#!/usr/bin/env bash

bar=$(eww active-windows | grep -c "bar")
fake1=$(eww active-windows | grep -c "fakecorner-box-1")
fake2=$(eww active-windows | grep -c "fakecorner-box-2")
fake3=$(eww active-windows | grep -c "fakecorner-box-3")

# both closed
if [ "$bar" -eq 0 ] && [ "$fake1" -eq 0 ]; then
  eww open bar
  eww open fakecorner-box-1
  eww open fakecorner-box-2
  eww open fakecorner-box-3
  hyprctl reload
# both open
elif [ "$bar" -eq 1 ] && [ "$fake1" -eq 1 ]; then
  eww close fakecorner-box-1
  eww close fakecorner-box-2
  eww close fakecorner-box-3
  eww close bar
  hyprctl keyword general:gaps_out 4
# mixed state → just toggle both
else
  eww close fakecorner-box-1
  eww close fakecorner-box-2
  eww close fakecorner-box-3
  eww close bar
  hyprctl keyword general:gaps_out 4
fi
