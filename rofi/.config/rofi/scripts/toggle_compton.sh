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

# the config file that compton will be using (should I move this to the universal config?)
compton_config=~/.config/compton/config

# display different options depending on whether compton is running or not
if [[ $(pgrep -u $(whoami) -x "compton" 2>/dev/null) ]]; then
     options=( '1: Stop compton' '2: Restart compton' )
     rofi_width=156
     rofi_lines=2
else
     options=( '1: Start compton' )
     rofi_width=144
     rofi_lines=1
fi

select_option() {
     case $1 in
          '1: Start compton' )
               if [[ $compton_config ]]; then
                    compton --config $compton_config
               else
                    compton
               fi
               ;;
          '1: Stop compton' )
               killall -u $(whoami) -q compton
               ;;
          '2: Restart compton' )
               killall -u $(whoami) -q compton

               while pgrep -u $(whoami) -x compton; do
                    sleep 1;
               done

               if [[ $compton_config ]]; then
                    compton --config $compton_config
               else
                    compton
               fi
               ;;
     esac
}


# starting rofi in dmenu mode
select_option "$(printf "%s\n" "${options[@]}" | rofi -dmenu \
     -i \
     -p "> " \
     -width $rofi_width \
     -lines $rofi_lines \
     -padding 20 \
     -borderwidth 3 \
     -hide-scrollbar \
     -font "$font $font_size" \
     -color-normal  "$colour00,    $colour05,     $colour00,     $colour0D,     $colour00" \
     -color-active  "$colour00,    $colour05,     $colour00,     $colour0D,     $colour00" \
     -color-urgent  "$colour08,    $colour00,     $colour08,     $colour0D,     $colour00" \
     -color-window  "$colour00,    $colour0D,     $colour00")"
