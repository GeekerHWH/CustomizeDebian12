#!/bin/bash

# This script is used to combine all needed scripts into one single script
# which is convinient to be executed by one command
rm -f CustomizeDebian12.sh

# echo "# Final executable scripts" > CustomizeDebian12.sh

cat Scripts/modules/changeMirror.sh Scripts/modules/install.sh Scripts/modules/tweaks.sh Scripts/tui/tui.sh Scripts/main.sh > CustomizeDebian12.sh