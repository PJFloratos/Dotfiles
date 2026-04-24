#!/bin/bash

# Define the glass theme
THEME="$HOME/.config/rofi/launchers/type-1/style-11.rasi"

# Define the menu options with visual separators (─)
options="󰝟  Toggle Audio Mute
󰍭  Toggle Mic Mute
──────────────────────
󰕾  Volume +5%
󰖀  Volume -5%
󰕾  Set Volume 100%
󰖀  Set Volume 50%
──────────────────────
󰒮  Previous Track
󰐊  Play / Pause
󰒭  Next Track
──────────────────────
󰒓  Audio Settings (pavucontrol)"

# Feed the options into Rofi
chosen=$(echo -e "$options" | rofi -dmenu -i -theme "$THEME" -p "Audio Center")

# Execute the command based on the exact string selected
case $chosen in
    "󰝟  Toggle Audio Mute")
        pactl set-sink-mute @DEFAULT_SINK@ toggle ;;
    "󰍭  Toggle Mic Mute")
        pactl set-source-mute @DEFAULT_SOURCE@ toggle ;;
    "󰕾  Volume +5%")
        pactl set-sink-volume @DEFAULT_SINK@ +5% ;;
    "󰖀  Volume -5%")
        pactl set-sink-volume @DEFAULT_SINK@ -5% ;;
    "󰕾  Set Volume 100%")
        pactl set-sink-volume @DEFAULT_SINK@ 100% ;;
    "󰖀  Set Volume 50%")
        pactl set-sink-volume @DEFAULT_SINK@ 50% ;;
    "󰒮  Previous Track")
        playerctl previous ;;
    "󰐊  Play / Pause")
        playerctl play-pause ;;
    "󰒭  Next Track")
        playerctl next ;;
    "󰒓  Audio Settings (pavucontrol)")
        pavucontrol ;;
esac
