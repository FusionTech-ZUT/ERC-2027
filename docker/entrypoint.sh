#!/bin/bash
set -e

# Source ROS 2 Humble (systemowy)
source /opt/ros/humble/setup.bash

# Source workspace jeśli został już zbudowany (po pierwszej kompilacji)
if [ -f "/root/ros2_ws/install/setup.bash" ]; then
    source /root/ros2_ws/install/setup.bash
fi

# Wykonanie komendy przekazanej do kontenera
exec "$@"
