#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "newfs.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- my_newfs(partition, num_inodes, [flags ...,]) --
my_newfs()
{
  local my_partition=$1
  local my_inodes=$2
  local my_mediasize
  local my_density
  shift
  shift
  
  my_mediasize=`diskinfo "${my_partition}" | tr '\t' ' ' | cut -d\  -f 3`
  [ -z "${my_mediasize}" ] && return 1
  
  my_density=$(($my_mediasize / $my_inodes / 512 * 512))
  
  newfs -i "${my_density}" "$@" "${my_partition}" || return 1
}


# -- my_prompt_to_newfs(dev) --
my_prompt_to_newfs()
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
disk0=ada0
disk1=ada1


# -- layout  --
# disk0:
#   freebsd-boot    # change to ESP for UEFI
#   /
#   swap
#   /var
#   /usr/ports
#   /usr/src
#   /var/db/portsnap
#   /usr/obj
#   /home
my_prompt_to_newfs "${disk0}" || exit 1
# newfs_msdos -F 32 -c 8 -r 32 -o 2048 -m 0xF8 /dev/"${disk0}"p1 || exit 1
my_newfs /dev/"${disk0}"p2 131072 -U -n || exit 1
my_newfs /dev/"${disk0}"p4 25600 -U -j || exit 1
my_newfs /dev/"${disk0}"p5 196608 -U -n || exit 1
my_newfs /dev/"${disk0}"p6 131072 -U -n || exit 1
my_newfs /dev/"${disk0}"p7 49152 -U -n || exit 1
my_newfs /dev/"${disk0}"p8 524288 -U -n || exit 1
my_newfs /dev/"${disk0}"p9 786432 -U -j || exit 1

# disk1:
#   /export/backup
my_prompt_to_newfs "${disk1}" || exit 1
my_newfs /dev/"${disk1}"p1 262144 -U -j || exit 1
