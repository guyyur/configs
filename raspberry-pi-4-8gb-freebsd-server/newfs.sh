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
part_root_inode_density=34000              # ~131072 inodes for 3936M
part_var_inode_density=10000               # ~32768 inodes for 256M
part_export_packages_inode_density=110000  # ~131072 inodes for 14G
part_export_sources_inode_density=35000    # ~327680 inodes for 12G
part_jails_inode_density=20000             # ~262144 inodes for 4G
part_home_inode_density=5000000            # ~131072 inodes for 1832G


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
newfs -U -n -i ${part_root_inode_density} /dev/"${disk0}"p2 || exit 1
newfs -U -n -i ${part_var_inode_density} /dev/"${disk0}"p4 || exit 1
newfs -U -n -i ${part_export_packages_inode_density} /dev/"${disk0}"p5 || exit 1
newfs -U -n -i ${part_export_sources_inode_density} /dev/"${disk0}"p6 || exit 1
newfs -U -n -i ${part_jails_inode_density} /dev/"${disk0}"p7 || exit 1
newfs -U -n -i ${part_home_inode_density} /dev/"${disk0}"p8 || exit 1
