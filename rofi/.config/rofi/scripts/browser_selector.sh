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
     -lines 3 \
     -padding 40 \
     -borderwidth 6 \
     -hide-scrollbar \
     -font "$font $(($font_size * 2))" \
     -color-normal  "$colour00,    $colour05,     $colour00,     $colour0D,     $colour00" \
     -color-active  "$colour00,    $colour05,     $colour00,     $colour0D,     $colour00" \
     -color-urgent  "$colour08,    $colour00,     $colour08,     $colour0D,     $colour00" \
     -color-window  "$colour00,    $colour0D,     $colour00")"
