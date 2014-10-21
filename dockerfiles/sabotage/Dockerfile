FROM jprjr/sabotagelinux-stage0:latest
MAINTAINER John Regan <john@jrjrtech.com>

RUN cd /src && mkdir tarballs &&\
    sed -i 's/MAKE_THREADS=1/MAKE_THREADS=2/' config && \
    butch install stage1 && \
    cd / && rm -rf /src/build/* /src/tarballs/*
