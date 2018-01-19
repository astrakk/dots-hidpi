#!/usr/bin/env bash

list_choices_passwords() {
     cd ~/.password-store
     find -L . -iname '*.gpg' -printf '%P\n' | sort -n | \ 
          while read -r filename; do
               printf '%s\n' "${filename%.gpg}"
          done
}

get_selection_passwords() {
     echo -ne "$(list_choices_passwords | rofi -dmenu \
          -i \
          -p "> ")"
}

password_file=$(get_selection_passwords)
[ -z "$password_file" ] && exit 1

retrieve_password() {
     echo -n "$password" | xclip -sel "clip"
}

retrieve_username() {
     echo -n "$username" | xclip -sel "clip"
}

retrieve_url() {
     echo -n "$url" | xclip -sel "clip"
}

retrieve_otp() {
     oathtool --base32 --totp "$otp" | xclip -sel "clip"
}

get_selection_options() {
     case $1 in
          *password )
               retrieve_password
               ;;  
          *username )
               retrieve_username
               ;;  
          *URL )
               retrieve_url
               ;;  
          *OTP )
               retrieve_otp
               ;;  
     esac
}

list_choices_options() {
     contents=$(pass show "$password_file")

     password=$(echo -n "$contents" | sed -n '1p')
     username=$(echo -n "$contents" | sed -n -e '/^user: /p' | sed 's/^user: //')
     url=$(echo -n "$contents" | sed -n -e '/^url: /p' | sed 's/^url: //')
     otp=$(echo -n "$contents" | sed -n -e '/^otpauth:\/\//p' | grep -o '\?secret=[0-9a-Z]*' | sed 's/\?secret=//')

     options=()
     index=0
     [ ! -z "$password" ] && ((index=index+1)) && options+=("$index: Copy password")
     [ ! -z "$username" ] && ((index=index+1)) && options+=("$index: Copy username")
     [ ! -z "$url" ] && ((index=index+1)) && options+=("$index: Copy URL")
     [ ! -z "$otp" ] && ((index=index+1)) && options+=("$index: Copy OTP")

     get_selection_options "$(printf "%s\n" "${options[@]}" | rofi -dmenu \
          -i \
          -p "> " \
          -width 286 \
          -lines $index)"
}

list_choices_options
