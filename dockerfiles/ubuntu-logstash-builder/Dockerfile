FROM ubuntu:14.04
MAINTAINER John Regan <john@jrjrtech.com>

RUN apt-get update 
RUN apt-get install -y build-essential golang git ruby ruby-dev
RUN gem install fpm

ADD build.sh /opt/build.sh

RUN mkdir -p /build && mkdir -p /output

VOLUME "/build"
VOLUME "/output"

ENTRYPOINT ["/opt/build.sh"]
