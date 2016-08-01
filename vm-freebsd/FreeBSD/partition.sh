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
disk0=ada0
disk1=ada1
disk2=ada2
disk3=ada3
disk4=ada4
disk5=ada5


# -- layout --
# disk0:
#   freebsd-boot
#   /
#   /var
my_prompt_to_partition "${disk0}" || exit 1
gpart create -s GPT -f x "${disk0}" || exit 1
gpart bootcode -b /boot/pmbr -f x "${disk0}" || exit 1
gpart add -b 64 -s 448 -t freebsd-boot -f x "${disk0}" || exit 1
gpart bootcode -p /boot/gptboot -i 1 -f x "${disk0}" || exit 1
gpart add -a 1m -b 2048 -s 9435136 -t freebsd-ufs -f x "${disk0}" || exit 1
gpart add -a 1m -t freebsd-ufs -f x "${disk0}" || exit 1
gpart commit "${disk0}" || exit 1
gpart show "${disk0}" || exit 1

# disk1:
#   swap
my_prompt_to_partition "${disk1}" || exit 1
gpart create -s GPT -f x "${disk1}" || exit 1
gpart add -a 1m -b 2048 -t freebsd-swap -l swap -f x "${disk1}" || exit 1
gpart commit "${disk1}" || exit 1
gpart show "${disk1}" || exit 1
gpart show -l "${disk1}" || exit 1

# disk2:
#   /usr/src
my_prompt_to_partition "${disk2}" || exit 1
gpart create -s GPT -f x "${disk2}" || exit 1
gpart add -a 1m -b 2048 -t freebsd-ufs -f x "${disk2}" || exit 1
gpart commit "${disk2}" || exit 1
gpart show "${disk2}" || exit 1

# disk3:
#   /usr/obj
my_prompt_to_partition "${disk3}" || exit 1
gpart create -s GPT -f x "${disk3}" || exit 1
gpart add -a 1m -b 2048 -t freebsd-ufs -f x "${disk3}" || exit 1
gpart commit "${disk3}" || exit 1
gpart show "${disk3}" || exit 1

# disk4:
#   /usr/ports
my_prompt_to_partition "${disk4}" || exit 1
gpart create -s GPT -f x "${disk4}" || exit 1
gpart add -a 1m -b 2048 -t freebsd-ufs -f x "${disk4}" || exit 1
gpart commit "${disk4}" || exit 1
gpart show "${disk4}" || exit 1

# disk5:
#   /home
my_prompt_to_partition "${disk5}" || exit 1
gpart create -s GPT -f x "${disk5}" || exit 1
gpart add -a 1m -b 2048 -t freebsd-ufs -f x "${disk5}" || exit 1
gpart commit "${disk5}" || exit 1
gpart show "${disk5}" || exit 1