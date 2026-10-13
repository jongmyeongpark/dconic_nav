cmake_minimum_required(VERSION 3.0.2)
project(autonomous_parker)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14")

find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
  tf
  geometry_msgs
  sensor_msgs
  cv_bridge
  image_transport
  tf2
  tf2_geometry_msgs
  move_base_msgs
  nav_msgs
)

find_package( OpenCV 4 REQUIRED )

generate_messages(DEPENDENCIES std_msgs geometry_msgs tf )

catkin_package(
  CATKIN_DEPENDS std_msgs roscpp geometry_msgs sensor_msgs
)



include_directories(${catkin_INCLUDE_DIRS} include)

add_executable(autonomous_parker src/autonomous_parker_node.cpp) 
add_dependencies(autonomous_parker ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
target_link_libraries(autonomous_parker ${catkin_LIBRARIES} ${OpenCV_LIBS})

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
