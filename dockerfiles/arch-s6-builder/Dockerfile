FROM jprjr/arch:latest
MAINTAINER John Regan <john@jrjrtech.com>

RUN pacman -Syy > /dev/null 2>/dev/null && \
    pacman -S --noconfirm --quiet --needed base-devel curl > /dev/null 2>/dev/null && \
    pacman -S --noconfirm --quiet --needed --asdeps git jshon expac > /dev/null 2>/dev/null

RUN mkdir -p /build && mkdir -p /output

ADD build.sh /opt/build.sh

VOLUME "/build"
VOLUME "/output"

