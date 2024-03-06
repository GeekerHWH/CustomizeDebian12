#!/bin/bash

function set_grub_time_0() {
    # change grub timeout to 0 sec
    sudo sed -i 's/GRUB_TIMEOUT=[0-9]\+/GRUB_TIMEOUT=0/' /etc/default/grub
    update-grub
}

function display_git_branch() {
    # get the home path
    original_user_home=$(eval echo ~$SUDO_USER)

    cat << 'EOF' >> $original_user_home/.bashrc

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
    cat << 'EOF' >> $original_user_home/.bashrc
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
EOF
}

# alias ll='ls -alh'
function alias_ll() {
    original_user_home=$(eval echo ~$SUDO_USER)
    echo "alias ll='ls -alh'" >> $original_user_home/.bashrc
}

# alias docker=podman
function alias_docker_podman() {
    original_user_home=$(eval echo ~$SUDO_USER)
    echo "docker=podman" >> $original_user_home/.bashrc
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

    for directory in "${directories[@]}"
    do
        if [ ! -d "$directory" ]
        then
            echo "$directory"
            mkdir -vp "$directory"

            # 修改文件夹所有者为原用户
            sudo chown -R $SUDO_USER:$SUDO_USER "$directory"

            # 设置文件夹权限为 rwxr-xr-x
            sudo chmod -R 755 "$directory"
        fi
    done
}
