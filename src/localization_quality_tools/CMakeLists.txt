cmake_minimum_required(VERSION 3.0.2)
project(localization_quality_tools)

find_package(catkin REQUIRED COMPONENTS
  rospy
  std_msgs
  geometry_msgs
  nav_msgs
  sensor_msgs
  tf
)

catkin_package()

catkin_install_python(PROGRAMS
  scripts/localization_quality_checker.py
  scripts/particle_cluster_quality.py
  scripts/pose_on_costmap_checker.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)