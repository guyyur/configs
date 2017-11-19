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
cd /usr/ports/net/dhcpcd && make $target || exit 1
cd /usr/ports/editors/hexedit && make $target || exit 1
cd /usr/ports/sysutils/cdrtools && make $target || exit 1
cd /usr/ports/archivers/unrar && make $target || exit 1
cd /usr/ports/archivers/p7zip && make $target || exit 1
cd /usr/ports/sysutils/dmidecode && make $target || exit 1
cd /usr/ports/sysutils/smartmontools && make $target || exit 1
cd /usr/ports/lang/python3 && make $target || exit 1
cd /usr/ports/ftp/curl && make $target || exit 1
cd /usr/ports/ftp/wget && make $target || exit 1
cd /usr/ports/dns/dnsmasq && make $target || exit 1
cd /usr/ports/net/samba46 && make $target || exit 1
cd /usr/ports/net/mpd5 && make $target || exit 1
cd /usr/ports/net/dhcp6 && make $target || exit 1
cd /usr/ports/security/openvpn && make $target || exit 1
cd /usr/ports/devel/subversion && make $target || exit 1
cd /usr/ports/devel/git && make $target || exit 1
cd /usr/ports/devel/mercurial && make $target || exit 1
cd /usr/ports/www/thttpd && make $target || exit 1
cd /usr/ports/devel/cscope && make $target || exit 1
cd /usr/ports/devel/gdb && make $target || exit 1
cd /usr/ports/textproc/aspell && make $target || exit 1
cd /usr/ports/textproc/en-aspell && make $target || exit 1
cd /usr/ports/hebrew/aspell && make $target || exit 1
cd /usr/ports/www/youtube_dl && make $target || exit 1
cd /usr/ports/benchmarks/iperf && make $target || exit 1
cd /usr/ports/www/tidy-devel && make $target || exit 1
cd /usr/ports/graphics/p5-Image-ExifTool && make $target || exit 1
cd /usr/ports/audio/cdparanoia && make $target || exit 1
cd /usr/ports/local/dtb && make $target || exit 1
cd /usr/ports/sysutils/u-boot-beaglebone && make $target || exit 1
cd /usr/ports/sysutils/u-boot-cubieboard && make $target || exit 1
cd /usr/ports/sysutils/u-boot-nanopi-neo && make $target || exit 1
cd /usr/ports/sysutils/u-boot-orangepi-one && make $target || exit 1
cd /usr/ports/local/u-boot-orangepi-pc && make $target || exit 1
cd /usr/ports/local/sunxi-tools && make $target || exit 1
cd /usr/ports/print/freetype2 && make $target || exit 1
cd /usr/ports/x11-fonts/fontconfig && make $target || exit 1
cd /usr/ports/audio/flac && make $target || exit 1
cd /usr/ports/audio/lame && make $target || exit 1
cd /usr/ports/multimedia/ffmpeg && make $target || exit 1
cd /usr/ports/devel/dbus && make $target || exit 1
cd /usr/ports/sysutils/consolekit2 && make $target || exit 1
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
cd /usr/ports/x11-drivers/xf86-video-ati && make $target || exit 1
cd /usr/ports/x11-wm/compton && make $target || exit 1
cd /usr/ports/x11-fonts/croscorefonts-fonts-ttf && make $target || exit 1
cd /usr/ports/x11-fonts/crosextrafonts-caladea-ttf && make $target || exit 1
cd /usr/ports/x11-fonts/crosextrafonts-carlito-ttf && make $target || exit 1
cd /usr/ports/x11-fonts/sourcecodepro-ttf && make $target || exit 1
cd /usr/ports/x11-fonts/liberation-fonts-ttf && make $target || exit 1
cd /usr/ports/hebrew/culmus && make $target || exit 1
cd /usr/ports/x11-fonts/junicode && make $target || exit 1
cd /usr/ports/x11/xsetroot && make $target || exit 1
cd /usr/ports/x11/hsetroot && make $target || exit 1
cd /usr/ports/x11/slock && make $target || exit 1
cd /usr/ports/accessibility/atk && make $target || exit 1
cd /usr/ports/x11-toolkits/gtk20 && make $target || exit 1
cd /usr/ports/x11-themes/adwaita-icon-theme && make $target || exit 1
cd /usr/ports/x11-toolkits/gtk30 && make $target || exit 1
cd /usr/ports/x11-themes/gtk-engines2 && make $target || exit 1
cd /usr/ports/devel/qt5-core && make $target || exit 1
cd /usr/ports/x11-toolkits/qt5-widgets && make $target || exit 1
cd /usr/ports/x11-themes/clearlooks-phenix-theme && make $target || exit 1
cd /usr/ports/emulators/virtualbox-ose-additions && make $target || exit 1
cd /usr/ports/devel/py-xdg && make $target || exit 1
cd /usr/ports/x11-wm/openbox && make $target || exit 1
cd /usr/ports/x11-themes/openbox-themes && make $target || exit 1
cd /usr/ports/x11-wm/obconf && make $target || exit 1
cd /usr/ports/x11/tint && make $target || exit 1
cd /usr/ports/deskutils/gsimplecal && make $target || exit 1
cd /usr/ports/x11/terminator && make $target || exit 1
cd /usr/ports/x11/gmrun && make $target || exit 1
cd /usr/ports/x11-fm/pcmanfm-qt && make $target || exit 1
cd /usr/ports/editors/leafpad && make $target || exit 1
cd /usr/ports/x11-themes/lxappearance && make $target || exit 1
cd /usr/ports/x11/lxrandr && make $target || exit 1
cd /usr/ports/deskutils/parcellite && make $target || exit 1
cd /usr/ports/sysutils/lxtask && make $target || exit 1
cd /usr/ports/textproc/meld && make $target || exit 1
cd /usr/ports/graphics/scrot && make $target || exit 1
cd /usr/ports/www/firefox && make $target || exit 1
cd /usr/ports/www/xpi-flashblock && make $target || exit 1
cd /usr/ports/www/qupzilla-qt5 && make $target || exit 1
cd /usr/ports/mail/thunderbird && make $target || exit 1
cd /usr/ports/math/galculator && make $target || exit 1
cd /usr/ports/devel/geany && make $target || exit 1
cd /usr/ports/graphics/epdfview && make $target || exit 1
cd /usr/ports/graphics/gpicview && make $target || exit 1
cd /usr/ports/multimedia/smplayer && make $target || exit 1
cd /usr/ports/multimedia/qmmp-qt5 && make $target || exit 1
cd /usr/ports/multimedia/mediainfo && make $target || exit 1
cd /usr/ports/graphics/gimp && make $target || exit 1
cd /usr/ports/graphics/rawtherapee && make $target || exit 1
cd /usr/ports/graphics/inkscape && make $target || exit 1
cd /usr/ports/audio/audacity && make $target || exit 1
cd /usr/ports/multimedia/avidemux && make $target || exit 1
cd /usr/ports/print/fontforge && make $target || exit 1
cd /usr/ports/graphics/blender && make $target || exit 1
cd /usr/ports/editors/libreoffice && make $target || exit 1
cd /usr/ports/net/wireshark-qt5 && make $target || exit 1
cd /usr/ports/emulators/qemu && make $target || exit 1
cd /usr/ports/deskutils/virt-manager && make $target || exit 1
cd /usr/ports/emulators/dosbox && make $target || exit 1

pkg_repo_path=$(cd /usr/ports && make -V PACKAGES)
[ -z "$pkg_repo_path" ] && { echo "PACKAGES var is empty" 1>&2; exit 1; }
mkdir -p ${pkg_repo_path} || exit 1
mkdir ${pkg_repo_path}/All || exit 1
mkdir ${pkg_repo_path}/Latest || exit 1
(cd ${pkg_repo_path}/All && pkg create -a) || exit 1
(cd ${pkg_repo_path}/Latest && ln -sf ../All/pkg-*.txz pkg.txz) || exit 1
pkg repo ${pkg_repo_path}
