#!/usr/bin/env bash

set -euo pipefail

WALLPAPER_DIR="$HOME/.config/Wallpapers/images"
THUMB_DIR="$HOME/.config/Wallpapers/thumbnails"

mkdir -p "$THUMB_DIR"

find "$WALLPAPER_DIR" -type f \
  \( -iname "*.jpg" \
  -o -iname "*.jpeg" \
  -o -iname "*.png" \
  -o -iname "*.webp" \) |
  while IFS= read -r img; do
    rel_path="${img#$WALLPAPER_DIR/}"
    thumb="$THUMB_DIR/$rel_path"

    mkdir -p "$(dirname "$thumb")"

    # Skip if thumbnail exists and is newer than the source
    if [[ -f "$thumb" && "$thumb" -nt "$img" ]]; then
      continue
    fi

    echo "Generating: $rel_path"

    magick "$img" \
      -auto-orient \
      -thumbnail 900x1200^ \
      -gravity center \
      -extent 900x1200 \
      -strip \
      "$thumb"
  done

echo "Thumbnail generation complete."
