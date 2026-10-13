cmake_minimum_required(VERSION 3.0.2)
project(pointcloud_height_filter)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  sensor_msgs
  dynamic_reconfigure
)

generate_dynamic_reconfigure_options(
  cfg/HeightFilter.cfg
)

catkin_package(
  CATKIN_DEPENDS roscpp sensor_msgs dynamic_reconfigure
)

include_directories(${catkin_INCLUDE_DIRS})

add_executable(height_filter_node src/height_filter_node.cpp)
add_dependencies(height_filter_node ${PROJECT_NAME}_gencfg)
target_link_libraries(height_filter_node ${catkin_LIBRARIES})

install(TARGETS height_filter_node
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)
install(DIRECTORY launch/
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/launch
)
