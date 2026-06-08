#!/usr/bin/env bash

set -e

cleanup() {
  hyprctl keyword animations:enabled 1
}

trap cleanup EXIT

# Disable animations
hyprctl keyword animations:enabled 0

case "$1" in
ss)
  mkdir -p ~/Pictures
  grimblast copysave area ~/Pictures/screenshot-$(date +%F-%H-%M-%S).png
  ;;

vid)
  mkdir -p ~/Videos
  wf-recorder \
    -f ~/Videos/recording-$(date +%F-%H-%M-%S).mp4 \
    -g "$(slurp)"
  ;;

*)
  echo "Usage: $0 {ss|vid}"
  exit 1
  ;;
esac
