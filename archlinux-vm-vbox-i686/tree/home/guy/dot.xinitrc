#!/usr/bin/sh

# dbus session
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
  exec dbus-run-session -- ~/.xinitrc
fi


#
. ~/.xprofile


#
setxkbmap -option grp:alt_shift_toggle,caps:shift us,il
xsetroot -solid "#202020"
tint2 &
/usr/lib/openbox/openbox-xdg-autostart OPENBOX

exec openbox
