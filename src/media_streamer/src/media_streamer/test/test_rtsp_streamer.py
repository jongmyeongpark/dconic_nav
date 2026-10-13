from media_streamer.streamer import RtspStreamer, StreamState, RtpConnectionInfo

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


def test_rtsp_streamer():

    rtsp_params = {
        "url" : "rtsp://admin:admin@192.168.10.14:554/snl/live/1/1",
        # "url" : "rtsp://192.168.10.14:554/snl/live/1/1",
        # "url" : "rtsp://freja.hiof.no:1935/rtplive/definst/hessdalen02.stream",
        # "url" : "rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mp4",
        "security" : False,
    }


    rtsp_params2 = {
        "url" : "rtsp://admin:admin@192.168.10.14:554/snl/live/2/1",
        # "url" : "rtsp://192.168.10.14:554/snl/live/1/1",
        # "url" : "rtsp://freja.hiof.no:1935/rtplive/definst/hessdalen02.stream",
        # "url" : "rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mp4",
        "security" : False,
    }

    streamer = RtspStreamer("test", rtsp_params)

    streamer2 = RtspStreamer("test", rtsp_params2)

    connection_info = RtpConnectionInfo(
        host="13.124.189.70",
        port=3131,
        rtcp_port=3130,
        payload_type=100,
        ssrc=22222221,
        srtp_key=None,
        srtp_salt=None,
    )

    connection_info2 = RtpConnectionInfo(
        host="13.124.189.70",
        port=3138,
        rtcp_port=3172,
        payload_type=100,
        ssrc=22222221,
        srtp_key=None,
        srtp_salt=None,
    )

    streamer.set_connection_info(connection_info)
    streamer2.set_connection_info(connection_info2)

    streamer.start()
    streamer2.start()
    
    state = streamer.get_state()

    print("streamer", state)

    state = streamer2.get_state()

    print("streamer2", state)

    try:
        while True:
            pass
    except KeyboardInterrupt:
        streamer.close()

if __name__ == "__main__":
    test_rtsp_streamer()