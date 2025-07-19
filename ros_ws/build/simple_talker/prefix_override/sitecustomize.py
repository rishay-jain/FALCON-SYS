import sys
if sys.prefix == '/usr':
    sys.real_prefix = sys.prefix
    sys.prefix = sys.exec_prefix = '/home/falcon/FALCON-SYS/ros_ws/install/simple_talker'
