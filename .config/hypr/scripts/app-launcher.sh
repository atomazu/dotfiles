#!/bin/bash

# Kill any existing rofi instance
killall rofi

# Launch rofi in drun mode with uwsm app directly
uwsm app -- rofi \
    -show drun \
    -theme ~/.config/rofi/app-launcher.rasi \
    -show-icons \
    -icon-theme "Papirus,breeze,hicolor" \
    -drun-display-format "{name}" \
    -no-click-to-exit \
    -drun-exec "uwsm app --"