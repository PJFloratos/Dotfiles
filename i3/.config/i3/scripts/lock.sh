#!/bin/bash

# Define where to temporarily save the screenshot
IMAGE=/tmp/screen_locked.png

# 1. Take a screenshot of the current desktop
scrot $IMAGE

# 2. Add the "Frosted Glass" blur effect (0x8 is the blur strength)
convert $IMAGE -blur 0x8 $IMAGE

# 3. Lock the screen with the blurred PNG
i3lock -n -i $IMAGE

# 4. Delete the temporary image after unlocking
rm $IMAGE
