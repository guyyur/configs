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
pkgs="${pkgs} ncurses"
pkgs="${pkgs} terminfo-db"
pkgs="${pkgs} tmux"
pkgs="${pkgs} ca_root_nss"
pkgs="${pkgs} dhcpcd"
pkgs="${pkgs} git"
# pkgs="${pkgs} gdb"
pkgs="${pkgs} u-boot-rock64"
pkgs="${pkgs} qemu-user-static"


# -- add pkgs --
pkg ${chroot_arg} install ${pkgs} || exit 1
