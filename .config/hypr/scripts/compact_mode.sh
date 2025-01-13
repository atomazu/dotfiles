#!/bin/bash

COMPACT_STYLE="$HOME/.config/waybar/compact.css"
COMPACT_CONFIG="$HOME/.config/waybar/compact.jsonc"
STATE_FILE="/tmp/waybar_compact_mode_state"

enable_compact_mode() {
  echo "Enabling compact mode..."

  killall waybar
  waybar -c $COMPACT_CONFIG -s $COMPACT_STYLE &
  hyprctl keyword decoration:rounding 0
  hyprctl keyword general:gaps_in 0
  hyprctl keyword general:gaps_out 0
  hyprctl keyword general:border_size 1
  hyprctl keyword general:col.active_border 0xffaaaaaa
  hyprctl keyword general:col.inactive_border 0xff333333
  
  echo "compact" > "$STATE_FILE"
}

disable_compact_mode() {
  echo "Disabling compact mode..."

  killall waybar
  waybar &
  hyprctl reload

  echo "normal" > "$STATE_FILE"
}

# Check current state and toggle
if [ -f "$STATE_FILE" ]; then
  CURRENT_STATE=$(cat "$STATE_FILE")
else
  CURRENT_STATE="normal"
fi

if [ "$CURRENT_STATE" = "compact" ]; then
  disable_compact_mode
else
  enable_compact_mode
fi