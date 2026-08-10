#!/usr/bin/env bash

mkdir -p ~/Pictures/Screenshot

case "$1" in
ss)
  TMP_FILE="/tmp/screenshot-$(date +%s).png"

  # Correct runtime syntax for Lua framework
  hyprctl eval 'hl.config({ animations = { enabled = false } })'

  # Freeze and capture selection
  if grimblast --freeze save area "$TMP_FILE"; then
    # Force animations back on manually before launching Swappy
    hyprctl eval 'hl.config({ animations = { enabled = true } })'
    # Open editing tool
    swappy -f "$TMP_FILE" -o ~/Pictures/Screenshot/$(date +%F-%H-%M-%S).png
  fi

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
