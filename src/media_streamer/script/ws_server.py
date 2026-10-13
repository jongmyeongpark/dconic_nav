import rospy
from sensor_msgs.msg import CompressedImage
import json
from websocket_server import WebsocketServer
import cv2
import numpy as np

# 웹소켓 클라이언트에게 이미지 데이터를 전송하는 함수
def send_image_data(client, server, image_data):
    server.send_message(client, json.dumps({"image_data": image_data}))

# ROS 토픽에서 이미지 데이터를 수신하는 콜백 함수
def image_callback(msg):
    image_data = msg.data
    # 압축된 이미지를 디코딩하여 숫자 벡터로 변환
    # np_arr = np.frombuffer(image_data, np.uint8)
    # image_np = cv2.imdecode(np_arr, cv2.IMREAD_COLOR)
    # image_np_flat = image_np.flatten().tolist()  # 이미지를 평탄화한 후 리스트로 변환
    # print(image_np_flat)
    # 모든 클라이언트에게 이미지 데이터 전송
    global server
    # server.send_message_to_all(json.dumps({"image_data": image_np_flat}))
    server.send_message_to_all("sdaf")
    rospy.loginfo("Image data sent to all clients")

def main():
    # ROS 노드 초기화
    rospy.init_node('websocket_server_node')

    # ROS 토픽 구독
    rospy.Subscriber("/usb_cam/image_raw/compressed", CompressedImage, image_callback)

    # 웹소켓 서버 생성 및 실행
    global server
    server = WebsocketServer("0.0.0.0", 8765)
    server.run_forever()

if __name__ == "__main__":
    main()
