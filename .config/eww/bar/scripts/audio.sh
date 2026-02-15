#!/usr/bin/env bash

case "$1" in
"symbol")
  # Get the default audio sink
  default_sink=$(pactl list sinks | grep "Active Port" | awk -F': ' '{print $2}')

  # Check if the default sink is a headphone device
  if [[ "$default_sink" == *"analog-output-headphones"* ]]; then
    echo "" # Headphones icon
  else
    echo "" # Speakers or volume icon
  fi
  ;;
esac
