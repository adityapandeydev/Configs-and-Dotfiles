#!/bin/bash

WALL_DIR="$HOME/Pictures/Wallpapers"
CACHE_FILE="$HOME/.cache/wallpaper-index"

mapfile -t WALLPAPERS < <(ls -1 "$WALL_DIR" | sort)

COUNT=${#WALLPAPERS[@]}

if [[ -f "$CACHE_FILE" ]]; then
    INDEX=$(cat "$CACHE_FILE")
else
    INDEX=0
fi

sleep 2

while true; do
    awww img "$WALL_DIR/${WALLPAPERS[$INDEX]}"

    echo "$INDEX" > "$CACHE_FILE"

    INDEX=$(( (INDEX + 1) % COUNT ))

    sleep 300
done