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
disk0=da0
disk1=da1
disk2=da2
disk3=da3
disk4=da4
disk5=da5


# -- layout --
# disk0:
#   /efi
#   /
#   /var
my_prompt "${disk0}" || exit 1
gpart create -s GPT -f x "${disk0}" || exit 1
gpart add -a 1M -b 8192 -s 28M -t efi -f x "${disk0}" || exit 1
gpart add -a 1M -s 31455232 -t freebsd-ufs -f x "${disk0}" || exit 1
gpart add -a 1M -t freebsd-ufs -f x "${disk0}" || exit 1
gpart commit "${disk0}" || exit 1
gpart show "${disk0}" || exit 1

# disk1:
#   swap
my_prompt "${disk1}" || exit 1
gpart create -s GPT -f x "${disk1}" || exit 1
gpart add -a 1M -b 2048 -t freebsd-swap -l swap -f x "${disk1}" || exit 1
gpart commit "${disk1}" || exit 1
gpart show "${disk1}" || exit 1
gpart show -l "${disk1}" || exit 1

# disk2:
#   /usr/obj
my_prompt "${disk2}" || exit 1
gpart create -s GPT -f x "${disk2}" || exit 1
gpart add -a 1M -b 2048 -t freebsd-ufs -f x "${disk2}" || exit 1
gpart commit "${disk2}" || exit 1
gpart show "${disk2}" || exit 1

# disk3:
#   /jails
my_prompt "${disk3}" || exit 1
gpart create -s GPT -f x "${disk3}" || exit 1
gpart add -a 1M -b 2048 -t freebsd-ufs -f x "${disk3}" || exit 1
gpart commit "${disk3}" || exit 1
gpart show "${disk3}" || exit 1

# disk4:
#   /home
my_prompt "${disk4}" || exit 1
gpart create -s GPT -f x "${disk4}" || exit 1
gpart add -a 1M -b 2048 -t freebsd-ufs -f x "${disk4}" || exit 1
gpart commit "${disk4}" || exit 1
gpart show "${disk4}" || exit 1

# disk5:
#   /usr/wrkdir_large
my_prompt "${disk5}" || exit 1
gpart create -s GPT -f x "${disk5}" || exit 1
gpart add -a 1M -b 2048 -t freebsd-ufs -f x "${disk5}" || exit 1
gpart commit "${disk5}" || exit 1
gpart show "${disk5}" || exit 1
