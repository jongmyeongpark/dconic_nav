import rospy

class Logger(object):

    def debug(self, msg):
        """
        This function logs a debug message
        :param msg: the message to log
        :return: None
        """
        # _log("DEBUG", msg)
        rospy.logdebug(msg)

    def info(self, msg):
        """
        This function logs an info message
        :param msg: the message to log
        :return: None
        """
        # _log("INFO", msg)
        rospy.loginfo(msg)

    def warn(self, msg):
        """
        This function logs a warning message
        :param msg: the message to log
        :return: None
        """
        # _log("WARN", msg)
        rospy.logwarn(msg)

    def error(self, msg):
        """
        This function logs an error message
        :param msg: the message to log
        :return: None
        """
        # _log("ERROR", msg)
        rospy.logerr(msg)

    def _log(self, level, msg):
        """
        This function logs a message
        :param level: the level of the message
        :param msg: the message to log
        :return: None
        """
        # print(f"[{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] [{level}] {msg}")

        rospy.loginfo(f"[{level}] {msg}")


logger = Logger()

__all__ = ["Logger"]
# Path: src\media_streamer\pipeline.py
# Compare this snippet from script\app.py: