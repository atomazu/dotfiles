#!/bin/bash

# Kill any existing rofi window
killall rofi

selected=$(echo -e "1. 󰌾 Lock\n2. 󰑐 Reboot\n3. 󰤄 Sleep\n4. 󰐥 Shutdown\n5. 󰗽 Log Out" | \
rofi \
    -dmenu \
    -p "Power Menu:" \
    -theme ~/.config/rofi/powermenu.rasi \
    -monitor 0 \
    -location 0 \
    -i)

# Debug output
#echo "Selected: $selected" > /tmp/rofi_power.log

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