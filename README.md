# OpenCV Auto Installer

<div align="center">
░█████╗░██████╗░███████╗███╗░░██╗░█████╗░██╗░░░██╗
██╔══██╗██╔══██╗██╔════╝████╗░██║██╔══██╗██║░░░██║
██║░░██║██████╔╝█████╗░░██╔██╗██║██║░░╚═╝╚██╗░██╔╝
██║░░██║██╔═══╝░██╔══╝░░██║╚████║██║░░██╗░╚████╔╝░
╚█████╔╝██║░░░░░███████╗██║░╚███║╚█████╔╝░░╚██╔╝░░
░╚════╝░╚═╝░░░░░╚══════╝╚═╝░░╚══╝░╚════╝░░░░╚═╝░░░
</div>

## This shell file installs OpenCV, version you desire.

### - For ROS users, some packages might be deleted after the installation. Can be restored while the installation.

### - Some OpenCV versions may not be installed with this script. This is NOT a official installer!

# Test Environments

### - Ubuntu 18.04

### - Ubuntu 20.04

### - Ubuntu 22.04

###

# How to use

```shell
sudo apt-get install git
cd
git clone https://github.com/mjlee111/OpenCV_auto_installer.git
cd OpenCV_auto_installer
sudo chmod +x opencv_installer.sh
./opencv_installer.sh
```

## After running the command above ...

![Screenshot from 2023-06-09 08-34-51](https://github.com/mjlee111/OpenCV_auto_installer/assets/66550892/c08b064f-b92e-4cb8-9400-eb738b9591a9)

### If there is a opencv or opencv4 already installed, the shell will ask wether to continue or stop.

### Press ENTER to continue or any other key to stop.

##

###

###

![Screenshot from 2023-06-09 05-16-36](https://github.com/mjlee111/OpenCV_auto_installer/assets/66550892/1c1be558-2509-4005-bd9a-470a08d89088)

### If there is no opencv or opencv4 installed, the shell will ask what version you will install.
