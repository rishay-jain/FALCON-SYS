import os

from launch import LaunchDescription
from launch.actions import IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from ament_index_python.packages import get_package_share_directory
from launch_ros.actions import Node

def generate_launch_description():
    rplidar_launch_path = os.path.join(
        get_package_share_directory('rplidar_ros'),
        'launch',
        'rplidar_c1_launch.py')

    return LaunchDescription([
        IncludeLaunchDescription(
            PythonLaunchDescriptionSource(rplidar_launch_path),
            launch_arguments={
                'serial_port': '/dev/ttyUSB0',
                'serial_baudrate': '460800',
                'frame_id': 'laser',
                'inverted': 'false',
                'angle_compensate': 'true',
                'scan_mode': 'Standard',
                'channel_type': 'serial'
            }.items(),
        ),

        Node(
            package='slam_toolbox',
            executable='sync_slam_toolbox_node',
            name='slam_toolbox',
            output='screen',
            parameters=[{
                # your slam parameters here
            }],
        ),

        Node(
            package='falcon_mapping_system',
            executable='websocket_publisher',
            name='websocket_publisher',
            output='screen',
        ),
    ])
