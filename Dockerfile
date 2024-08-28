# Use the official ROS Noetic base image
FROM ros:noetic-ros-core

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    python3-catkin-tools \
    python3-rosdep \
    python3-rosinstall \
    python3-rosinstall-generator \
    python3-wstool \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set up the ROS workspace
WORKDIR /catkin_ws
RUN mkdir -p src

# Copy the ROS package from the local machine into the Docker image
COPY src/ros_pub_sub /catkin_ws/src/ros_pub_sub

# Initialize and build the workspace
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && catkin_make"

# Source the workspace setup and run the ROS launch file
CMD ["bash", "-c", "source /opt/ros/noetic/setup.bash && source /catkin_ws/devel/setup.bash && roslaunch ros_pub_sub pub_sub.launch"]

