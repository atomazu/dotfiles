#!/bin/bash

# --- Configuration ---
WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"
INTERVAL=600
DEBUG=true

# Parse arguments
while getopts "d" opt; do
    case $opt in
        d) DEBUG=true ;;
    esac
done

# Print function
print_msg() {
    local level=$1
    local message=$2
    printf "[%s] [%s] %s\n" "$(date '+%H:%M:%S')" "$level" "$message" >&2
}

debug() {
    if [[ "$DEBUG" == true ]]; then
        print_msg "DEBUG" "$1"
    fi
}

# Function to get a list of all images (shuffled)
get_shuffled_images() {
    find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) 2>/dev/null | sort -R
}

# Function to get a list of connected monitors
get_monitors() {
    hyprctl monitors | grep "Monitor " | awk '{print $2}'
}

# Check if directory exists and is readable
if [[ ! -d "$WALLPAPER_DIR" || ! -r "$WALLPAPER_DIR" ]]; then
    print_msg "ERROR" "Cannot access directory: $WALLPAPER_DIR"
    exit 1
fi

# Script startup
debug "Script started"
debug "Using directory: $WALLPAPER_DIR"

# Main loop
while true; do
    monitors=($(get_monitors))
    num_monitors=${#monitors[@]}
    debug "Found $num_monitors monitors: ${monitors[@]}"

    if [[ "$num_monitors" -gt 0 ]]; then
        shuffled_images=($(get_shuffled_images))
        num_images=${#shuffled_images[@]}
        debug "Found $num_images images"

        if [[ "$num_images" -lt "$num_monitors" ]]; then
            print_msg "WARNING" "Not enough unique images to set for all monitors. Skipping this cycle."
        else
            # Assign a unique image to each monitor
            i=0
            for monitor in "${monitors[@]}"; do
                image="${shuffled_images[i]}"
                if [[ -n "$image" ]]; then
                    hyprctl_command=$(printf 'hyprctl hyprpaper wallpaper "%s,%s"' "$monitor" "$image")
                    debug "Setting wallpaper for $monitor with: $hyprctl_command"
                    if eval "$hyprctl_command"; then
                        print_msg "INFO" "Set wallpaper for $monitor: $(basename "$image")"
                    else
                        print_msg "ERROR" "Failed to set wallpaper for $monitor: $(basename "$image")"
                    fi
                    ((i++))
                else
                    print_msg "ERROR" "Error getting image for $monitor"
                fi
            done
        fi
    else
        print_msg "WARNING" "No monitors found"
    fi

    debug "Waiting $INTERVAL seconds"
    sleep "$INTERVAL"s
done