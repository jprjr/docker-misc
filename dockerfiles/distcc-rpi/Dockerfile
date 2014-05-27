FROM jprjr/arch
MAINTAINER John Regan <john@jrjrtech.com>

ADD build.sh /tmp/build.sh
RUN /tmp/build.sh

ENV PATH /usr/bin/arm-linux-gnueabihf:$PATH
USER nobody
EXPOSE 3632
ENTRYPOINT ["distccd"]
CMD ["--no-detach", \
     "--daemon", \
     "--allow", "0.0.0.0"]
