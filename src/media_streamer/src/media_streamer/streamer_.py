# -*- coding: utf-8 -*-
import time
import base64
import threading
from enum import Enum
from dataclasses import dataclass

import gi
gi.require_version('Gst', '1.0')
gi.require_version('GObject', '2.0')
from gi.repository import Gst, GObject

from media_streamer.model.frame_model import FrameModel
import media_streamer.logger as Logger
import inject

from media_streamer.model.producer_model import (
    ProducerModel, ProducerObserver, ProducerConnection
)

# GStreamer init
Gst.init(None)

logger = inject.attr(Logger.Logger)


class StreamState(Enum):
    IDLE = 0
    STARTED = 1
    STOPPED = 2


@dataclass
class RtpConnectionInfo:
    host: str
    port: int
    rtcp_port: int
    payload_type: int
    ssrc: int
    srtp_key: str = None
    srtp_salt: str = None


def _make_or_none(factory: str, name: str):
    el = Gst.ElementFactory.make(factory, name)
    return el


def _first_available(names):
    """names = [(factory, name_for_debug), ...]"""
    for f, n in names:
        el = _make_or_none(f, n)
        if el:
            return el, f
    return None, None


class Streamer(threading.Thread):
    _state = StreamState.IDLE
    pipeline = None

    def __init__(self, stream_name, security) -> None:
        threading.Thread.__init__(self)
        self.loop = None
        self._name = stream_name
        self.security = security

    @property
    def name(self):
        return self._name

    def _change_state(self, state: StreamState):
        self._state = state
        print(f"state changed ({self.name}) = {state}")

    def _start_pipeline(self):
        self.pipeline.set_state(Gst.State.PLAYING)
        self._change_state(StreamState.STARTED)

    def set_connection_info(self, connection_info: RtpConnectionInfo):
        pass

    def get_state(self) -> StreamState:
        return self._state

    def run(self):
        print("start pipeline")
        try:
            self._start_pipeline()
            self.loop = GObject.MainLoop()
            self.loop.run()
        except Exception as err:
            print(f"thread exception! err = {err}".format(err=err))

    def close(self):
        try:
            self._change_state(StreamState.STOPPED)
            self.pipeline.set_state(Gst.State.NULL)
            if self.loop:
                self.loop.quit()
        except Exception as err:
            print(f"close exception! err = {err}".format(err=err))


class AppStreamer(Streamer):
    """
    RTP/H264 (+ 선택적 SRTP) 송신 공통부.
    상위 체인(소스~H264)은 self._set_video_source_element()로 payloader에 붙입니다.
    """

    def __init__(self, name: str, security=True) -> None:
        super().__init__(name, security)
        self.pipeline = Gst.Pipeline()
        self.bus = self.pipeline.get_bus()

        # payloader
        self.rtph264pay = _make_or_none("rtph264pay", f"rtph264pay_{name}")
        if not self.rtph264pay:
            raise RuntimeError("Failed to create rtph264pay")
        # 주기적으로 SPS/PPS 삽입
        self.rtph264pay.set_property("config-interval", 1)

        # UDP sink
        self.udpsink = _make_or_none("udpsink", f"udpsink_{name}")
        if not self.udpsink:
            raise RuntimeError("Failed to create udpsink")
        self.udpsink.set_property("sync", False)
        self.udpsink.set_property("async", False)

        self.pipeline.add(self.rtph264pay)
        self.pipeline.add(self.udpsink)

        # SRTP(Optional)
        if security:
            self.srtpenc = _make_or_none("srtpenc", f"srtpenc_{name}")
            if not self.srtpenc:
                raise RuntimeError("Failed to create srtpenc")
            self.pipeline.add(self.srtpenc)
            if not self.rtph264pay.link(self.srtpenc):
                raise RuntimeError("Failed to link rtph264pay->srtpenc")
            if not self.srtpenc.link(self.udpsink):
                raise RuntimeError("Failed to link srtpenc->udpsink")
        else:
            if not self.rtph264pay.link(self.udpsink):
                raise RuntimeError("Failed to link rtph264pay->udpsink")

        self.loop = GObject.MainLoop()

    def _set_video_source_element(self, last_element_before_pay: Gst.Element):
        """H.264 출력 요소(last) → payloader"""
        if not last_element_before_pay.link(self.rtph264pay):
            raise RuntimeError("Failed to link video chain to rtph264pay")

    def _start_pipeline(self):
        self.bus.add_signal_watch()
        super()._start_pipeline()

    def set_connection_info(self, connection_info: RtpConnectionInfo):
        print(f"set connection info ({self.name})  = {connection_info}")

        self.rtph264pay.set_property("pt", connection_info.payload_type)
        self.rtph264pay.set_property("ssrc", connection_info.ssrc)

        if self.security and connection_info.srtp_key:
            key_bytes = base64.b64decode(connection_info.srtp_key)
            buf = Gst.Buffer.new_wrapped(key_bytes)
            self.srtpenc.set_property("key", buf)

        self.udpsink.set_property("host", connection_info.host)
        self.udpsink.set_property("port", connection_info.port)


class RosStreamer(AppStreamer):
    """
    ROS CompressedImage(JPEG) → (nvjpegdec/avdec_mjpeg/jpegdec) → (nvvidconv/videoconvert)
      → [HW: NVMM+NV12 → nvv4l2h264enc] or [SW/NVENC: I420 → x264enc/nvh264enc/omx]
      → (h264parse) → rtph264pay
    """

    frame_model: FrameModel = None

    def __init__(self, stream_name: str, streamer_params: dict) -> None:
        security = streamer_params.get("security", True)

        self.topic = streamer_params.get("topic", None)
        self._frame_rate = int(streamer_params.get("frame_rate", 15))
        self._bitrate = int(streamer_params.get("bitrate", 4_000_000))
        self.msg_type = streamer_params.get("msg_type", "sensor_msgs/CompressedImage")

        if not self.topic:
            raise ValueError("topic is required")

        super().__init__(stream_name, security)

        # ---- Elements (source side)
        # appsrc (JPEG bytes from ROS)
        self._appsrc = _make_or_none("appsrc", f"appsrc_{stream_name}")
        if not self._appsrc:
            raise RuntimeError("Failed to create appsrc")

        # caps: JPEG + FPS
        caps = Gst.Caps.from_string(f"image/jpeg,framerate={self._frame_rate}/1")
        self._appsrc.set_property("caps", caps)
        self._appsrc.set_property("format", Gst.Format.TIME)
        self._appsrc.set_property("do-timestamp", True)
        self._appsrc.set_property("is-live", True)
        self._appsrc.set_property("block", False)

        # 과부하시 최신 프레임만 유지
        drop_q = _make_or_none("queue", f"dropq_{stream_name}")
        if drop_q:
            drop_q.set_property("leaky", 2)  # downstream
            drop_q.set_property("max-size-buffers", 2)
            drop_q.set_property("max-size-bytes", 0)
            drop_q.set_property("max-size-time", 0)

        jpegparse = _make_or_none("jpegparse", f"jpegparse_{stream_name}")

        # 디코더 (Jetson 우선)
        jpegdec, dec_used = _first_available([
            ("nvjpegdec", f"nvjpegdec_{stream_name}"),
            ("nvv4l2jpegdec", f"nvv4l2jpegdec_{stream_name}"),
            ("avdec_mjpeg", f"avdec_mjpeg_{stream_name}"),
            ("jpegdec", f"jpegdec_{stream_name}"),
        ])
        if not jpegdec:
            raise RuntimeError("No JPEG decoder available")

        # 컨버터 (Jetson 우선)
        conv, conv_used = _first_available([
            ("nvvidconv", f"nvvidconv_{stream_name}"),
            ("nvvideoconvert", f"nvvideoconvert_{stream_name}"),
            ("videoconvert", f"videoconvert_{stream_name}"),
        ])
        if not conv:
            raise RuntimeError("No converter available")

        # 인코더 (Jetson NVENC 우선)
        h264enc, enc_used = _first_available([
            ("nvv4l2h264enc", f"nvv4l2h264enc_{stream_name}"),
            ("omxh264enc", f"omxh264enc_{stream_name}"),  # legacy
            ("nvh264enc", f"nvh264enc_{stream_name}"),    # x86 NVENC
            ("x264enc", f"x264enc_{stream_name}"),        # CPU 폴백
        ])
        if not h264enc:
            raise RuntimeError("No H264 encoder available")

        # 인코더 옵션
        if enc_used == "nvv4l2h264enc":
            h264enc.set_property("preset-level", 1)        # 빠른 프리셋
            h264enc.set_property("control-rate", 1)        # CBR
            h264enc.set_property("bitrate", self._bitrate) # bps
            h264enc.set_property("iframeinterval", self._frame_rate * 2)
            h264enc.set_property("insert-sps-pps", True)
            h264enc.set_property("zerolatency", True)
        elif enc_used in ("omxh264enc", "nvh264enc"):
            try: h264enc.set_property("bitrate", self._bitrate)
            except Exception: pass
        else:
            # x264enc CPU 최적화
            h264enc.set_property("speed-preset", "ultrafast")
            h264enc.set_property("tune", "zerolatency")
            h264enc.set_property("threads", 2)  # 스트림 2개면 총 4스레드
            h264enc.set_property("key-int-max", self._frame_rate * 2)
            h264enc.set_property("bframes", 0)
            h264enc.set_property("byte-stream", True)
            h264enc.set_property("intra-refresh", True)
            # 일부 플러그인은 kbps 단위
            try: h264enc.set_property("bitrate", int(self._bitrate / 1000))
            except Exception: pass

        h264parse = _make_or_none("h264parse", f"h264parse_{stream_name}")
        if h264parse:
            h264parse.set_property("config-interval", 1)

        print(f"[GST] Using dec={dec_used}, conv={conv_used}, enc={enc_used}")

        # ---- Build & Link
        for el in (self._appsrc, drop_q, jpegparse, jpegdec, conv):
            if el:
                self.pipeline.add(el)

        def _safe_link(a, b, desc):
            if a and b and (not a.link(b)):
                raise RuntimeError(f"Failed to link: {desc}")

        # appsrc → (drop_q) → (jpegparse) → jpegdec
        _safe_link(self._appsrc, drop_q or jpegparse or jpegdec, "appsrc->next")
        _safe_link(drop_q, jpegparse or jpegdec, "drop_q->jpeg(parse/dec)")
        if jpegparse:
            _safe_link(jpegparse, jpegdec, "jpegparse->jpegdec")

        # 인코더 유형별로 메모리/포맷 분기
        if enc_used == "nvv4l2h264enc":
            # NVMM/NV12 → NVENC
            capsfilter_nv = _make_or_none("capsfilter", f"caps_nv12_{stream_name}")
            if not capsfilter_nv:
                raise RuntimeError("Failed to create capsfilter (NVMM)")
            capsfilter_nv.set_property(
                "caps",
                Gst.Caps.from_string("video/x-raw(memory:NVMM),format=NV12")
            )

            for el in (capsfilter_nv, h264enc, h264parse):
                if el:
                    self.pipeline.add(el)

            _safe_link(jpegdec, conv, "jpegdec->nvvidconv")
            _safe_link(conv, capsfilter_nv, "nvvidconv->caps(NVMM)")
            _safe_link(capsfilter_nv, h264enc, "caps(NVMM)->nvv4l2h264enc")

        else:
            # CPU/NVENC(x86)/OMX 경로: system memory I420
            capsfilter_cpu = _make_or_none("capsfilter", f"caps_i420_{stream_name}")
            if not capsfilter_cpu:
                raise RuntimeError("Failed to create capsfilter (I420)")
            capsfilter_cpu.set_property(
                "caps",
                Gst.Caps.from_string("video/x-raw,format=I420")
            )

            for el in (capsfilter_cpu, h264enc, h264parse):
                if el:
                    self.pipeline.add(el)

            _safe_link(jpegdec, conv, "jpegdec->conv")
            _safe_link(conv, capsfilter_cpu, "conv->caps(I420)")
            _safe_link(capsfilter_cpu, h264enc, "caps(I420)->h264enc")

        # payloader 앞 마지막 요소
        last_before_pay = h264parse if h264parse else h264enc
        self._set_video_source_element(last_before_pay)

    # ROS → appsrc
    def _on_video_frame(self, image: bytes):
        if not image:
            return

        buf = Gst.Buffer.new_wrapped(image)
        ret = self._appsrc.emit("push-buffer", buf)

        # ✅ unref 호출 금지 (PyGI에 없음)
        # buf.unref()  # ← 이 줄 삭제
        # 선택: 참조만 끊고 싶다면
        # del buf

        if ret != Gst.FlowReturn.OK:
            print(f"WARNING: appsrc push-buffer failed: {ret}")


    def _start_pipeline(self):
        super()._start_pipeline()
        RosStreamer.frame_model.add_frame_subscriber(
            self.topic, self.msg_type, self.name, self._on_video_frame
        )

    def close(self):
        super().close()
        RosStreamer.frame_model.remove_frame_subscriber(self.topic, self.name)


class RtspStreamer(Streamer):
    """(옵션) RTSP 입력 → depay → RTP 재패키징"""
    def __init__(self, stream_name: str, streamer_params: dict):
        security = streamer_params.get("security", True)
        super().__init__(stream_name, security)
        self.rtsp_url = streamer_params.get("url", None)
        if not self.rtsp_url:
            raise ValueError("url is required")

    def set_connection_info(self, connection_info: RtpConnectionInfo):
        print(f"set connection info ({self.name})  = {connection_info}")
        pt = connection_info.payload_type
        ssrc = connection_info.ssrc
        host = connection_info.host
        port = connection_info.port
        # rtcp_port = connection_info.rtcp_port  # 필요하면 확장

        pipeline_description = (
            f"rtspsrc location={self.rtsp_url} latency=100 ! "
            f"rtph264depay ! h264parse config-interval=1 ! "
            f"rtph264pay pt={pt} ssrc={ssrc} ! "
            f"udpsink host={host} port={port} sync=false async=false"
        )
        if self.security and connection_info.srtp_key:
            key_bytes = base64.b64decode(connection_info.srtp_key)
            key_str = ",".join(str(b) for b in key_bytes)
            pipeline_description = (
                f"rtspsrc location={self.rtsp_url} latency=100 ! "
                f"rtph264depay ! h264parse config-interval=1 ! "
                f"rtph264pay pt={pt} ssrc={ssrc} ! "
                f"srtpenc key={{ {key_str} }} ! "
                f"udpsink host={host} port={port} sync=false async=false"
            )

        self.pipeline = Gst.parse_launch(pipeline_description)


class StreamerManager(ProducerObserver):
    """
    스트리머 생성/관리 (Jetson 최적화 분기 포함)
    """
    def __init__(self, frame_model: FrameModel, producer_model: ProducerModel) -> None:
        self._streamers: dict[str, Streamer] = {}
        self._streamer_classes = {"ROS": RosStreamer, "RTSP": RtspStreamer}
        RosStreamer.frame_model = frame_model

        self.producer_model = producer_model
        self.producer_model.set_observer(self)

        self._streamer_params = {}
        self._is_refreshing = False
        self.is_connected = False

    def create_stream(self, stream_name: str, stream_params: dict) -> bool:
        if stream_name in self._streamers:
            return False
        self._streamer_params[stream_name] = stream_params
        if self.is_connected:
            self._open(stream_name, stream_params)
        return True

    def on_connected(self):
        print("on_connected")
        self.producer_model.connect_init()
        for stream_name, stream_params in self._streamer_params.items():
            self._open(stream_name=stream_name, stream_params=stream_params)
        self.is_connected = True

    def on_disconnected(self):
        self.is_connected = False
        print("on_disconnected")
        self.close()

    def on_error(self):
        self.refresh()

    def on_producer_open(self, stream_name: str, connection_info: ProducerConnection):
        if stream_name not in self._streamers:
            return
        info = RtpConnectionInfo(
            host=connection_info.host,
            port=connection_info.rtp_port,
            rtcp_port=connection_info.rtcp_port,
            payload_type=connection_info.payload_type,
            ssrc=connection_info.ssrc,
            srtp_key=connection_info.srtp_key,
            srtp_salt=connection_info.srtp_salt
        )
        self._streamers[stream_name].set_connection_info(info)
        self._streamers[stream_name].start()

    def on_producer_close(self, stream_name: str):
        self.close_stream(stream_name)

    def get_streamer(self, stream_name: str):
        return self._streamers.get(stream_name, None)

    def get_state(self):
        return {name: s.get_state() for name, s in self._streamers.items()}

    def close_stream(self, stream_name: str):
        s = self._streamers.get(stream_name)
        if not s:
            return
        s.close()
        self.producer_model.stop_producer(stream_name)
        del self._streamers[stream_name]

    def close(self):
        for name, s in list(self._streamers.items()):
            print(f"close stream({name})")
            s.close()
            self.producer_model.stop_producer(name)
        self._streamers.clear()

    def refresh(self):
        if self._is_refreshing or not self.is_connected:
            return
        self._is_refreshing = True
        self.producer_model.connect_init()
        time.sleep(2)
        try:
            names = list(self._streamers.keys())
            for n in names:
                self._streamers[n].close()
                self.producer_model.stop_producer(n)
            self._streamers.clear()

            self.producer_model.set_observer(None)
            time.sleep(3)
            self.producer_model.set_observer(self)

            for n in names:
                params = self._streamer_params.get(n)
                if params:
                    self._open(n, params)
        except Exception as e:
            print(e)
        self._is_refreshing = False

    def _open(self, stream_name, stream_params):
        stream_type = stream_params.get("type", None)
        cls = self._streamer_classes[stream_type]
        streamer = cls(stream_name, stream_params)
        self._streamers[stream_name] = streamer
        self.producer_model.start_producer(stream_name, stream_params.get("security", True))



__all__ = ["StreamerManager"]
