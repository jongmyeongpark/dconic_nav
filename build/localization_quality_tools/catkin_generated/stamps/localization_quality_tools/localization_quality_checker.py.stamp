#!/usr/bin/env python
# -*- coding: utf-8 -*-
import rospy
import tf
import numpy as np
import math
import datetime
from nav_msgs.msg import OccupancyGrid
from geometry_msgs.msg import PoseWithCovarianceStamped
from sensor_msgs.msg import LaserScan
from std_msgs.msg import String, Int32

class FastFullScanWindowEvaluator:
    def __init__(self):
        rospy.init_node("localization_quality_checker")

        # --- Parameters (조정 가능) ---
        self.window_size         = rospy.get_param("~window_size", 15)
        self.step_size           = rospy.get_param("~step_size", 30)
        self.min_good_win        = rospy.get_param("~min_good_win", 2)
        # 히스토그램 비교 임계치 (히스테리시스: GOOD 문턱 > BAD 문턱)
        self.bc_threshold_good   = rospy.get_param("~bc_threshold_good", 0.52)
        self.bc_threshold_bad    = rospy.get_param("~bc_threshold_bad", 0.30)
        self.hist_bins           = rospy.get_param("~hist_bins", 15)
        self.max_range_clip      = rospy.get_param("~max_range_clip", 8.0)
        self.beam_stride         = rospy.get_param("~beam_stride", 5)   # 너무 크면 정밀도 하락
        # 윈도우 유효성: 최소 관측/기대 샘플 수
        self.min_obs_per_window  = rospy.get_param("~min_obs_per_window", 6)
        self.min_exp_per_window  = rospy.get_param("~min_exp_per_window", 3)
        # EMA / persistence
        self.ema_alpha           = rospy.get_param("~ema_alpha", 0.3)  # EMA 융합 계수
        self.bad_persist_time    = rospy.get_param("~bad_persist_time", 6.0)  # 초
        # 디버깅/로깅
        self.log_file            = rospy.get_param("~log_file",
                                                   "/tmp/localization_eval_{}.log".format(
                                                       datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")))

        # 상태 변수
        self.last_good_pose = None
        self.last_status = "UNCERTAIN"
        self.waiting_recovery = False
        self.bc_ema = None
        self.bad_start_time = None

        # 파일 헤더
        with open(self.log_file, "w") as f:
            f.write("time,bc_mean,bc_ema,num_good_windows,num_valid_windows,status\n")

        # Subscribers / Publishers
        rospy.Subscriber("/map", OccupancyGrid, self.map_cb, queue_size=1)
        rospy.Subscriber("/amcl_pose", PoseWithCovarianceStamped, self.pose_cb, queue_size=1)
        rospy.Subscriber("/scan_multi", LaserScan, self.scan_cb, queue_size=1)

        self.status_pub   = rospy.Publisher("~status", String, queue_size=10)
        self.move_pub     = rospy.Publisher("/move_request", Int32, queue_size=10)
        self.initpose_pub = rospy.Publisher("/initialpose", PoseWithCovarianceStamped, queue_size=1)

        # 데이터
        self.map = None
        self.pose = None
        self.scan = None
        self.exp_ranges = None
        self.obs_ranges = None

        # 평가 주기: 3초 (요청대로)
        rospy.Timer(rospy.Duration(3.0), self.evaluate)
        rospy.loginfo("[localization_quality_checker] started (3s cadence). params: beam_stride=%d, window=%d, step=%d",
                      self.beam_stride, self.window_size, self.step_size)
        rospy.spin()

    # ---------- callbacks ----------
    def map_cb(self, msg):
        self.map = msg

    def pose_cb(self, msg):
        # PoseWithCovarianceStamped
        self.pose = msg.pose.pose
        # GOOD 상태일 때만 저장 (최근 안정 pose)
        if self.last_status == "GOOD":
            self.last_good_pose = msg

    def scan_cb(self, msg):
        """Scan 수신시: 관측/예상 거리 벡터를 캐시(다운샘플링 포함).
           exp_ranges 계산은 한 번만(현재 pose 기준).
        """
        self.scan = msg
        if self.map is None or self.pose is None:
            return

        x = self.pose.position.x
        y = self.pose.position.y
        _, _, yaw = tf.transformations.euler_from_quaternion(
            [self.pose.orientation.x, self.pose.orientation.y,
             self.pose.orientation.z, self.pose.orientation.w]
        )

        r_max = min(self.max_range_clip, msg.range_max)
        indices = np.arange(0, len(msg.ranges), self.beam_stride)
        obs = []
        exp = []
        # 빔별로 최대거리인 경우(무응답) 는 히스토그램 계산에서 제외하기 위해 따로 처리
        for i in indices:
            r = msg.ranges[i]
            angle = msg.angle_min + i * msg.angle_increment
            if np.isfinite(r) and r > 0 and r < r_max:
                obs.append(r)
            else:
                # 마크: 이 관측은 'far'로 간주 (히스토그램에서는 제외)
                obs.append(None)
            d = self.raycast_expected(x, y, yaw, angle, r_max)
            # expected 가 max_range면(맵에 장애물 없음) None 처리
            if d is None or d >= r_max:
                exp.append(None)
            else:
                exp.append(d)

        # 캐시: 두 리스트(원소들이 None 혹은 float)
        self.obs_ranges = obs
        self.exp_ranges = exp

        # 첫 scan 즉시 평가(지연 없이 무조건 한번 결과 확인)
        self.evaluate(None)

    # ---------- 도우미 ----------
    def world_to_map_index(self, x, y):
        if self.map is None:
            return None
        info = self.map.info
        mx = int((x - info.origin.position.x) / info.resolution)
        my = int((y - info.origin.position.y) / info.resolution)
        if 0 <= mx < info.width and 0 <= my < info.height:
            return mx, my
        return None

    def raycast_expected(self, x, y, yaw, angle, max_range):
        """Bresenham 기반 raycast: 장애물셀 발견 시 거리 반환, 없으면 None (max_range로 처리)"""
        if self.map is None:
            return None
        info = self.map.info
        res = info.resolution
        width, height = info.width, info.height
        grid = np.array(self.map.data, dtype=np.int16).reshape((height, width))

        end_x = x + math.cos(yaw + angle) * max_range
        end_y = y + math.sin(yaw + angle) * max_range
        start = self.world_to_map_index(x, y)
        end = self.world_to_map_index(end_x, end_y)
        if start is None or end is None:
            return None

        x0, y0 = start
        x1, y1 = end
        dx = abs(x1 - x0)
        dy = abs(y1 - y0)
        sx = 1 if x0 < x1 else -1
        sy = 1 if y0 < y1 else -1
        err = dx - dy
        px, py = x0, y0
        steps = 0
        while True:
            if grid[py, px] > 50:
                # 장애물 셀을 찾음 => 거리 반환
                return steps * res
            if px == x1 and py == y1:
                break
            e2 = 2 * err
            if e2 > -dy:
                err -= dy
                px += sx
            if e2 < dx:
                err += dx
                py += sy
            steps += 1
            # 안전 차단: 너무 멀면 None 처리
            if steps * res >= max_range:
                break
        return None

    def make_hist(self, samples, bins, max_range):
        """None 또는 빈 샘플들 제외: 히스토그램(density) 반환"""
        filtered = [s for s in samples if (s is not None)]
        if len(filtered) == 0:
            # uniform으로 대체하되 호출부에서 '유효성 검사'가 필요
            h = np.ones(bins, dtype=np.float32) / float(bins)
            return h, 0
        clipped = np.clip(np.array(filtered, dtype=np.float32), 0.0, max_range)
        hist, _ = np.histogram(clipped, bins=bins, range=(0.0, max_range), density=True)
        hist = hist.astype(np.float32) + 1e-6
        hist = hist / np.sum(hist)
        return hist, len(filtered)

    def bhattacharyya_coeff(self, p, q):
        return float(np.sum(np.sqrt(p * q)))

    # ---------- 주요 평가 루틴 ----------
    def evaluate(self, _event):
        # 데이터 존재 체크
        if self.obs_ranges is None or self.exp_ranges is None:
            rospy.logdebug("No scan cache yet")
            return

        N = len(self.obs_ranges)
        if N < self.window_size:
            rospy.logwarn_throttle(5.0, "Too few beams after subsampling: %d", N)
            return

        num_good_windows = 0
        bc_list = []
        valid_window_count = 0

        # 윈도우 순회
        for start in range(0, N - self.window_size + 1, self.step_size):
            obs_win = self.obs_ranges[start:start + self.window_size]
            exp_win = self.exp_ranges[start:start + self.window_size]

            # 유효 샘플 수 확인 (None 제외)
            obs_count = sum(1 for v in obs_win if v is not None)
            exp_count = sum(1 for v in exp_win if v is not None)

            if obs_count < self.min_obs_per_window or exp_count < self.min_exp_per_window:
                # 이 윈도우는 비교하기에 샘플 부족 → 무시
                continue

            # 히스토그램 및 BC 계산
            p, pcount = self.make_hist(exp_win, self.hist_bins, self.max_range_clip)
            q, qcount = self.make_hist(obs_win, self.hist_bins, self.max_range_clip)
            bc = self.bhattacharyya_coeff(p, q)

            bc_list.append(bc)
            valid_window_count += 1

            # 윈도우 레벨의 GOOD 판정 (즉시집계)
            if bc >= self.bc_threshold_good:
                num_good_windows += 1
                if num_good_windows >= self.min_good_win:
                    # early stop: 이미 충분한 좋은 윈도우 발견
                    break

        # 비어있으면 판정 불가
        if valid_window_count == 0:
            rospy.logwarn_throttle(5.0, "No valid windows (insufficient samples) for BC computation")
            # 상태를 급하게 BAD로 바꾸지 않고 UNCERTAIN 유지
            status_candidate = "UNCERTAIN"
            bc_mean = 0.0
        else:
            bc_mean = float(np.mean(bc_list)) if bc_list else 0.0
            # EMA 업데이트
            if self.bc_ema is None:
                self.bc_ema = bc_mean
            else:
                self.bc_ema = self.ema_alpha * bc_mean + (1.0 - self.ema_alpha) * self.bc_ema

            # 상태 후보 결정 (EMA 기반 히스토리 포함)
            if self.bc_ema >= self.bc_threshold_good:
                status_candidate = "GOOD"
            elif self.bc_ema < self.bc_threshold_bad:
                status_candidate = "BAD"
            else:
                status_candidate = "UNCERTAIN"

        # --- persistence: BAD 동작(정지/재초기화)은 일정 시간 지속될 때만 수행 ---
        now = rospy.get_time()
        take_recovery_action = False

        if status_candidate == "BAD":
            if self.last_status != "BAD":
                # BAD 시작 시각 기록
                self.bad_start_time = now
                rospy.loginfo("BAD candidate detected, starting persistence timer")
            else:
                # 이미 BAD 상태였으면 시간 체크
                if self.bad_start_time is not None and (now - self.bad_start_time) >= self.bad_persist_time:
                    # 충분히 지속 → 실제 recovery action 트리거
                    take_recovery_action = True
        else:
            # BAD가 아니면 reset bad timer
            self.bad_start_time = None

        # 상태 전이 및 행동
        status_out = self.last_status  # default retain

        if status_candidate == "GOOD":
            status_out = "GOOD"
            # 회복 대기 중이면 복구 액션(한번만)
            if self.waiting_recovery:
                rospy.loginfo("Localization recovered (bc_ema=%.3f). Sending move_request=2", self.bc_ema)
                self.move_pub.publish(Int32(2))
                self.waiting_recovery = False

        elif take_recovery_action:
            # BAD persists enough -> if 이전에 GOOD, then stop+reinit
            if self.last_status == "GOOD" and self.last_good_pose is not None:
                rospy.logwarn("Localization persistently BAD. Stopping and publishing initialpose to reinit.")
                self.move_pub.publish(Int32(1))  # 정지
                rospy.sleep(0.5)
                self.initpose_pub.publish(self.last_good_pose)
                self.waiting_recovery = True
            status_out = "BAD"

        else:
            # UNCERTAIN path or BAD but not yet persistent
            status_out = "UNCERTAIN" if status_candidate != "GOOD" else "GOOD"

        # 저장/출력
        self.last_status = status_out
        # publish status properly wrapped
        self.status_pub.publish(String(data=status_out))

        rospy.loginfo("bc_mean=%.3f bc_ema=%.3f valid_windows=%d good_windows=%d -> %s",
                      bc_mean, self.bc_ema if self.bc_ema is not None else 0.0,
                      valid_window_count, num_good_windows, status_out)

        # 상세 로그(분석용)
        with open(self.log_file, "a") as f:
            f.write("{:.3f},{:.4f},{:.4f},{:d},{:d},{}\n".format(
                now, bc_mean, self.bc_ema if self.bc_ema is not None else 0.0,
                num_good_windows, valid_window_count, status_out
            ))

if __name__ == "__main__":
    FastFullScanWindowEvaluator()