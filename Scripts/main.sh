#!/bin/bash

source ./modules/setBashrc.sh
source ./modules/setDir.sh
source ./modules/setGRUB.sh
source ./modules/changeMirror.sh
# tailor is used for debloating gnome-core and installing some powerful tools
# based on gnome-core
source ./modules/install.sh

Tsinghua="https://mirrors.tuna.tsinghua.edu.cn/debian"
Aliyun="https://mirrors.aliyun.com/debian"
USTC="https://mirrors.ustc.edu.cn/debian"

# main
# setBashrc
# setDir
# changeMirror $Tsinghua "Debian12"
# tailor
read -p "If you want to set GRUB timeout to 0s right now? (N/y): " choice
# choice="${choice:-N}"
if [ $choice == "y" ]; then
    set_grub_time_0
fi

read -p "If you want tailor right now? (N/y): " choice
# choice="${choice:-N}"
if [ $choice == "y" ]; then
    tailor
fi

read -p "If you want to install docker right now? (N/y): " choice
# choice="${choice:-N}"
if [ $choice == "y" ]; then
    install_docker
fi

read -p "If you want to install wineHQ right now? (N/y): " choice
# choice="${choice:-N}"
if [ $choice == "y" ]; then
    install_winehq
fi

read -p "If you want to reboot right now? (N/y): " choice
# choice="${choice:-N}"
if [ $choice == "y" ]; then
    reboot
fi