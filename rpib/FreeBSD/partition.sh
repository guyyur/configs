#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "partition.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- my_prompt(dev) --
my_prompt()
{
  local my_devname=$1
  local my_continue
  
  read -p "partition ${my_devname}? [No/yes] " my_continue || return 1
  case "${my_continue}" in
    [Yy][Ee][Ss])
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}


# -- disk names --
if [ -z "$1" ]; then
  echo "disk device not specified" 1>&2
  exit 1
fi

disk0=$1


# -- layout --
# disk0:
#   /boot/custom
#   freebsd label
#     /
#     dump
#     /home
my_prompt "${disk0}" || exit 1

gpart create -s MBR -f x "${disk0}" || exit 1
gpart add -a 4M -b 8192 -s 28M -t '!4' -f x "${disk0}" || exit 1
gpart set -a active -i 1 -f x "${disk0}" || exit 1
gpart add -a 4M -t freebsd -f x "${disk0}" || exit 1
gpart commit "${disk0}" || exit 1
gpart show "${disk0}" || exit 1

gpart create -s BSD -f x "${disk0}"s2 || exit 1
gpart add -s 992M -t freebsd-ufs -f x "${disk0}"s2 || exit 1
gpart add -a 4M -s 64M -t freebsd-swap -f x "${disk0}"s2 || exit 1
gpart add -i 4 -a 4M -t freebsd-ufs -f x "${disk0}"s2 || exit 1
gpart commit "${disk0}"s2 || exit 1
gpart show "${disk0}"s2 || exit 1
