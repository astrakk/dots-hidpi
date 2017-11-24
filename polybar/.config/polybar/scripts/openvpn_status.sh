#!/bin/bash

if pgrep -x openvpn >/dev/null; then
     echo '%{u'$s_ul' +u}%{B'$s_bg'}  secured  %{B-}%{-u}'
else
     echo '%{u'$u_ul' +u}%{B'$u_bg'}  unsecured  %{B-}%{-u}'
fi
