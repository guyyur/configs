#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "pacman.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- install --
pacman --root /mnt --dbpath /mnt/usr/db/pacman -Sy || exit 1
pacman --root /mnt --dbpath /mnt/usr/db/pacman -S \
  bash \
  binutils \
  bzip2 \
  coreutils \
  cronie \
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
  linux-lts \
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
  procps-ng \
  psmisc \
  sed \
  shadow \
  sysfsutils \
  syslog-ng \
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
  hdparm \
  sdparm \
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
  openssh \
  rpcbind \
  nfsidmap \
  nfs-utils \
  tcpdump \
  openbsd-netcat \
  ca-certificates \
  wget \
  sg3_utils \
  alsa-utils \
  alsa-oss \
  bc \
  kbd \
  hexedit \
  unzip \
  linux-api-headers \
  linux-headers \
  autoconf \
  automake \
  bison \
  ed \
  fakeroot \
  flex \
  gcc \
  libtool \
  m4 \
  make \
  patch \
  pkg-config \
  bin86 \
  indent \
  python \
  gdb \
  strace \
  cdrkit \
  cifs-utils \
  smbclient \
  samba \
  mercurial \
  git \
  abs \
  dbus \
  xf86-input-libinput \
  xorg-server \
  xorg-xinit \
  xorg-utils \
  xorg-xkb-utils \
  xorg-server-utils \
  libxkbcommon-x11 \
  compton \
  ttf-liberation \
  ttf-dejavu \
  ttf-junicode \
  hicolor-icon-theme \
  xterm \
  libxss \
  libnotify \
  virtualbox-guest-modules-arch \
  virtualbox-guest-utils \
  gtk-engines \
  adwaita-icon-theme \
  gnome-icon-theme \
  python2-xdg \
  openbox \
  obconf \
  openbox-themes \
  tint2 \
  gsimplecal \
  lxqt-notificationd \
  gmrun \
  pcmanfm \
  leafpad \
  lxappearance \
  lxrandr \
  parcellite \
  lxtask \
  geany \
  meld \
  || exit 1

pacman -U --root /mnt --dbpath /mnt/usr/db/pacman \
  /var/cache/pacman/AUR_pkg/hsetroot-*-x86_64.pkg.tar.xz \
  /var/cache/pacman/AUR_pkg/clearlooks-phenix-gtk-theme-*-any.pkg.tar.xz \
  /var/cache/pacman/AUR_pkg/ttf-chromeos-fonts-*-any.pkg.tar.xz \
  /var/cache/pacman/AUR_pkg/ttf-caladea-*-any.pkg.tar.xz \
  /var/cache/pacman/AUR_pkg/ttf-carlito-*-any.pkg.tar.xz \
  || exit 1

ln -sfn ../proc/self/mounts /mnt/etc/mtab || exit 1

/mnt/usr/bin/extlinux --install /mnt/boot/syslinux || exit 1
ln -sfn /usr/lib/syslinux/bios/libutil.c32 /mnt/boot/syslinux/libutil.c32 || exit 1
ln -sfn /usr/lib/syslinux/bios/menu.c32 /mnt/boot/syslinux/menu.c32 || exit 1
