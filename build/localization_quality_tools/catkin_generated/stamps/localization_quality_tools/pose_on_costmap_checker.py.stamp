#!/usr/bin/env python

import rospy
import numpy as np
from nav_msgs.msg import OccupancyGrid
from geometry_msgs.msg import PoseWithCovarianceStamped
from std_msgs.msg import String, Float32

class PoseOnCostmapChecker:
    def __init__(self):
        rospy.init_node("localization_evaluator_costmap")

        # Params
        self.costmap_topic = rospy.get_param("~costmap_topic", "/move_base/global_costmap/costmap")  # 
        self.window_radius_cells = rospy.get_param("~window_radius_cells", 3)   #
        self.max_obstacle_ratio_ok = rospy.get_param("~max_obstacle_ratio_ok", 0.10)  # 
        self.allow_unknown = rospy.get_param("~allow_unknown", False)   # 

        self.map = None
        self.pose = None

        rospy.Subscriber(self.costmap_topic, OccupancyGrid, self.map_cb)
        rospy.Subscriber("/amcl_pose", PoseWithCovarianceStamped, self.pose_cb)

        self.status_pub = rospy.Publisher("~status", String, queue_size=10)
        self.score_pub  = rospy.Publisher("~free_score", Float32, queue_size=10)

        rospy.Timer(rospy.Duration(2), self.evaluate)
        rospy.loginfo("[pose_on_costmap_checker] costmap: %s, window=%d",
                      self.costmap_topic, self.window_radius_cells)
        rospy.spin()

    def map_cb(self, msg):
        self.map = msg

    def pose_cb(self, msg):
        self.pose = msg.pose.pose

    def world_to_map(self, x, y):
        """returns (mx, my) or None if out of bounds"""
        origin_x = self.map.info.origin.position.x
        origin_y = self.map.info.origin.position.y
        res = self.map.info.resolution
        mx = int((x - origin_x) / res)
        my = int((y - origin_y) / res)
        if 0 <= mx < self.map.info.width and 0 <= my < self.map.info.height:
            return mx, my
        return None

    def evaluate(self, _event):
        if self.map is None or self.pose is None:
            return

        data = np.array(self.map.data, dtype=np.int16).reshape(self.map.info.height, self.map.info.width)
        p = self.world_to_map(self.pose.position.x, self.pose.position.y)
        if p is None:
            status = "BAD: out_of_map"
            self.status_pub.publish(status)
            rospy.logwarn(status)
            return

        mx, my = p
        r = self.window_radius_cells
        x0 = max(mx - r, 0); x1 = min(mx + r, self.map.info.width  - 1)
        y0 = max(my - r, 0); y1 = min(my + r, self.map.info.height - 1)
        window = data[y0:y1+1, x0:x1+1]

        # Count cells
        total = window.size
        obst = np.sum(window == 100)
        unk  = np.sum(window == -1)
        free = np.sum(window == 0)

        # Unknown 
        if self.allow_unknown:
            effective_total = free + obst  # unknown
        else:
            effective_total = total

        if effective_total == 0:
            status = "UNCERTAIN: empty_window"
            self.status_pub.publish(status)
            rospy.logwarn(status)
            return

        obstacle_ratio = (float(obst) / float(effective_total)) if effective_total > 0 else 1.0
        free_score = float(free) / float(effective_total)

        # 
        if obstacle_ratio <= self.max_obstacle_ratio_ok and (not (window[my - y0, mx - x0] == 100)):
            status = "GOOD"
        elif obstacle_ratio <= min(0.25, self.max_obstacle_ratio_ok * 2.0):
            status = "UNCERTAIN"
        else:
            status = "BAD"

        rospy.loginfo("Cell=(%d,%d) win=%dx%d obst_ratio=%.2f free_score=%.2f -> %s",
                      mx, my, window.shape[1], window.shape[0], obstacle_ratio, free_score, status)
        self.status_pub.publish(status)
        self.score_pub.publish(free_score)

if __name__ == "__main__":
    PoseOnCostmapChecker()