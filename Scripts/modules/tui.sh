#!/bin/bash
# Based on dialog package

cmd=(dialog --separate-output --checklist "What's the purpose of this machine? Use space to choose" 0 0 0)
options=(1 "Server" off    # any option can be set to default to "on"
         2 "Desktop" off)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
    case $choice in
        1)
            echo "Start installing for Server"
            ;;
        2)
            echo "Start installing for Desktop"
            ;;
    esac
done