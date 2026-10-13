# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "landmark: 6 messages, 0 services")

set(MSG_I_FLAGS "-Ilandmark:/home/nvidia/dconic_nav/src/landmark/msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/noetic/share/sensor_msgs/cmake/../msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(landmark_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/img_pose.msg" NAME_WE)
add_custom_target(_landmark_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "landmark" "/home/nvidia/dconic_nav/src/landmark/msg/img_pose.msg" "geometry_msgs/PoseWithCovariance:geometry_msgs/Pose:geometry_msgs/Point:geometry_msgs/PoseWithCovarianceStamped:sensor_msgs/Image:geometry_msgs/Quaternion:std_msgs/Header"
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/img_pose_result.msg" NAME_WE)
add_custom_target(_landmark_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "landmark" "/home/nvidia/dconic_nav/src/landmark/msg/img_pose_result.msg" ""
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/VisionCheckResult.msg" NAME_WE)
add_custom_target(_landmark_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "landmark" "/home/nvidia/dconic_nav/src/landmark/msg/VisionCheckResult.msg" "geometry_msgs/PoseWithCovariance:geometry_msgs/Pose:geometry_msgs/Point:geometry_msgs/PoseWithCovarianceStamped:geometry_msgs/Quaternion:std_msgs/Header"
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/VisionPose.msg" NAME_WE)
add_custom_target(_landmark_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "landmark" "/home/nvidia/dconic_nav/src/landmark/msg/VisionPose.msg" "geometry_msgs/PoseWithCovariance:geometry_msgs/Pose:geometry_msgs/Point:geometry_msgs/PoseWithCovarianceStamped:geometry_msgs/Quaternion:std_msgs/Header"
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/des_vector.msg" NAME_WE)
add_custom_target(_landmark_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "landmark" "/home/nvidia/dconic_nav/src/landmark/msg/des_vector.msg" "geometry_msgs/PoseWithCovariance:geometry_msgs/Pose:geometry_msgs/Point:geometry_msgs/PoseWithCovarianceStamped:geometry_msgs/Quaternion:std_msgs/Header"
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/relocal.msg" NAME_WE)
add_custom_target(_landmark_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "landmark" "/home/nvidia/dconic_nav/src/landmark/msg/relocal.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/img_pose.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovarianceStamped.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/landmark
)
_generate_msg_cpp(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/img_pose_result.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/landmark
)
_generate_msg_cpp(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/VisionCheckResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovarianceStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/landmark
)
_generate_msg_cpp(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/VisionPose.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovarianceStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/landmark
)
_generate_msg_cpp(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/des_vector.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovarianceStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/landmark
)
_generate_msg_cpp(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/relocal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/landmark
)

### Generating Services

### Generating Module File
_generate_module_cpp(landmark
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/landmark
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(landmark_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(landmark_generate_messages landmark_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/img_pose.msg" NAME_WE)
add_dependencies(landmark_generate_messages_cpp _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/img_pose_result.msg" NAME_WE)
add_dependencies(landmark_generate_messages_cpp _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/VisionCheckResult.msg" NAME_WE)
add_dependencies(landmark_generate_messages_cpp _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/VisionPose.msg" NAME_WE)
add_dependencies(landmark_generate_messages_cpp _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/des_vector.msg" NAME_WE)
add_dependencies(landmark_generate_messages_cpp _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/relocal.msg" NAME_WE)
add_dependencies(landmark_generate_messages_cpp _landmark_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(landmark_gencpp)
add_dependencies(landmark_gencpp landmark_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS landmark_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/img_pose.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovarianceStamped.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/landmark
)
_generate_msg_eus(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/img_pose_result.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/landmark
)
_generate_msg_eus(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/VisionCheckResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovarianceStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/landmark
)
_generate_msg_eus(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/VisionPose.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovarianceStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/landmark
)
_generate_msg_eus(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/des_vector.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovarianceStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/landmark
)
_generate_msg_eus(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/relocal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/landmark
)

### Generating Services

### Generating Module File
_generate_module_eus(landmark
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/landmark
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(landmark_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(landmark_generate_messages landmark_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/img_pose.msg" NAME_WE)
add_dependencies(landmark_generate_messages_eus _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/img_pose_result.msg" NAME_WE)
add_dependencies(landmark_generate_messages_eus _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/VisionCheckResult.msg" NAME_WE)
add_dependencies(landmark_generate_messages_eus _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/VisionPose.msg" NAME_WE)
add_dependencies(landmark_generate_messages_eus _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/des_vector.msg" NAME_WE)
add_dependencies(landmark_generate_messages_eus _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/relocal.msg" NAME_WE)
add_dependencies(landmark_generate_messages_eus _landmark_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(landmark_geneus)
add_dependencies(landmark_geneus landmark_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS landmark_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/img_pose.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovarianceStamped.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/landmark
)
_generate_msg_lisp(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/img_pose_result.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/landmark
)
_generate_msg_lisp(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/VisionCheckResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovarianceStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/landmark
)
_generate_msg_lisp(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/VisionPose.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovarianceStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/landmark
)
_generate_msg_lisp(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/des_vector.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovarianceStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/landmark
)
_generate_msg_lisp(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/relocal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/landmark
)

### Generating Services

### Generating Module File
_generate_module_lisp(landmark
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/landmark
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(landmark_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(landmark_generate_messages landmark_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/img_pose.msg" NAME_WE)
add_dependencies(landmark_generate_messages_lisp _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/img_pose_result.msg" NAME_WE)
add_dependencies(landmark_generate_messages_lisp _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/VisionCheckResult.msg" NAME_WE)
add_dependencies(landmark_generate_messages_lisp _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/VisionPose.msg" NAME_WE)
add_dependencies(landmark_generate_messages_lisp _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/des_vector.msg" NAME_WE)
add_dependencies(landmark_generate_messages_lisp _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/relocal.msg" NAME_WE)
add_dependencies(landmark_generate_messages_lisp _landmark_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(landmark_genlisp)
add_dependencies(landmark_genlisp landmark_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS landmark_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/img_pose.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovarianceStamped.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/landmark
)
_generate_msg_nodejs(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/img_pose_result.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/landmark
)
_generate_msg_nodejs(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/VisionCheckResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovarianceStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/landmark
)
_generate_msg_nodejs(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/VisionPose.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovarianceStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/landmark
)
_generate_msg_nodejs(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/des_vector.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovarianceStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/landmark
)
_generate_msg_nodejs(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/relocal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/landmark
)

### Generating Services

### Generating Module File
_generate_module_nodejs(landmark
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/landmark
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(landmark_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(landmark_generate_messages landmark_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/img_pose.msg" NAME_WE)
add_dependencies(landmark_generate_messages_nodejs _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/img_pose_result.msg" NAME_WE)
add_dependencies(landmark_generate_messages_nodejs _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/VisionCheckResult.msg" NAME_WE)
add_dependencies(landmark_generate_messages_nodejs _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/VisionPose.msg" NAME_WE)
add_dependencies(landmark_generate_messages_nodejs _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/des_vector.msg" NAME_WE)
add_dependencies(landmark_generate_messages_nodejs _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/relocal.msg" NAME_WE)
add_dependencies(landmark_generate_messages_nodejs _landmark_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(landmark_gennodejs)
add_dependencies(landmark_gennodejs landmark_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS landmark_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/img_pose.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovarianceStamped.msg;/opt/ros/noetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/landmark
)
_generate_msg_py(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/img_pose_result.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/landmark
)
_generate_msg_py(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/VisionCheckResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovarianceStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/landmark
)
_generate_msg_py(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/VisionPose.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovarianceStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/landmark
)
_generate_msg_py(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/des_vector.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseWithCovarianceStamped.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/landmark
)
_generate_msg_py(landmark
  "/home/nvidia/dconic_nav/src/landmark/msg/relocal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/landmark
)

### Generating Services

### Generating Module File
_generate_module_py(landmark
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/landmark
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(landmark_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(landmark_generate_messages landmark_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/img_pose.msg" NAME_WE)
add_dependencies(landmark_generate_messages_py _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/img_pose_result.msg" NAME_WE)
add_dependencies(landmark_generate_messages_py _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/VisionCheckResult.msg" NAME_WE)
add_dependencies(landmark_generate_messages_py _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/VisionPose.msg" NAME_WE)
add_dependencies(landmark_generate_messages_py _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/des_vector.msg" NAME_WE)
add_dependencies(landmark_generate_messages_py _landmark_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/landmark/msg/relocal.msg" NAME_WE)
add_dependencies(landmark_generate_messages_py _landmark_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(landmark_genpy)
add_dependencies(landmark_genpy landmark_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS landmark_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/landmark)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/landmark
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(landmark_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()
if(TARGET sensor_msgs_generate_messages_cpp)
  add_dependencies(landmark_generate_messages_cpp sensor_msgs_generate_messages_cpp)
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(landmark_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/landmark)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/landmark
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(landmark_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()
if(TARGET sensor_msgs_generate_messages_eus)
  add_dependencies(landmark_generate_messages_eus sensor_msgs_generate_messages_eus)
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(landmark_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/landmark)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/landmark
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(landmark_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()
if(TARGET sensor_msgs_generate_messages_lisp)
  add_dependencies(landmark_generate_messages_lisp sensor_msgs_generate_messages_lisp)
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(landmark_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/landmark)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/landmark
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(landmark_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()
if(TARGET sensor_msgs_generate_messages_nodejs)
  add_dependencies(landmark_generate_messages_nodejs sensor_msgs_generate_messages_nodejs)
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(landmark_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/landmark)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/landmark\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/landmark
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(landmark_generate_messages_py geometry_msgs_generate_messages_py)
endif()
if(TARGET sensor_msgs_generate_messages_py)
  add_dependencies(landmark_generate_messages_py sensor_msgs_generate_messages_py)
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(landmark_generate_messages_py std_msgs_generate_messages_py)
endif()
