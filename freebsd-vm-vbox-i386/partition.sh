#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "partition.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- commit_or_undo(disk) --
my_commit_or_undo()
{
  local my_disk=$1
  local my_commit
  
  gpart show "${my_disk}" || return 1
  gpart show -l "${my_disk}" || return 1
  
  read -p "commit? [N/y] " my_commit || return 1
  case "${my_commit}" in
    Y|y)
      gpart commit "${my_disk}" || return 1
      ;;
    *)
      gpart undo "${my_disk}"
      return 1
      ;;
  esac
}


# -- disk names --
disk0=ada0
disk1=ada1
disk2=ada2
disk3=ada3


# -- layout --
# disk0:
#   freebsd-boot
#   /
#   /var
#   /tmp
gpart create -s GPT -f x "${disk0}" || exit 1
gpart bootcode -b /boot/pmbr -f x "${disk0}" || exit 1
gpart add -b 40 -s 88 -t freebsd-boot -f x "${disk0}" || exit 1
gpart bootcode -p /boot/gptboot -i 1 -f x "${disk0}" || exit 1
gpart add -a 1m -b 2048 -s 10485760 -t freebsd-ufs -f x "${disk0}" || exit 1
gpart add -a 1m -s 1048576 -t freebsd-ufs -f x "${disk0}" || exit 1
gpart add -a 1m -t freebsd-ufs -f x "${disk0}" || exit 1
my_commit_or_undo "${disk0}" || exit 1

# disk1:
#   swap
gpart create -s GPT -f x "${disk1}" || exit 1
gpart add -a 1m -b 2048 -t freebsd-swap -l swap -f x "${disk1}" || exit 1
my_commit_or_undo "${disk1}" || exit 1

# disk2:
#   /home
gpart create -s GPT -f x "${disk2}" || exit 1
gpart add -a 1m -b 2048 -t freebsd-ufs -f x "${disk2}" || exit 1
my_commit_or_undo "${disk2}" || exit 1

# disk3:
#   /usr/obj
gpart create -s GPT -f x "${disk3}" || exit 1
gpart add -a 1m -b 2048 -t freebsd-ufs -f x "${disk3}" || exit 1
my_commit_or_undo "${disk3}" || exit 1
