#!/bin/bash
set -x
WALLPAPER_DIR="$HOME/.config/Wallpapers/images"
THUMB_DIR="$HOME/.config/Wallpapers/thumbnails"
VIDEO_DIR="$HOME/.config/Wallpapers/vids"
SCRIPT_DIR="$HOME/.config/Wallpapers/Scripts"
WALLPAPER_SCRIPT="$HOME/.config/Wallpapers/Scripts/wallpaper.sh"
SYS_SCRIPT="$HOME/.config/Wallpapers/Scripts/currentWal.sh"
EWW_SCRIPT="$HOME/.config/hypr/scripts/toggle_bar.sh"
SPICETIFY_THEME="Dribbblish"

# Ensure wallpaper directory exists
mkdir -p "$WALLPAPER_DIR"

#Toggle bar
eww close fakecorner-box-1
eww close fakecorner-box-2
eww close fakecorner-box-3
eww close bar
hyprctl keyword general:gaps_out 4

# "$BARS_SCRIPT"
WALLPAPER=$(
  find "$WALLPAPER_DIR" -type f \
    \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) |
    while IFS= read -r img_path; do

      rel_path="${img_path#$WALLPAPER_DIR/}"
      thumb="$THUMB_DIR/$rel_path"

      if [[ -f "$thumb" ]]; then
        icon="$thumb"
      else
        icon="$img_path"
      fi

      printf '%s\0icon\x1f%s\n' "$img_path" "$icon"

    done |
    rofi -dmenu -show-icons \
      -theme ~/.config/rofi/wallpaper-select.rasi
)

[[ -z "$WALLPAPER" ]] && exit 0
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
pywal-spicetify "$SPICETIFY_THEME"
themecord -p

eww open bar
eww open fakecorner-box-1
eww open fakecorner-box-2
eww open fakecorner-box-3
hyprctl reload
eww reload

echo "Wallpaper set to $WALLPAPER_PATH"
