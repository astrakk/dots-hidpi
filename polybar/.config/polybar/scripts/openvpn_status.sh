#!/bin/bash

if pgrep -x openvpn >/dev/null; then
     echo '%{u'$secured' +u}  secured  %{-u}'
else
     echo '%{u'$unsecured' +u}  unsecured  %{-u}'
fi
