#!/bin/bash

# Define the options with beautiful Nerd Font icons
lock="  Lock"
logout="󰍃  Logout"
suspend="󰒲  Suspend"
reboot="󰜉  Reboot"
shutdown="󰐥  Shutdown"

# Send the options to Rofi and wait for the user to pick one
# -dmenu reads from our list, -i makes it case insensitive, -p is the prompt
selected=$(echo -e "$lock\n$logout\n$suspend\n$reboot\n$shutdown" | rofi -dmenu -i -p "Power")

# Execute the command based on what you clicked/typed
case $selected in
    "$lock")
        ~/.config/i3/scripts/lock.sh ;;
    "$logout")
        i3-msg exit ;;
    "$suspend")
        systemctl suspend ;;
    "$reboot")
        systemctl reboot ;;
    "$shutdown")
        systemctl poweroff ;;
esac
