#!/usr/bin/env python3
import rospy
import json
import tf
import math
import cv2
import actionlib
from std_msgs.msg import String
from sensor_msgs.msg import Image
from geometry_msgs.msg import Twist
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal, MoveBaseActionGoal
from cv_bridge import CvBridge
from ultralytics import YOLO

class SmartMove:
    def __init__(self):
        rospy.init_node('smart_move_node')

        self.model = YOLO("/home/nvidia/yolo_models/best_250415.pt")
        self.bridge = CvBridge()
        self.latest_image = None
        self.goal_pub = rospy.Publisher("/move_base/goal", MoveBaseActionGoal, queue_size=1)

        self.cmd_pub = rospy.Publisher("/cmd_vel", Twist, queue_size=1)
        self.text_pub = rospy.Publisher("/robot_assistant/text/speak", String, queue_size=1)
        self.text_tts_pub = rospy.Publisher("/robot_assistant/text/speak", String, queue_size=1)
        self.client = actionlib.SimpleActionClient("move_base", MoveBaseAction)
        rospy.loginfo("Waiting for move_base server...")
        self.client.wait_for_server()
        rospy.loginfo("move_base server ready.")

        rospy.Subscriber("/camera2/usb_cam2/image_raw", Image, self.image_callback)
        rospy.Subscriber("/robot_assistant/navigation/request", String, self.goal_callback)

        rospy.spin()

    def image_callback(self, msg):
        self.latest_image = self.bridge.imgmsg_to_cv2(msg, desired_encoding='bgr8')

    def goal_callback(self, msg):
        try:
            data = json.loads(msg.data)
            pose = data["pose"]
            label = data["label"]
            rospy.loginfo(f"[\U0001F4E2 이동 명령 수신] label: {label}, pose: {pose}")
            self.move_to(pose, label)
        except Exception as e:
            rospy.logerr(f"[❌ JSON 파싱 실패] {e}")

    def move_to(self, pose, text):
        goal = MoveBaseGoal()
        goal.target_pose.header.frame_id = "map"
        goal.target_pose.header.stamp = rospy.Time.now()
        goal.target_pose.pose.position.x = pose["x"]
        goal.target_pose.pose.position.y = pose["y"]
        q = tf.transformations.quaternion_from_euler(0, 0, pose["yaw"])
        goal.target_pose.pose.orientation.x = q[0]
        goal.target_pose.pose.orientation.y = q[1]
        goal.target_pose.pose.orientation.z = q[2]
        goal.target_pose.pose.orientation.w = q[3]

        self.client.send_goal(goal)
        rospy.loginfo("\U0001F6B6 이동 시작...")
        rate = rospy.Rate(2)

        while not rospy.is_shutdown():
            if self.client.get_state() == actionlib.GoalStatus.SUCCEEDED:
                rospy.loginfo("***목표 위치 도달***")
                self.text_tts_pub.publish(String(f'{text} 에 도착했습니다.'))
                break

            if self.latest_image is not None:
                results = self.model(self.latest_image)[0]
                for box in results.boxes:
                    label = results.names[int(box.cls[0])]
                    if label == text and text == "fire extinguisher":
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

                        self.text_tts_pub.publish(String(f'{text} 가 보입니다.'))
                        rospy.sleep(4.0)
                        self.rotate_toward_object(text)

                        rospy.loginfo("🕒 객체 감지됨 → 3초 대기 중...")
                        rospy.sleep(3.0)

                        # 거리 계산 후 앞으로 이동
                        y2 = float(box.xyxy[0][3])
                        distance = self.estimate_distance(y2)
                        rospy.loginfo(f"📐 y2={y2:.2f} → 거리={distance:.2f}m")
                        self.publish_offset_goal(distance, text)
                        return  # 함수 종료

            rate.sleep()

        rospy.sleep(1.0)
        if self.latest_image is not None:
            results = self.model(self.latest_image)[0]
            labels = [results.names[int(cls)] for cls in results.boxes.cls]

            if text in labels:
                if text == "fire extinguisher":
                    rospy.loginfo("📍 도착 위치에서 객체 감지됨 → 정렬 후 객체 앞으로 이동 시작")
                    self.rotate_toward_object(text)

                    for box in results.boxes:
                        label = results.names[int(box.cls[0])]
                        if label == text:
                            y2 = float(box.xyxy[0][3])
                            distance = self.estimate_distance(y2)
                            rospy.loginfo(f"📐 객체 위치 y2={y2:.2f} → 거리 추정: {distance:.2f}m")
                            self.publish_offset_goal(distance, text)
                            return

            else:
                rospy.logwarn("❌ 도착 후에도 객체를 찾지 못했습니다.")
                self.text_tts_pub.publish(String(f'{text} 를 찾지 못했습니다.')) 

    def rotate_toward_object(self, text):
        rospy.loginfo("***객체를 중앙에 맞추기 위한 회전 시작***")
        rate = rospy.Rate(5)

        while not rospy.is_shutdown():
            if self.latest_image is not None:
                results = self.model(self.latest_image)[0]
                for box in results.boxes:
                    label = results.names[int(box.cls[0])]
                    if label == text:
                        cx = float(box.xywh[0][0])
                        y2 = float(box.xyxy[0][3])

                        rospy.loginfo(f"***'{label}' → cx={cx:.1f}, y2={y2:.1f}***")

                        if cx < 315:
                            self.send_rotation_command(0.15)
                        elif cx > 325:
                            self.send_rotation_command(-0.15)
                        else:
                            self.send_rotation_command(0.0)
                            if y2 > 200:
                                rospy.loginfo("***정지 완료***")
                                return
            rate.sleep()

    def send_rotation_command(self, speed):
        twist = Twist()
        twist.angular.z = speed
        self.cmd_pub.publish(twist)

    def estimate_distance(self, y2, cam_height=0.85, fov_v=70.0, image_height=480):
        center_y = image_height / 2.0
        angle_per_pixel = fov_v / image_height
        angle_deg = (y2 - center_y) * angle_per_pixel
        if angle_deg <= 0.1:
            return float('inf')
        theta = math.radians(angle_deg)
        return cam_height / math.tan(theta)

    def publish_offset_goal(self, distance, text, offset=0.5):
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
            rospy.loginfo("***목표 도착 완료***")
            self.text_tts_pub.publish(String(f'{text} 에 도착했습니다.'))
        else:
            rospy.logwarn("***목표 도착 실패 또는 시간 초과***")

if __name__ == '__main__':
    try:
        SmartMove()
    except rospy.ROSInterruptException:
        pass
