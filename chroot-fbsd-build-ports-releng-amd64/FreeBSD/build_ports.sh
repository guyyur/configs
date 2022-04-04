#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
  echo "build_ports.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# target="config-conditional"
# target="config-recursive"
target="install clean"
overlays=$(cd /usr/ports && make -V OVERLAYS)


build_port()
{
  local port_dir
  for d in $overlays /usr/ports; do
    port_dir="$d/$1"
    if [ -d "$port_dir" ]; then
      cd "$port_dir" && make $target || exit 1
      return
    fi
  done
  exit 1
}


# -- build ports --
build_port ports-mgmt/pkg
build_port ports-mgmt/portmaster
build_port security/ca_root_nss
build_port editors/nano
build_port shells/zsh
build_port ftp/curl
build_port lang/python3
build_port sysutils/tmux
build_port sysutils/juexec
build_port net/dhcpcd
build_port security/doas
build_port sysutils/cdrtools
build_port editors/hexedit
build_port archivers/unrar
build_port archivers/p7zip
build_port sysutils/dmidecode
build_port sysutils/smartmontools
build_port net/rsync
build_port lang/go
build_port ftp/wget
build_port dns/dnsmasq
build_port net/samba413
build_port net/dhcp6
build_port net/miniupnpd
build_port net/miniupnpc
build_port net/libnatpmp
build_port security/openvpn
build_port net/wireguard-kmod
build_port net/wireguard-tools
build_port devel/git
build_port devel/mercurial
build_port www/thttpd
build_port www/fcgiwrap
build_port www/nginx
build_port devel/cscope
build_port devel/gdb
build_port textproc/aspell
build_port textproc/en-aspell
build_port hebrew/aspell
build_port www/youtube_dl
build_port benchmarks/iperf
build_port www/tidy-devel
build_port graphics/p5-Image-ExifTool
build_port audio/cdparanoia
build_port sysutils/rpi-firmware
build_port sysutils/u-boot-beaglebone
build_port sysutils/u-boot-nanopi-neo
build_port sysutils/u-boot-orangepi-one
build_port sysutils/u-boot-orangepi-pc
build_port sysutils/u-boot-orangepi-pc2
build_port sysutils/u-boot-rock64
build_port sysutils/u-boot-rpi4
build_port comms/sunxi-tools
build_port print/freetype2
build_port x11-fonts/fontconfig
build_port audio/flac
build_port audio/lame
build_port multimedia/ffmpeg
build_port emulators/qemu-user-static
build_port textproc/odt2txt
build_port x11-fonts/font-alias
build_port x11-fonts/font-cursor-misc
build_port x11-fonts/font-misc-misc
build_port x11-fonts/xorg-fonts-type1
# build_port x11-fonts/dejavu
build_port x11-fonts/xorg-fonts-truetype
build_port x11-fonts/croscorefonts-fonts-ttf
build_port x11-fonts/crosextrafonts-caladea-ttf
build_port x11-fonts/crosextrafonts-carlito-ttf
build_port x11-fonts/sourcecodepro-ttf
build_port x11-fonts/liberation-fonts-ttf
build_port hebrew/culmus
build_port x11-fonts/junicode
build_port x11-fonts/sbl-hebrew
# build_port graphics/tesseract
build_port devel/dbus
build_port graphics/drm-kmod
build_port x11-servers/xorg-server
build_port x11-drivers/xf86-input-mouse
build_port x11-drivers/xf86-input-keyboard
build_port x11-drivers/xf86-input-libinput
build_port x11/xinit
build_port x11/xauth
build_port x11/setxkbmap
build_port x11/xclipboard
build_port x11/xdpyinfo
build_port x11/xdriinfo
build_port x11/xev
build_port x11/xhost
# build_port x11/xkbcomp
build_port x11/xkbevd
build_port x11/xkbprint
build_port x11/xkbutils
build_port x11/xkill
build_port x11/xmodmap
build_port x11/xprop
build_port x11/xrandr
build_port x11/xinput
build_port x11/xrdb
build_port x11/xset
build_port x11/xvinfo
build_port x11/xwininfo
build_port x11/xterm
build_port x11-themes/xcursor-themes
build_port x11/xorg-docs
build_port x11-servers/xwayland
build_port x11-drivers/xf86-video-ati
build_port x11-drivers/xf86-video-vmware
build_port x11-wm/picom
build_port x11/xsetroot
build_port x11/hsetroot
build_port x11/slock
build_port accessibility/atk
build_port x11-toolkits/gtk20
build_port x11-themes/adwaita-icon-theme
build_port x11-toolkits/gtk30
build_port x11-themes/gtk-engines2
build_port devel/qt5-core
build_port x11-toolkits/qt5-widgets
build_port graphics/qt5-wayland
build_port x11-themes/clearlooks-phenix-theme
build_port devel/py-xdg
build_port x11-wm/openbox
build_port x11-wm/obconf-qt
build_port x11/tint
build_port deskutils/lxqt-notificationd
build_port deskutils/gsimplecal
build_port x11/qterminal
build_port x11/gmrun
build_port x11-fm/pcmanfm-qt
build_port editors/leafpad
build_port editors/featherpad
build_port x11-themes/lxappearance
build_port x11/lxrandr
build_port sysutils/lxtask
build_port textproc/meld
build_port graphics/scrot
# build_port www/firefox
# build_port www/falkon
# build_port mail/thunderbird
build_port math/galculator
build_port math/speedcrunch
build_port devel/geany
# build_port print/qpdfview
# build_port graphics/lximage-qt
# build_port multimedia/vlc
# build_port multimedia/smplayer
# build_port multimedia/qmmp-qt5
# build_port multimedia/mediainfo
# build_port graphics/gimp
# build_port graphics/rawtherapee
# build_port graphics/darktable
# build_port graphics/hugin
# build_port graphics/inkscape
# build_port audio/audacity
# build_port multimedia/avidemux-qt5
# build_port print/fontforge
# build_port graphics/luminance-qt5
# build_port graphics/blender
# build_port editors/libreoffice
# build_port net/wireshark
# build_port emulators/qemu
# build_port sysutils/uefi-edk2-qemu
# build_port emulators/dosbox
# build_port astro/qmapshack
# build_port sysutils/android-file-transfer
# build_port sysutils/android-file-transfer-qt5

pkg_repo_path=$(cd /usr/ports && make -V PACKAGES)
[ -z "$pkg_repo_path" ] && { echo "PACKAGES var is empty" 1>&2; exit 1; }
rm -rf ${pkg_repo_path}/* || exit 1
mkdir ${pkg_repo_path}/All || exit 1
mkdir ${pkg_repo_path}/Latest || exit 1
(cd ${pkg_repo_path}/All && pkg create -a) || exit 1
(cd ${pkg_repo_path}/Latest && ln -sf ../All/pkg-*.pkg pkg.pkg) || exit 1
pkg repo ${pkg_repo_path}
