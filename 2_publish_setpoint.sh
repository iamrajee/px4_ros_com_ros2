source /opt/ros/foxy/setup.bash
source ~/px4_ros_com_ros2/install/setup.bash
ros2 topic pub /fmu/trajectory_setpoint/in px4_msgs/msg/TrajectorySetpoint "position:
- 0.0
- 0.0
- -5.0
yaw: -3.14"
