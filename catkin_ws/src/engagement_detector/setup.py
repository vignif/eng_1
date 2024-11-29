#!/usr/bin/env python

from setuptools import setup
from catkin_pkg.python_setup import generate_distutils_setup

# Importing required modules for Python 3 compatibility
import sys
if sys.version_info < (3,):
    from io import open

d = generate_distutils_setup(
    packages=['engagement_detector'],
    # scripts=['scripts'],
    package_dir={'': 'src'},
    install_requires=['numpy', 'Pillow', 'tensorflow-gpu==1.14.0', 'keras==2.2.4', 'opencv-python', 'rospkg']
)

setup(**d)
