cmake_minimum_required(VERSION 2.8.3)
project(hdmi_serial_switcher)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  serial
  std_msgs
)

catkin_package(
  CATKIN_DEPENDS
    serial
    std_msgs
)

include_directories(
  ${catkin_INCLUDE_DIRS}
)

file(GLOB serial_src "include/serial/*.cc")
add_library(serial SHARED ${serial_src})

add_executable(hdmi_serial_switcher_node src/hdmi_serial_switcher_node.cpp)

target_link_libraries(hdmi_serial_switcher_node
  ${catkin_LIBRARIES}
  serial
)

