#!/bin/bash

function set_grub_time_0() {
    # change grub timeout to 0 sec
    sudo sed -i 's/GRUB_TIMEOUT=[0-9]\+/GRUB_TIMEOUT=0/' /etc/default/grub
    update-grub
}