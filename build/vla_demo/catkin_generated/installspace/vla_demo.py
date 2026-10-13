#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import rospy
import json
import openai
import cv2
import tf
import actionlib
import math
import re
from collections import deque
from sensor_msgs.msg import Image
from geometry_msgs.msg import PoseWithCovarianceStamped, Twist
from cv_bridge import CvBridge
from std_msgs.msg import String
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal, MoveBaseActionGoal
from ultralytics import YOLO
import time

class FrameNavigator:
    def __init__(self):
        self.model = YOLO("/home/nvidia/dconic_nav/src/ju_vla/scripts/best_250415.pt")
        openai.api_key = "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"
        self.json_path = "/home/nvidia/dconic_nav/src/sang_vla/captured_json/data.json"
        
        self.bridge = CvBridge()

        rospy.Subscriber("/robot_assistant/vla_input", String, self.input_callback)
        rospy.Subscriber("/camera2/usb_cam2/image_raw", Image, self.image_callback)

        self.cmd_pub = rospy.Publisher("/cmd_vel", Twist, queue_size=1)
        self.pub_event_speech = rospy.Publisher("/event_speech", String, queue_size=1)
        self.goal_pub = rospy.Publisher("/move_base/goal", MoveBaseActionGoal, queue_size=1)

        self.client = actionlib.SimpleActionClient("move_base", MoveBaseAction)
        self.client.wait_for_server()

        rospy.loginfo("✅ ***FrameNavigator 노드 시작됨***")

        self.latest_image = None  

    def image_callback(self, msg):
        self.latest_image = self.bridge.imgmsg_to_cv2(msg, desired_encoding='bgr8')


    def input_callback(self, msg):
        question = msg.data
        rospy.loginfo(f"***사용자 질문***: {question}")
        best_frame, target_object = self.get_best_frame_from_openai(question)
        if best_frame:
            rospy.loginfo(f"***선택된 프레임***: {best_frame['frame_id']}, ***객체***: {target_object}")
            self.move_to(best_frame["x"], best_frame["y"], best_frame["orientation"], target_object)
        else:
            rospy.logwarn("***관련된 프레임을 찾을 수 없습니다.***")

    def get_best_frame_from_openai(self, question):
        with open(self.json_path, "r", encoding="utf-8") as f:
            frames = json.load(f)

        prompt = f"""
You are given a list of frame data. Each frame includes:
- frame_id
- caption
- a list of detected objects (label)

Your task is to:
1. Understand the user's question.
2. Choose the frame where the caption is most relevant to the user's question.
3. Respond in the following JSON format:

{{
  "frame_id": "frame_XXXX.jpg",
  "object": "object_label"
}}

You MUST respond with the JSON block first, then on the next line explain why you chose this frame.

Frame metadata:
{json.dumps(frames, indent=2, ensure_ascii=False)}

User question: {question}
"""

        response = openai.ChatCompletion.create(
            model="gpt-4o-mini",
            messages=[
                {"role": "system", "content": "You are a helpful robot that navigates to locations based on image metadata."},
                {"role": "user", "content": prompt}
            ],
            temperature=0.2,
            max_tokens=300
        )

        reply = response.choices[0].message["content"]
        rospy.loginfo(f"🤖 GPT 응답:\n{reply}")

        try:
            match = re.search(r'\{[\s\S]*?\}', reply)
            if match:
                json_str = match.group(0)
                result = json.loads(json_str)
                frame_id = result["frame_id"]
                target_object = result["object"]

                explanation = reply[match.end():].strip()
                rospy.loginfo(f"📌 프레임 선택 이유: {explanation}")
                for frame in frames:
                    if frame["frame_id"] == frame_id:
                        return frame, target_object
            else:
                rospy.logwarn("***JSON 블록을 찾을 수 없습니다.***")
        except Exception as e:
            rospy.logwarn(f"***GPT 응답 처리 실패: {e}***")

        return None, None

    def estimate_distance(self, y2, cam_height=0.9, fov_v=70.0, image_height=480):
        center_y = image_height / 2.0
        angle_per_pixel = fov_v / image_height
        delta_y = y2 - center_y
        angle_deg = delta_y * angle_per_pixel
        if angle_deg <= 0.1:
            return float('inf')
        theta = math.radians(angle_deg)
        return cam_height / math.tan(theta)

    def publish_offset_goal(self, distance, target_object, offset=0.5):
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

        # MoveBaseGoal 생성
        move_goal = MoveBaseGoal()
        move_goal.target_pose.header.frame_id = "map"
        move_goal.target_pose.header.stamp = rospy.Time.now()
        move_goal.target_pose.pose.position.x = goal_x
        move_goal.target_pose.pose.position.y = goal_y
        move_goal.target_pose.pose.orientation.x = rot[0]
        move_goal.target_pose.pose.orientation.y = rot[1]
        move_goal.target_pose.pose.orientation.z = rot[2]
        move_goal.target_pose.pose.orientation.w = rot[3]

        # 액션 클라이언트로 목표 전송
        self.client.send_goal(move_goal)
        rospy.loginfo(f"***객체 앞 추정 좌표로 이동: ({goal_x:.2f}, {goal_y:.2f})***")

        # 결과 대기
        success = self.client.wait_for_result(rospy.Duration(30.0))  # 최대 20초 기다림
        if success and self.client.get_state() == actionlib.GoalStatus.SUCCEEDED:
            if self.latest_image is not None:
                results = self.model(self.latest_image)[0]
                for box in results.boxes:
                    label = results.names[int(box.cls[0])]
                    if label == target_object:
                        rospy.loginfo(f"***'{label}' 객체 도착 지점에서 확인됨***")
                        self.pub_event_speech.publish("0000")
                    else:
                        rospy.logwarn("***목표 도착 실패 또는 시간 초과***")


    def rotate_toward_object(self, target_object):
        rospy.loginfo("***객체를 중앙에 맞추기 위한 회전 시작***")
        rate = rospy.Rate(5)

        centered_start_time = None

        while not rospy.is_shutdown():
            if self.latest_image is not None:
                results = self.model(self.latest_image)[0]
                for box in results.boxes:
                    label = results.names[int(box.cls[0])]
                    if label == target_object:
                        cx = float(box.xywh[0][0])
                        y2 = float(box.xyxy[0][3])

                        rospy.loginfo(f"***'{label}' → cx={cx:.1f}, y2={y2:.1f}***")

                        if 300 < cx < 340:
                            self.send_rotation_command(0.0)

                            if centered_start_time is None:
                                centered_start_time = time.time()
                            else:
                                elapsed = time.time() - centered_start_time
                                if elapsed > 3.0 and y2 > 200:
                                    rospy.loginfo("***3초 이상 중심 유지 + 거리 충족 → 정지 완료***")
                        else:
                            centered_start_time = None

                            if cx < 300:
                                self.send_rotation_command(0.15)
                            elif cx > 340:
                                self.send_rotation_command(-0.15)

            rate.sleep()

    def send_rotation_command(self, speed):
        twist = Twist()
        twist.angular.z = speed
        self.cmd_pub.publish(twist)

    def move_to(self, x, y, orientation, target_object):
        rospy.loginfo(f"***이동 시작 → x: {x:.2f}, y: {y:.2f}, object: {target_object}***")
        
        goal = MoveBaseGoal()
        goal.target_pose.header.frame_id = "map"
        goal.target_pose.header.stamp = rospy.Time.now()
        goal.target_pose.pose.position.x = x
        goal.target_pose.pose.position.y = y
        goal.target_pose.pose.orientation.x = orientation["x"]
        goal.target_pose.pose.orientation.y = orientation["y"]
        goal.target_pose.pose.orientation.z = orientation["z"]
        goal.target_pose.pose.orientation.w = orientation["w"]

        self.client.send_goal(goal)

        rate = rospy.Rate(2)
        object_detected = False

        while not rospy.is_shutdown():
            # 이동 성공
            if self.client.get_state() == actionlib.GoalStatus.SUCCEEDED:
                rospy.loginfo("***목표 위치 도달***")
                break

            # 이미지가 있고 객체가 감지되었는지 확인
            if self.latest_image is not None:
                results = self.model(self.latest_image)[0]
                for box in results.boxes:
                    label = results.names[int(box.cls[0])]
                    if label == target_object and target_object == "fire extinguisher":
                        rospy.loginfo(f"📍 주행 중 '{label}' 감지됨 → 목표 취소 및 정렬 시작")
                        state = self.client.get_state()
                        if state not in [actionlib.GoalStatus.SUCCEEDED,
                                        actionlib.GoalStatus.ABORTED,
                                        actionlib.GoalStatus.REJECTED,
                                        actionlib.GoalStatus.PREEMPTED]:
                            self.client.cancel_goal()
                            rospy.loginfo("📍 목표 취소 요청 전송됨")
                        else:
                            rospy.logwarn(f"🚫 목표 이미 완료 상태({state}) → cancel_goal() 스킵")

                        rospy.sleep(1.5)

                        self.pub_event_speech.publish("0410_05")
                        rospy.sleep(1.0)
                        self.rotate_toward_object(target_object)
                        
                        
                        rospy.loginfo("🕒 객체 감지됨 → 3초 대기 중...")
                        rospy.sleep(3.0)

                        # 거리 계산 후 앞으로 이동
                        y2 = float(box.xyxy[0][3])
                        distance = self.estimate_distance(y2)
                        rospy.loginfo(f"📐 y2={y2:.2f} → 거리={distance:.2f}m")
                        self.publish_offset_goal(distance)
                        return  # 함수 종료

            rate.sleep()

        # 목표지점 도착했지만 객체를 감지 못한 경우 (기존 로직 유지)
        rospy.sleep(1.0)
        if self.latest_image is not None:
            results = self.model(self.latest_image)[0]
            labels = [results.names[int(cls)] for cls in results.boxes.cls]

            if target_object in labels:
                if target_object == "fire extinguisher":
                    rospy.loginfo("📍 도착 위치에서 객체 감지됨 → 정렬 후 객체 앞으로 이동 시작")
                    self.rotate_toward_object(target_object)

                    for box in results.boxes:
                        label = results.names[int(box.cls[0])]
                        if label == target_object:
                            y2 = float(box.xyxy[0][3])
                            distance = self.estimate_distance(y2)
                            rospy.loginfo(f"📐 객체 위치 y2={y2:.2f} → 거리 추정: {distance:.2f}m")
                            self.publish_offset_goal(distance)
                            return
            else:
                rospy.logwarn("❌ 도착 후에도 객체를 찾지 못했습니다.")
                self.pub_event_speech.publish("0410_01")


def main():
    rospy.init_node("frame_navigator")
    navigator = FrameNavigator()
    rospy.spin()

if __name__ == "__main__":
    main()
