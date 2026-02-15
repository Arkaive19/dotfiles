#!/usr/bin/env bash
# rotate-monitors.sh
# Usage: ./rotate-monitors.sh left|right

CACHE="$HOME/.cache/rotation_state" # temp file to store current rotation

DIR="$1" # "left" (-90°) or "right" (+90°)

# Default rotation if cache doesn't exist
if [ ! -f "$CACHE" ]; then
  echo 0 >"$CACHE"
fi

# Read current rotation
CUR=$(cat "$CACHE")

# Compute new rotation
if [ "$DIR" = "right" ]; then
  NEW=$(((CUR + 90) % 360))
elif [ "$DIR" = "left" ]; then
  NEW=$(((CUR + 270) % 360)) # same as -90 mod 360
else
  echo "Usage: $0 left|right"
  exit 1
fi

# Update cache
echo "$NEW" >"$CACHE"

# Apply rotation to all monitors
MONITORS=$(hyprctl monitors | grep "Monitor " | awk '{print $2}')

# Hyprland transform mapping: 0->0, 90->1, 180->2, 270->3
TRANSFORM=$((NEW / 90))

for MON in $MONITORS; do
  hyprctl keyword monitor "$MON,preferred,auto,1,transform,$TRANSFORM"
  echo "Rotated $MON to $NEW°"
done
