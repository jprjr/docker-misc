# jprjr/centos-pydio

This is a CentOS-based image with [Pydio](http://pyd.io) ver 5.2.3 installed.

This is similar to my `jprjr/pydio` image, just with CentOS as the host OS instead of
Arch Linux. This means it's running older versions of PHP, Git, etc, which seem
to generally work better with Pydio.

It's running as a FastCGI app, listening on port 9000, meaning you'll need to
setup a reverse proxy. I have a folder called `example_nginx_conf` to get
a reverse proxy up and running via nginx. The example configuration relies on using 
[container links](https://docs.docker.com/userguide/dockerlinks/) - it
expects your Pydio container to be linked as `pydio`

## Usage

You can run this image out-of-the-box, but if you want persistence you'll
need to mount a volume to `/var/lib/pydio/data` and run an initialization
script. This is absolutely required for a production setup.

Also out-of-the-box, there's a default set of config files at `/etc/pydio` -
if you want to customize those, you'll need to mount a volume to `/etc/pydio`
and run an initialization script. This is not required, but highly recommended.

## Default Entry Point

The default behavior of this image is to run `php-fpm` in the foreground.

## Alternate Entry Points

There's a few scripts you can use as a default entrypoint, for initializing
your configuration and data volumes:

* `/opt/init_data_folder.sh` - For initializing /var/lib/pydio/data
* `/opt/init_conf_folder.sh` - For initializing /etc/pydio
* `/opt/init_folders.sh` - For initializing both volumes

## Upgrading

If you've mounted a volume to `/etc/pydio` (which I recommend) and want
to upgrade to a new version of this image, you should extract the new default
configuration and merge updates in manually.

An easy way to extract the default configuration is to run

`docker run -v /tmp/pydio-conf:/etc/pydio --entrypoint /opt/init_conf_folder.sh jprjr/pydio`

Make a backup of your current configuration, then merge everything in `/tmp/pydio-conf` to your configuration folder.

If you haven't mounted a volume to `/etc/pydio` you should be fine to upgrade
to a newer version of this image without any problems.

### Build

```
$ docker build -t <repo name> .
```

### Initialize data folder structure
```
$ docker run -v /path/to/data/folder:/var/lib/pydio/data -v /path/to/conf/folder:/etc/pydio --entrypoint /opt/init_folders.sh jprjr/centos-pydio
```

### Run in foreground
```
$ docker run -v /path/to/data/folder:/var/lib/pydio/data -v /path/to/conf/folder:/etc/pydio jprjr/centos-pydio
```

### Run in background
```
$ docker run -d -v /path/to/data/folder:/var/lib/pydio/data -v /path/to/conf/folder:/etc/pydio jprjr/centos-pydio
```

Alternatively, you should be able to use links and data-only containers for
persistence.

## Exposed ports

* 9000 (fastcgi port)
* 8090 (default websocket port)

## Exposed volumes

* `/usr/share/webapps/pydio` (Files for nginx/apache/etc)
* `/var/lib/pydio/data` (Pydio data files)
* `/etc/pydio` (Pydio configuration files)
