FROM jprjr/centos-php-fpm
MAINTAINER John Regan <john@jrjrtech.com>

RUN yum -y install git rsync imagemagick ghostscript \
    subversion php-pear-Mail-mimeDecode \
    php-pear-HTTP-OAuth unzip tar gzip bzip2 \
    php-pecl-ssh2 php-imap samba-client \
    gcc php-devel libattr-devel patch librsync-devel

RUN pear config-set preferred_state alpha && \
    pear install VersionControl_Git && \
    pear config-set preferred_state stable

RUN pear install HTTP_WebDAV_Client

RUN pecl config-set preferred_state beta && \
    pecl install rsync && \
    pecl config-set preferred_state stable && \
    echo "extension=rsync.so" > /etc/php.d/rsync.ini

RUN yes '' | pecl install xattr && \
    echo "extension=xattr.so" > /etc/php.d/xattr.ini

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
open_basedir = /usr/share/webapps/pydio/:/tmp/:/usr/share/pear/:/var/lib/pydio/:/etc/pydio/' /etc/php.ini

ADD pydio_enhance_websocket_settings.patch /opt/pydio_enhance_websocket_settings.patch

RUN mkdir -p /usr/share/webapps && \
    mkdir -p /var/lib/pydio &&  \
    mkdir -p /etc/pydio && \
    cd /usr/share/webapps && \
    curl -R -L \
    "http://downloads.sourceforge.net/project/ajaxplorer/pydio/stable-channel/5.2.3/pydio-core-5.2.3.tar.gz" \
    | tar xz  && \
    curl -R -L -O \
    "http://pear.amazonwebservices.com/get/sdk-1.6.2.zip" && \
    unzip sdk-1.6.2.zip && rm sdk-1.6.2.zip && \
    mv pydio-core-5.2.3/data /usr/share/webapps/pydio-data-5.2.3  && \
    mv pydio-core-5.2.3/conf /usr/share/webapps/pydio-conf-5.2.3 && \
    mv /usr/share/webapps/pydio-core-5.2.3 /usr/share/webapps/pydio && \
    cd pydio && patch -p 1 -i /opt/pydio_enhance_websocket_settings.patch && cd .. && \
    mv sdk-1.6.2 /usr/share/webapps/pydio/plugins/access.s3/aws-sdk && \
    ln -s /var/lib/pydio/data /usr/share/webapps/pydio/data && \
    ln -s /etc/pydio /usr/share/webapps/pydio/conf && \
    chown -R apache:apache /var/lib/pydio && \
    chown -R apache:apache /etc/pydio && \
    chown -R apache:apache /usr/share/webapps

ADD init_data_folder.sh /opt/init_data_folder.sh
ADD init_conf_folder.sh /opt/init_conf_folder.sh
ADD init_folders.sh     /opt/init_folders.sh
RUN /opt/init_folders.sh

# Volumes to export
VOLUME /etc/pydio
VOLUME /usr/share/webapps/pydio
VOLUME /var/lib/pydio/data

# Port 9000 (fastcgi) is implied by parent
# WebSockets port
EXPOSE 8090

