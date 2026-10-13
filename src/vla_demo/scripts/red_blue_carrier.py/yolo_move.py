#!/usr/bin/env python
# coding: utf-8

import rospy
from sensor_msgs.msg import Image
from std_msgs.msg import String
from cv_bridge import CvBridge
import cv2
from ultralytics import YOLO

class YoloDirectionFilteredNode:
    def __init__(self):
        rospy.init_node("yolov8_direction_filtered_node")

        self.bridge = CvBridge()
        self.model = YOLO("yolov8n.pt")

        self.color_direction_map = {}  # 예: {"왼쪽": "파란색", "오른쪽": "분홍색"}
        self.target_direction = None   # 최종 선택된 방향 ("왼쪽" 또는 "오른쪽")

        self.image_sub = rospy.Subscriber("/camera2/usb_cam2/image_raw", Image, self.image_callback)
        self.gpt_response_sub = rospy.Subscriber("/gpt_response", String, self.gpt_response_callback)
        self.chat_sub = rospy.Subscriber("/robot_assistant/gpt/chat_vla", String, self.chat_callback)
        self.image_pub = rospy.Publisher("/yolov8/overlay_image", Image, queue_size=10)

        rospy.loginfo("YOLOv8 Direction Filtered Node Started.")

    def gpt_response_callback(self, msg):
        text = msg.data
        self.color_direction_map.clear()

        # 예: "왼쪽 : 파란색 캐리어, 오른쪽 : 분홍색 캐리어"
        directions = ["왼쪽", "오른쪽"]
        for direction in directions:
            if direction in text:
                try:
                    part = text.split(direction)[1]
                    color = part.split("캐리어")[0].replace(":", "").replace("의", "").strip()
                    self.color_direction_map[direction] = color
                except Exception as e:
                    rospy.logwarn(f"[GPT 응답 파싱 오류] {e}")
        rospy.loginfo(f"[GPT 응답 처리 완료] 방향-색상 매핑: {self.color_direction_map}")

    def chat_callback(self, msg):
        # 예: "분홍색 캐리어 앞으로 가줘"
        chat_text = msg.data
        for direction, color in self.color_direction_map.items():
            if color in chat_text:
                self.target_direction = direction
                rospy.loginfo(f"[지시 수신] '{color}' → '{direction}' 방향 감지 설정")
                return

    def image_callback(self, msg):
        try:
            frame = self.bridge.imgmsg_to_cv2(msg, "bgr8")
            results = self.model(frame)[0]
            overlay = frame.copy()

            # 항상 YOLO 추론은 실행됨
            suitcase_boxes = [box for box in results.boxes
                            if self.model.names[int(box.cls[0])] == "suitcase"]

            # 조건이 설정된 경우에만 특정 방향 필터링
            if self.target_direction and suitcase_boxes:
                if self.target_direction == "오른쪽":
                    target_box = max(suitcase_boxes, key=lambda b: b.xyxy[0][0])
                elif self.target_direction == "왼쪽":
                    target_box = min(suitcase_boxes, key=lambda b: b.xyxy[0][0])
                else:
                    target_box = None

                if target_box is not None:
                    overlay = target_box.plot(overlay)
            else:
                # 조건 설정 안된 경우 → 바운딩박스 없이 원본 출력
                pass  # overlay 그대로 사용

            # 항상 이미지 발행
            ros_overlay = self.bridge.cv2_to_imgmsg(overlay, encoding="bgr8")
            self.image_pub.publish(ros_overlay)

        except Exception as e:
            rospy.logerr(f"[YOLO 처리 오류] {e}")


if __name__ == '__main__':
    try:
        YoloDirectionFilteredNode()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass
