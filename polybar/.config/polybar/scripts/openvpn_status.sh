#!/usr/bin/env bash

if ps -fC "openvpn" >/dev/null; then
     echo '%{u'$s_ul' +u}%{B'$s_bg'}  secured  %{B-}%{-u}'
else
     echo '%{u'$u_ul' +u}%{B'$u_bg'}  unsecured  %{B-}%{-u}'
fi
