cmake_minimum_required(VERSION 3.0.2)
project(boot_processor)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
  tf
  geometry_msgs
  sensor_msgs
  diagnostic_msgs
)

generate_messages(DEPENDENCIES std_msgs geometry_msgs tf )

catkin_package(
  #LIBRARIES dconic_odometry
  CATKIN_DEPENDS std_msgs roscpp geometry_msgs sensor_msgs diagnostic_msgs
)



include_directories(${catkin_INCLUDE_DIRS} include)

add_executable(boot_processor src/boot_processor_node.cpp) 
add_dependencies(boot_processor ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
target_link_libraries(boot_processor ${catkin_LIBRARIES})

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
