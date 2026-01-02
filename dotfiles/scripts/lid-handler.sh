#!/usr/bin/env bash

if xrandr | grep -q "HDMI.* connected"; then
    exit 0
fi

systemctl suspend
