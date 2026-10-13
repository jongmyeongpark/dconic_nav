#!/usr/bin/env python3


import rospy
import json
import time
import math
import os
import csv
import paho.mqtt.client as mqtt
import tf # 쿼터니언 변환용
from nav_msgs.msg import Odometry, OccupancyGrid   # 추가 : OccupancyGrid
from sensor_msgs.msg import BatteryState, LaserScan, Imu, Range   # 수정 : Range (초음파) 추가
from std_msgs.msg import String, Bool, Empty, Int32, Float32   # 이사님추가 : Float32 (배터리 개별 토픽용)
from geometry_msgs.msg import Twist, PoseWithCovarianceStamped
from actionlib_msgs.msg import GoalStatusArray   # 이사님추가 : /move_base/status 용
# 추가 : hdl_localization 스캔 매칭 상태 (localizationScore 용). 패키지 import 실패 시에도 브리지는 계속 동작
try:
    from hdl_localization.msg import ScanMatchingStatus
except ImportError:
    ScanMatchingStatus = None
# 수정 : md_node 의 /monitor_topic (모터 전압/전류/알람). 패키지 import 실패 시에도 브리지는 계속 동작
try:
    from md.msg import monitor_msg as MonitorMsg   # 수정
except ImportError:
    MonitorMsg = None   # 수정
 
FCODE = "INTE-PLA-00000-0X0000-00000"
BROKER_ADDRESS = "127.0.0.1" # 로봇 로컬 브로커
BROKER_PORT = 1883
MAC_ADDRESS = "00:1A:2B:3C:4D:5E" # 하드웨어 고유 MAC
SENSOR_TIMEOUT_SEC = 2.0   # 수정 : 마지막 수신 후 이 시간(초) 이내면 센서 Alive
MOTOR_VOLT_SCALE = 0.1   # 수정 : monitor_msg.sVoltIn → V (실측 237 → 23.7V)
MOTOR_CUR_SCALE = 0.1    # 수정 : monitor_msg.sLeftMotCur / sRightMotCur → A (MD 매뉴얼 0.1A 단위, 주행 중 실측 검증 필요)
 
class PlatyMqttBridge:
    def __init__(self):
        rospy.init_node('platy_mqtt_bridge', anonymous=True)
 
        # --- 내부 상태값 저장용 딕셔너리 ---
        self.robot_state = {
            "x": 0.0, "y": 0.0, "angle": 0.0, 
            "linear_vel": 0.0, "angular_vel": 0.0, # 각속도 추가
            "battery_soc": 0.0, "battery_vol": 0.0, "battery_cur": 0.0, "is_charging": False,
            "battery_soh": 100.0, "battery_temp": 25.0, # 신규 배터리 상태 추가
            "is_dock_connected": False,   # 이사님추가 : /isDockConnected 수신 전 기본값
            "front_laser_active": False, "imu_active": False,
            "driving_state": "Idle",   # 이사님추가 : driving.state용 (콜백들이 이 키에 기록)
            "drive_mode": "Auto",      # 이사님추가 : driving.driveMode용
            "emergencyStop": False,    # 이사님추가 : /motor_em_topic 수신 전 기본값
            "is_auto_driving": False,
            "bumper_status": False, # 범퍼 상태 추가
            "docking_state": "IDLE", # 도킹 상태 추적 (IDLE, DOCKING, SUCCESS, FAILED)
            "localization_score": 100.0, # AMCL 매칭 신뢰도 추가
            # 추가된 코드
            "driving_state_code": -1,   # /driving_state 원본 숫자 (-1 = 아직 못 받음)
            "map_name": "",   # 추가 : /map_running 수신 전 빈 문자열
            "map_metadata": None,   # 추가 : /map 수신 전 None
            "current_waypoint_index": -1,   # 추가 : /current_waypoint_from_fw 수신 전 기본값
            "total_waypoint_count": 0,      # 추가 : /last_waypoint_index 수신 전 기본값
            "route_repetition": 0,          # 추가 : /current_route_repetition_from_fw 수신 전 기본값
            "target_route_repetition": 0,   # 추가 : /goal_route_repetition 수신 전 기본값
            "distance_tolerance": 0.5       # 추가 : /distance_tolerance 수신 전 기본값 (기존 하드코딩 값)
        }
 
        # 수정 : 센서별 마지막 수신 시각 (0.0 = 아직 수신 없음)
        self.sensor_last_seen = {   # 수정
            "frontLaser": 0.0, "rearLaser": 0.0, "imu": 0.0,
            "motorDriver": 0.0, "usbCam": 0.0, "sonar": 0.0,
            "motorMonitor": 0.0   # 수정 : /monitor_topic 수신 시각
        }
        # 수정 : state.motor 값 (monitor_callback 이 갱신)
        self.motor_state = {   # 수정
            "voltage": 0.0, "cur_left": 0.0, "cur_right": 0.0,
            "alarm_left": [], "alarm_right": []
        }
        # (검증용, 확인 완료 후 주석 처리) 주행 중 전류 raw 최대값 기록
        # self.motor_dbg = {"max_cur_left": 0, "max_cur_right": 0}
        # (검증용, 확인 완료 후 주석 처리) 알람 비트 → 문자열 변환 자가 점검 (확인된 출력: [] ['OverTemp'] ['OverVolt', 'OverLoad', 'Stall'])
        # rospy.loginfo(f"[motor] decode 자가점검: 0→{self.decode_motor_status(0)}, 8→{self.decode_motor_status(8)}, 0x94→{self.decode_motor_status(0x94)}")

        # --- ROS Subscriber 등록 ---
        rospy.Subscriber("/odom", Odometry, self.odom_callback)
        rospy.Subscriber("/amcl_pose", PoseWithCovarianceStamped, self.amcl_pose_callback)
        # 이사님추가 : /battery_state 통합 토픽은 아래 개별 토픽 방식으로 대체되어 주석 처리
        #             (둘 다 켜두면 같은 battery_* 키를 서로 덮어씀)
        # rospy.Subscriber("/battery_state", BatteryState, self.battery_callback)
        # rospy.Subscriber("/scan", LaserScan, self.laser_callback)   # /scan 토픽이 로봇에 없어 주석 처리
        # 수정 : 실제 레이저 토픽(ltme_node1/2) 구독. frame_id 기준 /scan_1=front_laser, /scan_2=rear_laser
        rospy.Subscriber("/scan_1", LaserScan, self.front_laser_callback)   # 수정
        rospy.Subscriber("/scan_2", LaserScan, self.rear_laser_callback)   # 수정
        rospy.Subscriber("/imu", Imu, self.imu_callback)
        # 수정 : sonar / usbCam 수신 여부 판정용 (이미지는 AnyMsg 로 받아 본문 해석 생략)
        for sonar_topic in ["/sonar1", "/sonar2", "/sonar3", "/sonar4"]:   # 수정
            rospy.Subscriber(sonar_topic, Range, self.sonar_callback)   # 수정
        rospy.Subscriber("/camera1/usb_cam1/image_raw", rospy.AnyMsg, self.usb_cam_callback)   # 수정
        # 수정 : 모터 드라이버 전압/전류/알람 (md_node 발행). md 패키지 import 실패 시에도 브리지는 계속 동작
        if MonitorMsg is not None:   # 수정
            rospy.Subscriber("/monitor_topic", MonitorMsg, self.monitor_callback)   # 수정
        else:
            rospy.logwarn("md.msg import 실패 → state.motor 미연동")   # 수정
        # TODO: 범퍼 센서 토픽 구독 추가 필요 시 여기에 작성
        # 추가된 코드 
        rospy.Subscriber("/driving_state", Int32, self.driving_state_callback)
        rospy.Subscriber("/motor_em_topic", Int32, self.motor_em_topic_callback)   # ← 추가
        rospy.Subscriber("/move_base/status", GoalStatusArray, self.move_base_status_callback)   # 이사님추가
        rospy.Subscriber("/map_running", String, self.map_running_callback)   # 추가
        rospy.Subscriber("/map", OccupancyGrid, self.map_callback, queue_size=1)   # 추가 : 맵 데이터가 커서 queue 1개만
        rospy.Subscriber("/current_waypoint_from_fw", Int32, self.current_waypoint_callback)   # 추가
        rospy.Subscriber("/last_waypoint_index", Int32, self.last_waypoint_index_callback)   # 추가 : totalWaypointCount 용
        rospy.Subscriber("/current_route_repetition_from_fw", Int32, self.route_repetition_callback)   # 추가 : routeRepetition 용
        rospy.Subscriber("/goal_route_repetition", Int32, self.target_route_repetition_callback)   # 추가 : targetRouteRepetition 용
        rospy.Subscriber("/distance_tolerance", Float32, self.distance_tolerance_callback)   # 추가 : distanceTolerance 용
        # 추가 : localizationScore 는 hdl_localization /status 의 inlier_fraction 기준
        if ScanMatchingStatus is not None:
            rospy.Subscriber("/status", ScanMatchingStatus, self.scan_matching_status_callback)
        else:
            rospy.logwarn("hdl_localization.msg import 실패 → localizationScore 미연동")

        # 이사님추가 : 배터리 개별 토픽 구독
        rospy.Subscriber("/batterySoc", Float32, self.soc_callback)
        rospy.Subscriber("/batteryCur", Float32, self.cur_callback)
        rospy.Subscriber("/batteryVol", Float32, self.vol_callback)
        rospy.Subscriber("/batterySoh", Float32, self.soh_callback)
        rospy.Subscriber("/batteryTemperature", Float32, self.temp_callback)
        rospy.Subscriber("/isCharging", Bool, self.is_charging_callback)
        rospy.Subscriber("/isDockConnected", Bool, self.is_dock_connected_callback)

        # --- ROS Publisher 추가 (명령 전달용) ---
        self.sys_cmd_pub = rospy.Publisher("/robot_system_command", String, queue_size=10)
        self.cmd_vel_pub = rospy.Publisher("/cmd_vel", Twist, queue_size=10)
        self.clear_err_pub = rospy.Publisher("/clear_error", Bool, queue_size=10)
        self.path_run_pub = rospy.Publisher("/path_run_request", String, queue_size=10)
        self.shortest_guide_pub = rospy.Publisher("/request_shortest_guide", String, queue_size=10)
        self.path_cancel_pub = rospy.Publisher("/path_run_cancel_request", Empty, queue_size=10)
        self.move_req_pub = rospy.Publisher("/move_request", Int32, queue_size=10)
        self.max_vel_pub = rospy.Publisher("/max_velocity_override", Twist, queue_size=10) # 속도 제한 설정용
        # MQTT 클라이언트 설정
        self.client = mqtt.Client()
        self.client.on_connect = self.on_connect
        self.client.on_message = self.on_message
        self.client.connect(BROKER_ADDRESS, BROKER_PORT, 60)
        self.client.loop_start()
 
        # 1Hz 주기로 상태 발행하는 타이머
        rospy.Timer(rospy.Duration(1.0), self.publish_state)
 
    # ----------------------------------------------------
    # ROS 콜백 함수들 (로봇 상태 업데이트)
    # ----------------------------------------------------
    # odom 
    def odom_callback(self, msg):
        self.robot_state["linear_vel"] = round(msg.twist.twist.linear.x, 3)
        self.robot_state["angular_vel"] = round(math.degrees(msg.twist.twist.angular.z), 2) # 각속도 추가 (deg/s 변환)

 
    def amcl_pose_callback(self, msg):
        self.robot_state["x"] = round(msg.pose.pose.position.x, 3)
        self.robot_state["y"] = round(msg.pose.pose.position.y, 3)
        q = msg.pose.pose.orientation
        quaternion_list = [q.x, q.y, q.z, q.w]
        _, _, yaw = tf.transformations.euler_from_quaternion(quaternion_list)
        self.robot_state["angle"] = round(math.degrees(yaw), 2)
        # 수정 : /amcl_pose 는 tf_to_amcl_pose 가 발행하며 공분산이 0.25 고정 → 신뢰도로 쓸 수 없어 주석 처리
        #        localizationScore 는 scan_matching_status_callback (/status) 에서 갱신
        # cov_x = msg.pose.covariance[0]
        # cov_y = msg.pose.covariance[7]
        # score = max(0.0, 100.0 - (cov_x + cov_y) * 1000) # 예시 수식
        # self.robot_state["localization_score"] = round(min(100.0, score), 1)

    # 이사님추가 : 기존 DRIVING_STATE_MAP 방식은 /move_base/status 방식으로 대체되어 주석 처리
    # DRIVING_STATE_MAP = {
    #     0: ("Idle",    False),  # 주행 취소/완료 (map_info.cpp 244,344,379,463)
    #     1: ("Pause",   True),   # 일시정지 (373, 1415)
    #     2: ("Driving", True),   # 주행 시작 (351) + 실측 확인
    # }
    #
    # def driving_state_callback(self, msg):
    #     code = msg.data
    #     self.robot_state["driving_state_code"] = code
    #     state_str, running = self.DRIVING_STATE_MAP.get(code, ("Idle", False))
    #     self.robot_state["driving_state_str"] = state_str
    #     self.robot_state["is_auto_driving"] = running
    #     rospy.loginfo(f"[driving_state] 코드 {code} 수신 → {state_str}")

    # 이사님추가 : /move_base/status → driving.state (Driving/Stop/Idle/Error)
    def move_base_status_callback(self, msg):
        # 상태 리스트가 비어있으면 무시하거나 Idle 처리
        if not msg.status_list:
            return

        # 가장 최근(마지막) 들어온 목표의 상태값을 확인
        latest_status = msg.status_list[-1].status
        current_state = self.robot_state.get("driving_state", "Idle")

        # 비상정지(Emergency)나 수동 일시정지(Pause) 상태일 때는 move_base 상태보다 우선순위가 높게 처리
        if current_state in ["Emergency", "Pause"]:
            # 단, 일시정지 중인데 목표가 아예 취소(2)되거나 에러(4)가 나면 상태를 업데이트
            if latest_status in [2, 3, 4]:
                self.robot_state["driving_state"] = "Idle"
            return

        # actionlib_msgs/GoalStatus 상태 코드 매핑
        if latest_status in [0, 1]:
            # 0: PENDING (목표 대기중), 1: ACTIVE (주행 중)
            self.robot_state["driving_state"] = "Driving"
        elif latest_status == 2:
            # 2: PREEMPTED (명령 취소됨 -> 정지)
            self.robot_state["driving_state"] = "Stop"
        elif latest_status == 3:
            # 3: SUCCEEDED (목표 도착 완료)
            self.robot_state["driving_state"] = "Idle"
        elif latest_status == 4:
            # 4: ABORTED (경로 생성 실패, 로봇 갇힘 등 에러)
            self.robot_state["driving_state"] = "Error"

    # 이사님추가 : waypoint 패키지에서 1이 오면 Pause (0/2는 /move_base/status가 담당)
    def driving_state_callback(self, msg):
        """경로 waypoint 관리 패키지에서 올라오는 상태값 처리"""
        self.robot_state["driving_state_code"] = msg.data

        # 추가 : isPathRunning 은 FW /driving_state 코드 기준으로 갱신 (명령 핸들러 값은 FW 응답 전 임시값)
        #   0 = 주행 취소/완료 → False
        #   1 = 일시정지       → True  (경로 프로세스는 살아있음)
        #   2 = 주행 중        → True
        if msg.data == 0:
            self.robot_state["is_auto_driving"] = False
            self.robot_state["total_waypoint_count"] = 0   # 추가 : 경로 종료 시 개수 초기화 (/last_waypoint_index 는 경로 로드 때만 발행)
            self.robot_state["target_route_repetition"] = 0   # 추가 : 경로 종료 시 목표 반복 횟수 초기화 (/goal_route_repetition 도 경로 로드 때만 발행)
        elif msg.data in (1, 2):
            self.robot_state["is_auto_driving"] = True

        # msg.data 값이 1일 때 Pause로 변경
        if msg.data == 1:
            self.robot_state["driving_state"] = "Pause"
            rospy.loginfo("waypoint 패키지 알림: 주행 상태가 Pause(1)로 변경되었습니다.")

    def motor_em_topic_callback(self, msg):
        self.touch_sensor("motorDriver")   # 수정 : md_node 가 15Hz 로 발행 → motorDriver Alive 판정에 사용
        if msg.data == 1:                                  # msg → msg.data 수정 (이사님 원본 msg==1 은 항상 거짓이라 보정)
            self.robot_state["emergencyStop"] = False      # 1 = 정상
            # print("motor_em_topic: 정상 상태 수신")
            # print(f"driving_state: {self.robot_state.get('driving_state', 'Unknown')}, is_auto_driving: {self.robot_state.get('is_auto_driving', False)}")
            # print(f"motor_monitor: voltage: {self.motor_state.get('voltage', 0.0)}V, current: {self.motor_state.get('cur_left', 0.0)}A/{self.motor_state.get('cur_right', 0.0)}A")
        else:
            self.robot_state["emergencyStop"] = True       # 그 외 = 비상정지


    # 이사님추가 : /battery_state 통합 콜백은 개별 토픽 콜백으로 대체되어 주석 처리
    # def battery_callback(self, msg):
    #     self.robot_state["battery_soc"] = msg.percentage * 100.0 if msg.percentage <= 1.0 else msg.percentage
    #     self.robot_state["battery_vol"] = msg.voltage
    #     self.robot_state["battery_cur"] = msg.current
    #     self.robot_state["is_charging"] = (msg.power_supply_status == BatteryState.POWER_SUPPLY_STATUS_CHARGING)

    # 이사님추가 : 배터리 개별 토픽 콜백
    def soc_callback(self, msg):
        self.robot_state["battery_soc"] = msg.data

    def cur_callback(self, msg):
        self.robot_state["battery_cur"] = msg.data

    def vol_callback(self, msg):
        self.robot_state["battery_vol"] = msg.data

    def soh_callback(self, msg):
        self.robot_state["battery_soh"] = msg.data

    def temp_callback(self, msg):
        self.robot_state["battery_temp"] = msg.data

    def is_charging_callback(self, msg):
        self.robot_state["is_charging"] = msg.data

    def is_dock_connected_callback(self, msg):
        self.robot_state["is_dock_connected"] = msg.data

        # 추가
    def map_callback(self, msg):
        self.robot_state["map_metadata"] = {
            "resolution": round(float(msg.info.resolution), 4),   # 0.2 m/pixel
            "width": int(msg.info.width),                          # 1000 pixel
            "height": int(msg.info.height),                        # 1000 pixel
            "originX": float(msg.info.origin.position.x),          # -100.0 m
            "originY": float(msg.info.origin.position.y)           # -100.0 m
        }    
    
        # 추가
    def map_running_callback(self, msg):
        self.robot_state["map_name"] = msg.data.strip()

    # 추가 : 현재 향하는 웨이포인트 순번 (-1 = 경로 없음 / 단일 목표 주행)
    def current_waypoint_callback(self, msg):
        self.robot_state["current_waypoint_index"] = msg.data

    # 추가 : 마지막 순번 + 1 = 전체 웨이포인트 수 (경로 로드 때 1회만 발행됨)
    def last_waypoint_index_callback(self, msg):
        self.robot_state["total_waypoint_count"] = msg.data + 1

    # 추가 : 반복 주행 현재 회차 (FW 값 그대로)
    def route_repetition_callback(self, msg):
        self.robot_state["route_repetition"] = msg.data

    # 추가 : 명령으로 하달된 목표 반복 횟수 (경로 로드 때 1회 발행)
    def target_route_repetition_callback(self, msg):
        self.robot_state["target_route_repetition"] = msg.data

    # 추가 : hdl_localization 스캔 매칭 상태 → localizationScore (0~100)
    #   수렴 전(has_converged=False) 이면 0, 수렴 후에는 inlier_fraction(0~1) × 100
    def scan_matching_status_callback(self, msg):
        if not msg.has_converged:
            self.robot_state["localization_score"] = 0.0
        else:
            score = float(msg.inlier_fraction) * 100.0
            self.robot_state["localization_score"] = round(max(0.0, min(100.0, score)), 1)

    # 추가 : 웨이포인트 도달 인정 반경 (m)
    def distance_tolerance_callback(self, msg):
        self.robot_state["distance_tolerance"] = round(float(msg.data), 3)

    # def laser_callback(self, msg):
    #     self.robot_state["front_laser_active"] = True
    #
    # def imu_callback(self, msg):
    #     self.robot_state["imu_active"] = True

    # 수정 : 센서별 마지막 수신 시각 기록 (한 번 True 후 계속 유지되던 문제 해결)
    def touch_sensor(self, name):   # 수정
        self.sensor_last_seen[name] = time.time()

    # 수정 : 마지막 수신 후 SENSOR_TIMEOUT_SEC 이내면 Alive
    def is_sensor_alive(self, name):   # 수정
        last = self.sensor_last_seen.get(name, 0.0)
        return (time.time() - last) < SENSOR_TIMEOUT_SEC

    def front_laser_callback(self, msg):   # 수정 : /scan_1
        self.touch_sensor("frontLaser")

    def rear_laser_callback(self, msg):   # 수정 : /scan_2
        self.touch_sensor("rearLaser")

    def imu_callback(self, msg):   # 수정
        self.touch_sensor("imu")

    def sonar_callback(self, msg):   # 수정 : /sonar1~4 중 하나라도 수신되면 Alive
        self.touch_sensor("sonar")

    def usb_cam_callback(self, msg):   # 수정 : 이미지 본문은 해석하지 않고 수신 여부만 사용(AnyMsg)
        self.touch_sensor("usbCam")

    # 수정 : /monitor_topic (md/monitor_msg) → state.motor 4개 key
    def monitor_callback(self, msg):   # 수정
        self.touch_sensor("motorMonitor")
        self.motor_state["voltage"] = round(msg.sVoltIn * MOTOR_VOLT_SCALE, 1)   # 0.1V 단위 가정 (실측 237 → 23.7V)
        self.motor_state["cur_left"] = round(msg.sLeftMotCur * MOTOR_CUR_SCALE, 2)   # 0.1A 단위 가정 (주행 중 실측으로 검증 필요)
        self.motor_state["cur_right"] = round(msg.sRightMotCur * MOTOR_CUR_SCALE, 2)
        self.motor_state["alarm_left"] = self.decode_motor_status(msg.byLeftMotStatus)
        self.motor_state["alarm_right"] = self.decode_motor_status(msg.byRightMotStatus)
        # (검증용, 확인 완료 후 주석 처리) state.motor 4개 key 검증 로그
        # 정지 상태는 1초에 1회, 전류/알람이 0이 아니면 0.2초에 1회 출력. 다시 쓰려면 아래 주석(#)을 해제하고 __init__ 의 motor_dbg 도 해제
        # self.motor_dbg["max_cur_left"] = max(self.motor_dbg["max_cur_left"], abs(msg.sLeftMotCur))
        # self.motor_dbg["max_cur_right"] = max(self.motor_dbg["max_cur_right"], abs(msg.sRightMotCur))
        # motor_active = (msg.sLeftMotCur != 0 or msg.sRightMotCur != 0
        #                 or msg.byLeftMotStatus != 0 or msg.byRightMotStatus != 0)
        # motor_log = (
        #     f"[motor] V={self.motor_state['voltage']} (raw {msg.sVoltIn}) | "
        #     f"curL={self.motor_state['cur_left']}A (raw {msg.sLeftMotCur}, max {self.motor_dbg['max_cur_left']}) | "
        #     f"curR={self.motor_state['cur_right']}A (raw {msg.sRightMotCur}, max {self.motor_dbg['max_cur_right']}) | "
        #     f"alarmL={self.motor_state['alarm_left']} (raw {msg.byLeftMotStatus}) | "
        #     f"alarmR={self.motor_state['alarm_right']} (raw {msg.byRightMotStatus}) | "
        #     f"linVel={msg.sRealLinearVel}mm/s angVel={msg.sRealAngularVel} | "
        #     f"emergencyStop={self.robot_state.get('emergencyStop')}")
        # if motor_active:
        #     rospy.loginfo_throttle(0.2, motor_log)
        # else:
        #     rospy.loginfo_throttle(1.0, motor_log)

    # 수정 : 모터 상태 비트 → API 에러 문자열 (MD 매뉴얼 PID_MONITOR 상태 BIT)
    def decode_motor_status(self, status):   # 수정
        alarms = []
        if status & (1 << 2): alarms.append("OverVolt")
        if status & (1 << 3): alarms.append("OverTemp")
        if status & (1 << 4): alarms.append("OverLoad")
        if status & (1 << 7): alarms.append("Stall")
        return alarms
 
    # ----------------------------------------------------
    # MQTT 통신 및 명령 처리
    # ----------------------------------------------------
    def on_connect(self, client, userdata, flags, rc):
        rospy.loginfo(f"MQTT 브로커 연결 성공 (결과 코드: {rc}) # 코드수정")
        client.subscribe(f"/{FCODE}/request/#")
        client.subscribe("$SYS/broker/log/N/notice")
 
    def on_message(self, client, userdata, msg):
        topic = msg.topic
        payload = msg.payload.decode('utf-8')
        if topic.startswith("$SYS/broker/log/N/notice"):
            if "New client connected" in payload:
                client_ip = payload.split("from ")[-1].split(" as")[0] if "from " in payload else "Unknown IP"
                rospy.loginfo(f"🟢 [관제 앱 접속 감지] 앱이 연결되었습니다. (IP: {client_ip})")
            elif "Client" in payload and "disconnected" in payload:
                rospy.logwarn(f"🔴 [관제 앱 접속 해제] 앱 연결이 끊어졌습니다.")
            return
        try:
            req_data = json.loads(payload)
            command = topic.split('/')[-1]
            msg_id = req_data.get("msgId", "unknown")
            # --- ROS 로봇 제어 명령 처리 ---
            success, response_data = self.handle_robot_command(command, req_data)
            # 수신 즉시 성공 응답 발행 (결과 데이터가 있으면 함께 전송)
            self.publish_response(msg_id, command, success, response_data)
        except json.JSONDecodeError:
            rospy.logerr("JSON 파싱 에러")
 
    def handle_robot_command(self, command, req_data):
        """관제로부터 받은 명령을 분석하여 실제 ROS 명령을 내립니다."""
        try:
            # 1. 주행 관련 제어
            if command == "startDrive":
                waypoints = req_data.get("waypoints", [])
                rospy.loginfo(f"[startDrive] waypoints: {waypoints}")   # 수정
                file_name = "temp_path.csv"
                save_dir = "/home/nvidia/dconic_nav/src/follow_waypoints/saved_path/"
                if not os.path.exists(save_dir):
                    os.makedirs(save_dir)
                full_path = os.path.join(save_dir, file_name)
                # CSV 파일 작성 시 전달받은 angle(목표 헤딩)을 쿼터니언으로 변환하여 저장
                with open(full_path, mode='w', newline='') as f:
                    writer = csv.writer(f)
                    for wp in waypoints:
                        target_angle = wp.get('angle', None)
                        if target_angle is not None:
                            q = tf.transformations.quaternion_from_euler(0, 0, math.radians(target_angle))
                        else:
                            q = [0.0, 0.0, 0.0, 1.0] # 각도 지정 안된 경우 디폴트 쿼터니언
                        writer.writerow([wp.get('x', 0.0), wp.get('y', 0.0), 0.0, q[0], q[1], q[2], q[3]])
                rospy.loginfo(f"명령 수행: 주행 시작 (자동 언도킹 전환, 경로 파일 생성 완료: {full_path})")
                self.robot_state["docking_state"] = "IDLE" # 출발 시 도킹 해제
                self.path_run_pub.publish('0100'+file_name)
                self.robot_state["is_auto_driving"] = True
                return True, None
            elif command == "driveToDestination":
                target = req_data.get("target", {})
                rospy.loginfo(f"명령 수행: 단일 목적지 이동 {target}")
                self.robot_state["docking_state"] = "IDLE"
                self.shortest_guide_pub.publish(json.dumps(target))
                self.robot_state["is_auto_driving"] = True
                return True, None
 
            elif command == "cancelDrive":
                rospy.loginfo("명령 수행: 주행 명령 취소 (정지)")
                self.path_cancel_pub.publish(Empty())
                self.cmd_vel_pub.publish(Twist()) 
                self.robot_state["is_auto_driving"] = False
                return True, None
            elif command == "pauseDrive":
                rospy.loginfo("명령 수행: 주행 일시정지")
                self.move_req_pub.publish(Int32(1))
                self.cmd_vel_pub.publish(Twist()) 
                self.robot_state["is_auto_driving"] = False
                return True, None
            elif command == "resumeDrive":
                rospy.loginfo("명령 수행: 주행 재개")
                self.move_req_pub.publish(Int32(2))
                self.robot_state["is_auto_driving"] = True
                # 이사님추가 : 재개 시 Pause 해제 (이후 move_base status가 실제 상태로 갱신)
                if self.robot_state.get("driving_state") == "Pause":
                    self.robot_state["driving_state"] = "Driving"
                return True, None
 
            elif command == "setDriveSpeed":
                linear = float(req_data.get("linearVelocity", 0.0))
                angular = float(req_data.get("angularVelocity", 0.0))
                rospy.loginfo(f"명령 수행: 주행 속도 제한 설정 (v: {linear}, w: {angular})")
                limit_msg = Twist()
                limit_msg.linear.x = linear
                limit_msg.angular.z = math.radians(angular) # ROS 내부용 라디안 변환
                self.max_vel_pub.publish(limit_msg)
                return True, None
 
            # 2. 충전 스테이션 및 도킹
            elif command == "goToCharge":
                rospy.loginfo("명령 수행: 충전 스테이션 복귀")
                self.robot_state["docking_state"] = "DOCKING"
                self.sys_cmd_pub.publish("GO_CHARGE")
                return True, None
            elif command == "goToChargeViaWaypoints":
                waypoints = req_data.get("waypoints", [])
                rospy.loginfo(f"명령 수행: 경유지 거쳐 충전소 복귀")
                self.robot_state["docking_state"] = "DOCKING"
                self.sys_cmd_pub.publish(f"GO_CHARGE_VIA:{json.dumps(waypoints)}")
                return True, None
 
            elif command == "undock":
                rospy.loginfo("명령 수행: 강제 언도킹")
                self.sys_cmd_pub.publish("UNDOCK_REQUEST")
                self.robot_state["docking_state"] = "IDLE"
                return True, None
 
            # 3. 수동 제어
            elif command == "manualMove":
                if self.robot_state.get("is_auto_driving", False):
                    return False, None
                linear = float(req_data.get("linear", 0.0))
                angular = float(req_data.get("angular", 0.0))
                twist_msg = Twist()
                twist_msg.linear.x = linear
                twist_msg.angular.z = math.radians(angular)
                self.cmd_vel_pub.publish(twist_msg)
                return True, None
 
            # 4. 시스템 및 유틸리티
            elif command == "clearError":
                rospy.loginfo("명령 수행: 알람/에러 초기화")
                self.clear_err_pub.publish(True)
                return True, None
 
            elif command == "requestRobotInfo":
                rospy.loginfo("명령 수행: 로봇 하드웨어 정보 요청")
                info_data = {
                    "fcode": FCODE,
                    "macAddress": MAC_ADDRESS,
                    "model": "Platy VX2"
                }
                return True, info_data
 
            elif command == "runSelfDiagnosis":
                rospy.loginfo("명령 수행: 자가 진단 실행")
                # 실제 진단 로직 수행 결과 반환 (예시)
                diag_result = {
                    "motor": True,
                    # "lidar": self.robot_state["front_laser_active"],
                    # "imu": self.robot_state["imu_active"],
                    "lidar": self.is_sensor_alive("frontLaser"),   # 수정
                    "imu": self.is_sensor_alive("imu"),   # 수정
                    "network": True
                }
                return True, diag_result
 
            else:
                rospy.logwarn(f"등록되지 않은 명령어 수신됨: {command}")
                return False, None
        except Exception as e:
            rospy.logerr(f"명령 처리 중 오류 발생: {e}")
            return False, None
 
    def publish_response(self, msg_id, command, success, data=None):
        res_topic = f"/{FCODE}/response"
        res_payload = {
            "msgId": msg_id,
            "command": command,
            "success": success
        }
        if data is not None:
            res_payload["data"] = data
        self.client.publish(res_topic, json.dumps(res_payload), qos=1)
        rospy.loginfo(f"[응답 발행] {command} 처리 완료")
 
    def publish_state(self, event):
        """저장된 self.robot_state 값을 JSON으로 묶어서 앱으로 송신"""
        state_topic = f"/{FCODE}/state"
        current_state = {
            "timestamp": float(time.time()),
            "driving": {
                "x": float(self.robot_state.get("x", 0.0)),
                "y": float(self.robot_state.get("y", 0.0)),
                "angle": float(self.robot_state.get("angle", 0.0)),
                "linearVelocity": float(self.robot_state.get("linear_vel", 0.0)),
                "angularVelocity": float(self.robot_state.get("angular_vel", 0.0)),
                # "state": "Driving" if self.robot_state.get("linear_vel", 0.0) != 0.0 else "Idle",
                # "state": self.robot_state.get("driving_state_str", "Idle"), # emergency 넣기 전 
                # "state": "Emergency" if self.robot_state.get("emergencyStop", False) else self.robot_state.get("driving_state_str", "Idle"), #emergency 넣은 후 수정
                "state": "Emergency" if self.robot_state.get("emergencyStop", False) else self.robot_state.get("driving_state", "Idle"),   # 이사님추가 : move_base/status 기반
                # "driveMode": "Auto",
                "driveMode": self.robot_state.get("drive_mode", "Auto"),   # 이사님추가
                # "emergencyStop": False,
                "emergencyStop": bool(self.robot_state.get("emergencyStop", False)),
                "dockingState": self.robot_state.get("docking_state", "IDLE")
            },
            "navigation": {
                # "mapName": "t2_f1_east",
                "mapName": self.robot_state.get("map_name", ""),   # 추가 : /map_running 연동
                # "mapMetadata": None,
                "mapMetadata": self.robot_state.get("map_metadata", None),   # 추가 : /map info 연동
                "isPathRunning": self.robot_state.get("is_auto_driving", False),
                "currentWaypoint": None,
                # "currentWaypointIndex": -1,
                "currentWaypointIndex": int(self.robot_state.get("current_waypoint_index", -1)),   # 추가 : /current_waypoint_from_fw 연동
                # "totalWaypointCount": 0,
                "totalWaypointCount": int(self.robot_state.get("total_waypoint_count", 0)),   # 추가 : /last_waypoint_index + 1
                # "routeRepetition": 0,
                "routeRepetition": int(self.robot_state.get("route_repetition", 0)),   # 추가 : /current_route_repetition_from_fw 연동
                # "targetRouteRepetition": 0,
                "targetRouteRepetition": int(self.robot_state.get("target_route_repetition", 0)),   # 추가 : /goal_route_repetition 연동
                # "distanceTolerance": 0.5,
                "distanceTolerance": float(self.robot_state.get("distance_tolerance", 0.5)),   # 추가 : /distance_tolerance 연동
                "localizationScore": float(self.robot_state.get("localization_score", 100.0))
            },
            "battery": {
                "batterySoc": float(self.robot_state.get("battery_soc", 0.0)),
                "batteryCur": float(self.robot_state.get("battery_cur", 0.0)),
                "batteryVol": float(self.robot_state.get("battery_vol", 0.0)),
                "isCharging": bool(self.robot_state.get("is_charging", False)),
                # "isDockConnected": False,
                "isDockConnected": bool(self.robot_state.get("is_dock_connected", False)),   # 이사님추가 : 하드코딩 False → 변수
                "batterySoh": float(self.robot_state.get("battery_soh", 100.0)),
                "batteryTemperature": float(self.robot_state.get("battery_temp", 25.0))
            },
            # "motor": {
            #     "motorDriverVoltage": 25.8, 
            #     "motorCurrentLeft": 0.0, 
            #     "motorCurrentRight": 0.0,
            #     "motorAlarmStatus": {"left": [], "right": []}
            # },
            # 수정 : 하드코딩 제거, /monitor_topic(md/monitor_msg) 값 사용. 2초 이상 수신 없으면 0.0 / 빈 배열
            "motor": {
                "motorDriverVoltage": self.motor_state["voltage"] if self.is_sensor_alive("motorMonitor") else 0.0,   # 수정
                "motorCurrentLeft": self.motor_state["cur_left"] if self.is_sensor_alive("motorMonitor") else 0.0,   # 수정
                "motorCurrentRight": self.motor_state["cur_right"] if self.is_sensor_alive("motorMonitor") else 0.0,   # 수정
                "motorAlarmStatus": {   # 수정
                    "left": self.motor_state["alarm_left"] if self.is_sensor_alive("motorMonitor") else [],
                    "right": self.motor_state["alarm_right"] if self.is_sensor_alive("motorMonitor") else []
                }
            },
            "sensor": {
                # "sensors": {
                #     "frontLaser": self.robot_state.get("front_laser_active", False), 
                #     "rearLaser": True,
                #     "imu": self.robot_state.get("imu_active", False), 
                #     "motorDriver": True,
                #     "usbCam": True,
                #     "sonar": True
                # },
                # 수정 : 하드코딩 True 제거, 마지막 수신 시각 기준(SENSOR_TIMEOUT_SEC 이내 수신 여부)으로 판정
                "sensors": {
                    "frontLaser": self.is_sensor_alive("frontLaser"),   # 수정
                    "rearLaser": self.is_sensor_alive("rearLaser"),   # 수정
                    "imu": self.is_sensor_alive("imu"),   # 수정
                    "motorDriver": self.is_sensor_alive("motorDriver"),   # 수정
                    "usbCam": self.is_sensor_alive("usbCam"),   # 수정
                    "sonar": self.is_sensor_alive("sonar")   # 수정
                },
                "sonarFrontLeft": 0.0, 
                "sonarFrontRight": 0.0,
                "bumperStatus": self.robot_state.get("bumper_status", False)
            },
            "accumulated": {
                "driveDistance": 0.0, 
                "driveTime": 0.0
            }
        }
        try:
            payload_str = json.dumps(current_state)
            self.client.publish(state_topic, payload_str, qos=0)
        except Exception as e:
            rospy.logerr(f"상태 JSON 발행 중 에러 발생: {e}")
 
if __name__ == '__main__':
    try:
        bridge = PlatyMqttBridge()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass