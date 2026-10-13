#!/usr/bin/env python
# coding: utf-8

import rospy
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
from std_msgs.msg import String, Int32
import cv2
import os
from ultralytics import YOLO
from geometry_msgs.msg import PoseWithCovarianceStamped

class YoloChairCapture:
    def __init__(self):
        rospy.init_node('yolo_chair_capture')

        # 모델 로딩
        self.model = YOLO("yolov8n.pt")
        # self.model.to("cuda")  # 필요 시 'cpu'로 명시

        # 토픽 구독
        self.bridge = CvBridge()
        self.capture_done = False
        self.fire_ext_count = 0
        self.latest_pose = None

        self.image_sub = rospy.Subscriber('/camera2/usb_cam2/image_raw', Image, self.image_callback)
        self.pose_sub = rospy.Subscriber('/amcl_pose', PoseWithCovarianceStamped, self.pose_callback)
        self.move_status_sub = rospy.Subscriber('/move_request_status', String, self.move_status_callback)

        self.capture_pub = rospy.Publisher('/capture_status', String, queue_size=10)
        self.move_pub = rospy.Publisher('/move_request', Int32, queue_size=10)
        self.status_pub = rospy.Publisher('/detected_object', String, queue_size=10)

        rospy.loginfo("YOLO Chair Capture Node Initialized.")

    def pose_callback(self, msg):
        self.latest_pose = msg.pose.pose  # geometry_msgs/Pose 타입
        # rospy.loginfo("amcl_pose 수신됨.")

    def move_status_callback(self, msg):
        if "주행" in msg.data:
            rospy.sleep(12.0)
            self.fire_ext_count = 0
            rospy.loginfo("move_request_status 수신됨 → fire_ext_count 초기화됨.")

    def image_callback(self, msg):
        if self.capture_done:
            return

        try:
            # 이미지 메시지를 OpenCV 이미지로 변환
            cv_image = self.bridge.imgmsg_to_cv2(msg, desired_encoding='bgr8')
        except Exception as e:
            rospy.logerr("cv_bridge 변환 실패: %s", e)
            return

        # YOLO 객체 탐지 수행
        results = self.model(cv_image)
        boxes = results[0].boxes
        class_names = self.model.names  # {0: 'person', 1: 'bicycle', ..., 56: 'chair', ...}
        
        for box in boxes:
            class_id = int(box.cls[0])
            class_name = class_names[class_id]
            confidence = float(box.conf[0])

            if class_name == "suitcase" and confidence >= 0.5:
                self.fire_ext_count += 1
                rospy.loginfo(f"suitcase 감지 횟수: {self.fire_ext_count} (신뢰도: {confidence:.2f})")

                if self.fire_ext_count == 10:
                    rospy.loginfo("suitcase 감지 10회 이상 - 이미지 저장 및 동작 수행")

                    save_dir = "/home/nvidia/dconic_nav/src/vla_demo/captured_image"
                    os.makedirs(save_dir, exist_ok=True)
                    img_path = os.path.join(save_dir, "capture.jpg")
                    cv2.imwrite(img_path, cv_image)

                    # self.capture_done = True
                    
                    rospy.loginfo("Image saved to: %s", img_path)

                    self.capture_pub.publish(String("Image captured"))
                    self.move_pub.publish(1)
                    self.status_pub.publish(String("object 발견"))
                    rospy.sleep(3.0)
                    self.status_pub.publish(String("발견 끝"))
                    rospy.loginfo("Published move request: 1")
                    # rospy.sleep(13.0)
                    

                    if self.latest_pose:
                        pos = self.latest_pose.position
                        ori = self.latest_pose.orientation
                        with open(os.path.join(save_dir, "pose.txt"), "w") as f:
                            f.write(f"{pos.x:.3f}, {pos.y:.3f}, {pos.z:.3f}, {ori.x:.3f}, {ori.y:.3f}, {ori.z:.3f}, {ori.w:.3f}\n")
                        rospy.loginfo(f"[📍AMCL 위치 저장됨] x: {pos.x:.2f}, y: {pos.y:.2f}, z: {pos.z:.2f}")
                    else:
                        rospy.logwarn("📭 amcl_pose 아직 수신되지 않음.")

                break  # 한 프레임에서 여러 개 감지되어도 1회만 증가

if __name__ == '__main__':
    try:
        node = YoloChairCapture()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass
