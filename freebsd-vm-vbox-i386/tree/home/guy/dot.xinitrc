#!/bin/sh

# consolekit and dbus sessions
if [ -z "$CK_LAUNCH_SESSION_RUNNING" ]; then
  export CK_LAUNCH_SESSION_RUNNING=1
  exec ck-launch-session ~/.xinitrc
fi

if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
  exec dbus-run-session -- ~/.xinitrc
fi


#
. ~/.xprofile


#
setxkbmap -option grp:alt_shift_toggle,caps:shift us,il
xsetroot -solid "#202020"
tint2 &
/usr/local/libexec/openbox-xdg-autostart OPENBOX

exec openbox
