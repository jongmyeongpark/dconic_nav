#!/usr/bin/env python3
import rospy
import cv2
import os
import time
import math
import json
import re
import openai
import tf
from sensor_msgs.msg import Image
from geometry_msgs.msg import PoseWithCovarianceStamped
from cv_bridge import CvBridge
from ultralytics import YOLO

# === 설정 ===
MODEL_PATH = "/home/nvidia/yolo_models/best_250415.pt"
SAVE_DIR = "/home/nvidia/dconic_nav/src/vla_demo/image_pose/"
os.makedirs(SAVE_DIR, exist_ok=True)

CAPTURE_INTERVAL = 10.0  # 10초 간격
MOVE_INTERVAL = 5.0 
STOP_INTERVAL = 60.0    # 정지 중
DIFF_THRESHOLD = 25.0  # 이미지 변화 감지 임계값
MAX_HISTORY = 5 

openai.api_key = "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"  # 실제 키로 교체

# === 전역 변수 ===
bridge = CvBridge()
model = YOLO(MODEL_PATH)

gray_history = [] 

prev_pose = None
latest_pose = None

latest_image = None
prev_image_gray = None

last_capture_time = 0

is_moving = False
captured_due_to_diff = False

movement_buffer = []

def get_next_frame_count(save_dir):
    max_index = 0
    pattern = re.compile(r"image_(\d{4})")
    all_dirs = [save_dir, os.path.join(save_dir, "uploaded")]

    for d in all_dirs:
        if not os.path.exists(d):
            continue
        for filename in os.listdir(d):
            match = pattern.match(filename)
            if match:
                index = int(match.group(1))
                max_index = max(max_index, index)

    return max_index + 1


frame_count = get_next_frame_count(SAVE_DIR)


# === 클래스 → 높이 정보 ===
default_metadata = {
    "fire_extinguisher": {"height": 50},
    "chair": {"height": 80},
    "Cubrick": {"height": 150},
    "plant": {"height": 30},
    "charging station": {"height": 30},
    "charging station_long": {"height": 20}
}

# === 콜백 ===
def pose_callback(msg):
    global latest_pose, prev_pose, movement_buffer, is_moving
    pos = msg.pose.pose.position
    ori = msg.pose.pose.orientation
    _, _, yaw = tf.transformations.euler_from_quaternion([ori.x, ori.y, ori.z, ori.w])
    latest_pose = {
        "x": round(pos.x, 3),
        "y": round(pos.y, 3),
        "z": round(pos.z, 3),
        "angle": round(math.degrees(yaw), 2)
    }

    if prev_pose is not None:
        dx = abs(prev_pose["x"] - latest_pose["x"])
        dy = abs(prev_pose["y"] - latest_pose["y"])
        dyaw = abs(prev_pose["angle"] - latest_pose["angle"])
        moved = dx > 0.001 or dy > 0.001 or dyaw > 1.0  # 움직임 허용 오차
        movement_buffer.append(moved)

        if len(movement_buffer) > 5:
            movement_buffer.pop(0)

        is_moving = movement_buffer.count(True) >= 3  # 최근 5번 중 3번 이상 움직였으면 True
    else:
        is_moving = False

    prev_pose = latest_pose.copy()

def image_callback(msg):
    global last_capture_time, frame_count, latest_pose, latest_image, gray_history, captured_due_to_diff

    now = time.time()
    if latest_pose is None:
        return

    # 최신 이미지 수신 및 gray 변환
    latest_image = bridge.imgmsg_to_cv2(msg, desired_encoding='bgr8')
    gray = cv2.cvtColor(latest_image, cv2.COLOR_BGR2GRAY)

    # 회색 이미지 히스토리 관리
    gray_history.append(gray)
    if len(gray_history) > MAX_HISTORY:
        gray_history.pop(0)

    time_elapsed = now - last_capture_time

    # mean diff 계산
    if len(gray_history) >= MAX_HISTORY:
        diff = cv2.absdiff(gray_history[0], gray_history[-1])
        mean_diff = cv2.mean(diff)[0]
        rospy.loginfo(f"📊 현재 mean diff: {mean_diff:.2f}")
    else:
        mean_diff = 0.0
        rospy.loginfo("📊 mean diff 계산 대기 중... (히스토리 부족)")
        return

    # === 정지 상태 ===
    if not is_moving:
        if mean_diff >= DIFF_THRESHOLD:
            if not captured_due_to_diff:
                rospy.loginfo(f"🔴 정지 상태 + 큰 변화 감지 → 즉시 캡처")
                captured_due_to_diff = True
            else:
                rospy.loginfo(f"🛑 정지 상태 + 큰 변화 지속 중 → 캡처 생략")
                return
        elif time_elapsed >= STOP_INTERVAL:
            rospy.loginfo(f"🟢 정지 상태 + 60초 경과 → 주기적 캡처")
            captured_due_to_diff = False
        else:
            rospy.loginfo(f"🟡 정지 상태 + 변화 없음 + 60초 안 지남 → 캡처 생략")
            captured_due_to_diff = False
            return

    # === 이동 중 ===
    else:
        captured_due_to_diff = False  # 이동 중일 땐 항상 flag 초기화
        if time_elapsed < MOVE_INTERVAL:
            rospy.loginfo(f"🚗 이동 중 + {MOVE_INTERVAL}초 안 지남 → 캡처 생략")
            return
        else:
            rospy.loginfo(f"🚗 이동 중 + {MOVE_INTERVAL}초 경과 → 캡처 진행")
        # captured_due_to_diff = False  # 이동 중일 땐 항상 flag 초기화


    # prev_image_gray = gray.copy()
    last_capture_time = now

    results = model(latest_image)[0]
    image_out = results.plot()

    filename_base = f"image_{frame_count:04d}"
    image_path = os.path.join(SAVE_DIR, f"{filename_base}.jpg")
    json_path = os.path.join(SAVE_DIR, f"{filename_base}.json")
    cv2.imwrite(image_path, image_out)

    # 전체 이미지에 대한 captures용 json 저장
    overall_data = {
        "mapName": "office_241210_v3",
        "robotId": "INTE-PLA-04134-012305-00000",
        "imageType": "captures",
        "identity": None,
        "type": None,
        "color": None,
        "confidence": None,
        "height": None,
        "riskLevel": None,
        "reflection": None,
        "darkness": None,
        "x": latest_pose["x"],
        "y": latest_pose["y"],
        "z": latest_pose["z"],
        "angle": latest_pose["angle"]
    }
    with open(json_path, "w") as f:
        json.dump(overall_data, f, indent=2)

    for i, box in enumerate(results.boxes):
        class_id = int(box.cls[0])
        class_name = results.names[class_id]
        confidence = round(float(box.conf[0]) * 100, 2)
        height = default_metadata.get(class_name, {}).get("height", 0)

        # 바운딩 박스로 객체 잘라내기
        x1, y1, x2, y2 = map(int, box.xyxy[0])
        cropped = latest_image[y1:y2, x1:x2]

        index_str = f"{frame_count:04d}_{i+1:02d}"
        crop_filename_base = f"image_{index_str}"
        crop_image_path = os.path.join(SAVE_DIR, crop_filename_base + ".jpg")
        crop_json_path = os.path.join(SAVE_DIR, crop_filename_base + ".json")
        cv2.imwrite(crop_image_path, cropped)
        rospy.loginfo(f"🔍 객체 이미지 저장됨: {crop_image_path}")

        prompt = (
            f"객체 종류는 '{class_name}'입니다.\n"
            f"아래 속성들을 JSON 형식으로만 반환해주세요. 다른 설명 없이 JSON만 출력하세요.\n\n"
            f'응답 형식 예시:\n'
            '{\n  "color": "red",\n  "riskLevel": "medium",\n  "reflection": "none",\n  "darkness": "normal"\n}'
        )

        try:
            gpt_response = openai.ChatCompletion.create(
                model="gpt-4o-mini",
                messages=[{"role": "user", "content": prompt}]
            )
            answer = gpt_response['choices'][0]['message']['content']
            metadata = json.loads(answer)
        except Exception as e:
            rospy.logwarn(f"OpenAI 응답 오류: {e}")
            metadata = {"color": "unknown", "riskLevel": "low", "reflection": "none", "darkness": "normal"}

        data = {
            "mapName": "office_241210_v3",
            "robotId": "INTE-PLA-04134-012305-00000",
            "imageType": "objects",
            "identity": f"{class_name}_{index_str}",
            "type": class_name,
            "color": metadata.get("color", "unknown"),
            "confidence": confidence,
            "height": height,
            "riskLevel": metadata.get("riskLevel", "low"),
            "reflection": metadata.get("reflection", "none"),
            "darkness": metadata.get("darkness", "normal"),
            "x": latest_pose["x"],
            "y": latest_pose["y"],
            "z": latest_pose["z"],
            "angle": latest_pose["angle"]
        }

        with open(crop_json_path, "w") as f:
            json.dump(data, f, indent=2)

    rospy.loginfo(f"✅ 전체 이미지 저장 완료: {image_path}")
    frame_count += 1

# === 실행 ===
if __name__ == "__main__":
    rospy.init_node("yolo_gpt_pose_capturer")
    rospy.Subscriber("/camera2/usb_cam2/image_raw", Image, image_callback)
    rospy.Subscriber("/robot_pose_ekf/odom_combined", PoseWithCovarianceStamped, pose_callback)
    rospy.loginfo("🚀 YOLO + pose + GPT 기반 정보 저장 노드 실행 중...")
    rospy.spin()
