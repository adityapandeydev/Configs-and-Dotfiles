#!/bin/bash

WINDOWS=$(hyprctl activeworkspace -j | jq '.windows')

if [[ "$WINDOWS" -eq 0 ]]; then
    exec ghostty
else
    exec ghostty --class ghostty-float
fi