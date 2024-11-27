#!/bin/bash

# Kill any existing rofi window
killall rofi

# Set theme path
THEME_PATH="$HOME/.config/rofi/powermenu.rasi"

# Show power menu using rofi
selected=$(echo -e "1. 󰌾 Lock\n2. 󰑐 Reboot\n3. 󰤄 Sleep\n4. 󰐥 Shutdown\n5. 󰗽 Log Out" | \
uwsm app -- rofi \
    -dmenu \
    -theme "$THEME_PATH" \
    -p "Power Menu:" \
    -monitor 0 \
    -location 0 \
    -i)

case "$selected" in
    "1. 󰌾 Lock")
        nohup ~/.config/hypr/scripts/lock.sh > /dev/null 2>&1 & ;;
    "2. 󰑐 Reboot")
        systemctl reboot ;;
    "3. 󰤄 Sleep")
        systemctl suspend ;;
    "4. 󰐥 Shutdown")
        systemctl poweroff ;;
    "5. 󰗽 Log Out")
        hyprctl dispatch exit;;
esac