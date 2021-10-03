Introduction
------------
You can use any external program that accepts wav or raw PCM data to encode audio data and use the resulting compressed 
stream as an output, either to a file, a pipe, or even icecast.

When using an external encoding process, uncompressed PCM data will be sent to the process through its standard input (`stdin`), and encoded data will be read through its standard output (`stdout`). When using a process that does only file input or output, `/dev/stdin` and `/dev/stdout` can be used, though this may generate issues if the encoding process expects to be able to go backward/forward in the file.

External encoders
-----------------
The main operators that can be used with external encoders are:

* `output.file`
* `output.icecast`

In order to use external encoders with these operators, you have to use the 
`%external` [encoding format](encoding_formats.html).
Its syntax is:

```liquidsoap
%external(channels=2,samplerate=44100,header=true,
          restart_on_crash=false,
          restart_on_metadata,
          restart_after_delay=30,
          process="progname")
```

The available options are:

* `process`: this parameter is a function that takes the current metadata and return the process to start.
* `header`: if set to `false` then no WAV header will be added to the data fed to the encoding process, thus the encoding process shall operate on RAW data.
* `restart_on_crash`: wether to restart the encoding process if it crashed. Useful when the external process fails to encode properly data after some time.
* `restart_on_metadata`: restart encoding process on each new metadata:. Useful in conjonction with the `process` parameter for audio formats that need a new header, possibly with metadatas, for each new track. This is the case for the ogg container.
* `restart_encoder_delay`: Restart the encoder after some delay. This can be useful for encoders that cannot operate on infinite streams, or are buggy after some time, like the `lame` binary. The default for `lame` and `accplusenc`-based encoders is to restart the encoder every hour.

Only one of `restart_encoder_delay` or `restart_on_new_track` should be used.

The restart mechanism strongly relies on the good behaviour of the encoding process. The restart operation will 
close the standard input of the encoding process. The encoding process is then expected to finish its own operations and
close its standard output. If it does not close its standard output, the encoding task will not finish. 

If your encoding process has this issue, you should turn the `restart_on_crash` option to `true` and kill the encoding
process yourself.

If you use an external encoder with the `output.icecast` operator,
you should also use the following options of `output.icecast`:

* `icy_metadata`: send new metadata as ICY update. This is the case for headerless formats, such as MP3 or AAC, and it appears to work also for ogg/vorbis streams.
* `format`: Content-type (mime) of the data sent to icecast. For instance, for ogg data, it is one of ``application/ogg'', ``audio/ogg'' or ``video/ogg'' and for mp3 data it is ``audio/mpeg''.

Video support
-------------
Videos can also be encoded by programs able to read files in avi format from
standard input. To use it, the flag `video=true` of `%external` should be
used. For instance, a compresed avi file can be generated with `ffmpeg` using

```liquidsoap
output.file(
  %external(process="ffmpeg -i pipe:0 -f avi pipe:1",video=true),
  "/tmp/test.avi", s)
```
