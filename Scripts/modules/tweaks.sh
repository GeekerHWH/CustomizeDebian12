#!/bin/bash

function set_grub_time_0() {
    # change grub timeout to 0 sec
    sudo sed -i 's/GRUB_TIMEOUT=[0-9]\+/GRUB_TIMEOUT=0/' /etc/default/grub
    sudo update-grub
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

function alias_docker_podman() {
    original_user_home=$(eval echo ~$SUDO_USER)
    echo "alias docker='podman'" >> $original_user_home/.bashrc
}

# To Do: colorful grep
function alias_color_grep() {
    original_user_home=$(eval echo ~$SUDO_USER)
    echo "alias grep='grep --color=auto'" >> $original_user_home/.bashrc
}
