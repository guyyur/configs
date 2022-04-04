#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
  echo "pacman.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- install --
pacman --root /mnt --dbpath /mnt/usr/db/pacman --cachedir /mnt/var/cache/pacman/pkg -Sy || exit 1
pacman --root /mnt --dbpath /mnt/usr/db/pacman --cachedir /mnt/var/cache/pacman/pkg -S \
  bash \
  binutils \
  bzip2 \
  coreutils \
  cryptsetup \
  dash \
  device-mapper \
  diffutils \
  e2fsprogs \
  dosfstools \
  file \
  filesystem \
  findutils \
  gawk \
  gcc-libs \
  gdisk \
  gettext \
  glibc \
  grep \
  gzip \
  kmod \
  linux \
  linux-api-headers \
  linux-firmware \
  less \
  licenses \
  logrotate \
  man-db \
  man-pages \
  mkinitcpio \
  nano \
  pacman \
  pacman-mirrorlist \
  parted \
  gptfdisk \
  procps-ng \
  psmisc \
  sed \
  shadow \
  sysfsutils \
  systemd \
  tar \
  tzdata \
  util-linux \
  vi \
  which \
  syslinux \
  zsh \
  sharutils \
  lsof \
  pciutils \
  libusb \
  usbutils \
  dmidecode \
  sysstat \
  time \
  openresolv \
  dhcpcd \
  inetutils \
  iputils \
  iproute2 \
  ethtool \
  net-tools \
  ndisc6 \
  traceroute \
  ipv6calc \
  openssh \
  rpcbind \
  nfsidmap \
  nfs-utils \
  tcpdump \
  openbsd-netcat \
  ca-certificates \
  curl \
  wget \
  alsa-utils \
  alsa-oss \
  bc \
  kbd \
  autoconf \
  automake \
  bison \
  ed \
  fakeroot \
  flex \
  libtool \
  m4 \
  make \
  patch \
  pkg-config \
  gdb \
  strace \
  gcc \
  dos2unix \
  exfatprogs \
  python \
  tmux \
  git \
  iperf \
  dbus \
  polkit \
  xf86-input-libinput \
  xorg-server \
  xorg-xinit \
  xorg-xkbutils \
  libxkbcommon-x11 \
  xorg-xbacklight \
  xorg-xhost \
  xorg-xinput \
  xorg-xrandr \
  xorg-xset \
  xorg-xdpyinfo \
  xorg-xdriinfo \
  xorg-xev \
  xorg-xprop \
  xorg-xvinfo \
  xorg-xwininfo \
  xorg-xwayland \
  ttf-liberation \
  ttf-dejavu \
  hicolor-icon-theme \
  xterm \
  ttf-caladea \
  ttf-carlito \
  ttf-croscore \
  ttf-junicode \
  libnotify \
  picom \
  hsetroot \
  adwaita-icon-theme \
  gnome-icon-theme \
  oxygen-icons \
  gtk-engines \
  gnome-themes-extra \
  gtk-engine-murrine \
  arc-solid-gtk-theme \
  qt5-wayland \
  python-pyxdg \
  openbox \
  obconf-qt \
  tint2 \
  gsimplecal \
  lxqt-notificationd \
  qterminal \
  gmrun \
  pcmanfm-qt \
  leafpad \
  featherpad \
  lxappearance \
  lxrandr \
  lxtask \
  meld \
  geany \
  || exit 1

echo -n > /tmp/aur_pkg_list

if [ -s /tmp/aur_pkg_list ]; then
  cat /tmp/aur_pkg_list | pacman -U --root /mnt --dbpath /mnt/usr/db/pacman - || exit 1
fi

chroot /mnt locale-gen || exit 1

/mnt/usr/bin/extlinux --install /mnt/boot/syslinux || exit 1
ln -sfn /usr/lib/syslinux/bios/libutil.c32 /mnt/boot/syslinux/libutil.c32 || exit 1
ln -sfn /usr/lib/syslinux/bios/menu.c32 /mnt/boot/syslinux/menu.c32 || exit 1
