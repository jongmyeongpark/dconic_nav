# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "custom_msgs: 33 messages, 0 services")

set(MSG_I_FLAGS "-Icustom_msgs:/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine;-Icustom_msgs:/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection;-Icustom_msgs:/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/display;-Icustom_msgs:/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer;-Icustom_msgs:/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor;-Icustom_msgs:/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/nav;-Icustom_msgs:/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/image;-Icustom_msgs:/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control;-Icustom_msgs:/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/alpha1s;-Icustom_msgs:/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware;-Icustom_msgs:/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create;-Icustom_msgs:/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/rtc;-Icustom_msgs:/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/console;-Icustom_msgs:/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/monitoring;-Icustom_msgs:/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/ssh;-Icustom_msgs:/home/nvidia/dconic_nav/src/custom_msgs_demo/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg;-Inav_msgs:/opt/ros/noetic/share/nav_msgs/cmake/../msg;-Iactionlib_msgs:/opt/ros/noetic/share/actionlib_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(custom_msgs_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/State.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/State.msg" ""
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/Transition.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/Transition.msg" "custom_msgs/State"
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/MachineDescription.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/MachineDescription.msg" "custom_msgs/Transition:custom_msgs/State"
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/FaceInfo.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/FaceInfo.msg" ""
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/DetectedFaces.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/DetectedFaces.msg" "custom_msgs/FaceInfo"
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/NormalizedFaces.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/NormalizedFaces.msg" "geometry_msgs/Point"
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/display/TextCmd.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/display/TextCmd.msg" ""
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Form.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Form.msg" "geometry_msgs/Point"
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Obstacles.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Obstacles.msg" "custom_msgs/Form:geometry_msgs/Point"
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Zone.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Zone.msg" "custom_msgs/Form:geometry_msgs/Point"
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/AppCmd.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/AppCmd.msg" ""
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Dependency.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Dependency.msg" ""
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Service.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Service.msg" "custom_msgs/Dependency"
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Process.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Process.msg" ""
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/nav/Map64.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/nav/Map64.msg" "geometry_msgs/Point:geometry_msgs/Quaternion:nav_msgs/MapMetaData:geometry_msgs/Pose:std_msgs/Header"
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/image/Image64.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/image/Image64.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadCmd.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadCmd.msg" ""
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadPose.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadPose.msg" ""
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/PhoneCmdVel.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/PhoneCmdVel.msg" ""
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/alpha1s/BatteryState.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/alpha1s/BatteryState.msg" ""
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/ColorRGB.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/ColorRGB.msg" ""
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/Leds.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/Leds.msg" "custom_msgs/ColorRGB"
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Bumper.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Bumper.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/ChargingState.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/ChargingState.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Mode.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Mode.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/DefineSong.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/DefineSong.msg" ""
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/PlaySong.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/PlaySong.msg" ""
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/rtc/MessageRTC.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/rtc/MessageRTC.msg" ""
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/console/Log.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/console/Log.msg" ""
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/monitoring/Info.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/monitoring/Info.msg" ""
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/ssh/Heartbeat.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/ssh/Heartbeat.msg" ""
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/LedRGBColors.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/LedRGBColors.msg" ""
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/Battery.msg" NAME_WE)
add_custom_target(_custom_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "custom_msgs" "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/Battery.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/State.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/Transition.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/State.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/MachineDescription.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/Transition.msg;/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/State.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/FaceInfo.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/DetectedFaces.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/FaceInfo.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/NormalizedFaces.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/display/TextCmd.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Form.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Obstacles.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Form.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Zone.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Form.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/AppCmd.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Dependency.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Service.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Dependency.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Process.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/nav/Map64.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/nav_msgs/cmake/../msg/MapMetaData.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/image/Image64.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadCmd.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadPose.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/PhoneCmdVel.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/alpha1s/BatteryState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/ColorRGB.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/Leds.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/ColorRGB.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Bumper.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/ChargingState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Mode.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/DefineSong.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/PlaySong.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/rtc/MessageRTC.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/console/Log.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/monitoring/Info.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/ssh/Heartbeat.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/LedRGBColors.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)
_generate_msg_cpp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/Battery.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
)

### Generating Services

### Generating Module File
_generate_module_cpp(custom_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(custom_msgs_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(custom_msgs_generate_messages custom_msgs_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/State.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/Transition.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/MachineDescription.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/FaceInfo.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/DetectedFaces.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/NormalizedFaces.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/display/TextCmd.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Form.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Obstacles.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Zone.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/AppCmd.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Dependency.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Service.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Process.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/nav/Map64.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/image/Image64.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadCmd.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadPose.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/PhoneCmdVel.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/alpha1s/BatteryState.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/ColorRGB.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/Leds.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Bumper.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/ChargingState.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Mode.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/DefineSong.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/PlaySong.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/rtc/MessageRTC.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/console/Log.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/monitoring/Info.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/ssh/Heartbeat.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/LedRGBColors.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/Battery.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_cpp _custom_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(custom_msgs_gencpp)
add_dependencies(custom_msgs_gencpp custom_msgs_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS custom_msgs_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/State.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/Transition.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/State.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/MachineDescription.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/Transition.msg;/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/State.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/FaceInfo.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/DetectedFaces.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/FaceInfo.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/NormalizedFaces.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/display/TextCmd.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Form.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Obstacles.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Form.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Zone.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Form.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/AppCmd.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Dependency.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Service.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Dependency.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Process.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/nav/Map64.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/nav_msgs/cmake/../msg/MapMetaData.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/image/Image64.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadCmd.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadPose.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/PhoneCmdVel.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/alpha1s/BatteryState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/ColorRGB.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/Leds.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/ColorRGB.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Bumper.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/ChargingState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Mode.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/DefineSong.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/PlaySong.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/rtc/MessageRTC.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/console/Log.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/monitoring/Info.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/ssh/Heartbeat.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/LedRGBColors.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)
_generate_msg_eus(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/Battery.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
)

### Generating Services

### Generating Module File
_generate_module_eus(custom_msgs
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(custom_msgs_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(custom_msgs_generate_messages custom_msgs_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/State.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/Transition.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/MachineDescription.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/FaceInfo.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/DetectedFaces.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/NormalizedFaces.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/display/TextCmd.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Form.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Obstacles.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Zone.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/AppCmd.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Dependency.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Service.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Process.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/nav/Map64.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/image/Image64.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadCmd.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadPose.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/PhoneCmdVel.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/alpha1s/BatteryState.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/ColorRGB.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/Leds.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Bumper.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/ChargingState.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Mode.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/DefineSong.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/PlaySong.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/rtc/MessageRTC.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/console/Log.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/monitoring/Info.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/ssh/Heartbeat.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/LedRGBColors.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/Battery.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_eus _custom_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(custom_msgs_geneus)
add_dependencies(custom_msgs_geneus custom_msgs_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS custom_msgs_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/State.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/Transition.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/State.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/MachineDescription.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/Transition.msg;/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/State.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/FaceInfo.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/DetectedFaces.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/FaceInfo.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/NormalizedFaces.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/display/TextCmd.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Form.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Obstacles.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Form.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Zone.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Form.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/AppCmd.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Dependency.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Service.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Dependency.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Process.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/nav/Map64.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/nav_msgs/cmake/../msg/MapMetaData.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/image/Image64.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadCmd.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadPose.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/PhoneCmdVel.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/alpha1s/BatteryState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/ColorRGB.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/Leds.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/ColorRGB.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Bumper.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/ChargingState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Mode.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/DefineSong.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/PlaySong.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/rtc/MessageRTC.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/console/Log.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/monitoring/Info.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/ssh/Heartbeat.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/LedRGBColors.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)
_generate_msg_lisp(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/Battery.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
)

### Generating Services

### Generating Module File
_generate_module_lisp(custom_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(custom_msgs_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(custom_msgs_generate_messages custom_msgs_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/State.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/Transition.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/MachineDescription.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/FaceInfo.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/DetectedFaces.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/NormalizedFaces.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/display/TextCmd.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Form.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Obstacles.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Zone.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/AppCmd.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Dependency.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Service.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Process.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/nav/Map64.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/image/Image64.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadCmd.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadPose.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/PhoneCmdVel.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/alpha1s/BatteryState.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/ColorRGB.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/Leds.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Bumper.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/ChargingState.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Mode.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/DefineSong.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/PlaySong.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/rtc/MessageRTC.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/console/Log.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/monitoring/Info.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/ssh/Heartbeat.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/LedRGBColors.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/Battery.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_lisp _custom_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(custom_msgs_genlisp)
add_dependencies(custom_msgs_genlisp custom_msgs_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS custom_msgs_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/State.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/Transition.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/State.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/MachineDescription.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/Transition.msg;/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/State.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/FaceInfo.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/DetectedFaces.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/FaceInfo.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/NormalizedFaces.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/display/TextCmd.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Form.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Obstacles.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Form.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Zone.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Form.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/AppCmd.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Dependency.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Service.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Dependency.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Process.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/nav/Map64.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/nav_msgs/cmake/../msg/MapMetaData.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/image/Image64.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadCmd.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadPose.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/PhoneCmdVel.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/alpha1s/BatteryState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/ColorRGB.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/Leds.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/ColorRGB.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Bumper.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/ChargingState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Mode.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/DefineSong.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/PlaySong.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/rtc/MessageRTC.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/console/Log.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/monitoring/Info.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/ssh/Heartbeat.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/LedRGBColors.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)
_generate_msg_nodejs(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/Battery.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
)

### Generating Services

### Generating Module File
_generate_module_nodejs(custom_msgs
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(custom_msgs_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(custom_msgs_generate_messages custom_msgs_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/State.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/Transition.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/MachineDescription.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/FaceInfo.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/DetectedFaces.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/NormalizedFaces.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/display/TextCmd.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Form.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Obstacles.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Zone.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/AppCmd.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Dependency.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Service.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Process.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/nav/Map64.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/image/Image64.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadCmd.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadPose.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/PhoneCmdVel.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/alpha1s/BatteryState.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/ColorRGB.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/Leds.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Bumper.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/ChargingState.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Mode.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/DefineSong.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/PlaySong.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/rtc/MessageRTC.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/console/Log.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/monitoring/Info.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/ssh/Heartbeat.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/LedRGBColors.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/Battery.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_nodejs _custom_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(custom_msgs_gennodejs)
add_dependencies(custom_msgs_gennodejs custom_msgs_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS custom_msgs_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/State.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/Transition.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/State.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/MachineDescription.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/Transition.msg;/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/State.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/FaceInfo.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/DetectedFaces.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/FaceInfo.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/NormalizedFaces.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/display/TextCmd.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Form.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Obstacles.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Form.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Zone.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Form.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/AppCmd.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Dependency.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Service.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Dependency.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Process.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/nav/Map64.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/nav_msgs/cmake/../msg/MapMetaData.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/image/Image64.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadCmd.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadPose.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/PhoneCmdVel.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/alpha1s/BatteryState.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/ColorRGB.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/Leds.msg"
  "${MSG_I_FLAGS}"
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/ColorRGB.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Bumper.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/ChargingState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Mode.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/DefineSong.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/PlaySong.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/rtc/MessageRTC.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/console/Log.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/monitoring/Info.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/ssh/Heartbeat.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/LedRGBColors.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)
_generate_msg_py(custom_msgs
  "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/Battery.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
)

### Generating Services

### Generating Module File
_generate_module_py(custom_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(custom_msgs_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(custom_msgs_generate_messages custom_msgs_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/State.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/Transition.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/state_machine/MachineDescription.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/FaceInfo.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/DetectedFaces.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/detection/NormalizedFaces.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/display/TextCmd.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Form.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Obstacles.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/virtual_layer/Zone.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/AppCmd.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Dependency.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Service.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/supervisor/Process.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/nav/Map64.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/image/Image64.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadCmd.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/HeadPose.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/control/PhoneCmdVel.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/alpha1s/BatteryState.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/ColorRGB.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/hardware/Leds.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Bumper.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/ChargingState.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/Mode.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/DefineSong.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/create/PlaySong.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/rtc/MessageRTC.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/console/Log.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/monitoring/Info.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/ssh/Heartbeat.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/LedRGBColors.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/custom_msgs_demo/msg/Battery.msg" NAME_WE)
add_dependencies(custom_msgs_generate_messages_py _custom_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(custom_msgs_genpy)
add_dependencies(custom_msgs_genpy custom_msgs_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS custom_msgs_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/custom_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(custom_msgs_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(custom_msgs_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()
if(TARGET nav_msgs_generate_messages_cpp)
  add_dependencies(custom_msgs_generate_messages_cpp nav_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/custom_msgs
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(custom_msgs_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(custom_msgs_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()
if(TARGET nav_msgs_generate_messages_eus)
  add_dependencies(custom_msgs_generate_messages_eus nav_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/custom_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(custom_msgs_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(custom_msgs_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()
if(TARGET nav_msgs_generate_messages_lisp)
  add_dependencies(custom_msgs_generate_messages_lisp nav_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/custom_msgs
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(custom_msgs_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(custom_msgs_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()
if(TARGET nav_msgs_generate_messages_nodejs)
  add_dependencies(custom_msgs_generate_messages_nodejs nav_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/custom_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(custom_msgs_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(custom_msgs_generate_messages_py geometry_msgs_generate_messages_py)
endif()
if(TARGET nav_msgs_generate_messages_py)
  add_dependencies(custom_msgs_generate_messages_py nav_msgs_generate_messages_py)
endif()
