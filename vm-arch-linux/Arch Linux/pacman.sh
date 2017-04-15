#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
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
  linux-lts \
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
  indent \
  python \
  samba \
  git \
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
  hicolor-icon-theme \
  xterm \
  ttf-junicode \
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
  terminator \
  gmrun \
  pcmanfm-qt \
  leafpad \
  lxappearance \
  lxrandr \
  parcellite \
  lxtask \
  meld \
  geany \
  || exit 1

echo -n > /tmp/aur_pkg_list
ls /mnt/var/cache/pacman/AUR_pkg/clearlooks-phenix-gtk-theme-*-any.pkg.tar.xz >> /tmp/aur_pkg_list || exit 1
ls /mnt/var/cache/pacman/AUR_pkg/ttf-chromeos-fonts-*-any.pkg.tar.xz >> /tmp/aur_pkg_list || exit 1
ls /mnt/var/cache/pacman/AUR_pkg/ttf-caladea-*-any.pkg.tar.xz >> /tmp/aur_pkg_list || exit 1
ls /mnt/var/cache/pacman/AUR_pkg/ttf-carlito-*-any.pkg.tar.xz >> /tmp/aur_pkg_list || exit 1
ls /mnt/var/cache/pacman/AUR_pkg/hsetroot-*-x86_64.pkg.tar.xz >> /tmp/aur_pkg_list || exit 1

if [ -s /tmp/aur_pkg_list ]; then
  cat /tmp/aur_pkg_list | pacman -U --root /mnt --dbpath /mnt/usr/db/pacman - || exit 1
fi

ln -sfn ../proc/self/mounts /mnt/etc/mtab || exit 1

/mnt/usr/bin/extlinux --install /mnt/boot/syslinux || exit 1
ln -sfn /usr/lib/syslinux/bios/libutil.c32 /mnt/boot/syslinux/libutil.c32 || exit 1
ln -sfn /usr/lib/syslinux/bios/menu.c32 /mnt/boot/syslinux/menu.c32 || exit 1
