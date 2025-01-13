#!/bin/bash
# This script prevents running multiple hyprshot instances.

lockfile="/tmp/hyprshot.lock"

if [ -f "$lockfile" ]; then
    exit 0
fi

touch "$lockfile"
hyprshot -m region --clipboard-only
rm "$lockfile"