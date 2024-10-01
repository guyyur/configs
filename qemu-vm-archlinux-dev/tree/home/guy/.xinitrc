#!/bin/sh

#
. ~/.xprofile
xrdb -merge "$HOME/.Xresources"


#
dbus-update-activation-environment --systemd DISPLAY XAUTHORITY


#
setxkbmap -layout ${XKB_DEFAULT_LAYOUT} -option ${XKB_DEFAULT_OPTIONS}

sh $XDG_CONFIG_HOME/openbox/autostart
exec openbox
