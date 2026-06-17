#!/bin/bash

BAR_HEIGHT=34

FLOATING=$(hyprctl activewindow | awk '/floating:/ {print $2}')

if [[ "$FLOATING" == "0" ]]; then
    hyprctl dispatch togglefloating

    sleep 0.05

    hyprctl dispatch movewindowpixel exact 0 $BAR_HEIGHT
    hyprctl dispatch resizeactive exact 1536 $((864 - BAR_HEIGHT))
else
    hyprctl dispatch togglefloating
fi