import asyncio
import websockets
import json

async def receive_image_data():
    uri = "ws://localhost:8765"
    async with websockets.connect(uri) as websocket:
        while True:
            # 웹소켓 서버로부터 데이터 수신
            data = await websocket.recv()
            # 수신한 데이터 출력 또는 처리
            print("Received image data:", data)

async def main():
    await receive_image_data()

if __name__ == "__main__":
    asyncio.run(main())
