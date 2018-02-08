#!/usr/bin/env bash

options=( '1: Sign out' '2: Shutdown' '3: Reboot' )

select_option() {
     case $1 in
          '1: Sign out' )
               i3-msg "exit"
               ;;
          '2: Shutdown' )
               sudo poweroff
               ;;
          '3: Reboot' )
               sudo reboot
               ;;
     esac
}


# starting rofi in dmenu mode
select_option "$(printf "%s\n" "${options[@]}" | rofi -dmenu \
     -i \
     -p "> " \
     -width 226 \
     -lines 3)"
