FROM jprjr/arch:latest
MAINTAINER John Regan <john@jrjrtech.com>

RUN pacman -Syy --quiet >/dev/null 2>/dev/null && \
    pacman -S --noconfirm --quiet --needed base-devel && \
    mkdir /tmp/musl && cd /tmp/musl && \
    curl -R -L -O https://gist.githubusercontent.com/jprjr/65b5850e54496f75dabd/raw/3fff884f1f49251f782c38ca0069c46ff47cf7ce/PKGBUILD && \
    makepkg --asroot -i --noconfirm > /dev/null 2>/dev/null
