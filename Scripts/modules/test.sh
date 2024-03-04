sudo apt install dialog -y
choice=$(dialog --menu "my menu" 0 0 0 1 "Desktop" 2 "Server Lab for VMs" 3>&1 1>&2 2>&3 3>&-); clear
choice="${choice:-1}"
if [ $choice == "1" ]; then
    read -p "If you want to set GRUB timeout to 0s right now? (N/y): " choice
    choice="${choice:-N}"
    if [ $choice == "y" ]; then
        set_grub_time_0
    fi
fi