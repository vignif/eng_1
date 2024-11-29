#!/bin/bash
# apt-get update

# pwd

source /opt/ros/melodic/setup.bash

catkin build

source devel/setup.bash

roslaunch engagement_detector engagement_detector.launch

# Keep the container running
exec "$@"
