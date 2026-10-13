from catkin_pkg.python_setup import generate_distutils_setup
from setuptools import setup

setup_args = generate_distutils_setup(
    packages=['media_streamer'],
    package_dir={'': 'src'},
    install_requires=['inject', 'python-socketio[client]']
)

setup(**setup_args)
