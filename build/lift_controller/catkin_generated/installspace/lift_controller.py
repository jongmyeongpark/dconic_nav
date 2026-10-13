#!/usr/bin/env python3

# import the necessary packages
from std_msgs.msg import Int32
from std_msgs.msg import Empty


import rospy
import base64
import os
import sys


class LiftController:
	def __init__ (self):

		# Publisher
		self.isRequesteLiftUp_ = False
		self.isRequesteLiftDown_ = False

	def requestLiftUpCallback(self, data):
		self.isRequesteLiftUp_ = True

	def requestLiftDownCallback(self, data):
		self.isRequesteLiftDown_ = True


def main():
	rospy.init_node('lift_controller')
	rate = rospy.Rate(1.0/1.0) # 1hz

	lc = LiftController()

	# Publisher
	selfCamUrlPublisher = rospy.Publisher('/self_cam_url', Empty, queue_size = 1)

	# Subscriber

	rospy.Subscriber("/request_lift_up", Empty, lc.requestLiftUpCallback)
	rospy.Subscriber("/request_lift_down", Empty, lc.requestLiftDownCallback)

		
	while not rospy.is_shutdown():

		if (lc.isRequesteLiftUp_):
			os.system('curl --max-time 0.01 http://192.168.10.7/UP')
			lc.isRequesteLiftUp_ = False

		if(lc.isRequesteLiftDown_):
			os.system('curl --max-time 0.01 http://192.168.10.7/DN')
			lc.isRequesteLiftDown_ = False
				
		rate.sleep()

if __name__ == '__main__':
	main()
