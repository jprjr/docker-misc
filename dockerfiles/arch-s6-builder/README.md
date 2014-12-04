# jprjr/s6-builder-debug

This is just a small utility image for building [s6](http://www.skarnet.org/software/s6/), a set of process supervision programs.

You'll want to mount a volume to `/output`

## example

```bash
$ docker build -t jprjr/s6-builder-debug .
$ mkdir output
$ docker run -v $(pwd)/output:/output jprjr/s6-builder-debug /opt/build.sh
```

If everything works correctly, you'll have a .tar file in `output`
