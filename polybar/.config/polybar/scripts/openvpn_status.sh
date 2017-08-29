#!/bin/bash

# sourcing the universal config if it exists
if [ -f ~/.universal.conf ]; then
     source ~/.universal.conf
else
     colour0D=#0000ff
     colour08=#ff0000
fi

if [[ $(ip addr show dev tun0 2>/dev/null) ]]; then
     echo '%{u'$colour0D' +u}  secured  %{-u}'
else
     echo '%{u'$colour08' +u}  unsecured  %{-u}'
fi
