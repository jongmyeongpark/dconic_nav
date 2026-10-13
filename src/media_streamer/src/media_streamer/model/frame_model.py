from importlib import import_module
from typing import Any, Callable, Dict

import rospy
# from rosbridge_library.internal import message_conversion

def _get_message_class(msg_type: str) -> Any:
    """
    Get the message class from the message type
    :param msg_type: the message type
    :return: the message class
    """

    module_name, class_name = msg_type.split("/")

    module = import_module(module_name + ".msg")

    print(module)

    return getattr(module, class_name)

class FrameModel:
    """
    ROS model
    """

    def __init__(self):

        self._frame_subscribers = {}
        self._subscribers = {}

    def add_frame_subscriber(self, topic: str, msg_type_name: str, name: str, callback: callable):
        """
        Add a subscriber to a ROS topic.
        """

        if topic in self._frame_subscribers:
            self._frame_subscribers[topic].add(callback)
            return

        def _callback(msg):

            for cb in self._frame_subscribers[topic].values():
                cb(msg.data)

        msg_type = _get_message_class(msg_type_name)
        print(msg_type)

        subscriber = rospy.Subscriber(topic, msg_type, _callback)

        self._subscribers[topic] = subscriber
        self._frame_subscribers[topic] = {
            name: callback
        }

    def remove_frame_subscriber(self, topic: str, name: str):
        """
        Remove a subscriber from a ROS topic.
        """

        if topic in self._frame_subscribers:
            if name in self._frame_subscribers[topic]:
                del self._frame_subscribers[topic][name]

                if len(self._frame_subscribers[topic]) == 0:
                    self._subscribers[topic].unregister()
                    del self._subscribers[topic]
                    del self._frame_subscribers[topic]


__all__ = ["FrameModel"]