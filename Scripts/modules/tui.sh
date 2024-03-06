#!/bin/bash

function tui_desktop() {
    # install softwares
    cmd=(dialog --separate-output --checklist "Choose the utilities that you want to install" 0 0 0)
    options=(1 "Daily Gnome Desktop" on    # any option can be set to default to "on"
            2 "MacOS theme" off
            3 "Chrome" off
            4 "VSCode" off
            5 "Golang" off
            6 "Docker" off
            7 "WineHQ" off)
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
                echo "Start installing Chrome"
                install_chrome
                ;;
            4)
                echo "Start installing VSCode"
                install_vscode
                ;;
            5)
                echo "Start installing Golang"
                install_go
                ;;
            6)
                echo "Start installing Docker"
                install_docker
                ;;
            7)
                echo "Start installing WineHQ"
                install_winehq
                ;;
        esac
    done

    # following section is for tweaks
    cmd=(dialog --separate-output --checklist "Feel free to choose tweaks that you like" 0 0 0)
    options=(1 "display git branch in terminal" on    # any option can be set to default to "on"
            2 "bind tab with auto-suggestion" on
            3 "set GRUB timeout to 0 sec" on)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    for choice in $choices
    do
        case $choice in
            1)
                echo "Now the git branch will be displayed in your terminal"
                display_git_branch
                ;;
            2)
                echo "Now you can use tab to auto-suggestion"
                bind_tab_like_zsh
                ;;
            3)
                echo "Now your GRUB timeout is set to 0 sec"
                set_grub_time_0
                ;;
        esac
    done

    # set alias
    cmd=(dialog --separate-output --checklist "Choose the alias you want" 0 0 0)
    options=(1 "ll='ls -alh'" on    # any option can be set to default to "on"
            2 "docker='podman'" on)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    for choice in $choices
    do
        case $choice in
            1)
                echo "Now your 'll' is equivalent to 'ls -alh'"
                alias_ll
                ;;
            2)
                echo "Now your 'docker' is equivalent to 'podman'"
                alias_docker_podman
                ;;
        esac
    done


    # reboot
    choice=$(dialog --stdout --title "If you want to Reboot right now?" --yesno "Desktop Environment need reboot to setup" 0 0 && echo "1" || echo "2");clear
    choice="${choice:-2}"
    if [ $choice == "1" ]; then
        reboot
    fi
}

function tui_server_lab() {
    cmd=(dialog --separate-output --checklist "What's the purpose of this machine? Use space to choose" 0 0 0)
    options=(1 "Essential Server tools" on    # any option can be set to default to "on"
            2 "Docker" off)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    for choice in $choices
    do
        case $choice in
            1)
                echo "Start installing Essential Server tools"
                tailor_server
                ;;
            2)
                echo "Start installing Docker"
                install_docker
                ;;
        esac
    done
}