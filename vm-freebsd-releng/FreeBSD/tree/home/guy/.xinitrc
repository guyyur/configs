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

xrandr --newmode "1024x640_60.00"  52.83  1024 1072 1176 1328  640 641 644 663  -HSync +Vsync
xrandr --addmode VGA-0 "1024x640_60.00"
xrandr --newmode "1280x720_60.00"  74.48  1280 1336 1472 1664  720 721 724 746  -HSync +Vsync
xrandr --addmode VGA-0 "1280x720_60.00"
xrandr --newmode "1280x800_60.00"  83.46  1280 1344 1480 1680  800 801 804 828  -HSync +Vsync
xrandr --addmode VGA-0 "1280x800_60.00"

xrandr --output VGA-0 --mode "1280x800_60.00"

compton -CGb --config=/dev/null

if [ -e "$XDG_CONFIG_HOME"/wallpaper.jpg ]; then
  hsetroot -full "$XDG_CONFIG_HOME"/wallpaper.jpg
else
  hsetroot -solid "#202020"
fi

tint2 &
/usr/local/libexec/openbox-xdg-autostart OPENBOX

exec openbox
