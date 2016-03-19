#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "partition.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- my_prompt_to_partition(dev) --
my_prompt_to_partition()
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
disk0=mmcsd1


# -- layout --
# disk0:
#   /boot/custom (msdosfs)
#   freebsd label
my_prompt_to_partition "${disk0}" || exit 1
gpart create -s MBR -f x "${disk0}" || exit 1
gpart add -a 1m -b 2048 -s 31M -t '!4' -f x "${disk0}" || exit 1
gpart set -a active -i 1 -f x "${disk0}" || exit 1
gpart add -a 1m -t freebsd -f x "${disk0}" || exit 1
gpart commit "${disk0}" || exit 1
gpart show "${disk0}" || exit 1

# disk0s2:
#   /
my_prompt_to_partition "${disk0}"s2 || exit 1
gpart create -s BSD -f x "${disk0}"s2 || exit 1
gpart add -t freebsd-ufs -f x "${disk0}"s2 || exit 1
gpart commit "${disk0}"s2 || exit 1
gpart show "${disk0}"s2 || exit 1
