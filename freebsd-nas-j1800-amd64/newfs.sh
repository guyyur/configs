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
#   freebsd-boot
#   /
#   /var
#   /usr/src
#   /usr/obj
#   /usr/ports
#   /home
my_prompt_to_newfs "${disk0}" || exit 1
my_newfs /dev/"${disk0}"p2 131072 -U -n -t || exit 1
my_newfs /dev/"${disk0}"p3 65536 -U -n -t || exit 1
my_newfs /dev/"${disk0}"p4 131072 -U -n -t || exit 1
my_newfs /dev/"${disk0}"p5 524288 -U -n -t || exit 1
my_newfs /dev/"${disk0}"p6 196608 -U -n -t || exit 1
my_newfs /dev/"${disk0}"p7 786432 -U -n -t || exit 1

# disk1:
#   /export/backup
my_prompt_to_newfs "${disk1}" || exit 1
my_newfs /dev/"${disk1}"p1 262144 -U -n -j || exit 1
