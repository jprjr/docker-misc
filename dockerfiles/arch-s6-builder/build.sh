#!/usr/bin/env bash 
set -e
set -x

declare suffix="musl-static"

declare -A versions
versions[musl]=1.0.4
versions[skalibs]=2.2.1.0
versions[execline]=2.0.2.0
versions[s6]=2.1.0.1
versions[s6-portable-utils]=2.0.0.1
versions[s6-linux-utils]=2.0.0.1
versions[s6-dns]=2.0.0.2
versions[s6-networking]=2.1.0.0
versions[dash]=0.5.8

declare -A includes
includes[skalibs]="--with-include=/usr/musl/include"
includes[execline]="--with-include=/usr/musl/include --with-include=/opt/skalibs/usr/include"
includes[s6]="--with-include=/usr/musl/include --with-include=/opt/skalibs/usr/include --with-include=/opt/execline/usr/include"
includes[s6-portable-utils]=${includes['s6']}
includes[s6-linux-utils]="${includes['s6']} --with-include=/usr/linux-api/usr/include"
includes[s6-dns]=${includes['s6']}
includes[s6-networking]="${includes['s6']} --with-include=/opt/s6/usr/include --with-include=/opt/s6-dns/usr/include"

declare -A libs
libs[skalibs]="--with-lib=/usr/musl/lib"
libs[execline]="--with-lib=/usr/musl/lib --with-lib=/opt/skalibs/usr/lib/skalibs"
libs[s6]="--with-lib=/usr/musl/lib --with-lib=/opt/skalibs/usr/lib/skalibs --with-lib=/opt/execline/usr/lib/execline"
libs[s6-portable-utils]=${libs['s6']}
libs[s6-linux-utils]=${libs['s6']}
libs[s6-dns]=${libs['s6']}
libs[s6-networking]="${libs['s6']} --with-lib=/opt/s6/usr/lib/s6 --with-lib=/opt/s6-dns/usr/lib/s6-dns"

declare -A sysdeps
sysdeps[skalibs]=""
sysdeps[execline]="--with-sysdeps=/opt/skalibs/usr/lib/skalibs/sysdeps"
sysdeps[s6]="--with-sysdeps=/opt/skalibs/usr/lib/skalibs/sysdeps"
sysdeps[s6-portable-utils]=${sysdeps['s6']}
sysdeps[s6-linux-utils]=${sysdeps['s6']}
sysdeps[s6-dns]=${sysdeps['s6']}
sysdeps[s6-networking]=${sysdeps['s6']}

function build_skarnet_package { # {{{
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
} # }}}

function tar_package { # {{{
  local package=$1

  if [[ -d "/opt/${package}/usr/bin" ]]; then
    find "/opt/${package}/usr/bin" -type f -exec strip {} \;
  fi

  tar -czf "/output/${package}-${versions[$package]}-${suffix}.tar.gz" \
      --exclude "usr/lib" \
      --exclude "usr/include" \
      -C "/opt/${package}" .

  local dev_directories=""
  if [[ -d "/opt/${package}/usr/lib" ]]; then
    dev_directories="usr/lib"
  fi
  if [[ -d "/opt/${package}/usr/include" ]]; then
    dev_directories="${dev_directories} usr/include"
  fi

  if [[ -n "${dev_directories}" ]]; then
    tar -czf "/output/${package}-${versions[$package]}-${suffix}-dev.tar.gz" \
      -C "/opt/${package}" $dev_directories
  fi
} # }}}

# install musl
cd /build
curl -R -L -O http://www.musl-libc.org/releases/musl-${versions[musl]}.tar.gz
tar xf musl-${versions["musl"]}.tar.gz
cd musl-${versions["musl"]}
CFLAGS="-fno-toplevel-reorder -fno-stack-protector" ./configure --prefix=/usr/musl --exec-prefix=/usr --disable-shared
make
make install

# build dash
mkdir /opt/dash
cd /build
curl -R -L -O http://gondor.apana.org.au/~herbert/dash/files/dash-${versions["dash"]}.tar.gz
tar xf dash-${versions["dash"]}.tar.gz
cd dash-${versions["dash"]}
CC=musl-gcc ./configure --prefix=/usr --bindir=/usr/bin --mandir=/usr/share/man --exec-prefix="" --enable-static
make
make DESTDIR=/opt/dash install

# install skalibs
build_skarnet_package skalibs
build_skarnet_package execline

for package in 's6' 's6-portable-utils' 's6-linux-utils' 's6-dns' 's6-networking'; do
  build_skarnet_package ${package}
done

install -D -m644 /etc/leapsecs.dat /opt/skalibs/etc/leapsecs.dat
rm /opt/skalibs/usr/etc/leapsecs.dat

for package in 'dash' 'skalibs' 'execline' 's6' 's6-portable-utils' 's6-linux-utils' 's6-dns' 's6-networking'; do
  tar_package ${package}
done
