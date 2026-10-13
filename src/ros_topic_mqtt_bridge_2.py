"""�낅┰ �ㅽ뻾�� MQTT �� ROS1 �좏뵿 釉뚮━吏� �곕え (MO2 / Platy)."""

from __future__ import annotations

import argparse
import importlib
import json
import logging
import math
import os
import signal
import socket
import ssl
import threading
import time
import uuid
from datetime import datetime, timedelta, timezone
from pathlib import Path
from typing import Any, Callable, Dict, Optional, Tuple
from urllib.error import HTTPError, URLError
from urllib.parse import urlparse
from urllib.request import Request, urlopen

import paho.mqtt.client as mqtt
import yaml

try:
    rospy = importlib.import_module("rospy")
    std_msgs_msg = importlib.import_module("std_msgs.msg")
    Empty = std_msgs_msg.Empty
    Int32 = std_msgs_msg.Int32
    String = std_msgs_msg.String
    ROS_AVAILABLE = True
except ImportError:
    rospy = None  # type: ignore
    Empty = Int32 = String = None  # type: ignore
    ROS_AVAILABLE = False


KST = timezone(timedelta(hours=9))
LOG = logging.getLogger("ros_topic_mqtt_bridge")


def log_step(step: str, message: str, *args: Any) -> None:
    LOG.info("[STEP:%s] " + message, step, *args)


def log_step_fail(step: str, message: str, *args: Any) -> None:
    LOG.warning("[STEP:%s:FAIL] " + message, step, *args)


def log_bridge_info(message: str, *args: Any) -> None:
    """�쒖� logging怨� (ROS �몃뱶媛� �� �덉쑝硫�) rosout�� rospy.loginfo瑜� �④퍡 �④릿��."""
    text = message % args if args else message
    LOG.info(text)
    if not ROS_AVAILABLE or rospy is None:
        return
    try:
        if rospy.core.is_initialized():
            rospy.loginfo(text)
    except Exception:
        pass


def log_cmd_to_ros(
    command_id: str,
    ros_topic: str,
    msg_type: str,
    data_repr: str,
    dry_run: bool,
) -> None:
    """MQTT 紐낅졊 泥섎━ �� ROS濡� �대젮蹂대궦 �� 嫄댁쓣 �� 以꾨줈 �④릿��."""
    log_bridge_info(
        "[CMD�뭃OS] command_id=%s ros_topic=%s msg_type=%s data=%s dry_run=%s",
        command_id,
        ros_topic,
        msg_type,
        data_repr,
        dry_run,
    )


DEFAULT_CONFIG: Dict[str, Any] = {
    "f_cd": "ros_bridge_demo",
    "robot_id": None,
    "backend": "mo2",
    "mqtt": {
        "broker": {
            "url": "mqtt://127.0.0.1:1883",
            "client_id_prefix": "flyinglet_agent",
            "username": None,
            "password": None,
            "keepalive": 60,
            "use_tls": False,
        },
        "default_qos": 1,
        "connect_warn_after_sec": 10,
        "tcp_probe_timeout_sec": 3,
    },
    "asyncapi": {
        "subscribe_command_mission": False,
        "publish_command_mission_ack": False,
        "emit_backend_topics": True,
    },
    "ros": {
        "dry_run": False,
        "ros_master_uri": None,
        "mo2": {
            "mission_command_topic": "/mission_command",
            "mission_status_topic": "/mission_status",
            "position_topic": "/robot_position_json",
            "state_topic": "/robot_state_json",
            "value_start": 2,
            "value_pause": 1,
            "value_cancel": 0,
        },
        "platy": {
            "path_run_request_topic": "/path_run_request",
            "path_run_cancel_topic": "/path_run_cancel_request",
            "move_request_topic": "/move_request",
            "default_path_csv": "0100m16_4floor_1.csv",
            "position_topic": "/robot_position_json",
            "state_topic": "/robot_state_json",
            "mission_status_topic": "/mission_status",
        },
    },
    "mission_result_upload": {
        "endpoint_url": "https://robot.skhynix.com/api/v1/missions-schedule/mission-result/demo/upload-jpg",
        "image_root_dir": "/home/nvidia/images",
        "secret": "inte3050!",
        "secret_transport": "header",
        "secret_header_name": "X-Demo-Secret",
        "timeout_sec": 10,
        "auto_upload_on_completed": True,
        # HTTPS �낅줈�� �� �쒕쾭 �몄쬆�� 寃�利�. false �� MITM/�쒓컖 �ㅻ쪟 �고쉶��(�댁쁺 鍮꾧텒��).
        "verify_ssl": False,
        # �ㅽ듃�뚰겕/DNS �쒓컙 �ㅽ뙣(EAI_AGAIN ��) �� �낅줈�� �ъ떆��: 異붽� �잛닔(��: 2 �� 珥� 理쒕� 3��)
        "dns_fail_retry_extra": 2,
        "dns_fail_retry_backoff_sec": 1.0,
    },
}


def load_yaml(path: Path) -> Dict[str, Any]:
    if not path.is_file():
        LOG.warning("�ㅼ젙 �뚯씪�� �놁뼱 �댁옣 湲곕낯媛믪쑝濡� �ㅽ뻾�⑸땲��: %s", path)
        return dict(DEFAULT_CONFIG)
    with open(path, "r", encoding="utf-8") as f:
        loaded = yaml.safe_load(f) or {}
    merged = dict(DEFAULT_CONFIG)
    merged.update(loaded)
    return merged


def now_iso() -> str:
    return datetime.now().isoformat()


def now_kst_compact() -> str:
    return datetime.now(KST).strftime("%Y%m%d%H%M%S")


def json_dumps(payload: Any, indent: Optional[int] = None) -> str:
    # None �� �ㅼ뿬�곌린 �곸슜(L1 MQTT_JSON_PUBLISH_INDENT �� �숈씪�섍쾶 2)
    eff_indent = 2 if indent is None else indent
    return json.dumps(payload, ensure_ascii=False, default=str, indent=eff_indent)


def _normalize_existing_path(path: Path) -> Path:
    """�ㅼ젣 議댁옱 寃쎈줈 諛섑솚 �� resolve(strict=False). Python 3.8 �� strict 誘몄���."""
    try:
        return path.resolve(strict=False)
    except TypeError:
        try:
            return path.resolve()
        except OSError:
            return path
    except OSError:
        return path


def _urLError_reason_lower(exc: URLError) -> str:
    r = getattr(exc, "reason", None)
    return str(r).lower() if r is not None else str(exc).lower()


def _is_dns_related_urLError(exc: URLError) -> bool:
    """urllib URLError 以� getaddrinfo/DNS 怨꾩뿴(�쇱떆 �ㅽ뙣 �ы븿)."""
    low = _urLError_reason_lower(exc)
    needles = (
        "temporary failure in name resolution",
        "name or service not known",
        "nodename nor servname provided, or not known",
        "name resolution",
        "getaddrinfo failed",
        "gaierror",
        "errno -3",
    )
    return any(n in low for n in needles)


def command_category(command_type: str) -> str:
    control = {"stop", "freeze"}
    navigation = {"play_mission", "mission_clear"}
    if command_type in control:
        return "control"
    if command_type in navigation:
        return "navigation"
    return "unknown"


def mission_status_payload(robot_id: str, status: str, backend: str) -> Dict[str, Any]:
    return {
        "message_id": str(uuid.uuid4()),
        "robot_id": robot_id,
        "timestamp": now_iso(),
        "data_type": "MISSION_STATUS",
        "data": {
            "status": status,
            "mission_id": 0,
            "tick_number": 0,
            "tick_counter": 0,
            "current_action": {"kind": "ros_topic_bridge", "detail": backend} if status == "running" else None,
            "current_element": {},
            "mission_first_tick_start_timestamp": None,
        },
    }


def command_response_payload(
    command_id: str,
    command_type: str,
    success: bool,
    result: Optional[Dict[str, Any]] = None,
    error: Optional[str] = None,
) -> Dict[str, Any]:
    payload: Dict[str, Any] = {
        "command_id": command_id,
        "type": command_type,
        "category": command_category(command_type),
        "success": success,
        "ack": success,
        "delivered_to_sdk": success,
        "timestamp": now_iso(),
        "error": None,
        "result": result or {},
    }
    if not success:
        payload["error"] = error or f"command_failed:{command_type}"
    return payload


def mission_completed_event(robot_id: str, command_id: str) -> Dict[str, Any]:
    return {
        "event": "mission_completed",
        "robot_id": robot_id,
        "command_id": command_id,
        "command_type": "play_mission",
        "success": True,
        "timestamp": now_iso(),
        "result": {"source": "ros_topic_bridge", "ros_signal": "COMPLETED"},
    }


def telemetry_payload(robot_id: str, data_type: str, data: Dict[str, Any]) -> Dict[str, Any]:
    return {"message_id": str(uuid.uuid4()), "robot_id": robot_id, "timestamp": now_iso(), "data_type": data_type, "data": data}


def _build_multipart_form_body(
    field_name: str,
    file_name: str,
    file_content: bytes,
    boundary: str,
    extra_fields: Optional[Dict[str, Any]] = None,
) -> bytes:
    crlf = b"\r\n"
    body = b""
    for key, value in (extra_fields or {}).items():
        if value in (None, ""):
            continue
        body += f"--{boundary}".encode("utf-8") + crlf
        body += f'Content-Disposition: form-data; name="{key}"'.encode("utf-8") + crlf
        body += crlf
        body += str(value).encode("utf-8") + crlf

    body += f"--{boundary}".encode("utf-8") + crlf
    body += f'Content-Disposition: form-data; name="{field_name}"; filename="{file_name}"'.encode("utf-8") + crlf
    body += b"Content-Type: image/jpeg" + crlf
    body += crlf
    body += file_content + crlf
    body += f"--{boundary}--".encode("utf-8") + crlf
    return body


def _pose_from_flat_xyz_q(src: Dict[str, Any]) -> Tuple[Dict[str, Any], Dict[str, Any]]:
    """x,y,z 諛� qx,qy,qz,qw(荑쇳꽣�덉뼵) �� position{x,y,z}, rotation{x,y,z,w}."""
    position: Dict[str, Any] = {}
    rotation: Dict[str, Any] = {}
    for axis in ("x", "y", "z"):
        if axis in src and src[axis] is not None:
            position[axis] = src[axis]
    for q_key, r_key in (("qx", "x"), ("qy", "y"), ("qz", "z"), ("qw", "w")):
        if q_key in src and src[q_key] is not None:
            rotation[r_key] = src[q_key]
    return position, rotation


def _merge_rotation_xyzw(dst: Dict[str, Any], src: Any) -> None:
    if not isinstance(src, dict):
        return
    for axis in ("x", "y", "z", "w"):
        if src.get(axis) is not None:
            dst[axis] = src[axis]


def quaternion_xyzw_to_roll_pitch_yaw_deg(qx: float, qy: float, qz: float, qw: float) -> Tuple[float, float, float]:
    """�⑥쐞 荑쇳꽣�덉뼵 (qx, qy, qz, qw) �� (roll, pitch, yaw) degree.

    愿��기넂濡쒖뺄 �쒖꽌濡� �뷀엳 �곕뒗 Tait�밄ryan (roll�뭦itch�뭰aw, 怨좎젙異� XYZ)��
    �숈씪�� �꾪삎�곸씤 �꾧컻�앹씠��.
    """
    n = math.sqrt(qx * qx + qy * qy + qz * qz + qw * qw)
    if n < 1e-10:
        return 0.0, 0.0, 0.0
    qx, qy, qz, qw = qx / n, qy / n, qz / n, qw / n

    sinr_cosp = 2.0 * (qw * qx + qy * qz)
    cosr_cosp = 1.0 - 2.0 * (qx * qx + qy * qy)
    roll = math.atan2(sinr_cosp, cosr_cosp)

    sinp = 2.0 * (qw * qy - qz * qx)
    sinp = max(-1.0, min(1.0, sinp))
    pitch = math.asin(sinp)

    siny_cosp = 2.0 * (qw * qz + qx * qy)
    cosy_cosp = 1.0 - 2.0 * (qy * qy + qz * qz)
    yaw = math.atan2(siny_cosp, cosy_cosp)
    return math.degrees(roll), math.degrees(pitch), math.degrees(yaw)


def shape_robot_status_data(data: Dict[str, Any]) -> Dict[str, Any]:
    """�낅젰(raw)�� 諛쏆븘 紐⑺몴 MQTT status �ㅽ궎留덈줈 怨좎젙 蹂��섑븳��."""
    src = dict(data)

    def _as_float(value: Any) -> Optional[float]:
        if isinstance(value, (int, float)):
            return float(value)
        if isinstance(value, str):
            try:
                return float(value.strip())
            except Exception:
                return None
        return None

    def _as_bool(value: Any) -> Optional[bool]:
        if isinstance(value, bool):
            return value
        if isinstance(value, str):
            t = value.strip().lower()
            if t in ("true", "1", "yes", "y", "on"):
                return True
            if t in ("false", "0", "no", "n", "off"):
                return False
        return None

    def _pick_num(*keys: str) -> Optional[float]:
        for k in keys:
            v = _as_float(src.get(k))
            if v is not None:
                return v
        return None

    def _pick_str(*keys: str) -> Optional[str]:
        for k in keys:
            v = src.get(k)
            if isinstance(v, str) and v.strip():
                return v
        return None

    # position/rotation
    pos: Dict[str, Any] = {}
    rot: Dict[str, Any] = {}
    p1, r1 = _pose_from_flat_xyz_q(src)
    pos.update(p1)
    rot.update(r1)
    if isinstance(src.get("position"), dict):
        p2, r2 = _pose_from_flat_xyz_q(src["position"])
        pos.update(p2)
        rot.update(r2)
        _merge_rotation_xyzw(rot, src["position"].get("rotation"))
    _merge_rotation_xyzw(rot, src.get("rotation"))

    # battery
    battery_obj: Dict[str, Any] = {}
    battery = src.get("battery")
    if isinstance(battery, dict):
        pct = _as_float(battery.get("percentage"))
        if pct is not None:
            battery_obj["percentage"] = pct
        if isinstance(battery.get("status"), str) and battery.get("status", "").strip():
            battery_obj["status"] = battery["status"]
    else:
        pct = _as_float(battery)
        if pct is None:
            pct = _pick_num("battery_percentage", "battery_level")
        if pct is not None:
            battery_obj["percentage"] = pct
    if "status" not in battery_obj:
        st = _pick_str("battery_status")
        if st:
            battery_obj["status"] = st
        else:
            ch = _as_bool(src.get("charging"))
            if ch is not None:
                battery_obj["status"] = "charging" if ch else "discharging"

    # orientation(yaw/pitch/roll)
    orientation: Dict[str, Any] = {}
    if isinstance(src.get("orientation"), dict):
        for k in ("yaw", "pitch", "roll"):
            v = _as_float(src["orientation"].get(k))
            if v is not None:
                orientation[k] = v
    for key, alias in (("yaw", ("yaw", "heading", "theta")), ("pitch", ("pitch",)), ("roll", ("roll",))):
        if key not in orientation:
            v = _pick_num(*alias)
            if v is not None:
                orientation[key] = v

    # qx,qy,qz,qw �� yaw/pitch/roll (degree). rotation 蹂묓빀 寃곌낵( x=qx �� ) �먮뒗 猷⑦듃/position�먯꽌 �쎌쓬.
    qt: Optional[Tuple[float, float, float, float]] = None
    rx, ry, rz, rw = (_as_float(rot.get("x")), _as_float(rot.get("y")), _as_float(rot.get("z")), _as_float(rot.get("w")))
    if rx is not None and ry is not None and rz is not None and rw is not None:
        qt = (rx, ry, rz, rw)
    else:
        qxa, qya, qza, qwa = (
            _as_float(src.get("qx")),
            _as_float(src.get("qy")),
            _as_float(src.get("qz")),
            _as_float(src.get("qw")),
        )
        if qxa is not None and qya is not None and qza is not None and qwa is not None:
            qt = (qxa, qya, qza, qwa)
        elif isinstance(src.get("position"), dict):
            pd = src["position"]
            qxb, qyb, qzb, qwb = (
                _as_float(pd.get("qx")),
                _as_float(pd.get("qy")),
                _as_float(pd.get("qz")),
                _as_float(pd.get("qw")),
            )
            if qxb is not None and qyb is not None and qzb is not None and qwb is not None:
                qt = (qxb, qyb, qzb, qwb)
    if qt is not None:
        roll_d, pitch_d, yaw_d = quaternion_xyzw_to_roll_pitch_yaw_deg(*qt)
        orientation["roll"] = roll_d
        orientation["pitch"] = pitch_d
        orientation["yaw"] = yaw_d

    locomotion_status = _pick_str("locomotion_status", "motion_status", "drive_status")
    mission_status = _pick_str("mission_status")
    localization_status = _pick_str("localization_status")
    map_recording_status = _pick_str("map_recording_status")
    anchoring_status = _pick_str("anchoring_status", "anchor_status")
    control_mode = _pick_str("control_mode", "mode")
    power_motor = _pick_str("motor_power", "power_state", "motor_state")

    velocity = _pick_num("velocity", "linear_velocity", "vel", "speed")
    lease = _as_bool(src.get("lease"))
    if lease is None:
        lease = _as_bool(src.get("has_lease"))
    distance = _pick_num("distance", "drive_distance", "distance_m", "travel_distance")
    time_moving = _pick_num("time_moving", "drive_time", "time_moving_sec", "moving_time", "moving_time_sec")

    shaped: Dict[str, Any] = {
        "battery": battery_obj if battery_obj else {},
        "velocity": velocity if velocity is not None else 0.0,
        "orientation": orientation if orientation else {"yaw": 0.0, "pitch": 0.0, "roll": 0.0},
        "position": pos if pos else {"x": 0.0, "y": 0.0, "z": 0.0},
        "locomotion": {"status": locomotion_status or "idle"},
        "control": {"mode": control_mode or "manual"},
        "mission": {"status": mission_status or "idle"},
        "localization": {"status": localization_status or "not_localized"},
        "map_recording": {"status": map_recording_status or "not_recording"},
        "anchoring": {"status": anchoring_status or "not_anchored"},
        "power": {"motor": power_motor or "on"},
        "lease": bool(lease) if lease is not None else False,
        "distance": distance if distance is not None else 0.0,
        "time_moving": time_moving if time_moving is not None else 0.0,
    }

    # �댁쁺�먯꽌 �곕뒗 異붽� �ㅻ룄 �좎� (�놁쑝硫� �앸왂)
    speed = _pick_num("speed", "velocity", "linear_velocity", "vel")
    if speed is not None:
        shaped["speed"] = int(round(speed))
    if rot:
        shaped["rotation"] = rot
    if isinstance(src.get("network"), dict):
        net = dict(src["network"])
    else:
        net = {}
    ns = _pick_num("network_strength", "wifi_strength", "rssi")
    if ns is not None:
        net.setdefault("strength", int(round(ns)))
    nb = _pick_num("network_down_bps", "down_bps", "rx_bps")
    if nb is not None:
        net.setdefault("down_bps", int(round(nb)))
    if net:
        shaped["network"] = net
    for k in ("initial_start_time", "timestamp", "drive_status", "current_waypoint_name", "map_name", "drive_time", "drive_distance"):
        if k in src and src[k] not in (None, ""):
            shaped[k] = src[k]
    if isinstance(src.get("sensor_status"), dict):
        shaped["sensor_status"] = src["sensor_status"]

    return shaped


class SimpleMqtt:
    def __init__(self, cfg: Dict[str, Any]):
        mqtt_cfg = cfg.get("mqtt") or {}
        broker = mqtt_cfg.get("broker") or mqtt_cfg
        parsed = urlparse(str(broker.get("url") or "mqtt://127.0.0.1:1883"))
        self.host = parsed.hostname or "127.0.0.1"
        self.port = int(parsed.port or 1883)
        self.keepalive = int(broker.get("keepalive", 60))
        qos_cfg = mqtt_cfg.get("qos", mqtt_cfg.get("default_qos", 1))
        self.qos = int(qos_cfg if not isinstance(qos_cfg, dict) else mqtt_cfg.get("default_qos", 1))
        self.connect_warn_after_sec = int(mqtt_cfg.get("connect_warn_after_sec", broker.get("connect_warn_after_sec", 10)))
        self.tcp_probe_timeout_sec = float(mqtt_cfg.get("tcp_probe_timeout_sec", broker.get("tcp_probe_timeout_sec", 3)))
        self.connected = threading.Event()
        self.stopped = threading.Event()
        self.handlers: Dict[str, Callable[[str, Any], None]] = {}
        client_id_prefix = str(broker.get("client_id_prefix") or "flyinglet_agent")
        client_id = str(broker.get("client_id") or f"{client_id_prefix}_ros_bridge_{os.getpid()}_{int(time.time())}")
        self.client_id = client_id
        self.connect_started_mono: Optional[float] = None
        self.monitor_thread: Optional[threading.Thread] = None
        self.client = mqtt.Client(client_id=client_id, clean_session=True, protocol=mqtt.MQTTv311)
        if broker.get("username"):
            self.client.username_pw_set(str(broker.get("username")), broker.get("password"))
        if parsed.scheme in ("mqtts", "ssl") or broker.get("use_tls", False):
            self.client.tls_set()
        self.client.on_connect = self._on_connect
        self.client.on_disconnect = self._on_disconnect
        self.client.on_message = self._on_message
        self.client.on_log = self._on_log

    def connect(self) -> bool:
        self.connect_started_mono = time.monotonic()
        log_step(
            "MQTT_CONNECT",
            "鍮꾨룞湲� �곌껐 �쒖옉 host=%s port=%s keepalive=%s client_id=%s",
            self.host,
            self.port,
            self.keepalive,
            self.client_id,
        )
        self._probe_tcp("MQTT_CONNECT")
        self.client.reconnect_delay_set(min_delay=1, max_delay=30)
        self.client.connect_async(self.host, self.port, self.keepalive)
        self.client.loop_start()
        self._start_connect_monitor()
        log_step("MQTT_CONNECT", "�ㅽ듃�뚰겕 猷⑦봽 �쒖옉 �꾨즺, �곌껐 �ㅽ뙣 �� 諛깃렇�쇱슫�� �ъ떆��")
        return True

    def stop(self) -> None:
        log_step("SHUTDOWN", "MQTT 猷⑦봽 醫낅즺 �쒖옉")
        self.stopped.set()
        self.client.loop_stop()
        self.client.disconnect()
        log_step("SHUTDOWN", "MQTT �곌껐 醫낅즺 �꾨즺")

    def _start_connect_monitor(self) -> None:
        if self.monitor_thread and self.monitor_thread.is_alive():
            return
        self.monitor_thread = threading.Thread(target=self._watch_connection, name="mqtt-connect-watchdog", daemon=True)
        self.monitor_thread.start()

    def _watch_connection(self) -> None:
        while not self.stopped.is_set() and not self.connected.is_set():
            self.stopped.wait(float(self.connect_warn_after_sec))
            if self.stopped.is_set() or self.connected.is_set():
                break
            elapsed = time.monotonic() - (self.connect_started_mono or time.monotonic())
            log_step_fail(
                "MQTT_CONNECT",
                "釉뚮줈而� �곌껐 �꾨즺 肄쒕갚 ��湲� 以� elapsed=%.1fs host=%s port=%s. 釉뚮줈而� �ㅽ뻾/二쇱냼/諛⑺솕踰�/�ы듃 �뺤씤 �꾩슂",
                elapsed,
                self.host,
                self.port,
            )
            self._probe_tcp("MQTT_PROBE")

    def _probe_tcp(self, step: str) -> bool:
        try:
            with socket.create_connection((self.host, self.port), timeout=self.tcp_probe_timeout_sec):
                log_step(step, "TCP probe �깃났 host=%s port=%s", self.host, self.port)
                return True
        except socket.gaierror as exc:
            log_step_fail(step, "DNS �댁꽍 �ㅽ뙣 host=%s error=%s. MQTT url 二쇱냼 �뺤씤 �꾩슂", self.host, exc)
        except TimeoutError as exc:
            log_step_fail(
                step,
                "TCP probe timeout %.1fs host=%s port=%s error=%s. �먭꺽 釉뚮줈而ㅻ씪硫� �꾩썐諛붿슫�� 諛⑺솕踰�/�쇱슦�� �뺤씤 �꾩슂",
                self.tcp_probe_timeout_sec,
                self.host,
                self.port,
                exc,
            )
        except ConnectionRefusedError as exc:
            log_step_fail(step, "TCP �곌껐 嫄곕� host=%s port=%s error=%s. 二쇱냼�� �우�留� 釉뚮줈而�/�ы듃媛� �대젮�덉� �딆쓬", self.host, self.port, exc)
        except OSError as exc:
            log_step_fail(step, "TCP probe �ㅽ뙣 host=%s port=%s error=%s. �ㅽ듃�뚰겕/諛⑺솕踰�/�ы듃 �뺤씤 �꾩슂", self.host, self.port, exc)
        return False

    def subscribe(self, topic: str, handler: Callable[[str, Any], None]) -> None:
        self.handlers[topic] = handler
        if self.connected.is_set():
            self.client.subscribe(topic, qos=self.qos)
        log_step("MQTT_SUBSCRIBE", "援щ룆 �깅줉 topic=%s connected=%s", topic, self.connected.is_set())

    def publish_json(self, topic: str, payload: Dict[str, Any], indent: Optional[int] = None) -> None:
        self.client.publish(topic, json_dumps(payload, indent=indent), qos=self.qos, retain=False)
        LOG.debug("MQTT 諛쒗뻾: %s", topic)

    def _on_connect(self, _client: mqtt.Client, _userdata: Any, _flags: Any, rc: int) -> None:
        if rc != 0:
            log_step_fail("MQTT_CONNECT", "釉뚮줈而ㅺ� �곌껐 嫄곕� rc=%s", rc)
            return
        self.connected.set()
        for topic in self.handlers:
            self.client.subscribe(topic, qos=self.qos)
        log_step("MQTT_CONNECT", "釉뚮줈而� �곌껐 �꾨즺, �깅줉 援щ룆 ��=%s", len(self.handlers))

    def _on_disconnect(self, _client: mqtt.Client, _userdata: Any, rc: int) -> None:
        self.connected.clear()
        log_step_fail("MQTT_CONNECT", "釉뚮줈而� �곌껐 �댁젣 rc=%s, paho媛� �ъ뿰寃� �쒕룄", rc)

    def _on_log(self, _client: mqtt.Client, _userdata: Any, level: int, buf: str) -> None:
        if level in (mqtt.MQTT_LOG_ERR, mqtt.MQTT_LOG_WARNING):
            log_step_fail("MQTT_LOG", "%s", buf)
        else:
            LOG.debug("[STEP:MQTT_LOG] %s", buf)

    def _on_message(self, _client: mqtt.Client, _userdata: Any, msg: mqtt.MQTTMessage) -> None:
        raw = msg.payload.decode("utf-8", errors="replace")
        try:
            payload: Any = json.loads(raw)
        except json.JSONDecodeError:
            payload = raw
        for pattern, handler in list(self.handlers.items()):
            if mqtt.topic_matches_sub(pattern, msg.topic):
                handler(msg.topic, payload)


class RosTopicBridge:
    def __init__(self, cfg: Dict[str, Any], dry_run_override: bool):
        self.cfg = cfg
        self.f_cd = str(cfg.get("f_cd") or cfg.get("robot_id") or "ros_bridge_demo")
        self.robot_id = str(cfg.get("robot_id") or self.f_cd)
        self.backend = str(cfg.get("backend") or "mo2").lower()
        self.asyncapi = cfg.get("asyncapi") or {}
        self.emit_backend_topics = bool(self.asyncapi.get("emit_backend_topics", True))
        self.dry_run = dry_run_override or bool((cfg.get("ros") or {}).get("dry_run", False))
        if not ROS_AVAILABLE:
            self.dry_run = True
            LOG.warning("rospy媛� �놁뼱 dry-run�쇰줈 �ㅽ뻾�⑸땲��.")
        self.mqtt = SimpleMqtt(cfg)
        self.lock = threading.Lock()
        self.last_play_command_id: Optional[str] = None
        self.pub_mo2_cmd = None
        self.pub_platy_run = None
        self.pub_platy_cancel = None
        self.pub_platy_move = None
        self.ros_ready = False
        self.latest_position: Optional[Dict[str, Any]] = None
        self.latest_state: Optional[Dict[str, Any]] = None

    def start(self) -> None:
        log_step("START", "釉뚮━吏� �쒖옉 以�鍮� f_cd=%s robot_id=%s backend=%s dry_run=%s", self.f_cd, self.robot_id, self.backend, self.dry_run)
        log_step("START", "1/3 MQTT �곌껐 �④퀎 吏꾩엯")
        self.mqtt.connect()
        log_step("START", "2/3 ROS 珥덇린�� �④퀎 吏꾩엯")
        self._try_init_ros()
        log_step("START", "3/3 MQTT 紐낅졊 援щ룆 �④퀎 吏꾩엯")
        self._subscribe_mqtt_topics()
        log_step("START", "釉뚮━吏� �쒖옉 �꾨즺")

    def _try_init_ros(self) -> None:
        if self.dry_run:
            log_step("ROS_INIT", "dry-run 紐⑤뱶�� ROS 珥덇린�붾� 嫄대꼫��")
            return
        if self.ros_ready:
            log_step("ROS_INIT", "�대� ROS 珥덇린�� �꾨즺 �곹깭")
            return
        try:
            log_step("ROS_INIT", "ROS 珥덇린�� �쒕룄 backend=%s", self.backend)
            self._init_ros()
            self.ros_ready = True
            log_step("ROS_INIT", "ROS 珥덇린�� �꾨즺")
        except Exception as exc:
            self.ros_ready = False
            log_step_fail("ROS_INIT", "ROS 珥덇린�� �ㅽ뙣, �꾨줈�몄뒪 �좎� �� �ъ떆��: %s", exc)

    def stop(self) -> None:
        log_step("SHUTDOWN", "釉뚮━吏� 醫낅즺 泥섎━ �쒖옉")
        self.mqtt.stop()

    def _init_ros(self) -> None:
        if self.dry_run:
            return
        ros_cfg = self.cfg.get("ros") or {}
        if ros_cfg.get("ros_master_uri"):
            os.environ["ROS_MASTER_URI"] = str(ros_cfg["ros_master_uri"])
            log_step("ROS_INIT", "ROS_MASTER_URI �ㅼ젙: %s", os.environ["ROS_MASTER_URI"])
        else:
            log_step("ROS_INIT", "ROS_MASTER_URI 湲곗〈 �섍꼍媛� �ъ슜: %s", os.environ.get("ROS_MASTER_URI"))
        log_step("ROS_INIT", "rospy �몃뱶 珥덇린�� �쒖옉")
        rospy.init_node("standalone_mqtt_ros_topic_bridge", anonymous=True, disable_signals=True)
        log_step("ROS_INIT", "rospy �몃뱶 珥덇린�� �꾨즺")
        if self.backend == "mo2":
            mo2 = ros_cfg.get("mo2") or {}
            mission_command_topic = mo2.get("mission_command_topic", "/mission_command")
            mission_status_topic = mo2.get("mission_status_topic", "/mission_status")
            self.pub_mo2_cmd = rospy.Publisher(mission_command_topic, Int32, queue_size=10)
            log_step("ROS_TOPIC", "MO2 publisher �깅줉: %s Int32", mission_command_topic)
            rospy.Subscriber(mission_status_topic, String, self._on_ros_completed)
            log_step("ROS_TOPIC", "MO2 subscriber �깅줉: %s String", mission_status_topic)
            if mo2.get("position_topic"):
                rospy.Subscriber(str(mo2["position_topic"]), String, self._on_ros_position)
                log_step("ROS_TOPIC", "MO2 subscriber �깅줉: %s String -> robot/status/raw", mo2["position_topic"])
            if mo2.get("state_topic"):
                rospy.Subscriber(str(mo2["state_topic"]), String, self._on_ros_state)
                log_step("ROS_TOPIC", "MO2 subscriber �깅줉: %s String -> robot/status", mo2["state_topic"])
        elif self.backend == "platy":
            platy = ros_cfg.get("platy") or {}
            path_run_topic = platy.get("path_run_request_topic", "/path_run_request")
            path_cancel_topic = platy.get("path_run_cancel_topic", "/path_run_cancel_request")
            move_topic = platy.get("move_request_topic", "/move_request")
            self.pub_platy_run = rospy.Publisher(path_run_topic, String, queue_size=10)
            self.pub_platy_cancel = rospy.Publisher(path_cancel_topic, Empty, queue_size=10)
            self.pub_platy_move = rospy.Publisher(move_topic, Int32, queue_size=10)
            log_step("ROS_TOPIC", "Platy publisher �깅줉: %s String", path_run_topic)
            log_step("ROS_TOPIC", "Platy publisher �깅줉: %s Empty", path_cancel_topic)
            log_step("ROS_TOPIC", "Platy publisher �깅줉: %s Int32", move_topic)
            if platy.get("mission_status_topic"):
                rospy.Subscriber(str(platy["mission_status_topic"]), String, self._on_ros_completed)
                log_step("ROS_TOPIC", "Platy subscriber �깅줉: %s String", platy["mission_status_topic"])
            if platy.get("position_topic"):
                rospy.Subscriber(str(platy["position_topic"]), String, self._on_ros_position)
                log_step("ROS_TOPIC", "Platy subscriber �깅줉: %s String -> robot/status/raw + status", platy["position_topic"])
            if platy.get("state_topic"):
                rospy.Subscriber(str(platy["state_topic"]), String, self._on_ros_state)
                log_step("ROS_TOPIC", "Platy subscriber �깅줉: %s String -> robot/status", platy["state_topic"])
        else:
            raise ValueError(f"吏��먰븯吏� �딅뒗 backend: {self.backend}")

    def _subscribe_mqtt_topics(self) -> None:
        if self.asyncapi.get("subscribe_command_mission", False):
            self.mqtt.subscribe(f"flyinglet/{self.f_cd}/command/mission", self.handle_mqtt_command)
        self.mqtt.subscribe(f"flyinglet/{self.f_cd}/robot/command", self.handle_mqtt_command)
        log_step("MQTT_SUBSCRIBE", "MQTT 紐낅졊 援щ룆 �깅줉 �꾨즺")

    def _on_ros_completed(self, msg: Any) -> None:
        if str(getattr(msg, "data", "")).strip().upper() == "COMPLETED":
            self._publish_completed()
            cfg = self.cfg.get("mission_result_upload") or {}
            if bool(cfg.get("auto_upload_on_completed", True)):
                auto_command_id = str(uuid.uuid4())
                log_step(
                    "MISSION_RESULT_UPLOAD",
                    "ROS COMPLETED 媛먯�濡� �먮룞 �낅줈�� �ㅽ뻾 command_id=%s",
                    auto_command_id,
                )
                self._dispatch_mission_result_upload(
                    auto_command_id,
                    "mission_result_acquire_and_upload",
                    {},
                )

    def _on_ros_position(self, msg: Any) -> None:
        if not self.emit_backend_topics:
            return
        position = self._parse_ros_json_message(msg)
        with self.lock:
            self.latest_position = position
            status = self._merged_status_locked()
        self.mqtt.publish_json(f"flyinglet/{self.f_cd}/robot/status/raw", telemetry_payload(self.f_cd, "ROBOT_STATUS_RAW", position))
        self.mqtt.publish_json(
            f"flyinglet/{self.f_cd}/robot/status",
            telemetry_payload(self.f_cd, "ROBOT_STATUS", shape_robot_status_data(status)),
        )
        LOG.debug("ROS position -> MQTT status/raw 諛쒗뻾, status�� position 蹂묓빀")

    def _on_ros_state(self, msg: Any) -> None:
        if not self.emit_backend_topics:
            return
        state = self._parse_ros_json_message(msg)
        with self.lock:
            self.latest_state = state
            status = self._merged_status_locked()
        self.mqtt.publish_json(
            f"flyinglet/{self.f_cd}/robot/status",
            telemetry_payload(self.f_cd, "ROBOT_STATUS", shape_robot_status_data(status)),
        )
        LOG.debug("ROS state -> MQTT status 諛쒗뻾, 理쒖떊 position 蹂묓빀")

    def _parse_ros_json_message(self, msg: Any) -> Dict[str, Any]:
        text = str(getattr(msg, "data", ""))
        try:
            parsed = json.loads(text)
        except json.JSONDecodeError:
            return {"raw": text}
        return parsed if isinstance(parsed, dict) else {"value": parsed}

    def _merged_status_locked(self) -> Dict[str, Any]:
        state = dict(self.latest_state or {})
        position = dict(self.latest_position or {})
        if not position:
            return state
        state["position"] = dict(position)
        for key, value in position.items():
            if value not in (None, "", {}):
                state[key] = value
        return state

    def _publish_ack(self, payload: Dict[str, Any]) -> None:
        if not self.asyncapi.get("publish_command_mission_ack", True):
            return
        msg_id = str(payload.get("mqtt_payload_id") or payload.get("msg_id") or payload.get("command_id") or uuid.uuid4())
        self.mqtt.publish_json(f"flyinglet/{self.f_cd}/command/mission/ack", {"msg_id": msg_id, "timestamp": now_kst_compact()}, indent=2)

    def _publish_backend_response(self, command_id: str, cmd: str, ok: bool, result: Optional[Dict[str, Any]] = None, error: Optional[str] = None) -> None:
        topic = f"flyinglet/{self.f_cd}/robot/command/response"
        response = command_response_payload(command_id, cmd, ok, result, error)
        if self.emit_backend_topics:
            self.mqtt.publish_json(topic, response, indent=2)
        log_bridge_info(
            "[MQTT_COMMAND_RESPONSE] topic=%s command_id=%s type=%s success=%s error=%s emit=%s",
            topic,
            command_id,
            cmd,
            ok,
            error or "",
            self.emit_backend_topics,
        )

    def _publish_running(self) -> None:
        if self.emit_backend_topics:
            self.mqtt.publish_json(
                f"flyinglet/{self.f_cd}/robot/mission/status",
                mission_status_payload(self.robot_id, "running", self.backend),
                indent=2,
            )

    def _publish_completed(self) -> None:
        command_id = self.last_play_command_id or str(uuid.uuid4())
        if self.emit_backend_topics:
            self.mqtt.publish_json(
                f"flyinglet/{self.f_cd}/robot/mission/status",
                mission_status_payload(self.robot_id, "success", self.backend),
                indent=2,
            )
            self.mqtt.publish_json(
                f"flyinglet/{self.f_cd}/robot/events",
                mission_completed_event(self.robot_id, command_id),
                indent=2,
            )
        LOG.info("ROS COMPLETED �� MQTT �꾨즺 �곹깭 諛쒗뻾")

    def handle_mqtt_command(self, topic: str, payload: Any) -> None:
        parsed = self._parse_payload(payload)
        if parsed is None:
            return
        if topic.endswith("/command/mission"):
            self._publish_ack(parsed)
        command_id = str(parsed.get("command_id") or parsed.get("mqtt_payload_id") or uuid.uuid4())
        cmd = self._command_type(parsed)
        params = parsed.get("parameters") if isinstance(parsed.get("parameters"), dict) else {}
        raw_type = str(
            parsed.get("type")
            or parsed.get("command_type")
            or parsed.get("command")
            or parsed.get("action")
            or parsed.get("x")
            or "",
        )
        param_keys = ",".join(sorted(params.keys())) if params else "-"
        log_bridge_info(
            "[MQTT_COMMAND_RECEIVE] topic=%s command_id=%s normalized_type=%s raw_type=%s param_keys=%s",
            topic,
            command_id,
            cmd,
            raw_type or "(empty)",
            param_keys,
        )
        log_bridge_info(
            "[CMD�뭃OS] step=route command_id=%s mqtt_topic=%s backend=%s normalized_cmd=%s",
            command_id,
            topic,
            self.backend,
            cmd,
        )
        raw_action = str(parsed.get("type") or parsed.get("command_type") or parsed.get("command") or parsed.get("action") or parsed.get("x") or "").lower()
        if raw_action == "resume":
            params["resume_only"] = True
        for key in ("path_csv", "path_file", "mission_name"):
            if parsed.get(key) and key not in params:
                params[key] = parsed[key]
        if cmd == "move_velocity" and "v_x" not in params and "v_x" in parsed:
            params["v_x"] = parsed["v_x"]
        with self.lock:
            try:
                self._dispatch(command_id, cmd, params)
            except Exception as exc:
                LOG.exception("紐낅졊 泥섎━ �ㅽ뙣")
                self._publish_backend_response(command_id, cmd, False, {"error": str(exc)}, str(exc))

    def _parse_payload(self, payload: Any) -> Optional[Dict[str, Any]]:
        if isinstance(payload, str):
            try:
                payload = json.loads(payload)
            except json.JSONDecodeError:
                LOG.warning("JSON 媛앹껜媛� �꾨땶 MQTT payload 臾댁떆: %r", payload[:80])
                return None
        if not isinstance(payload, dict):
            LOG.warning("MQTT payload�� JSON 媛앹껜�ъ빞 �⑸땲��.")
            return None
        inner = payload.get("data") or payload.get("payload") or payload.get("body")
        if isinstance(inner, dict) and not any(k in payload for k in ("type", "command_type", "command", "action", "x")):
            return inner
        return payload

    def _command_type(self, payload: Dict[str, Any]) -> str:
        raw = payload.get("type") or payload.get("command_type") or payload.get("command") or payload.get("action") or payload.get("x")
        value = str(raw or "").strip().lower()
        return {
            "start": "play_mission",
            "resume": "play_mission",
            "run": "play_mission",
            "play": "play_mission",
            "pause": "freeze",
            "cancel": "stop",
        }.get(value, value or "play_mission")

    def _dispatch(self, command_id: str, cmd: str, params: Dict[str, Any]) -> None:
        if cmd == "mission_result_acquire_and_upload":
            log_bridge_info(
                "[CMD�뭃OS] step=handler command_id=%s handler=mission_upload (ROS 誘몄궗��, HTTP �낅줈��)",
                command_id,
            )
            self._dispatch_mission_result_upload(command_id, cmd, params)
            return
        if self.backend == "mo2":
            self._dispatch_mo2(command_id, cmd, params)
        else:
            self._dispatch_platy(command_id, cmd, params)

    def _dispatch_mission_result_upload(self, command_id: str, cmd: str, params: Dict[str, Any]) -> None:
        cfg = self.cfg.get("mission_result_upload") or {}
        endpoint_url = str(cfg.get("endpoint_url") or "").strip()
        image_root_cfg = cfg.get("image_root_dir") or "/home/nvidia/images"
        image_root_dir = Path(str(image_root_cfg)).expanduser()
        timeout_sec = float(cfg.get("timeout_sec") or 10)
        secret = str(cfg.get("secret") or "").strip()
        secret_transport = str(cfg.get("secret_transport") or "header").strip().lower()
        secret_header_name = str(cfg.get("secret_header_name") or "X-Demo-Secret").strip()
        verify_ssl = bool(cfg.get("verify_ssl", True))
        if not endpoint_url:
            self._publish_backend_response(command_id, cmd, False, {}, "missing_endpoint_url")
            return

        image_path = self._resolve_image_path(params, image_root_dir)
        if image_path is None:
            self._publish_backend_response(command_id, cmd, False, {}, f"image_not_found:{image_root_dir}")
            return

        try:
            with open(image_path, "rb") as f:
                image_bytes = f.read()
            boundary = f"----bridgeBoundary{uuid.uuid4().hex}"
            form_fields = {
                "robotId": params.get("robotId") or self.robot_id,
                "missionExecSeq": params.get("missionExecSeq"),
                "fPerMissionId": params.get("fPerMissionId"),
                "missionName": params.get("missionName"),
                "payloadType": params.get("payloadType"),
                "channelNm": params.get("channelNm"),
                "localizationTimestamp": params.get("localizationTimestamp"),
            }
            if secret and secret_transport == "form":
                form_fields["secret"] = secret
            body = _build_multipart_form_body("file", image_path.name, image_bytes, boundary, form_fields)
            headers = {
                "Content-Type": f"multipart/form-data; boundary={boundary}",
                "Content-Length": str(len(body)),
            }
            if secret and secret_transport == "header":
                headers[secret_header_name] = secret
            parsed_ep = urlparse(endpoint_url)
            ssl_ctx: Optional[ssl.SSLContext] = None
            if parsed_ep.scheme.lower() == "https":
                if not verify_ssl:
                    ssl_ctx = ssl._create_unverified_context()
                    log_step_fail(
                        "MISSION_UPLOAD",
                        "verify_ssl=false 濡� HTTPS �몄쬆�� 寃�利앹쓣 ��(�댁쁺 �섍꼍�먯꽌�� �ъ슜�섏� 留� 寃�)",
                    )
            urlopen_kw: Dict[str, Any] = {"timeout": timeout_sec}
            if ssl_ctx is not None:
                urlopen_kw["context"] = ssl_ctx

            dns_extra = max(0, min(10, int(cfg.get("dns_fail_retry_extra", 2))))
            dns_backoff = max(0.1, float(cfg.get("dns_fail_retry_backoff_sec") or 1.0))
            attempts_total = 1 + dns_extra
            status_code = 0
            response_body = ""

            for attempt_idx in range(attempts_total):
                request = Request(endpoint_url, data=body, method="POST", headers=headers)
                try:
                    with urlopen(request, **urlopen_kw) as response:
                        status_code = int(getattr(response, "status", 200))
                        response_body = response.read().decode("utf-8", errors="replace")
                    break
                except HTTPError:
                    raise
                except URLError as ue:
                    if (
                        attempt_idx < attempts_total - 1
                        and _is_dns_related_urLError(ue)
                    ):
                        log_step_fail(
                            "MISSION_UPLOAD",
                            "�낅줈�� URLError (DNS쨌�대쫫�댁꽍 ��, �ъ떆�� %s/%s): %s",
                            attempt_idx + 1,
                            attempts_total,
                            ue.reason if getattr(ue, "reason", None) is not None else ue,
                        )
                        time.sleep(dns_backoff)
                        continue
                    raise

            ok = 200 <= status_code < 300
            if ok:
                self._publish_backend_response(
                    command_id,
                    cmd,
                    True,
                    {"uploaded_file": str(image_path), "status_code": status_code, "response_body": response_body},
                )
                return
            self._publish_backend_response(
                command_id,
                cmd,
                False,
                {"uploaded_file": str(image_path), "status_code": status_code, "response_body": response_body},
                f"http_status:{status_code}",
            )
        except HTTPError as exc:
            status_code = int(getattr(exc, "code", 500))
            try:
                response_body = exc.read().decode("utf-8", errors="replace")
            except Exception:
                response_body = str(exc)
            self._publish_backend_response(
                command_id,
                cmd,
                False,
                {"uploaded_file": str(image_path), "status_code": status_code, "response_body": response_body},
                f"http_status:{status_code}",
            )
        except URLError as exc:
            reason = str(exc.reason) if getattr(exc, "reason", None) is not None else str(exc)
            hint = ""
            low = reason.lower()
            if "not yet valid" in low or "certificate has expired" in low:
                hint = "; hint: sync_system_time_ntp_chrony"
            elif "certificate verify failed" in low or "sslcert" in low:
                hint = "; hint: check_ca_bundle_or_mission_result_upload.verify_ssl_dev_only"
            elif _is_dns_related_urLError(exc):
                host = urlparse(endpoint_url).hostname or ""
                hint = (
                    "; hint: dns_resolve_failed_check_internet_resolv.conf_or_systemd_resolved"
                    f" ping_nslookup_host={host!r}"
                )
            log_step_fail("MISSION_UPLOAD", "�낅줈�� URLError: %s%s", reason, hint)
            self._publish_backend_response(
                command_id,
                cmd,
                False,
                {"uploaded_file": str(image_path), "url_error": reason},
                f"upload_failed:{exc}{hint}",
            )
        except Exception as exc:
            self._publish_backend_response(
                command_id,
                cmd,
                False,
                {"uploaded_file": str(image_path)},
                f"upload_failed:{exc}",
            )

    def _resolve_image_path(self, params: Dict[str, Any], image_root_dir: Path) -> Optional[Path]:
        explicit_path = params.get("image_path")
        root = Path(image_root_dir).expanduser()
        if isinstance(explicit_path, str) and explicit_path.strip():
            raw = explicit_path.strip().strip("\"'").replace("\\", "/")
            # ~ �� expanduser �� �섎㈃ Path.is_file() �� ��긽 �ㅽ뙣��
            p = Path(raw).expanduser()
            if p.is_file():
                return _normalize_existing_path(p)
            # �곷� 寃쎈줈 臾몄옄�� �꾩껜瑜� image_root 湲곗��쇰줈 �ъ떆��
            if not p.is_absolute() and root.is_dir():
                q = root / raw.lstrip("/")
                if q.is_file():
                    return _normalize_existing_path(q)
            # �섎せ�� �섏쐞 �붾젆�곕━(��: epoch �쒓퀎 �ㅻ쪟 �� 1970-01-01)�몃뜲 �뚯씪紐낆� 留욎쓣 �� �� image_root �댄븯 媛숈� �대쫫 理쒖떊 �섏젙蹂�
            basename = Path(raw).name
            if basename and ("." in basename) and root.is_dir():
                best: Optional[Path] = None
                best_mtime = -1.0
                try:
                    for cand in root.rglob(basename):
                        if not cand.is_file():
                            continue
                        try:
                            mt = cand.stat().st_mtime
                        except OSError:
                            continue
                        if mt > best_mtime:
                            best_mtime = mt
                            best = cand
                except OSError:
                    pass
                if best is not None:
                    LOG.info(
                        "�대�吏�: 紐낆떆 寃쎈줈 �놁쓬 �먮뒗 誘몃컻寃� �� image_root �먯꽌 媛숈� �뚯씪紐� 理쒖떊 �섏젙蹂� �ъ슜: %s (�붿껌 寃쎈줈=%r)",
                        best,
                        raw[:200],
                    )
                    return _normalize_existing_path(best)
        if not root.exists():
            return None
        latest_path: Optional[Path] = None
        latest_mtime = -1.0
        for image_path in root.rglob("*.jpg"):
            try:
                mtime = image_path.stat().st_mtime
            except OSError:
                continue
            if mtime > latest_mtime:
                latest_mtime = mtime
                latest_path = image_path
        return latest_path

    def _dispatch_mo2(self, command_id: str, cmd: str, params: Dict[str, Any]) -> None:
        mo2 = (self.cfg.get("ros") or {}).get("mo2") or {}
        if cmd == "move_velocity":
            # 諛깆뿏�� move_velocity: v_x �뚯닔 �� pause(湲곕낯 1), �묒닔 �� resume/start(湲곕낯 2) �� mission_command Int32
            v_x_raw = params.get("v_x", 0)
            try:
                v_x = float(v_x_raw)
            except Exception:
                log_bridge_info(
                    "[CMD�뭃OS] step=skip command_id=%s reason=invalid_v_x raw=%r (ROS 諛쒗뻾 �놁쓬)",
                    command_id,
                    v_x_raw,
                )
                self._publish_backend_response(command_id, cmd, False, None, f"invalid_v_x:{v_x_raw}")
                return
            val_pause = int(mo2.get("value_pause", 1))
            val_resume = int(mo2.get("value_start", 2))
            if v_x < 0:
                self._publish_int32(self.pub_mo2_cmd, val_pause, command_id, cmd, params)
                return
            if v_x > 0:
                self._publish_int32(self.pub_mo2_cmd, val_resume, command_id, cmd, params)
                self._publish_running()
                return
            log_bridge_info(
                "[CMD�뭃OS] step=skip command_id=%s reason=v_x_zero (ROS 諛쒗뻾 �놁쓬, move_velocity)",
                command_id,
            )
            self._publish_backend_response(command_id, cmd, True, {"no_op": True, "reason": "v_x_zero", "dry_run": self.dry_run})
            return
        values = {
            "play_mission": int(mo2.get("value_start", 2)),
            "freeze": int(mo2.get("value_pause", 1)),
            "stop": int(mo2.get("value_cancel", 0)),
            "mission_clear": int(mo2.get("value_cancel", 0)),
        }
        if cmd not in values:
            log_bridge_info(
                "[CMD�뭃OS] step=skip command_id=%s reason=unsupported_command cmd=%s (ROS 諛쒗뻾 �놁쓬)",
                command_id,
                cmd,
            )
            self._publish_backend_response(
                command_id,
                cmd,
                True,
                {"skipped": True, "reason": "unsupported_command", "command": cmd},
            )
            return
        if cmd == "play_mission":
            self.last_play_command_id = command_id
        self._publish_int32(self.pub_mo2_cmd, values[cmd], command_id, cmd, params)
        if cmd == "play_mission":
            self._publish_running()

    def _dispatch_platy(self, command_id: str, cmd: str, params: Dict[str, Any]) -> None:
        platy = (self.cfg.get("ros") or {}).get("platy") or {}
        # Backend �댁쁺 �ㅽ럺: type=play_mission|set_control_mode|move_velocity
        if cmd == "play_mission" and params.get("resume_only"):
            self.last_play_command_id = command_id
            self._publish_int32(self.pub_platy_move, 2, command_id, cmd, params)
            self._publish_running()
            return
        if cmd == "play_mission":
            path = str(params.get("path_csv") or params.get("path_file") or params.get("mission_name") or platy.get("default_path_csv") or "0100m16_4floor_1.csv")
            self.last_play_command_id = command_id
            topic = str(platy.get("path_run_request_topic", "/path_run_request"))
            if self.dry_run:
                preview = path if len(path) <= 160 else path[:160] + "..."
                log_cmd_to_ros(command_id, topic, "String", preview, True)
            else:
                msg = String()
                msg.data = path
                self.pub_platy_run.publish(msg)
                preview = path if len(path) <= 160 else path[:160] + "..."
                log_cmd_to_ros(command_id, topic, "String", preview, False)
            self._publish_backend_response(command_id, cmd, True, {"path_csv": path, "dry_run": self.dry_run})
            self._publish_running()
            return
        if cmd == "set_control_mode":
            mode = str(params.get("mode") or "").strip().lower()
            if mode == "manual":
                # �섎룞紐⑤뱶 �쒖옉�� pause �숈옉�쇰줈 �곌껐
                self._publish_int32(self.pub_platy_move, 1, command_id, cmd, params)
                return
            if mode == "autonomous":
                # �섎룞紐⑤뱶 醫낅즺�� resume �숈옉�쇰줈 �곌껐
                self._publish_int32(self.pub_platy_move, 2, command_id, cmd, params)
                self._publish_running()
                return
            log_bridge_info(
                "[CMD�뭃OS] step=skip command_id=%s reason=unsupported_mode mode=%r (ROS 諛쒗뻾 �놁쓬)",
                command_id,
                mode,
            )
            self._publish_backend_response(command_id, cmd, False, None, f"unsupported_mode:{mode}")
            return
        if cmd == "move_velocity":
            # �붿껌�ы빆: �섎룞議곗옉 S=�쇱떆以묒�, W=�ш컻
            v_x_raw = params.get("v_x", 0)
            try:
                v_x = float(v_x_raw)
            except Exception:
                log_bridge_info(
                    "[CMD�뭃OS] step=skip command_id=%s reason=invalid_v_x raw=%r (ROS 諛쒗뻾 �놁쓬)",
                    command_id,
                    v_x_raw,
                )
                self._publish_backend_response(command_id, cmd, False, None, f"invalid_v_x:{v_x_raw}")
                return
            move_topic = str(platy.get("move_request_topic", "/move_request"))
            if v_x < 0:
                self._publish_int32(self.pub_platy_move, 1, command_id, cmd, params)
                return
            if v_x > 0:
                self._publish_int32(self.pub_platy_move, 2, command_id, cmd, params)
                self._publish_running()
                return
            # 0�� �곹깭 �좎�濡� �깃났 �묐떟留� 諛섑솚
            log_bridge_info(
                "[CMD�뭃OS] step=skip command_id=%s reason=v_x_zero (ROS 諛쒗뻾 �놁쓬, move_velocity)",
                command_id,
            )
            self._publish_backend_response(command_id, cmd, True, {"no_op": True, "reason": "v_x_zero", "dry_run": self.dry_run})
            return
        if cmd == "freeze":
            self._publish_int32(self.pub_platy_move, 1, command_id, cmd, params)
            return
        if cmd in ("stop", "mission_clear"):
            topic = str(platy.get("path_run_cancel_topic", "/path_run_cancel_request"))
            if self.dry_run:
                log_cmd_to_ros(command_id, topic, "Empty", "-", True)
            else:
                self.pub_platy_cancel.publish(Empty())
                log_cmd_to_ros(command_id, topic, "Empty", "-", False)
            self._publish_backend_response(command_id, cmd, True, {"cancel": True, "dry_run": self.dry_run})
            return
        log_bridge_info(
            "[CMD�뭃OS] step=skip command_id=%s reason=unsupported_command cmd=%s (ROS 諛쒗뻾 �놁쓬)",
            command_id,
            cmd,
        )
        self._publish_backend_response(
            command_id,
            cmd,
            True,
            {"skipped": True, "reason": "unsupported_command", "command": cmd},
        )

    def _publish_int32(self, publisher: Any, value: int, command_id: str, cmd: str, params: Dict[str, Any]) -> None:
        topic = None
        if self.backend == "platy":
            topic = str(((self.cfg.get("ros") or {}).get("platy") or {}).get("move_request_topic", "/move_request"))
        elif self.backend == "mo2":
            topic = str(((self.cfg.get("ros") or {}).get("mo2") or {}).get("mission_command_topic", "/mission_command"))
        if self.dry_run:
            log_cmd_to_ros(command_id, str(topic), "Int32", str(int(value)), True)
        else:
            msg = Int32()
            msg.data = int(value)
            publisher.publish(msg)
            log_cmd_to_ros(command_id, str(topic), "Int32", str(int(value)), False)
        self._publish_backend_response(command_id, cmd, True, {"int32": value, "parameters": params, "dry_run": self.dry_run})


def setup_logging(verbose: bool) -> None:
    logging.basicConfig(
        level=logging.DEBUG if verbose else logging.INFO,
        format="%(asctime)s %(levelname)s %(name)s - %(message)s",
    )


def main() -> None:
    parser = argparse.ArgumentParser(description="Standalone MQTT �� ROS topic bridge for MO2/Platy")
    parser.add_argument("--config", default=str(Path(__file__).with_name("ros_topic_mqtt_bridge.yaml")), help="YAML �ㅼ젙 �뚯씪")
    parser.add_argument("--dry-run", action="store_true", help="ROS �놁씠 MQTT留� 寃�利�")
    parser.add_argument("--verbose", action="store_true", help="�붾쾭洹� 濡쒓렇")
    args = parser.parse_args()
    setup_logging(args.verbose)

    bridge = RosTopicBridge(load_yaml(Path(args.config)), dry_run_override=args.dry_run)
    stop_event = threading.Event()
    signal.signal(signal.SIGINT, lambda *_: stop_event.set())
    signal.signal(signal.SIGTERM, lambda *_: stop_event.set())
    bridge.start()
    next_ros_retry = 0.0
    log_step("RUN_LOOP", "硫붿씤 猷⑦봽 吏꾩엯")
    try:
        while not stop_event.is_set():
            if not bridge.dry_run and not bridge.ros_ready and time.monotonic() >= next_ros_retry:
                log_step("RUN_LOOP", "ROS 誘몄�鍮� �곹깭 媛먯�, 5珥� 二쇨린 �ъ떆�� �ㅽ뻾")
                next_ros_retry = time.monotonic() + 5.0
                bridge._try_init_ros()
            if not bridge.dry_run and bridge.ros_ready and ROS_AVAILABLE and rospy.is_shutdown():
                log_step_fail("RUN_LOOP", "rospy shutdown 媛먯�, 釉뚮━吏� 醫낅즺")
                break
            stop_event.wait(0.5)
    finally:
        log_step("RUN_LOOP", "硫붿씤 猷⑦봽 醫낅즺")
        bridge.stop()


if __name__ == "__main__":
    main()

