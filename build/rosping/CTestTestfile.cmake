# CMake generated Testfile for 
# Source directory: /home/nvidia/dconic_nav/src/rosping
# Build directory: /home/nvidia/dconic_nav/build/rosping
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(_ctest_rosping_rostest_test_test-rosping.test "/home/nvidia/dconic_nav/build/rosping/catkin_generated/env_cached.sh" "/usr/bin/python3" "/opt/ros/noetic/share/catkin/cmake/test/run_tests.py" "/home/nvidia/dconic_nav/build/rosping/test_results/rosping/rostest-test_test-rosping.xml" "--return-code" "/usr/bin/python3 /opt/ros/noetic/share/rostest/cmake/../../../bin/rostest --pkgdir=/home/nvidia/dconic_nav/src/rosping --package=rosping --results-filename test_test-rosping.xml --results-base-dir \"/home/nvidia/dconic_nav/build/rosping/test_results\" /home/nvidia/dconic_nav/src/rosping/test/test-rosping.test ")
set_tests_properties(_ctest_rosping_rostest_test_test-rosping.test PROPERTIES  _BACKTRACE_TRIPLES "/opt/ros/noetic/share/catkin/cmake/test/tests.cmake;160;add_test;/opt/ros/noetic/share/rostest/cmake/rostest-extras.cmake;52;catkin_run_tests_target;/home/nvidia/dconic_nav/src/rosping/CMakeLists.txt;48;add_rostest;/home/nvidia/dconic_nav/src/rosping/CMakeLists.txt;0;")
subdirs("gtest")
