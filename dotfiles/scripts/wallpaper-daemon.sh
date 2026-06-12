#!/usr/bin/env bash

DEFAULT_WALLPAPER="/home/pottarr/Pictures/Profile/Background.jpg"
STATE_FILE="/home/pottarr/.config/i3/.current_wallpaper"

setup_wallpaper() {
    # Wait a brief moment to ensure xrandr is updated and displays are stable
    sleep 1.5
    
    # Determine which wallpaper to use
    if [ -f "$STATE_FILE" ]; then
        WALLPAPER=$(cat "$STATE_FILE")
    else
        WALLPAPER="$DEFAULT_WALLPAPER"
    fi
    
    # Fallback to default if the file from the state file doesn't exist
    if [ ! -f "$WALLPAPER" ]; then
        WALLPAPER="$DEFAULT_WALLPAPER"
    fi

    if [ ! -f "$WALLPAPER" ]; then
        echo "Wallpaper file not found: $WALLPAPER" >&2
        return 1
    fi

    # Read the wallpaper mode
    STATE_FILE_MODE="${STATE_FILE}_mode"
    if [ -f "$STATE_FILE_MODE" ]; then
        MODE=$(cat "$STATE_FILE_MODE")
    else
        MODE="scale"
    fi

    # Validate mode
    if [[ ! "$MODE" =~ ^(scale|tile|center|fill)$ ]]; then
        MODE="scale"
    fi
    
    # Get the number of connected monitors
    num_monitors=$(xrandr --query | grep " connected" | wc -l)
    
    # Build the feh command
    cmd=("feh" "--bg-$MODE")
    for ((i=0; i<num_monitors; i++)); do
        cmd+=("$WALLPAPER")
    done
    
    echo "Setting wallpaper in '$MODE' mode for $num_monitors connected monitor(s)..."
    "${cmd[@]}"
}

if [ "$1" = "--once" ]; then
    setup_wallpaper
    exit 0
fi

# Run setup initially
setup_wallpaper

# Listen to DRM events (monitor connection changes)
udevadm monitor --subsystem=drm | while read -r line; do
    if [[ "$line" == *"change"* ]]; then
        setup_wallpaper
    fi
done
