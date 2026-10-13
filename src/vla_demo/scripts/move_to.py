#!/usr/bin/env python
# coding: utf-8

import rospy
from std_msgs.msg import String, Int32
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
from ultralytics import YOLO
import json
import os
import threading

class GptResponseHandler:
    def __init__(self):
        rospy.init_node("gpt_response_handler")

        self.bridge = CvBridge()
        self.latest_image = None

        # YOLO 모델 로드
        self.model = YOLO("yolov8n.pt")
        # self.model.to("cuda")

        self.label_kor_map = {
            "suitcase": "캐리어"
        }

        self.awaiting_lost_item_confirmation = False
        self.latest_result = None

        # 토픽 구독 및 발행
        self.image_sub = rospy.Subscriber("/camera2/usb_cam2/image_raw", Image, self.image_callback)
        self.gpt_sub = rospy.Subscriber("/gpt_response", String, self.gpt_callback)
        # rospy.Subscriber("/robot_assistant/gpt/chat_vla", String, self.input_callback)

        self.text_pub = rospy.Publisher("/robot_assistant/text/speak", String, queue_size=1)
        self.move_pub = rospy.Publisher('/move_request', Int32, queue_size=10)
        # self.goal_pub = rospy.Publisher("/robot_assistant/navigation/request", String, queue_size=10)
        self.move_status_pub = rospy.Publisher('/move_request_status', String, queue_size=10)

        rospy.loginfo("GPT 응답 핸들러 노드 시작됨.")

    def image_callback(self, msg):
        try:
            self.latest_image = self.bridge.imgmsg_to_cv2(msg, desired_encoding="bgr8")
            self.latest_result = self.model(self.latest_image)[0]  # 이미지 들어올 때마다 YOLO 추론 수행
        except Exception as e:
            rospy.logerr("이미지 변환 또는 YOLO 추론 실패: %s", e)

    def detect_label(self, target_label):
        if self.latest_image is None:
            rospy.logwarn("아직 이미지 수신 안됨.")
            return False

        # results = self.model(self.latest_image)
        # boxes = results[0].boxes
        class_names = self.model.names

        for box in self.latest_result.boxes:
            cls_id = int(box.cls[0])
            label = class_names[cls_id]
            if label == target_label:
                rospy.loginfo(f"[✅ 감지됨] {label}")
                return True

        rospy.loginfo(f"[❌ 미감지] {target_label}")
        self.move_pub.publish(2)
        self.move_status_pub.publish(String("주행"))
        return False

    def gpt_callback(self, msg):
        label = msg.data.strip().lower()
        rospy.loginfo(f"GPT 응답 수신됨: {label}")
        if self.detect_label(label):
            rospy.sleep(3.0)
            label_kor = self.label_kor_map.get(label, label)
            self.text_pub.publish(String(f"{label_kor}가 바닥에 놓여져 있습니다."))
            rospy.loginfo(f"도착")
            # 5초 후에 move_request 발행 예약
            # rospy.Timer(rospy.Duration(5.0), self.publish_move_request_zero, oneshot=True)
            # threading.Timer(5.0, self.publish_move_request_zero).start()
            rospy.sleep(3.0)
            self.move_pub.publish(2)
            self.move_status_pub.publish(String("주행"))



    # def publish_move_request_zero(self, event):
    #     self.move_pub.publish(Int32(0))
    #     rospy.loginfo("5초 후 move_request 0 발행 완료.")

    def input_callback(self, msg):
        text = msg.data.strip().lower()
        rospy.loginfo(f"[gpt/chat_vla 수신] {text}")

        if "캐리어" in text and not self.awaiting_lost_item_confirmation:
            self.awaiting_lost_item_confirmation = True
            self.text_pub.publish(String("캐리어를 본 적이 있어요. 그 곳으로 안내해 드릴까요?"))
            return

        if self.awaiting_lost_item_confirmation and text in ["응", "네", "좋아"]:
            self.text_pub.publish(String("네 알겠습니다. 저를 따라오세요."))
            self.awaiting_lost_item_confirmation = False

            # pose.txt 경로에서 좌표 읽기
            pose_path = "/home/nvidia/dconic_nav/src/vla_demo/captured_image/pose.txt"
            if not os.path.exists(pose_path):
                rospy.logerr("pose.txt 파일이 존재하지 않습니다.")
                return

            try:
                with open(pose_path, "r") as f:
                    line = f.readline().strip()
                    values = list(map(float, line.split(",")))
                    if len(values) == 7:
                        x, y, z, ox, oy, oz, ow = values
                        pose_msg = {
                            "pose": {
                                "position": {"x": x, "y": y, "z": z},
                                "orientation": {"x": ox, "y": oy, "z": oz, "w": ow}
                            },
                            "label": "suitcase"
                        }
                        self.goal_pub.publish(String(json.dumps(pose_msg)))
                        rospy.loginfo(f"[📍 이동 명령 발행]: {pose_msg}")
                    else:
                        rospy.logerr("pose.txt 형식 오류 (7개의 float 값 필요)")
            except Exception as e:
                rospy.logerr(f"pose.txt 읽기 오류: {e}")

if __name__ == '__main__':
    try:
        GptResponseHandler()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass
