#!/usr/bin/env bash

brightness=$(brightnessctl | grep -oP '[0-9]+(?=%)')
dunstify "Brightness: ${brightness}%" -h string:x-dunst-stack-tag:brightness -h int:value:"$brightness"
