#!/bin/bash

WALL_DIR="$HOME/Pictures/Wallpapers"
CACHE_FILE="$HOME/.cache/wallpaper-index"

mapfile -t WALLPAPERS < <(ls -1 "$WALL_DIR" | sort)

COUNT=${#WALLPAPERS[@]}

INDEX=$(cat "$CACHE_FILE" 2>/dev/null || echo 0)

INDEX=$(( (INDEX - 1 + COUNT) % COUNT ))

echo "$INDEX" > "$CACHE_FILE"

awww img "$WALL_DIR/${WALLPAPERS[$INDEX]}"
