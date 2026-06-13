#!/usr/bin/env bash

# Find touchpad device name dynamically and strip any leading non-alphanumeric chars (like '∼')
DEVICE=$(xinput list --name-only | grep -i "touchpad" | head -n 1 | sed 's/^[^[:alnum:]]*//')

if [[ -z "$DEVICE" ]]; then
    if command -v dunstify &>/dev/null; then
        dunstify -u critical "Touchpad Toggle" "No touchpad device found!"
    elif command -v notify-send &>/dev/null; then
        notify-send -u critical "Touchpad Toggle" "No touchpad device found!"
    fi
    echo "Error: No touchpad device found." >&2
    exit 1
fi

# Get current state (1 for enabled, 0 for disabled)
STATE=$(xinput list-props "$DEVICE" | awk '/Device Enabled/ {print $NF}')

# Determine action
ACTION="${1:-toggle}"

case "$ACTION" in
    on|enable)
        NEW_STATE=1
        ;;
    off|disable)
        NEW_STATE=0
        ;;
    toggle)
        if [[ "$STATE" -eq 1 ]]; then
            NEW_STATE=0
        else
            NEW_STATE=1
        fi
        ;;
    status)
        if [[ "$STATE" -eq 1 ]]; then
            echo "enabled"
        else
            echo "disabled"
        fi
        exit 0
        ;;
    *)
        echo "Usage: $0 [on|off|toggle|status]" >&2
        exit 1
        ;;
esac

# Apply state change
if [[ "$NEW_STATE" -eq 1 ]]; then
    xinput enable "$DEVICE"
    MSG="Touchpad Enabled"
    ICON="input-touchpad"
else
    xinput disable "$DEVICE"
    MSG="Touchpad Disabled"
    ICON="touchpad-disabled"
fi

# Send notification if dunstify or notify-send is available
if command -v dunstify &>/dev/null; then
    dunstify -h string:x-dunst-stack-tag:touchpad -i "$ICON" "Touchpad" "$MSG"
elif command -v notify-send &>/dev/null; then
    notify-send -h string:x-dunst-stack-tag:touchpad -i "$ICON" "Touchpad" "$MSG"
fi

echo "$MSG"
