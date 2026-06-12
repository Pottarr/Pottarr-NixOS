#!/usr/bin/env bash

WALLPAPER="/home/pottarr/Pictures/Profile/Background.jpg"

setup_wallpaper() {
    # Wait a brief moment to ensure xrandr is updated and displays are stable
    sleep 1.5
    if [ ! -f "$WALLPAPER" ]; then
        echo "Wallpaper file not found: $WALLPAPER" >&2
        return 1
    fi
    
    # Get the number of connected monitors
    num_monitors=$(xrandr --query | grep " connected" | wc -l)
    
    # Build the feh command
    cmd=("feh" "--bg-scale")
    for ((i=0; i<num_monitors; i++)); do
        cmd+=("$WALLPAPER")
    done
    
    echo "Setting wallpaper for $num_monitors connected monitor(s)..."
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
