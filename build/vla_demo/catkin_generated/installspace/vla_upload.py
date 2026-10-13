import os
import json
import time
import requests
import shutil

folder = "/home/nvidia/dconic_nav/src/vla_demo/image_pose/"
uploaded_folder = os.path.join(folder, "uploaded")
os.makedirs(uploaded_folder, exist_ok=True)

url = "https://synaai.app.flyinglet.com/api/main/synaai/post_vla_images"

print("🚀 실시간 업로드 감시 시작...")

while True:
    for filename in sorted(os.listdir(folder)):
        if not filename.endswith(".json"):
            continue


        if filename.endswith(".json"):
            json_path = os.path.join(folder, filename)
            image_name = filename.replace(".json", ".jpg")
            image_path = os.path.join(folder, image_name)

            if not os.path.exists(image_path):
                print(f"❌ 이미지 없음: {image_name}")
                continue

            if os.path.getsize(image_path) == 0:
                print(f"❌ 빈 이미지 파일: {image_name}")
                continue

            with open(json_path, "r") as f:
                try:
                    data = json.load(f)
                except Exception as e:
                    print(f"❌ JSON 파싱 실패: {filename} / {e}")
                    continue

            try:
                with open(image_path, "rb") as img_file:
                    clean_name = os.path.basename(image_path).replace(" ", "_")
                    files = {
                        "file": (clean_name, img_file, "image/jpeg")
                    }
                    response = requests.post(url, files=files, data=data)

                    print(f"✅ 업로드: {image_name} / Status: {response.status_code}")
                    print(response.json())

                    # 업로드 성공 시 파일 이동
                    if response.status_code == 200:
                        shutil.move(json_path, os.path.join(uploaded_folder, os.path.basename(json_path)))
                        shutil.move(image_path, os.path.join(uploaded_folder, os.path.basename(image_path)))
                        print(f"📦 업로드된 파일 이동 완료: {filename}")

            except Exception as e:
                print(f"❌ 업로드 실패: {filename} / {e}")

    time.sleep(5)  # 5초마다 새 파일 감지
