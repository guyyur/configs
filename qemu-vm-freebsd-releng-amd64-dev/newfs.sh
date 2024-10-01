#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
  echo "newfs.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- verify endian --
uname_p=$(uname -p)
if [ "${uname_p}" != "amd64" ]; then
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
disk0=da0
disk1=da1
disk2=da2
disk3=da3
disk4=da4
disk5=da5


# -- layout  --
# disk0:
#   /efi
#   /
#   /var
my_prompt "${disk0}" || exit 1
newfs_msdos -A -F 16 -c 8 -o 8192 -m 0xF8 /dev/"${disk0}"p1 || exit 1
newfs -U -n -i 50000 /dev/"${disk0}"p2 || exit 1  # ~262144 inodes for 31455232
newfs -U -n -i 40000 /dev/"${disk0}"p3 || exit 1  # ~25600 inodes for 1G

# disk1:
#   swap

# disk2:
#   /usr/obj
my_prompt "${disk2}" || exit 1
newfs -U -n -i 120000 /dev/"${disk2}"p1 || exit 1  # ~393216 inodes for 48G

# disk3:
#   /jails
my_prompt "${disk3}" || exit 1
newfs -U -n -i 51000 /dev/"${disk3}"p1 || exit 1  # ~524288 inodes for 24G

# disk4:
#   /home
my_prompt "${disk4}" || exit 1
newfs -U -n -i 34000 /dev/"${disk4}"p1 || exit 1  # ~524288 inodes for 16G

# disk5:
#   /usr/wrkdir_large
my_prompt "${disk5}" || exit 1
newfs -U -n -i 68000 /dev/"${disk5}"p1 || exit 1  # ~524288 inodes for 32G
