# CMake generated Testfile for 
# Source directory: /home/nvidia/dconic_nav/src/tf2_web_republisher
# Build directory: /home/nvidia/dconic_nav/build/tf2_web_republisher
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(_ctest_tf2_web_republisher_rostest_test_test_tf2_web_republisher.test "/home/nvidia/dconic_nav/build/tf2_web_republisher/catkin_generated/env_cached.sh" "/usr/bin/python3" "/opt/ros/noetic/share/catkin/cmake/test/run_tests.py" "/home/nvidia/dconic_nav/build/tf2_web_republisher/test_results/tf2_web_republisher/rostest-test_test_tf2_web_republisher.xml" "--return-code" "/usr/bin/python3 /opt/ros/noetic/share/rostest/cmake/../../../bin/rostest --pkgdir=/home/nvidia/dconic_nav/src/tf2_web_republisher --package=tf2_web_republisher --results-filename test_test_tf2_web_republisher.xml --results-base-dir \"/home/nvidia/dconic_nav/build/tf2_web_republisher/test_results\" /home/nvidia/dconic_nav/src/tf2_web_republisher/test/test_tf2_web_republisher.test ")
set_tests_properties(_ctest_tf2_web_republisher_rostest_test_test_tf2_web_republisher.test PROPERTIES  _BACKTRACE_TRIPLES "/opt/ros/noetic/share/catkin/cmake/test/tests.cmake;160;add_test;/opt/ros/noetic/share/rostest/cmake/rostest-extras.cmake;52;catkin_run_tests_target;/home/nvidia/dconic_nav/src/tf2_web_republisher/CMakeLists.txt;83;add_rostest;/home/nvidia/dconic_nav/src/tf2_web_republisher/CMakeLists.txt;0;")
subdirs("gtest")
