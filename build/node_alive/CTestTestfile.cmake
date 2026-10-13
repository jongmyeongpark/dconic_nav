# CMake generated Testfile for 
# Source directory: /home/nvidia/dconic_nav/src/node_alive
# Build directory: /home/nvidia/dconic_nav/build/node_alive
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(_ctest_node_alive_nosetests_test "/home/nvidia/dconic_nav/build/node_alive/catkin_generated/env_cached.sh" "/usr/bin/python3" "/opt/ros/noetic/share/catkin/cmake/test/run_tests.py" "/home/nvidia/dconic_nav/build/node_alive/test_results/node_alive/nosetests-test.xml" "--return-code" "\"/usr/bin/cmake\" -E make_directory /home/nvidia/dconic_nav/build/node_alive/test_results/node_alive" "/usr/bin/nosetests3 -P --process-timeout=60 --where=/home/nvidia/dconic_nav/src/node_alive/test --with-xunit --xunit-file=/home/nvidia/dconic_nav/build/node_alive/test_results/node_alive/nosetests-test.xml")
set_tests_properties(_ctest_node_alive_nosetests_test PROPERTIES  _BACKTRACE_TRIPLES "/opt/ros/noetic/share/catkin/cmake/test/tests.cmake;160;add_test;/opt/ros/noetic/share/catkin/cmake/test/nosetests.cmake;83;catkin_run_tests_target;/home/nvidia/dconic_nav/src/node_alive/CMakeLists.txt;29;catkin_add_nosetests;/home/nvidia/dconic_nav/src/node_alive/CMakeLists.txt;0;")
subdirs("gtest")
