#!/usr/bin/env bash

check_install() {
     if [[ ! $(type $1 2>/dev/null) ]]; then
          echo "Error: missing command '$1'. Exiting."
          exit 1
     fi
}

check_install xdo
check_install xprop

for bar in $(xdo id -N 'Polybar'); do
     if xprop -id $bar | grep "polybar-tray"; then
          if xprop -id $bar | grep "Normal"; then
               xdo hide $bar
          elif xprop -id $bar | grep "Withdrawn"; then
               kill $(xdo pid "$bar")
               for output in $(xrandr -q | grep " connected primary" | cut -d ' ' -f1); do
                    MONITOR=$output polybar tray &
               done
          fi
     fi
done
