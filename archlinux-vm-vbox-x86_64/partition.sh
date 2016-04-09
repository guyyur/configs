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
disk0=sda
disk1=sdb
disk2=sdc
disk3=sdd


# -- layout --
# disk0:
#   /
#   /var
my_prompt_to_partition "${disk0}" || exit 1
parted -s -a optimal /dev/"${disk0}" \
  mklabel msdos \
  unit s \
  mkpart primary ext4 2048s 10485759s \
  mkpart primary ext4 10485760s 100% \
  set 1 boot on \
  || exit 1
parted -s -a optimal /dev/"${disk0}" unit s print || exit 1

dd bs=446 count=1 conv=notrunc if="${DESTDIR}/usr/lib/syslinux/bios/mbr.bin" of=/dev/"${disk0}" || exit 1

# disk1:
#   swap
my_prompt_to_partition "${disk1}" || exit 1
parted -s -a optimal /dev/"${disk1}" \
  mklabel msdos \
  unit s \
  mkpart primary linux-swap 2048s 100% \
  || exit 1
parted -s -a optimal /dev/"${disk1}" unit s print || exit 1

# disk2:
#   /var/cache/pacman
my_prompt_to_partition "${disk2}" || exit 1
parted -s -a optimal /dev/"${disk2}" \
  mklabel msdos \
  unit s \
  mkpart primary ext4 2048s 100% \
  || exit 1
parted -s -a optimal /dev/"${disk2}" unit s print || exit 1

# disk3:
#   /home
my_prompt_to_partition "${disk3}" || exit 1
parted -s -a optimal /dev/"${disk3}" \
  mklabel msdos \
  unit s \
  mkpart primary ext4 2048s 100% \
  || exit 1
parted -s -a optimal /dev/"${disk3}" unit s print || exit 1
