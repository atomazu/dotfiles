# ~/.config/hypr/scripts/everything-search.sh

# Kill any existing rofi instance
killall rofi

# Launch rofi in combined mode
rofi \
    -show combi \
    -combi-modes "drun,run,filebrowser" \
    -modes combi \
    -theme ~/.config/rofi/everything-search.rasi \
    -show-icons \
    -icon-theme "Papirus,breeze,gnome,hicolor" \
    -drun-display-format "{name}" \
    -file-browser-dir "$HOME" \
    -file-browser-follow-symlinks \
    -no-click-to-exit