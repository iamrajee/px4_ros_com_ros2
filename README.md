# Documentation: https://docs.google.com/document/d/1ZPXg8pRfYiuOkcLDv2s443YgoQIDe3rJ55hZbEZgDIU/edit?usp=sharing

## A. Launch Simulation and QGC
```
~/PX4-Autopilot
make px4_sitl_rtps gazebo
```

## B. Open QGC, Important!
```
~/.PX4-Autopilot/QGroundControl.AppImage
```

## C. Now move to workspace and run MicroROS Agent
```
cd ~/px4_ros_com_ros2
source /opt/ros/foxy/setup.bash
source ~/px4_ros_com_ros2/install/setup.bash
micrortps_agent -t UDP
```

## D. Offboard: ROSNode
```
ros2 run px4_ros_com offboard_control
```

`              OR                    `

## D.(Optional) Commandline, Open 4 terminal as below:-

### 1: Only position change in setpoint allowed
```
ros2 topic pub /fmu/offboard_control_mode/in px4_msgs/msg/OffboardControlMode "{position: true}"
```

### 2: Send Trajectory
```
ros2 topic pub /fmu/trajectory_setpoint/in px4_msgs/msg/TrajectorySetpoint "position:
- 0.0
- 0.0
- -5.0
yaw: -3.14"
```
`After 10 iteration of above commands, run below command` 

### 3: Enable offboard Mode
```
ros2 topic pub /fmu/vehicle_command/in px4_msgs/msg/VehicleCommand "{param1: 1,
param2: 6,
command: 176,
target_system: 1,
target_component: 1,
source_system: 1,
source_component: 1,
from_external: true}"
```

### 4: Arm!
```
ros2 topic pub /fmu/vehicle_command/in px4_msgs/msg/VehicleCommand "{param1: 1,
command: 400,
target_system: 1,
target_component: 1,
source_system: 1,
source_component: 1,
from_external: true}"
```

#### If required: Disarm
```
ros2 topic pub /fmu/vehicle_command/in px4_msgs/msg/VehicleCommand "{param1: 0,
command: 400,
target_system: 1,
target_component: 1,
source_system: 1,
source_component: 1,
from_external: true}"
```
