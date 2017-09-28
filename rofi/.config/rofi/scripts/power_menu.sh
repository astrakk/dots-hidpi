#!/bin/bash

# sourcing the universal config if it exists
if [ -f ~/.universal.conf ]; then
     source ~/.universal.conf
else
     font=Arial
     font_size=12
     colour00=#000000
     colour05=#666666
     colour08=#ff0000
     colour0D=#0000ff
fi

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
     -lines 3 \
     -padding 40 \
     -borderwidth 6 \
     -hide-scrollbar \
     -font "$font $(($font_size * 2))" \
     -color-normal  "$colour00,    $colour05,     $colour00,     $colour0D,     $colour00" \
     -color-active  "$colour00,    $colour05,     $colour00,     $colour0D,     $colour00" \
     -color-urgent  "$colour08,    $colour00,     $colour08,     $colour0D,     $colour00" \
     -color-window  "$colour00,    $colour0D,     $colour00")"
