#! /bin/bash
# ROS2 Humble packages for Jetson users running JetPack 5.x (or based on Ubuntu 20.04 Focal)

# Copyright 2024 mkdir-sweetiepie
# https://github.com/mkdir-sweetiepie/ros_ubuntu_install
# Licensed under the MIT License

function custom_echo() {
  text=$1                     # 첫 번째 인자는 출력할 텍스트입니다.
  color=$2                    # 두 번째 인자는 출력할 색상입니다.
  terminal_width=$(tput cols) # 현재 터미널의 너비(컬럼 수)를 가져옵니다.

  case $color in
  "green")
    echo -e "\033[32m[RO:BIT] $text\033[0m" # 초록색으로 출력
    ;;
  "red")
    echo -e "\033[31m[RO:BIT] $text\033[0m" # 빨간색으로 출력
    ;;
  "yellow")
    echo -e "\033[33m[RO:BIT] $text\033[0m" # 노란색으로 출력
    ;;
  *)
    echo "$text"
    ;;
  esac
}

loading_animation() {
  local interval=1                                    # 프레임 전환 간격을 설정 (0.1초 단위, 0.1초로 표시됨)
  local duration=30                                   # 애니메이션 총 지속 시간 (초 단위)
  local bar_length=$(tput cols)                       # 터미널 창의 너비를 가져옴
  local total_frames=$((duration * interval))         # 총 프레임 수를 계산
  local frame_chars=("█" "▉" "▊" "▋" "▌" "▍" "▎" "▏") # 로딩 애니메이션에 사용할 프레임 문자 배열

  for ((i = 0; i <= total_frames; i++)); do
    local frame_index=$((i % ${#frame_chars[@]}))     # 현재 프레임 문자 인덱스를 계산
    local progress=$((i * bar_length / total_frames)) # 진행 상황을 터미널 너비로 변환
    local bar=""
    for ((j = 0; j < bar_length; j++)); do
      if ((j <= progress)); then
        bar+="${frame_chars[frame_index]}" # 진행된 부분에 해당하는 프레임 문자 추가
      else
        bar+=" " # 진행되지 않은 부분에는 공백 추가
      fi
    done
    printf "\r\033[32m%s\033[0m" "$bar" # 초록색으로 출력
    sleep 0.$interval                   # 다음 프레임까지 대기 (여기서는 0.1초)
  done

  printf "\n"
}

ext_art="

░█▀▀█ ░█▀▀▀█ ▄ ░█▀▀█ ▀█▀ ▀▀█▀▀ 　 ░█▀▄▀█ ░█─▄▀ ░█▀▀▄ ▀█▀ ░█▀▀█ 
░█▄▄▀ ░█──░█ ─ ░█▀▀▄ ░█─ ─░█── 　 ░█░█░█ ░█▀▄─ ░█─░█ ░█─ ░█▄▄▀ 
░█─░█ ░█▄▄▄█ ▀ ░█▄▄█ ▄█▄ ─░█── 　 ░█──░█ ░█─░█ ░█▄▄▀ ▄█▄ ░█─░█ 

░█▀▀▀█ ░█──░█ ░█▀▀▀ ░█▀▀▀ ▀▀█▀▀ ▀█▀ ░█▀▀▀ ░█▀▀█ ▀█▀ ░█▀▀▀ 
─▀▀▀▄▄ ░█░█░█ ░█▀▀▀ ░█▀▀▀ ─░█── ░█─ ░█▀▀▀ ░█▄▄█ ░█─ ░█▀▀▀ 
░█▄▄▄█ ░█▄▀▄█ ░█▄▄▄ ░█▄▄▄ ─░█── ▄█▄ ░█▄▄▄ ░█─── ▄█▄ ░█▄▄▄ 

░█▀▀█ ░█▀▀▀█ ░█▀▀▀█ 
░█▄▄▀ ░█──░█ ─▀▀▀▄▄ 
░█─░█ ░█▄▄▄█ ░█▄▄▄█

"

terminal_width=$(tput cols)                             # 현재 터미널의 너비(컬럼 수)를 가져옵니다.
padding_length=$(((terminal_width - ${#text_art}) / 2)) # 중앙 패딩
padding=$(printf "%*s" $padding_length "")

echo -e "\033[38;5;208m$padding$text_art\033[0m"           # 텍스트 아트 출력
custom_echo "GITHUB : github.com/mkdir-sweetiepie" "green" # 깃헙 주소 출력
custom_echo "RO:BIT 18th JiHyeon Hong" "green"             # 이름 출력
custom_echo "Install ROS2 Humble" "green"                  # Ros 설치 정보 출력

loading_animation

# Set Locale
locale  # check for UTF-8
sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
locale  # verify settings

# Install Dependencies
sudo apt update && sudo apt install gnupg wget
sudo apt install software-properties-common
sudo add-apt-repository universe

# Setup Source
wget -qO - https://isaac.download.nvidia.com/isaac-ros/repos.key | sudo apt-key add -
echo "deb https://isaac.download.nvidia.com/isaac-ros/ubuntu/main focal main" | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Install core ROS 2 Packages
sudo apt update && sudo apt install -y
sudo apt install ros-humble-desktop

