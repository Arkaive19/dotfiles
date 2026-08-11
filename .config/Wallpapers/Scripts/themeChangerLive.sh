#!/bin/bash
set -x
WALLPAPER_DIR="$HOME/.config/Wallpapers"
WALLPAPER_SCRIPT="$HOME/.config/Wallpapers/Scripts/wallpaper.sh"
SYS_SCRIPT="$HOME/.config/Wallpapers/Scripts/currentWal.sh"
SPICETIFY_THEME="Dribbblish"

# Ensure wallpaper directory exists
mkdir -p "$WALLPAPER_DIR"

eww close bar

# "$BARS_SCRIPT"
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.gif" \) | while read -r img_path; do echo -en "${img_path}\0icon\x1fthumbnail://$img_path\n"; done |
  rofi -dmenu -show-icons -theme ~/.config/rofi/wallpaper-select.rasi)

# Get full path
WALLPAPER_PATH="$WALLPAPER"

echo "Selected wallpaper path: $WALLPAPER_PATH"

#make syslink
"$SYS_SCRIPT" "$WALLPAPER_PATH"

# Call  custom wallpaper script (swww)
"$WALLPAPER_SCRIPT" "$WALLPAPER_PATH"

sleep 3

# Generate colors with wal (pywal)
wal -i "$WALLPAPER_PATH"
# pywal-spicetify "$SPICETIFY_THEME"

eww reload
echo "Wallpaper set to $WALLPAPER_PATH"
