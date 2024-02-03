#!/bin/bash

function custom_echo() {
  text=$1
  color=$2

  case $color in
    "green")
      echo -e "\033[32m[RO:BIT] $text\033[0m"
      ;;
    "red")
      echo -e "\033[31m[RO:BIT] $text\033[0m"
      ;;
    *)
      echo "$text"
      ;;
  esac
}

loading_animation() {
  local interval=1
  local duration=30
  local bar_length=$(tput cols)  # Get terminal window width
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
    printf "\r\033[32m%s\033[0m" "$bar"  # Print in green color
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
custom_echo "CV_bridge cleaner" "green"

loading_animation

cd 

custom_echo "Checking OpenCV version" "green"
if pkg-config --exists opencv; then
  opencv_version=$(pkg-config --modversion opencv)
  custom_echo "OpenCV installed!!! current OpenCV version : $opencv_version" "red"
else
  custom_echo "OpenCV is not installed." "red"
fi

custom_echo "Checking OpenCV4 version" "green"
if pkg-config --exists opencv4; then
  opencv4_version=$(pkg-config --modversion opencv4)
  custom_echo "OpenCV4 installed!!! current OpenCV version : $opencv4_version" "red"
else
  custom_echo "OpenCV4 is not installed." "red"
fi


echo ""
echo ""
echo ""

custom_echo "Cleaning CV bridge config file for ros usage" "green"
loading_animation

file_path="/opt/ros/noetic/share/cv_bridge/cmake/cv_bridgeConfig.cmake"

line_number_to_delete=96

new_content='  set(_include_dirs "/usr/local/include/opencv4;")'
sed -i "${line_number_to_delete}d" "$file_path"
sed -i "${line_number_to_delete}i$new_content" "$file_path"

line_number_to_delete=119

new_content="set(libraries \"cv_bridge;/usr/local/lib/libopencv_core.so.$opencv4_version;/usr/local/lib/libopencv_imgproc.so.$opencv4_version;/usr/local/lib/libopencv_imgcodecs.so.$opencv4_version\")"
sed -i "${line_number_to_delete}d" "$file_path"
sed -i "${line_number_to_delete}i$new_content" "$file_path"


sudo ln -s /usr/include/opencv4 /usr/include/opencv
sudo ln -s /usr/local/include/opencv4 /usr/local/include/opencv
sudo ln -s /usr/include/opencv4 /usr/include/opencv2
sudo ln -s /usr/local/include/opencv4 /usr/local/include/opencv2
sudo ln -s /usr/include/opencv4 /usr/include/opencv4/opencv2
sudo ln -s /usr/local/include/opencv4 /usr/local/include/opencv4/opencv2
sudo ldconfig

custom_echo "Complete !" "green"


