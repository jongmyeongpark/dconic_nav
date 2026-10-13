cmake_minimum_required(VERSION 3.0.2)
project(depth_anything_ros)

find_package(catkin REQUIRED COMPONENTS
  rospy
  sensor_msgs
  std_msgs
  cv_bridge
  image_transport
)

catkin_package()

catkin_install_python(PROGRAMS
  scripts/depth_anything_node.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)
