#!/usr/bin/env python3
# parking_teb_switcher.py
# /parking_state 토픽을 구독해서 주차 진입/진출 시 TEB 파라미터를 STRICT/NORMAL로 전환

import rospy
import dynamic_reconfigure.client
from std_msgs.msg import String, Bool


class ParkingTebSwitcher:
    def __init__(self):
        rospy.init_node('parking_teb_switcher')

        self.in_strict_mode = False

        # 주차 진입/진출 시 STRICT로 전환할 상태 목록
        self.strict_states = {
            # "MOVING_TO_PARKING_POINT",
            "MOVING_TO_PARKING_POINT2",
            "MOVING_TO_PARKING_POINT3",
            "MOVING_TO_PARKING_POINT4",
            # "INITIAL_MOVING_BACK",
            # "ADJUSTING_YAW",
            # "INITIAL_ADJUSTING_FOWARD",
            # "COLLECTING_DATA",
            # "ADJUSTING_YAW_TO_HORIZONTAL",
            # "ADJUSTING_FORWARD_TO_HORIZONTAL",
            # "ADJUSTING_YAW_AFTER_HORIZONTAL_FORWARD",
            # "ADJUSTING_YAW_PRECISELY_AFTER_HORIZONTAL_FORWARD",
            # "ADJUSTING_FORWARD",
            # "MOVING_BACK",
            # "FINISHED",
            # "MOVING_BACK_TO_JOURNEY",
            # "TURN_AFTER_MOVING_BACK_TO_JOURNEY",
            "MOVING_TO_EXIT_POINT1",
        }

        # NORMAL로 복귀할 상태 목록
        self.normal_states = {
            "INITIALIZING",
            "IDLE",
        }

        # ── Strict 파라미터 ──
        self.strict_params = {
            'global_plan_viapoint_sep': 0.15,
            'weight_viapoint': 30.0,
            'via_points_ordered': True,
            'max_global_plan_lookahead_dist': 0.8,
            'max_vel_x': 0.12,
            'max_vel_x_backwards': 0.05,
            'max_vel_theta': 0.2,
            'weight_obstacle': 2.0,
            'min_obstacle_dist': 0.3,
            'inflation_dist': 0.4,
            'weight_kinematics_forward_drive': 10.0,
            'xy_goal_tolerance': 0.05,
            'yaw_goal_tolerance': 0.05,
        }

        self.strict_move_base_params = {
            'recovery_behavior_enabled': False,
            'clearing_rotation_allowed': False,
        }

        # ── Normal 파라미터 ──
        self.normal_params = {
            'global_plan_viapoint_sep': 0.5,
            'weight_viapoint': 2.0,
            'via_points_ordered': False,
            'max_global_plan_lookahead_dist': 3.0,
            'max_vel_x': 0.3,
            'max_vel_x_backwards': 0.1,
            'max_vel_theta': 0.25,
            'weight_obstacle': 5.0,
            'min_obstacle_dist': 0.3,
            'inflation_dist': 0.4,
            'weight_kinematics_forward_drive': 5.0,
            'xy_goal_tolerance': 0.3,
            'yaw_goal_tolerance': 0.1,
        }

        self.normal_move_base_params = {
            'recovery_behavior_enabled': True,
            'clearing_rotation_allowed': True,
        }

        # dynamic_reconfigure clients - move_base 뜰 때까지 재시도
        self.teb_client = None
        self.move_base_client = None

        rospy.loginfo("Waiting for move_base/TebLocalPlannerROS...")
        while not rospy.is_shutdown():
            try:
                self.teb_client = dynamic_reconfigure.client.Client(
                    '/move_base/TebLocalPlannerROS', timeout=5.0)
                rospy.loginfo("TEB dynamic_reconfigure client connected")
                break
            except Exception as e:
                rospy.logwarn(f"move_base 아직 준비 안됨, 재시도 중... {e}")
                rospy.sleep(2.0)

        rospy.loginfo("Waiting for move_base...")
        while not rospy.is_shutdown():
            try:
                self.move_base_client = dynamic_reconfigure.client.Client(
                    '/move_base', timeout=5.0)
                rospy.loginfo("move_base dynamic_reconfigure client connected")
                break
            except Exception as e:
                rospy.logwarn(f"move_base 아직 준비 안됨, 재시도 중... {e}")
                rospy.sleep(2.0)

        self.strict_zone_active_pub = rospy.Publisher(
            '/parking_strict_zone_active', Bool, queue_size=1, latch=True)

        rospy.Subscriber('/parking_state', String, self.parking_state_callback)

        rospy.loginfo("Parking TEB Switcher ready")


    def parking_state_callback(self, msg):
        state = msg.data

        if state in self.strict_states:
            if not self.in_strict_mode:
                rospy.loginfo(f"Parking State [{state}] -> STRICT")
                self._apply_params(self.strict_params)
                self._apply_move_base_params(self.strict_move_base_params)
                self.in_strict_mode = True
                self.strict_zone_active_pub.publish(Bool(data=True))

        elif state in self.normal_states:
            if self.in_strict_mode:
                rospy.loginfo(f"Parking State [{state}] -> NORMAL")
                self._apply_params(self.normal_params)
                self._apply_move_base_params(self.normal_move_base_params)
                self.in_strict_mode = False
                self.strict_zone_active_pub.publish(Bool(data=False))

    def _apply_params(self, params):
        try:
            new_config = self.teb_client.update_configuration(params)
            applied_values = {k: new_config[k] for k in params.keys() if k in new_config}
            rospy.loginfo("── 파라미터 적용 성공 ──")
            for key, val in applied_values.items():
                rospy.loginfo(f"  [확인] {key}: {val}")
            rospy.loginfo("────────────────────────")
        except Exception as e:
            rospy.logwarn(f"파라미터 적용 실패: {e}")

    def _apply_move_base_params(self, params):
        if self.move_base_client is None:
            return
        try:
            self.move_base_client.update_configuration(params)
            rospy.loginfo(f"move_base params applied: {params}")
        except Exception as e:
            rospy.logwarn(f"move_base 파라미터 적용 실패: {e}")


if __name__ == '__main__':
    node = ParkingTebSwitcher()
    rospy.spin()
