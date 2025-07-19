#!/bin/bash

# Log start time
echo "=== LIDAR startup script initiated at $(date) ==="

# Source ROS 2 setup
source /opt/ros/humble/setup.bash

# Source your workspace
source ~/FALCON-SYS/ros_ws/install/setup.bash

# Start RPLidar C1 if not already running
if ! pgrep -f "rplidar_c1_launch.py" > /dev/null; then
  echo "[INFO] Starting RPLidar C1 node..."
  ros2 launch rplidar_ros rplidar_c1_launch.py >> ~/lidar.log 2>&1 &
else
  echo "[INFO] RPLidar C1 node already running."
fi

# Wait for LIDAR to initialize
sleep 2

# Start rosbridge if not already running
if ! lsof -i :9090 > /dev/null; then
  echo "[INFO] Starting rosbridge_server..."
  ros2 launch rosbridge_server rosbridge_websocket_launch.xml >> ~/rosbridge.log 2>&1 &
else
  echo "[INFO] rosbridge_server already running on port 9090."
fi

echo "=== LIDAR startup script completed at $(date) ==="
