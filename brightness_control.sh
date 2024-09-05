#!/bin/bash

# Get the current brightness level
current_brightness=$(xrandr --verbose --current | grep -i brightness | cut -f2 -d ' ')

# Convert the brightness to a floating-point number
current_brightness=$(echo "$current_brightness" | awk '{printf "%.1f", $1}')

# Define the increment value
increment=0.1

if [ "$1" = "decrease" ]; then
    new_brightness=$(echo "$current_brightness - $increment" | bc)
elif [ "$1" = "increase" ]; then
    new_brightness=$(echo "$current_brightness + $increment" | bc)
fi

# Ensure the brightness does not go below 0 or above 1
new_brightness=$(awk -v nb="$new_brightness" 'BEGIN { if (nb < 0) print 0; else if (nb > 1) print 1; else print nb }')

# Set the new brightness level
xrandr --output eDP-1 --brightness $new_brightness

