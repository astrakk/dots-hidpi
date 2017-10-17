#!/bin/bash

# the config file that openvpn will be using
openvpn_config=~/.config/openvpn/config.ovpn

# display different options depending on whether compton is running or not
if [[ $(pgrep -x "openvpn" 2>/dev/null) ]]; then
     options=( '1: Stop OpenVPN' )
     rofi_width=274
     rofi_lines=1
else
     options=( '1: Start OpenVPN' )
     rofi_width=286
     rofi_lines=1
fi

select_option() {
     case $1 in
          '1: Start OpenVPN' )
               pkexec openvpn $openvpn_config
               ;;
          '1: Stop OpenVPN' )
               pkexec killall -q openvpn
               ;;
     esac
}


# starting rofi in dmenu mode
select_option "$(printf "%s\n" "${options[@]}" | rofi -dmenu \
     -i \
     -p "> " \
     -width $rofi_width \
     -lines $rofi_lines)"
