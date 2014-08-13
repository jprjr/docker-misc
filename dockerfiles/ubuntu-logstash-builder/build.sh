#!/usr/bin/env bash 
set -e

cd /build

if [ ! -d logstash-forwarder ]; then
  git clone git://github.com/elasticsearch/logstash-forwarder.git
fi
cd logstash-forwarder
git pull
go build
make deb
mv *.deb /output/
