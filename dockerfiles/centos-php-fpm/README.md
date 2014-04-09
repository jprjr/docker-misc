# jprjr/centos-php-fpm

This is a CentOS-based image with PHP-FPM installed. It's meant to be similar to my `jprjr/php-fpm` image, just
based off of CentOS.

It's pre-configured to listen on port 9000.

## Usage

This is really meant to be used for building new docker images with
your PHP app. Here's a [blog post](https://jrjrtech.com/blog/2014/03/27/docker_fastcgi_pydio/) I wrote on using fastcgi and docker.

It uses php-fpm as the entrypoint.

### Build

```
$ docker build -t <repo name>.
```

### Run in foreground

```
$ docker run -p 9000 jprjr/php-fpm
```

### Run in background
```
$ docker run -d -p 9000 jprjr/php-fpm
```

## Exposed ports

* 9000
