#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/nvidia/dconic_nav/src/robot_bridge/rosbridge_library"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/nvidia/dconic_nav/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/nvidia/dconic_nav/install/lib/python3/dist-packages:/home/nvidia/dconic_nav/build/rosbridge_library/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/nvidia/dconic_nav/build/rosbridge_library" \
    "/usr/bin/python3" \
    "/home/nvidia/dconic_nav/src/robot_bridge/rosbridge_library/setup.py" \
     \
    build --build-base "/home/nvidia/dconic_nav/build/rosbridge_library" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/nvidia/dconic_nav/install" --install-scripts="/home/nvidia/dconic_nav/install/bin"
