#!/usr/bin/sh

#
. ~/.xprofile


#
setxkbmap -option grp:alt_shift_toggle,caps:shift us,il

xrandr --newmode "1024x640_60.00"  52.83  1024 1072 1176 1328  640 641 644 663  -HSync +Vsync
xrandr --addmode VGA-0 "1024x640_60.00"
xrandr --newmode "1024x768_60.00"  64.11  1024 1080 1184 1344  768 769 772 795  -HSync +Vsync
xrandr --addmode VGA-0 "1024x768_60.00"
xrandr --newmode "1280x720_60.00"  74.48  1280 1336 1472 1664  720 721 724 746  -HSync +Vsync
xrandr --addmode VGA-0 "1280x720_60.00"
xrandr --newmode "1280x800_60.00"  83.46  1280 1344 1480 1680  800 801 804 828  -HSync +Vsync
xrandr --addmode VGA-0 "1280x800_60.00"

xrandr --output VGA-0 --mode "1024x640_60.00"

compton -CGb --config=/dev/null
hsetroot -solid "#202020"

tint2 &
/usr/lib/openbox/openbox-xdg-autostart OPENBOX

exec openbox
