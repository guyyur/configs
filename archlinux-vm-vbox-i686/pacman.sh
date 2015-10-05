#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "pacman.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- set up dirs --
install -d -m 755 -o root -g root /mnt/usr/db/pacman || exit 1
ln -sfn /var/cache/pacman/sync /mnt/usr/db/pacman/sync || exit 1


# -- install --
pacman --root /mnt --dbpath /mnt/usr/db/pacman -S \
  bash \
  binutils \
  bzip2 \
  coreutils \
  cronie \
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
  gettext \
  glibc \
  grep \
  gzip \
  kmod \
  linux \
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
  gnu-netcat \
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
  dbus \
  xorg-server \
  xorg-xinit \
  xorg-utils \
  xorg-xkb-utils \
  xorg-server-utils \
  libxkbcommon-x11 \
  ttf-liberation \
  ttf-dejavu \
  ttf-junicode \
  hicolor-icon-theme \
  xterm \
  libxss \
  libnotify \
  virtualbox-guest-modules \
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
  gmrun \
  pcmanfm \
  leafpad \
  lxappearance \
  lxrandr \
  parcellite \
  lxtask \
  geany \
  || exit 1

pacman -U --root /mnt --dbpath /mnt/usr/db/pacman \
  /var/cache/pacman/AUR/pkg/hsetroot-*-i686.pkg.tar.xz || exit 1
pacman -U --root /mnt --dbpath /mnt/usr/db/pacman \
  /var/cache/pacman/AUR/pkg/compton-*-i686.pkg.tar.xz || exit 1
pacman -U --root /mnt --dbpath /mnt/usr/db/pacman \
  /var/cache/pacman/AUR/pkg/ttf-chromeos-fonts-*-any.pkg.tar.xz || exit 1
pacman -U --root /mnt --dbpath /mnt/usr/db/pacman \
  /var/cache/pacman/AUR/pkg/ttf-caladea-*-any.pkg.tar.xz || exit 1
pacman -U --root /mnt --dbpath /mnt/usr/db/pacman \
  /var/cache/pacman/AUR/pkg/ttf-carlito-*-any.pkg.tar.xz || exit 1
