#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
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
#   /efi
#   /
#   dump
#   /home
my_prompt "${disk0}" || exit 1
newfs_msdos -A -F 16 -c 8 -o 8192 -m 0xF8 /dev/"${disk0}"p1 || exit 1
newfs -U -n /dev/"${disk0}"p2 || exit 1  # ~131072 for 1248M
newfs -U -n /dev/"${disk0}"p4 || exit 1  # ~131072 for 506M
