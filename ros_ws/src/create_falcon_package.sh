#!/bin/bash

set -e

WS_DIR=~/FALCON-SYS/ros_ws
PKG_NAME=falcon_mapping_system
PKG_DIR=$WS_DIR/src/$PKG_NAME

echo "Creating package: $PKG_NAME"

# Create package structure
mkdir -p $PKG_DIR/{launch,config,scripts,rviz}
cd $PKG_DIR

# Create package.xml
cat > package.xml << 'EOF'
<?xml version="1.0"?>
<package format="3">
  <name>falcon_mapping_system</name>
  <version>0.1.0</version>
  <description>Integrated SLAM + WebSocket mapping system for RPLidar and future Pixhawk integration.</description>

  <maintainer email="you@example.com">Your Name</maintainer>
  <license>MIT</license>

  <buildtool_depend>ament_cmake</buildtool_depend>
  <exec_depend>rclpy</exec_depend>
  <exec_depend>rclcpp</exec_depend>
  <exec_depend>slam_toolbox</exec_depend>
  <exec_depend>rplidar_ros</exec_depend>
  <exec_depend>tf2_ros</exec_depend>
  <exec_depend>nav_msgs</exec_depend>
  <exec_depend>geometry_msgs</exec_depend>
  <exec_depend>std_msgs</exec_depend>
  <exec_depend>sensor_msgs</exec_depend>
</package>
EOF

# Create CMakeLists.txt
cat > CMakeLists.txt << 'EOF'
cmake_minimum_required(VERSION 3.8)
project(falcon_mapping_system)

find_package(ament_cmake REQUIRED)
find_package(rclpy REQUIRED)

install(PROGRAMS
  scripts/websocket_publisher.py
  DESTINATION lib/${PROJECT_NAME}
)

install(DIRECTORY
  launch config rviz
  DESTINATION share/${PROJECT_NAME}
)

ament_package()
EOF

# Create launch file
cat > launch/falcon_launch.py << 'EOF'
from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    return LaunchDescription([
        Node(
            package='rplidar_ros',
            executable='rplidar_composition',
            name='rplidar_node',
            parameters=[{'serial_port': '/dev/ttyUSB0', 'frame_id': 'laser'}],
            output='screen'
        ),
        Node(
            package='slam_toolbox',
            executable='async_slam_toolbox_node',
            name='slam_toolbox',
            parameters=['config/slam_toolbox_params.yaml'],
            output='screen'
        ),
        Node(
            package='falcon_mapping_system',
            executable='websocket_publisher.py',
            name='websocket_publisher',
            output='screen'
        )
    ])
EOF

# Create slam toolbox config
cat > config/slam_toolbox_params.yaml << 'EOF'
slam_toolbox:
  ros__parameters:
    use_sim_time: false
    mode: "mapping"
    resolution: 0.05
    publish_period: 1.0
    map_file_name: "map"
    map_start_pose: [0.0, 0.0, 0.0]
    odom_frame: "odom"
    map_frame: "map"
    base_frame: "base_link"
    scan_topic: "scan"
    transform_publish_period: 0.05
EOF

# Create websocket publisher script
cat > scripts/websocket_publisher.py << 'EOF'
#!/usr/bin/env python3

import rclpy
from rclpy.node import Node
import asyncio
import threading
import websockets
import json
from nav_msgs.msg import OccupancyGrid

class MapWebSocketPublisher(Node):
    def __init__(self):
        super().__init__('map_websocket_publisher')
        self.subscription = self.create_subscription(
            OccupancyGrid,
            '/map',
            self.listener_callback,
            10)
        self.latest_map = None
        threading.Thread(target=self.websocket_thread, daemon=True).start()

    def listener_callback(self, msg):
        self.latest_map = {
            'width': msg.info.width,
            'height': msg.info.height,
            'resolution': msg.info.resolution,
            'origin': {
                'position': {
                    'x': msg.info.origin.position.x,
                    'y': msg.info.origin.position.y
                }
            },
            'data': list(msg.data)
        }

    async def handler(self, websocket, path):
        while True:
            if self.latest_map:
                await websocket.send(json.dumps(self.latest_map))
            await asyncio.sleep(1)

    def websocket_thread(self):
        asyncio.run(websockets.serve(self.handler, "0.0.0.0", 8765))
        asyncio.get_event_loop().run_forever()

def main(args=None):
    rclpy.init(args=args)
    node = MapWebSocketPublisher()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
EOF

# Make the script executable
chmod +x scripts/websocket_publisher.py

echo "Package $PKG_NAME created successfully."
echo "Run 'colcon build --packages-select $PKG_NAME' from your workspace root."
