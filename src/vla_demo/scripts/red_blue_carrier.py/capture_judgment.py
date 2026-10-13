#!/usr/bin/env python
# coding: utf-8

import rospy
from std_msgs.msg import String
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
import openai
import cv2
import base64
import os

openai.api_key = "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"

class GptImageCaptionNode:
    def __init__(self):
        rospy.init_node("gpt_image_caption_node")

        self.bridge = CvBridge()
        self.latest_image = None

        # 이미지 수신
        self.image_sub = rospy.Subscriber('/camera2/usb_cam2/image_raw', Image, self.image_callback)
        # 질문 수신
        self.text_sub = rospy.Subscriber("/robot_assistant/gpt/chat_vla", String, self.input_callback)
        # GPT 응답 발행
        self.pub = rospy.Publisher("/gpt_response", String, queue_size=10)

        # 이미지 저장 경로
        self.image_save_path = "/home/nvidia/dconic_nav/src/vla_demo/captured_image"
        rospy.loginfo("GptImageCaptionNode initialized.")

    def image_callback(self, msg):
        try:
            self.latest_image = self.bridge.imgmsg_to_cv2(msg, desired_encoding="bgr8")
        except Exception as e:
            rospy.logerr(f"이미지 수신/변환 실패: {e}")

    def input_callback(self, msg):
        rospy.loginfo("질문 수신됨: 이미지를 캡처하고 GPT에게 분석을 요청합니다.")

        # 최신 이미지 확인
        if self.latest_image is None:
            rospy.logwarn("아직 수신된 이미지가 없습니다.")
            return

        # 이미지 저장
        try:
            os.makedirs(self.image_save_path, exist_ok=True)
            img_file_path = os.path.join(self.image_save_path, "capture.jpg")
            cv2.imwrite(img_file_path, self.latest_image)
            rospy.loginfo(f"이미지 저장됨: {img_file_path}")
        except Exception as e:
            rospy.logerr(f"이미지 저장 실패: {e}")
            return

        # base64 인코딩
        try:
            with open(img_file_path, "rb") as f:
                image_base64 = base64.b64encode(f.read()).decode("utf-8")
        except Exception as e:
            rospy.logerr(f"이미지 파일 열기 실패: {e}")
            return

        # GPT 요청 - 고정된 프롬프트 사용
        try:
            prompt_text = "너는 실내에서 주행하는 로봇이야." \
            "사진을 보고 너가 주행하는데에 있어 걸리는 부분을 얘기해줘" \
            "바닥에 객체들이 있으면 사진의 어느 방향에 어떤 색의 어떤 객체가 있는지 설명해줘." \
            "예를 들어 바닥의 왼쪽에 파란색 캐리어가 있고 오른쪽에 분홍색 캐리어가 있으면" \
            "답변을 왼쪽:파란색 오른쪽:분홍색 이렇게 응답해줘." \
            "만약 바닥에 장애물처럼 보이는 것이 없으면 장애물 미감지 라고 답변해줘"

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
            self.pub.publish(String(description))

        except Exception as e:
            rospy.logerr(f"GPT 요청 실패: {e}")

if __name__ == '__main__':
    try:
        GptImageCaptionNode()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass