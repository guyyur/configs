#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "add_pkgs.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- add pkgs --
pkg install \
  pkg \
  nano \
  zsh \
  dhcpcd \
  cdrtools \
  dmidecode \
  python3 \
  samba46 \
  mercurial \
  subversion \
  git \
  cscope \
  gdb \
  iperf \
  freetype2 \
  fontconfig \
  dbus \
  consolekit \
  xorg-server \
  xf86-input-mouse \
  xf86-input-keyboard \
  xinit \
  xauth \
  font-alias \
  font-cursor-misc \
  font-misc-misc \
  setxkbmap \
  xclipboard \
  xdpyinfo \
  xdriinfo \
  xev \
  xhost \
  xkbevd \
  xkbprint \
  xkbutils \
  xkill \
  xmodmap \
  xprop \
  xsetpointer \
  xrandr \
  xinput \
  xrdb \
  xset \
  xsetmode \
  xvinfo \
  xwininfo \
  xterm \
  xorg-fonts-type1 \
  xorg-fonts-truetype \
  xcursor-themes \
  xorg-docs \
  compton \
  croscorefonts \
  crosextrafonts-caladea \
  crosextrafonts-carlito \
  sourcecodepro-ttf \
  liberation-fonts-ttf \
  iw-culmus \
  junicode \
  xsetroot \
  hsetroot \
  adwaita-icon-theme \
  gtk-engines2 \
  clearlooks-phenix-theme \
  py27-xdg \
  openbox \
  openbox-themes \
  obconf \
  tint2 \
  gsimplecal \
  terminator \
  gmrun \
  pcmanfm-qt \
  leafpad \
  lxappearance \
  lxrandr \
  parcellite \
  virtualbox-ose-additions \
  lxtask \
  meld \
  geany \
  dtb \
  raspberrypi-firmware-boot \
  odroid-c1-boot-files \
  u-boot \
  sunxi-tools \
  || exit 1
