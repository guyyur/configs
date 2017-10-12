#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "write_boot_blocks.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- my_prompt(dev) --
my_prompt()
{
  local my_devname=$1
  local my_continue
  
  read -p "write boot blocks to ${my_devname}? [No/yes] " my_continue || return 1
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
disk0_removable=1


# -- write boot blocks --
my_prompt "${disk0}" || exit 1
if [ -n "${disk0_removable}" ]; then
  dd if=/usr/local/share/u-boot/u-boot-beaglebone/MLO of=/dev/"${disk0}" bs=128k seek=1 conv=sync,notrunc
  dd if=/usr/local/share/u-boot/u-boot-beaglebone/u-boot.img of=/dev/"${disk0}" bs=384k seek=1 conv=sync,notrunc
else
  dd if=/dev/mmcsd0 of=/dev/"${disk0}" bs=128k skip=1 seek=1 count=1 conv=sync,notrunc
  dd if=/dev/mmcsd0 of=/dev/"${disk0}" bs=384k skip=1 seek=1 count=2 conv=sync,notrunc
fi
