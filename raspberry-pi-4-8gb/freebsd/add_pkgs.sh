#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
  echo "add_pkgs.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- chroot path --


# -- pkg list --
pkgs="pkg"
pkgs="${pkgs} nano"
pkgs="${pkgs} zsh"
pkgs="${pkgs} curl"
pkgs="${pkgs} python3"
pkgs="${pkgs} tmux"
pkgs="${pkgs} ca_root_nss"
pkgs="${pkgs} dhcpcd"
pkgs="${pkgs} doas"
pkgs="${pkgs} hexedit"
pkgs="${pkgs} unrar"
pkgs="${pkgs} 7-zip"
pkgs="${pkgs} smartmontools"
pkgs="${pkgs} rsync"
pkgs="${pkgs} wget"
pkgs="${pkgs} samba413"
pkgs="${pkgs} miniupnpc"
pkgs="${pkgs} libnatpmp"
pkgs="${pkgs} git"
pkgs="${pkgs} gitup"
pkgs="${pkgs} fcgiwrap"
pkgs="${pkgs} nginx"
pkgs="${pkgs} gdb"
pkgs="${pkgs} aspell"
pkgs="${pkgs} en-aspell"
pkgs="${pkgs} iw-aspell"
pkgs="${pkgs} iperf"
pkgs="${pkgs} tidy-devel"
pkgs="${pkgs} p5-Image-ExifTool"
pkgs="${pkgs} flac"
pkgs="${pkgs} lame"
pkgs="${pkgs} ffmpeg"
pkgs="${pkgs} odt2txt"


# -- add pkgs --
pkg install ${pkgs} || exit 1
