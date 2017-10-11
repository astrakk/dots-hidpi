#!/bin/bash

options=( '1: qutebrowser' '2: firefox' '3: chromium' )

select_option() {
     case $1 in
          '1: qutebrowser' )
               QT_SCREEN_SCALE_FACTORS=1 qutebrowser
               ;;
          '2: firefox' )
               firefox
               ;;
          '3: chromium' )
               chromium
               ;;
     esac
}


# starting rofi in dmenu mode
select_option "$(printf "%s\n" "${options[@]}" | rofi -dmenu \
     -i \
     -p "> " \
     -width 262 \
     -lines 3)"
