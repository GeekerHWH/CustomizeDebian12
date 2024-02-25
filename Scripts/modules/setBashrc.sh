#!/bin/bash

function setBashrc() {
    # get the home path
    original_user_home=$(eval echo ~$SUDO_USER)

    cat << 'EOF' >> $original_user_home/.bashrc
export PATH=$PATH:/usr/local/go/bin

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

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

alias ll='ls -alh'
EOF

}