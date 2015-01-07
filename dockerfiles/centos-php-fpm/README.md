# jprjr/centos-php-fpm

This is a CentOS-based image with PHP-FPM installed. It's meant to be similar to my `jprjr/php-fpm` image, just
based off of CentOS.

## Usage

This is really meant to be used for building new docker images with
your PHP app. Here's a [blog post](https://jrjrtech.com/blog/2014/03/27/docker_fastcgi_pydio/) I wrote on using fastcgi and docker.

You can connect this to another container running NGINX or Apache, or just run NGINX in
the container by setting the `EMBEDDED_NGINX` environment variable to 1.

If all you need is a basic PHP setup, you can either:

* Create a new Docker image based off of this and add your code to `/srv/http`
* Run this image as-is, and use `/srv/http` to bring in own PHP code.

### Build

```
$ docker build -t <repo name> .
```

### Examples

```
$ docker run -p 9000 jprjr/centos-php-fpm # For using your own nginx proxy
$ docker run -p 80 -e EMBEDDED_NGINX=1 -v /path/to/whatever:/srv/http jprjr/centos-php-fpm # for using the embedded nginx proxy w/ your own app at /path/to/whatever
```


## Exposed ports

* 9000

## Volumes

* `/srv/http`
