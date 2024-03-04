#!/bin/bash

source ./modules/set.sh
source ./modules/changeMirror.sh
source ./modules/install.sh

Tsinghua="https://mirrors.tuna.tsinghua.edu.cn/debian"
Aliyun="https://mirrors.aliyun.com/debian"
USTC="https://mirrors.ustc.edu.cn/debian"
CQU="https://mirrors.cqu.edu.cn/debian"

# main
set_bashrc
set_dir_structure
changeMirror $CQU "Debian12"

sudo apt install dialog -y

choice=$(dialog --menu "my menu" 0 0 0 1 "Desktop" 2 "Server Lab for VMs" 3>&1 1>&2 2>&3 3>&-); clear
if [ $choice == "1" ]; then
    read -p "If you want to set GRUB timeout to 0s right now? (N/y): " choice
    choice="${choice:-N}"
    if [ $choice == "y" ]; then
        set_grub_time_0
    fi

    # tailor is used for debloating gnome-core and installing some powerful tools
    # based on gnome-core
    read -p "If you want tailor right now? (N/y): " choice
    choice="${choice:-N}"
    if [ $choice == "y" ]; then
        tailor_desktop
    fi

    read -p "If you want to install docker right now? (N/y): " choice
    choice="${choice:-N}"
    if [ $choice == "y" ]; then
        install_docker
    fi

    read -p "If you want to install Go right now? (N/y): " choice
    choice="${choice:-N}"
    if [ $choice == "y" ]; then
        install_go
    fi

    read -p "If you want to install wineHQ right now? (N/y): " choice
    choice="${choice:-N}"
    if [ $choice == "y" ]; then
        install_winehq
    fi

    read -p "If you want to install macOS theme right now? (N/y): " choice
    choice="${choice:-N}"
    if [ $choice == "y" ]; then
        install_macOS_theme
    fi

    read -p "If you want to reboot right now? (N/y): " choice
    choice="${choice:-N}"
    if [ $choice == "y" ]; then
        reboot
    fi
else # for server
    read -p "If you want to set GRUB timeout to 0s right now? (N/y): " choice
    choice="${choice:-N}"
    if [ $choice == "y" ]; then
        set_grub_time_0
    fi

    # tailor_server is used to install essential tools e.g. openssh-server...
    read -p "If you want to tailor right now? (N/y): " choice
    choice="${choice:-N}"
    if [ $choice == "y" ]; then
        tailor_server
    fi

    read -p "If you want to install docker right now? (N/y): " choice
    choice="${choice:-N}"
    if [ $choice == "y" ]; then
        install_docker
    fi

    read -p "If you want to reboot right now? (N/y): " choice
    choice="${choice:-N}"
    if [ $choice == "y" ]; then
        reboot
    fi
fi