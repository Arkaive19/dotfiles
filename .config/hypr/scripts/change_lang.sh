#!/usr/bin/env bash

# Toggle input method
fcitx5-remote -t

# Get current input method
current=$(fcitx5-remote -n)

# Notify
notify-send "Language switched to: $current"
