#!/usr/bin/env bash

# Dropped -e so missing/dead daemons or empty process list matches never crash the loop halfway
set -uo pipefail

STATE="$HOME/.cache/blitz-mode"

enable() {
  sudo cpupower frequency-set -g performance >/dev/null 2>&1 || true

  # Native run-time keywords using dot-notation. This bypasses the static table locking bug
  hyprctl keyword animations.enabled 0
  hyprctl keyword decoration.rounding 0
  hyprctl keyword decoration.inactive_opacity 1.0
  hyprctl keyword decoration.active_opacity 1.0
  hyprctl keyword decoration.blur.enabled false
  hyprctl keyword general.gaps_in 0
  hyprctl keyword general.gaps_out 0
  hyprctl keyword general.border_size 1
  hyprctl keyword general.allow_tearing true
  hyprctl keyword misc.disable_hyprland_logo true
  hyprctl keyword misc.disable_splash_rendering true

  # Silently handle applications without letting failures kill your shell script timeline
  pkill -x awww-daemon >/dev/null 2>&1 || true
  swaync-client -D >/dev/null 2>&1 || true
  pkill -x hypridle >/dev/null 2>&1 || true

  touch "$STATE"
  notify-send "🚀 Blitz Mode" "Enabled"
}

disable() {
  sudo cpupower frequency-set -g powersave >/dev/null 2>&1 || true

  # Cleanly resets all flat keyword alterations back to your static hyprland.lua values
  hyprctl reload

  # Open the notifications tray context back up
  swaync-client -d >/dev/null 2>&1 || true
  sleep 0.1

  # Safely check and spawn background dependencies without triggering execution halts
  if ! pgrep -x awww-daemon >/dev/null 2>&1; then
    awww-daemon &
  fi

  if ! pgrep -x hypridle >/dev/null 2>&1; then
    hypridle &
  fi

  rm -f "$STATE"
  notify-send "🔋 Blitz Mode" "Disabled"
}

mkdir -p "$(dirname "$STATE")"

if [[ -f "$STATE" ]]; then
  # Pop notification and cycle swaync toggle cleanly
  notify-send "dis" "Returning to normal settings..."
  sleep 0.05
  swaync-client >/dev/null 2>&1 || true

  disable
else
  enable
fi
