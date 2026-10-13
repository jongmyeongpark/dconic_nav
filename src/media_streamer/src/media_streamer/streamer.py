# -*- coding: utf-8 -*-
import time
from gi.repository import Gst, GObject
import gi

from enum import Enum
from dataclasses import dataclass
import threading
import base64

from media_streamer.model.frame_model import FrameModel
# from logging import Logger
import media_streamer.logger as Logger

import inject
from media_streamer.model.producer_model import ProducerModel, ProducerObserver, ProducerConnection


print(gi.__file__)

gi.require_version('Gst', '1.0')
gi.require_version('GLib', '2.0')
gi.require_version('GObject', '2.0')

logger = inject.attr(Logger.Logger)

Gst.init(None)


class StreamState(Enum):
    """
    This class is used to define the state of the stream
    """
    IDLE = 0
    STARTED = 1
    STOPPED = 2


@dataclass
class RtpConnectionInfo:
    """
    This class is used to store the connection information
    for the RTP stream
    """

    host: str
    port: int

    rtcp_port: int

    payload_type: int
    ssrc: int

    srtp_key: str = None
    srtp_salt: str = None


class Streamer(threading.Thread):
    """
    Media Pipeline with GStreamer
    it is used to stream video to a remote host
    """

    _state = StreamState.IDLE

    pipeline = None

    def __init__(self, stream_name, security) -> None:
        threading.Thread.__init__(self)

        self.loop = None

        self._name = stream_name
        self.security = security

    def _change_state(self, state: StreamState):
        """
        Change the state of the pipeline
        :param state: the new state
        :return: None
        """
        self._state = state
        print(f"state changed ({self.name}) = {state}")

    def _start_pipeline(self):
        """
        This function is called when the pipeline is started
        :return: None
        """

        self.pipeline.set_state(Gst.State.PLAYING)

        self._change_state(StreamState.STARTED)

    def set_connection_info(self, connection_info: RtpConnectionInfo):
        pass

    def get_state(self) -> StreamState:
        """
        Get the current state of the streamer
        :return: the current state
        """
        return self._state

    def run(self):
        print("start pipeline")

        # start play back and listen to events
        try:
            self._start_pipeline()
            self.loop = GObject.MainLoop()
            self.loop.run()
        except Exception as err:
            print(f"thread exception! err = {err}".format(err=err))

    def close(self):
        """
        This function is called when the pipeline is closed
        :return: None
        """
        try:
            self._change_state(StreamState.STOPPED)
            # self.frame_receiver.stop()

            # stop the pipeline
            self.pipeline.set_state(Gst.State.NULL)
            self.loop.quit()
        except Exception as err:
            print(f"close exception! err = {err}".format(err=err))


class AppStreamer(Streamer):
    """
    Media Pipeline with GStreamer
    it is used to stream video to a remote host

    video is encoded using H.264 in hardware and
    sent over UDP using RTP Server ok?
    """

    # def __init__(self, name: str, frame_receiver: FrameReceiver) -> None:
    def __init__(self, name: str, security=True) -> None:
        super().__init__(name, security)

        # Create the pipeline
        self.pipeline = Gst.Pipeline()

        # H264용 RTP 페이로더
        self.rtph264pay = Gst.ElementFactory.make("rtph264pay", "rtph264pay")
        self.rtph264pay.set_property("config-interval", -1)

        # Create the UDP sink element
        self.udpsink = Gst.ElementFactory.make("udpsink", "udpsink")
        self.udpsink.set_property("sync", False)
        self.udpsink.set_property("async", False)

        self.pipeline.add(self.rtph264pay)
        self.pipeline.add(self.udpsink)

        if security:
            self.srtpenc = Gst.ElementFactory.make("srtpenc", "srtpenc")
            self.pipeline.add(self.srtpenc)
            self.rtph264pay.link(self.srtpenc)
            self.srtpenc.link(self.udpsink)
        else:
            self.rtph264pay.link(self.udpsink)

        self.loop = GObject.MainLoop()
        self.bus = self.pipeline.get_bus()

    def _set_video_source_element(self, element: Gst.Element):
        """
        Set the video source element
        :param element: the video source element
        """
        element.link(self.rtph264pay)

    def _start_pipeline(self):
        """
        This function is called when the pipeline is started
        :return: None
        """

        self.bus.add_signal_watch()
        # self.bus.connect("message", self._bus_call, self.loop)

        super()._start_pipeline()

    def _bus_call(self, _, message, loop):
        """
        This function is called when a message is received on the bus
        :param bus: the bus
        :param message: the message
        :param loop: the main loop
        :return: None
        """
        message_type = message.type

        if message_type == Gst.MessageType.EOS:
            print("End-of-stream")
            # logger.error("End-of-stream")
            loop.quit()
        elif message_type == Gst.MessageType.ERROR:
            err, debug = message.parse_error()
            print(f"Error: {err}: {debug}")
            # logger.error(f"Error: {err}: {debug}".format(err=err, debug=debug))
            loop.quit()
        elif message_type == Gst.MessageType.STATE_CHANGED:
            old, new, pending = message.parse_state_changed()
            print(
                f"message received ({self.name}) STATE_CHANGED : old = {str(old)} new = {str(new)} pending = {str(pending)}")
        elif message_type == Gst.MessageType.STREAM_STATUS:
            stream_status_type, stream_owner = message.parse_stream_status()
            print(
                f"message received ({self.name}) STREAM_STATUS : type = {str(stream_status_type)} / stream_owner = {str(stream_owner)}")
        elif message_type == Gst.MessageType.PROGRESS:

            progress_type, code, text = message.parse_progress()
            print(
                f"message received ({self.name}) PROGRESS : type = {str(progress_type)} / code = {code} / text = {text}")
        # else :
        #     print(f"message received ({self.name}) = {message_type}")

        return True

    def set_connection_info(self, connection_info: RtpConnectionInfo):
        """
        Set the connection info
        :param host: the host to send the stream to
        :param port: the port to send the stream to
        :param payload_type: the payload type to use
        :param ssrc: the ssrc to use
        :param srtp_key: the srtp key to use
        :return: None
        """

        print(f"set connection info ({self.name})  = {connection_info}")

        self.rtph264pay.set_property("pt", connection_info.payload_type)
        self.rtph264pay.set_property("ssrc", connection_info.ssrc)
        # self.rtph265pay.set_property("ssrc", 22222221)

        if self.security:
            key_bytes = base64.b64decode(connection_info.srtp_key)
            buf = Gst.Buffer.new_wrapped(key_bytes)
            # srtpenc auth and cipher is set to default
            self.srtpenc.set_property("key", buf)


        self.udpsink.set_property("host", connection_info.host)

        # if self.name == "front" :
        #     self.udpsink.set_property("port", 3111)
        # else :
        #     self.udpsink.set_property("port", 3156)

        self.udpsink.set_property("port", connection_info.port)


class RosStreamer(AppStreamer):
    """
    Media Pipeline with GStreamer
    it is used to stream video to a remote host
    """

    frame_model: FrameModel = None

    def __init__(self, stream_name: str, streamer_params: dict) -> None:
        security = streamer_params.get("security", True)
        self.topic = streamer_params.get("topic", None)
        
        if not self.topic:
            raise ValueError("topic is required")

        self._frame_rate = streamer_params.get("frame_rate", 60)
        self._frame_interval = 1 / self._frame_rate     
        self.prev_frame_time = 0
        self._bitrate = streamer_params.get("bitrate", 4000000)
        
        self.msg_type = streamer_params.get("msg_type", "sensor_msgs/CompressedImage")
        self.is_compressed = "Compressed" in self.msg_type

        super().__init__(stream_name, security)

        try:
            self._appsrc = Gst.ElementFactory.make("appsrc", "appsrc")
            if not self._appsrc:
                raise Exception("Failed to create appsrc element")

            if self.is_compressed:
                # JPEG 입력 캡스 설정
                in_caps = Gst.Caps.from_string("image/jpeg")
            else:
                # RGB 입력 캡스 설정
                width = 640
                height = 480
                fps = self._frame_rate
                in_caps = Gst.Caps.from_string(
                    f"video/x-raw,format=RGB,width={width},height={height},framerate={fps}/1"
                )

            # appsrc 설정 최적화
            self._appsrc.set_property("caps", in_caps)
            self._appsrc.set_property("is-live", True)
            self._appsrc.set_property("format", Gst.Format.TIME)
            self._appsrc.set_property("do-timestamp", True)
            self._appsrc.set_property("stream-type", 0)
            self._appsrc.set_property("block", False)
            self._appsrc.set_property("max-bytes", 0)

            elements = [self._appsrc]

            if self.is_compressed:
                # JPEG 디코더 추가
                jpegdec = Gst.ElementFactory.make("jpegdec", "jpegdec")
                if not jpegdec:
                    raise Exception("Failed to create jpegdec")
                elements.append(jpegdec)

            # RGB -> I420 변환
            videoconvert = Gst.ElementFactory.make("videoconvert", "videoconvert")
            if not videoconvert:
                raise Exception("Failed to create videoconvert")
            elements.append(videoconvert)

            # 작은 큐 사용 (최소 버퍼링)
            queue = Gst.ElementFactory.make("queue", "queue")
            if not queue:
                raise Exception("Failed to create queue")
            queue.set_property("max-size-buffers", 2)
            queue.set_property("max-size-bytes", 0)
            queue.set_property("max-size-time", 0)
            queue.set_property("leaky", 2)  # 새로운 프레임 우선
            elements.append(queue)

            # H264 인코더 - NVIDIA 하드웨어 인코더 우선 시도
            h264enc = Gst.ElementFactory.make("omxh264enc", "omxh264enc")
            if not h264enc:
                print(f"WARNING: omxh264enc not available, trying nvh264enc for {stream_name}")
                h264enc = Gst.ElementFactory.make("nvh264enc", "nvh264enc")
                if not h264enc:
                    print(f"WARNING: nvh264enc not available, trying x264enc for {stream_name}")
                    # NVIDIA 실패시 x264enc 시도
                    h264enc = Gst.ElementFactory.make("x264enc", "x264enc")
                    if not h264enc:
                        print(f"WARNING: x264enc not available, trying avenc_h264 for {stream_name}")
                        # 마지막으로 avenc_h264 시도
                        h264enc = Gst.ElementFactory.make("avenc_h264", "avenc_h264")
                        if not h264enc:
                            print(f"ERROR: All H264 encoders failed for {stream_name}")
                            raise Exception("Failed to create H264 encoder")
                        print(f"DEBUG: avenc_h264 (software) created successfully for {stream_name}")
                    else:
                        print(f"DEBUG: x264enc (software) created successfully for {stream_name}")
                else:
                    print(f"DEBUG: nvh264enc (NVIDIA GPU) created successfully for {stream_name}")
            else:
                print(f"DEBUG: omxh264enc (NVIDIA hardware) created successfully for {stream_name}")

            # 인코더별 최적화된 설정
            if h264enc.get_factory().get_name() == "nvh264enc":
                # NVIDIA 하드웨어 인코더 설정
                h264enc.set_property("preset", 4)  # lowest latency
                h264enc.set_property("rc-mode", "cbr")  # constant bitrate
                h264enc.set_property("bitrate", int(self._bitrate / 1000))
                h264enc.set_property("gop-size", 15)
                h264enc.set_property("zerolatency", True)
            else:
                # 소프트웨어 인코더 설정
                h264enc.set_property("speed-preset", "ultrafast")
                h264enc.set_property("tune", "zerolatency")
                h264enc.set_property("threads", 4)
                h264enc.set_property("key-int-max", 15)
                h264enc.set_property("bitrate", int(self._bitrate / 1000))
                h264enc.set_property("rc-lookahead", 0)
                h264enc.set_property("sliced-threads", True)
                h264enc.set_property("sync-lookahead", 0)
                h264enc.set_property("b-adapt", 0)

            elements.append(h264enc)

            # 파이프라인에 추가
            for element in elements:
                self.pipeline.add(element)

            # 엘리먼트 연결
            for i in range(len(elements) - 1):
                if not elements[i].link(elements[i + 1]):
                    raise Exception(f"Failed to link {elements[i].get_name()} to {elements[i + 1].get_name()}")

            # h264enc를 rtph264pay에 연결
            if not h264enc.link(self.rtph264pay):
                raise Exception("Failed to link h264enc to rtph264pay")

            # 디버그를 위한 프로브 추가
            h264enc.get_static_pad("src").add_probe(
                Gst.PadProbeType.BUFFER,
                self._on_h264_data_probe
            )

            self._set_video_source_element(h264enc)

            print(f"Successfully created pipeline for {stream_name} using {h264enc.get_factory().get_name()}")

        except Exception as e:
            error_msg = f"Failed to create pipeline: {str(e)}"
            print(error_msg)
            if hasattr(self, 'logger'):
                self.logger.error(error_msg)
            raise

    def _on_video_frame(self, msg):
        try:
            if self._frame_interval > 0:
                current_time = time.time()
                if current_time - self.prev_frame_time < self._frame_interval:
                    return
                self.prev_frame_time = current_time

            if not self._appsrc:
                raise Exception("appsrc is not initialized")

            # 메시지 타입에 따라 데이터 추출
            if self.is_compressed:
                if isinstance(msg, bytes):
                    image_data = msg
                else:
                    if not hasattr(msg, 'format'):
                        raise Exception("CompressedImage message missing 'format' field")
                    
                    image_format = msg.format.lower() if msg.format else ''
                    if not image_format or 'jpeg' not in image_format:
                        raise Exception(f"Unsupported compressed format: {msg.format}")
                    
                    image_data = bytes(msg.data)
            else:
                if hasattr(msg, 'encoding') and msg.encoding == 'rgb8':
                    image_data = bytes(msg.data)
                else:
                    raise Exception(f"Unsupported raw format: {msg.encoding if hasattr(msg, 'encoding') else 'unknown'}")

            # 이미지 데이터 크기 로깅 추가
            # print(f"Processing frame for {self.name}: {len(image_data)} bytes")

            # 타임스탬프 계산
            pts = self.prev_frame_time * Gst.SECOND
            duration = (1 / self._frame_rate) * Gst.SECOND

            # 새로운 버퍼 생성
            buf = Gst.Buffer.new_allocate(None, len(image_data), None)
            if not buf:
                raise Exception("Failed to allocate buffer")
            
            # 버퍼에 데이터 쓰기
            buf.fill(0, image_data)
            
            # 타임스탬프 설정
            buf.pts = pts
            buf.duration = duration

            # 버퍼 푸시 및 결과 로깅
            ret = self._appsrc.emit("push-buffer", buf)
            # print(f"Push-buffer result for {self.name}: {ret}")
            
            # 메모리 참조 해제
            # buf.unref()
            buf = None

            if ret != Gst.FlowReturn.OK:
                error_msg = f"Warning: push-buffer returned {ret}"
                print(error_msg)
                if hasattr(self, 'logger'):
                    self.logger.warning(error_msg)

        except Exception as e:
            error_msg = f"Error in _on_video_frame: {str(e)}"
            print(error_msg)
            if hasattr(self, 'logger'):
                self.logger.error(error_msg)

    def _on_h264_data_probe(self, pad, info):
        """H264 인코딩된 데이터를 모니터링하는 프로브"""
        buffer = info.get_buffer()
        size = buffer.get_size()
        # print(f"H264 encoded data for {self.name}: {size} bytes")
        return Gst.PadProbeReturn.OK

    def _start_pipeline(self):
        """파이프라인 시작 시 디버그 정보 추가"""
        # init the ros node
        print(f"\nStarting pipeline for {self.name}")
        print("Pipeline structure:")
        
        # 파이프라인 구조 출력
        if self.pipeline:
            iterator = self.pipeline.iterate_elements()
            while True:
                result = iterator.next()
                if result[0] == Gst.IteratorResult.DONE:
                    break
                if result[0] == Gst.IteratorResult.OK:
                    element = result[1]
                    print(f"Element: {element.get_name()} ({element.get_factory().get_name()})")
        
        super()._start_pipeline()

        # 파이프라인 상태 확인
        ret, state, pending = self.pipeline.get_state(0)
        print(f"Pipeline state: {state}, pending: {pending}, return: {ret}")

        RosStreamer.frame_model.add_frame_subscriber(
            self.topic, self.msg_type, self.name, self._on_video_frame)

    def close(self):
        """
        This function is called when the pipeline is closed
        :return: None
        """
        super().close()

        RosStreamer.frame_model.remove_frame_subscriber(
            self.topic, self.name)


class RtspStreamer(Streamer):
    """
    Media Pipeline with GStreamer
    it is used to stream video to a remote host
    """

    def __init__(self, stream_name: str, streamer_params: dict):
        """
        Initialize the streamer
        :param stream_name: the name of the stream
        :param frame_receiver: the frame receiver
        """
        security = streamer_params.get("security", True)

        super().__init__(stream_name, security)

        self.rtsp_url = streamer_params.get("url", None)

        if not self.rtsp_url:
            raise ValueError("url is required")

        # print(f"rtsp_url = {rtsp_url}")

        # self.rtspsrc = Gst.ElementFactory.make("rtspsrc", "rtsp-source")

        # self.rtspsrc.set_property("location", rtsp_url)

        # self.rtspsrc.set_property("debug", True)
        # self.rtspsrc.set_property("message-forward", True)

        # self.rtspsrc.connect("handle-request", self._handle_request_callback)

        # self.rtph264depay = Gst.ElementFactory.make(
        #     "rtph264depay", "rtph264depay")

        # self.pipeline.add(self.rtspsrc)
        # self.pipeline.add(self.rtph264depay)

        # self.rtspsrc.link(self.rtph264depay)

        # self._set_video_source_element(self.rtph264depay)
        # self._set_video_source_element(self.rtspsrc)

    def set_connection_info(self, connection_info: RtpConnectionInfo):
        print(f"set connection info ({self.name})  = {connection_info}")

        pt = connection_info.payload_type
        ssrc = connection_info.ssrc
        host = connection_info.host
        port = connection_info.port
        rtcp_port = connection_info.rtcp_port

        # pipeline_description = f"rtspsrc location={self.rtsp_url} \
        #     ! rtph264depay \
        #     ! rtph264pay config-interval=-1 pt={pt} ssrc={ssrc} "

        # if self.security:
        #     srtp_key = connection_info.srtp_key
        #     key_bytes = base64.b64decode(srtp_key)
        #     # buf = Gst.Buffer.new_wrapped(key_bytes)
        #     pipeline_description += f"! srtpenc key={key_bytes}"

        # pipeline_description += f"! udpsink host={host} port={port} sync=false async=false"

        # self.pipeline = Gst.parse_launch(pipeline_description)


        pipeline_description = f"rtpbin name=rtpbin  rtspsrc location={self.rtsp_url} \
            ! rtph264depay \
            ! rtph264pay config-interval=-1 pt={pt} ssrc={ssrc} \
            ! rtpbin.send_rtp_sink_0 rtpbin.send_rtp_src_0"

        if self.security:
            srtp_key = connection_info.srtp_key
            key_bytes = base64.b64decode(srtp_key)
            # buf = Gst.Buffer.new_wrapped(key_bytes)
            pipeline_description += f"! srtpenc key={key_bytes}"

        pipeline_description += f"! udpsink host={host} port={port} sync=false async=false rtpbin.send_rtcp_src_0"
        pipeline_description += f"! udpsink host={host} port={rtcp_port} sync=false async=false udpsrc port={rtcp_port} ! rtpbin.recv_rtcp_sink_0"

        self.pipeline = Gst.parse_launch(pipeline_description)

    def _handle_request_callback(self, _, req_msg, res_msg, udata):
        print("handle request")
        print(req_msg)
        print(res_msg)
        print(udata)


class StreamerManager(ProducerObserver):
    """
    This class manages the streamers
    """
    
    def __init__(self, frame_model: FrameModel, producer_model: ProducerModel) -> None:
        self._streamers: dict[Streamer] = {}

        self._streamer_classes = {
            "ROS": RosStreamer,
            "RTSP": RtspStreamer
        }

        RosStreamer.frame_model = frame_model
        # self.frame_model = frame_model

        self.producer_model = producer_model
        # self.producer_model = inject.attr(ProducerModel)
        # print(self.producer_model)
        self.producer_model.set_observer(self)

        self._streamer_params = {}

        self._is_refreshing = False

        self.is_connected = False

    def create_stream(self, stream_name: str, stream_params: dict) -> bool:
        """
        This function requests a new stream
        :param stream_name: the name of the stream
        :param stream_params: the parameters of the stream
        :param connection_info: the connection info
        :return: bool
        """

        if stream_name in self._streamers:
            # logger.warn("stream already exists")
            return False

        self._streamer_params[stream_name] = stream_params

        if self.is_connected:
            self._open(stream_name, stream_params)

        return True

    def on_connected(self):
        """
        This function is called when the producer is connected
        :return: None
        """

        print("on_connected")

        self.producer_model.connect_init()

        for stream_name, stream_params in self._streamer_params.items():
            self._open(stream_name=stream_name, stream_params=stream_params)

        self.is_connected = True
        # for stream_name, stream_params in self._streamer_params.items():
        #     security = stream_params.get("security", True)
        #     self.producer_model.start_producer(stream_name, security)

    def on_disconnected(self):

        self.is_connected = False
        print("on_disconnected")
        # for stream_name, streamer in self._streamers.items():
        #     streamer.close()
        self.close()

    def on_error(self):
        """
        This function is called when an error occurs
        :return: None
        """
        self.refresh()

    def on_producer_open(self, stream_name: str, connection_info: ProducerConnection):
        """
        This function is called when a new stream is available
        :param stream_name: the name of the stream
        :param producer_connection: the connection info
        :return: None
        """

        if stream_name not in self._streamers:
            return

        connection_info = RtpConnectionInfo(
            host=connection_info.host,
            port=connection_info.rtp_port,
            rtcp_port=connection_info.rtcp_port,
            payload_type=connection_info.payload_type,
            ssrc=connection_info.ssrc,
            srtp_key=connection_info.srtp_key,
            srtp_salt=connection_info.srtp_salt
        )

        self._streamers[stream_name].set_connection_info(connection_info)

        self._streamers[stream_name].start()

    def on_producer_close(self, stream_name: str):
        """
        This function is called when a stream is closed
        :param stream_name: the name of the stream
        :return: None
        """

        self.close_stream(stream_name)

    def get_streamer(self, stream_name: str):
        """
        This function returns the streamer with the given name
        :param stream_name: the name of the stream
        :return: the streamer
        """

        if stream_name not in self._streamers:
            return None

        return self._streamers[stream_name]

    def get_state(self):
        """
        This function returns the state of the streamer manager
        :return: the state of the streamer manager
        """

        state = {}

        for stream_name, streamer in self._streamers.items():
            state[stream_name] = streamer.get_state()

        return state

    def close_stream(self, stream_name: str):
        """
        This function is called when a stream is closed
        :param stream_name: the name of the stream
        :return: None
        """

        if stream_name not in self._streamers:
            return

        self._streamers[stream_name].close()

        self.producer_model.stop_producer(stream_name)

        del self._streamers[stream_name]

    def close(self):
        """
        This function is called when the streamer manager is closed
        :return: None
        """

        for stream_name, streamer in self._streamers.items():
            print(f"close stream({stream_name})")
            streamer.close()
            self.producer_model.stop_producer(stream_name)
            # self.close_stream(stream_name)

        self._streamers.clear()

    def refresh(self):
        """
        This function is called when the streamer manager is refreshed
        :return: None
        """

        # it's not connected yet
        # anythings to do
        if self._is_refreshing or not self.is_connected:
            return

        self._is_refreshing = True

        self.producer_model.connect_init()

        time.sleep(2)

        try:
            streamer_names = []

            for stream_name, streamer in self._streamers.items():
                streamer.close()
                streamer_names.append(stream_name)
                self.producer_model.stop_producer(stream_name)

            self._streamers.clear()

            self.producer_model.set_observer(None)

            time.sleep(3)

            print("refresh : self.producer_model.set_observer")
            self.producer_model.set_observer(self)

            for stream_name in streamer_names:
                stream_params = self._streamer_params.get(stream_name, None)
                print(f"refresh : _open({stream_name}, {stream_params})")

                if stream_params:
                    self._open(
                        stream_name, self._streamer_params[stream_name])

        except Exception as error:
            print(error)

        self._is_refreshing = False

    def _open(self, stream_name, stream_params):
        """
        """

        stream_type = stream_params.get("type", None)

        streamer_class = self._streamer_classes[stream_type]

        security = stream_params.get("security", True)

        streamer = streamer_class(stream_name, stream_params)

        self._streamers[stream_name] = streamer

        self.producer_model.start_producer(stream_name, security)


__all__ = ["StreamerManager"]
