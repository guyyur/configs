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
disk0=sda
disk1=sdb
disk2=sdc


# -- write boot blocks --
my_prompt "${disk0}" || exit 1
dd if="/mnt/usr/lib/syslinux/bios/mbr.bin" of=/dev/"${disk0}" bs=440 count=1 conv=notrunc || exit 1
