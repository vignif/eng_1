FROM ros:melodic

LABEL maintainer="Francesco Vigni <vignif@gmail.com>"

# Copy all contents from the current directory to the app directory
COPY /catkin_ws /catkin_ws

# Update aptitude with new repo and install necessary software
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential g++-8 cmake git libopenblas-dev libgtk2.0-dev pkg-config \
    libavcodec-dev libavformat-dev libswscale-dev python-opencv python-rosdep \
    python-catkin-tools libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev \
    libdc1394-22-dev unzip wget ros-melodic-catkin ros-melodic-cv-bridge \
    libyaml-cpp-dev ros-melodic-tf2* apturl libosmesa6-dev libgl1-mesa-dev \
    libglu1-mesa-dev libavdevice-dev libavutil-dev libavfilter-dev python-pip \
    libswresample-dev libfreetype6-dev libsndfile1 libboost-dev libeigen3-dev \
    ros-melodic-image-geometry ros-melodic-trajectory-msgs ros-melodic-visualization-msgs \
    ttf-mscorefonts-installer \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /catkin_ws

# Install pip and upgrade setuptools and wheel for Python 2
RUN pip install --upgrade pip setuptools wheel

# Set Git access token as an environment variable
ENV GIT_ACCESS_TOKEN
RUN git clone https://${GIT_ACCESS_TOKEN}@github.com/vignif/grace_common_msgs.git /catkin_ws/src/grace_common_msgs


# Install Python 2 dependencies
RUN pip install numpy pillow tensorflow==1.14.0 keras==2.2.5 \
    defusedxml netifaces h5py==2.10.0

COPY entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/bin/bash"]
