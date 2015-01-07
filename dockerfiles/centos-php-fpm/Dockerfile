FROM centos:6
MAINTAINER John Regan <john@jrjrtech.com>

RUN rpm -i http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && \
    rpm -i http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm && \
    yum -y install php php-fpm php-gd php-ldap \
    php-sqlite php-pgsql php-pear php-mysql \
    php-mcrypt php-xcache php-xml php-xmlrpc \
    msmtp nginx && \
    sed -i '/^listen/c \
listen = 0.0.0.0:9000' /etc/php-fpm.d/www.conf && \
    sed -i 's/^listen.allowed_clients/;listen.allowed_clients/' /etc/php-fpm.d/www.conf && \
    mkdir -p /srv/http && \
    echo "<?php phpinfo(); ?>" > /srv/http/index.php && \
    chown -R apache:apache /srv/http && \
    chown -R apache:apache /var/run/php-fpm

COPY root /

EXPOSE 9000
VOLUME /srv/http
ENTRYPOINT ["/usr/bin/s6-svscan","/etc/s6"]
CMD []

