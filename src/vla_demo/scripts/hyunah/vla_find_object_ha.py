#!/usr/bin/env python3
import rospy
import json
import tf
import math
import cv2
import actionlib
import numpy as np
from std_msgs.msg import String
from sensor_msgs.msg import Image
from geometry_msgs.msg import Twist
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal, MoveBaseActionGoal
from cv_bridge import CvBridge
from ultralytics import YOLO

class FindObject:
    def __init__(self):
        rospy.init_node('find_object_node')

        self.latest_image = None
        self.target_label = None
        self.target_color = None

        self.model = YOLO("yolov8n.pt")  # 기본 YOLOv8n 모델
        self.bridge = CvBridge()

        dummy = 255 * np.ones((480, 640, 3), dtype=np.uint8)
        _ = self.model(dummy)[0]
        rospy.loginfo("✅ YOLO 모델 워밍업 완료")

        rospy.Subscriber("/camera2/usb_cam2/image_raw", Image, self.image_callback)
        rospy.Subscriber("/robot_assistant/navigation/request", String, self.goal_callback)

        self.goal_pub = rospy.Publisher("/move_base/goal", MoveBaseActionGoal, queue_size=1)
        self.cmd_pub = rospy.Publisher("/cmd_vel", Twist, queue_size=1)
        self.text_pub = rospy.Publisher("/robot_assistant/text/speak", String, queue_size=1)

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
            self.target_label = data["label"].strip().lower()
            self.target_color = data.get("color", "").strip().lower()

            rospy.loginfo(f"[🧭 명령 수신] label: {self.target_label}, color: {self.target_color}, pose: {pose}")
            self.move_to(pose)
        except Exception as e:
            rospy.logerr(f"[❌ JSON 파싱 실패] {e}")

    def is_target_color(self, image, box):
        if not self.target_color:
            return True  # 색상 조건 없으면 통과

        x1, y1, x2, y2 = map(int, box[:4])
        roi = image[y1:y2, x1:x2]
        if roi.size == 0:
            return False

        hsv = cv2.cvtColor(roi, cv2.COLOR_BGR2HSV)
        color_ranges = {
            "pink": ([140, 50, 50], [170, 255, 255]),
            "blue": ([100, 50, 50], [130, 255, 255]),
            "red": ([0, 70, 50], [10, 255, 255]),
            "green": ([40, 40, 40], [80, 255, 255]),
            "yellow": ([20, 100, 100], [35, 255, 255]),
        }

        if self.target_color not in color_ranges:
            rospy.logwarn(f"[⚠️ 색상 미정의] {self.target_color}")
            return False

        lower, upper = map(np.array, color_ranges[self.target_color])
        mask = cv2.inRange(hsv, lower, upper)
        ratio = cv2.countNonZero(mask) / (roi.shape[0] * roi.shape[1])
        return ratio > 0.2

    def detect_label(self):
        if self.latest_image is None:
            return False
        results = self.model(self.latest_image)[0]
        for r in results.boxes.data:
            cls_id = int(r[-1])
            label = self.model.names[cls_id].lower()
            if label == self.target_label and self.is_target_color(self.latest_image, r):
                rospy.loginfo(f"[✅ 탐지됨] {label} ({self.target_color})")
                return True
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

        self.client.send_goal(goal)
        self.client.wait_for_result()
        rospy.sleep(1.0)

        if self.detect_label():
            self.text_pub.publish(String(f"{self.target_color}색 {self.target_label}가 보입니다."))
        else:
            self.text_pub.publish(String(f"{self.target_color}색 {self.target_label}가 보이지 않습니다. 주변을 살펴보겠습니다."))
            if self.rotate_and_detect():
                y2 = self.get_y2_of_target()
                if y2:
                    distance = self.estimate_distance(y2)
                    self.publish_offset_goal(distance)
                else:
                    self.text_pub.publish(String("거리 추정 실패"))
            else:
                self.text_pub.publish(String(f"{self.target_color}색 {self.target_label}를 찾을 수 없습니다."))

    def rotate_and_detect(self):
        return self.rotate_until_detect() and self.align_object_center()

    def rotate_until_detect(self):
        rate = rospy.Rate(10)
        twist = Twist()
        twist.angular.z = 0.3
        start_time = rospy.Time.now()
        while (rospy.Time.now() - start_time).to_sec() < 20.0:
            self.cmd_pub.publish(twist)
            if self.latest_image is not None:
                results = self.model(self.latest_image)[0]
                for box in results.boxes.data:
                    cls_id = int(box[-1])
                    label = self.model.names[cls_id].lower()
                    if label == self.target_label and self.is_target_color(self.latest_image, box):
                        self.cmd_pub.publish(Twist())
                        rospy.sleep(1.0)
                        return True
            rate.sleep()
        self.cmd_pub.publish(Twist())
        return False

    def align_object_center(self):
        rate = rospy.Rate(10)
        twist = Twist()
        while not rospy.is_shutdown():
            if self.latest_image is None:
                rate.sleep()
                continue
            results = self.model(self.latest_image)[0]
            for box in results.boxes.data:
                cls_id = int(box[-1])
                label = self.model.names[cls_id].lower()
                if label == self.target_label and self.is_target_color(self.latest_image, box):
                    x1, y1, x2, y2 = box[:4]
                    x_center = (x1 + x2) / 2.0
                    if 310 <= x_center <= 330:
                        self.cmd_pub.publish(Twist())
                        return True
                    elif x_center < 310:
                        twist.angular.z = 0.15
                    else:
                        twist.angular.z = -0.15
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
            label = self.model.names[cls_id].lower()
            if label == self.target_label and self.is_target_color(self.latest_image, box):
                return float(box[3])
        return None

    def publish_offset_goal(self, distance, offset=0.3):
        goal_x_base = distance - offset
        if goal_x_base <= 0.2:
            rospy.logwarn("너무 가까워서 이동 생략")
            return
        listener = tf.TransformListener()
        listener.waitForTransform("/map", "/base_link", rospy.Time(0), rospy.Duration(3.0))
        (trans, rot) = listener.lookupTransform("/map", "/base_link", rospy.Time(0))
        yaw = tf.transformations.euler_from_quaternion(rot)[2]
        goal_x = trans[0] + goal_x_base * math.cos(yaw)
        goal_y = trans[1] + goal_x_base * math.sin(yaw)

        goal = MoveBaseGoal()
        goal.target_pose.header.frame_id = "map"
        goal.target_pose.header.stamp = rospy.Time.now()
        goal.target_pose.pose.position.x = goal_x
        goal.target_pose.pose.position.y = goal_y
        goal.target_pose.pose.orientation.x = rot[0]
        goal.target_pose.pose.orientation.y = rot[1]
        goal.target_pose.pose.orientation.z = rot[2]
        goal.target_pose.pose.orientation.w = rot[3]

        self.client.send_goal(goal)
        rospy.loginfo(f"[🚶 정밀이동] → ({goal_x:.2f}, {goal_y:.2f})")
        success = self.client.wait_for_result(rospy.Duration(30.0))
        if success:
            self.text_pub.publish(String(f"{self.target_color}색 {self.target_label} 앞으로 이동 완료"))

if __name__ == "__main__":
    try:
        FindObject()
    except rospy.ROSInterruptException:
        pass
