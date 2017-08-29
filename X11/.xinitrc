# Configure display (xrandr script specified here if necessary)
~/.screenlayout/screenlayout.sh
xrandr --auto
xrandr --dpi 96

# Export variables
export TERMINAL=urxvt
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_STYLE_OVERRIDE=gtk2

# Build configs before launching WM
dots-variables ~/.config/i3/template ~/.config/i3/config
dots-variables ~/.config/polybar/template ~/.config/polybar/config
dots-variables ~/.config/Xresources/template ~/.Xresources
dots-variables ~/.config/dunst/template ~/.config/dunst/config

# Merge .Xresources
xrdb -merge ~/.Xresources

# Prepare keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets)

# Start polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Start WM
exec i3
