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
read -p "Enter device for disk0: " disk0 || exit 1


# -- partition sizes --
part_efi_start=8192
part_efi_size=28M
part_root_size=3040M
part_swap_size=128M


# -- layout --
# disk0:
#   /efi
#   /
#   dump
#   /backup
my_prompt "${disk0}" || exit 1
gpart create -s GPT -f x "${disk0}" || exit 1
gpart add -a 4M -b ${part_efi_start} -s ${part_efi_size} -t efi -f x "${disk0}" || exit 1
gpart add -a 4M -s ${part_root_size} -t freebsd-ufs -f x "${disk0}" || exit 1
gpart add -a 4M -s ${part_swap_size} -t freebsd-swap -f x "${disk0}" || exit 1
gpart add -a 4M -t freebsd-ufs -f x "${disk0}" || exit 1
gpart commit "${disk0}" || exit 1
gpart show "${disk0}" || exit 1
