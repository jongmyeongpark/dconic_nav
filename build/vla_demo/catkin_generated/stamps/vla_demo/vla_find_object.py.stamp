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
import numpy as np

class FindObject:
    def __init__(self):
        rospy.init_node('find_object_node')

        self.latest_image = None
        self.target_label = None
        self.label_kor_map = {
            "fire extinguisher": "소화기",
            "chair": "의자",
            "Cubrick": "큐브릭",
            "plant": "화분",
            "charging station": "충전 스테이션",
            "charging station_long": "긴 충전 스테이션",
            "Vstella": "브이 스텔라",
            "Mo2": "엠오투",
            "refrigerator": "냉장고"
        }
        self.model = YOLO("/home/nvidia/dconic_nav/src/vla_demo/best_250415.pt")
        self.bridge = CvBridge()
        
        dummy_image = 255 * np.ones((480, 640, 3), dtype=np.uint8)
        _ = self.model(dummy_image)[0]
        rospy.loginfo("✅ YOLO 모델 워밍업 완료")

        rospy.Subscriber("/camera1/usb_cam1/image_raw", Image, self.image_callback)
        rospy.Subscriber("/robot_assistant/navigation/request", String, self.goal_callback)

        self.goal_pub = rospy.Publisher("/move_base/goal", MoveBaseActionGoal, queue_size=1)
        self.cmd_pub = rospy.Publisher("/cmd_vel", Twist, queue_size=1)
        self.text_pub = rospy.Publisher("/robot_assistant/text/speak", String, queue_size=1)
        self.text_tts_pub = rospy.Publisher("/robot_assistant/text/speak", String, queue_size=1)
                                        
        self.client = actionlib.SimpleActionClient("move_base", MoveBaseAction)
        rospy.loginfo("Waiting for move_base server...")
        self.client.wait_for_server()
        rospy.loginfo("move_base server ready.")

        rospy.spin()

    def image_callback(self, msg):
        self.latest_image = self.bridge.imgmsg_to_cv2(msg, desired_encoding='bgr8')

    def goal_callback(self, msg):
        try:
            data = json.loads(msg.data)
            pose = data["pose"]
            self.target_label = data["label"]
            self.target_label_kor = self.label_kor_map.get(self.target_label, self.target_label)

            rospy.loginfo(f"[\U0001F4E2 이동 명령 수신] label: {self.target_label}, pose: {pose}")
            self.move_to(pose)
        except Exception as e:
            rospy.logerr(f"[❌ JSON 파싱 실패] {e}")

    def detect_label(self):
        if self.latest_image is None:
            return False
        results = self.model(self.latest_image)[0]
        for r in results.boxes.data:
            cls_id = int(r[-1])
            label = self.model.names[cls_id]
            if label == self.target_label:
                rospy.loginfo(f"[✅ 탐지됨] {label}")
                return True
        rospy.loginfo("[❌ 탐지 안됨]")
        return False
    
    def move_to(self, pose):
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

        rospy.loginfo("이동 중...")
        self.client.send_goal(goal)
        self.client.wait_for_result()
        rospy.loginfo("도착 완료")

        rospy.sleep(1.0)

        if self.detect_label():
            self.text_pub.publish(String(f"{self.target_label_kor} 위치에 도착하였습니다."))
        else:
            self.text_pub.publish(String(f"{self.target_label_kor}가 보이지 않습니다."))
            rospy.sleep(5.0)
            rospy.loginfo("[🔁 탐지 실패] 한 바퀴 회전 시도 중...")
        
            if self.rotate_and_detect():
                rospy.sleep(2.0)
                y2 = self.get_y2_of_target()
                if y2:
                    distance = self.estimate_distance(y2)
                    self.publish_offset_goal(distance, self.target_label_kor)
                else:
                    self.text_pub.publish(String(f"{self.target_label_kor} 탐지 후 거리 추정 실패"))
            else:
                self.text_pub.publish(String(f"{self.target_label_kor}을 찾을 수 없습니다."))

    def rotate_and_detect(self):
        if not self.rotate_until_detect():
            return False  # 탐지 실패
        return self.align_object_center()

    def rotate_until_detect(self):
        rospy.loginfo("[🔁 회전 중] 객체 탐지 시까지 회전")
        rate = rospy.Rate(10)
        twist = Twist()
        twist.angular.z = 0.3
        start_time = rospy.Time.now()

        while (rospy.Time.now() - start_time).to_sec() < 21.0:  # 최대 회전 시간
            self.cmd_pub.publish(twist)

            if self.latest_image is None:
                rate.sleep()
                continue

            results = self.model(self.latest_image)[0]
            for box in results.boxes.data:
                cls_id = int(box[-1])
                label = self.model.names[cls_id]
                if label == self.target_label:
                    rospy.loginfo(f"[✅ 탐지됨] {label}")
                    self.cmd_pub.publish(Twist())  # 🔴 멈춤1
                    rospy.sleep(1.0)
                    self.text_pub.publish(String(f"{self.target_label_kor}을 찾았습니다."))
                    return True
            rate.sleep()

        self.cmd_pub.publish(Twist())
        return False

    def align_object_center(self):
        rospy.sleep(1.0)
        rospy.loginfo("[🎯 중심 정렬 시작]")
        rate = rospy.Rate(10)
        twist = Twist()
        twist.angular.z = 0.2  # 느리게 회전

        while not rospy.is_shutdown():
            if self.latest_image is None:
                rate.sleep()
                continue

            results = self.model(self.latest_image)[0]
            for box in results.boxes.data:
                cls_id = int(box[-1])
                label = self.model.names[cls_id]
                if label == self.target_label:
                    x1, y1, x2, y2 = box[:4]
                    x_center = (x1 + x2) / 2.0
                    rospy.loginfo(f"[👀 중심 x: {x_center}]")

                    if 315 <= x_center <= 325:
                        self.cmd_pub.publish(Twist())  # 🔴 멈춤2
                        rospy.loginfo("[✅ 중심 정렬 완료]")
                        return True
                    elif x_center < 315:
                        twist.angular.z = 0.15  # 좌회전
                    elif x_center > 325:
                        twist.angular.z = -0.15  # 우회전

                    self.cmd_pub.publish(twist)
                    break
            rate.sleep()

    def estimate_distance(self, y2, cam_height=0.9, fov_v=50.0, image_height=480):
        center_y = image_height / 2.0
        angle_per_pixel = fov_v / image_height
        angle_deg = (y2 - center_y) * angle_per_pixel
        if angle_deg <= 0.1:
            return float('inf')
        theta = math.radians(angle_deg)
        return cam_height / math.tan(theta)

    def get_y2_of_target(self):
        if self.latest_image is None:
            return None

        results = self.model(self.latest_image)[0]
        for box in results.boxes.data:
            cls_id = int(box[-1])
            label = self.model.names[cls_id]
            if label == self.target_label:
                _, _, _, y2 = box[:4]
                return float(y2)
        return None

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

if __name__ == "__main__":
    try:
        FindObject()
    except rospy.ROSInterruptException:
        pass