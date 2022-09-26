source /opt/ros/foxy/setup.bash
source ~/px4_ros_com_ros2/install/setup.bash
ros2 topic pub /fmu/vehicle_command/in px4_msgs/msg/VehicleCommand "{param1: 1,
command: 400,
target_system: 1,
target_component: 1,
source_system: 1,
source_component: 1,
from_external: true}"
