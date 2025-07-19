#!/usr/bin/env bash



battery_info=$(acpi -b | awk -F', *' '{print "Battery:", $2, "Time left:", substr($3, 1, 5)}')
dunstify "${battery_info}"
