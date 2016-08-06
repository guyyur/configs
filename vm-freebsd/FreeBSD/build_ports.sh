#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "build_ports.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# target="config"
# target="config-recursive"
target="install clean"


# -- build ports --
cd /usr/ports/ports-mgmt/pkg && make $target || exit 1
cd /usr/ports/ports-mgmt/portmaster && make $target || exit 1
cd /usr/ports/editors/nano && make $target || exit 1
cd /usr/ports/shells/zsh && make $target || exit 1
cd /usr/ports/net/svnup && make $target || exit 1
cd /usr/ports/net/dhcpcd && make $target || exit 1
cd /usr/ports/editors/hexedit && make $target || exit 1
cd /usr/ports/sysutils/cdrtools && make $target || exit 1
cd /usr/ports/sysutils/dmidecode && make $target || exit 1
cd /usr/ports/lang/python3 && make $target || exit 1
cd /usr/ports/ftp/curl && make $target || exit 1
cd /usr/ports/ftp/wget && make $target || exit 1
cd /usr/ports/net/samba43 && make $target || exit 1
cd /usr/ports/textproc/aspell && make $target || exit 1
cd /usr/ports/textproc/en-aspell && make $target || exit 1
cd /usr/ports/hebrew/aspell && make $target || exit 1
cd /usr/ports/devel/mercurial && make $target || exit 1
cd /usr/ports/devel/git && make $target || exit 1
cd /usr/ports/devel/fossil && make $target || exit 1
cd /usr/ports/devel/cscope && make $target || exit 1
cd /usr/ports/devel/gdb && make $target || exit 1
cd /usr/ports/benchmarks/iperf && make $target || exit 1
cd /usr/ports/www/tidy-devel && make $target || exit 1
cd /usr/ports/graphics/p5-Image-ExifTool && make $target || exit 1
cd /usr/ports/print/freetype2 && make $target || exit 1
cd /usr/ports/x11-fonts/fontconfig && make $target || exit 1
cd /usr/ports/devel/dbus && make $target || exit 1
cd /usr/ports/sysutils/consolekit && make $target || exit 1
cd /usr/ports/x11-servers/xorg-server && make $target || exit 1
cd /usr/ports/x11-drivers/xf86-input-mouse && make $target || exit 1
cd /usr/ports/x11-drivers/xf86-input-keyboard && make $target || exit 1
cd /usr/ports/x11/xinit && make $target || exit 1
cd /usr/ports/x11/xauth && make $target || exit 1
cd /usr/ports/x11-fonts/font-alias && make $target || exit 1
cd /usr/ports/x11-fonts/font-cursor-misc && make $target || exit 1
cd /usr/ports/x11-fonts/font-misc-misc && make $target || exit 1
cd /usr/ports/x11/setxkbmap && make $target || exit 1
cd /usr/ports/x11/xclipboard && make $target || exit 1
cd /usr/ports/x11/xdpyinfo && make $target || exit 1
cd /usr/ports/x11/xdriinfo && make $target || exit 1
cd /usr/ports/x11/xev && make $target || exit 1
cd /usr/ports/x11/xhost && make $target || exit 1
# cd /usr/ports/x11/xkbcomp && make $target || exit 1
cd /usr/ports/x11/xkbevd && make $target || exit 1
cd /usr/ports/x11/xkbprint && make $target || exit 1
cd /usr/ports/x11/xkbutils && make $target || exit 1
cd /usr/ports/x11/xkill && make $target || exit 1
cd /usr/ports/x11/xmodmap && make $target || exit 1
cd /usr/ports/x11/xprop && make $target || exit 1
cd /usr/ports/x11/xsetpointer && make $target || exit 1
cd /usr/ports/x11/xrandr && make $target || exit 1
cd /usr/ports/x11/xinput && make $target || exit 1
cd /usr/ports/x11/xrdb && make $target || exit 1
cd /usr/ports/x11/xset && make $target || exit 1
cd /usr/ports/x11/xsetmode && make $target || exit 1
cd /usr/ports/x11/xvinfo && make $target || exit 1
cd /usr/ports/x11/xwininfo && make $target || exit 1
cd /usr/ports/x11/xterm && make $target || exit 1
cd /usr/ports/x11-fonts/xorg-fonts-type1 && make $target || exit 1
# cd /usr/ports/x11-fonts/dejavu && make $target || exit 1
cd /usr/ports/x11-fonts/xorg-fonts-truetype && make $target || exit 1
cd /usr/ports/x11-themes/xcursor-themes && make $target || exit 1
cd /usr/ports/x11/xorg-docs && make $target || exit 1
cd /usr/ports/x11-wm/compton && make $target || exit 1
cd /usr/ports/x11-fonts/croscorefonts-fonts-ttf && make $target || exit 1
cd /usr/ports/x11-fonts/crosextrafonts-caladea-ttf && make $target || exit 1
cd /usr/ports/x11-fonts/crosextrafonts-carlito-ttf && make $target || exit 1
cd /usr/ports/x11-fonts/sourcecodepro-ttf && make $target || exit 1
cd /usr/ports/x11-fonts/liberation-fonts-ttf && make $target || exit 1
cd /usr/ports/hebrew/culmus && make $target || exit 1
cd /usr/ports/x11-fonts/junicode && make $target || exit 1
cd /usr/ports/x11/xsetroot && make $target || exit 1
cd /usr/ports/graphics/hsetroot && make $target || exit 1
cd /usr/ports/accessibility/atk && make $target || exit 1
cd /usr/ports/x11-toolkits/gtk20 && make $target || exit 1
cd /usr/ports/x11-themes/adwaita-icon-theme && make $target || exit 1
cd /usr/ports/x11-toolkits/gtk30 && make $target || exit 1
cd /usr/ports/x11-themes/gtk-engines2 && make $target || exit 1
cd /usr/ports/x11-themes/clearlooks-phenix-theme && make $target || exit 1
cd /usr/ports/devel/py-xdg && make $target || exit 1
cd /usr/ports/x11-wm/openbox && make $target || exit 1
cd /usr/ports/x11-themes/openbox-themes && make $target || exit 1
cd /usr/ports/x11-wm/obconf && make $target || exit 1
cd /usr/ports/x11/tint && make $target || exit 1
cd /usr/ports/deskutils/gsimplecal && make $target || exit 1
cd /usr/ports/x11/gmrun && make $target || exit 1
cd /usr/ports/x11-fm/pcmanfm && make $target || exit 1
cd /usr/ports/editors/leafpad && make $target || exit 1
cd /usr/ports/x11-themes/lxappearance && make $target || exit 1
cd /usr/ports/x11/lxrandr && make $target || exit 1
cd /usr/ports/deskutils/parcellite && make $target || exit 1
cd /usr/ports/emulators/virtualbox-ose-additions && make $target || exit 1
cd /usr/ports/devel/geany && make $target || exit 1
cd /usr/ports/textproc/meld && make $target || exit 1
cd /usr/ports/local/raspberrypi-firmware-boot && make $target || exit 1
cd /usr/ports/local/odroid-c1-boot-files && make $target || exit 1
cd /usr/ports/local/u-boot && make $target || exit 1
cd /usr/ports/local/dtb && make $target || exit 1
