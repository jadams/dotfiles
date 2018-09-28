#!/bin/sh
set -e
xpid="$(pgrep -n X)"
userpid="$(pgrep -n startx)"
xuser="$(ps -o user --no-headers $userpid)"
display="$(egrep -aoz ':[0-9](.[0-9])?' /proc/$xpid/cmdline)"
export XAUTHORITY="/home/$xuser/.Xauthority"
export DISPLAY="$display"

su - "$xuser" -c "/usr/local/bin/betterlockscreen -l" &
pm-suspend
