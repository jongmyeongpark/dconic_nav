import threading
import time
from collections import deque

import socketio


STREAM_NAME_TO_CAM_NAME = {
    "front": "FRONT-CAM",
    "back": "REAR-CAM",
    "left": "LEFT-CAM",
    "right": "RIGHT-CAM",
    "thermal": "THERMAL-CAM",
    "front-thermal": "THERMAL-CAM",
}


def _socketio_base_url(host: str) -> str:
    host = host or "http://localhost:3000"
    if host.startswith("wss://"):
        return "https://" + host[len("wss://"):]
    if host.startswith("ws://"):
        return "http://" + host[len("ws://"):]
    return host


def _as_bool(value, default=True) -> bool:
    if value is None:
        return default
    if isinstance(value, bool):
        return value
    return str(value).strip().lower() not in ("0", "false", "no", "off")


def _cam_name_for(stream_name: str, explicit_cam_name: str = None) -> str:
    if explicit_cam_name:
        return explicit_cam_name
    normalized = str(stream_name).lower()
    return STREAM_NAME_TO_CAM_NAME.get(normalized, str(stream_name).upper())


class WSClient:
    """Socket.IO signaling client for mediasoup Plain RTP producer setup."""

    _instance = None
    _initialized = False

    def __new__(cls, *args, **kwargs):
        if cls._instance is None:
            cls._instance = super(WSClient, cls).__new__(cls)
            print("[SINGLETON] Creating new instance")
        else:
            print("[SINGLETON] Returning existing instance")
        return cls._instance

    def __init__(
        self,
        host: str,
        auth_key: str,
        robot_id: str,
        serial=None,
        logger=None,
        cert_path=None,
        verify_ssl=True,
    ) -> None:
        if self._initialized:
            self.logger.info("[SINGLETON] Using existing WSClient instance")
            return

        if logger is None:
            logger = serial
            serial = ""

        self.logger = logger
        self.host = _socketio_base_url(host)
        self.robot_id = robot_id
        self.header = {
            "authorization": "secret-token",
            "x-api-key": auth_key,
            "x-robot-id": robot_id,
            "x-serial": str(serial),
        }

        verify_ssl = _as_bool(verify_ssl, default=True)
        use_ssl = self.host.lower().startswith("https://")
        ssl_verify = False
        if use_ssl and verify_ssl:
            ssl_verify = cert_path if cert_path else True

        self.sio = socketio.Client(
            reconnection=False,
            ssl_verify=ssl_verify,
            logger=False,
            engineio_logger=False,
        )
        self.sio.on("connect", self._on_open)
        self.sio.on("disconnect", self._on_close)
        self.sio.on("connect_error", self._on_error)
        self.sio.on("consumer-added", self._on_optional_event("consumer-added"))
        self.sio.on("consumer-removed", self._on_optional_event("consumer-removed"))

        self._on_callbacks = {}
        self.message_queue = deque()
        self._connected_event = threading.Event()
        self._call_timeout_sec = 10
        self.is_connecting = False
        self.is_interupted = False
        self.is_connected = False

        self.logger.info(f"[SINGLETON] Creating new WSClient instance - Socket.IO {self.host}")
        self._initialized = True

    def _run_callback(self, action, *args, background=False):
        callback = self._on_callbacks.get(action)
        if not callback:
            return

        def _safe_call():
            try:
                callback(*args)
            except Exception as error:
                self.logger.error(f"Callback for action {action} failed: {error}")

        if background:
            threading.Thread(target=_safe_call, daemon=True).start()
        else:
            _safe_call()

    def _on_optional_event(self, action):
        def _handler(data=None):
            if action in self._on_callbacks:
                self._run_callback(action, data, background=True)
            else:
                self.logger.info(f"Socket.IO event ignored: {action} {data}")
        return _handler

    def _on_open(self) -> None:
        self.logger.info("Socket.IO connected")
        self.is_connected = True
        self.is_connecting = False
        self._connected_event.set()
        self._flush_queued_messages()
        self._run_callback("connected", background=True)

    def _on_close(self) -> None:
        was_connected = self.is_connected
        self.is_connected = False
        self.is_connecting = False
        self._connected_event.clear()
        self.logger.info("Socket.IO disconnected")
        if was_connected:
            self._run_callback("disconnected", background=True)

    def _on_error(self, error=None) -> None:
        self.logger.error(f"Socket.IO error: {error}")
        self._connected_event.clear()
        self._run_callback("error", str(error), background=True)

    def _wait_until_connected(self, timeout_sec: float = 5.0) -> None:
        if self.sio.connected and self.is_connected:
            return
        if self._connected_event.wait(timeout_sec) and self.sio.connected and self.is_connected:
            return
        raise RuntimeError(f"Socket.IO not connected (timeout={timeout_sec}s)")

    def _flush_queued_messages(self):
        while self.message_queue and self.sio.connected:
            action, payload = self.message_queue.popleft()
            self.send(action, payload)

    def join(self) -> None:
        """Create or reuse the mediasoup channel for this robot."""
        last_error = None
        for _ in range(20):
            try:
                if not self.sio.connected or not self.is_connected:
                    time.sleep(0.25)
                    continue
                response = self.sio.call("create-channel", self.robot_id, timeout=self._call_timeout_sec)
                if isinstance(response, dict) and response.get("error"):
                    raise RuntimeError(response["error"])
                self.logger.info(f"Mediasoup channel ready: {self.robot_id}, response={response}")
                return
            except Exception as error:
                last_error = error
                time.sleep(0.25)

        error_message = f"create-channel failed: {last_error or 'socket not connected'}"
        self.logger.error(error_message)
        self._run_callback("error", str(last_error or "socket not connected"), background=True)

    def connect(self) -> None:
        """Connect to Socket.IO and keep retrying until interrupted."""
        if self.is_connecting or self.is_interupted:
            self.logger.info("[SINGLETON] Already connecting or interrupted, skipping...")
            return

        while not self.is_interupted:
            try:
                self.logger.info("[SINGLETON] Starting Socket.IO connection...")
                self.is_connecting = True
                self.sio.connect(
                    self.host,
                    headers=self.header,
                    transports=["websocket"],
                    wait_timeout=10,
                    socketio_path="/socket.io",
                )
                self.sio.wait()
            except Exception as error:
                self.is_connecting = False
                if not self.is_interupted:
                    self.logger.error(f"Socket.IO connection error: {error}")
                    self._run_callback("error", str(error), background=True)

            if not self.is_interupted:
                self.logger.info("Reconnecting to Socket.IO...")
                time.sleep(3)

    def disconnect(self) -> None:
        try:
            self.is_interupted = True
            self._connected_event.clear()
            if self.sio.connected:
                self.sio.disconnect()
        except Exception as error:
            self.logger.error(f"Socket.IO disconnect error: {error}")

    def _start_plain_rtp_producer(self, payload: dict) -> None:
        stream_name = payload.get("stream_name")
        if not stream_name:
            raise RuntimeError("stream_name is required")

        request = {
            "fcd": self.robot_id,
            "streamName": stream_name,
            "camName": _cam_name_for(stream_name, payload.get("camName")),
            "kind": "video",
            "codec": payload.get("codec", "H264"),
            "security": payload.get("security", False),
        }
        response = self.sio.call("create-plain-rtp-producer", request, timeout=self._call_timeout_sec)
        if not isinstance(response, dict):
            raise RuntimeError("create-plain-rtp-producer returned invalid response")
        if response.get("error"):
            raise RuntimeError(response["error"])

        response["stream_name"] = response.get("stream_name") or stream_name
        response["host"] = response["host"]
        response["rtp_port"] = response["rtp_port"]
        response["rtcp_port"] = response.get("rtcp_port", -1)
        response["payload_type"] = response["payload_type"]
        response["ssrc"] = response["ssrc"]
        response.setdefault("srtp_key", None)
        response.setdefault("srtp_salt", None)

        self.logger.info(
            f"Plain RTP producer ready: stream={stream_name} cam={response.get('camName')} "
            f"rtp={response.get('host')}:{response.get('rtp_port')} "
            f"pt={response.get('payload_type')} ssrc={response.get('ssrc')}"
        )
        self._run_callback("producer/start", response, background=False)

    def _stop_plain_rtp_producer(self, payload: dict) -> None:
        stream_name = payload.get("stream_name")
        if not stream_name:
            raise RuntimeError("stream_name is required")

        request = {
            "fcd": self.robot_id,
            "streamName": stream_name,
            "camName": _cam_name_for(stream_name, payload.get("camName")),
        }
        response = self.sio.call("close-plain-rtp-producer", request, timeout=self._call_timeout_sec)
        if isinstance(response, dict) and response.get("error"):
            raise RuntimeError(response["error"])
        self.logger.info(f"Plain RTP producer closed: stream={stream_name}")

    def send(self, action: str, payload: dict) -> None:
        """Send an action through the current Socket.IO signaling protocol."""
        if not self.sio.connected or not self.is_connected:
            self.message_queue.append((action, payload))
            self.logger.info(f"Socket.IO not connected yet. Queueing action={action}")
            return

        try:
            if action == "producer/start":
                self._start_plain_rtp_producer(payload)
                return
            if action == "producer/stop":
                self._stop_plain_rtp_producer(payload)
                return

            self.sio.emit(action, {"robot_id": self.robot_id, "payload": payload})
        except Exception as error:
            self.logger.error(f"Socket.IO send failed: action={action} error={error}")
            self._run_callback("error", str(error), background=True)

    def on(self, action: str, callback) -> None:
        if action in self._on_callbacks:
            raise Exception(f"Callback for action {action} already exists")
        self._on_callbacks[action] = callback

    def off(self, action: str) -> None:
        if action not in self._on_callbacks:
            raise Exception(f"Callback for action {action} does not exist")
        del self._on_callbacks[action]

    def on_error(self, callback) -> None:
        self._on_callbacks["error"] = callback
