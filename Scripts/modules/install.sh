#!/bin/bash

function tailor_gnome() {
    sudo apt update && sudo apt upgrade -y
    # install essential tools
    sudo apt install net-tools vim curl wget ftp -y
    # install xorg and gnome-core
    sudo apt install xorg gnome-core -y

    sudo apt purge firefox-esr gnome-logs gnome-characters gnome-contacts gnome-text-editor gnome-font-viewer gnome-accessibility-themes yelp totem eog evince -y
    sudo apt autoremove -y

    # install gnome-extensions
    sudo apt install font-manager gnome-tweaks gnome-shell-extension-manager -y

    # install FOSS
    # sudo apt install vlc qbittorrent telegram-desktop -y

    # install my favorite apps
    # sudo apt install code google-chrome-stable balena-etcher linuxqq -y

    # install fonts
    # sudo apt install ttf-mscorefonts-installer -y
}

# To Do: not used
function tailor_server() {
    sudo apt update && sudo apt upgrade -y
    # install essential tools
    sudo apt install net-tools curl wget openssh-server vim -y
}

function install_vscode() {
    sudo apt-get install wget gpg -y
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg

    sudo apt update -y
    sudo apt install code -y
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

    sudo groupadd docker
    sudo usermod -aG docker $SUDO_USER
}

function install_winehq() {
    sudo dpkg --add-architecture i386 
    sudo mkdir -pm755 /etc/apt/keyrings
    sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
    sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources
    sudo apt update
    sudo apt install --install-recommends winehq-stable -y
}

function install_macOS_theme() {
    git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
    chmod -R +x WhiteSur-gtk-theme
    WhiteSur-gtk-theme/install.sh -l -N mojave
    sudo WhiteSur-gtk-theme/tweaks.sh -g

    git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git --depth=1
    chmod +x WhiteSur-icon-theme/install.sh
    WhiteSur-icon-theme/install.sh

    git clone https://github.com/vinceliuice/WhiteSur-wallpapers.git --depth=1
    chmod +x WhiteSur-wallpapers/install-wallpapers.sh
    WhiteSur-wallpapers/install-wallpapers.sh -t whitesur -c light
}

# To Do: not used
function install_nvidia_driver() {
    sudo apt install nvidia-driver -y
}

function install_chrome() {
    curl -sSLO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install ./google-chrome-stable_current_amd64.deb -y
    rm google-chrome-stable_current_amd64.deb
}

# need to keep pace with official updates
function install_go() {
    curl -sSLO https://go.dev/dl/go1.22.0.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz

    # add local environment variable
    original_user_home=$(eval echo ~$SUDO_USER)
    echo "export PATH=$PATH:/usr/local/go/bin" >> $original_user_home/.bashrc
}

# need to keep pace with official updates
function install_protobuf() {
    sudo apt install -y protobuf-compiler
    go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2

    # add local environment variable
    original_user_home=$(eval echo ~$SUDO_USER)
    echo "export PATH="$PATH:$(go env GOPATH)/bin"" >> $original_user_home/.bashrc
}

# need to keep pace with official updates
function install_nekoray() {
    nekoray_version=3.26-2023-12-09
    curl -sSLO https://github.com/MatsuriDayo/nekoray/releases/latest/download/nekoray-$nekoray_version-debian-x64.deb
    sudo apt install ./nekoray-$nekoray_version-debian-x64.deb -y
    rm nekoray-$nekoray_version-debian-x64.deb
}

function install_darktable() {
    echo 'deb http://download.opensuse.org/repositories/graphics:/darktable/Debian_12/ /' | sudo tee /etc/apt/sources.list.d/graphics:darktable.list
    curl -fsSL https://download.opensuse.org/repositories/graphics:darktable/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/graphics_darktable.gpg > /dev/null
    sudo apt update -y
    sudo apt install darktable -y
}
