#!/usr/bin/env python3
import rospy
import cv2
import os
import logging
from datetime import datetime
from sensor_msgs.msg import Image
from std_msgs.msg import Int32
from cv_bridge import CvBridge

bridge = CvBridge()
CAPTURE_AT = [9, 14, 23]
ROOT_DIR = "/home/nvidia/images"
SESSION_DIR = os.path.join(ROOT_DIR, datetime.now().strftime('%Y-%m-%d'))
os.makedirs(SESSION_DIR, exist_ok=True)
latest_frame = None

logging.basicConfig(
    filename='/home/nvidia/capture_debug.log',
    level=logging.DEBUG,
    format='%(asctime)s %(message)s'
)

def image_cb(msg):
    global latest_frame
    try:
        latest_frame = bridge.imgmsg_to_cv2(msg, "bgr8")
    except Exception as e:
        logging.warning(f"이미지 변환 실패: {e}")

def capture(waypoint_num):
    global latest_frame
    for _ in range(20):
        if latest_frame is not None:
            break
        logging.info("프레임 대기 중...")
        rospy.sleep(0.1)

    if latest_frame is None:
        logging.warning("저장 실패: 수신된 이미지 없음")
        rospy.logwarn("저장 실패: 수신된 이미지 없음")
        return

    now_time = datetime.now().strftime('%H%M%S')
    filename = os.path.join(SESSION_DIR, f"{now_time}.jpg")
    cv2.imwrite(filename, latest_frame)
    logging.info(f"저장 완료: {filename}")
    rospy.loginfo(f"저장 완료: {filename}")

def capture_trigger_cb(msg):
    arrived = msg.data
    logging.info(f"Waypoint {arrived} 도달")
    if arrived in CAPTURE_AT:
        logging.info(f"→ 촬영! waypoint {arrived}")
        capture(arrived)

if __name__ == "__main__":
    rospy.init_node("waypoint_camera_capture")
    rospy.Subscriber("/camera1/usb_cam1/image_raw", Image, image_cb)
    rospy.Subscriber("/capture_trigger", Int32, capture_trigger_cb)
    logging.info("노드 시작")
    rospy.loginfo(f"노드 시작 | 저장 경로: {SESSION_DIR}")
    rospy.spin()