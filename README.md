# ros_ubuntu_install

Copyright 2024 mkdir-sweetiepie <br>
https://github.com/mkdir-sweetiepie/ros_ubuntu_install  <br>
Licensed under the MIT License <br>

## 참고 사이트
ros_humble_install <br>
(https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debs.html)

ros_humble_install (jetpack) <br>
(https://nvidia-isaac-ros.github.io/getting_started/isaac_apt_repository.html#isaac-ros-buildfarm)

## 한줄 설치 가이드
This .sh file will install ROS2 Humble autometicaly. <br>
Commit this command in terminal
1. git repo install && cd
```shell
git clone https://github.com/mkdir-sweetiepie/ros_ubuntu_install.git
cd ros_ubuntu_install
```

2. select version
### ROS2 HUMBLE on UBUNTU 20.04 focal
```shell
chmod +x ros2_humble_install_on_20.04.sh
./ros2_humble_install_on_20.04.sh
```

### ROS2 HUMBLE on UBUNTU 22.04 jammy
```shell
chmod +x ros2_humble_install_on_22.04.sh
./ros2_humble_install_on_22.04.sh
```

### ROS2 HUMBLE on Jetpack 5.x or Jetson Nano 20.04 focal
```shell
chmod +x ros2_humble_install_on_jetson_20.04.sh
./ros2_humble_install_on_jetson_20.04.sh 
```
