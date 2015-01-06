#!/usr/bin/env bash 
set -e
set -x

declare -A versions
versions[musl]=1.0.4
versions[skalibs]=2.1.0.0
versions[execline]=2.0.1.0
versions[s6]=2.0.0.1

declare -A includes
includes[skalibs]="--with-include=/usr/musl/include"
includes[execline]="--with-include=/usr/musl/include --with-include=/opt/skalibs/usr/include"
includes[s6]="--with-include=/usr/musl/include --with-include=/opt/skalibs/usr/include --with-include=/opt/execline/usr/include"

declare -A libs
libs[skalibs]="--with-lib=/usr/musl/lib"
libs[execline]="--with-lib=/usr/musl/lib --with-lib=/opt/skalibs/usr/lib/skalibs"
libs[s6]="--with-lib=/usr/musl/lib --with-lib=/opt/skalibs/usr/lib/skalibs --with-lib=/opt/execline/usr/lib/execline"

declare -A sysdeps
sysdeps[skalibs]=""
sysdeps[execline]="--with-sysdeps=/opt/skalibs/usr/lib/skalibs/sysdeps"
sysdeps[s6]="--with-sysdeps=/opt/skalibs/usr/lib/skalibs/sysdeps"

function build_skarnet_package {
  local package=$1
  cd /build
  curl -R -L -O "http://skarnet.org/software/${package}/${package}-${versions[$package]}.tar.gz"
  tar xf "${package}-${versions[$package]}.tar.gz"
  cd "${package}-${versions[$package]}"
  CC="musl-gcc" ./configure \
    --prefix=/usr \
    --disable-shared \
    ${includes[$package]} \
    ${libs[$package]} \
    ${sysdeps[$package]} \
    --enable-force-devr
  make
  make DESTDIR="/opt/${package}" install
}

function tar_skarnet_package {
  local package=$1
  local version=$2
  rm -rf "/opt/${package}/usr/lib"
  rm -rf "/opt/${package}/usr/include"
  tar -cf "/output/${package}-${versions[$package]}-musl-static.tar" -C "/opt/${package}" .
}

# install musl
curl -R -L -O http://www.musl-libc.org/releases/musl-${versions[musl]}.tar.gz
tar xf musl-${versions["musl"]}.tar.gz
cd musl-${versions["musl"]}
CFLAGS="-fno-toplevel-reorder -fno-stack-protector" ./configure --prefix=/usr/musl --exec-prefix=/usr --disable-shared
make
make install

# install skalibs
build_skarnet_package skalibs
build_skarnet_package execline
build_skarnet_package s6

install -D -m644 /etc/leapsecs.dat /opt/s6/etc/leapsecs.dat

tar_skarnet_package execline
tar_skarnet_package s6
