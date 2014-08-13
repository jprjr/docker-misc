# jprjr/syslog-ng

This is an Arch-based image with syslog-ng installed. This is (potentially) useful for creating a centralized logging solution.

## Usage

This image starts syslog-ng. By default, it's configured to listen for udp
traffic on port 514, and tcp traffic on port 601. All traffic is just logged
to stdout. Note: the image doesn't have any ports exposed by default.

It reads a configuration file at `/opt/syslog-ng/syslog-ng.conf` - you can
bind a volume to `/opt/syslog-ng` and use your own configuration.

So out of the box, it doesn't do a whole lot. But I can think of a few use
cases where this is useful.

* Use this as a central collection point, and filter/log messages to files.
* Use this as a central collection point, and filter/log messages to a SQL server.

## Default Entry Point

The default behavior of this image is to run `syslog-ng` in the foreground.

### Build

```
$ docker build -t <repo name> .
```

### Run in foreground
```
$ docker run --expose 514/udp --expose 601/tcp -v /path/to/config/folder:/opt/syslog-ng jprjr/syslog-ng
```

### Run in background
```
$ docker run -d --expose 514/udp --expose 601/tcp -v /path/to/config/folder:/opt/syslog-ng jprjr/syslog-ng
```

## Exposed ports

* None by default

## Exposed volumes

* `/opt/syslog-ng` (For loading a custom `syslog-ng.conf` file)
