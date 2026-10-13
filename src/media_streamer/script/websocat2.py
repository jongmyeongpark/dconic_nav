#!/usr/bin/env python3

import asyncio
import ssl
import websockets
import json
import signal

# 전역 변수 선언
websocket = None  # 전역 변수로 websocket을 초기화합니다.
shutdown_event = asyncio.Event()

# asyncio 이벤트 루프를 중지시킬 함수를 정의합니다.
def signal_handler(signum, frame):
    shutdown_event.set()

async def send_message(message):
    global websocket  # 전역 변수로 선언된 websocket을 사용합니다.
    try:
        await websocket.send(json.dumps(message))
        response = await websocket.recv()
        print(f"< Received: {response}")
    except Exception as e:
        print(f"An error occurred while sending message: {e}")

async def connect():
    global websocket  # 전역 변수로 선언된 websocket을 사용합니다.
    uri = "wss://media-streamer.local:8765"  # Ensure this path matches server configuration
    tls_context = ssl.create_default_context(ssl.Purpose.CLIENT_AUTH)
    tls_context.load_verify_locations('./selfsigned.crt')

    print(f"> Attempting to connect to {uri}")
    try:
        async with websockets.connect(uri, ssl=tls_context) as ws:
            websocket = ws
            print(f"> Connected to {uri}")

            while not shutdown_event.is_set():
                # 원하는 메시지를 생성하여 전송합니다.
                message = {"action": "simple_message", "content": "Hello, WebSocket Server!"}
                await send_message(message)

                # 메시지 전송 간격을 조절합니다.
                await asyncio.sleep(1)

    except websockets.exceptions.InvalidStatusCode as e:
        print(f"InvalidStatusCode: {e.status_code}")
    except websockets.exceptions.ConnectionClosedError as e:
        print(f"ConnectionClosedError: {e}")
    except websockets.exceptions.InvalidMessage as e:
        print(f"InvalidMessage: {e}")
    except ssl.SSLError as e:
        print(f"SSLError: {e}")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        print("Closing websocket connection")
        if websocket is not None:
            await websocket.close()


import rospy
from sensor_msgs.msg import CompressedImage

def image_callback(msg):
    rospy.loginfo("Received compressed image")
    # 여기에 이미지 데이터를 출력하거나 처리하는 코드를 작성하세요
    # 예를 들어, 다음과 같이 데이터 길이 출력을 할 수 있습니다.
    rospy.loginfo("Image data length: %d", len(msg.data))

def main():
    rospy.init_node('image_listener', anonymous=True)
    rospy.Subscriber("/usb_cam/image_raw/compressed", CompressedImage, send_message)
    rospy.spin()


if __name__ == "__main__":
    # SIGINT 신호 처리를 설정합니다.
    # signal.signal(signal.SIGINT, signal_handler)

    # loop = asyncio.get_event_loop()
    # loop.run_until_complete(connect())
    main()