#!/bin/bash

# checking if device even has a backlight setting
if [[ $(find /sys/class/backlight/* 2>/dev/null) ]]; then
     echo -e "$(xbacklight -get)"
fi
