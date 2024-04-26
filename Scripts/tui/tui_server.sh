#!/bin/bash

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