import inject
# from media_streamer.logger import Logger
import media_streamer.logger as Logger

from ..ws_client import WSClient
from dataclasses import dataclass


@dataclass
class ProducerConnection:
    """
    Producer connection info
    """

    host: str

    rtp_port: int
    rtcp_port: int

    payload_type: int
    ssrc: int

    srtp_key: str
    srtp_salt: str


class ProducerObserver:
    """
    Producer observer
    """

    def on_connected(self):
        """
        This function is called when the connection is established
        :return: None
        """
        pass

    def on_disconnected(self):
        """
        This function is called when the connection is closed
        :return: None
        """
        pass

    def on_producer_open(self, stream_name: str, connection_info: ProducerConnection):
        """
        This function is called when a producer is produced
        :param stream_name: the name of the stream
        :param connection_info: the connection info
        :return: None
        """
        pass

    def on_producer_close(self, stream_name: str):
        """
        This function is called when a producer is closed
        :param stream_name: the name of the stream
        :return: None
        """
        pass

    def on_error(self):
        """
        This function is called when an error occurs
        :return: None
        """
        pass


class ProducerModel:
    """
    Producer model
    """

    # def __init__(self):
    def __init__(self, ws_client: WSClient):

        self._producers = {}

        self._observer: ProducerObserver = None

        self.logger = inject.attr(Logger.Logger)

        # self._ws_client = inject.attr(WSClient)
        self._ws_client = ws_client

        self._ws_client.on("producer/start", self._on_produced)
        self._ws_client.on("error", self._on_error)
        self._ws_client.on("connected", self._on_connected)
        self._ws_client.on("disconnected", self._on_disconnected)

        self._producers = {}

    def start_producer(self, stream_name: str, security: bool = False):
        """
        Register a producer
        """

        self._producers[stream_name] = {}

        self._ws_client.send("producer/start", {
            "stream_name": stream_name,
            "security": security
        })

    def stop_producer(self, stream_name: str):
        """
        Stop a producer
        """

        self._ws_client.send("producer/stop", {
            "stream_name": stream_name
        })
    
    def connect_init(self):
        """
        Reset the model
        """

        self._ws_client.join()

    def _on_connected(self):
        """
        Called when the connection is established
        """
            
        if self._observer:
            self._observer.on_connected()

    def _on_disconnected(self):
        """
        Called when the connection is closed
        """

        if self._observer:
            self._observer.on_disconnected()

    def _on_error(self, message: str):
        """
        Called when an error occurs"""

        if self._observer:
            self._observer.on_error()

    def _on_produced(self, connection_info: dict):

        # connection_info = payload["connection_info"]
        stream_name = connection_info["stream_name"]

        producer_connection = ProducerConnection(
            host=connection_info["host"],
            rtp_port=connection_info["rtp_port"],
            rtcp_port=connection_info["rtcp_port"],
            payload_type=connection_info["payload_type"],
            ssrc=connection_info["ssrc"],
            srtp_key=connection_info.get("srtp_key", None),
            srtp_salt=connection_info.get("srtp_salt", None),
        )

        self._producers[stream_name] = producer_connection

        if self._observer:
            self._observer.on_producer_open(stream_name, producer_connection)

    def _on_closed_producer(self, stream_name: str):
        """
        Called when a producer is closed
        """

        if stream_name in self._producers:
            del self._producers[stream_name]

        if self._observer:
            self._observer.on_producer_close(stream_name)

    def set_observer(self, observer: ProducerObserver):
        """
        Set the observer
        """

        self._observer = observer


__all__ = ["ProducerModel", "ProducerObserver", "ProducerConnection"]
