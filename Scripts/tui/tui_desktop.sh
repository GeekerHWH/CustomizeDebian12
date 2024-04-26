#!/bin/bash

function tui_desktop() {
    while true; do
        choice=$(dialog --menu "What kind of software you want" 0 0 0 1 "Desktop Theme" 2 "Daily Software" 3 "Development Tools" 3>&1 1>&2 2>&3)
        clear

        case $choice in
        1)
            tui_desktop_theme
            ;;
        2)
            tui_desktop_dailysoftware
            ;;
        3)
            tui_desktop_development
            ;;
        *)
            clear
            break
            ;;
        esac
    done

    tui_desktop_tweaks

    # set alias
    cmd=(dialog --separate-output --checklist "Choose the alias you want" 0 0 0)
    options=(1 "ll='ls -alh'" on # any option can be set to default to "on"
        2 "docker='podman'" on)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    for choice in $choices; do
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
    choice=$(dialog --stdout --title "If you want to Reboot right now?" --yesno "Desktop Environment need reboot to setup" 0 0 && echo "1" || echo "2")
    clear
    choice="${choice:-2}"
    if [ $choice == "1" ]; then
        sudo reboot
    fi
}

# install theme for desktop
function tui_desktop_theme() {
    choice=$(dialog --title "Customize Debian 12" \
        --menu "Which theme do you prefer? press Enter to confirm" 0 0 0 \
        1 "Original Gnome" 2 "MacOS Theme" 3>&1 1>&2 2>&3 3>&-)
    clear
    if [ $choice == "1" ]; then
        install_gnome_core
    else # MacOS theme
        install_gnome_core
        install_macOS_theme
    fi
}

# daily software
function tui_desktop_dailysoftware() {
    cmd=(dialog --separate-output --checklist "Choose the utilities that you want, use SPACE to choose, ENTER to confirm" 0 0 0)
    options=(1 "Chrome" off
        2 "qBittorrent" off
        3 "WineHQ" off
        4 "GIMP" off
        5 "DarkTable" off
        6 "VLC" off)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    for choice in $choices; do
        case $choice in
        1)
            echo "Start installing Chrome"
            install_chrome
            ;;
        2)
            sudo apt install qbittorrent -y
            ;;
        3)
            echo "Start installing WineHQ"
            install_winehq
            ;;
        4)
            sudo apt install gimp -y
            ;;
        5)
            install_darktable
            ;;
        6)
            sudo apt install vlc -y
            ;;
        esac
    done
}

# case 3
function tui_desktop_development() {
    cmd=(dialog --separate-output --checklist "Choose the Development Tools that you want to install" 0 0 0)
    options=(1 "Vim" on
        2 "Tmux" off
        3 "VSCode" off
        4 "Git" off
        5 "Docker" off
        6 "Go" off)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    for choice in $choices; do
        case $choice in
        1)
            echo "Start installing Vim editor"
            sudo apt install vim -y
            ;;
        2)
            sudo apt install tmux -y
            ;;
        3)
            echo "Start installing VSCode"
            install_vscode
            ;;
        4)
            echo "Start installing Git"
            sudo apt install git -y
            ;;
        5)
            echo "Start installing Docker"
            install_docker
            ;;
        6)
            echo "Start installing Go"
            install_go
            ;;
        esac
    done
}

function tui_desktop_tweaks() {
    # following section is for tweaks
    cmd=(dialog --separate-output --checklist "Feel free to choose tweaks that you like" 0 0 0)
    options=(1 "display git branch in terminal" on # any option can be set to default to "on"
        2 "bind tab with auto-suggestion" on
        3 "set GRUB timeout to 0 sec" on)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    for choice in $choices; do
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
}
