cmake_minimum_required(VERSION 3.0.2)
project(shock_detector)

find_package(catkin REQUIRED COMPONENTS
  rospy
  std_msgs
  geometry_msgs
  sensor_msgs
)

catkin_package()

include_directories(
  ${catkin_INCLUDE_DIRS}
)

catkin_install_python(PROGRAMS
  scripts/shock_detector.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)