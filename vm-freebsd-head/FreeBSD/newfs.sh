#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
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
disk0=ada0
disk1=ada1
disk2=ada2
disk3=ada3
disk4=ada4


# -- layout  --
# disk0:
#   freebsd-boot
#   /
#   /var
my_prompt "${disk0}" || exit 1
newfs -U -n -i 50000 /dev/"${disk0}"p2 || exit 1  # ~131072 for 5G
newfs -U -n -i 40000 /dev/"${disk0}"p3 || exit 1  #  ~25600 for 1G

# disk1:
#   swap

# disk2:
#   /usr/obj
my_prompt "${disk2}" || exit 1
newfs -U -n -i 68000 /dev/"${disk2}"p1 || exit 1  # ~262144 for 16G

# disk3:
#   /home
my_prompt "${disk3}" || exit 1
newfs -U -n -i 34000 /dev/"${disk3}"p1 || exit 1  # ~524288 for 16G

# disk4:
#   /chroots
my_prompt "${disk4}" || exit 1
newfs -U -n -i 34000 /dev/"${disk4}"p1 || exit 1  # ~524288 for 16G
