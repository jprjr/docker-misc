FROM jprjr/centos-php-fpm
MAINTAINER John Regan <john@jrjrtech.com>

RUN yum -y install git rsync imagemagick ghostscript \
    subversion php-pear-Mail-mimeDecode \
    php-pear-HTTP-OAuth unzip tar gzip bzip2 \
    php-pecl-ssh2 php-imap samba-client \
    gcc php-devel libattr-devel patch librsync-devel && \
    pear config-set preferred_state alpha && \
    pear install VersionControl_Git && \
    pear config-set preferred_state stable && \
    pear install HTTP_WebDAV_Client && \
    pecl config-set preferred_state beta && \
    pecl install rsync && \
    pecl config-set preferred_state stable && \
    echo "extension=rsync.so" > /etc/php.d/rsync.ini && \
    yes '' | pecl install xattr && \
    echo "extension=xattr.so" > /etc/php.d/xattr.ini && \
    sed -i '/^file_uploads/c \
file_uploads = On' /etc/php.ini && \
    sed -i '/^post_max_size/c \
post_max_size = 2G' /etc/php.ini && \
    sed -i '/^upload_max_filesize/c \
upload_max_filesize = 2G' /etc/php.ini && \
    sed -i '/^max_file_uploads/c \
max_file_uploads = 20000' /etc/php.ini && \
    sed -i '/^output_buffering/c \
output_buffering = Off' /etc/php.ini && \
    sed -i '/^open_basedir/c \
open_basedir = /usr/share/webapps/pydio/:/tmp/:/usr/share/pear/:/var/lib/pydio/:/etc/pydio/' /etc/php.ini && \
    mkdir -p /usr/share/webapps && \
    mkdir -p /var/lib/pydio &&  \
    mkdir -p /etc/pydio && \
    cd /usr/share/webapps && \
    curl -R -L \
    "http://downloads.sourceforge.net/project/ajaxplorer/pydio/stable-channel/6.0.2/pydio-core-6.0.2.tar.gz" \
    | tar xz  && \
    mv pydio-core-6.0.2/data /usr/share/webapps/pydio-data-6.0.2  && \
    mv pydio-core-6.0.2/conf /usr/share/webapps/pydio-conf-6.0.2 && \
    mv /usr/share/webapps/pydio-core-6.0.2 /usr/share/webapps/pydio && \
    cd /usr/share/webapps/pydio/plugins/access.s3 && \
    curl -R -L -O "https://github.com/aws/aws-sdk-php/releases/download/2.7.12/aws.phar" && cd /usr/share/webapps && \
    ln -s /var/lib/pydio/data /usr/share/webapps/pydio/data && \
    ln -s /etc/pydio /usr/share/webapps/pydio/conf && \
    chown -R apache:apache /var/lib/pydio && \
    chown -R apache:apache /etc/pydio && \
    chown -R apache:apache /usr/share/webapps

COPY root /

# Volumes to export
VOLUME /etc/pydio
VOLUME /usr/share/webapps/pydio
VOLUME /var/lib/pydio/data

# Port 9000 (fastcgi) is implied by parent
# WebSockets port
EXPOSE 8090

