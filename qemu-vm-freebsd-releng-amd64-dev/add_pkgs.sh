#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
  echo "add_pkgs.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- set up params --
if [ -n "${1%/}" ]; then
  chroot_arg="-c ${1%/}"
else
  chroot_arg=""
fi


# -- pkg list --
pkgs="pkg"
pkgs="${pkgs} nano"
pkgs="${pkgs} zsh"
pkgs="${pkgs} python3"
pkgs="${pkgs} ncurses"
pkgs="${pkgs} terminfo-db"
# pkgs="${pkgs} go"
pkgs="${pkgs} tmux"
pkgs="${pkgs} shuf"
pkgs="${pkgs} ca_root_nss"
pkgs="${pkgs} dhcpcd"
pkgs="${pkgs} cdrtools"
pkgs="${pkgs} hexedit"
pkgs="${pkgs} dmidecode"
pkgs="${pkgs} smartmontools"
pkgs="${pkgs} gmake"
pkgs="${pkgs} git"
pkgs="${pkgs} mercurial"
pkgs="${pkgs} cscope"
pkgs="${pkgs} gdb"
pkgs="${pkgs} iperf"
pkgs="${pkgs} rpi-firmware"
pkgs="${pkgs} u-boot-nanopi_neo"
pkgs="${pkgs} u-boot-nanopi-r4s"
pkgs="${pkgs} u-boot-orangepi-one"
pkgs="${pkgs} u-boot-orangepi-pc"
pkgs="${pkgs} u-boot-orangepi-pc2"
pkgs="${pkgs} u-boot-rock64"
pkgs="${pkgs} u-boot-rpi4"
pkgs="${pkgs} freetype2"
pkgs="${pkgs} fontconfig"
pkgs="${pkgs} qemu-user-static"
pkgs="${pkgs} dbus"
pkgs="${pkgs} seatd"
pkgs="${pkgs} font-alias"
pkgs="${pkgs} font-cursor-misc"
pkgs="${pkgs} font-misc-misc"
pkgs="${pkgs} xorg-fonts-type1"
pkgs="${pkgs} xorg-fonts-truetype"
pkgs="${pkgs} croscorefonts"
pkgs="${pkgs} crosextrafonts-caladea"
pkgs="${pkgs} crosextrafonts-carlito"
pkgs="${pkgs} source-code-pro-ttf"
pkgs="${pkgs} liberation-fonts-ttf"
pkgs="${pkgs} iw-culmus"
pkgs="${pkgs} junicode"
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
pkgs="${pkgs} xsetroot"
pkgs="${pkgs} drm-61-kmod"
pkgs="${pkgs} xf86-video-vmware"
pkgs="${pkgs} picom"
pkgs="${pkgs} hsetroot"
pkgs="${pkgs} adwaita-icon-theme"
pkgs="${pkgs} kf5-oxygen-icons"
# pkgs="${pkgs} qt5-wayland"
pkgs="${pkgs} qt6-wayland"
# pkgs="${pkgs} qt5ct"
pkgs="${pkgs} qt6ct"
pkgs="${pkgs} libnotify"
pkgs="${pkgs} openbox"
# pkgs="${pkgs} obconf"
# pkgs="${pkgs} obconf-qt"
pkgs="${pkgs} tint2"
pkgs="${pkgs} gsimplecal"
pkgs="${pkgs} lxqt-notificationd"
# pkgs="${pkgs} labwc"
# pkgs="${pkgs} wayfire"
# pkgs="${pkgs} wf-shell"
# pkgs="${pkgs} wlr-randr"
# pkgs="${pkgs} swaybg"
# pkgs="${pkgs} mako"
# ?? pkgs="${pkgs} wlogout"
pkgs="${pkgs} startlabwc-headless"
pkgs="${pkgs} wayvnc"
pkgs="${pkgs} terminator"
pkgs="${pkgs} gmrun"
pkgs="${pkgs} pcmanfm-qt"
pkgs="${pkgs} featherpad"
pkgs="${pkgs} xed"
pkgs="${pkgs} lxtask"
pkgs="${pkgs} meld"
pkgs="${pkgs} geany"


# -- add pkgs --
pkg ${chroot_arg} install ${pkgs} || exit 1
