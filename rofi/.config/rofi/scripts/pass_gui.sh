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
     pass -c "$password_file"
}

retrieve_username() {
     pass show "$password_file" | sed -n -e '/^user: /p' | sed 's/^user: //' | xclip -sel "clip"
}

retrieve_url() {
     pass show "$password_file" | sed -n -e '/^url: /p' | sed 's/^url: //' | xclip -sel "clip"
}

get_selection_options() {
     case $1 in
          '1: Copy password' )
               retrieve_password
               ;;
          '2: Copy username' )
               retrieve_username
               ;;
          '3: Copy URL' )
               retrieve_url
               ;;
     esac
}

list_choices_options() {
     options=( '1: Copy password' '2: Copy username' '3: Copy URL' )
     
     get_selection_options "$(printf "%s\n" "${options[@]}" | rofi -dmenu \
          -i \
          -p "> " \
          -width 144 \
          -lines 3)"
}

list_choices_options
