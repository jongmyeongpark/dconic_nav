cmake_minimum_required(VERSION 3.0.2)
project(esp32_combined)

## C++ 표준 설정
add_compile_options(-std=c++14)

## 필요한 ROS 패키지 선언
find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
  sensor_msgs
  serial
  pcl_ros
)

## catkin 설정
catkin_package(
  CATKIN_DEPENDS roscpp std_msgs sensor_msgs serial
)

## include 디렉토리 설정
include_directories(
  ${catkin_INCLUDE_DIRS}
)

## 실행파일 빌드 설정
add_executable(esp32_combined_node src/esp32_combined_node.cpp)
add_dependencies(esp32_combined_node ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
target_link_libraries(esp32_combined_node ${catkin_LIBRARIES})

add_executable(esp32_sender_node src/esp32_sender_node.cpp)
add_dependencies(esp32_sender_node ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
target_link_libraries(esp32_sender_node ${catkin_LIBRARIES})

add_executable(esp32_receiver_node src/esp32_receiver_node.cpp)
add_dependencies(esp32_receiver_node ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
target_link_libraries(esp32_receiver_node ${catkin_LIBRARIES})

add_executable(range_to_pointcloud_node src/range_to_pointcloud_top.cpp)
add_dependencies(range_to_pointcloud_node ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
target_link_libraries(range_to_pointcloud_node ${catkin_LIBRARIES})

## 설치 설정 (선택 사항)
install(TARGETS esp32_combined_node
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)
