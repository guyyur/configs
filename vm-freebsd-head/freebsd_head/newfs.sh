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
disk0=da0
disk1=da1
disk2=da2
disk3=da3
disk4=da4


# -- file system params --
part_root_inode_density=50000     # ~262144 inodes for 15G
part_var_inode_density=40000      # ~25600 inodes for 1G
part_home_inode_density=34000     # ~524288 inodes for 16G
part_usr_obj_inode_density=90000  # ~393216 inodes for 32G
part_jails_inode_density=51000    # ~524288 inodes for 24G


# -- layout  --
# disk0:
#   freebsd-boot
#   /
#   /var
my_prompt "${disk0}" || exit 1
newfs -U -n -i ${part_root_inode_density} /dev/"${disk0}"p2 || exit 1
newfs -U -n -i ${part_var_inode_density} /dev/"${disk0}"p3 || exit 1

# disk1:
#   swap

# disk2:
#   /home
my_prompt "${disk2}" || exit 1
newfs -U -n -i ${part_home_inode_density} /dev/"${disk2}"p1 || exit 1

# disk3:
#   /usr/obj
my_prompt "${disk3}" || exit 1
newfs -U -n -i ${part_usr_obj_inode_density} /dev/"${disk3}"p1 || exit 1

# disk4:
#   /jails
my_prompt "${disk4}" || exit 1
newfs -U -n -i ${part_jails_inode_density} /dev/"${disk4}"p1 || exit 1
