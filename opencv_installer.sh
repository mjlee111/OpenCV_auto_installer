function custom_echo() {
  text=$1
  color=$2

  case $color in
    "green")
      echo -e "\033[32m[RO:BIT] $text\033[0m"
      ;;
    "green")
      echo -e "\033[31m [RO:BIT] $text\033[0m"
      ;;
    *)
      echo "$text"
      ;;
  esac
}

loading_animation() {
  local interval=1
  local duration=30
  local bar_length=$(tput cols)  # 터미널 창의 너비를 가져옴
  local total_frames=$((duration * interval))
  local frame_chars=("█" "▉" "▊" "▋" "▌" "▍" "▎" "▏")

  for ((i = 0; i <= total_frames; i++)); do
    local frame_index=$((i % ${#frame_chars[@]}))
    local progress=$((i * bar_length / total_frames))
    local bar=""
    for ((j = 0; j < bar_length; j++)); do
      if ((j <= progress)); then
        bar+="${frame_chars[frame_index]}"
      else
        bar+=" "
      fi
    done
    printf "\r\033[32m%s\033[0m" "$bar"  # 초록색으로 출력
    sleep 0.$interval
  done

  printf "\n"
}

text_art="

██████╗░░█████╗░██╗██████╗░██╗████████╗  ███╗░░░███╗░░░░░██╗  ██╗░░░░░███████╗███████╗
██╔══██╗██╔══██╗╚═╝██╔══██╗██║╚══██╔══╝  ████╗░████║░░░░░██║  ██║░░░░░██╔════╝██╔════╝
██████╔╝██║░░██║░░░██████╦╝██║░░░██║░░░  ██╔████╔██║░░░░░██║  ██║░░░░░█████╗░░█████╗░░
██╔══██╗██║░░██║░░░██╔══██╗██║░░░██║░░░  ██║╚██╔╝██║██╗░░██║  ██║░░░░░██╔══╝░░██╔══╝░░
██║░░██║╚█████╔╝██╗██████╦╝██║░░░██║░░░  ██║░╚═╝░██║╚█████╔╝  ███████╗███████╗███████╗
╚═╝░░╚═╝░╚════╝░╚═╝╚═════╝░╚═╝░░░╚═╝░░░  ╚═╝░░░░░╚═╝░╚════╝░  ╚══════╝╚══════╝╚══════╝

░█████╗░██████╗░███████╗███╗░░██╗░█████╗░██╗░░░██╗
██╔══██╗██╔══██╗██╔════╝████╗░██║██╔══██╗██║░░░██║
██║░░██║██████╔╝█████╗░░██╔██╗██║██║░░╚═╝╚██╗░██╔╝
██║░░██║██╔═══╝░██╔══╝░░██║╚████║██║░░██╗░╚████╔╝░
╚█████╔╝██║░░░░░███████╗██║░╚███║╚█████╔╝░░╚██╔╝░░
░╚════╝░╚═╝░░░░░╚══════╝╚═╝░░╚══╝░╚════╝░░░░╚═╝░░░
"

terminal_width=$(tput cols)
padding_length=$(( (terminal_width - ${#text_art}) / 2 ))
padding=$(printf "%*s" $padding_length "")

echo -e "\033[38;5;208m$padding$text_art\033[0m"


custom_echo "RO:BIT 17th Myeungjin Lee" "green"
custom_echo "OpenCV Auto Installer" "green"

loading_animation

cd 

custom_echo "Checking if OpneCV is already installed" "green"
if pkg-config --exists opencv; then
  opencv_version=$(pkg-config --modversion opencv)
  custom_echo "OpenCV already installed!!! current OpenCV version : "$opencv_version"" "green"
  custom_echo "Delete current version? If not, installation ends" "green"
  read -p "Press Enter to delete the current version and proceed, or any other key to exit: " choice

  if [ "$choice" == "" ]; then
    echo "Deleting the current version of OpenCV..."
    sudo apt-get purge -y opencv*
    sudo apt-get purge -y libopencv*
    sudo apt-get autoremove -y
    sudo find /usr/local/ -name "*opencv*" -exec rm -rf {} \;
    echo "Current version of OpenCV has been deleted."
  else
    echo "Installation stopped. Current version of OpenCV was not deleted."
    exit
  fi
else
  echo "OpenCV is not installed"
fi

custom_echo "Checking if OpneCV4 is already installed" "green"
if pkg-config --exists opencv4; then
  opencv_version=$(pkg-config --modversion opencv4)
  custom_echo "OpenCV4 already installed!!! current OpenCV2 version : "$opencv_version"" "green"
  custom_echo "Delete current version? If not, installation ends" "green"
  read -p "Press Enter to delete the current version and proceed, or any other key to exit: " choice

  if [ "$choice" == "" ]; then
    echo "Deleting the current version of OpenCV..."
    sudo apt-get purge -y opencv*
    sudo apt-get purge -y libopencv*
    sudo apt-get autoremove -y
    sudo find /usr/local/ -name "*opencv*" -exec rm -rf {} \;
    echo "Current version of OpenCV has been deleted."
  else
    echo "Installation stopped. Current version of OpenCV was not deleted."
    exit
  fi
else
  echo "OpenCV4 is not installed"
fi

custom_echo "Installing requirements" "green"
loading_animation
sudo apt update -y
sudo apt upgrade -y
sudo apt-get install -y build-essential cmake
sudo apt-get install -y pkg-config
sudo apt-get install -y libjpeg-dev libtiff5-dev libpng-dev
sudo apt-get install -y ffmpeg libavcodec-dev libavformat-dev libswscale-dev libxvidcore-dev libx264-dev libxine2-dev
sudo apt-get -y install libv4l-dev v4l-utils
sudo apt-get -y install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
sudo apt-get -y install libqt4-dev
sudo apt-get -y install mesa-utils libgl1-mesa-dri libgtkgl2.0-dev libgtkglext1-dev
sudo apt-get -y install libatlas-base-dev gfortran libeigen3-dev


mkdir opencv && cd opencv

loading_animation
custom_echo "Enter your target OpenCV version" "green"
read cvversion

custom_echo "${cvversion}" "green"
custom_echo "checking if version is available ..." "green"
loading_animation
download_url="https://github.com/opencv/opencv/archive/${cvversion}.zip"
wget -O opencv.zip "$download_url" || { custom_echo "This version is unavailable" "green" ; cd && rm -rf opencv; exit 1; }
download_url_contrib="https://github.com/opencv/opencv_contrib/archive/${cvversion}.zip"
wget -O opencv_contrib.zip "$download_url_contrib" || { custom_echo "This version is unavailable" "green" ; cd && sudo rm -rf opencv; exit 1; }

unzip opencv.zip
unzip opencv_contrib.zip

dest_dirs="opencv-${cvversion}"
cd "$dest_dirs"
mkdir build && cd build

custom_echo "VERSION AVAILABLE" "green"
custom_echo "Downloaded required files" "green"
custom_echo "now building ... "

cmake_command="cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=OFF -D WITH_IPP=OFF -D WITH_1394=OFF -D BUILD_WITH_DEBUG_INFO=OFF -D BUILD_DOCS=OFF -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=OFF -D BUILD_PACKAGE=OFF -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D WITH_QT=OFF -D WITH_GTK=ON -D WITH_OPENGL=ON -D BUILD_opencv_python3=ON -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-4.5.2/modules -D WITH_V4L=ON -D WITH_FFMPEG=ON -D WITH_XINE=ON -D OPENCV_ENABLE_NONFREE=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D OPENCV_SKIP_PYTHON_LOADER=ON -D OPENCV_GENERATE_PKGCONFIG=ON ../"

custom_echo "Running cmake command..." "green"
$cmake_command || { custom_echo "BUILD FAILED !!!! MANUAL INSTALL REQUIRED !!!!" "green"; exit 1; }

custom_echo "Running make command..." "green"
time make -j $(nproc) || { custom_echo "BUILD FAILED !!!! MANUAL INSTALL REQUIRED !!!!" "green"; exit 1; }

sudo make install

if ! grep -q '/usr/local/lib' /etc/ld.so.conf.d/*; then
  sudo sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'
fi
sudo ldconfig
custom_echo "BUILD COMPLETE" "green"
loading_animation

echo " "
echo " "
echo " "

cd
sudo rm -rf OpenCV_auto_installer
first_digit=$(echo "$cvversion" | cut -d. -f1)

if [ "$first_digit" = "4" ]; then
  pkg-config --modversion opencv4
else
  pkg-config --modversion opencv
fi

custom_echo "OpenCV Installation COMPLETE" "green"

