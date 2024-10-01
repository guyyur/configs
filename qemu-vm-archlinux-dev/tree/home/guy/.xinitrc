#!/bin/sh

#
. ~/.xprofile
xrdb -merge "$HOME/.Xresources"


#
setxkbmap -layout ${XKB_DEFAULT_LAYOUT} -option ${XKB_DEFAULT_OPTIONS}

xrandr --output Virtual-1 --mode 1440x900

picom -CGb

if [ -e "$XDG_CONFIG_HOME"/wallpaper.jpg ]; then
  hsetroot -full "$XDG_CONFIG_HOME"/wallpaper.jpg
else
  hsetroot -solid "#202020"
fi

tint2 &
/usr/lib/openbox/openbox-xdg-autostart OPENBOX

exec openbox
