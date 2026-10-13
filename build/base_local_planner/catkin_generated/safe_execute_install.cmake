execute_process(COMMAND "/home/nvidia/dconic_nav/build/base_local_planner/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/nvidia/dconic_nav/build/base_local_planner/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
