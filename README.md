# ROS2 FOXY Workspace

[![Build Status](http://img.shields.io/travis/badges/badgerbadgerbadger.svg?style=flat-square)](https://travis-ci.org/badges/badgerbadgerbadger) [![Coverage Status](http://img.shields.io/coveralls/badges/badgerbadgerbadger.svg?style=flat-square)](https://coveralls.io/r/badges/badgerbadgerbadger) [![MIT License](https://img.shields.io/github/license/iamrajee/px4_ros_com_ros2.svg)](http://badges.mit-license.org) [![GitHub Issues](https://img.shields.io/github/issues/iamrajee/px4_ros_com_ros2.svg)](https://github.com/iamrajee/px4_ros_com_ros2/issues) [![GitHub Pull Requests](https://img.shields.io/github/issues-pr/iamrajee/px4_ros_com_ros2.svg)](https://github.com/iamrajee/px4_ros_com_ros2/pulls) [![Gitter](https://badges.gitter.im/iamrajee-ROS/community.svg)](https://gitter.im/iamrajee-ROS/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge) [![Join our Slack Workspace](https://img.shields.io/badge/Slack%20Workspace-roboticsclubiitpkd.slack.com-blue.svg?logo=slack&longCache=true&style=flat)](https://roboticsclubiitpkd.slack.com) 
<!---
[![Gem Version](http://img.shields.io/gem/v/badgerbadgerbadger.svg?style=flat-square)](https://rubygems.org/gems/badgerbadgerbadger)
[![first-timers-only](https://img.shields.io/badge/first--timers--only-friendly-blue.svg)](https://www.firsttimersonly.com/)
--->

This ROS2 Foxy workspace is created on Ubuntu 20.04.  Here I have worked on some px4-ros2 related projects. 

# Documentation: [click here](https://docs.google.com/document/d/1ZPXg8pRfYiuOkcLDv2s443YgoQIDe3rJ55hZbEZgDIU/edit?usp=sharing)

<br/><br/>

## Table of content
- [Installation](https://github.com/iamrajee/px4_ros_com_ros2#installation)
- [Run](https://github.com/iamrajee/px4_ros_com_ros2#run)
- [Package description](https://github.com/iamrajee/px4_ros_com_ros2#package-description)
- [Helper scripts](https://github.com/iamrajee/px4_ros_com_ros2#helper-scripts)
- [Team](https://github.com/iamrajee/px4_ros_com_ros2#team)
- [Contributing](https://github.com/iamrajee/px4_ros_com_ros2#contributing)
- [FAQ](https://github.com/iamrajee/px4_ros_com_ros2#faq)
- [Support](https://github.com/iamrajee/px4_ros_com_ros2#support)
- [License](https://github.com/iamrajee/px4_ros_com_ros2#license)
- [Acknowledgments](https://github.com/iamrajee/px4_ros_com_ros2#acknowledgments)
<!--- - [xyz](link) --->

---

## Installation

> All the `code` required to get started
- #### Prerequisite
    - You should have ROS2 Foxy on your ubuntu 20.04.
    - All ROS dependency is satisfied.

- #### Clone

    ```
    git clone https://github.com/iamrajee/px4_ros_com_ros2.git
    ```

- #### Setup
    ```
    cd px4_ros_com_ros2/
    ./source.sh
    make
    ```
---
## RUN

### A. Launch Simulation and QGC
```
~/PX4-Autopilot
make px4_sitl_rtps gazebo
```

### B. Open QGC, Important!
```
~/.PX4-Autopilot/QGroundControl.AppImage
```

### C. Now move to workspace and run MicroROS Agent
```
cd ~/px4_ros_com_ros2
source /opt/ros/foxy/setup.bash
source ~/px4_ros_com_ros2/install/setup.bash
micrortps_agent -t UDP
```

### D. Offboard: ROSNode([Demo!](https://youtu.be/IpPRvqkHRw8))
```
ros2 run px4_ros_com offboard_control
```

`              OR                    `

### D.(Optional) Commandline, Open 4 terminal as below:-
([Demo!](https://youtu.be/Rl_CBXy5bfY))
#### 1: Only position change in setpoint allowed
```
ros2 topic pub /fmu/offboard_control_mode/in px4_msgs/msg/OffboardControlMode "{position: true}"
```

#### 2: Send Trajectory
```
ros2 topic pub /fmu/trajectory_setpoint/in px4_msgs/msg/TrajectorySetpoint "position:
- 0.0
- 0.0
- -5.0
yaw: -3.14"
```
`After 10 iteration of above commands, run below command` 

#### 3: Enable offboard Mode
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

#### 4: Arm!
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

---

## Package description

* ## [px4_msgs](src/px4_msgs)
    > It is package px4 related msgs for ros2,
    #### TODO
* ## [px4_ros_com](src/px4_ros_com)
    > It is package contains all the basic scripts and dependencies for px4 functionalities.
    #### TODO
* ## [testpkg](src/testpkg)
    > TODO: It is custom pkg
    
   
---
<br/><br/>
# Helper Scripts

* ## source.sh
    ```
    #!/bin/bash
    source /opt/ros/foxy/setup.bash
    source install/local_setup.bash
    source install/setup.bash
    clear
    ```
    > It will source the workspace after buiding workspace or after creating new pkg. Run it as `./source.sh`

* ## makefile
    ```
    SHELL=/bin/bash
    all:
        make run
    run:
        colcon build --symlink-install
        bash source.sh
    ```
    > It will build the workspace . Run it as `make`

* ## createpkg.sh
    ```
    #!/bin/bash
    cd src/
    ros2 pkg create $1 --build-type ament_cmake --node-name cpp_node
    cd ../
    #ls src/
    make
    source source.sh
    ```
    > It will create new package . Run it as `./createpkg.sh newpkg_name`

* ## tftree.sh
    ```
    #!/bin/bash
    ros2 run rqt_tf_tree rqt_tf_tree
    ```
    > It will  launch the gui to visvualise the tf tree. Run it as `./tftree.sh`

* ## printenv.sh
    ```
    #!/bin/bash
    printenv | grep -i ROS
    ```
    > It will print the ROS related environment variable . Run it as `./printenv.sh`

* ## rosdep.sh
    ```
    sudo rosdep install -i --from-path src --rosdistro $ROS_DISTRO -y
    ```
    > It will install dependencies of all pkg in the workspace. Run it in the workspace as `./rosdep.sh`

* ## ssh_into_another_computer.sh
    ```
    #!/bin/bash
    ssh rajendra@rajendra
    ```
    > It will ssh into another system. Useful when using multiple ros masters. Run it as `./rajendra.sh`

---
<br/><br/>
## Team

> Or Contributors/supporters/mentors/guides who helped me out in these projects.
<!---
| <a href="https://github.com/MuskaanMaheshwari" target="_blank">**Muskaan Maheshwari**</a> | <a href="https://www.linkedin.com/in/sachin-rustagi-882b55145/" target="_blank">**Sachin Rustagi**</a> | <a href="https://www.linkedin.com/in/s-m-rafi-911442130/" target="_blank">**S M Rafi**</a> |
| :---: |:---:| :---:|
--->
| <a href="https://github.com/akshata-1" target="_blank">**Akshata**</a> | <a href="https://www.linkedin.com/in/sachin-rustagi-882b55145/" target="_blank">**Sachin Rustagi**</a> | <a href="https://github.com/amins1" target="_blank">**Swami Prasad**</a> |
| :---: |:---:| :---:|
| ![](https://avatars0.githubusercontent.com/u/47593305?s=200&v=3) | ![](https://avatars0.githubusercontent.com/u/917816?s=200&v=3) | ![](https://avatars0.githubusercontent.com/u/48486228?s=200&v=3)  |


---

## Contributing

> To get started...

### Step 1

- **Option 1**
    - 🍴 Fork this repo!

- **Option 2**
    - 👯 Clone this repo to your local machine using `https://github.com/iamrajee/px4_ros_com_ros2.git`

### Step 2

- **HACK AWAY!** 🔨🔨🔨

### Step 3

- 🔃 Create a new pull request using <a href="https://github.com/iamrajee/px4_ros_com_ros2/compare/" target="_blank">`https://github.com/iamrajee/px4_ros_com_ros2/compare/`</a>.
---

## FAQ

- **I ran into some issue while running above package, what to do now?**
    - Simply contact me!

---

## Support
Reach out to me for any help!
|  |  |
| :---: | --- |
| ![](https://avatars0.githubusercontent.com/u/25712145?s=200&v=3) | Name : Rajendra Singh<br/> Email  : singh.raj1997@gmail.com<br/> Web    : https://iamrajee.github.io/<br/> LinkedIn    : https://www.linkedin.com/in/rajendra-singh-6b0b3a13a/<br/> Twitter: <a href="https://twitter.com/i_am_rajee" target="_blank">`@i_am_rajee`</a> |
|  |  |
 
---

## License

[![MIT License](https://img.shields.io/github/license/iamrajee/px4_ros_com_ros2.svg)](http://badges.mit-license.org)

- **[MIT license](http://opensource.org/licenses/mit-license.php)**
- Copyright (c) 2019 [Rajendra Singh](https://iamrajee.github.io/).
---

## Acknowledgments

* Hat tip to anyone whose code was used and thanks to everyone who inspired and supported me in this project.
