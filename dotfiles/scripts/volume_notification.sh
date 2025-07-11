#!/usr/bin/env bash

sink_name=$(wpctl status | awk '
  /Sinks:/ {p=1; next}
  p && /\*/ {
    # Remove first three fields: "*", ID, and "ID." (number)
    for (i=4; i<=NF; i++) {
      if ($i ~ /^\[vol:/) break
      printf $i " "
    }
    print ""
    exit
  }
')

vol=$(wpctl get-volume "@DEFAULT_AUDIO_SINK@")
vol=${vol#* }
vol=$(echo "$vol" | tr -d ".")
while [[ ${vol:0:1} == "0" ]]; do vol=${vol:1}; done
if [[ -z "$vol" ]]; then vol=0; fi
dunstify "Volume: ${vol}%" "$sink_name" -h string:x-dunst-stack-tag:volume -h int:value:"$vol"
