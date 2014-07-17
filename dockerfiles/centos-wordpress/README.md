# jprjr/centos-wordpress

This is a CentOS-based image with [Wordpress](http://wordpress.org) ver 3.9.1 installed.

It's running as a FastCGI app, listening on port 9000, meaning you'll need to
setup a reverse proxy. 

## Usage

You can run this image out-of-the-box, but if you want persistence you'll
need to mount a volume to `/var/lib/wordpress` and run an initialization
script. This is absolutely required for a production setup.

Also out-of-the-box, there's a default set of config files at `/etc/wordpress` -
if you want to customize those, you'll need to mount a volume to `/etc/wordpress`
and run an initialization script. This is also required for a production setup.

## Default Entry Point

The default behavior of this image is to run `php-fpm` in the foreground.

## Alternate Entry Points

There's a few scripts you can use as a default entrypoint, for initializing
your configuration and data volumes:

* `/opt/init_data_folder.sh` - For initializing /var/lib/wordpress
* `/opt/init_conf_folder.sh` - For initializing /etc/wordpress
* `/opt/init_folders.sh` - For initializing both volumes


### Build

```
$ docker build -t <repo name> .
```

### Initialize data folder structure
```
$ docker run -v /path/to/data/folder:/var/lib/wordpress -v /path/to/conf/folder:/etc/wordpress --entrypoint /opt/init_folders.sh jprjr/centos-wordpress
```

### Run in foreground
```
$ docker run -v /path/to/data/folder:/var/lib/wordpress -v /path/to/conf/folder:/etc/wordpress jprjr/centos-wordpress
```

### Run in background
```
$ docker run -d -v /path/to/data/folder:/var/lib/wordpress -v /path/to/conf/folder:/etc/wordpress jprjr/centos-wordpress
```

Alternatively, you should be able to use links and data-only containers for
persistence.

## Exposed ports

* 9000 (fastcgi port)

## Exposed volumes

* `/usr/share/webapps/wordpress` (Files for nginx/apache/etc)
* `/var/lib/wordpress` (Wordpress data/uploaded files)
* `/etc/wordpress` (For storing your wp-config.php)
