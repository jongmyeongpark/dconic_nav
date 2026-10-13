# CMake generated Testfile for 
# Source directory: /home/nvidia/dconic_nav/src/costmap_converter
# Build directory: /home/nvidia/dconic_nav/build/costmap_converter
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(_ctest_costmap_converter_rostest_test_costmap_polygons.test "/home/nvidia/dconic_nav/build/costmap_converter/catkin_generated/env_cached.sh" "/usr/bin/python3" "/opt/ros/noetic/share/catkin/cmake/test/run_tests.py" "/home/nvidia/dconic_nav/build/costmap_converter/test_results/costmap_converter/rostest-test_costmap_polygons.xml" "--return-code" "/usr/bin/python3 /opt/ros/noetic/share/rostest/cmake/../../../bin/rostest --pkgdir=/home/nvidia/dconic_nav/src/costmap_converter --package=costmap_converter --results-filename test_costmap_polygons.xml --results-base-dir \"/home/nvidia/dconic_nav/build/costmap_converter/test_results\" /home/nvidia/dconic_nav/src/costmap_converter/test/costmap_polygons.test ")
set_tests_properties(_ctest_costmap_converter_rostest_test_costmap_polygons.test PROPERTIES  _BACKTRACE_TRIPLES "/opt/ros/noetic/share/catkin/cmake/test/tests.cmake;160;add_test;/opt/ros/noetic/share/rostest/cmake/rostest-extras.cmake;52;catkin_run_tests_target;/opt/ros/noetic/share/rostest/cmake/rostest-extras.cmake;80;add_rostest;/opt/ros/noetic/share/rostest/cmake/rostest-extras.cmake;100;_add_rostest_google_test;/home/nvidia/dconic_nav/src/costmap_converter/CMakeLists.txt;231;add_rostest_gtest;/home/nvidia/dconic_nav/src/costmap_converter/CMakeLists.txt;0;")
subdirs("gtest")
