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


# -- file system params --
part_root_inode_density=24000    # ~131072 inodes for 3040M
part_backup_inode_density=84000  # ~262144 inodes for 26G


# -- layout  --
# disk0:
#   /efi
#   /
#   dump
#   /backup
my_prompt "${disk0}" || exit 1
newfs_msdos -A -F 16 -c 8 -o 8192 -m 0xF8 /dev/"${disk0}"p1 || exit 1
newfs -U -n -i ${part_root_inode_density} /dev/"${disk0}"p2 || exit 1
newfs -U -n -i ${part_backup_inode_density} /dev/"${disk0}"p4 || exit 1
