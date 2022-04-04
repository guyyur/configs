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
#   /
#   /var
my_prompt "${disk0}" || exit 1
parted -s -a optimal /dev/"${disk0}" \
  mklabel msdos \
  unit s \
  mkpart primary ext4 2048s 14680063s \
  mkpart primary ext4 14680064s 100% \
  set 1 boot on \
  || exit 1
parted -s -a optimal /dev/"${disk0}" unit s print || exit 1

# disk1:
#   swap
my_prompt "${disk1}" || exit 1
parted -s -a optimal /dev/"${disk1}" \
  mklabel msdos \
  unit s \
  mkpart primary linux-swap 2048s 100% \
  || exit 1
parted -s -a optimal /dev/"${disk1}" unit s print || exit 1

# disk2:
#   /home
my_prompt "${disk2}" || exit 1
parted -s -a optimal /dev/"${disk2}" \
  mklabel msdos \
  unit s \
  mkpart primary ext4 2048s 100% \
  || exit 1
parted -s -a optimal /dev/"${disk2}" unit s print || exit 1
