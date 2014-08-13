# jprjr/logstash-forwarder-builder:ubuntu

I know this name is terrible, but this is just a small utility image.

All it does is git-clone logstash-forwarder, build it, and make a debian
package.

You'll want to mount a volume to `/output`

## example

```bash
$ docker build -t jprjr/logstash-forwarder-builder:ubuntu .
$ mkdir output
$ docker run -v $(pwd)/output:/output prjr/logstash-forwarder-builder:ubuntu
```

If everything works correctly, you'll have a .deb file in `output`
