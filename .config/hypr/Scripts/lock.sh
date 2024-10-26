#!/bin/bash

# Define paths for the screenshots
acershot="/tmp/lock-acer.png"
lgshot="/tmp/lock-lg.png"
lenovoshot="/tmp/lock-lenovo.png"

# Take screenshots for each monitor
grim -o HDMI-A-1 "$acershot"      # Acer XV272U
grim -o DP-3 "$lgshot"            # LG UltraGear
grim -o DP-2 "$lenovoshot"        # Lenovo D32q-20B

# Small delay to ensure images are saved
sleep 0.1

# Run Hyprlock
hyprlock
