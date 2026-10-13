# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "node_alive: 0 messages, 1 services")

set(MSG_I_FLAGS "-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(node_alive_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/nvidia/dconic_nav/src/node_alive/srv/ListNodesAlive.srv" NAME_WE)
add_custom_target(_node_alive_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "node_alive" "/home/nvidia/dconic_nav/src/node_alive/srv/ListNodesAlive.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages

### Generating Services
_generate_srv_cpp(node_alive
  "/home/nvidia/dconic_nav/src/node_alive/srv/ListNodesAlive.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/node_alive
)

### Generating Module File
_generate_module_cpp(node_alive
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/node_alive
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(node_alive_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(node_alive_generate_messages node_alive_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nvidia/dconic_nav/src/node_alive/srv/ListNodesAlive.srv" NAME_WE)
add_dependencies(node_alive_generate_messages_cpp _node_alive_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(node_alive_gencpp)
add_dependencies(node_alive_gencpp node_alive_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS node_alive_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages

### Generating Services
_generate_srv_eus(node_alive
  "/home/nvidia/dconic_nav/src/node_alive/srv/ListNodesAlive.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/node_alive
)

### Generating Module File
_generate_module_eus(node_alive
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/node_alive
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(node_alive_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(node_alive_generate_messages node_alive_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nvidia/dconic_nav/src/node_alive/srv/ListNodesAlive.srv" NAME_WE)
add_dependencies(node_alive_generate_messages_eus _node_alive_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(node_alive_geneus)
add_dependencies(node_alive_geneus node_alive_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS node_alive_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(node_alive
  "/home/nvidia/dconic_nav/src/node_alive/srv/ListNodesAlive.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/node_alive
)

### Generating Module File
_generate_module_lisp(node_alive
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/node_alive
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(node_alive_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(node_alive_generate_messages node_alive_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nvidia/dconic_nav/src/node_alive/srv/ListNodesAlive.srv" NAME_WE)
add_dependencies(node_alive_generate_messages_lisp _node_alive_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(node_alive_genlisp)
add_dependencies(node_alive_genlisp node_alive_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS node_alive_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages

### Generating Services
_generate_srv_nodejs(node_alive
  "/home/nvidia/dconic_nav/src/node_alive/srv/ListNodesAlive.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/node_alive
)

### Generating Module File
_generate_module_nodejs(node_alive
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/node_alive
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(node_alive_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(node_alive_generate_messages node_alive_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nvidia/dconic_nav/src/node_alive/srv/ListNodesAlive.srv" NAME_WE)
add_dependencies(node_alive_generate_messages_nodejs _node_alive_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(node_alive_gennodejs)
add_dependencies(node_alive_gennodejs node_alive_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS node_alive_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(node_alive
  "/home/nvidia/dconic_nav/src/node_alive/srv/ListNodesAlive.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/node_alive
)

### Generating Module File
_generate_module_py(node_alive
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/node_alive
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(node_alive_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(node_alive_generate_messages node_alive_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nvidia/dconic_nav/src/node_alive/srv/ListNodesAlive.srv" NAME_WE)
add_dependencies(node_alive_generate_messages_py _node_alive_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(node_alive_genpy)
add_dependencies(node_alive_genpy node_alive_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS node_alive_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/node_alive)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/node_alive
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(node_alive_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/node_alive)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/node_alive
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(node_alive_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/node_alive)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/node_alive
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(node_alive_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/node_alive)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/node_alive
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(node_alive_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/node_alive)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/node_alive\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/node_alive
    DESTINATION ${genpy_INSTALL_DIR}
    # skip all init files
    PATTERN "__init__.py" EXCLUDE
    PATTERN "__init__.pyc" EXCLUDE
  )
  # install init files which are not in the root folder of the generated code
  string(REGEX REPLACE "([][+.*()^])" "\\\\\\1" ESCAPED_PATH "${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/node_alive")
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/node_alive
    DESTINATION ${genpy_INSTALL_DIR}
    FILES_MATCHING
    REGEX "${ESCAPED_PATH}/.+/__init__.pyc?$"
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(node_alive_generate_messages_py std_msgs_generate_messages_py)
endif()
