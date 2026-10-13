#!/usr/bin/env python
# coding: utf-8

import rospy
from std_msgs.msg import String
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError
import openai
import cv2
import base64
import os
import numpy as np
import webcolors
from ultralytics import YOLO
import math
import tf
import actionlib
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal
from geometry_msgs.msg import Twist

# ✅ OpenAI API 키 설정
openai.api_key = "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"  # 실제 키로 교체 필요

class GptYoloOverlayNode:
    def __init__(self):
        rospy.init_node("gpt_yolo_overlay_node")

        self.bridge = CvBridge()
        self.latest_image = None
        self.overlay_image = None
        self.target_label = None

        # YOLO 모델 로드
        self.model = YOLO("yolov8n.pt")

        # ROS 통신 설정
        self.image_sub = rospy.Subscriber('/camera2/usb_cam2/image_raw', Image, self.image_callback)
        self.overlay_pub = rospy.Publisher('/camera2/yolo_overlay/image', Image, queue_size=1)
        self.response_pub = rospy.Publisher("/gpt_response", String, queue_size=10)
        self.text_sub = rospy.Subscriber("/robot_assistant/gpt/chat_vla", String, self.input_callback)
        self.cmd_pub = rospy.Publisher("/cmd_vel", Twist, queue_size=10)
        # self.text_tts_pub = rospy.Publisher("/robot_speech_tts", String, queue_size=10)
        self.client = actionlib.SimpleActionClient("move_base", MoveBaseAction)
        self.client.wait_for_server()

        self.image_save_path = "/home/nvidia/dconic_nav/src/vla_demo/captured_image"
        rospy.loginfo("GptYoloOverlayNode initialized.")

    def image_callback(self, msg):
        try:
            cv_image = self.bridge.imgmsg_to_cv2(msg, desired_encoding="bgr8")
            self.latest_image = cv_image.copy()
            self.process_yolo_overlay(cv_image)
        except CvBridgeError as e:
            rospy.logerr(f"CvBridge 변환 실패: {e}")

    def process_yolo_overlay(self, img_bgr):
        img_rgb = cv2.cvtColor(img_bgr, cv2.COLOR_BGR2RGB)
        results = self.model.predict(img_rgb)[0]
        vis_img = img_bgr.copy()

        for box in results.boxes:
            x1, y1, x2, y2 = map(int, box.xyxy[0])
            cls_id = int(box.cls[0])
            class_name = self.model.names[cls_id]
            crop = img_rgb[y1:y2, x1:x2]
            if crop.size == 0:
                continue
            avg_rgb = self.get_avg_rgb(crop)
            color_name = self.closest_color_name(avg_rgb)
            label = f"{color_name} {class_name}"
            cv2.rectangle(vis_img, (x1, y1), (x2, y2), (0, 255, 0), 2)
            cv2.putText(vis_img, label, (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 2)

        self.overlay_image = vis_img
        try:
            overlay_msg = self.bridge.cv2_to_imgmsg(vis_img, encoding="bgr8")
            self.overlay_pub.publish(overlay_msg)
        except CvBridgeError as e:
            rospy.logerr(f"오버레이 이미지 퍼블리시 실패: {e}")

    def closest_color_name(self, rgb):
        def distance(c1, c2):
            return sum((a - b) ** 2 for a, b in zip(c1, c2))
        r, g, b = int(rgb[0]), int(rgb[1]), int(rgb[2])
        min_dist = float('inf')
        closest_name = "unknown"
        for name, hex_val in webcolors.CSS3_NAMES_TO_HEX.items():
            try:
                r_c, g_c, b_c = webcolors.hex_to_rgb(hex_val)
                d = distance((r, g, b), (r_c, g_c, b_c))
                if d < min_dist:
                    min_dist = d
                    closest_name = name
            except:
                continue
        return closest_name

    def get_avg_rgb(self, crop):
        return np.mean(crop.reshape(-1, 3), axis=0)

    def input_callback(self, msg):
        user_msg = msg.data.strip()
        rospy.loginfo(f"사용자 메시지 수신: {user_msg}")

        # 자연어 → 타겟 객체 이름 매핑
        if "분홍색 캐리어" in user_msg:
            self.target_label = "rosybrown suitcase " or "darkgray suitcase"
            print("succes")
            self.navigate_to_target("분홍색 캐리어")
        elif "파란색 캐리어" in user_msg:
            self.target_label = "darkslategray suitcase"
            self.navigate_to_target("파란색 캐리어")
        else:
            rospy.logwarn("지원되지 않는 명령입니다.")

    def navigate_to_target(self, spoken_name):
        success = self.align_object_center()
        if not success:
            rospy.logwarn("중심 정렬 실패")
            return

        y2 = self.get_y2_of_target()
        if y2 is None:
            rospy.logwarn("거리 추정 실패: 객체 인식 안됨")
            return

        distance = self.estimate_distance(y2)
        rospy.loginfo(f"[📏 추정 거리]: {distance:.2f}m")
        self.publish_offset_goal(distance, spoken_name)

    def align_object_center(self):
        rospy.sleep(1.0)
        rospy.loginfo("[🎯 중심 정렬 시작]")
        rate = rospy.Rate(10)
        twist = Twist()
        twist.angular.z = 0.2

        while not rospy.is_shutdown():
            if self.latest_image is None:
                rate.sleep()
                continue

            results = self.model(self.latest_image)[0]
            for box in results.boxes.data:
                cls_id = int(box[-1])
                label = self.model.names[cls_id]
                rospy.loginfo(f"[🧪 탐지 객체] {label}")

                crop = self.latest_image[int(box[1]):int(box[3]), int(box[0]):int(box[2])]
                rospy.loginfo(f"[🧪 crop shape] {crop.shape}")

                if crop.size == 0:
                    rospy.logwarn("[⚠️ 잘못된 crop - size 0]")
                    continue

                avg_rgb = self.get_avg_rgb(cv2.cvtColor(crop, cv2.COLOR_BGR2RGB))
                color = self.closest_color_name(avg_rgb)
                full_label = f"{color} {label}"
                rospy.loginfo(f"[🎨 full_label] {full_label} / target: {self.target_label}")
                if full_label == self.target_label:
                    x1, y1, x2, y2 = box[:4]
                    x_center = (x1 + x2) / 2.0
                    rospy.loginfo(f"[👀 중심 x: {x_center}]")

                    if 315 <= x_center <= 325:
                        self.cmd_pub.publish(Twist())
                        rospy.loginfo("[✅ 중심 정렬 완료]")
                        return True
                    elif x_center < 315:
                        twist.angular.z = 0.15
                    elif x_center > 325:
                        twist.angular.z = -0.15

                    self.cmd_pub.publish(twist)
                    break
            rate.sleep()

        return False

    def get_y2_of_target(self):
        if self.latest_image is None:
            return None

        results = self.model(self.latest_image)[0]
        for box in results.boxes.data:
            cls_id = int(box[-1])
            label = self.model.names[cls_id]
            crop = self.latest_image[int(box[1]):int(box[3]), int(box[0]):int(box[2])]
            if crop.size == 0:
                continue
            avg_rgb = self.get_avg_rgb(cv2.cvtColor(crop, cv2.COLOR_BGR2RGB))
            color = self.closest_color_name(avg_rgb)
            full_label = f"{color} {label}"
            if full_label == self.target_label:
                _, _, _, y2 = box[:4]
                return float(y2)
        return None

    def estimate_distance(self, y2, cam_height=0.9, fov_v=50.0, image_height=480):
        center_y = image_height / 2.0
        angle_per_pixel = fov_v / image_height
        angle_deg = (y2 - center_y) * angle_per_pixel
        if angle_deg <= 0.1:
            return float('inf')
        theta = math.radians(angle_deg)
        return cam_height / math.tan(theta)

    def publish_offset_goal(self, distance, text, offset=0.3):
        goal_x_base = distance - offset
        if goal_x_base <= 0.2:
            rospy.logwarn("Too close to object, not moving.")
            return

        listener = tf.TransformListener()
        listener.waitForTransform("/map", "/base_link", rospy.Time(0), rospy.Duration(3.0))
        (trans, rot) = listener.lookupTransform("/map", "/base_link", rospy.Time(0))
        yaw = tf.transformations.euler_from_quaternion(rot)[2]

        goal_x = trans[0] + goal_x_base * math.cos(yaw)
        goal_y = trans[1] + goal_x_base * math.sin(yaw)

        move_goal = MoveBaseGoal()
        move_goal.target_pose.header.frame_id = "map"
        move_goal.target_pose.header.stamp = rospy.Time.now()
        move_goal.target_pose.pose.position.x = goal_x
        move_goal.target_pose.pose.position.y = goal_y
        move_goal.target_pose.pose.orientation.x = rot[0]
        move_goal.target_pose.pose.orientation.y = rot[1]
        move_goal.target_pose.pose.orientation.z = rot[2]
        move_goal.target_pose.pose.orientation.w = rot[3]

        self.client.send_goal(move_goal)
        rospy.loginfo(f"***객체 앞 추정 좌표로 이동: ({goal_x:.2f}, {goal_y:.2f})***")

        success = self.client.wait_for_result(rospy.Duration(30.0))
        if success and self.client.get_state() == actionlib.GoalStatus.SUCCEEDED:
            rospy.loginfo("***목표 도착 완료***")
            # self.text_tts_pub.publish(String(f'{text} 에 도착했습니다.'))
        else:
            rospy.logwarn("***목표 도착 실패 또는 시간 초과***")

if __name__ == '__main__':
    try:
        GptYoloOverlayNode()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass
