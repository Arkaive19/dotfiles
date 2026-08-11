#!/bin/bash

# Usage: ./set_current.sh /path/to/target

TARGET="$1"
LINK="$HOME/.config/Wallpapers/Scripts/current"

if [ -z "$TARGET" ]; then
  echo "Error: No target path provided."
  echo "Usage: $0 /path/to/target"
  exit 1
fi

if [ ! -e "$TARGET" ]; then
  echo "Error: Target path does not exist: $TARGET"
  exit 1
fi

# Remove existing symlink if it exists
if [ -L "$LINK" ] || [ -e "$LINK" ]; then
  rm -rf "$LINK"
fi

# Create the symlink
ln -s "$TARGET" "$LINK"

echo "Symlink created: $LINK -> $TARGET"
