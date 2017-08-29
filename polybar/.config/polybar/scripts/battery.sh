#!/bin/bash

# sourcing the universal config if it exists
if [ -f ~/.universal.conf ]; then
     source ~/.universal.conf
else
     colour0A=#ffff00
     colour0D=#0000ff
     colour08=#ff0000
fi

# checking if the device has a battery connected, exiting if not
if [[ ! $(ls /sys/class/power_supply/BAT* 2>/dev/null) ]]; then
     exit 1
fi

if [[ ! $(ls /sys/class/power_supply/AC* 2>/dev/null) ]]; then
     exit 1
fi

batt_list=$(find /sys/class/power_supply/ -name "BAT*")
ac_list=$(find /sys/class/power_supply/ -name "AC*")

batt=(${batt_list[@]})
ac=(${ac_list[@]})

# getting the maximum and current battery values
max=$(cat ${batt[0]}/energy_full)
now=$(cat ${batt[0]}/energy_now)

# checking if the power supply is connected
case $(cat ${ac[0]}/online) in
     1)
          pwr=$colour0A
          ;;
     *)
          pwr=$colour0D
          if [[ $((100*$now/$max)) -le 15 ]]; then
               pwr=$colour08
          fi
          ;;
esac
echo -e "%{u$pwr +u}  $((100*$now/$max))%  %{-u}"
