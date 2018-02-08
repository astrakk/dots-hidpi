#!/usr/bin/env bash

# kill all polybar instances for the current user
killall -u $(whoami) -q dunst

# wait till they're all killed...
while pgrep -u $(whoami) -x dunst >/dev/null; do 
     sleep 1; 
done

# launch dunst
dunst -config ~/.config/dunst/config &
