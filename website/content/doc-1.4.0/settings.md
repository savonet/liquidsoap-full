
## ALSA configuration

### Alsa internal buffer size

This setting is only used in buffered alsa I/O, and affects latency.
Set to 0 to disable this setting and use ALSA's default.
```liquidsoap
set("alsa.alsa_buffer",0)
```

### Buffer size, in frames

This is only used for buffered ALSA I/O, and affects latency.
```liquidsoap
set("alsa.buffer_length",1)
```

### Number of periods

Set to 0 to disable this setting and use ALSA's default.
```liquidsoap
set("alsa.periods",0)
```

## Audio settings

### Conversion settings

#### Samplerate conversion settings

##### Preferred samplerate converters

Preferred samplerate converter. The native converter is always available.
```liquidsoap
set("audio.converter.samplerate.converters",["ffmpeg","libsamplerate","native"])
```

##### Libsamplerate conversion settings

###### Resampling quality

Resampling quality, one of: `"best"`, `"medium"`, `"fast"`, `"zero_order"` or `"linear"`. Refer to ocaml-samplerate for details.
```liquidsoap
set("audio.converter.samplerate.libsamplerate.quality","fast")
```

##### Native samplerate conversion settings

###### Resampling quality

Resampling quality: either "nearest" or "linear".
```liquidsoap
set("audio.converter.samplerate.native.quality","linear")
```

## Clock settings

### Handling of streaming errors

Control the behaviour of clocks when an error occurs during streaming.
This has no effect on errors occurring during source initializations.
By default, any error will cause liquidsoap to shutdown. If errors
are allowed, faulty sources are simply removed and clocks keep running.
Allowing errors can result in complex surprising situations;
use at your own risk!
```liquidsoap
set("clock.allow_streaming_errors",false)
```

## Console configuration

### Use color in console output when available. One of: "allways", "never" or "auto".

```liquidsoap
set("console.colorize","auto")
```

## Decoder settings

### Maximum debugging information (dev only)

WARNING: Do not enable unless a developer instructed you to do so!
The debugging mode makes it easier to understand why decoding fails,
but as a side effect it will crash liquidsoap at the end of every
track.
```liquidsoap
set("decoder.debug",false)
```

### external decoders

#### Faad

##### faad path

Path to faad binary
```liquidsoap
set("decoder.external.faad.path","faad")
```

#### Ffmpeg

##### ffmpeg path

Path to ffmpeg binary
```liquidsoap
set("decoder.external.ffmpeg.path","ffmpeg")
```

#### Ffprobe

##### ffprobe path

Path to ffprobe binary
```liquidsoap
set("decoder.external.ffprobe.path","ffprobe")
```

#### Flac

##### flac path

Path to flac binary
```liquidsoap
set("decoder.external.flac.path","flac")
```

#### Metaflac

##### metaflac path

Path to metaflac binary
```liquidsoap
set("decoder.external.metaflac.path","metaflac")
```

#### Mpcdec

##### mpcdec path

Path to mpcdec binary
```liquidsoap
set("decoder.external.mpcdec.path","mpcdec")
```

### Decoders and order used to decode files.

```liquidsoap
set("decoder.file_decoders",["META","WAV","AIFF","MIDI","IMAGE","FFMPEG","FLAC","AAC","MP4","OGG","MAD","GSTREAMER"])
```

### File extensions used for guessing audio formats

#### File extensions used for guessing AAC format

```liquidsoap
set("decoder.file_extensions.aac",["aac"])
```

#### File extensions used for guessing AIFF format

```liquidsoap
set("decoder.file_extensions.aiff",["aiff","aif","aifc"])
```

#### File extensions used for decoding with ffmpeg

```liquidsoap
set("decoder.file_extensions.ffmpeg",["mp3","mp4","m4a","wav","flac","ogg","wma","webm","osb"])
```

#### File extensions used for guessing FLAC format

```liquidsoap
set("decoder.file_extensions.flac",["flac"])
```

#### File extensions used for guessing format handled by GStreamer

```liquidsoap
set("decoder.file_extensions.gstreamer",["wma","wmv","avi","mp4","3gp","webm","mkv"])
```

#### File extensions used for guessing mpeg audio format

```liquidsoap
set("decoder.file_extensions.mad",["mp3","mp2","mp1"])
```

#### File extensions used for guessing MP3 format (DEPRECATED, use *.mad configuration keys!)

```liquidsoap
set("decoder.file_extensions.mp3",["mp3","mp2","mp1"])
```

#### File extensions used for guessing MP4 format

```liquidsoap
set("decoder.file_extensions.mp4",["m4a","m4b","m4p","m4v","m4r","3gp","mp4"])
```

#### File extensions used for guessing OGG format

```liquidsoap
set("decoder.file_extensions.ogg",["ogv","oga","ogx","ogg","opus"])
```

#### File extensions used for decoding metadata using TAGLIB

```liquidsoap
set("decoder.file_extensions.taglib",["mp3"])
```

#### File extensions used for guessing WAV format

```liquidsoap
set("decoder.file_extensions.wav",["wav","wave"])
```

### Decoders and order used to decode image files.

```liquidsoap
set("decoder.image_file_decoders",["PPM","CAMLIMAGES","SDL/IMAGE"])
```

### Mime-types used for guessing audio formats

#### Mime-types used for guessing AAC format

```liquidsoap
set("decoder.mime_types.aac",["audio/aac","audio/aacp","audio/x-hx-aac-adts"])
```

#### Mime-types used for guessing AIFF format

```liquidsoap
set("decoder.mime_types.aiff",["audio/x-aiff","audio/aiff"])
```

#### Mime-types used for guessing PCM/BASIC format

```liquidsoap
set("decoder.mime_types.basic",["audio/basic"])
```

#### Mime-types used for decoding with ffmpeg

```liquidsoap
set("decoder.mime_types.ffmpeg",["application/ffmpeg"])
```

#### Mime-types used for guessing FLAC format

```liquidsoap
set("decoder.mime_types.flac",["audio/x-flac"])
```

#### Mime-types used for guessing format handled by GStreamer

```liquidsoap
set("decoder.mime_types.gstreamer",["video/x-ms-asf","video/x-msvideo","video/mp4","video/3gpp","video/webm","video/x-matroska","video/mp2t","video/MP2T"])
```

#### Mime-types used for guessing mpeg audio format

```liquidsoap
set("decoder.mime_types.mad",["audio/mpeg","audio/MPA"])
```

#### Mime-types used for guessing MP3 format (DEPRECATED, use *.mad configuration keys!)

```liquidsoap
set("decoder.mime_types.mp3",["audio/mpeg","audio/MPA"])
```

#### Mime-types used for guessing MP4 format

```liquidsoap
set("decoder.mime_types.mp4",["audio/mp4","application/mp4"])
```

#### Mime-types used for guessing OGG format.

```liquidsoap
set("decoder.mime_types.ogg",["application/ogg","application/x-ogg","audio/x-ogg","audio/ogg","video/ogg"])
```

#### Mime-types used for decoding metadata using TAGLIB

```liquidsoap
set("decoder.mime_types.taglib",["audio/mpeg"])
```

#### Mime-types used for guessing WAV format

```liquidsoap
set("decoder.mime_types.wav",["audio/vnd.wave","audio/wav","audio/wave","audio/x-wav"])
```

### Decoders and order used to decode streams.

```liquidsoap
set("decoder.stream_decoders",["WAV","AIFF","PCM/BASIC","RAW AUDIO","FFMPEG","FLAC","AAC","OGG","MAD"])
```

### Taglib settings

## Encoder settings

### Metadata settings

#### Exported metdata

The list of labels of exported metadata.
```liquidsoap
set("encoder.encoder.export",["artist","title","album","genre","date","tracknumber","comment","track","year","dj","next"])
```

## FFMPEG configuration

### Log configuration

#### Level

```liquidsoap
set("ffmpeg.log.level",5)
```

#### Verbosity

Set FFMPEG log level, one of: "quiet", "panic", "fatal"
"error", "warning", "info", "verbose" or "debug"
```liquidsoap
set("ffmpeg.log.verbosity","quiet")
```

## Frame format

### Audio (PCM) format

#### Default number of channels

```liquidsoap
set("frame.audio.channels",2)
```

#### Samplerate

```liquidsoap
set("frame.audio.samplerate",44100)
```

### Tentative frame duration in seconds

Audio and video samplerates constrain the possible frame durations.
This setting is used as a hint for the duration, when 'frame.audio.size'
is not provided.
Tweaking frame duration is tricky but needed when dealing with latency
or getting soundcard I/O correctly synchronized with liquidsoap.
```liquidsoap
set("frame.duration",0.04)
```

### MIDI parameters

#### Default number of channels

```liquidsoap
set("frame.midi.channels",0)
```

### Video format

#### Default number of channels

```liquidsoap
set("frame.video.channels",0)
```

#### Image height

```liquidsoap
set("frame.video.height",240)
```

#### Samplerate

```liquidsoap
set("frame.video.samplerate",25)
```

#### Image width

```liquidsoap
set("frame.video.width",320)
```

## Media decoding/endcoding through gstreamer.

### Add borders in order to keep video aspect ratio.

```liquidsoap
set("gstreamer.add_borders",true)
```

### Maximal number of buffers.

```liquidsoap
set("gstreamer.max_buffers",10)
```

## Harbor settings (Icecast/shoutcast stream receiver).

### [DEPRECATED] Harbor bind_addr

IP addresses on which the harbor should listen.
```liquidsoap
set("harbor.bind_addr","0.0.0.0")
```

### IP addresses on which the harbor should listen.

```liquidsoap
set("harbor.bind_addrs",["0.0.0.0"])
```

### Content-type (mime) of formats which allow shout metadata update.

```liquidsoap
set("harbor.icy_formats",["audio/mpeg","audio/aacp","audio/aac","audio/x-aac","audio/wav","audio/wave","audio/x-flac"])
```

### Maximun of pending source requests per port.

```liquidsoap
set("harbor.max_connections",2)
```

### Perform reverse DNS lookup to get the client's hostname from its IP.

```liquidsoap
set("harbor.reverse_dns",false)
```

### Harbor SSL settings.

#### Path to the server's SSL certificate. (mandatory)

```liquidsoap
set("harbor.ssl.certificate","")
```

#### Path to the server's SSL password. (optional, blank if omited)

```liquidsoap
set("harbor.ssl.password","")
```

#### Path to the server's SSL private key. (mandatory)

```liquidsoap
set("harbor.ssl.private_key","")
```

#### Read timeout on SSL sockets. Set to zero to never timeout, ignored (system default) if negative.

```liquidsoap
set("harbor.ssl.read_timeout",-1.)
```

#### Read timeout on SSL sockets. Set to zero to never timeout, ignored (system default) if negative.

```liquidsoap
set("harbor.ssl.write_timeout",-1.)
```

### Timeout for network operations.

```liquidsoap
set("harbor.timeout",300.)
```

### Display passwords, for debugging.

```liquidsoap
set("harbor.verbose",false)
```

## initialization configuration

### Allow liquidsoap to run as root

This should be reserved for advanced dynamic uses of liquidsoap 
such as running inside an isolated environment like docker.
```liquidsoap
set("init.allow_root",false)
```

### catch exceptions, use false to backtrace exceptions

```liquidsoap
set("init.catch_exn",true)
```

### run initialization using concurrent threads

```liquidsoap
set("init.concurrent",false)
```

### run in daemon mode

```liquidsoap
set("init.daemon",false)
```

#### Changes the effective user (drops privileges).

```liquidsoap
set("init.daemon.change_user",false)
```

##### Group used to run the daemon.

```liquidsoap
set("init.daemon.change_user.group","daemon")
```

##### User used to run the daemon.

```liquidsoap
set("init.daemon.change_user.user","daemon")
```

#### support for pidfile generation

```liquidsoap
set("init.daemon.pidfile",true)
```

##### path to pidfile

```liquidsoap
set("init.daemon.pidfile.path","<sysrundir>/<script>.pid")
```

### Start liquidsoap even without any active source

This should be reserved for advanced dynamic uses of liquidsoap.
```liquidsoap
set("init.force_start",false)
```

### dump an initialization trace

```liquidsoap
set("init.trace",false)
```

## Lasdpa Configuration

### Directories to search for plugins

```liquidsoap
set("ladspa.dirs",["/usr/lib64/ladspa","/usr/lib/ladspa","/usr/local/lib/ladspa"])
```

### Enable Ladspa 

```liquidsoap
set("ladspa.enable",true)
```

## Language configuration.

### Debug language features such as type inference and reduction.

```liquidsoap
set("lang.debug",false)
```

### Debug errors by showing stacktraces instead of printing messages.

```liquidsoap
set("lang.debug_errors",false)
```

## log configuration

### log to file

```liquidsoap
set("log.file",false)
```

#### append log to the file

```liquidsoap
set("log.file.append",true)
```

#### path to log file

```liquidsoap
set("log.file.path","<syslogdir>/<script>.log")
```

#### log file permissions

```liquidsoap
set("log.file.perms",384)
```

### general log level

```liquidsoap
set("log.level",3)
```

### log to stdout

```liquidsoap
set("log.stdout",true)
```

### display unix timestamps (subsecond accuracy, timezone independant)

```liquidsoap
set("log.unix_timestamps",false)
```

## Parameters for the mpd protocol.

### Debug communications with MPD server.

```liquidsoap
set("mpd.debug",false)
```

### MPD host.

```liquidsoap
set("mpd.host","127.0.0.1")
```

### Directory where MPD's music is located.

```liquidsoap
set("mpd.path","/var/lib/mpd/music")
```

### MPD port.

```liquidsoap
set("mpd.port",6600)
```

### Randomize order of MPD's results.

```liquidsoap
set("mpd.randomize",true)
```

## Interactions through the OSC protocol.

### Port for OSC server.

```liquidsoap
set("osc.port",7777)
```

## Playlist formats

### Cue in metadata for playlists with track index.

Some playlists format, such as CUE files specify index points to start
tracks playback. In this case, tracks are resolved to a annotate: request with
a cue-in metadata containing the index. If you want to make use of this index,
you should specify here what label you want for this metadata and use the cue_cut
operator on the resulting source
```liquidsoap
set("playlists.cue_in_metadata","liq_cue_in")
```

### Cue out metadata for playlists with track index.

Some playlists format, such as CUE files specify index points to start
tracks playback. In this case, tracks are resolved to a annotate: request with
a cue-in metadata containing the index. If you want to make use of this index,
you should specify here what label you want for this metadata and use the cue_cut
operator on the resulting source
```liquidsoap
set("playlists.cue_out_metadata","liq_cue_out")
```

### Mime-types used for guessing playlist formats.

#### Mime types associated to XML-based playlist formats

```liquidsoap
set("playlists.mime_types.xml",["video/x-ms-asf","audio/x-ms-asx","text/xml","application/xml","application/smil","application/smil+xml","application/xspf+xml","application/rss+xml"])
```

## Protocol Settings

### AWS protocols settings

#### Endpoint URL

Alternative endpoint URL (useful for other S3 implementations).
```liquidsoap
set("protocol.aws.endpoint","")
```

#### Binary

Path to aws CLI binary
```liquidsoap
set("protocol.aws.path","aws")
```

#### Polly protocol settings

##### Format

Output format
```liquidsoap
set("protocol.aws.polly.format","mp3")
```

##### Voice

Voice ID
```liquidsoap
set("protocol.aws.polly.voice","Joanna")
```

#### Profile

Use a specific profile from your credential file.
```liquidsoap
set("protocol.aws.profile","")
```

#### Region

AWS Region
```liquidsoap
set("protocol.aws.region","")
```

### External download protocol

```liquidsoap
set("protocol.external",true)
```

#### Path to curl

```liquidsoap
set("protocol.external.curl","curl")
```

#### External protocols

```liquidsoap
set("protocol.external.protocols",["http","https","ftp"])
```

### ffmpeg protocol settings

#### Number of channels

```liquidsoap
set("protocol.ffmpeg.channels",2)
```

#### Extract metadata

```liquidsoap
set("protocol.ffmpeg.metadata",true)
```

#### Path to ffmpeg

```liquidsoap
set("protocol.ffmpeg.path","ffmpeg")
```

#### Adjust replaygain

```liquidsoap
set("protocol.ffmpeg.replaygain",false)
```

### Process protocol settings

#### Process Environment

List of environment variables passed down to the executed process.
```liquidsoap
set("protocol.process.env",[])
```

#### Inherit Environment

Inherit calling process's environment when `env` parameter is empty.
```liquidsoap
set("protocol.process.inherit_env",true)
```

### Replay_gain protocol settings

#### Replay_gain path

```liquidsoap
set("protocol.replay_gain.path","/usr/local/share/liquidsoap/1.4.0/bin/extract-replaygain")
```

### Say protocol settings

#### Sox path

```liquidsoap
set("protocol.say.sox_path","sox")
```

### Text2wave protocol settings

#### Text2wave path

```liquidsoap
set("protocol.text2wave.path","text2wave")
```

### Youtube_dl protocol settings

#### Youtube-dl path

```liquidsoap
set("protocol.youtube-dl.path","youtube-dl")
```

## requests configuration

### Time (in seconds) after which a destroyed request cannot be accessed anymore.

```liquidsoap
set("request.grace_time",600.)
```

### Number of requests at which a leak warning should be issued.

```liquidsoap
set("request.leak_warning",100)
```

### Decoders and order used to decode files' metadata.

```liquidsoap
set("request.metadata_decoders",["FFMPEG","FLAC","MP4","OGG","TAGLIB","GSTREAMER"])
```

#### Compute duration in the "duration" metadata, if the metadata is not already present. This can take a long time and the use of this option is not recommended: the proper way is to have a script precompute the "duration" metadata.

```liquidsoap
set("request.metadata_decoders.duration",false)
```

#### Allow metadata resolvers to override metadata already set through annotate: or playlist resolution for instance.

```liquidsoap
set("request.metadata_decoders.override",false)
```

## Streaming clock settings

### Maximum latency in seconds

If the latency gets higher than this value, the outputs will be reset,
instead of trying to catch it up second by second.
The reset is typically only useful to reconnect icecast mounts.
```liquidsoap
set("root.max_latency",60.)
```

## Use sandboxing for external process. One of: `"enabled"`, `"disabled"` or `"auto"`.

```liquidsoap
set("sandbox","disabled")
```

### Sandbox binary to use.

```liquidsoap
set("sandbox.binary","bwrap")
```

### Enable network

```liquidsoap
set("sandbox.network",true)
```

### Read-only directories

```liquidsoap
set("sandbox.ro",["/"])
```

### Read/write directories. Default: `[$HOME;$TMPDIR]`.

```liquidsoap
set("sandbox.rw",["/home/opam","/tmp"])
```

### Additional default environment variables.

```liquidsoap
set("sandbox.setenv",["TEMPDIR=/tmp","TEMP=/tmp","TMPDIR=/tmp","TMP=/tmp"])
```

### Run command inside shell.

```liquidsoap
set("sandbox.shell",true)
```

#### Patch to shell binary. Defaults to `$SHELL` if set and "/bin/sh" otherwise.

```liquidsoap
set("sandbox.shell.path","/bin/bash")
```

### Environment varialbes to unset.

```liquidsoap
set("sandbox.unsetenv",[])
```

## Internal scheduler

### Fast queues

Number of queues that are dedicated to fast tasks.
It might be useful to create some if your request resolutions,
or some user defined tasks (cf. `add_timeout()`), are
delayed too much because of slow tasks blocking the generic queues,
such as last.fm submissions or slow `add_timeout` handlers.
```liquidsoap
set("scheduler.fast_queues",0)
```

### Generic queues

Number of event queues accepting any kind of task.
There should at least be one. Having more can be useful to avoid that
trivial request resolutions (local files) are not delayed because of
a stalled download. But N stalled download can block N queues anyway.
```liquidsoap
set("scheduler.generic_queues",2)
```

### Log scheduler messages

```liquidsoap
set("scheduler.log",false)
```

### Non-blocking queues

Number of queues dedicated to internal non-blocking tasks.
These are only started if such tasks are needed.
There should be at least one.
```liquidsoap
set("scheduler.non_blocking_queues",2)
```

## Server configuration

### Support for communication via a UNIX domain socket interface

The main advantage of this method is that you can set very precisely
the access permissions for the socket, just like for any other file.
A useful command to use this interface is: "socat stdin unix:<path>".
```liquidsoap
set("server.socket",false)
```

#### Path of the UNIX domain socket

In this filename, <pid>, <script> and <sysrundir> are replaced by 
their respective values: PID of the instance of liquidsoap,
base name of the .liq script (if any), default runtime data directory.
```liquidsoap
set("server.socket.path","<sysrundir>/<script>.sock")
```

#### Socket permissions, up to umask

This parameter is better written in octal notation. Although you can 
write octal numbers like 0o660, they are not displayed back in octal. 
For example, the default value 384 is the decimal for 0o600.
```liquidsoap
set("server.socket.permissions",384)
```

### Support for communication via a telnet interface

This allows you to communicate with the server via a telnet interface,
i.e., a simple text-based communication over TCP.
The standard "telnet" command will allow you to communicate through
that interface, as well as the telnet libraries available in most
script languages.
Since there is currently no authentication, you should be careful
about who can access this interface: either restrict it to connections
from localhost (using the bind_addr param) or set up a firewall.
```liquidsoap
set("server.telnet",false)
```

#### Network mask from which the telnet server should accept connections

```liquidsoap
set("server.telnet.bind_addr","127.0.0.1")
```

#### Port on which the telnet server should listen

```liquidsoap
set("server.telnet.port",1234)
```

#### Perform reverse DNS lookup to get the client's hostname from its IP.

```liquidsoap
set("server.telnet.revdns",false)
```

### Timeout for read/write operations.

A negative value disables timeout.
```liquidsoap
set("server.timeout",30.)
```

## SRT configuration

### Log configuration

#### Level

```liquidsoap
set("srt.log.level",5)
```

### Poll configuration

#### Timeout for polling loop, in ms

```liquidsoap
set("srt.poll.timeout",100)
```

## Settings related to metadata tags

### List of encodings to try for automatic encoding detection

```liquidsoap
set("tag.encodings",["UTF-8","ISO-8859-1"])
```

## Video settings

### Video conversion

#### Gavl converter

##### Conversion quality

Quality setting for gavl video conversion. Range from 1 to 5
```liquidsoap
set("video.converter.gavl.quality",2)
```

##### Scale mode

Scale mode. Values must be one of: 
"auto"
"nearest"
"bilinear"
"quadratic"
"cubic_bspline"
"cubic_mitchell"
"cubic_catmull"
"scale_sinc_lanczos"
```liquidsoap
set("video.converter.gavl.scale_mode","auto")
```

#### Preferred video converter

```liquidsoap
set("video.converter.preferred","gavl")
```

#### Preferred proportional scale.

```liquidsoap
set("video.converter.proportional_scale",true)
```

