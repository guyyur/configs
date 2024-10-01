#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
  echo "pkgs.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- params --
export PKG_PATH=http://www.mirrorservice.org/pub/OpenBSD/"$(uname -r)"/packages/"$(uname -m)"/


# -- pkg list --
pkgs=""
pkgs="${pkgs} nano"
pkgs="${pkgs} zsh"


# -- add pkgs --
pkg_add ${pkgs} || exit 1
