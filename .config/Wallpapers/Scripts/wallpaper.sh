#!/bin/bash
set -x

# Check if a directory argument was passed
if [ -z "$1" ]; then
  echo "Usage: $0 <wallpaper-directory>"
  exit 1
fi

WALL_DIR="$1"

# Pick a random image from the directory
wal=$(find "$WALL_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.gif" \) | shuf -n 1)

# Make sure we found an image
if [ -z "$wal" ]; then
  echo "No image found in $WALL_DIR"
  exit 1
fi

# Set the wallpaper
awww img "$wal" --transition-type wave
