#!/bin/bash

# only for debian12
function changeMirror() {
    local url=$1
    local os=$2

    if [ $os = "Debian12" ]; then
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
# deb-src $url bookworm-security main contrib non-free non-free-firmware" >"$sources_list"
        sudo apt update -y

    else
        echo "This changeMirror script is only for Debian12"
        exit 1
    fi
}

#!/bin/bash

function tailor_gnome() {
    sudo apt update && sudo apt upgrade -y
    # install essential tools
    sudo apt install net-tools vim curl wget ftp -y
    # install xorg and gnome-core
    sudo apt install xorg gnome-core -y

    sudo apt purge firefox-esr gnome-logs gnome-characters gnome-contacts gnome-text-editor gnome-font-viewer gnome-accessibility-themes yelp totem evince -y
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

function tailor_server() {
    sudo apt update && sudo apt upgrade -y
    # install essential tools
    sudo apt install net-tools curl wget openssh-server vim -y
}

function install_vscode() {
    sudo apt-get install wget gpg -y
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
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
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
        sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
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

function install_nvidia_driver() {
    sudo apt install nvidia-driver -y
}

function install_chrome() {
    curl -sSLO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install ./google-chrome-stable_current_amd64.deb -y
    rm google-chrome-stable_current_amd64.deb
}

function install_go() {
    curl -sSLO https://go.dev/dl/go1.22.0.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz

    # add local environment variable
    original_user_home=$(eval echo ~$SUDO_USER)
    echo "export PATH=$PATH:/usr/local/go/bin" >>$original_user_home/.bashrc
}

# need to keep pace with official updates
function install_protobuf() {
    sudo apt install -y protobuf-compiler
    go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2

    # add local environment variable
    original_user_home=$(eval echo ~$SUDO_USER)
    echo "export PATH="$PATH:$(go env GOPATH)/bin"" >>$original_user_home/.bashrc
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
    curl -fsSL https://download.opensuse.org/repositories/graphics:darktable/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/graphics_darktable.gpg >/dev/null
    sudo apt update -y
    sudo apt install darktable -y
}
#!/bin/bash

function set_grub_time_0() {
    # change grub timeout to 0 sec
    sudo sed -i 's/GRUB_TIMEOUT=[0-9]\+/GRUB_TIMEOUT=0/' /etc/default/grub
    update-grub
}

function display_git_branch() {
    # get the home path
    original_user_home=$(eval echo ~$SUDO_USER)

    cat <<'EOF' >>$original_user_home/.bashrc

function git_branch {
   branch="`git branch 2>/dev/null | grep "^\*" | sed -e "s/^\*\ //"`"
   if [ "${branch}" != "" ];then
       if [ "${branch}" = "(no branch)" ];then
           branch="(`git rev-parse --short HEAD`...)"
       fi
       echo " ($branch)"
   fi
}

export PS1='\u@\h \[\033[01;36m\]\W\[\033[01;32m\]$(git_branch)\[\033[00m\] \$ ' 
EOF
}

function bind_tab_like_zsh() {
    original_user_home=$(eval echo ~$SUDO_USER)
    cat <<'EOF' >>$original_user_home/.bashrc
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
EOF
}

# alias ll='ls -alh'
function alias_ll() {
    original_user_home=$(eval echo ~$SUDO_USER)
    echo "alias ll='ls -alh'" >>$original_user_home/.bashrc
}

# alias docker=podman
function alias_docker_podman() {
    original_user_home=$(eval echo ~$SUDO_USER)
    echo "docker=podman" >>$original_user_home/.bashrc
}

function alias_color_grep() {
    original_user_home=$(eval echo ~$SUDO_USER)
    echo "alias grep='grep --color=auto'" >>$original_user_home/.bashrc
}

function set_dir_structure() {

    # 构建原用户的主目录路径
    ORIGINAL_HOME=$(eval echo ~$SUDO_USER)

    directories=(
        "$ORIGINAL_HOME/Projects"
        "$ORIGINAL_HOME/Documents"
        "$ORIGINAL_HOME/Downloads"
        "$ORIGINAL_HOME/Downloads/ISOs"
        "$ORIGINAL_HOME/Downloads/Videos"
        "$ORIGINAL_HOME/Downloads/Softwares"
        "$ORIGINAL_HOME/Downloads/Documents"
        "$ORIGINAL_HOME/Downloads/Repos"
        "$ORIGINAL_HOME/Downloads/Key-Pairs"
    )

    for directory in "${directories[@]}"; do
        if [ ! -d "$directory" ]; then
            echo "$directory"
            mkdir -vp "$directory"

            # 修改文件夹所有者为原用户
            sudo chown -R $SUDO_USER:$SUDO_USER "$directory"

            # 设置文件夹权限为 rwxr-xr-x
            sudo chmod -R 755 "$directory"
        fi
    done
}

#!/bin/bash

# Deprecated
function tui_desktop1() {
    cmd=(dialog --separate-output --checklist "Choose the utilities that you want to install" 0 0 0)
    options=(1 "Daily Gnome Desktop" on # any option can be set to default to "on"
        2 "MacOS theme" off
        3 "Chrome" off
        4 “qBittorrent” off
        5 "VSCode" off
        6 "Golang" off
        7 "Docker" off
        8 "WineHQ" off
        9 "GIMP" off
        10 "VLC" off
        11 "AppImageLauncher" off)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    for choice in $choices; do
        case $choice in
        1)
            echo "Start installing Gnome Desktop Environment"
            tailor_gnome
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
            sudo apt install qbittorrent
            ;;
        5)
            echo "Start installing VSCode"
            install_vscode
            ;;
        6)
            echo "Start installing Golang"
            install_go
            ;;
        7)
            echo "Start installing Docker"
            install_docker
            ;;
        8)
            echo "Start installing WineHQ"
            install_winehq
            ;;
        9)
            sudo apt install gimp
            ;;
        10)
            sudo apt install vlc
            ;;
        11)
            sudo apt install appimagelauncher
            ;;
        esac
    done

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
        reboot
    fi
}

# Recommended
function tui_desktop2() {
    while true; do
        choice=$(dialog --menu "What kind of software you want" 0 0 0 1 "Desktop Environment" 2 "Daily Software" 3 "Development Tools" 3>&1 1>&2 2>&3)
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
        reboot
    fi
}

# case 1
function tui_desktop_theme() {
    choice=$(dialog --title "Customize Debian 12" \
        --menu "Which theme do you prefer? press Enter to confirm" 0 0 0 \
        1 "Original Gnome" 2 "MacOS Theme" 3>&1 1>&2 2>&3 3>&-)
    clear
    if [ $choice == "1" ]; then
        tailor_gnome
    else # MacOS theme
        tailor_gnome
        install_macOS_theme
    fi
}

# case 2
function tui_desktop_dailysoftware() {
    cmd=(dialog --separate-output --checklist "Choose the utilities that you want, use SPACE to choose, ENTER to confirm" 0 0 0)
    options=(1 "Chrome" off
        2 "qBittorrent" off
        3 "WineHQ" off
        4 "GIMP" off
        5 "DarkTable" off
        6 "VLC" off
        7 "AppImageLauncher" off)
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
        7)
            sudo apt install appimagelauncher -y
            ;;
        esac
    done
}

# case 3
function tui_desktop_development() {
    cmd=(dialog --separate-output --checklist "Choose the Development Tools that you want to install" 0 0 0)
    options=(1 "Vim" on
        2 "VSCode" off
        3 "Git" off
        4 "Docker" off
        5 "Go" off)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    for choice in $choices; do
        case $choice in
        1)
            echo "Start installing Vim editor"
            sudo apt install vim -y
            ;;
        2)
            echo "Start installing VSCode"
            install_vscode
            ;;
        3)
            echo "Start installing Git"
            sudo apt install git -y
            ;;
        4)
            echo "Start installing Docker"
            install_docker
            ;;
        5)
            echo "Start installing Go"
            install_go
            ;;
        esac
    done
}

function tui_server_lab() {
    cmd=(dialog --separate-output --checklist "What's the purpose of this machine? Use space to choose" 0 0 0)
    options=(1 "Essential Server tools" on # any option can be set to default to "on"
        2 "Docker" off)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    for choice in $choices; do
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

source ./modules/tweaks.sh
source ./modules/changeMirror.sh
source ./modules/install.sh
source ./tui/tui.sh

Tsinghua="https://mirrors.tuna.tsinghua.edu.cn/debian"
Aliyun="https://mirrors.aliyun.com/debian"
USTC="https://mirrors.ustc.edu.cn/debian"
CQU="https://mirrors.cqu.edu.cn/debian"

# main
# changeMirror $CQU "Debian12"

sudo apt install dialog -y

choice=$(dialog --title "Customize Debian 12" --menu "What's the purpose of this machine? press Enter to confirm" 0 0 0 1 "Desktop" 2 "Server Lab for VMs" 3>&1 1>&2 2>&3 3>&-)
clear
if [ $choice == "1" ]; then
    tui_desktop2
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
