#!/usr/bin/env bash

# 1. Terminate already running bar instances
killall -q polybar

# 2. Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# 3. Launch Polybar on all connected monitors
if type "xrandr" > /dev/null; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload top &
    MONITOR=$m polybar --reload bottom &
  done
else
  polybar --reload top &
  polybar --reload bottom &
fi
