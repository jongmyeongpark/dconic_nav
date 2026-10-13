#!/usr/bin/env python3
import rospy
import json
import openai
import re
from std_msgs.msg import String
import tf

openai.api_key = "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"  # GPT API 키

class QuestionQurey:
    def __init__(self):
        rospy.init_node('question_query')
        self.json_path = "/home/nvidia/dconic_nav/src/vla_demo/captured_data.json"

        self.text = None
        self.pending_pose = None
        self.pending_text = None

        self.tts_pub = rospy.Publisher("/event_speech", String, queue_size=1)
        self.gpt_fap_pub = rospy.Publisher("/robot_assistant/gpt/chat", String, queue_size=1)
        self.text_tts_pub = rospy.Publisher("/robot_assistant/text/speak", String, queue_size=1)

        self.goal_pub = rospy.Publisher("/robot_assistant/navigation/request", String, queue_size=1)

        rospy.Subscriber("/robot_assistant/gpt/chat_vla", String, self.input_callback)
        rospy.loginfo("Subscribed to /robot_assistant/gpt/chat_vla topic.")
        rospy.spin()

    def publish_goal_request(self, pose_dict, label):
        msg = {
            "pose": pose_dict,
            "label": label
        }
        self.goal_pub.publish(String(json.dumps(msg)))
        rospy.loginfo(f"[📤 이동 요청 전송] {msg}")


    def input_callback(self, msg):
        question = msg.data.strip()
        rospy.loginfo(f'사용자 질문: {question}')

        if not question:
            rospy.logwarn("빈 질문 수신됨")
            return

        # pending 상태에서 먼저 처리
        if self.pending_pose:
            gpt_response = self.interpret_user_response(question)
            if gpt_response and "response: yes" in gpt_response:
                rospy.loginfo(f"GPT 판단: 긍정 → {self.pending_text}로 이동")
                self.text_tts_pub.publish(String("네, 알겠습니다. 이동하겠습니다."))
                self.text = self.pending_text
                self.tts_pub.publish("vla_0000")
                self.publish_goal_request(self.pending_pose, self.pending_text)
            else:
                rospy.loginfo("GPT 판단: 부정 또는 불확실 → 이동 취소")
                self.text_tts_pub.publish(String("네 알겠습니다. 이동하지 않겠습니다."))
            self.pending_pose = None
            self.pending_text = None
            return

        # 새로운 질문 처리
        with open(self.json_path, 'r') as f:
            data = json.load(f)

        frame_to_caption = {k: v["caption"] for k, v in data.items()}
        gpt_response = self.analyze_question(question, frame_to_caption)

        if not gpt_response:
            rospy.logwarn("GPT 응답 없음")
            return

        if "mode:" not in gpt_response:
            rospy.logwarn("GPT 응답에 mode: 정보가 없음")
            self.text_tts_pub.publish(String("질문을 잘 이해하지 못했어요. 다시 한 번 말씀해 주세요."))
            return

        # === move 모드 ===
        if "mode: move" in gpt_response:
            rospy.loginfo("---move mode---")
            frame_match = re.search(r"frame:\s*(\S+)", gpt_response)
            target_match = re.search(r"target:\s*(.*)", gpt_response)
            reason_match = re.search(r"reason:\s*(.*)", gpt_response)

            if not target_match:
                rospy.logwarn("❗ move 모드인데 target 없음")
                self.text = "알 수 없는 장소"
            else:
                self.text = target_match.group(1).strip()

            self.move_reason = reason_match.group(1).strip() if reason_match else "이유 없음"

            rospy.loginfo(f'핵심 단어(move): {self.text}')
            frame_id = frame_match.group(1)
            rospy.loginfo(f"frame: {frame_id}")
            rospy.loginfo(f'선택된 이유(move): {self.move_reason}')

            if frame_match:
                frame_id = frame_match.group(1)
                if frame_id in data:
                    self.tts_pub.publish("vla_0000")
                    self.publish_goal_request(data[frame_id], self.text)
                else:
                    rospy.logwarn(f"frame_id '{frame_id}'는 JSON에 없음")

        # === chat 모드 ===
        elif "mode: chat" in gpt_response:
            rospy.loginfo("---chat mode---")
            self.gpt_fap_pub.publish(String(question))

        # === unclear 모드 ===
        elif "mode: unclear" in gpt_response:
            frame_match = re.search(r"frame:\s*(\S+)", gpt_response)
            target_match = re.search(r"target:\s*(.*)", gpt_response)
            reason_match = re.search(r"reason:\s*(.*)", gpt_response)
            answer_match = re.search(r"answer:\s*(.*)", gpt_response, re.DOTALL)
            clarify_match = re.search(r"clarify:\s*(.*)", gpt_response, re.DOTALL)

            if frame_match and frame_match.group(1) in data:
                self.pending_pose = data[frame_match.group(1)]

                if not target_match:
                    rospy.logwarn("❗ unclear 모드인데 target 없음")
                    self.pending_text = "알 수 없는 장소"
                else:
                    self.pending_text = target_match.group(1).strip()

                self.pending_reason = reason_match.group(1).strip() if reason_match else "이유 없음"

                rospy.loginfo(f"핵심 단어(unclear): {self.pending_text}")
                frame_id = frame_match.group(1)
                rospy.loginfo(f"frame: {frame_id}")
                rospy.loginfo(f"선택된 이유(unclear): {self.pending_reason}")


                if answer_match:
                    answer_text = answer_match.group(1).strip()
                    #clarify가 끼어 있으면 잘라내기
                    if 'clarify:' in answer_text:
                        answer_text = answer_text.split('clarify:')[0].strip()
                    # self.text_tts_pub.publish(String(answer_text))
                    # rospy.sleep(2.5)

                if clarify_match:
                    self.text_tts_pub.publish(String(clarify_match.group(1).strip()))

            else:
                rospy.logwarn("unclear인데 frame 정보가 부족합니다.")

        else:
            rospy.logwarn(f"예상치 못한 GPT 응답:\n{gpt_response}")


    def interpret_user_response(self, user_input):
        prompt = (
            "이전 질문에 대한 사용자의 응답을 해석해주세요.\n\n"
            "만약 사용자가 긍정적인 의도로 이동을 수락했다면 → response: yes\n"
            "만약 사용자가 거절하거나 부정적인 의사라면 → response: no\n\n"
            f"응답: \"{user_input}\"\n"
            "→ 결과를 response: yes 또는 response: no 형태로만 출력하세요."
        )

        messages = [
            {"role": "system", "content": "너는 사용자의 응답이 긍정인지 부정인지 판단하는 어시스턴트야."},
            {"role": "user", "content": prompt}
        ]

        try:
            response = openai.ChatCompletion.create(
                model="gpt-4o-mini",
                messages=messages
            )
            return response["choices"][0]["message"]["content"]
        except Exception as e:
            rospy.logerr(f"GPT 응답 해석 실패: {e}")
            return None

    def analyze_question(self, question, frame_to_caption):
        prompt = (
            "사용자의 질문을 보고 아래 규칙에 따라 정확히 판단하세요.\n\n"
            "1. 질문이 단순한 정보 문의이거나 위치만 궁금한 경우 → 'mode: chat'\n"
            "2. 로봇이 실제로 물리적으로 이동해야 한다는 명확한 명령이 있을 경우 → 'mode: move'\n"
            "3. 질문이 애매하여 이동이 필요한지 확실하지 않은 경우 → 'mode: unclear'\n\n"
            "※ 중요 규칙 ※\n"
            "- move, unclear 모드 모두 반드시 frame_000X를 하나 선택하세요.\n"
            "- 만약 관련 frame이 전혀 없다면 'frame: none'으로 명시하세요.\n"
            "- move, unclear 모드일 경우 반드시 target도 작성하세요 (예: reception, fire extinguisher, refrigerator 등).\n"
            "- target은 반드시 사용자의 질문에 명시된 핵심 장소 또는 사물과 정확히 일치해야 합니다.\n"
            "- 예: 사용자가 '의자'라고 질문했다면 target은 반드시 '의자'여야 하며, '리셉션' 등으로 바꾸지 마세요.\n"
            "- move 모드일 경우 반드시 reason을 작성하세요 (왜 이 frame을 골랐는지).\n"
            "- unclear 모드일 경우에도 반드시 reason을 작성하세요 (왜 이 frame을 골랐는지).\n"
            "- reason은 **선택한 frame 내부의 구체적인 시각적/언어적 요소**를 근거로 작성하세요.\n"
            "- 절대 '관련이 깊어서', '연관이 있어 보여서' 같은 모호한 표현만 쓰지 마세요.\n"
            "- reason에는 반드시 캡션에 근거한 구체적인 정보가 포함되어야 합니다. (예: '화장실'이라는 문구가 보인다, 정수기 사진이 있다 등)\n"
            "- mode가 unclear인 이유는 절대로 reason에 작성하지 마세요. reason은 frame 선택 이유만 설명해야 합니다.\n"
            "- answer에는 절대로 clarify 문장을 포함하지 마세요.\n"
            "- clarify는 이동 여부를 묻는 문장만 단독으로 작성하세요.\n"
            "- target과 reason은 절대로 헷갈리지 말고 각각 정확히 작성하세요.\n"
            "- target은 프레임에 해당하는 구체적인 장소 이름이어야 합니다. (예: fire extinguisher, refrigerator, reception)\n"
            "- answer는 사용자의 질문에 대한 설명만 담고, clarify는 이동 질문만 담아야 합니다.\n\n"
            "- 예시로 사용자의 질문에 목이 마르다거나 물이 있는 곳이 어디냐고 물어보면 refrigerator가 핵심 단어로 들어가야 합니다.\n"
            "- 예시로 사용자의 질문에 배송로봇이라는 단어가 들어가면 핵심 단어는 Mo2로 들어가야합니다.\n"
            "- 예시로 사용자의 질문에 모빌리티라는 단어가 들어가면 핵심 단어는 Cubrick으로 들어가야합니다.\n"
            "- 예시로 사용자의 질문에 로봇 팔이라는 단어가 들어가면 핵심 단어는 Vstella로 들어가야합니다.\n"
            "- 예시로 사용자의 질문에 충전소라는 단어가 들어가면 핵심 단어는 charging station으로 들어가야합니다.\n"
            "- 예시로 사용자의 질문에 불, 소화기라는 단어가 들어가면 핵심 단어는 fire extinguisher으로 들어가야합니다.\n"
            "- 예시로 사용자의 질문에 식물, 꽃이라는 단어가 들어가면 핵심 단어는 plant로 들어가야합니다.\n"
            "예시:\n"
            "질문: '소화기는 어디 있어?' → mode: unclear\n"
            "질문: '소화기로 안내해줘' → mode: move\n"
            "질문: '리셉션으로 가자' → mode: move\n"
            "질문: 'INTIGRAT는 뭐야?' → mode: chat\n"
            "질문: '의자로 안내해줘' → mode: move\n\n"
            "이동 모드 예시:\n"
            "mode: move\n"
            "frame: frame_0001\n"
            "target: reception\n"
            "reason: frame_0001에는 'INTIGRAT'라는 글씨가 리셉션 벽에 써 있고, 로봇이 위치한 리셉션 책상 앞이 잘 보이기 때문입니다.\n\n"
            "mode: move\n"
            "frame: frame_0008\n"
            "target: chair\n"
            "reason: frame_0008에는 의자가 전면에 잘 보이고, 사용자가 요청한 장소인 의자가 명확히 인식되기 때문입니다.\n\n"
            "대화 모드 예시:\n"
            "mode: chat\n"
            "answer: INTIGRAT는 서울 강남구에 위치한 회사입니다.\n\n"
            "unclear 모드 예시:\n"
            "mode: unclear\n"
            "frame: frame_0000\n"
            "target: fire extinguisher\n"
            "reason: frame_0000에는 빨간색 소화기가 벽면에 놓여 있고, 주변에 'FIRE EXTINGUISHER'라고 적혀 있기 때문입니다.\n"
            "answer: 소화기는 출입구 옆 벽에 있습니다.\n"
            "clarify: 소화기 위치로 이동해드릴까요?\n\n"
            "unclear 모드 예시:\n"
            "mode: unclear\n"
            "frame: frame_0005\n"
            "target: refrigerator\n"
            "reason: frame_0005에는 커피 머신과 냉장고, 정수기가 있어 물을 제공할 가능성이 있습니니다.\n"
            "answer: 물은 주방공간에 있는 정수기에서 먹을 수 있습니다.\n"
            "clarify: 냉장고 위치로 이동해드릴까요?\n\n"
            "관련 frame이 없는 경우 예시:\n"
            "mode: unclear\n"
            "frame: none\n"
            "reason: 질문과 직접적으로 관련된 사물이나 위치를 찾지 못했습니다.\n"
            "answer: 정확한 위치를 파악할 수 없습니다.\n"
            "clarify: 이동을 도와드릴까요?\n\n"
            f"질문: {question}\n\n"
            "이미지 캡션 목록:\n"
        )


        for frame_id, caption in frame_to_caption.items():
            prompt += f"{frame_id}: {caption.strip()}\n\n"

        messages = [
            {"role": "system", "content": "너는 사용자의 질문이 '이동' 관련인지 '일반 대화'인지 구분하고, unclear일 경우 답변과 clarify 질문도 함께 출력하는 어시스턴트야."},
            {"role": "user", "content": prompt}
        ]

        try:
            response = openai.ChatCompletion.create(
                model="gpt-4o-mini",
                messages=messages
            )
            return response["choices"][0]["message"]["content"]
        except Exception as e:
            rospy.logerr(f"GPT 분석 실패: {e}")
            return None


if __name__ == "__main__":
    try:
        QuestionQurey()
    except rospy.ROSInterruptException:
        pass