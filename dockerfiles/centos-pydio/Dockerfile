FROM jprjr/centos-php
MAINTAINER John Regan <john@jrjrtech.com>

RUN yum -y install git rsync imagemagick ghostscript \
    subversion php-pear-Mail-mimeDecode \
    php-pear-HTTP-OAuth tar gzip bzip2 

RUN pear config-set preferred_state alpha && \
    pear install VersionControl_Git && \
    pear config-set preferred_state stable

RUN sed -i '/^file_uploads/c \
file_uploads = On' /etc/php.ini

RUN sed -i '/^post_max_size/c \
post_max_size = 2G' /etc/php.ini

RUN sed -i '/^upload_max_filesize/c \
upload_max_filesize = 2G' /etc/php.ini

RUN sed -i '/^max_file_uploads/c \
max_file_uploads = 20000' /etc/php.ini

RUN sed -i '/^output_buffering/c \
output_buffering = Off' /etc/php.ini

RUN sed -i '/^open_basedir/c \
open_basedir = /usr/share/webapps/pydio/:/tmp/:/usr/share/pear/:/var/lib/pydio/' /etc/php.ini

RUN mkdir -p /usr/share/webapps && \
    mkdir -p /var/lib/pydio &&  \
    cd /usr/share/webapps && \
    curl -R -L \
    "http://downloads.sourceforge.net/project/ajaxplorer/pydio/stable-channel/5.2.3/pydio-core-5.2.3.tar.gz" \
    | tar xz  && \
    mv pydio-core-5.2.3/data /usr/share/webapps/pydio-data-5.2.3  && \
    ln -s /usr/share/webapps/pydio-core-5.2.3 /usr/share/webapps/pydio && \
    ln -s /var/lib/pydio/data /usr/share/webapps/pydio/data && \
    chown -R apache:apache /var/lib/pydio && \
    chown -R apache:apache /usr/share/webapps

ADD init_data_folder.sh /opt/init_data_folder.sh
RUN /opt/init_data_folder.sh

# Volumes to export
VOLUME /usr/share/webapps/pydio
VOLUME /var/lib/pydio/data

# Port 9000 (fastcgi) is implied by parent
# WebSockets port
EXPOSE 8090

