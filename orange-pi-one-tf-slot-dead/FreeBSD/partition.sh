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
read -p "Enter device for disk0: " disk0 || exit 1


# -- layout --
# disk0:
#   /boot/custom
#   /
#   dump
#   /home
my_prompt "${disk0}" || exit 1
gpart create -s GPT -f x "${disk0}" || exit 1
gpart add -b 8192 -s 28M -t ms-basic-data -f x "${disk0}" || exit 1
gpart add -a 4M -s 992M -t freebsd-ufs -f x "${disk0}" || exit 1
gpart add -a 4M -s 64M -t freebsd-swap -f x "${disk0}" || exit 1
gpart add -a 4M -t freebsd-ufs -f x "${disk0}" || exit 1
gpart commit "${disk0}" || exit 1
gpart show "${disk0}" || exit 1
