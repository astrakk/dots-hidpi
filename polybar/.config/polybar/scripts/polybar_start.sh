#!/usr/bin/env bash

# kill all polybar instances for the current user
killall -u $(whoami) -q polybar

# wait till they're all killed...
while pgrep -u $(whoami) -x polybar >/dev/null; do 
     sleep 1; 
done

# launch the bar with system tray on primary monitor
for output in $(xrandr -q | grep " connected primary" | cut -d ' ' -f1); do
     MONITOR=$output polybar primary &
     MONITOR=$output polybar tray &
done

# launch the bar without system tray on each non-primary monitor
for output in $(xrandr -q | grep -v " connected primary" | grep " connected" | cut -d ' ' -f1); do
     MONITOR=$output polybar primary &
done
