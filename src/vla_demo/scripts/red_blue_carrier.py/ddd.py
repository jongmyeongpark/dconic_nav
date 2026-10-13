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

# ✅ OpenAI API 키 설정
openai.api_key = "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"  # 실제 키로 교체 필요

class GptYoloOverlayNode:
    def __init__(self):
        rospy.init_node("gpt_yolo_overlay_node")

        self.bridge = CvBridge()
        self.latest_image = None
        self.overlay_image = None

        # YOLO 모델 로드
        self.model = YOLO("yolov8n.pt")  # 또는 커스텀 모델 경로

        # 이미지 구독 및 발행
        self.image_sub = rospy.Subscriber('/camera2/usb_cam2/image_raw', Image, self.image_callback)
        self.overlay_pub = rospy.Publisher('/camera2/yolo_overlay/image', Image, queue_size=1)
        self.response_pub = rospy.Publisher("/gpt_response", String, queue_size=10)
        self.text_sub = rospy.Subscriber("/robot_assistant/gpt/chat_vla", String, self.input_callback)

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

        # 이미지 저장 + 퍼블리시
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
        rospy.loginfo("질문 수신됨 → GPT 분석 요청 진행")

        if self.latest_image is None:
            rospy.logwarn("아직 수신된 이미지가 없습니다.")
            return

        try:
            os.makedirs(self.image_save_path, exist_ok=True)
            img_file_path = os.path.join(self.image_save_path, "capture.jpg")
            cv2.imwrite(img_file_path, self.latest_image)
            rospy.loginfo(f"GPT용 이미지 저장됨: {img_file_path}")
        except Exception as e:
            rospy.logerr(f"이미지 저장 실패: {e}")
            return

        try:
            with open(img_file_path, "rb") as f:
                image_base64 = base64.b64encode(f.read()).decode("utf-8")
        except Exception as e:
            rospy.logerr(f"이미지 base64 인코딩 실패: {e}")
            return

        try:
            prompt_text = (
                "너는 실내에서 주행하는 로봇이야. "
                "사진을 보고 너가 주행하는데에 있어 걸리는 부분을 얘기해줘. "
                "바닥에 객체들이 있으면 사진의 어느 방향에 어떤 색의 어떤 객체가 있는지 설명해줘. "
                "예를 들어 바닥의 왼쪽에 파란색 캐리어가 있고 오른쪽에 분홍색 캐리어가 있으면, "
                "'왼쪽에는 파란색의 캐리어가 있고 오른쪽에는 분홍색 캐리어가 있습니다.' 라고 답변해줘."
            )

            response = openai.ChatCompletion.create(
                model="gpt-4o",
                messages=[
                    {
                        "role": "user",
                        "content": [
                            {"type": "text", "text": prompt_text},
                            {"type": "image_url", "image_url": {
                                "url": f"data:image/jpeg;base64,{image_base64}"
                            }}
                        ]
                    }
                ],
                max_tokens=500
            )

            description = response["choices"][0]["message"]["content"].strip()
            rospy.loginfo(f"[GPT 응답]: {description}")
            self.response_pub.publish(String(description))

        except Exception as e:
            rospy.logerr(f"GPT 요청 실패: {e}")

if __name__ == '__main__':
    try:
        GptYoloOverlayNode()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass
