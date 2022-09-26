source /opt/ros/foxy/setup.bash
source ~/px4_ros_com_ros2/install/setup.bash
ros2 topic pub /fmu/offboard_control_mode/in px4_msgs/msg/OffboardControlMode "{position: true}"
