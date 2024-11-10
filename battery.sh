#!/bin/bash

# Get battery status and percentage
battery_info=$(acpi -b)
status=$(echo "$battery_info" | awk '{print $3}' | tr -d ',')
percentage=$(echo "$battery_info" | awk '{print $4}' | tr -d '%,')
time_remaining=$(echo "$battery_info" | awk '{print $5}')

# Define icon based on state
if [ "$status" = "Discharging" ]; then
  icon="🔋"
elif [ "$status" = "Charging" ]; then
  icon="⚡"
else
  icon="🔌"
fi

# Output for i3blocks
echo "$icon $percentage% ($time_remaining)"

# Color based on battery level
if [ "$percentage" -ge 80 ]; then
  echo "#00FF00" # Green for >= 80%
elif [ "$percentage" -ge 30 ]; then
  echo "#FFFF00" # Yellow for 30-79%
else
  echo "#FF0000" # Red for < 30%
fi
