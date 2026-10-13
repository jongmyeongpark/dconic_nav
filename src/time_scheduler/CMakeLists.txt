cmake_minimum_required(VERSION 3.0.2)
project(time_scheduler)


find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
  geometry_msgs
  sensor_msgs
  move_base_msgs
  tf2
  tf2_geometry_msgs  
)

catkin_package(
  #LIBRARIES dconic_odometry
  CATKIN_DEPENDS std_msgs roscpp geometry_msgs sensor_msgs
)

include_directories(${catkin_INCLUDE_DIRS} include)

find_package(jsoncpp REQUIRED)

add_executable(time_scheduler src/time_scheduler_node.cpp) 
add_dependencies(time_scheduler ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
target_link_libraries(time_scheduler ${catkin_LIBRARIES} jsoncpp)

#############
## Install ##
#############

## Mark executables and/or libraries for installation
install(TARGETS ${PROJECT_NAME} 
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
  LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
)

## Copy launch files
install(DIRECTORY launch/
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/launch
  FILES_MATCHING PATTERN "*.launch"
)

#install(DIRECTORY include/${PROJECT_NAME}/
#   DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
#   FILES_MATCHING PATTERN "*.h" PATTERN "*.hpp"
#)
