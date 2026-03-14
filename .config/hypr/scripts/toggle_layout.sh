#!/usr/bin/env bash

FILE="$HOME/.config/hypr/hyprland_conf/lookfeel.conf"

if grep -q "layout *= *scrolling" "$FILE"; then
  sed -i 's/layout *= *scrolling/layout = dwindle/' "$FILE"
  notify-send "Switched layout to dwindle"
else
  sed -i 's/layout *= *dwindle/layout = scrolling/' "$FILE"
  notify-send "Switched layout to scrolling"
fi

hyprctl reload
