#!/usr/bin/env python3
# teb_zone_switcher.py

import rospy
import dynamic_reconfigure.client
from std_msgs.msg import Int32, String

class TebZoneSwitcher:
    def __init__(self):
        rospy.init_node('teb_zone_switcher')

        # ── 충전기 구간 waypoint 인덱스 범위 (rosparam으로 관리) ──
        # 예: 경로 파일의 0~5번 waypoint가 충전기 진출입 구간
        self.charger_waypoint_ranges = rospy.get_param('~charger_waypoint_ranges', [
            {'start': 0, 'end': 5},    # 예: 충전기 출발 구간
            {'start': 42, 'end': 47},  # 예: 충전기 귀환 구간
        ])

        self.current_waypoint = -1
        self.in_strict_mode = False
        self.manual_override = False  # 수동 제어 여부
        self.current_path_name = ""

        # dynamic_reconfigure client
        try:
            self.teb_client = dynamic_reconfigure.client.Client(
                '/move_base/TebLocalPlannerROS', timeout=10.0)
            rospy.loginfo("TEB dynamic_reconfigure client connected")
        except Exception as e:
            rospy.logerr(f"TEB client connection failed: {e}")
            return

        # ── Strict 파라미터 (현재 값 기준으로 조정) ──
        self.strict_params = {
            # viapoint 활성화 → global plan 밀착 핵심
            'global_plan_viapoint_sep': 0.15,   # 현재 -0.1(비활성) → 0.15m마다 viapoint
            'weight_viapoint': 30.0,             # 현재 1.0 → 강하게 추종
            'via_points_ordered': True,          # 순서 보장

            # lookahead 축소 → 멀리 보지 않고 경로에 집중
            'max_global_plan_lookahead_dist': 0.8,  # 현재 3.0

            # 속도 제한
            'max_vel_x': 0.12,                  # 현재 0.3 → 카페트 구간 저속
            'max_vel_x_backwards': 0.05,
            'max_vel_theta': 0.2,               # 현재 0.4

            # 카페트 오인식 장애물 영향 최소화
            'weight_obstacle': 2.0,             # 현재 5.0 → 더 낮춤
            'min_obstacle_dist': 0.15,          # 현재 0.3 → 좁은 공간 대응
            'inflation_dist': 0.15,             # 현재 0.3

            # 경로 이탈 방지
            'weight_kinematics_forward_drive': 10.0,  # 현재 5.0
        }

        # ── Normal 파라미터 (현재 rosparam 값으로 복귀) ──
        self.normal_params = {
            'global_plan_viapoint_sep': 2.0,   # 비활성화 복귀
            'weight_viapoint': 1.0,
            'via_points_ordered': False,

            'max_global_plan_lookahead_dist': 3.0,

            'max_vel_x': 0.3,
            'max_vel_x_backwards': 0.1,
            'max_vel_theta': 0.2,

            'weight_obstacle': 5.0,
            'min_obstacle_dist': 0.3,
            'inflation_dist': 0.4,

            'weight_kinematics_forward_drive': 5.0,
        }

        # 현재 경로 파일명 수신 (선택적 - 경로별 다른 범위 설정 시 활용)
        rospy.Subscriber('/path_run_request', String, self.path_request_callback)

        # 현재 waypoint 인덱스 구독
        rospy.Subscriber('/current_waypoint_from_fw', Int32, self.waypoint_callback)

        rospy.loginfo("TEB Zone Switcher ready")
        rospy.loginfo(f"Charger ranges: {self.charger_waypoint_ranges}")

        rospy.Subscriber('/teb_mode_control', String, self.manual_control_callback)

        rospy.loginfo("TEB Zone Switcher ready. Use /teb_mode_control (STRICT, NORMAL, AUTO)")

    def manual_control_callback(self, msg):
        """사용자가 토픽으로 직접 모드를 변경할 때 호출"""
        cmd = msg.data.upper()
        
        if cmd == "STRICT":
            rospy.loginfo("Manual Override: FORCE STRICT MODE")
            self.manual_override = True
            self._apply_params(self.strict_params)
            self.in_strict_mode = True
        elif cmd == "NORMAL":
            rospy.loginfo("Manual Override: FORCE NORMAL MODE")
            self.manual_override = True
            self._apply_params(self.normal_params)
            self.in_strict_mode = False
        elif cmd == "AUTO":
            rospy.loginfo("Manual Override: DISABLED (Switching to AUTO)")
            self.manual_override = False
            # 즉시 현재 waypoint에 맞는 모드로 업데이트하기 위해 waypoint_callback 유도 가능
            self.current_waypoint = -2 # 강제 업데이트 트리거

    def path_request_callback(self, msg):
        """새로운 경로 요청이 오면 수동 제어를 해제하고 자동 모드로 복귀"""
        self.current_path_name = msg.data[4:]
        # ── 핵심 수정 부분: 상태 초기화 ──
        self.manual_override = False
        self.current_waypoint = -1   # Waypoint 비교 로직이 무조건 작동하도록 리셋
        self.in_strict_mode = False  # 모드 상태 초기화
        rospy.loginfo(f"New Path: {self.current_path_name} -> Mode reset to AUTO")

    def is_charger_waypoint(self, waypoint_idx):
        for r in self.charger_waypoint_ranges:
            if r['start'] <= waypoint_idx <= r['end']:
                return True
        return False

    def waypoint_callback(self, msg):
        # 수동 제어 중이면 Waypoint 로직을 타지 않음
        if self.manual_override:
            return

        waypoint_idx = msg.data
        if waypoint_idx < 0:
            if self.in_strict_mode:
                self._apply_params(self.normal_params)
                self.in_strict_mode = False
            return

        if waypoint_idx == self.current_waypoint:
            return
        self.current_waypoint = waypoint_idx

        should_be_strict = False
        for r in self.charger_waypoint_ranges:
            if r['start'] <= waypoint_idx <= r['end']:
                should_be_strict = True
                break

        if should_be_strict and not self.in_strict_mode:
            rospy.loginfo(f"Waypoint {waypoint_idx}: AUTO -> STRICT")
            self._apply_params(self.strict_params)
            self.in_strict_mode = True
        elif not should_be_strict and self.in_strict_mode:
            rospy.loginfo(f"Waypoint {waypoint_idx}: AUTO -> NORMAL")
            self._apply_params(self.normal_params)
            self.in_strict_mode = False

    def _apply_params(self, params):
            """파라미터를 적용하고 서버에서 반환된 실제 값을 로그로 출력합니다."""
            try:
                # update_configuration은 변경이 완료된 후의 '실제 전체 설정값'을 반환합니다.
                new_config = self.teb_client.update_configuration(params)
                
                # 우리가 변경을 시도한 값들만 필터링해서 로그 생성
                applied_values = {k: new_config[k] for k in params.keys() if k in new_config}
                
                rospy.loginfo("── 파라미터 적용 성공 ──")
                for key, val in applied_values.items():
                    rospy.loginfo(f"  [확인] {key}: {val}")
                rospy.loginfo("────────────────────────")
                
            except Exception as e:
                rospy.logwarn(f"파라미터 적용 실패: {e}")


if __name__ == '__main__':
    node = TebZoneSwitcher()
    rospy.spin()