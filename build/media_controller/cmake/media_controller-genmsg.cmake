# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "media_controller: 4 messages, 1 services")

set(MSG_I_FLAGS "-Imedia_controller:/home/nvidia/dconic_nav/src/media_controller/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(media_controller_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/CongestionLevel.msg" NAME_WE)
add_custom_target(_media_controller_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "media_controller" "/home/nvidia/dconic_nav/src/media_controller/msg/CongestionLevel.msg" ""
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/VideoLength.msg" NAME_WE)
add_custom_target(_media_controller_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "media_controller" "/home/nvidia/dconic_nav/src/media_controller/msg/VideoLength.msg" ""
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/VideoPriority.msg" NAME_WE)
add_custom_target(_media_controller_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "media_controller" "/home/nvidia/dconic_nav/src/media_controller/msg/VideoPriority.msg" ""
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/IntArray.msg" NAME_WE)
add_custom_target(_media_controller_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "media_controller" "/home/nvidia/dconic_nav/src/media_controller/msg/IntArray.msg" ""
)

get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/srv/video_info.srv" NAME_WE)
add_custom_target(_media_controller_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "media_controller" "/home/nvidia/dconic_nav/src/media_controller/srv/video_info.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/msg/CongestionLevel.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/media_controller
)
_generate_msg_cpp(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/msg/VideoLength.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/media_controller
)
_generate_msg_cpp(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/msg/VideoPriority.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/media_controller
)
_generate_msg_cpp(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/msg/IntArray.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/media_controller
)

### Generating Services
_generate_srv_cpp(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/srv/video_info.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/media_controller
)

### Generating Module File
_generate_module_cpp(media_controller
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/media_controller
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(media_controller_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(media_controller_generate_messages media_controller_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/CongestionLevel.msg" NAME_WE)
add_dependencies(media_controller_generate_messages_cpp _media_controller_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/VideoLength.msg" NAME_WE)
add_dependencies(media_controller_generate_messages_cpp _media_controller_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/VideoPriority.msg" NAME_WE)
add_dependencies(media_controller_generate_messages_cpp _media_controller_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/IntArray.msg" NAME_WE)
add_dependencies(media_controller_generate_messages_cpp _media_controller_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/srv/video_info.srv" NAME_WE)
add_dependencies(media_controller_generate_messages_cpp _media_controller_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(media_controller_gencpp)
add_dependencies(media_controller_gencpp media_controller_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS media_controller_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/msg/CongestionLevel.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/media_controller
)
_generate_msg_eus(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/msg/VideoLength.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/media_controller
)
_generate_msg_eus(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/msg/VideoPriority.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/media_controller
)
_generate_msg_eus(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/msg/IntArray.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/media_controller
)

### Generating Services
_generate_srv_eus(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/srv/video_info.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/media_controller
)

### Generating Module File
_generate_module_eus(media_controller
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/media_controller
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(media_controller_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(media_controller_generate_messages media_controller_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/CongestionLevel.msg" NAME_WE)
add_dependencies(media_controller_generate_messages_eus _media_controller_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/VideoLength.msg" NAME_WE)
add_dependencies(media_controller_generate_messages_eus _media_controller_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/VideoPriority.msg" NAME_WE)
add_dependencies(media_controller_generate_messages_eus _media_controller_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/IntArray.msg" NAME_WE)
add_dependencies(media_controller_generate_messages_eus _media_controller_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/srv/video_info.srv" NAME_WE)
add_dependencies(media_controller_generate_messages_eus _media_controller_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(media_controller_geneus)
add_dependencies(media_controller_geneus media_controller_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS media_controller_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/msg/CongestionLevel.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/media_controller
)
_generate_msg_lisp(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/msg/VideoLength.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/media_controller
)
_generate_msg_lisp(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/msg/VideoPriority.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/media_controller
)
_generate_msg_lisp(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/msg/IntArray.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/media_controller
)

### Generating Services
_generate_srv_lisp(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/srv/video_info.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/media_controller
)

### Generating Module File
_generate_module_lisp(media_controller
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/media_controller
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(media_controller_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(media_controller_generate_messages media_controller_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/CongestionLevel.msg" NAME_WE)
add_dependencies(media_controller_generate_messages_lisp _media_controller_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/VideoLength.msg" NAME_WE)
add_dependencies(media_controller_generate_messages_lisp _media_controller_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/VideoPriority.msg" NAME_WE)
add_dependencies(media_controller_generate_messages_lisp _media_controller_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/IntArray.msg" NAME_WE)
add_dependencies(media_controller_generate_messages_lisp _media_controller_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/srv/video_info.srv" NAME_WE)
add_dependencies(media_controller_generate_messages_lisp _media_controller_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(media_controller_genlisp)
add_dependencies(media_controller_genlisp media_controller_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS media_controller_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/msg/CongestionLevel.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/media_controller
)
_generate_msg_nodejs(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/msg/VideoLength.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/media_controller
)
_generate_msg_nodejs(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/msg/VideoPriority.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/media_controller
)
_generate_msg_nodejs(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/msg/IntArray.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/media_controller
)

### Generating Services
_generate_srv_nodejs(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/srv/video_info.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/media_controller
)

### Generating Module File
_generate_module_nodejs(media_controller
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/media_controller
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(media_controller_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(media_controller_generate_messages media_controller_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/CongestionLevel.msg" NAME_WE)
add_dependencies(media_controller_generate_messages_nodejs _media_controller_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/VideoLength.msg" NAME_WE)
add_dependencies(media_controller_generate_messages_nodejs _media_controller_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/VideoPriority.msg" NAME_WE)
add_dependencies(media_controller_generate_messages_nodejs _media_controller_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/IntArray.msg" NAME_WE)
add_dependencies(media_controller_generate_messages_nodejs _media_controller_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/srv/video_info.srv" NAME_WE)
add_dependencies(media_controller_generate_messages_nodejs _media_controller_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(media_controller_gennodejs)
add_dependencies(media_controller_gennodejs media_controller_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS media_controller_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/msg/CongestionLevel.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/media_controller
)
_generate_msg_py(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/msg/VideoLength.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/media_controller
)
_generate_msg_py(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/msg/VideoPriority.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/media_controller
)
_generate_msg_py(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/msg/IntArray.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/media_controller
)

### Generating Services
_generate_srv_py(media_controller
  "/home/nvidia/dconic_nav/src/media_controller/srv/video_info.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/media_controller
)

### Generating Module File
_generate_module_py(media_controller
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/media_controller
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(media_controller_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(media_controller_generate_messages media_controller_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/CongestionLevel.msg" NAME_WE)
add_dependencies(media_controller_generate_messages_py _media_controller_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/VideoLength.msg" NAME_WE)
add_dependencies(media_controller_generate_messages_py _media_controller_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/VideoPriority.msg" NAME_WE)
add_dependencies(media_controller_generate_messages_py _media_controller_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/msg/IntArray.msg" NAME_WE)
add_dependencies(media_controller_generate_messages_py _media_controller_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nvidia/dconic_nav/src/media_controller/srv/video_info.srv" NAME_WE)
add_dependencies(media_controller_generate_messages_py _media_controller_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(media_controller_genpy)
add_dependencies(media_controller_genpy media_controller_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS media_controller_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/media_controller)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/media_controller
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(media_controller_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/media_controller)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/media_controller
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(media_controller_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/media_controller)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/media_controller
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(media_controller_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/media_controller)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/media_controller
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(media_controller_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/media_controller)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/media_controller\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/media_controller
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(media_controller_generate_messages_py std_msgs_generate_messages_py)
endif()
