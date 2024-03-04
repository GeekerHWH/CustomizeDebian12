#!/bin/bash
# choice=$(dialog --menu "my menu" 0 0 0 1 "Desktop" 2 "Server Lab for VMs" 3>&1 1>&2 2>&3 3>&-); clear
cmd=(dialog --separate-output --checklist "What's the purpose of this machine? Use space to choose" 0 0 0)
    options=(1 "Daily Gnome Desktop" on    # any option can be set to default to "on"
            2 "MacOS theme" off
            3 "Golang" off
            4 "Docker" off
            5 "WineHQ" off)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    for choice in $choices
    do
        case $choice in
            1)
                echo "Start installing Gnome Desktop Environment"
                tailor_desktop
                ;;
            2)
                echo "Start installing MacOS theme"
                install_macOS_theme
                ;;
            3)
                echo "Start installing Golang"
                install_go
                ;;
            4)
                echo "Start installing Docker"
                install_docker
                ;;
            5)
                echo "Start installing WineHQ"
                install_winehq
                ;;
        esac
    done