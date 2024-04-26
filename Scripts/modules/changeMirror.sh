#!/bin/bash

# only for debian12
function changeMirror(){
    local url=$1
    local os=$2

    if [ $os = "Debian12" ]
    then
        sources_list="/etc/apt/sources.list"
        backup_file="$sources_list.bak"
        sudo cp "$sources_list" "$backup_file"

        sudo echo "# By default, source mirrors are commented out to improve apt update speed. Uncomment if needed.
deb $url/ bookworm main contrib non-free non-free-firmware
# deb-src $url/ bookworm main contrib non-free non-free-firmware

deb $url/ bookworm-updates main contrib non-free non-free-firmware
# deb-src $url/ bookworm-updates main contrib non-free non-free-firmware

deb $url/ bookworm-backports main contrib non-free non-free-firmware
# deb-src $url/ bookworm-backports main contrib non-free non-free-firmware

deb $url-security bookworm-security main contrib non-free non-free-firmware
# deb-src $url bookworm-security main contrib non-free non-free-firmware" > "$sources_list"
        sudo apt update -y

    else
        echo "This changeMirror script is only for Debian12"
        exit 1
    fi
}

