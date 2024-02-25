#!/bin/bash

function setDir() {

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
        if [ ! -d $directory ]
        then
            echo $directory
            mkdir -vp $directory
        fi
    done

}