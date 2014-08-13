FROM jprjr/arch
MAINTAINER John Regan <john@jrjrtech.com>

RUN pacman -Sy && \
    pacman -S --noconfirm syslog-ng

RUN mkdir /opt/syslog-ng && \
    echo '@version: 3.5' > /etc/syslog-ng/syslog-ng.conf && \
    echo '@include "/opt/syslog-ng/syslog-ng.conf"' >> /etc/syslog-ng/syslog-ng.conf && \
    touch /opt/syslog-ng/syslog-ng.conf

ADD syslog-ng.conf /opt/syslog-ng/syslog-ng.conf

VOLUME /opt/syslog-ng

ENTRYPOINT ["syslog-ng"]
CMD ["-F","--no-caps"]
