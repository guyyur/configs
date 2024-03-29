#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
  echo "add_pkgs.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- pkg list --
pkgs="pkg"
pkgs="${pkgs} nano"
pkgs="${pkgs} zsh"
pkgs="${pkgs} python3"
pkgs="${pkgs} tmux"
pkgs="${pkgs} ca_root_nss"
pkgs="${pkgs} dhcpcd"
pkgs="${pkgs} cdrtools"
pkgs="${pkgs} hexedit"
pkgs="${pkgs} dmidecode"
pkgs="${pkgs} gmake"
pkgs="${pkgs} git"
pkgs="${pkgs} mercurial"
pkgs="${pkgs} cscope"
pkgs="${pkgs} gdb"
pkgs="${pkgs} iperf"
pkgs="${pkgs} rpi-firmware"
pkgs="${pkgs} u-boot-beaglebone"
pkgs="${pkgs} u-boot-nanopi_neo"
pkgs="${pkgs} u-boot-orangepi-one"
pkgs="${pkgs} u-boot-orangepi-pc"
pkgs="${pkgs} u-boot-orangepi-pc2"
pkgs="${pkgs} u-boot-rock64"
pkgs="${pkgs} u-boot-rpi4"
pkgs="${pkgs} freetype2"
pkgs="${pkgs} fontconfig"
pkgs="${pkgs} qemu-user-static"
# pkgs="${pkgs} go"
pkgs="${pkgs} font-alias"
pkgs="${pkgs} font-cursor-misc"
pkgs="${pkgs} font-misc-misc"
pkgs="${pkgs} xorg-fonts-type1"
pkgs="${pkgs} xorg-fonts-truetype"
pkgs="${pkgs} croscorefonts"
pkgs="${pkgs} crosextrafonts-caladea"
pkgs="${pkgs} crosextrafonts-carlito"
pkgs="${pkgs} sourcecodepro-ttf"
pkgs="${pkgs} liberation-fonts-ttf"
pkgs="${pkgs} iw-culmus"
pkgs="${pkgs} junicode"
pkgs="${pkgs} dbus"
pkgs="${pkgs} seatd"
pkgs="${pkgs} xorg-server"
pkgs="${pkgs} xf86-input-mouse"
pkgs="${pkgs} xf86-input-keyboard"
pkgs="${pkgs} xf86-input-libinput"
pkgs="${pkgs} xinit"
pkgs="${pkgs} xauth"
pkgs="${pkgs} setxkbmap"
pkgs="${pkgs} xclipboard"
pkgs="${pkgs} xdpyinfo"
pkgs="${pkgs} xdriinfo"
pkgs="${pkgs} xev"
pkgs="${pkgs} xhost"
pkgs="${pkgs} xkbevd"
pkgs="${pkgs} xkbprint"
pkgs="${pkgs} xkbutils"
pkgs="${pkgs} xkill"
pkgs="${pkgs} xmodmap"
pkgs="${pkgs} xprop"
pkgs="${pkgs} xrandr"
pkgs="${pkgs} xinput"
pkgs="${pkgs} xrdb"
pkgs="${pkgs} xset"
pkgs="${pkgs} xvinfo"
pkgs="${pkgs} xwininfo"
pkgs="${pkgs} xterm"
pkgs="${pkgs} xcursor-themes"
pkgs="${pkgs} xorg-docs"
pkgs="${pkgs} drm-510-kmod"
pkgs="${pkgs} xf86-video-vmware"
pkgs="${pkgs} picom"
pkgs="${pkgs} xsetroot"
pkgs="${pkgs} hsetroot"
pkgs="${pkgs} gtk-engines2"
pkgs="${pkgs} clearlooks-phenix-theme"
pkgs="${pkgs} adwaita-icon-theme"
pkgs="${pkgs} gnome-icons-elementary"
pkgs="${pkgs} kf5-oxygen-icons5"
pkgs="${pkgs} qt5-wayland"
pkgs="${pkgs} qt5ct"
pkgs="${pkgs} openbox"
pkgs="${pkgs} obconf-qt"
pkgs="${pkgs} tint2"
pkgs="${pkgs} py39-xdg"
pkgs="${pkgs} lxqt-notificationd"
pkgs="${pkgs} gsimplecal"
pkgs="${pkgs} qterminal"
pkgs="${pkgs} gmrun"
pkgs="${pkgs} pcmanfm-qt"
pkgs="${pkgs} featherpad"
pkgs="${pkgs} xed"
pkgs="${pkgs} lxappearance"
pkgs="${pkgs} lxtask"
pkgs="${pkgs} meld"
pkgs="${pkgs} geany"


# -- add pkgs --
pkg install ${pkgs} || exit 1
