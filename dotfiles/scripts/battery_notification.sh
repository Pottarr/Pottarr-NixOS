#!/usr/bin/env bash

battery_info=$(acpi -b | awk -F', *' '{print "Battery:", $2, "Time left:", substr($3, 1, 5)}')
battery_percent=$(acpi -b | awk -F', *' '{print "Battery:", $2, "Time left:", substr($3, 1, 5)}')
dunstify "${battery_info}" -h string:x-dunst-stack-tag:battery -h int:value:"$battery_percent"
