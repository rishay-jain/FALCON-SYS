from setuptools import setup
import os  # <-- added this import

package_name = 'falcon_mapping_system'

setup(
    name=package_name,
    version='0.1.0',
    packages=[package_name],
    data_files=[
        ('share/ament_index/resource_index/packages', ['resource/' + package_name]),
        (os.path.join('share', package_name, 'launch'), ['launch/falcon_launch.py']),
        ('share/' + package_name, ['package.xml']),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='Rishay Jain',
    maintainer_email='rishayjain@gmail.com',
    description='SLAM and WebSocket-based mapping system',
    license='MIT',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            'websocket_publisher = falcon_mapping_system.websocket_publisher:main',
        ],
    },
)
