FROM jprjr/arch:latest
MAINTAINER John Regan <john@jrjrtech.com>

RUN pacman -Syy && \
    pacman -Syu --noconfirm --quiet && \
    pacman -S --noconfirm --quiet --needed base-devel curl && \
    pacman -S --noconfirm --quiet --needed --asdeps git jshon expac && \
    pacman -S --noconfirm --quiet linux-api-headers

RUN mkdir -p /build && mkdir -p /output && \
    mkdir -p /usr/linux-api && \
    cd /usr/linux-api && \
    tar xf /var/cache/pacman/pkg/linux-api-headers-$(pacman -Q linux-api-headers | cut -f 2 -d ' ')-x86_64.pkg.tar.xz

ADD build.sh /opt/build.sh

VOLUME "/build"
VOLUME "/output"

