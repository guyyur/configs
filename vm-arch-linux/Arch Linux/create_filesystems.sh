#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "create_filesystems.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- my_prompt(dev) --
my_prompt()
{
  local my_devname=$1
  local my_continue
  
  read -p "create filesystems on ${my_devname}? [No/yes] " my_continue || return 1
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
my_prompt "${disk0}" || exit 1
mke2fs -t ext4 -N 262144 -O ^64bit /dev/"${disk0}"1 || exit 1
mke2fs -t ext4 -N 81920 -O ^64bit /dev/"${disk0}"2 || exit 1

# disk1:
#   swap
my_prompt "${disk1}" || exit 1
mkswap /dev/"${disk1}"1

# disk2:
#   /var/cache/pacman
my_prompt "${disk2}" || exit 1
mke2fs -t ext4 -N 16384 -O ^64bit /dev/"${disk2}"1 || exit 1

# disk3:
#   /home
my_prompt "${disk3}" || exit 1
mke2fs -t ext4 -N 262144 -O ^64bit /dev/"${disk3}"1 || exit 1
