#!/bin/bash

WINDOWS=$(hyprctl activeworkspace -j | jq '.windows' 2>/dev/null)

if [[ -n "$WINDOWS" && "$WINDOWS" -gt 0 ]]; then
    exec ghostty --class=com.mitchellh.ghostty.float
else
    exec ghostty
fi