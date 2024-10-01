#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
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
disk0=sda
disk1=sdb
disk2=sdc


# -- layout --
# disk0:
#   /efi
#   /
#   /var
my_prompt "${disk0}" || exit 1
sgdisk -Z /dev/"${disk0}" || exit 1
sgdisk -n 1:8192:65535 -t 1:ef00 \
       -n 2:0:7G -t 2:8304 -u 2:b9d8c763-cd9d-4c52-8d2a-0a11809c7b83 \
       -N 3 -t 3:8310 \
       /dev/"${disk0}" || exit 1
sgdisk -p /dev/"${disk0}" || exit 1

# disk1:
#   swap
my_prompt "${disk1}" || exit 1
sgdisk -Z /dev/"${disk1}" || exit 1
sgdisk -N 1 -t 1:8200 /dev/"${disk1}" || exit 1
sgdisk -p /dev/"${disk1}" || exit 1

# disk2:
#   /home
my_prompt "${disk2}" || exit 1
sgdisk -Z /dev/"${disk2}" || exit 1
sgdisk -N 1 -t 1:8302 /dev/"${disk2}" || exit 1
sgdisk -p /dev/"${disk2}" || exit 1
