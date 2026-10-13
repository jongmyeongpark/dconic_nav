#!/usr/bin/env python
# coding: utf-8

import rospy
from std_msgs.msg import String
import openai
import os
import base64

# OpenAI API 키 설정
openai.api_key = "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"

class GptImageDescriber:
    def __init__(self):
        rospy.init_node('gpt_image_describer')

        self.image_path = "/home/nvidia/dconic_nav/src/vla_demo/captured_image/capture.jpg"

        # ROS 토픽
        self.sub = rospy.Subscriber('/capture_status', String, self.capture_callback)
        self.pub = rospy.Publisher('/gpt_response', String, queue_size=10)

        rospy.loginfo("GPT Image Describer Node Initialized.")

    def capture_callback(self, msg):
        if msg.data != "Image captured":
            return

        if not os.path.exists(self.image_path):
            rospy.logerr("이미지 파일이 존재하지 않습니다: %s", self.image_path)
            return

        rospy.loginfo("이미지 분석 요청 중...")

        try:
            with open(self.image_path, "rb") as image_file:
                image_data = base64.b64encode(image_file.read()).decode("utf-8")

            # GPT API 호출 (openai 0.28 방식)
            response = openai.ChatCompletion.create(
                model="gpt-4o",  # 또는 "gpt-4o" (지원 시)
                messages=[
                    {
                        "role": "user",
                        "content": [
                            {"type": "text", "text":
                                "이 이미지는 로봇의 전방에 달린 카메라의 사진이야. "
                                "로봇은 주행을 하는데 앞에 가로막히는 물건이 있는지 확인해야돼. "
                                "로봇이 주행하는데 앞을 가로막는 물건이 있으면 그 물건의 이름을 응답으로 말해줘. "
                                "예를 들어, 바닥이나 정면에 캐리어가 있으면 suitcase 라고 응답해줘."
                                "반드시 객체이름만 응답해야돼."
                             },
                            {"type": "image_url",
                             "image_url": {
                                 "url": f"data:image/jpeg;base64,{image_data}"
                             }}
                        ]
                    }
                ],
                max_tokens=300
            )

            description = response['choices'][0]['message']['content'].strip()
            rospy.loginfo("GPT 응답: %s", description)

            msg = String()
            msg.data = description
            self.pub.publish(msg)
            rospy.loginfo("/gpt_response 토픽으로 발행 완료.")

        except Exception as e:
            rospy.logerr("GPT 요청 실패: %s", e)

if __name__ == '__main__':
    try:
        GptImageDescriber()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass
