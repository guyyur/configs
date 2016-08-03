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
if [ -z "$1" ]; then
  echo "disk device not specified" 1>&2
  exit 1
fi

disk0=$1


# -- write boot blocks --
my_prompt "${disk0}" || exit 1
dd if=/usr/local/share/odroid-c1-boot-files/bl1-mbr.tmp of=/dev/"${disk0}" bs=446 count=1 conv=sync,notrunc || exit 1
dd if=/usr/local/share/odroid-c1-boot-files/bl1.bin.hardkernel of=/dev/"${disk0}" bs=512 skip=1 seek=1 conv=sync,notrunc || exit 1
dd if=/usr/local/share/odroid-c1-boot-files/u-boot.bin of=/dev/"${disk0}" bs=512 seek=64 conv=sync,notrunc || exit 1
dd if=/dev/zero of=/dev/"${disk0}" bs=32768 seek=1024 count=1 conv=sync,notrunc || exit 1