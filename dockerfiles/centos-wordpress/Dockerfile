FROM jprjr/centos-php-fpm
MAINTAINER John Regan <john@jrjrtech.com>

RUN yum -y install rsync tar

RUN sed -i '/^file_uploads/c \
file_uploads = On' /etc/php.ini

RUN sed -i '/open_basedir/c \
open_basedir = /usr/share/webapps/wordpress/:/var/lib/wordpress/:/etc/wordpress/:/tmp/' /etc/php.ini

RUN mkdir -p /usr/share/webapps && \
    mkdir -p /var/lib/wordpress && \
    mkdir -p /etc/wordpress && \
    mkdir -p /opt/wp && \
    cd /usr/share/webapps && \
    curl -R -L \
    "http://wordpress.org/wordpress-3.9.1.tar.gz" \
    | tar xz  && \
    mv /usr/share/webapps/wordpress/wp-content /opt/wp/wp-content && \
    mv /usr/share/webapps/wordpress/wp-config-sample.php /opt/wp/wp-config.php && \
    ln -sf /var/lib/wordpress /usr/share/webapps/wordpress/wp-content && \
    ln -sf /etc/wordpress/wp-config.php /usr/share/webapps/wordpress/wp-config.php && \
    chown -R apache:apache /opt/wp && \
    chown -R apache:apache /var/lib/wordpress && \
    chown -R apache:apache /etc/wordpress && \
    chown -R apache:apache /usr/share/webapps

ADD init_data_folder.sh /opt/init_data_folder.sh
ADD init_conf_folder.sh /opt/init_conf_folder.sh
ADD init_folders.sh     /opt/init_folders.sh
RUN /opt/init_folders.sh

# Volumes to export
VOLUME /etc/wordpress
VOLUME /usr/share/webapps/wordpress
VOLUME /var/lib/wordpress

# Port 9000 (fastcgi) is implied by parent

