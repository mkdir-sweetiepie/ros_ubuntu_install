#! /bin/bash
# Install ROS2 Humble

# Copyright 2024 mkdir-sweetiepie
# https://github.com/mkdir-sweetiepie/ros_ubuntu_install
# Licensed under the , Version 2.0

function custom_echo() {
  text=$1                      # 첫 번째 인자는 출력할 텍스트입니다.
  color=$2                     # 두 번째 인자는 출력할 색상입니다.
  terminal_width=$(tput cols)  # 현재 터미널의 너비(컬럼 수)를 가져옵니다.

  case $color in
    "green")
      echo -e "\033[32m[RO:BIT] $text\033[0m"
      ;;
    "red")
      echo -e "\033[31m [RO:BIT] $text\033[0m"
      ;;
    *)
      echo "$text"
      ;;
  esac
}
