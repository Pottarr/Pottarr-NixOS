#!/usr/bin/env bash

#Code Provided by Pottarr

# Get the ELECOM device ID
# I added 2 spacebars in the back to get the Normal one NOT the Consumer Control one!
ELECOM_ID=$(xinput list | grep "ELECOM ELECOM TrackBall Mouse  " | head -n 1 | sed -r 's/.*id=([0-9]+).*/\1/')

# Check if ELECOM_ID is not empty
if [ -z "$ELECOM_ID" ]; then
    echo "ELECOM device not found. Please ensure the device is connected."
    exit 1
fi

# Remap the buttons
xinput --set-button-map ${ELECOM_ID} 3 2 1

# Check if the remapping was successful
if [ $? -eq 0 ]; then
    echo "Buttons remapped successfully for ELECOM device (ID: $ELECOM_ID)."
else
    echo "Failed to remap buttons for ELECOM device (ID: $ELECOM_ID)."
    exit 1
fi

# Optional: Output the current button mapping for verification
echo "Current button mapping:"
xinput get-button-map ${ELECOM_ID}

