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
pkgs="${pkgs} curl"
pkgs="${pkgs} python3"
pkgs="${pkgs} ncurses"
pkgs="${pkgs} terminfo-db"
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
pkgs="${pkgs} git"
pkgs="${pkgs} gitup"
pkgs="${pkgs} samba416"
# pkgs="${pkgs} samba419"
pkgs="${pkgs} fcgiwrap"
pkgs="${pkgs} nginx"
pkgs="${pkgs} iperf"
pkgs="${pkgs} p5-Image-ExifTool"
pkgs="${pkgs} tidy-html5"
pkgs="${pkgs} fontconfig"
pkgs="${pkgs} flac"
pkgs="${pkgs} lame"
pkgs="${pkgs} odt2txt"
pkgs="${pkgs} ffmpeg"


# -- add pkgs --
pkg ${chroot_arg} install ${pkgs} || exit 1
