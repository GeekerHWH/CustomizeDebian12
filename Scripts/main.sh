#!/bin/bash

source ./modules/set.sh
source ./modules/changeMirror.sh
source ./modules/install.sh
source ./modules/tui.sh

Tsinghua="https://mirrors.tuna.tsinghua.edu.cn/debian"
Aliyun="https://mirrors.aliyun.com/debian"
USTC="https://mirrors.ustc.edu.cn/debian"
CQU="https://mirrors.cqu.edu.cn/debian"

# main
# set_bashrc
# set_dir_structure
# changeMirror $CQU "Debian12"

# sudo apt install dialog -y

choice=$(dialog --title "Customize Debian 12" --menu "What's the purpose of this machine? press Enter to confirm" 0 0 0 1 "Desktop" 2 "Server Lab for VMs" 3>&1 1>&2 2>&3 3>&-); clear
if [ $choice == "1" ];then
    read -p "If you want to set GRUB timeout to 0s right now? (N/y): " choice
    choice="${choice:-N}"
    if [ $choice == "y" ]; then
        set_grub_time_0
    fi

    tui_desktop

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

    tui_server_lab

    read -p "If you want to reboot right now? (N/y): " choice
    choice="${choice:-N}"
    if [ $choice == "y" ]; then
        reboot
    fi
fi