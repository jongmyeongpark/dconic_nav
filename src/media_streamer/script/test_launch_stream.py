#!/usr/bin/env python3

"""
media stream client
"""
import rospy

# from media_streamer.model.producer_model import ProducerModel
from media_streamer.model.producer_model import ProducerModel
from media_streamer.model.frame_model import FrameModel

from media_streamer.streamer import StreamerManager
from media_streamer.ws_client import WSClient
from media_streamer.logger import Logger

import inject


def create_config(producer_model: ProducerModel, 
                  frame_model: FrameModel, 
                  logger: Logger, 
                  ws_client: WSClient):
    """
    create inject config
    """
    def config(binder):
        print("injection config")
        print(producer_model)
        binder.bind(ProducerModel, producer_model)
        binder.bind(FrameModel, frame_model)
        binder.bind(Logger, logger)
        binder.bind(WSClient, ws_client)

    return config


def _main():

    rospy.init_node("media_streamer")

    params = rospy.get_param("~", None)

    signal_host = params.get("signal_host", None)

    remote = params.get("remote", None)
    remote_key = remote.get("key", None)
    robot_id = remote.get("robot_id", None)

    logger = Logger()

    ws_client = WSClient(signal_host, remote_key, robot_id, logger)

    frame_model = FrameModel()
    producer_model = ProducerModel(ws_client)

    stream_params = params.get("streamer", None)

    streamer_manager = StreamerManager(frame_model=frame_model, producer_model=producer_model)

    for stream_name, stream_param in stream_params.items():
        stream_type = stream_param.get("type", None)

        if stream_type == "ROS":
            streamer_manager.create_stream(stream_name, stream_param)



    def on_shutdown():
        streamer_manager.close()
        ws_client.disconnect()

    rospy.on_shutdown(on_shutdown)

    try:
        ws_client.connect()
        rospy.spin()
    except Exception as err:
        logger.error(f"rospy.spin() exception! err = {err}".format(err=err))
        on_shutdown()


if __name__ == "__main__":
    _main()
