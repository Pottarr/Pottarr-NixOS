#!/usr/bin/env bash

# Find the first laptop battery in /sys/class/power_supply (e.g., BAT0 or BAT1)
BAT_NUM=$(ls /sys/class/power_supply/ | grep -E '^BAT[0-9]+$' | head -n 1)
BAT_NUM=${BAT_NUM:-BAT0} # Fallback to BAT0 if none detected

# Using a PID file 

cd $(dirname $0)
PIDFILE=/tmp/$(basename $0 .sh).pid

if [ -f $PIDFILE ]; then
  if [ -e /proc/$(cat $PIDFILE) ]; then
    exit 0
  fi
fi
echo $BASHPID > $PIDFILE

# Making a function for each Notification type 

notify_me_full () {
	notify-send -u critical -t 0 -i "$PWD/icons/battery-full-charging.svg" "$1" "Level : $2%"
	paplay /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga
}

notify_me_low () {
        notify-send -u critical -t 0 -i "$PWD/icons/battery-low.svg" "$1" "Level : $2%"
        paplay /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga
}


while true
do
    export DISPLAY=:0.0
    battery_percent=$(cat /sys/class/power_supply/${BAT_NUM}/capacity)
	#    if on_ac_power; then
	#        if [ $battery_percent -gt 96 ]; then
	# 	notify_me_full "You can unplug the charger now! the battery is almost full" $battery_percent
	#        fi
	#    elif [ $battery_percent -lt 20 ]; then
	# notify_me_low "Plug the charger. Battery level is low, and that's not good" $battery_percent
	#    fi

    if [ $battery_percent -lt 20 ]; then
        notify_me_low "Plug the charger. Battery level is low, and that's not good" $battery_percent && brightnessctl set 10%
    fi
    sleep 300 # 5 minutes
done
