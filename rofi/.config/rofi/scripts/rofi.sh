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

# starting rofi
rofi -combi-modi run,drun -show combi -modi combi \
     -width 30 \
     -lines 10 \
     -padding 40 \
     -borderwidth 6 \
     -hide-scrollbar \
     -font "$font $(($font_size * 2))" \
     -color-normal  "$colour00,    $colour05,     $colour00,     $colour0D,     $colour00" \
     -color-active  "$colour00,    $colour05,     $colour00,     $colour0D,     $colour00" \
     -color-urgent  "$colour08,    $colour00,     $colour08,     $colour0D,     $colour00" \
     -color-window  "$colour00,    $colour0D,     $colour00"
