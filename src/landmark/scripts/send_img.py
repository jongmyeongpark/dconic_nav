#!/usr/bin/env python3
import rospy

import cv2
import numpy as np

from sensor_msgs.msg import Image, CompressedImage
from geometry_msgs.msg import PoseWithCovarianceStamped
from landmark.msg import img_pose


class sendimg:
	def __init__(self):
		self.msg = CompressedImage()
		self.msg_center = CompressedImage()
		self.msg_pose = PoseWithCovarianceStamped()
		self.image = []
		self.image_center = []
		self.header = CompressedImage.header
  
	def callback(self, data):		
		self.msg = data
		np_arr = np.frombuffer(data.data, np.uint8)
		self.image = cv2.imdecode(np_arr, cv2.IMREAD_COLOR)
		self.header = data.header
  
	def centercallback(self, data):
		self.msg_center = data
		np_arr = np.frombuffer(data.data, np.uint8)
		self.image_center = cv2.imdecode(np_arr, cv2.IMREAD_COLOR)
  
	def posecallback(self, data):		
		self.msg_pose = data


def main():
	rospy.init_node('send_img', anonymous=True)

	rate = rospy.Rate(1) # 1hz

	cam1 = rospy.get_param("~cam1", "/camera1/usb_cam1/image_raw/compressed")
	cam2 = rospy.get_param("~cam2", "/camera2/usb_cam2/image_raw/compressed")

	ic = sendimg()
	msg = img_pose()
	rospy.Subscriber(cam1, CompressedImage, ic.callback, queue_size = 1)
	rospy.Subscriber(cam2, CompressedImage, ic.centercallback, queue_size = 1)
	rospy.Subscriber("/amcl_pose", PoseWithCovarianceStamped, ic.posecallback, queue_size = 1)
	imgPublisher_merge = rospy.Publisher('/image_pose', img_pose, queue_size = 1)

	while not rospy.is_shutdown():
		if len(ic.image) != 0 and len(ic.image_center) != 0 :
			image_merge = cv2.vconcat([ic.image_center, ic.image])
			h, w, _ = image_merge.shape
			msg.image.header = ic.header
			msg.image.data = cv2.imencode('.jpg', image_merge)[1].tobytes()
			# msg.image.height = h
			# msg.image.width = w
			msg.pose = ic.msg_pose
			imgPublisher_merge.publish(msg) 
		rate.sleep()
        
if __name__ == '__main__':
	main()