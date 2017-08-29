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

# screenshot filename
tmp_image=/tmp/scrot_imgur.$USER.$$.png

check_install() {
     if [[ ! $(type $1 2>/dev/null) ]]; then
          echo "Error: missing command '$1'. Exiting."
          notify-send 'Screenshot' "Error uploading. Missing command $1."
          exit 1
     fi
}

imgur_upload() {
     response=$(curl -sH "Authorization: Client-ID 1923eac1555838e" -F "image=@$1" "https://api.imgur.com/3/upload")
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
     scrot -s -z "$tmp_image"
     imgur_upload "$tmp_image"
}

grab_window() {
     scrot -u -z "$tmp_image"
     imgur_upload "$tmp_image"
}

grab_all() {
     scrot -z "$tmp_image"
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
check_install "scrot"
check_install "curl"
check_install "xclip"

# starting rofi in dmenu mode
select_option "$(printf "%s\n" "${options[@]}" | rofi -dmenu \
     -i \
     -p "> " \
     -width 174 \
     -lines 3 \
     -padding 20 \
     -borderwidth 3 \
     -hide-scrollbar \
     -font "$font $font_size" \
     -color-normal  "$colour00,    $colour05,     $colour00,     $colour0D,     $colour00" \
     -color-active  "$colour00,    $colour05,     $colour00,     $colour0D,     $colour00" \
     -color-urgent  "$colour08,    $colour00,     $colour08,     $colour0D,     $colour00" \
     -color-window  "$colour00,    $colour0D,     $colour00")"
