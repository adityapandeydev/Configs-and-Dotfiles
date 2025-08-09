#!/bin/bash

ACTIVE_WINDOW=$(hyprctl activewindow -j)
ACTIVE_PID=$(echo "$ACTIVE_WINDOW" | jq -r '.pid')
ACTIVE_CLASS=$(echo "$ACTIVE_WINDOW" | jq -r '.class')

TARGET_DIR=""

# Function to recursively find all descendant process IDs
get_descendants() {
    local parent=$1
    local children=$(pgrep -P "$parent" 2>/dev/null)
    for child in $children; do
        echo "$child"
        get_descendants "$child"
    done
}

# If the active window is one of our target editors
if [[ "$ACTIVE_CLASS" =~ (code|zed|antigravity-ide|Zed|dev.zed.Zed) ]]; then
    # Gather all PIDs (main editor PID + all recursive descendant PIDs)
    PIDS=($ACTIVE_PID $(get_descendants "$ACTIVE_PID"))

    # 1. Try checking the CWD of the editor and its descendant processes
    for pid in "${PIDS[@]}"; do
        CWD=$(readlink -f "/proc/$pid/cwd" 2>/dev/null)
        if [[ -d "$CWD" && "$CWD" != "$HOME" && "$CWD" != "/" && "$CWD" =~ ^/home/adityapandey/ ]]; then
            dir="$CWD"
            while [[ "$dir" != "$HOME" && "$dir" != "/" ]]; do
                if [[ -d "$dir/.git" ]]; then
                    TARGET_DIR="$dir"
                    break 2
                fi
                dir=$(dirname "$dir")
            done
        fi
    done

    # 2. If target directory is still not found, check command line arguments
    if [[ -z "$TARGET_DIR" ]]; then
        while IFS= read -r -d '' arg; do
            if [[ -d "$arg" && "$arg" =~ ^/home/adityapandey/ ]]; then
                dir=$(readlink -f "$arg")
                while [[ "$dir" != "$HOME" && "$dir" != "/" ]]; do
                    if [[ -d "$dir/.git" ]]; then
                        TARGET_DIR="$dir"
                        break 2
                    fi
                    dir=$(dirname "$dir")
                done
            fi
        done < "/proc/$ACTIVE_PID/cmdline"
    fi

    # 3. If target directory is still not found, scan open file descriptors of all PIDs
    if [[ -z "$TARGET_DIR" ]]; then
        for pid in "${PIDS[@]}"; do
            paths=$(readlink -f /proc/$pid/fd/* 2>/dev/null | grep -E "^/home/adityapandey/" | grep -vE "(\.config|\.cache|\.local|/memfd:)")
            for p in $paths; do
                if [[ -f "$p" || -d "$p" ]]; then
                    dir=$(dirname "$p")
                    while [[ "$dir" != "$HOME" && "$dir" != "/" ]]; do
                        if [[ -d "$dir/.git" ]]; then
                            TARGET_DIR="$dir"
                            break 2
                        fi
                        dir=$(dirname "$dir")
                    done
                fi
            done
        done
    fi
fi

# Fallback: Default to the dotfiles directory or home
if [[ -z "$TARGET_DIR" || ! -d "$TARGET_DIR" ]]; then
    TARGET_DIR="/home/adityapandey/Aditya/Configs-and-Dotfiles"
fi

exec ghostty --class=com.mitchellh.ghostty.float --working-directory="$TARGET_DIR" -e lazygit
