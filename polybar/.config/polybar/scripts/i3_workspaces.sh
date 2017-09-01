#!/bin/bash

source ~/.universal.conf

workspaces_list=(1 2 3 4 5 6 7 8 9 10)
workspaces_active="$(i3-msg -t get_workspaces | jq '.[] | .num')"
workspace_focused="$(i3-msg -t get_workspaces | jq '.[] | select(.focused).num')"

for ws in ${workspaces_list[@]}; do
     if [[ $(echo "${workspace_focused}" | grep -w "$ws") ]]; then
          printf '%%{F'$colour0D'} ■ %%{F-}'
     elif [[ $(echo "${workspaces_active}" | grep -w "$ws") ]]; then
          printf '%%{F'$colour05'} ■ %%{F-}'
     else
          printf '%%{F'$colour03'} ■ %%{F-}'
     fi
done
