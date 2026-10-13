cmake_minimum_required(VERSION 3.5)
project(esp32)

# if CMAKE_BUILD_TYPE is not specified, take 'Release' as default
IF(NOT CMAKE_BUILD_TYPE)
    SET(CMAKE_BUILD_TYPE Release)
ENDIF(NOT CMAKE_BUILD_TYPE)

## Find catkin and any catkin packages
find_package(catkin REQUIRED COMPONENTS 
rospy
std_msgs 
)

#catkin_python_setup()

catkin_package(
  LIBRARIES ${PROJECT_NAME}
  CATKIN_DEPENDS rospy std_msgs
)

## Declare a catkin package
## Export the message runtime dependency

## Mark executable scripts (Python etc.) for installation
## in contrast to setup.py, you can choose the destination
catkin_install_python(PROGRAMS
  nodes/esp32_ir1.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)