#!/usr/bin/env python
# coding: utf-8

import rospy
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
import cv2
from ultralytics import YOLO
import numpy as np

class YoloOverlayPublisher:
    def __init__(self):
        rospy.init_node("yolo_overlay_publisher", anonymous=True)

        self.bridge = CvBridge()
        self.model = YOLO("/home/nvidia/yolov8n.pt")  # 경로는 상황에 맞게 수정
        self.model.to("cuda")  # 필요 시 'cuda'로 변경 가능

        # ROS 통신
        self.image_sub = rospy.Subscriber("/camera2/usb_cam2/image_raw", Image, self.image_callback, queue_size=1)
        self.overlay_pub = rospy.Publisher("/camera2/yolo_overlay/image", Image, queue_size=1)

        rospy.loginfo("YOLO Overlay Publisher 노드 시작됨.")

    def image_callback(self, msg):
        try:
            frame = self.bridge.imgmsg_to_cv2(msg, desired_encoding='bgr8')
        except Exception as e:
            rospy.logerr(f"이미지 변환 실패: {e}")
            return

        # YOLO 객체 탐지
        results = self.model.predict(frame, verbose=False)
        annotated_frame = results[0].plot()  # 오버레이된 이미지

        # ROS 이미지 메시지로 변환 후 발행
        try:
            overlay_msg = self.bridge.cv2_to_imgmsg(annotated_frame, encoding="bgr8")
            self.overlay_pub.publish(overlay_msg)
        except Exception as e:
            rospy.logerr(f"이미지 발행 실패: {e}")

if __name__ == "__main__":
    try:
        YoloOverlayPublisher()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass
