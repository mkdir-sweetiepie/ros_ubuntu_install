#! /bin/bash
# Install ROS2 Humble

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

text_art="

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

source /etc/os-release # 현재 Ubuntu 버전을 가져옵니다.
ubuntu=$VERSION_ID
cv="Current Version Of Ubuntu Is : ${ubuntu}" # 현재 Ubuntu 버전을 출력합니다.
custom_echo "${cv}" "green"

case $ubuntu in
"20.04")
  # Ubuntu 20.04에서는 ROS Humble을 설치할 수 있습니다.
  custom_echo "ROS Humble available!" "green"
  custom_echo "### ROS Humble is an upcoming release of the Robot Operating System (ROS). ###" "yellow"
  custom_echo "### It is being developed for Ubuntu 20.04 and aims to further expand the capabilities of ROS for robotics applications. ###" "yellow"

  read -n 1 -p "Press Enter to start ROS installation, or any other key to exit..."

  if [[ $REPLY == "" ]]; then
    echo "[Check UTF-8]"
    locale # check for UTF-8

    sudo apt update && sudo apt install locales
    sudo locale-gen en_US en_US.UTF-8
    sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
    export LANG=en_US.UTF-8

    locale # verify settings

    custom_echo "Installing ROS Humble" "green"
    loading_animation

    # Install
    custom_echo "updating package lists" "green"
    sudo apt-get update && sudo apt upgrade -y

    custom_echo "install software-properties-common" "green"
    sudo apt-get install -y software-properties-common
    custom_echo "add-apt-repository universe" "green"
    sudo add-apt-repository -y universe
    custom_echo "install curl gnupg2 lsb-release build-essential" "green"
    sudo apt-get install -y curl gnupg2 lsb-release build-essential # 패키지 목록 업데이트 및 추가 패키지 설치
    sudo apt update

    custom_echo "echo ros resources" "green"
    sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg # ROS 키를 추가
    custom_echo "adding key" "green"
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list >/dev/null
    custom_echo "updating" "green"
    sudo apt update # 패키지 목록 업데이트
    custom_echo "installing ROS-humble-desktop-full" "green"
    sudo apt install -y ros-humble-desktop-full # ROS Humble 설치

    # ROS 설정을 ~/.bashrc에 추가하고 적용합니다.
    custom_echo "setting bashrc" "green"
    echo "source /opt/ros/humble/setup.bash" >>~/.bashrc
    source ~/.bashrc

    sudo apt update && sudo apt install -y \
      python3-flake8-docstrings \
      python3-pip \
      python3-pytest-cov \
      ros-dev-tools

    python3 -m pip install -U \
      flake8-blind-except \
      flake8-builtins \
      flake8-class-newline \
      flake8-comprehensions \
      flake8-deprecated \
      flake8-import-order \
      flake8-quotes \
      "pytest>=5.3" \
      pytest-repeat \
      pytest-rerunfailures

    end_msg="ROS ${ros_version} Installed!"
    custom_echo "${end_msg}" "green"
  else
    custom_echo "Installation Canceled" "red"
  fi
  ;;
"22.04")
  custom_echo "ROS Humble available!" "green"
  custom_echo "### ROS Humble is an upcoming release of the Robot Operating System (ROS). ###" "yellow"
  custom_echo "### It is being developed for Ubuntu 22.04 and aims to further expand the capabilities of ROS for robotics applications. ###" "yellow"

  read -n 1 -p "Press Enter to start ROS Humble installation, or any other key to exit..."

  if [[ $REPLY == "" ]]; then
    echo "[Check UTF-8]"
    locale # check for UTF-8

    sudo apt update && sudo apt install locales
    sudo locale-gen en_US en_US.UTF-8
    sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
    export LANG=en_US.UTF-8

    locale # verify settings

    custom_echo "Installing ROS Humble" "green"
    loading_animation

    # Install
    custom_echo "updating package lists" "green"
    sudo apt-get update && sudo apt upgrade -y

    custom_echo "install software-properties-common" "green"
    udo apt-get install -y software-properties-common
    custom_echo "add-apt-repository universe" "green"
    sudo add-apt-repository -y universe
    custom_echo "install curl gnupg2 lsb-release build-essential" "green"
    sudo apt-get install -y curl gnupg2 lsb-release build-essential # 패키지 목록 업데이트 및 추가 패키지 설치
    sudo apt update

    custom_echo "echo ros resources" "green"
    sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg # ROS 키를 추가
    custom_echo "adding key" "green"
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list "updating" "green" >/dev/nullcustom_echo
    sudo apt update # 패키지 목록 업데이트
    custom_echo "installing ROS-humble-desktop-full" "green"
    sudo apt install -y ros-humble-desktop-full # ROS Humble 설치

    # ROS 설정을 ~/.bashrc에 추가하고 적용합니다.
    custom_echo "setting bashrc" "green"
    echo "source /opt/ros/humble/setup.bash" >>~/.bashrc
    source ~/.bashrc

    sudo apt update && sudo apt install -y \
      python3-flake8-docstrings \
      python3-pip \
      python3-pytest-cov \
      ros-dev-tools

    sudo apt install -y \
      python3-flake8-blind-except \
      python3-flake8-builtins \
      python3-flake8-class-newline \
      python3-flake8-comprehensions \
      python3-flake8-deprecated \
      python3-flake8-import-order \
      python3-flake8-quotes \
      python3-pytest-repeat \
      python3-pytest-rerunfailures

    end_msg="ROS ${ros_version} Installed!"
    custom_echo "${end_msg}" "green"
  else
    custom_echo "Installation Canceled" "red"
  fi
  ;;
*)
  custom_echo "ROS version not available or out of distribution for this Ubuntu version. You might need to upgrade Ubuntu." "red"
  exit 1
  ;;
esac
