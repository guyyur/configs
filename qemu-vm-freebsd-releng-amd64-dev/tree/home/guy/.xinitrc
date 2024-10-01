#!/bin/sh

# dbus sessions
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
  exec dbus-run-session -- ~/.xinitrc
fi


#
. ~/.xprofile
xrdb -merge "$HOME/.Xresources"


#
setxkbmap -layout ${XKB_DEFAULT_LAYOUT} -option ${XKB_DEFAULT_OPTIONS}

xrandr --output default --mode 1600x900

sh $XDG_CONFIG_HOME/openbox/autostart
exec openbox
