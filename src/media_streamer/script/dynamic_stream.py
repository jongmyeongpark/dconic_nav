#!/usr/bin/env python3

"""
media stream client
"""
import rospy

from media_streamer.streamer import RosStreamer, StreamState, RtpConnectionInfo
from media_streamer.ws_client import WSClient
from media_streamer import logger


def _main():
    rospy.init_node("dynamic_media_streamer")

    params = rospy.get_param("~", None)

    remote = params.get("remote", None)
    remote_ip = remote.get("ip", None)

    stream_params = params.get("streamer", None)

    streamers = {}

    for stream_name, stream_param in stream_params.items():
        # stream_param = stream_params.get_param(stream_name)

        type = stream_param.get("type", "")

        streamer = RosStreamer(stream_name=stream_name,
                               streamer_params=stream_param)

        port = stream_param.get("port", "")
        ssrc = stream_param.get("ssrc", "")
        payload_type = stream_param.get("payload_type", "")

        connection_info = RtpConnectionInfo(
            host=remote_ip,
            port=port,
            rtcp_port=-1,
            payload_type=payload_type,
            ssrc=ssrc,
            srtp_key=None,
            srtp_salt=None)

        streamer.set_connection_info(connection_info)

        streamers[stream_name] = streamer

        streamer.start()



    def on_shutdown():
        for stream_name, streamer in streamers.items():
            streamer.close()


    rospy.on_shutdown(on_shutdown)
    
    try:
        rospy.spin()
    except Exception as err:
        logger.error(f"rospy.spin() exception! err = {err}".format(err=err))
        on_shutdown()


if __name__ == "__main__":
    _main()
