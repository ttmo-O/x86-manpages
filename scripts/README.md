# Steps to reproduce

You need:

- https://github.com/threedaymonk/htmlbeautifier.git
- https://github.com/kangax/html-minifier.git
- https://github.com/cpuguy83/go-md2man.git
- https://github.com/jgm/pandoc.git
- GNU sed
- Some other GNU tools


After getting them, download felixcloutier.com/x86 website (w/ httrack etc.) or better, use what he used to generate html files from pdf (see [zneak/x86doc](https://github.com/zneak/x86doc).

Now, run; e.g `./doit.sh ret.html` to get `ret.7`

If you want to build them all, run it like:

```
for i in $(ls www.felixcloutier.com/x86); do ./doit.sh www.felixcloutier.com/x86/$i; done
```

NOTE: index.html converted to `x86-manpages.7` and edited manually.
