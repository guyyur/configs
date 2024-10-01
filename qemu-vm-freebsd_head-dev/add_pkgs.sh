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
pkgs="${pkgs} tmux"
pkgs="${pkgs} ca_root_nss"
pkgs="${pkgs} dhcpcd"
pkgs="${pkgs} git"
pkgs="${pkgs} gdb"
pkgs="${pkgs} qemu-user-static"


# -- add pkgs --
pkg install ${pkgs} || exit 1
