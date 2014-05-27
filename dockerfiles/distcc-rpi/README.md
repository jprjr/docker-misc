# jprjr/distcc-rpi

This is an Arch Linux-based image running distcc and with a Raspberry Pi
cross-compiler installed.

I'm not gonna lie, I haven't gotten to try this out with an actual Raspberry Pi
just yet, but this ought to work. I think?

This may or may not compile to other ARM platforms, I'm not entirely sure.
This is either really cool or completely useless.

This is running on the standard distcc port (3632).

### Build

```
$ docker build -t <repo name> .
```

### Run in foreground
```
$ docker run -p 3632 jprjr/distcc-rpi
```

### Run in background
```
$ docker run -d -p 3632 jprjr/distcc-rpi
```

## Exposed ports

* 3632 (distcc port)

