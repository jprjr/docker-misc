#!/usr/bin/env bash
set -e

# our target platform
_target=arm-linux-gnueabihf

# docker 0.11.1 borks /dev/fd
ln -sf /proc/self/fd /dev/fd
ln -sf /dev/null /dev/stdin

pacman -Syy
# install packer
pacman -S --noconfirm --quiet --needed distcc base-devel > /dev/null 2>/dev/null
pacman -S --noconfirm --quiet --needed --asdeps gperf git jshon expac > /dev/null 2>/dev/null

mkdir /tmp/packer && \
    cd /tmp/packer && \
    curl -R -L -O https://aur.archlinux.org/packages/pa/packer/PKGBUILD 2>/dev/null && \
    makepkg --asroot -i --noconfirm >/dev/null 2>/dev/null && \
    cd / && rm -rf /tmp/packer

# install the basic, non-conflicting stuff
packer -S --noconfirm --noedit ${_target}-binutils 
packer -S --noconfirm --noedit ${_target}-linux-api-headers 
packer -S --noconfirm --noedit ${_target}-gcc-stage1
packer -S --noconfirm --noedit ${_target}-eglibc-headers 

# build gcc stage2 and remove gcc stage 1
cd /tmp && packer -G ${_target}-gcc-stage2
cd ${_target}-gcc-stage2
makepkg --asroot -s
pacman -Rdd --noconfirm ${_target}-gcc-stage1
pacman -U --noconfirm ${_target}-gcc-stage2*.pkg.tar*

# build eglibc and remove eglibc-headers
cd /tmp && packer -G ${_target}-eglibc
cd ${_target}-eglibc
makepkg --asroot -s --noconfirm
pacman -Rdd --noconfirm ${_target}-eglibc-headers
pacman -U --noconfirm ${_target}-eglibc*.pkg.tar*

# build gcc and remove gcc-stage2
cd /tmp && packer -G ${_target}-gcc
cd ${_target}-gcc
makepkg --asroot 
pacman -Rdd --noconfirm ${_target}-gcc-stage2
pacman -U --noconfirm ${_target}-gcc*.pkg.tar*

cd /

# make handy symlinks for distcc
mkdir /usr/bin/${_target}

for file in /usr/bin/${_target}-*
do
  ln -s $file /usr/bin/${_target}/${file#/usr/bin/${_target}-}
done

# cleanup tmp
rm -rf /tmp/*

pacman -Ru --noconfirm packer
pacman -R --noconfirm $(pacman -Qdtq)
paccache -rk0
pacman -Scc --noconfirm
