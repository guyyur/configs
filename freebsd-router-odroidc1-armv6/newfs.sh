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
if [ -z "$1" ]; then
  echo "disk device not specified" 1>&2
  exit 1
fi

disk0=$1


# -- layout  --
# disk0:
#   /boot/custom (msdosfs)
#   freebsd label
#     /
#     /misc
my_prompt_to_newfs "${disk0}" || exit 1
newfs_msdos -F 16 -c 8 -r 2 -o 8192 -m 0xF8 /dev/"${disk0}"s1 || exit 1
my_newfs /dev/"${disk0}"s2a 131072 -U -n || exit 1
my_newfs /dev/"${disk0}"s2d 262144 -U -n || exit 1
