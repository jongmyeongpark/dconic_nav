from media_streamer.streamer import RosStreamer, StreamState, RtpConnectionInfo

# class TestRtspStreamer(unittest.TestCase):

#     def test_rtsp_streamer(self):

#         rtsp_params = {
#             "url" : "rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov",
#             "security" : False,
#         }

#         streamer = RtspStreamer("test", rtsp_params)

#         connection_info = ProducerConnection(
#             host="",
#             rtp_port=0,
#             rtcp_port=0,
#             payload_type=0,
#             ssrc=0,
#             srtp_key=None,
#             srtp_salt=None,
#         )

#         streamer.set_connection_info(connection_info)

#         streamer.start()
        
#         state = streamer.state()

#         assert state == StreamState.STARTED


def test_ros_streamer():

    rtsp_params = {
        "topic" : "/usb_cam/image_raw/compressed",
        "security" : False,
    }

    streamer = RosStreamer("test", rtsp_params)

    connection_info = RtpConnectionInfo(
        host="13.124.189.70",
        port=10045,
        payload_type=100,
        ssrc=22222221,
        srtp_key=None,
        srtp_salt=None,
    )

    streamer.set_connection_info(connection_info)

    streamer.start()
    
    state = streamer.get_state()

    print(state)

    try:
        while True:
            pass
    except KeyboardInterrupt:
        streamer.close()

if __name__ == "__main__":
    test_ros_streamer()