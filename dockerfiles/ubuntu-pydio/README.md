# jprjr/ubuntu-pydio

This is a Ubuntu-based image with [Pydio](http://pyd.io) installed.

This is similar to my `jprjr/pydio` image, just with Ubuntu as the host OS instead of
Arch Linux. This means it's running older versions of PHP, Git, etc, which seem
to generally work better with Pydio.

It's running as a FastCGI app, listening on port 9000.

I wrote up a [blog post](https://jrjrtech.com/blog/2014/03/27/docker_fastcgi_pydio/) on using 
`jprjr/pydio` with an nginx proxy, using this will be pretty similar.

## Usage

Pydio expects the data folder to have a certain layout. I've made a small
script to setup the data folder structure at `/opt/init_data_folder.sh` -
you should only have to do this once.

### Build

```
$ docker build -t <repo name> .
```

### Initialize data folder structure
```
$ docker run -v /path/to/perm/folder:/var/lib/pydio/data --entrypoint /opt/init_data_folder.sh jprjr/ubuntu-pydio
```

### Run in foreground
```
$ docker run -v /path/to/perm/folder:/var/lib/pydio/data -p 9000 jprjr/ubuntu-pydio
```

### Run in background
```
$ docker run -d -v /path/to/perm/folder:/var/lib/pydio/data -p 9000 jprjr/ubuntu-pydio
```

Alternatively, you should be able to use links and data-only containers for
persistence.

## Exposed ports

* 9000 (fastcgi port)
* 8090 (default websocket port)

## Exposed volumes

* `/usr/share/webapps/pydio` 
* `/var/lib/pydio/data` 
