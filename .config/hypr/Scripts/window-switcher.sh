#!/bin/bash
# ~/.config/hypr/scripts/window-switcher.sh

# Function to get icon based on class name
get_icon() {
    case $1 in
        "firefox") echo "firefox";;
        "code-url-handler") echo "visual-studio-code";;
        "foot") echo "terminal";;
        "nemo") echo "system-file-manager";;
        "spotify") echo "spotify";;
        "vesktop"|"discord") echo "discord";;
        *) echo "application-default";;
    esac
}

# Force any existing rofi window to close
killall rofi

# Get the current monitor ID
current_monitor=$(hyprctl activeworkspace -j | jq -r '.monitor')

# Store selection with address as hidden field
selected=$(hyprctl clients -j | \
jq -r '.[] | select(.mapped==true) | "\(.class) [\(.workspace.name)] - \(.title)\t\(.address)"' | \
while IFS=$'\t' read -r title address; do
    class=$(echo "$title" | cut -d' ' -f1)
    icon=$(get_icon "$class")
    printf "%s\0icon\x1f%s\n" "$title" "$icon"
done | \
rofi \
    -dmenu \
    -p "Switch to:" \
    -theme ~/.config/rofi/window-switcher.rasi \
    -show-icons \
    -monitor $current_monitor \
    -location 0 \
    -width 50 \
    -window-match-fields "title" \
    -no-click-to-exit \
    -i)

# If selection was made, focus the window
if [ ! -z "$selected" ]; then
    # Get the window address
    address=$(hyprctl clients -j | \
             jq -r ".[] | select(.mapped==true) | select(.class + \" [\" + .workspace.name + \"] - \" + .title == \"$selected\") | .address")

    if [ ! -z "$address" ]; then
        hyprctl dispatch focuswindow "address:$address"
        sleep 0.1
        coords=$(hyprctl activewindow -j | jq -r '"\(.at[0]+.size[0]/2),\(.at[1]+.size[1]/2)"')
        if [ ! -z "$coords" ]; then
            hyprctl dispatch movecursor $coords
        fi
    fi
fi