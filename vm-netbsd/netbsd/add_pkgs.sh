#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
  echo "pkgs.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- install package manager --
export PKG_PATH=https://cdn.NetBSD.org/pub/pkgsrc/packages/NetBSD/"$(uname -p)"/"$(uname -r)"/All

pkg_add pkgin || exit 1


# -- pkg list --
pkgs=""
pkgs="${pkgs} nano"
pkgs="${pkgs} zsh"


# -- add pkgs --
pkgin install ${pkgs} || exit 1
