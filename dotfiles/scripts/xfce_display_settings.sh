#!/usr/bin/env bash

# Example: List display profiles and apply selected one
PROFILES=$(xfconf-query -c xfce4-panel -p /xfce4-panel/profiles -l | grep -oP '(?<=profiles/)[^/]+')

CHOICE=$(echo -e "$PROFILES\nOpen Display Settings" | rofi -dmenu -p "Select Display Profile or Open Settings:")

if [ "$CHOICE" == "Open Display Settings" ]; then
    xfce4-display-settings
elif [ -n "$CHOICE" ]; then
    xfce4-display-settings --apply-profile "$CHOICE"
fi
