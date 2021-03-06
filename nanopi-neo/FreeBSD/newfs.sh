#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "newfs.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- my_prompt(dev) --
my_prompt()
{
  local my_devname=$1
  local my_continue
  
  read -p "newfs ${my_devname}? [No/yes] " my_continue || return 1
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


# -- layout  --
# disk0:
#   /boot/custom
#   freebsd label
#     /
my_prompt "${disk0}" || exit 1
newfs_msdos -F 16 -c 8 -r 2 -o 8192 -m 0xF8 /dev/"${disk0}"s1 || exit 1
newfs -U -n -i 28000 /dev/"${disk0}"s2a || exit 1  # ~262144 for 7G
