#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
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
disk0p=sda
disk1=sdb
disk1p=sdb
disk2=sdc
disk2p=sdc


# -- layout --
# disk0:
#   /
#   /var
my_prompt "${disk0}" || exit 1
mke2fs -t ext4 -N 262144 -O ^64bit /dev/"${disk0p}"1 || exit 1
mke2fs -t ext4 -N 81920 -O ^64bit /dev/"${disk0p}"2 || exit 1

# disk1:
#   swap
my_prompt "${disk1}" || exit 1
mkswap /dev/"${disk1p}"1

# disk2:
#   /home
my_prompt "${disk2}" || exit 1
mke2fs -t ext4 -N 262144 -O ^64bit /dev/"${disk2p}"1 || exit 1
