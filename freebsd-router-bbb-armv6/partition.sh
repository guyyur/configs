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
      printf "\n"
      ;;
    *)
      gpart undo "${my_disk}"
      return 1
      ;;
  esac
}


# -- disk names --
disk0=mmcsd1


# -- layout --
# disk0:
#   /boot/custom (msdosfs)
#   freebsd label
write_predefined_mbr fat16+freebsd /dev/zero /dev/"${disk0}" || exit 1

# disk0s2:
#   /
gpart create -s BSD -f x "${disk0}"s2 || exit 1
gpart add -t freebsd-ufs -f x "${disk0}"s2 || exit 1
my_commit_or_undo "${disk0}"s2 || exit 1
