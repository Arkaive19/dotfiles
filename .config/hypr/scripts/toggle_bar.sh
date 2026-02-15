#!/usr/bin/env bash

bar=$(eww active-windows | grep -c "bar")
fake=$(eww active-windows | grep -c "fakecorner")

# both closed
if [ "$bar" -eq 0 ] && [ "$fake" -eq 0 ]; then
  eww open bar
  eww open fakecorner

# both open
elif [ "$bar" -eq 1 ] && [ "$fake" -eq 1 ]; then
  eww close fakecorner
  eww close bar

# mixed state → just toggle both
else
  eww close bar
  eww close fakecorner
fi
