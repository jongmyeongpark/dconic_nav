#!/usr/bin/env python3

"""
media stream client
"""
import json
import rospy

# from media_streamer.model.producer_model import ProducerModel
from media_streamer.model.producer_model import ProducerModel
from media_streamer.model.frame_model import FrameModel

from media_streamer.streamer import StreamerManager
# from media_streamer.streamer_ import StreamerManager
from media_streamer.ws_client import WSClient
import media_streamer.logger as Logger

import inject

from std_msgs.msg import String, Empty


def create_config(producer_model: ProducerModel,
                  frame_model: FrameModel,
                  logger: Logger.Logger,
                  ws_client: WSClient):
    """
    create inject config
    """
    def config(binder):
        print("injection config")
        print(producer_model)
        binder.bind(ProducerModel, producer_model)
        binder.bind(FrameModel, frame_model)
        binder.bind(Logger.Logger, logger)
        binder.bind(WSClient, ws_client)

    return config

def callback_identification(data):
    """
    get f code from data
    """
    subscriber.unregister()

    identification_text = data.data
    identification = json.loads(identification_text)
    f_code = identification.get("f_code", None)
    serial = identification.get("serial", None)

    params = rospy.get_param("~", None)

    signal_host = params.get("signal_host", None)

    remote = params.get("remote", None)
    remote_key = remote.get("key", None)
    # robot_id = remote.get("robot_id", None)

    logger = Logger.Logger()

    ws_client = WSClient(signal_host, remote_key, f_code, serial, logger)

    frame_model = FrameModel()
    producer_model = ProducerModel(ws_client)

    # # dependency injection
    # config = create_config(
    #     producer_model, frame_model, logger, ws_client)
    # inject.configure(config)

    stream_params = params.get("streamer", None)

    streamer_manager = StreamerManager(
        frame_model=frame_model, producer_model=producer_model)

    def stream_start_callback(msg):
        stream_json = msg.data
        logger.info("stream_start_callback")

        if stream_json is None:
            rospy.logerr("stream json is None")
            return

        stream_params = json.loads(stream_json)

        stream_name = stream_params.get("name", None)

        if stream_name is None:
            rospy.logerr("stream name is None")
            return
        try:
            streamer_manager.create_stream(stream_name, stream_params)
        except Exception as err:
            rospy.logerr(f"create stream exception! err = {err}")

    def stream_stop_callback(msg):
        stream_name = msg.data

        logger.info(f"stream_stop_callback : {stream_name}")

        if stream_name is None:
            rospy.logerr("stream name is None")
            return

        if stream_name == "all":
            streamer_manager.close()
        else:
            streamer_manager.close_stream(stream_name)

    def stream_refresh_callback(_):
        logger.info("stream_refresh_callback")
        streamer_manager.refresh()

    rospy.Subscriber("/media/stream/start", String, stream_start_callback)
    rospy.Subscriber("/media/stream/stop", String, stream_stop_callback)
    rospy.Subscriber("/media/stream/refresh", Empty, stream_refresh_callback)

    # streamer_manager = StreamerManager(frame_model=frame_model, producer_model=producer_model, logger=logger)

    for stream_name, stream_param in stream_params.items():
        streamer_manager.create_stream(stream_name, stream_param)

    def on_shutdown():
        streamer_manager.close()
        ws_client.disconnect()

    rospy.on_shutdown(on_shutdown)

    try:
        ws_client.connect()
    except Exception as err:
        logger.error(f"rospy.spin() exception! err = {err}".format(err=err))
        logger.error(err.with_traceback())
        on_shutdown()


if __name__ == "__main__":
    rospy.init_node("media_streamer")

    subscriber = rospy.Subscriber("/flyinglet/identification", String, callback_identification)

    rospy.spin()()
