#!/bin/bash

function tailor() {
    sudo apt update && sudo apt upgrade -y
    # install essential tools
    sudo apt install net-tools vim curl -y
    # install xorg and gnome-core
    sudo apt install xorg gnome-core -y

    sudo apt purge firefox-esr gnome-logs gnome-characters gnome-contacts gnome-text-editor gnome-font-viewer gnome-accessibility-themes yelp totem eog evince -y
    sudo apt autoremove -y

    # install gnome-extensions
    sudo apt install gnome-tweaks gnome-shell-extension-manager -y
    # install FOSS
    sudo apt install vlc qbittorrent telegram-desktop -y

    # install my favorite apps
    # sudo apt install code google-chrome-stable balena-etcher linuxqq -y

    # install fonts
    # sudo apt install ttf-mscorefonts-installer -y
}

function install_docker() {
    # Remove old versions:
    for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    # Install Docker latest version:
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
}

function install_winehq() {
    sudo dpkg --add-architecture i386 
    sudo mkdir -pm755 /etc/apt/keyrings
    sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
    sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources
    sudo apt update
    sudo apt install --install-recommends winehq-stable -y
}