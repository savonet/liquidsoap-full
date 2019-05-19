Liquidsoap configuration
========================
ALSA configuration
------------------
### Buffer size, in frames.
Default: `1`

```
set("alsa.buffer_length",1)
```

This is only used for buffered ALSA I/O, and affects the latency.

### Number of periods
Default: `5`

```
set("alsa.periods",5)
```

Audio settings
--------------
Conversion settings
-------------------
Samplerate conversion settings
------------------------------
Libsamplerate conversion settings
---------------------------------
### Resampling quality
Default: `"zero_order"`

```
set("audio.converter.samplerate.libsamplerate.quality","zero_order")
```

Resampling quality, one of: ``best'', ``medium'', ``fast'', ``zero_order'', ``linear''. Refer to ocaml-samplerate for details.

### Prefered samplerate converter
Default: `"libsamplerate"`

```
set("audio.converter.samplerate.prefered","libsamplerate")
```

Prefered samplerate converter.

Parameters for buffering.
-------------------------
### Kind of buffering for audio data (default|raw|disk|disk_manyfiles).
Default: `"default"`

```
set("buffering.kind","default")
```

If set to raw, liquidsoap will use raw s16le pcm format 
when buffering audio data.
If set to disk, liquidsoap will store buffered data on 
disk (disk_manyfiles is the same but is a bit faster at 
the expense of creating many files).
Both non-default options can save a lot of memory when 
buffering a lot of data, at the cost of some computational power.

### Path where data buffered on disk should be put.
Default: `"/tmp"`

```
set("buffering.path","/tmp")
```

Decoding settings
-----------------
### Duration of the decoding buffer, in seconds
Default: `10.`

```
set("decoding.buffer_length",10.)
```

The decoding buffer contains some amount of data decoded in advance.
High values give better remaining time estimation, but cost more.
A value of D guarantees that the remaining time is computed exactly
starting D seconds before the end of track. Hence it is usually good
to set this to the higher duration used in cross(), fade.out() and
similar operators.

Frame format
------------
### Number of channels
Default: `2`

```
set("frame.channels",2)
```

MIDI parameters
---------------
### MIDI channels
Default: `0`

```
set("frame.midi.channels",0)
```

### Internal samplerate
Default: `44100`

```
set("frame.samplerate",44100)
```

### Frame size in samples
Default: `1764`

```
set("frame.size",1764)
```

Tweaking this is tricky but can be useful, since the latency is
proportional to the frame size. It can also help to get ALSA correctly
synchronized with liquidsoap when used in non-buffered mode.
With video enabled, frame duration should be a multiple of 
audio and video frame duration, in order to maintain synchronization.

Video format
------------
### Video channels
Default: `0`

```
set("frame.video.channels",0)
```

### Video frames per second
Default: `25`

```
set("frame.video.fps",25)
```

### Video frame height
Default: `240`

```
set("frame.video.height",240)
```

### Video frame width
Default: `320`

```
set("frame.video.width",320)
```

Builtin HTTP stream receiver.
-----------------------------
### IP address on which the HTTP stream receiver should listen.
Default: `"0.0.0.0"`

```
set("harbor.bind_addr","0.0.0.0")
```

### Enable the builtin ICY (shout) stream receiver.
Default: `false`

```
set("harbor.icy",false)
```

### Content-type (mime) of formats which allow shout metadata update.
Default: ```
["audio/mpeg","audio/aacp","audio/aac","audio/x-aac"]```


```
set("harbor.icy.metadata_formats",["audio/mpeg","audio/aacp","audio/aac","audio/x-aac"])
```

### Default password for source connection.
Default: `"hackme"`

```
set("harbor.password","hackme")
```

### Display passwords, for debugging.
Default: `false`

```
set("harbor.password.verbose",false)
```

### Port on which the HTTP stream receiver should listen.
Default: `8005`

```
set("harbor.port",8005)
```

### Perform reverse DNS lookup to get the client's hostname from its IP.
Default: `true`

```
set("harbor.reverse_dns",true)
```

### Timeout for source connections.
Default: `30.`

```
set("harbor.timeout",30.)
```

### Default username for source connection.
Default: `"source"`

```
set("harbor.username","source")
```

initialization configuration
----------------------------
### catch exceptions, use false to backtrace exceptions
Default: `true`

```
set("init.catch_exn",true)
```

### run initialization using concurrent threads
Default: `false`

```
set("init.concurrent",false)
```

### run in daemon mode
Default: `false`

```
set("init.daemon",false)
```

### support for pidfile generation
Default: `true`

```
set("init.daemon.pidfile",true)
```

### path to pidfile
Default: `"<sysrundir>/<script>.pid"`

```
set("init.daemon.pidfile.path","<sysrundir>/<script>.pid")
```

### dump an initialization trace
Default: `false`

```
set("init.trace",false)
```

JACK settings
-------------
### Client name
Default: `"liquidsoap-<pid>"`

```
set("jack.client_name","liquidsoap-<pid>")
```

Name of the JACK client, where <pid> is replaced by liquidsoap's PID,
and <script> by the base name of the .liq script if one is used.

### Ringbuffer coefficient
Default: `8`

```
set("jack.ringbuffer_coeff",8)
```

The ringbuffer between us and the Jack engine, interleaved. The
multiplication by 8 is an heuristic which seems to avoid underruns.
Should be supperior or equal to 4.

log configuration
-----------------
### log to file
Default: `true`

```
set("log.file",true)
```

### append log to the file
Default: `true`

```
set("log.file.append",true)
```

### path to log file
Default: `"<syslogdir>/<script>.log"`

```
set("log.file.path","<syslogdir>/<script>.log")
```

### log file permissions
Default: `384`

```
set("log.file.perms",384)
```

### general log level
Default: `3`

```
set("log.level",3)
```

### log to stdout
Default: `false`

```
set("log.stdout",false)
```

### display unix timestamps (subsecond accuracy, timezone independant)
Default: `false`

```
set("log.unix_timestamps",false)
```

Mad (mp3) decoding options.
---------------------------
### Enable magic mime test, if compiled.
Default: `true`

```
set("mad.check_mime",true)
```

### Mime-types used for guessing formats
Default: ```
["audio/mpeg","application/octet-stream","video/x-unknown"]```


```
set("mad.mime_types",["audio/mpeg","application/octet-stream","video/x-unknown"])
```

Parameters for the mpd protocol.
--------------------------------
### MPD host.
Default: `"127.0.0.1"`

```
set("mpd.host","127.0.0.1")
```

### Directory where MPD's music is located.
Default: `"/var/lib/mpd/music"`

```
set("mpd.path","/var/lib/mpd/music")
```

### MPD port.
Default: `6600`

```
set("mpd.port",6600)
```

### Randomize order of MPD's results.
Default: `true`

```
set("mpd.randomize",true)
```

Playlist formats
----------------
Mime-types used for guessing formats
------------------------------------
### Mime types associated to XML-based playlist formats
Default: ```
["video/x-ms-asf","text/xml","application/xml","application/smil","application/xspf+xml","application/rss+xml"]```


```
set("playlists.mime_types.xml",["video/x-ms-asf","text/xml","application/xml","application/smil","application/xspf+xml","application/rss+xml"])
```

requests configuration
----------------------
### maximum number of requests
Default: `50`

```
set("request.max_id",50)
```

Streaming root node settings
----------------------------
### Maximum latency in seconds
Default: `60.`

```
set("root.max_latency",60.)
```

If the latency gets higher than this value, the outputs will be reset,
instead of trying to catch it up second by second.
The reset is typically only useful to reconnect icecast mounts.

### Synchronization flag
Default: `true`

```
set("root.sync",true)
```

Control whether or not liquidsoap should take care of the timing.
Otherwise, the sources may handle it by themselves -- typically in the 
case of un-bufferized alsa I/O, which turns root synchronization off
automatically.
Leaving the sources without synchronization can also be useful for 
debugging or measuring performance, as it results in liquidsoap running
as fast as possible.

Internal scheduler
------------------
### Fast queues
Default: `0`

```
set("scheduler.fast_queues",0)
```

Number of queues that are dedicated to fast tasks.
It might be useful to create some if your request resolutions,
or some user defined tasks (cf. `add_timeout()`), are
delayed too much because of slow tasks blocking the generic queues,
such as last.fm submissions or slow `add_timeout` handlers.

### Generic queues
Default: `1`

```
set("scheduler.generic_queues",1)
```

Number of event queues accepting any kind of task.
There should at least be one. Having more can be useful to avoid that
trivial request resolutions (local files) are not delayed because of
a stalled download. But N stalled download can block N queues anyway.

### Log scheduler messages
Default: `false`

```
set("scheduler.log",false)
```

### Non-blocking queues
Default: `1`

```
set("scheduler.non_blocking_queues",1)
```

Number of queues dedicated to internal non-blocking tasks.
These are only started if such tasks are needed.
There should be at least one. Having more is probably useless.

Server configuration
--------------------
### Support for communication via a UNIX domain socket interface
Default: `false`

```
set("server.socket",false)
```

The main advantage of this method is that you can set very precisely
the access permissions for the socket, just like for any other file.
A useful command to use this interface is: ``socat stdin unix:<path>''.

### Path of the UNIX domain socket
Default: `"<sysrundir>/<script>.sock"`

```
set("server.socket.path","<sysrundir>/<script>.sock")
```

In this filename, <pid>, <script> and <sysrundir> are replaced by 
their respective values: PID of the instance of liquidsoap,
base name of the .liq script (if any), default runtime data directory.

### Socket permissions, up to umask
Default: `384`

```
set("server.socket.permissions",384)
```

This parameter is better written in octal notation. Although you can 
write octal numbers like 0o660, they are not displayed back in octal. 
For example, the default value 384 is the decimal for 0o600.

### Support for communication via a telnet interface
Default: `false`

```
set("server.telnet",false)
```

This allows you to communicate with the server via a telnet interface,
i.e., a simple text-based communication over TCP.
The standard ``telnet'' command will allow you to communicate through
that interface, as well as the telnet libraries available in most
script languages.
Since there is currently no authentification, you should be careful
about who can access this interface: either restrict it to connections
from localhost (using the bind_addr param) or set up a firewall.

### Network mask from which the telnet server should accept connections
Default: `"127.0.0.1"`

```
set("server.telnet.bind_addr","127.0.0.1")
```

### Port on which the telnet server should listen
Default: `1234`

```
set("server.telnet.port",1234)
```

### Perform reverse DNS lookup to get the client's hostname from its IP.
Default: `true`

```
set("server.telnet.reverse_dns",true)
```

Stream decoding settings
------------------------
Mime-types used for guessing audio stream formats
-------------------------------------------------
### Mime types associated to MP3 format
Default: `["audio/mpeg"]`

```
set("stream_decoding.mime_types.mp3",["audio/mpeg"])
```

### Mime types associated to Ogg container
Default: ```
["application/ogg","application/x-ogg","audio/x-ogg","audio/ogg","video/ogg"]```


```
set("stream_decoding.mime_types.ogg",["application/ogg","application/x-ogg","audio/x-ogg","audio/ogg","video/ogg"])
```

### Mime types associated to Ogg container. 
This settings has been DEPRECATED.
Default: ```
["application/ogg","application/x-ogg","audio/x-ogg","audio/ogg","video/ogg"]```


```
set("stream_decoding.mime_types.vorbis",["application/ogg","application/x-ogg","audio/x-ogg","audio/ogg","video/ogg"])
```

Settings related to metadata tags
---------------------------------
### List of encodings to try for automatic encoding detection
Default: `["UTF-8","ISO-8859-1"]`

```
set("tag.encodings",["UTF-8","ISO-8859-1"])
```

Video settings
--------------
Video conversion
----------------
Gavl converter
--------------
### Conversion quality
Default: `2`

```
set("video.converter.gavl.quality",2)
```

Quality setting for gavl video conversion. Range from 1 to 5

### Scale mode
Default: `"auto"`

```
set("video.converter.gavl.scale_mode","auto")
```

Scale mode. Values must be one of: 
``auto''
``nearest''
``bilinear''
``quadratic''
``cubic_bspline''
``cubic_mitchell''
``cubic_catmull''
``scale_sinc_lanczos''

### Prefered video converter
Default: `"gavl"`

```
set("video.converter.prefered","gavl")
```

### Prefered proportional scale.
Default: `true`

```
set("video.converter.proportional_scale",true)
```


