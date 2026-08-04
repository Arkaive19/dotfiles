#!/bin/bash

blitz_mode=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')

if [ "$blitz_mode" = 1 ]; then
  # Enable Blitz Mode 🚀

  sudo cpupower frequency-set -g performance >/dev/null

  hyprctl --batch "\
        keyword animations:enabled 0; \
        keyword decoration:drop_shadow 0; \
        keyword decoration:blur:enabled 0; \
        keyword decoration:rounding 0; \
        keyword general:gaps_in 0; \
        keyword general:gaps_out 0; \
        keyword general:border_size 1; \
        keyword general:allow_tearing 1; \
        keyword misc:disable_hyprland_logo 1; \
        keyword misc:disable_splash_rendering 1; \
        keyword decoration:inactive_opacity 1; \
        keyword decoration:active_opacity 1"
  #!/bin/bash

  blitz_mode=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')

  if [ "$blitz_mode" = 1 ]; then
    # Enable Blitz Mode
    sudo cpupower frequency-set -g performance

    hyprctl --batch "\
        keyword animations:enabled 0; \
        keyword decoration:drop_shadow 0; \
        keyword decoration:blur:enabled 0; \
        keyword decoration:rounding 0; \
        keyword general:gaps_in 0; \
        keyword general:gaps_out 0; \
        keyword general:border_size 1; \
        keyword general:allow_tearing 1; \
        keyword misc:disable_hyprland_logo 1; \
        keyword misc:disable_splash_rendering 1"

    pkill swww
    notify-send "Blitz Mode" "Enabled 🚀"
  else
    # Disable Blitz Mode
    sudo cpupower frequency-set -g powersave

    hyprctl reload
    swww-daemon &

    notify-send "Blitz Mode" "Disabled 🔋"
  fi

  # Stop wallpaper daemon
  pkill awww 2>/dev/null

  # Pause notifications and idle timer
  dunstctl set-paused true 2>/dev/null
  pkill hypridle 2>/dev/null

  notify-send "Blitz Mode" "Enabled 🚀"

else
  # Disable Blitz Mode 🔋

  sudo cpupower frequency-set -g powersave >/dev/null

  hyprctl reload

  # Restore wallpaper daemon
  pgrep awww-daemon >/dev/null || awww-daemon &

  # Restore notifications and idle
  dunstctl set-paused false 2>/dev/null
  hypridle &

  notify-send "Blitz Mode" "Disabled 🔋"
fi
