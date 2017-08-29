#!/bin/bash

# output the current active window name, truncate it to 30 characters, and add an elipsis to the end if it's too long or print blank line if no active window found
if [[ $(xdotool getactivewindow 2>/dev/null) ]]; then
     xdotool getactivewindow getwindowname | sed -e 's/\(.*\)/\L\1/' | awk -v len=33 '{ if (length($0) > len) print substr($0, 1, len-3) "..."; else print; }'
else
     echo ""
fi
