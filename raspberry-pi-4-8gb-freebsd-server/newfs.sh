#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
  echo "newfs.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- verify endian --
uname_p=$(uname -p)
if [ "${uname_p}" != "aarch64" ]; then
  case ${uname_p} in
    aarch64|amd64|armv7|riscv64) ;;
    *)
      echo "newfs.sh: endian mismatch between host arch and target arch or unsupported host arch." 1>&2
      exit 1
      ;;
  esac
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
#   /var
#   /export/packages
#   /export/sources
#   /jails
#   /home
my_prompt "${disk0}" || exit 1
newfs_msdos -A -F 16 -c 8 -o 8192 -m 0xF8 /dev/"${disk0}"p1 || exit 1
newfs -U -n -i 34000 /dev/"${disk0}"p2 || exit 1  # ~131072 inodes for 3936M
newfs -U -n -i 10000 /dev/"${disk0}"p4 || exit 1  # ~32768 inodes for 256M
newfs -U -n -i 110000 /dev/"${disk0}"p5 || exit 1  # ~131072 inodes for 14G
newfs -U -n -i 35000 /dev/"${disk0}"p6 || exit 1  # ~327680 inodes for 12G
newfs -U -n -i 20000 /dev/"${disk0}"p7 || exit 1  # ~262144 inodes for 4G
newfs -U -n -i 5000000 /dev/"${disk0}"p8 || exit 1  # ~131072 inodes for 1832G
