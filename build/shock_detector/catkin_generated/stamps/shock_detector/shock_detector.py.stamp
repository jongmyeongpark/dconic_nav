#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import rospy
from sensor_msgs.msg import Imu
from std_msgs.msg import Empty
from geometry_msgs.msg import Twist
import math
import time

class ShockDetector:
    def __init__(self):
        # 파라미터
        self.threshold = rospy.get_param("~accel_threshold", 5.0)   # 충격 감지 임계값 (m/s^2)
        self.stop_duration = rospy.get_param("~stop_duration", 2.0) # 정지 유지 시간 (초)
        self.cmd_hz = rospy.get_param("~cmd_rate", 20)              # cmd_vel 발행 주기 (Hz)

        # Publisher
        self.pub_cancel = rospy.Publisher("/path_run_cancel_request", Empty, queue_size=1)
        self.pub_cmd = rospy.Publisher("/cmd_vel", Twist, queue_size=10)

        # Subscriber
        rospy.Subscriber("/imu/data", Imu, self.imu_callback)

        # 상태 변수
        self.last_stop_time = 0.0
        self.stopping = False

        # Zero Twist 메시지 (선속도 + 회전속도 모두 0)
        self.zero_twist = Twist()
        self.zero_twist.linear.x = 0.0
        self.zero_twist.linear.y = 0.0
        self.zero_twist.linear.z = 0.0
        self.zero_twist.angular.x = 0.0
        self.zero_twist.angular.y = 0.0
        self.zero_twist.angular.z = 0.0

        # cmd_vel 루프 주기
        self.cmd_rate = rospy.Rate(self.cmd_hz)

    def imu_callback(self, msg):
        # 가속도 크기 계산
        ax = msg.linear_acceleration.x
        ay = msg.linear_acceleration.y
        az = msg.linear_acceleration.z
        accel_mag = math.sqrt(ax**2 + ay**2 + az**2)

        # 중력 보정
        accel_without_gravity = abs(accel_mag - 9.81)

        # 충격 감지
        if accel_without_gravity > self.threshold:
            now = time.time()
            if now - self.last_stop_time > self.stop_duration:
                rospy.logwarn("Shock detected! Cancelling path and forcing stop.")
                self.pub_cancel.publish(Empty())   # 경로 취소
                self.stopping = True               # 정지 상태로 전환
                self.last_stop_time = now

    def run(self):
        while not rospy.is_shutdown():
            if self.stopping:
                # stop_duration 동안 계속 0속도 발행
                if time.time() - self.last_stop_time < self.stop_duration:
                    self.pub_cmd.publish(self.zero_twist)
                else:
                    self.stopping = False
            self.cmd_rate.sleep()

if __name__ == "__main__":
    rospy.init_node("shock_detector", anonymous=False)
    node = ShockDetector()
    rospy.loginfo("Shock Detector node started.")
    node.run()