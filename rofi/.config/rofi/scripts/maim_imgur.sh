#!/bin/bash

# screenshot filename
tmp_image=/tmp/maim_imgur.$USER.$$.png

check_install() {
     if [[ ! $(type $1 2>/dev/null) ]]; then
          echo "Error: missing command '$1'. Exiting."
          notify-send 'Screenshot' "Error uploading. Missing command $1."
          exit 1
     fi  
}

imgur_upload() {
     response=$(curl -sH "Authorization: Client-ID 9cabcfc7ca9e0a2" -F "image=@$1" "https://api.imgur.com/3/upload")
     url=""

     # get the imgur link and copy it to clipboard
     grep -qo '"status":200' <<< "$response" && url=$(sed -e 's/.*\"'link'\":"\([^"]*\).*/\1/' <<< "$response" | sed -e 's/\\//g')
     if [ -z "$url" ]; then
          notify-send 'Screenshot' 'Error uploading.'
          echo "Error uploading to Imgur. Invalid response received."
     else
          echo -n "$url" | xclip -sel "clip"
          notify-send 'Screenshot' 'Link copied to clipboard.'
          echo "Link copied to clipboard ($url)"
     fi  

     rm "$1"
}

grab_area() {
     maim -s >"$tmp_image"
     imgur_upload "$tmp_image"
}

grab_window() {
     maim -i $(xdotool getactivewindow)>"$tmp_image"
     imgur_upload "$tmp_image"
}

grab_all() {
     maim >"$tmp_image"
     imgur_upload "$tmp_image"
}

options=( '1: Grab area' '2: Grab window' '3: Grab entire screen' )

select_option() {
     case $1 in
          '1: Grab area' )
               grab_area
               ;;  
          '2: Grab window' )
               grab_window
               ;;  
          '3: Grab entire screen' )
               grab_all
               ;;  
     esac
}

# check all required commands are available
check_install "maim"
check_install "curl"
check_install "xclip"
check_install "xdotool"

# starting rofi in dmenu mode
select_option "$(printf "%s\n" "${options[@]}" | rofi -dmenu \
     -i \
     -p "> " \
     -width 346 \
     -lines 3)"
