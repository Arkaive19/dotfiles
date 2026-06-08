#!/usr/bin/env bash

set -e

case "$1" in
ss)
  mkdir -p ~/Pictures/Screenshot

  TMP_FILE="/tmp/screenshot-$(date +%s).png"

  # Disable animations only for capture
  hyprctl keyword animations:enabled 0

  grimblast --freeze save area "$TMP_FILE"

  # Re-enable immediately after capture
  hyprctl keyword animations:enabled 1

  # Open swappy separately
  swappy -f "$TMP_FILE" \
    -o ~/Pictures/Screenshot/$(date +%F-%H-%M-%S).png

  rm -f "$TMP_FILE"
  ;;

vid)
  kooha
  ;;

*)
  notify-send "Capture Script" "Usage: $0 {ss|vid}"
  exit 1
  ;;
esac
