
# Liquidsoap configuration

## Settings related to metadata tags

### List of encodings to try for automatic encoding detection

```liquidsoap
settings.tag.encodings.set(["UTF-8", "ISO-8859-1"])
```

## SRT configuration

### Poll configuration

#### Timeout for polling loop, in ms

```liquidsoap
settings.srt.poll.timeout.set(100)
```

### Route srt logs through liquidsoap's logs

```liquidsoap
settings.srt.log.set(true)
```

#### Verbosity

Set SRT log level, one of: "critical", "error", "warning", "notice" or "debug"

```liquidsoap
settings.srt.log.verbosity.set("warning")
```

#### Level

```liquidsoap
settings.srt.log.level.set(4)
```

### Enforce consistent encryption settings on both end of any connection.

```liquidsoap
settings.srt.enforced_encryption.set(true)
```

## Server configuration

The server is an abstract text-command-based communication protocol, which can be used through several interfaces.

### Timeout for read/write operations.

A negative value disables timeout.

```liquidsoap
settings.server.timeout.set(30.)
```

### Support for communication via a telnet interface

This allows you to communicate with the server via a telnet interface,i.e., a simple text-based communication over TCP.The standard "telnet" command will allow you to communicate throughthat interface, as well as the telnet libraries available in mostscript languages.Since there is currently no authentication, you should be carefulabout who can access this interface: either restrict it to connectionsfrom localhost (using the bind_addr param) or set up a firewall.

```liquidsoap
settings.server.telnet.set(false)
```

#### Perform reverse DNS lookup to get the client's hostname from its IP.

```liquidsoap
settings.server.telnet.revdns.set(false)
```

#### Port on which the telnet server should listen

```liquidsoap
settings.server.telnet.port.set(1234)
```

#### Network mask from which the telnet server should accept connections

```liquidsoap
settings.server.telnet.bind_addr.set("127.0.0.1")
```

### Support for communication via a UNIX domain socket interface

The main advantage of this method is that you can set very preciselythe access permissions for the socket, just like for any other file.A useful command to use this interface is: "socat stdin unix:<path>".

```liquidsoap
settings.server.socket.set(false)
```

#### Socket permissions, up to umask

This parameter is better written in octal notation. Although you can write octal numbers like 0o660, they are not displayed back in octal. For example, the default value 384 is the decimal for 0o600.

```liquidsoap
settings.server.socket.permissions.set(384)
```

#### Path of the UNIX domain socket

In this filename, `<pid>`, `<script>` and `<sysrundir>` are replaced by their respective values: PID of the instance of liquidsoap,base name of the .liq script (if any), default runtime data directory.

```liquidsoap
settings.server.socket.path.set("<sysrundir>/<script>.sock")
```

### Log configuration.

#### Default log level for messages.

```liquidsoap
settings.server.log.level.set(3)
```

## Internal scheduler

The scheduler is used to process various tasks in liquidsoap.There are three kinds of tasks:"Non-blocking" ones are instantaneous to process, these are onlyinternal processes of liquidsoap like its server."Fast" tasks are those that can be long but are often not,such as request resolution (audio file downloading and checking).Finally, "slow" tasks are those that are always taking a long time,like last.fm submission, or user-defined tasks register via`thread.run`.The scheduler consists in a number of queues that process incomingtasks. Some queues might only process some kinds of tasks so thatthey are more responsive.Having more queues often do not make the program faster in average,but affect mostly the order in which tasks are processed.

### Non-blocking queues

Number of queues dedicated to internal non-blocking tasks.These are only started if such tasks are needed.There should be at least one.

```liquidsoap
settings.scheduler.non_blocking_queues.set(2)
```

### Log scheduler messages

```liquidsoap
settings.scheduler.log.set(false)
```

### Generic queues

Number of event queues accepting any kind of task.There should at least be one. Having more can be useful to make surethat trivial request resolutions (local files) are not delayedbecause of a stalled download. But N stalled download can blockN queues anyway.

```liquidsoap
settings.scheduler.generic_queues.set(2)
```

### Fast queues

Number of queues that are dedicated to fast tasks.It might be useful to create some if your request resolutions,or some user defined tasks (cf `thread.run`), aredelayed too much because of slow tasks blocking the generic queues,such as last.fm submissions or slow `thread.run` handlers.

```liquidsoap
settings.scheduler.fast_queues.set(0)
```

## Sandboxing for external processes.

```liquidsoap
settings.sandbox.set(false)
```

### Environment variables to unset.

```liquidsoap
settings.sandbox.unsetenv.set([])
```

### Run command inside shell.

```liquidsoap
settings.sandbox.shell.set(true)
```

#### Patch to shell binary. Defaults to `$SHELL` if set and "/bin/sh" otherwise.

```liquidsoap
settings.sandbox.shell.path.set("/bin/bash")
```

### Additional default environment variables.

```liquidsoap
settings.sandbox.setenv.set(["TEMPDIR=/tmp", "TEMP=/tmp", "TMPDIR=/tmp", "TMP=/tmp"])
```

### Read/write directories. Default: `[$HOME;$TMPDIR]`.

```liquidsoap
settings.sandbox.rw.set(["/home/opam", "/tmp"])
```

### Read-only directories

```liquidsoap
settings.sandbox.ro.set(["/"])
```

### Enable network

```liquidsoap
settings.sandbox.network.set(true)
```

### Sandbox binary to use.

```liquidsoap
settings.sandbox.binary.set("bwrap")
```

## Streaming clock settings

### Maximum latency in seconds

If the latency gets higher than this value, the outputs will be reset,instead of trying to catch it up second by second.The reset is typically only useful to reconnect icecast mounts.

```liquidsoap
settings.root.max_latency.set(60.)
```

## Requests configuration

### Decoders and order used to decode files' metadata.

```liquidsoap
settings.request.metadata_decoders.set(["FFMPEG", "FLAC", "MP4", "OGG", "TAGLIB", "ID3", "ID3V1", "ID3V2", "IMAGEMD", "VIDEOMD"])
```

#### Allow metadata resolvers to override metadata already set through annotate: or playlist resolution for instance.

```liquidsoap
settings.request.metadata_decoders.override.set(false)
```

#### Compute duration in the "duration" metadata, if the metadata is not already present. This can take a long time and the use of this option is not recommended: the proper way is to have a script precompute the "duration" metadata.

```liquidsoap
settings.request.metadata_decoders.duration.set(false)
```

### Number of requests at which a leak warning should be issued.

```liquidsoap
settings.request.leak_warning.set(100)
```

## Metric reporting using prometheus.

### Enable the prometheus server.

```liquidsoap
settings.prometheus.server.set(false)
```

#### Port to run the server on.

```liquidsoap
settings.prometheus.server.port.set(9090)
```

## Playlist formats

### Mime-types used for guessing playlist formats.

When a mime-type is available (e.g. with input.http), it can be usedto guess which playlist format to use.This section contains the listings used for that detection, which youmight want to tweak if you encounter a new mime-type.If you feel that new mime-types should be permanently added, pleasecontact the developers.

#### Mime types associated to XML-based playlist formats

```liquidsoap
settings.playlists.mime_types.xml.set(["video/x-ms-asf", "audio/x-ms-asx", "text/xml", "application/xml", "application/smil", "application/smil+xml", "application/xspf+xml", "application/rss+xml"])
```

### Cue out metadata for playlists with track index.

Some playlists format, such as CUE files specify index points to starttracks playback. In this case, tracks are resolved to a annotate: request witha cue-in metadata containing the index. If you want to make use of this index,you should specify here what label you want for this metadata and use the cue_cutoperator on the resulting source

```liquidsoap
settings.playlists.cue_out_metadata.set("liq_cue_out")
```

### Cue in metadata for playlists with track index.

Some playlists format, such as CUE files specify index points to starttracks playback. In this case, tracks are resolved to a annotate: request witha cue-in metadata containing the index. If you want to make use of this index,you should specify here what label you want for this metadata and use the cue_cutoperator on the resulting source

```liquidsoap
settings.playlists.cue_in_metadata.set("liq_cue_in")
```

## Interactions through the OSC protocol.

### Port for OSC server.

```liquidsoap
settings.osc.port.set(7777)
```

## Parameters for the mpd protocol.

### Randomize order of MPD's results.

```liquidsoap
settings.mpd.randomize.set(true)
```

### MPD port.

```liquidsoap
settings.mpd.port.set(6600)
```

### Directory where MPD's music is located.

```liquidsoap
settings.mpd.path.set("/var/lib/mpd/music")
```

### MPD host.

```liquidsoap
settings.mpd.host.set("127.0.0.1")
```

### Debug communications with MPD server.

```liquidsoap
settings.mpd.debug.set(false)
```

## Log configuration

### Display unix timestamps (subsecond accuracy, timezone independant)

```liquidsoap
settings.log.unix_timestamps.set(false)
```

### Log to stdout

```liquidsoap
settings.log.stdout.set(true)
```

### General log level

```liquidsoap
settings.log.level.set(3)
```

### Log to file

```liquidsoap
settings.log.file.set(false)
```

#### Log file permissions

```liquidsoap
settings.log.file.perms.set(384)
```

#### Path to log file

```liquidsoap
settings.log.file.path.set("<syslogdir>/<script>.log")
```

#### Append log to the file

```liquidsoap
settings.log.file.append.set(true)
```

## Language configuration.

### Debug errors by showing stacktraces instead of printing messages.

```liquidsoap
settings.lang.debug_errors.set(false)
```

### Debug language features such as type inference and reduction.

```liquidsoap
settings.lang.debug.set(false)
```

## Initialization configuration

### Dump an initialization trace

```liquidsoap
settings.init.trace.set(false)
```

### Start liquidsoap even without any active source

This should be reserved for advanced dynamic uses of liquidsoap.

```liquidsoap
settings.init.force_start.set(false)
```

### Run in daemon mode

```liquidsoap
settings.init.daemon.set(false)
```

#### Support for pidfile generation

```liquidsoap
settings.init.daemon.pidfile.set(true)
```

##### Unix file permissions for pidfile. Default: `0o640`.

```liquidsoap
settings.init.daemon.pidfile.perms.set(416)
```

##### Path to pidfile

```liquidsoap
settings.init.daemon.pidfile.path.set("<sysrundir>/<script>.pid")
```

#### Changes the effective user (drops privileges).

```liquidsoap
settings.init.daemon.change_user.set(false)
```

##### User used to run the daemon.

```liquidsoap
settings.init.daemon.change_user.user.set("daemon")
```

##### Group used to run the daemon.

```liquidsoap
settings.init.daemon.change_user.group.set("daemon")
```

### Catch exceptions, use false to backtrace exceptions

```liquidsoap
settings.init.catch_exn.set(true)
```

### Allow liquidsoap to run as root

This should be reserved for advanced dynamic uses of liquidsoap such as running inside an isolated environment like docker.

```liquidsoap
settings.init.allow_root.set(false)
```

## Harbor settings (Icecast/shoutcast stream receiver).

### Display passwords, for debugging.

```liquidsoap
settings.harbor.verbose.set(false)
```

### Timeout for network operations (in seconds).

```liquidsoap
settings.harbor.timeout.set(300.)
```

### Harbor SSL settings.

#### Read timeout on SSL sockets. Set to zero to never timeout, ignored (system default) if negative.

```liquidsoap
settings.harbor.ssl.write_timeout.set(-1.)
```

#### Read timeout on SSL sockets. Set to zero to never timeout, ignored (system default) if negative.

```liquidsoap
settings.harbor.ssl.read_timeout.set(-1.)
```

#### Path to the server's SSL private key. (mandatory)

```liquidsoap
settings.harbor.ssl.private_key.set("")
```

#### Path to the server's SSL password. (optional, blank if omitted)

```liquidsoap
settings.harbor.ssl.password.set("")
```

#### Path to the server's SSL certificate. (mandatory)

```liquidsoap
settings.harbor.ssl.certificate.set("")
```

### Perform reverse DNS lookup to get the client's hostname from its IP.

```liquidsoap
settings.harbor.reverse_dns.set(false)
```

### Maximum of pending source requests per port.

```liquidsoap
settings.harbor.max_connections.set(2)
```

### Content-type (mime) of formats which allow shout metadata update.

```liquidsoap
settings.harbor.icy_formats.set(["audio/mpeg", "audio/aacp", "audio/aac", "audio/x-aac", "audio/wav", "audio/wave", "audio/flac", "audio/x-flac"])
```

### IP addresses on which the harbor should listen.

```liquidsoap
settings.harbor.bind_addrs.set(["0.0.0.0"])
```

## Frame format

Settings for the data representation in frames, which are theelementary packets of which streams are made.

### Video settings

#### Image width

```liquidsoap
settings.frame.video.width.set(1280)
```

#### Image height

```liquidsoap
settings.frame.video.height.set(720)
```

#### Frame rate

```liquidsoap
settings.frame.video.framerate.set(25)
```

#### Set to `true` to force video content even when no video content is explicitly requested, for instance: `output.dummy(noise())`

```liquidsoap
settings.frame.video.default.set(false)
```

### MIDI parameters

#### Default number of channels

```liquidsoap
settings.frame.midi.channels.set(0)
```

### Tentative frame duration in seconds

Audio samplerate and video frame rate constrain the possible frame durations.This setting is used as a hint for the duration, when 'frame.audio.size'is not provided.Tweaking frame duration is tricky but needed when dealing with latencyor getting soundcard I/O correctly synchronized with liquidsoap.

```liquidsoap
settings.frame.duration.set(0.04)
```

### Audio (PCM) format

#### Tentative frame duration in audio samples

Audio samplerate and video frame rate constrain the possible frame durations.This setting is used as a hint for the duration, overriding'frame.duration'.Tweaking frame duration is tricky but needed when dealing with latencyor getting soundcard I/O correctly synchronized with liquidsoap.

```liquidsoap
settings.frame.audio.size.set(<value>)
```

#### Samplerate

```liquidsoap
settings.frame.audio.samplerate.set(44100)
```

#### Default number of channels

```liquidsoap
settings.frame.audio.channels.set(2)
```

## FFMPEG configuration

### Scaling algorithm

Set FFMPEG scaling algorithm. One of: "fast_bilinear","bilinear" or "bicubic".

```liquidsoap
settings.ffmpeg.scaling_algorithm.set("bicubic")
```

### Log configuration

#### Verbosity

Set FFMPEG log level, one of: "quiet", "panic", "fatal", "error", "warning", "info", "verbose" or "debug"

```liquidsoap
settings.ffmpeg.log.verbosity.set("warning")
```

#### Level

```liquidsoap
settings.ffmpeg.log.level.set(3)
```

## Encoder settings

Settings for the encoder

### Metadata settings

Settings for the encoded metadata.

#### Exported metadata

The list of labels of exported metadata.

```liquidsoap
settings.encoder.metadata.export.set(["artist", "title", "album", "genre", "date", "tracknumber", "comment", "track", "year", "dj", "next", "apic", "metadata_block_picture", "coverart"])
```

## Console configuration

### Use color in console output when available. One of: "always", "never" or "auto".

```liquidsoap
settings.console.colorize.set("auto")
```

## Clock settings

### How often (in seconds) we should indicate catchup errors.

```liquidsoap
settings.clock.log_delay.set(1.)
```

### Handling of streaming errors

Control the behaviour of clocks when an error occurs during streaming.This has no effect on errors occurring during source initializations.By default, any error will cause liquidsoap to shutdown. If errorsare allowed, faulty sources are simply removed and clocks keep running.Allowing errors can result in complex surprising situations;use at your own risk!

```liquidsoap
settings.clock.allow_streaming_errors.set(false)
```

## Audio settings

Options related to audio.

### Conversion settings

Options related to audio conversion.

#### Samplerate conversion settings

Options related to samplerate conversion.

##### Native samplerate conversion settings

Options related to native samplerate conversion.

###### Resampling quality

Resampling quality: either "nearest" or "linear".

```liquidsoap
settings.audio.converter.samplerate.native.quality.set("linear")
```

##### Libsamplerate conversion settings

Options related to libsamplerate conversion.

###### Resampling quality

Resampling quality, one of: `"best"`, `"medium"`, `"fast"`, `"zero_order"` or `"linear"`. Refer to ocaml-samplerate for details.

```liquidsoap
settings.audio.converter.samplerate.libsamplerate.quality.set("fast")
```

##### Preferred samplerate converters

Preferred samplerate converter. The native converter is always available.

```liquidsoap
settings.audio.converter.samplerate.converters.set(["libsamplerate", "ffmpeg", "native"])
```

#### Channel layout conversion settings

Options related to channel layout conversion.

##### Preferred samplerate converters

Preferred channel layout converter. The native converter is always available.

```liquidsoap
settings.audio.converter.channel_layout.converters.set(["native"])
```

## ALSA configuration

### Number of periods

Set to 0 to disable this setting and use ALSA's default.

```liquidsoap
settings.alsa.periods.set(0)
```

### Buffer size, in frames

This is only used for buffered ALSA I/O, and affects latency.

```liquidsoap
settings.alsa.buffer_length.set(1)
```

### Alsa internal buffer size

This setting is only used in buffered alsa I/O, and affects latency.Set to 0 to disable this setting and use ALSA's default.

```liquidsoap
settings.alsa.alsa_buffer.set(0)
```

## Settings for registered protocols

### Settings for the ReplayGain protocol

#### ReplayGain path

```liquidsoap
settings.protocol.replaygain.path.set("/usr/share/liquidsoap/2.1.1/bin/extract-replaygain")
```

#### Tag used to annotate ReplayGain

```liquidsoap
settings.protocol.replaygain.tag.set("replaygain_track_gain")
```

### Settings for the process protocol

#### List of environment variables passed down to the executed process.

```liquidsoap
settings.protocol.process.env.set([])
```

#### Inherit calling process's environment when `env` parameter is empty.

```liquidsoap
settings.protocol.process.inherit_env.set(true)
```

### Settings for the youtube-dl protocol

#### Path of the youtube-dl binary

```liquidsoap
settings.protocol.youtube_dl.path.set("youtube-dl")
```

### Settings for the FFmpeg protocol

#### Path to the ffmpeg binary

```liquidsoap
settings.protocol.ffmpeg.path.set("ffmpeg")
```

#### Should the protocol extract metadata

```liquidsoap
settings.protocol.ffmpeg.metadata.set(true)
```

#### Should the protocol adjust ReplayGain

```liquidsoap
settings.protocol.ffmpeg.replaygain.set(false)
```

### Settings for the text2wave protocol

#### Path to the text2wave binary

```liquidsoap
settings.protocol.text2wave.path.set("text2wave")
```

### Settings for the gtts protocol

#### Path to the gtts binary

```liquidsoap
settings.protocol.gtts.path.set("gtts-cli")
```

### Settings for the AWS protocol

#### Use a specific profile from your credential file.

```liquidsoap
settings.protocol.aws.profile.set(<value>)
```

#### Alternative endpoint URL (useful for other S3 implementations).

```liquidsoap
settings.protocol.aws.endpoint.set(<value>)
```

#### AWS Region

```liquidsoap
settings.protocol.aws.region.set(<value>)
```

#### Path to aws CLI binary

```liquidsoap
settings.protocol.aws.path.set("aws")
```

#### Settings for the polly protocol

##### Output format

```liquidsoap
settings.protocol.aws.polly.format.set("mp3")
```

##### Voice ID

```liquidsoap
settings.protocol.aws.polly.voice.set("Joanna")
```

## 

```liquidsoap
settings.make.set(<fun>)
```

### 

```liquidsoap
settings.make.void.set(<fun>)
```

### 

```liquidsoap
settings.make.protocol.set(<fun>)
```

### 

```liquidsoap
settings.make.external.set(<fun>)
```

## Decoder settings

### Native video metadata parser settings.

### Taglib settings

### Priorities used for choosing audio and video file decoders

#### Priority for the WAV decoder

```liquidsoap
settings.decoder.priorities.wav.set(1)
```

#### Priority for the SRT decoder

```liquidsoap
settings.decoder.priorities.srt.set(1)
```

#### Priority for the OGG decoder

```liquidsoap
settings.decoder.priorities.ogg.set(1)
```

#### Priority for the MP4 decoder

```liquidsoap
settings.decoder.priorities.mp4.set(1)
```

#### Priority for the mpeg audio decoder

```liquidsoap
settings.decoder.priorities.mad.set(1)
```

#### Priority for the flac decoder

```liquidsoap
settings.decoder.priorities.flac.set(1)
```

#### Priority for the ffmpeg decoder

```liquidsoap
settings.decoder.priorities.ffmpeg.set(10)
```

#### Priority for the PCM/BASIC decoder

```liquidsoap
settings.decoder.priorities.basic.set(1)
```

#### Priority for the AIFF decoder

```liquidsoap
settings.decoder.priorities.aiff.set(1)
```

#### Priority for the AAC decoder

```liquidsoap
settings.decoder.priorities.aac.set(1)
```

### Mime-types used for choosing audio and video file decoders

When a mime-type is available (e.g. with input.http), it can be usedto guess which audio stream format is used.This section contains the listings used for that detection, which youmight want to tweak if you encounter a new mime-type.If you feel that new mime-types should be permanently added, pleasecontact the developers.

#### Mime-types used for guessing WAV format

```liquidsoap
settings.decoder.mime_types.wav.set(["audio/vnd.wave", "audio/wav", "audio/wave", "audio/x-wav"])
```

#### Mime-types used for decoding metadata using native parser.

```liquidsoap
settings.decoder.mime_types.video_metadata.set(["video/x-msvideo", "video/mp4"])
```

#### Mime-types used for decoding metadata using TAGLIB

```liquidsoap
settings.decoder.mime_types.taglib.set(["audio/mpeg"])
```

#### Mime-types used for guessing SRT format

```liquidsoap
settings.decoder.mime_types.srt.set(["application/x-subrip"])
```

#### Mime-types used for guessing OGG format.

```liquidsoap
settings.decoder.mime_types.ogg.set(["audio/opus", "application/ogg", "application/x-ogg", "audio/x-ogg", "audio/ogg", "video/ogg"])
```

#### Mime-types used for guessing MP4 format

```liquidsoap
settings.decoder.mime_types.mp4.set(["audio/mp4", "application/mp4"])
```

#### Mime-types used for guessing MP3 format (DEPRECATED, use *.mad configuration keys!)

```liquidsoap
settings.decoder.mime_types.mp3.set(["audio/mpeg", "audio/MPA"])
```

#### Mime-types used for guessing mpeg audio format

```liquidsoap
settings.decoder.mime_types.mad.set(["audio/mpeg", "audio/MPA"])
```

#### Mime-types used for decoding metadata using native parser.

```liquidsoap
settings.decoder.mime_types.image_metadata.set(["image/png", "image/jpeg"])
```

#### Mime-types used for decoding metadata using native ID3v1 and ID3v2 parser

```liquidsoap
settings.decoder.mime_types.id3.set(["audio/mpeg", "audio/x-wav"])
```

#### Mime-types used for guessing FLAC format

```liquidsoap
settings.decoder.mime_types.flac.set(["audio/flac", "audio/x-flac"])
```

#### Mime-types used for decoding with ffmpeg

```liquidsoap
settings.decoder.mime_types.ffmpeg.set(["application/f4v", "application/ffmpeg", "application/mp4", "application/mxf", "application/octet-stream", "application/octet-stream", "application/ogg", "application/vnd.pg.format", "application/vnd.rn-realmedia", "application/vnd.smaf", "application/x-mpegURL", "application/x-ogg", "application/x-pgs", "application/x-shockwave-flash", "application/x-subrip", "application/xml", "audio/G722", "audio/MP4A-LATM", "audio/MPA", "audio/aac", "audio/aacp", "audio/aiff", "audio/amr", "audio/basic", "audio/bit", "audio/flac", "audio/g723", "audio/iLBC", "audio/mp4", "audio/mpeg", "audio/ogg", "audio/vnd.wave", "audio/wav", "audio/wave", "audio/webm", "audio/x-ac3", "audio/x-adpcm", "audio/x-caf", "audio/x-dca", "audio/x-eac3", "audio/x-flac", "audio/x-gsm", "audio/x-hx-aac-adts", "audio/x-ogg", "audio/x-oma", "audio/x-tta", "audio/x-voc", "audio/x-wav", "audio/x-wavpack", "multipart/x-mixed-replace;boundary=ffserver", "text/vtt", "text/x-ass", "text/x-jacosub", "text/x-microdvd", "video/3gpp", "video/3gpp2", "video/MP2T", "video/mp2t", "video/mp4", "video/mpeg", "video/ogg", "video/webm", "video/x-flv", "video/x-h261", "video/x-h263", "video/x-m4v", "video/x-matroska", "video/x-mjpeg", "video/x-ms-asf", "video/x-msvideo", "video/x-nut"])
```

##### Mime-types used for decoding images with ffmpeg

```liquidsoap
settings.decoder.mime_types.ffmpeg.images.set(["image/gif", "image/jpeg", "image/png", "image/vnd.microsoft.icon", "image/webp"])
```

#### Mime-types used for guessing PCM/BASIC format

```liquidsoap
settings.decoder.mime_types.basic.set(["audio/basic"])
```

#### Mime-types used for guessing AIFF format

```liquidsoap
settings.decoder.mime_types.aiff.set(["audio/x-aiff", "audio/aiff"])
```

#### Mime-types used for guessing AAC format

```liquidsoap
settings.decoder.mime_types.aac.set(["audio/aac", "audio/aacp", "audio/x-hx-aac-adts"])
```

### Native image metadata parser settings.

### Decoders and order used to decode image files.

```liquidsoap
settings.decoder.image_file_decoders.set(["PPM", "FFMPEG", "CAMLIMAGES", "SDL/IMAGE"])
```

### Native ID3 parser settings

### File extensions used for guessing audio formats

#### File extensions used for guessing WAV format

```liquidsoap
settings.decoder.file_extensions.wav.set(["wav", "wave"])
```

#### File extensions used for decoding metadata using native parser.

```liquidsoap
settings.decoder.file_extensions.video_metadata.set(["avi", "mp4"])
```

#### File extensions used for decoding metadata using TAGLIB

```liquidsoap
settings.decoder.file_extensions.taglib.set(["mp3"])
```

#### File extensions used for guessing SRT format

```liquidsoap
settings.decoder.file_extensions.srt.set(["srt"])
```

#### File extensions used for guessing OGG format

```liquidsoap
settings.decoder.file_extensions.ogg.set(["ogv", "oga", "ogx", "ogg", "opus"])
```

#### File extensions used for guessing MP4 format

```liquidsoap
settings.decoder.file_extensions.mp4.set(["m4a", "m4b", "m4p", "m4v", "m4r", "3gp", "mp4"])
```

#### File extensions used for guessing MP3 format (DEPRECATED, use *.mad configuration keys!)

```liquidsoap
settings.decoder.file_extensions.mp3.set(["mp3", "mp2", "mp1"])
```

#### File extensions used for guessing mpeg audio format

```liquidsoap
settings.decoder.file_extensions.mad.set(["mp3", "mp2", "mp1"])
```

#### File extensions used for decoding metadata using native parser.

```liquidsoap
settings.decoder.file_extensions.image_metadata.set(["png", "jpg", "jpeg"])
```

#### File extensions used for decoding metadata using native ID3v1 and ID3v2 parser

```liquidsoap
settings.decoder.file_extensions.id3.set(["mp3", "wav"])
```

#### File extensions used for guessing FLAC format

```liquidsoap
settings.decoder.file_extensions.flac.set(["flac"])
```

#### File extensions used for decoding media files (except images) with ffmpeg

```liquidsoap
settings.decoder.file_extensions.ffmpeg.set(["264", "265", "302", "3g2", "3gp", "669", "722", "A64", "a64", "aa", "aa3", "aac", "aax", "ac3", "acm", "adf", "adp", "ads", "adts", "adx", "aea", "afc", "aif", "aifc", "aiff", "aix", "amf", "amr", "ams", "amv", "ape", "apl", "apm", "apng", "aptx", "aptxhd", "aqt", "asf", "ass", "ast", "au", "aud", "avi", "avr", "avs", "avs2", "bcstm", "bfstm", "binka", "bit", "bmv", "brstm", "c2", "caf", "cavs", "cdata", "cdg", "cdxl", "cgi", "chk", "cif", "cpk", "cvg", "dat", "daud", "dav", "dbm", "dif", "digi", "dmf", "dnxhd", "dnxhr", "drc", "dsm", "dss", "dtk", "dtm", "dts", "dtshd", "dv", "dvd", "eac3", "f4v", "fap", "far", "ffmeta", "fits", "flac", "flm", "flv", "fsb", "fwse", "g722", "g723_1", "g729", "gdm", "genh", "gif", "gsm", "gxf", "h261", "h263", "h264", "h265", "hca", "hevc", "ice", "ico", "idf", "idx", "ifv", "imf", "imx", "ipu", "ircam", "ism", "isma", "ismv", "it", "ivf", "ivr", "j2b", "jss", "kux", "latm", "lbc", "loas", "lrc", "lvf", "m15", "m1v", "m2a", "m2t", "m2ts", "m2v", "m3u8", "m4a", "m4b", "m4v", "mac", "mca", "mcc", "mdl", "med", "mj2", "mjpeg", "mjpg", "mk3d", "mka", "mks", "mkv", "mlp", "mmcmp", "mmf", "mms", "mo3", "mod", "mods", "moflex", "mov", "mp2", "mp3", "mp4", "mpa", "mpc", "mpd", "mpeg", "mpg", "mpl2", "mptm", "msbc", "msf", "mt2", "mtaf", "mtm", "mts", "musx", "mvi", "mxf", "mxg", "nist", "nsp", "nst", "nut", "obu", "oga", "ogg", "ogv", "okt", "oma", "omg", "opus", "paf", "pcm", "pjs", "plm", "psm", "psp", "pt36", "ptm", "pvf", "qcif", "ra", "rco", "rcv", "rgb", "rm", "roq", "rsd", "rso", "rt", "s3m", "sami", "sbc", "sbg", "scc", "sdr2", "sds", "sdx", "ser", "sf", "sfx", "sfx2", "sga", "shn", "sln", "smi", "son", "sox", "spdif", "sph", "spx", "srt", "ss2", "ssa", "st26", "stk", "stl", "stm", "stp", "str", "sub", "sup", "svag", "svs", "swf", "tak", "tco", "thd", "ts", "tta", "ttml", "tun", "txt", "ty", "ty+", "ult", "umx", "v", "v210", "vag", "vb", "vc1", "vc2", "viv", "vob", "voc", "vpk", "vqe", "vqf", "vql", "vtt", "w64", "wav", "webm", "wma", "wmv", "wow", "wsd", "wtv", "wv", "xl", "xm", "xml", "xmv", "xpk", "xvag", "y4m", "yop", "yuv"])
```

##### File extensions used for decoding images with ffmpeg

```liquidsoap
settings.decoder.file_extensions.ffmpeg.images.set(["bmp", "cri", "dds", "dng", "dpx", "exr", "im1", "im24", "im32", "im8", "j2c", "j2k", "jls", "jp2", "jpc", "jpeg", "jpg", "jps", "ljpg", "mng", "mpg1-img", "mpg2-img", "mpg4-img", "mpo", "pam", "pbm", "pcd", "pct", "pcx", "pfm", "pgm", "pgmyuv", "pic", "pict", "pix", "png", "pnm", "pns", "ppm", "ptx", "ras", "raw", "rs", "sgi", "sun", "sunras", "svg", "svgz", "tga", "tif", "tiff", "webp", "xbm", "xface", "xpm", "xwd", "y", "yuv10"])
```

#### File extensions used for guessing AIFF format

```liquidsoap
settings.decoder.file_extensions.aiff.set(["aiff", "aif", "aifc"])
```

#### File extensions used for guessing AAC format

```liquidsoap
settings.decoder.file_extensions.aac.set(["aac"])
```

### FFmpeg decoder configuration

#### Codecs settings

##### Preferred codec to decode zmbv

```liquidsoap
settings.decoder.ffmpeg.codecs.zmbv.set(<value>)
```

###### Available codecs to decode zmbv

```liquidsoap
settings.decoder.ffmpeg.codecs.zmbv.available.set(["zmbv"])
```

##### Preferred codec to decode zlib

```liquidsoap
settings.decoder.ffmpeg.codecs.zlib.set(<value>)
```

###### Available codecs to decode zlib

```liquidsoap
settings.decoder.ffmpeg.codecs.zlib.available.set(["zlib"])
```

##### Preferred codec to decode yuv4

```liquidsoap
settings.decoder.ffmpeg.codecs.yuv4.set(<value>)
```

###### Available codecs to decode yuv4

```liquidsoap
settings.decoder.ffmpeg.codecs.yuv4.available.set(["yuv4"])
```

##### Preferred codec to decode yop

```liquidsoap
settings.decoder.ffmpeg.codecs.yop.set(<value>)
```

###### Available codecs to decode yop

```liquidsoap
settings.decoder.ffmpeg.codecs.yop.available.set(["yop"])
```

##### Preferred codec to decode ylc

```liquidsoap
settings.decoder.ffmpeg.codecs.ylc.set(<value>)
```

###### Available codecs to decode ylc

```liquidsoap
settings.decoder.ffmpeg.codecs.ylc.available.set(["ylc"])
```

##### Preferred codec to decode y41p

```liquidsoap
settings.decoder.ffmpeg.codecs.y41p.set(<value>)
```

###### Available codecs to decode y41p

```liquidsoap
settings.decoder.ffmpeg.codecs.y41p.available.set(["y41p"])
```

##### Preferred codec to decode xwd

```liquidsoap
settings.decoder.ffmpeg.codecs.xwd.set(<value>)
```

###### Available codecs to decode xwd

```liquidsoap
settings.decoder.ffmpeg.codecs.xwd.available.set(["xwd"])
```

##### Preferred codec to decode xpm

```liquidsoap
settings.decoder.ffmpeg.codecs.xpm.set(<value>)
```

###### Available codecs to decode xpm

```liquidsoap
settings.decoder.ffmpeg.codecs.xpm.available.set(["xpm"])
```

##### Preferred codec to decode xma2

```liquidsoap
settings.decoder.ffmpeg.codecs.xma2.set(<value>)
```

###### Available codecs to decode xma2

```liquidsoap
settings.decoder.ffmpeg.codecs.xma2.available.set(["xma2"])
```

##### Preferred codec to decode xma1

```liquidsoap
settings.decoder.ffmpeg.codecs.xma1.set(<value>)
```

###### Available codecs to decode xma1

```liquidsoap
settings.decoder.ffmpeg.codecs.xma1.available.set(["xma1"])
```

##### Preferred codec to decode xbm

```liquidsoap
settings.decoder.ffmpeg.codecs.xbm.set(<value>)
```

###### Available codecs to decode xbm

```liquidsoap
settings.decoder.ffmpeg.codecs.xbm.available.set(["xbm"])
```

##### Preferred codec to decode xan_wc4

```liquidsoap
settings.decoder.ffmpeg.codecs.xan_wc4.set(<value>)
```

###### Available codecs to decode xan_wc4

```liquidsoap
settings.decoder.ffmpeg.codecs.xan_wc4.available.set(["xan_wc4"])
```

##### Preferred codec to decode xan_wc3

```liquidsoap
settings.decoder.ffmpeg.codecs.xan_wc3.set(<value>)
```

###### Available codecs to decode xan_wc3

```liquidsoap
settings.decoder.ffmpeg.codecs.xan_wc3.available.set(["xan_wc3"])
```

##### Preferred codec to decode ws_vqa

```liquidsoap
settings.decoder.ffmpeg.codecs.ws_vqa.set(<value>)
```

###### Available codecs to decode ws_vqa

```liquidsoap
settings.decoder.ffmpeg.codecs.ws_vqa.available.set(["vqavideo"])
```

##### Preferred codec to decode wnv1

```liquidsoap
settings.decoder.ffmpeg.codecs.wnv1.set(<value>)
```

###### Available codecs to decode wnv1

```liquidsoap
settings.decoder.ffmpeg.codecs.wnv1.available.set(["wnv1"])
```

##### Preferred codec to decode wmv3

```liquidsoap
settings.decoder.ffmpeg.codecs.wmv3.set(<value>)
```

###### Available codecs to decode wmv3

```liquidsoap
settings.decoder.ffmpeg.codecs.wmv3.available.set(["wmv3"])
```

##### Preferred codec to decode wmv2

```liquidsoap
settings.decoder.ffmpeg.codecs.wmv2.set(<value>)
```

###### Available codecs to decode wmv2

```liquidsoap
settings.decoder.ffmpeg.codecs.wmv2.available.set(["wmv2"])
```

##### Preferred codec to decode wmv1

```liquidsoap
settings.decoder.ffmpeg.codecs.wmv1.set(<value>)
```

###### Available codecs to decode wmv1

```liquidsoap
settings.decoder.ffmpeg.codecs.wmv1.available.set(["wmv1"])
```

##### Preferred codec to decode wmavoice

```liquidsoap
settings.decoder.ffmpeg.codecs.wmavoice.set(<value>)
```

###### Available codecs to decode wmavoice

```liquidsoap
settings.decoder.ffmpeg.codecs.wmavoice.available.set(["wmavoice"])
```

##### Preferred codec to decode wmalossless

```liquidsoap
settings.decoder.ffmpeg.codecs.wmalossless.set(<value>)
```

###### Available codecs to decode wmalossless

```liquidsoap
settings.decoder.ffmpeg.codecs.wmalossless.available.set(["wmalossless"])
```

##### Preferred codec to decode westwood_snd1

```liquidsoap
settings.decoder.ffmpeg.codecs.westwood_snd1.set(<value>)
```

###### Available codecs to decode westwood_snd1

```liquidsoap
settings.decoder.ffmpeg.codecs.westwood_snd1.available.set(["ws_snd1"])
```

##### Preferred codec to decode webp

```liquidsoap
settings.decoder.ffmpeg.codecs.webp.set(<value>)
```

###### Available codecs to decode webp

```liquidsoap
settings.decoder.ffmpeg.codecs.webp.available.set(["webp"])
```

##### Preferred codec to decode wcmv

```liquidsoap
settings.decoder.ffmpeg.codecs.wcmv.set(<value>)
```

###### Available codecs to decode wcmv

```liquidsoap
settings.decoder.ffmpeg.codecs.wcmv.available.set(["wcmv"])
```

##### Preferred codec to decode wavpack

```liquidsoap
settings.decoder.ffmpeg.codecs.wavpack.set(<value>)
```

###### Available codecs to decode wavpack

```liquidsoap
settings.decoder.ffmpeg.codecs.wavpack.available.set(["wavpack"])
```

##### Preferred codec to decode wavesynth

```liquidsoap
settings.decoder.ffmpeg.codecs.wavesynth.set(<value>)
```

###### Available codecs to decode wavesynth

```liquidsoap
settings.decoder.ffmpeg.codecs.wavesynth.available.set(["wavesynth"])
```

##### Preferred codec to decode vp9

```liquidsoap
settings.decoder.ffmpeg.codecs.vp9.set(<value>)
```

###### Available codecs to decode vp9

```liquidsoap
settings.decoder.ffmpeg.codecs.vp9.available.set(["vp9", "vp9_v4l2m2m", "libvpx-vp9", "vp9_cuvid", "vp9_qsv"])
```

##### Preferred codec to decode vp8

```liquidsoap
settings.decoder.ffmpeg.codecs.vp8.set(<value>)
```

###### Available codecs to decode vp8

```liquidsoap
settings.decoder.ffmpeg.codecs.vp8.available.set(["vp8", "vp8_v4l2m2m", "libvpx", "vp8_cuvid", "vp8_qsv"])
```

##### Preferred codec to decode vp7

```liquidsoap
settings.decoder.ffmpeg.codecs.vp7.set(<value>)
```

###### Available codecs to decode vp7

```liquidsoap
settings.decoder.ffmpeg.codecs.vp7.available.set(["vp7"])
```

##### Preferred codec to decode vp6f

```liquidsoap
settings.decoder.ffmpeg.codecs.vp6f.set(<value>)
```

###### Available codecs to decode vp6f

```liquidsoap
settings.decoder.ffmpeg.codecs.vp6f.available.set(["vp6f"])
```

##### Preferred codec to decode vp6a

```liquidsoap
settings.decoder.ffmpeg.codecs.vp6a.set(<value>)
```

###### Available codecs to decode vp6a

```liquidsoap
settings.decoder.ffmpeg.codecs.vp6a.available.set(["vp6a"])
```

##### Preferred codec to decode vp6

```liquidsoap
settings.decoder.ffmpeg.codecs.vp6.set(<value>)
```

###### Available codecs to decode vp6

```liquidsoap
settings.decoder.ffmpeg.codecs.vp6.available.set(["vp6"])
```

##### Preferred codec to decode vp5

```liquidsoap
settings.decoder.ffmpeg.codecs.vp5.set(<value>)
```

###### Available codecs to decode vp5

```liquidsoap
settings.decoder.ffmpeg.codecs.vp5.available.set(["vp5"])
```

##### Preferred codec to decode vp4

```liquidsoap
settings.decoder.ffmpeg.codecs.vp4.set(<value>)
```

###### Available codecs to decode vp4

```liquidsoap
settings.decoder.ffmpeg.codecs.vp4.available.set(["vp4"])
```

##### Preferred codec to decode vp3

```liquidsoap
settings.decoder.ffmpeg.codecs.vp3.set(<value>)
```

###### Available codecs to decode vp3

```liquidsoap
settings.decoder.ffmpeg.codecs.vp3.available.set(["vp3"])
```

##### Preferred codec to decode vorbis

```liquidsoap
settings.decoder.ffmpeg.codecs.vorbis.set(<value>)
```

###### Available codecs to decode vorbis

```liquidsoap
settings.decoder.ffmpeg.codecs.vorbis.available.set(["vorbis", "libvorbis"])
```

##### Preferred codec to decode vmnc

```liquidsoap
settings.decoder.ffmpeg.codecs.vmnc.set(<value>)
```

###### Available codecs to decode vmnc

```liquidsoap
settings.decoder.ffmpeg.codecs.vmnc.available.set(["vmnc"])
```

##### Preferred codec to decode vmdvideo

```liquidsoap
settings.decoder.ffmpeg.codecs.vmdvideo.set(<value>)
```

###### Available codecs to decode vmdvideo

```liquidsoap
settings.decoder.ffmpeg.codecs.vmdvideo.available.set(["vmdvideo"])
```

##### Preferred codec to decode vmdaudio

```liquidsoap
settings.decoder.ffmpeg.codecs.vmdaudio.set(<value>)
```

###### Available codecs to decode vmdaudio

```liquidsoap
settings.decoder.ffmpeg.codecs.vmdaudio.available.set(["vmdaudio"])
```

##### Preferred codec to decode vixl

```liquidsoap
settings.decoder.ffmpeg.codecs.vixl.set(<value>)
```

###### Available codecs to decode vixl

```liquidsoap
settings.decoder.ffmpeg.codecs.vixl.available.set(["xl"])
```

##### Preferred codec to decode vcr1

```liquidsoap
settings.decoder.ffmpeg.codecs.vcr1.set(<value>)
```

###### Available codecs to decode vcr1

```liquidsoap
settings.decoder.ffmpeg.codecs.vcr1.available.set(["vcr1"])
```

##### Preferred codec to decode vc1image

```liquidsoap
settings.decoder.ffmpeg.codecs.vc1image.set(<value>)
```

###### Available codecs to decode vc1image

```liquidsoap
settings.decoder.ffmpeg.codecs.vc1image.available.set(["vc1image"])
```

##### Preferred codec to decode vc1

```liquidsoap
settings.decoder.ffmpeg.codecs.vc1.set(<value>)
```

###### Available codecs to decode vc1

```liquidsoap
settings.decoder.ffmpeg.codecs.vc1.available.set(["vc1", "vc1_qsv", "vc1_v4l2m2m", "vc1_cuvid"])
```

##### Preferred codec to decode vbn

```liquidsoap
settings.decoder.ffmpeg.codecs.vbn.set(<value>)
```

###### Available codecs to decode vbn

```liquidsoap
settings.decoder.ffmpeg.codecs.vbn.available.set(["vbn"])
```

##### Preferred codec to decode vble

```liquidsoap
settings.decoder.ffmpeg.codecs.vble.set(<value>)
```

###### Available codecs to decode vble

```liquidsoap
settings.decoder.ffmpeg.codecs.vble.available.set(["vble"])
```

##### Preferred codec to decode vb

```liquidsoap
settings.decoder.ffmpeg.codecs.vb.set(<value>)
```

###### Available codecs to decode vb

```liquidsoap
settings.decoder.ffmpeg.codecs.vb.available.set(["vb"])
```

##### Preferred codec to decode v410

```liquidsoap
settings.decoder.ffmpeg.codecs.v410.set(<value>)
```

###### Available codecs to decode v410

```liquidsoap
settings.decoder.ffmpeg.codecs.v410.available.set(["v410"])
```

##### Preferred codec to decode v408

```liquidsoap
settings.decoder.ffmpeg.codecs.v408.set(<value>)
```

###### Available codecs to decode v408

```liquidsoap
settings.decoder.ffmpeg.codecs.v408.available.set(["v408"])
```

##### Preferred codec to decode v308

```liquidsoap
settings.decoder.ffmpeg.codecs.v308.set(<value>)
```

###### Available codecs to decode v308

```liquidsoap
settings.decoder.ffmpeg.codecs.v308.available.set(["v308"])
```

##### Preferred codec to decode v210x

```liquidsoap
settings.decoder.ffmpeg.codecs.v210x.set(<value>)
```

###### Available codecs to decode v210x

```liquidsoap
settings.decoder.ffmpeg.codecs.v210x.available.set(["v210x"])
```

##### Preferred codec to decode v210

```liquidsoap
settings.decoder.ffmpeg.codecs.v210.set(<value>)
```

###### Available codecs to decode v210

```liquidsoap
settings.decoder.ffmpeg.codecs.v210.available.set(["v210"])
```

##### Preferred codec to decode ulti

```liquidsoap
settings.decoder.ffmpeg.codecs.ulti.set(<value>)
```

###### Available codecs to decode ulti

```liquidsoap
settings.decoder.ffmpeg.codecs.ulti.available.set(["ultimotion"])
```

##### Preferred codec to decode txd

```liquidsoap
settings.decoder.ffmpeg.codecs.txd.set(<value>)
```

###### Available codecs to decode txd

```liquidsoap
settings.decoder.ffmpeg.codecs.txd.available.set(["txd"])
```

##### Preferred codec to decode tta

```liquidsoap
settings.decoder.ffmpeg.codecs.tta.set(<value>)
```

###### Available codecs to decode tta

```liquidsoap
settings.decoder.ffmpeg.codecs.tta.available.set(["tta"])
```

##### Preferred codec to decode tscc2

```liquidsoap
settings.decoder.ffmpeg.codecs.tscc2.set(<value>)
```

###### Available codecs to decode tscc2

```liquidsoap
settings.decoder.ffmpeg.codecs.tscc2.available.set(["tscc2"])
```

##### Preferred codec to decode tscc

```liquidsoap
settings.decoder.ffmpeg.codecs.tscc.set(<value>)
```

###### Available codecs to decode tscc

```liquidsoap
settings.decoder.ffmpeg.codecs.tscc.available.set(["camtasia"])
```

##### Preferred codec to decode truemotion2rt

```liquidsoap
settings.decoder.ffmpeg.codecs.truemotion2rt.set(<value>)
```

###### Available codecs to decode truemotion2rt

```liquidsoap
settings.decoder.ffmpeg.codecs.truemotion2rt.available.set(["truemotion2rt"])
```

##### Preferred codec to decode truemotion2

```liquidsoap
settings.decoder.ffmpeg.codecs.truemotion2.set(<value>)
```

###### Available codecs to decode truemotion2

```liquidsoap
settings.decoder.ffmpeg.codecs.truemotion2.available.set(["truemotion2"])
```

##### Preferred codec to decode truemotion1

```liquidsoap
settings.decoder.ffmpeg.codecs.truemotion1.set(<value>)
```

###### Available codecs to decode truemotion1

```liquidsoap
settings.decoder.ffmpeg.codecs.truemotion1.available.set(["truemotion1"])
```

##### Preferred codec to decode truehd

```liquidsoap
settings.decoder.ffmpeg.codecs.truehd.set(<value>)
```

###### Available codecs to decode truehd

```liquidsoap
settings.decoder.ffmpeg.codecs.truehd.available.set(["truehd"])
```

##### Preferred codec to decode tqi

```liquidsoap
settings.decoder.ffmpeg.codecs.tqi.set(<value>)
```

###### Available codecs to decode tqi

```liquidsoap
settings.decoder.ffmpeg.codecs.tqi.available.set(["eatqi"])
```

##### Preferred codec to decode tmv

```liquidsoap
settings.decoder.ffmpeg.codecs.tmv.set(<value>)
```

###### Available codecs to decode tmv

```liquidsoap
settings.decoder.ffmpeg.codecs.tmv.available.set(["tmv"])
```

##### Preferred codec to decode tiff

```liquidsoap
settings.decoder.ffmpeg.codecs.tiff.set(<value>)
```

###### Available codecs to decode tiff

```liquidsoap
settings.decoder.ffmpeg.codecs.tiff.available.set(["tiff"])
```

##### Preferred codec to decode tiertexseqvideo

```liquidsoap
settings.decoder.ffmpeg.codecs.tiertexseqvideo.set(<value>)
```

###### Available codecs to decode tiertexseqvideo

```liquidsoap
settings.decoder.ffmpeg.codecs.tiertexseqvideo.available.set(["tiertexseqvideo"])
```

##### Preferred codec to decode thp

```liquidsoap
settings.decoder.ffmpeg.codecs.thp.set(<value>)
```

###### Available codecs to decode thp

```liquidsoap
settings.decoder.ffmpeg.codecs.thp.available.set(["thp"])
```

##### Preferred codec to decode theora

```liquidsoap
settings.decoder.ffmpeg.codecs.theora.set(<value>)
```

###### Available codecs to decode theora

```liquidsoap
settings.decoder.ffmpeg.codecs.theora.available.set(["theora"])
```

##### Preferred codec to decode tgv

```liquidsoap
settings.decoder.ffmpeg.codecs.tgv.set(<value>)
```

###### Available codecs to decode tgv

```liquidsoap
settings.decoder.ffmpeg.codecs.tgv.available.set(["eatgv"])
```

##### Preferred codec to decode tgq

```liquidsoap
settings.decoder.ffmpeg.codecs.tgq.set(<value>)
```

###### Available codecs to decode tgq

```liquidsoap
settings.decoder.ffmpeg.codecs.tgq.available.set(["eatgq"])
```

##### Preferred codec to decode tdsc

```liquidsoap
settings.decoder.ffmpeg.codecs.tdsc.set(<value>)
```

###### Available codecs to decode tdsc

```liquidsoap
settings.decoder.ffmpeg.codecs.tdsc.available.set(["tdsc"])
```

##### Preferred codec to decode targa_y216

```liquidsoap
settings.decoder.ffmpeg.codecs.targa_y216.set(<value>)
```

###### Available codecs to decode targa_y216

```liquidsoap
settings.decoder.ffmpeg.codecs.targa_y216.available.set(["targa_y216"])
```

##### Preferred codec to decode targa

```liquidsoap
settings.decoder.ffmpeg.codecs.targa.set(<value>)
```

###### Available codecs to decode targa

```liquidsoap
settings.decoder.ffmpeg.codecs.targa.available.set(["targa"])
```

##### Preferred codec to decode tak

```liquidsoap
settings.decoder.ffmpeg.codecs.tak.set(<value>)
```

###### Available codecs to decode tak

```liquidsoap
settings.decoder.ffmpeg.codecs.tak.available.set(["tak"])
```

##### Preferred codec to decode svq3

```liquidsoap
settings.decoder.ffmpeg.codecs.svq3.set(<value>)
```

###### Available codecs to decode svq3

```liquidsoap
settings.decoder.ffmpeg.codecs.svq3.available.set(["svq3"])
```

##### Preferred codec to decode svq1

```liquidsoap
settings.decoder.ffmpeg.codecs.svq1.set(<value>)
```

###### Available codecs to decode svq1

```liquidsoap
settings.decoder.ffmpeg.codecs.svq1.available.set(["svq1"])
```

##### Preferred codec to decode svg

```liquidsoap
settings.decoder.ffmpeg.codecs.svg.set(<value>)
```

###### Available codecs to decode svg

```liquidsoap
settings.decoder.ffmpeg.codecs.svg.available.set(["librsvg"])
```

##### Preferred codec to decode srgc

```liquidsoap
settings.decoder.ffmpeg.codecs.srgc.set(<value>)
```

###### Available codecs to decode srgc

```liquidsoap
settings.decoder.ffmpeg.codecs.srgc.available.set(["srgc"])
```

##### Preferred codec to decode speex

```liquidsoap
settings.decoder.ffmpeg.codecs.speex.set(<value>)
```

###### Available codecs to decode speex

```liquidsoap
settings.decoder.ffmpeg.codecs.speex.available.set(["speex", "libspeex"])
```

##### Preferred codec to decode speedhq

```liquidsoap
settings.decoder.ffmpeg.codecs.speedhq.set(<value>)
```

###### Available codecs to decode speedhq

```liquidsoap
settings.decoder.ffmpeg.codecs.speedhq.available.set(["speedhq"])
```

##### Preferred codec to decode sp5x

```liquidsoap
settings.decoder.ffmpeg.codecs.sp5x.set(<value>)
```

###### Available codecs to decode sp5x

```liquidsoap
settings.decoder.ffmpeg.codecs.sp5x.available.set(["sp5x"])
```

##### Preferred codec to decode sonic

```liquidsoap
settings.decoder.ffmpeg.codecs.sonic.set(<value>)
```

###### Available codecs to decode sonic

```liquidsoap
settings.decoder.ffmpeg.codecs.sonic.available.set(["sonic"])
```

##### Preferred codec to decode sol_dpcm

```liquidsoap
settings.decoder.ffmpeg.codecs.sol_dpcm.set(<value>)
```

###### Available codecs to decode sol_dpcm

```liquidsoap
settings.decoder.ffmpeg.codecs.sol_dpcm.available.set(["sol_dpcm"])
```

##### Preferred codec to decode snow

```liquidsoap
settings.decoder.ffmpeg.codecs.snow.set(<value>)
```

###### Available codecs to decode snow

```liquidsoap
settings.decoder.ffmpeg.codecs.snow.available.set(["snow"])
```

##### Preferred codec to decode smc

```liquidsoap
settings.decoder.ffmpeg.codecs.smc.set(<value>)
```

###### Available codecs to decode smc

```liquidsoap
settings.decoder.ffmpeg.codecs.smc.available.set(["smc"])
```

##### Preferred codec to decode siren

```liquidsoap
settings.decoder.ffmpeg.codecs.siren.set(<value>)
```

###### Available codecs to decode siren

```liquidsoap
settings.decoder.ffmpeg.codecs.siren.available.set(["siren"])
```

##### Preferred codec to decode sipr

```liquidsoap
settings.decoder.ffmpeg.codecs.sipr.set(<value>)
```

###### Available codecs to decode sipr

```liquidsoap
settings.decoder.ffmpeg.codecs.sipr.available.set(["sipr"])
```

##### Preferred codec to decode simbiosis_imx

```liquidsoap
settings.decoder.ffmpeg.codecs.simbiosis_imx.set(<value>)
```

###### Available codecs to decode simbiosis_imx

```liquidsoap
settings.decoder.ffmpeg.codecs.simbiosis_imx.available.set(["simbiosis_imx"])
```

##### Preferred codec to decode sgi

```liquidsoap
settings.decoder.ffmpeg.codecs.sgi.set(<value>)
```

###### Available codecs to decode sgi

```liquidsoap
settings.decoder.ffmpeg.codecs.sgi.available.set(["sgi"])
```

##### Preferred codec to decode sdx2_dpcm

```liquidsoap
settings.decoder.ffmpeg.codecs.sdx2_dpcm.set(<value>)
```

###### Available codecs to decode sdx2_dpcm

```liquidsoap
settings.decoder.ffmpeg.codecs.sdx2_dpcm.available.set(["sdx2_dpcm"])
```

##### Preferred codec to decode screenpresso

```liquidsoap
settings.decoder.ffmpeg.codecs.screenpresso.set(<value>)
```

###### Available codecs to decode screenpresso

```liquidsoap
settings.decoder.ffmpeg.codecs.screenpresso.available.set(["screenpresso"])
```

##### Preferred codec to decode scpr

```liquidsoap
settings.decoder.ffmpeg.codecs.scpr.set(<value>)
```

###### Available codecs to decode scpr

```liquidsoap
settings.decoder.ffmpeg.codecs.scpr.available.set(["scpr"])
```

##### Preferred codec to decode sbc

```liquidsoap
settings.decoder.ffmpeg.codecs.sbc.set(<value>)
```

###### Available codecs to decode sbc

```liquidsoap
settings.decoder.ffmpeg.codecs.sbc.available.set(["sbc"])
```

##### Preferred codec to decode sanm

```liquidsoap
settings.decoder.ffmpeg.codecs.sanm.set(<value>)
```

###### Available codecs to decode sanm

```liquidsoap
settings.decoder.ffmpeg.codecs.sanm.available.set(["sanm"])
```

##### Preferred codec to decode rv40

```liquidsoap
settings.decoder.ffmpeg.codecs.rv40.set(<value>)
```

###### Available codecs to decode rv40

```liquidsoap
settings.decoder.ffmpeg.codecs.rv40.available.set(["rv40"])
```

##### Preferred codec to decode rv30

```liquidsoap
settings.decoder.ffmpeg.codecs.rv30.set(<value>)
```

###### Available codecs to decode rv30

```liquidsoap
settings.decoder.ffmpeg.codecs.rv30.available.set(["rv30"])
```

##### Preferred codec to decode rv20

```liquidsoap
settings.decoder.ffmpeg.codecs.rv20.set(<value>)
```

###### Available codecs to decode rv20

```liquidsoap
settings.decoder.ffmpeg.codecs.rv20.available.set(["rv20"])
```

##### Preferred codec to decode rv10

```liquidsoap
settings.decoder.ffmpeg.codecs.rv10.set(<value>)
```

###### Available codecs to decode rv10

```liquidsoap
settings.decoder.ffmpeg.codecs.rv10.available.set(["rv10"])
```

##### Preferred codec to decode rscc

```liquidsoap
settings.decoder.ffmpeg.codecs.rscc.set(<value>)
```

###### Available codecs to decode rscc

```liquidsoap
settings.decoder.ffmpeg.codecs.rscc.available.set(["rscc"])
```

##### Preferred codec to decode rpza

```liquidsoap
settings.decoder.ffmpeg.codecs.rpza.set(<value>)
```

###### Available codecs to decode rpza

```liquidsoap
settings.decoder.ffmpeg.codecs.rpza.available.set(["rpza"])
```

##### Preferred codec to decode roq

```liquidsoap
settings.decoder.ffmpeg.codecs.roq.set(<value>)
```

###### Available codecs to decode roq

```liquidsoap
settings.decoder.ffmpeg.codecs.roq.available.set(["roqvideo"])
```

##### Preferred codec to decode rl2

```liquidsoap
settings.decoder.ffmpeg.codecs.rl2.set(<value>)
```

###### Available codecs to decode rl2

```liquidsoap
settings.decoder.ffmpeg.codecs.rl2.available.set(["rl2"])
```

##### Preferred codec to decode rasc

```liquidsoap
settings.decoder.ffmpeg.codecs.rasc.set(<value>)
```

###### Available codecs to decode rasc

```liquidsoap
settings.decoder.ffmpeg.codecs.rasc.available.set(["rasc"])
```

##### Preferred codec to decode ralf

```liquidsoap
settings.decoder.ffmpeg.codecs.ralf.set(<value>)
```

###### Available codecs to decode ralf

```liquidsoap
settings.decoder.ffmpeg.codecs.ralf.available.set(["ralf"])
```

##### Preferred codec to decode r210

```liquidsoap
settings.decoder.ffmpeg.codecs.r210.set(<value>)
```

###### Available codecs to decode r210

```liquidsoap
settings.decoder.ffmpeg.codecs.r210.available.set(["r210"])
```

##### Preferred codec to decode r10k

```liquidsoap
settings.decoder.ffmpeg.codecs.r10k.set(<value>)
```

###### Available codecs to decode r10k

```liquidsoap
settings.decoder.ffmpeg.codecs.r10k.available.set(["r10k"])
```

##### Preferred codec to decode qpeg

```liquidsoap
settings.decoder.ffmpeg.codecs.qpeg.set(<value>)
```

###### Available codecs to decode qpeg

```liquidsoap
settings.decoder.ffmpeg.codecs.qpeg.available.set(["qpeg"])
```

##### Preferred codec to decode qoi

```liquidsoap
settings.decoder.ffmpeg.codecs.qoi.set(<value>)
```

###### Available codecs to decode qoi

```liquidsoap
settings.decoder.ffmpeg.codecs.qoi.available.set(["qoi"])
```

##### Preferred codec to decode qdmc

```liquidsoap
settings.decoder.ffmpeg.codecs.qdmc.set(<value>)
```

###### Available codecs to decode qdmc

```liquidsoap
settings.decoder.ffmpeg.codecs.qdmc.available.set(["qdmc"])
```

##### Preferred codec to decode qdm2

```liquidsoap
settings.decoder.ffmpeg.codecs.qdm2.set(<value>)
```

###### Available codecs to decode qdm2

```liquidsoap
settings.decoder.ffmpeg.codecs.qdm2.available.set(["qdm2"])
```

##### Preferred codec to decode ptx

```liquidsoap
settings.decoder.ffmpeg.codecs.ptx.set(<value>)
```

###### Available codecs to decode ptx

```liquidsoap
settings.decoder.ffmpeg.codecs.ptx.available.set(["ptx"])
```

##### Preferred codec to decode psd

```liquidsoap
settings.decoder.ffmpeg.codecs.psd.set(<value>)
```

###### Available codecs to decode psd

```liquidsoap
settings.decoder.ffmpeg.codecs.psd.available.set(["psd"])
```

##### Preferred codec to decode ppm

```liquidsoap
settings.decoder.ffmpeg.codecs.ppm.set(<value>)
```

###### Available codecs to decode ppm

```liquidsoap
settings.decoder.ffmpeg.codecs.ppm.available.set(["ppm"])
```

##### Preferred codec to decode png

```liquidsoap
settings.decoder.ffmpeg.codecs.png.set(<value>)
```

###### Available codecs to decode png

```liquidsoap
settings.decoder.ffmpeg.codecs.png.available.set(["png"])
```

##### Preferred codec to decode pictor

```liquidsoap
settings.decoder.ffmpeg.codecs.pictor.set(<value>)
```

###### Available codecs to decode pictor

```liquidsoap
settings.decoder.ffmpeg.codecs.pictor.available.set(["pictor"])
```

##### Preferred codec to decode phm

```liquidsoap
settings.decoder.ffmpeg.codecs.phm.set(<value>)
```

###### Available codecs to decode phm

```liquidsoap
settings.decoder.ffmpeg.codecs.phm.available.set(["phm"])
```

##### Preferred codec to decode pgx

```liquidsoap
settings.decoder.ffmpeg.codecs.pgx.set(<value>)
```

###### Available codecs to decode pgx

```liquidsoap
settings.decoder.ffmpeg.codecs.pgx.available.set(["pgx"])
```

##### Preferred codec to decode pgmyuv

```liquidsoap
settings.decoder.ffmpeg.codecs.pgmyuv.set(<value>)
```

###### Available codecs to decode pgmyuv

```liquidsoap
settings.decoder.ffmpeg.codecs.pgmyuv.available.set(["pgmyuv"])
```

##### Preferred codec to decode pgm

```liquidsoap
settings.decoder.ffmpeg.codecs.pgm.set(<value>)
```

###### Available codecs to decode pgm

```liquidsoap
settings.decoder.ffmpeg.codecs.pgm.available.set(["pgm"])
```

##### Preferred codec to decode pfm

```liquidsoap
settings.decoder.ffmpeg.codecs.pfm.set(<value>)
```

###### Available codecs to decode pfm

```liquidsoap
settings.decoder.ffmpeg.codecs.pfm.available.set(["pfm"])
```

##### Preferred codec to decode pcx

```liquidsoap
settings.decoder.ffmpeg.codecs.pcx.set(<value>)
```

###### Available codecs to decode pcx

```liquidsoap
settings.decoder.ffmpeg.codecs.pcx.available.set(["pcx"])
```

##### Preferred codec to decode pcm_vidc

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_vidc.set(<value>)
```

###### Available codecs to decode pcm_vidc

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_vidc.available.set(["pcm_vidc"])
```

##### Preferred codec to decode pcm_u32le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u32le.set(<value>)
```

###### Available codecs to decode pcm_u32le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u32le.available.set(["pcm_u32le"])
```

##### Preferred codec to decode pcm_u32be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u32be.set(<value>)
```

###### Available codecs to decode pcm_u32be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u32be.available.set(["pcm_u32be"])
```

##### Preferred codec to decode pcm_u24le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u24le.set(<value>)
```

###### Available codecs to decode pcm_u24le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u24le.available.set(["pcm_u24le"])
```

##### Preferred codec to decode pcm_u24be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u24be.set(<value>)
```

###### Available codecs to decode pcm_u24be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u24be.available.set(["pcm_u24be"])
```

##### Preferred codec to decode pcm_u16le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u16le.set(<value>)
```

###### Available codecs to decode pcm_u16le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u16le.available.set(["pcm_u16le"])
```

##### Preferred codec to decode pcm_u16be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u16be.set(<value>)
```

###### Available codecs to decode pcm_u16be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_u16be.available.set(["pcm_u16be"])
```

##### Preferred codec to decode pcm_sga

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_sga.set(<value>)
```

###### Available codecs to decode pcm_sga

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_sga.available.set(["pcm_sga"])
```

##### Preferred codec to decode pcm_s64le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s64le.set(<value>)
```

###### Available codecs to decode pcm_s64le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s64le.available.set(["pcm_s64le"])
```

##### Preferred codec to decode pcm_s64be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s64be.set(<value>)
```

###### Available codecs to decode pcm_s64be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s64be.available.set(["pcm_s64be"])
```

##### Preferred codec to decode pcm_s32le_planar

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s32le_planar.set(<value>)
```

###### Available codecs to decode pcm_s32le_planar

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s32le_planar.available.set(["pcm_s32le_planar"])
```

##### Preferred codec to decode pcm_s32le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s32le.set(<value>)
```

###### Available codecs to decode pcm_s32le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s32le.available.set(["pcm_s32le"])
```

##### Preferred codec to decode pcm_s32be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s32be.set(<value>)
```

###### Available codecs to decode pcm_s32be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s32be.available.set(["pcm_s32be"])
```

##### Preferred codec to decode pcm_s24le_planar

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s24le_planar.set(<value>)
```

###### Available codecs to decode pcm_s24le_planar

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s24le_planar.available.set(["pcm_s24le_planar"])
```

##### Preferred codec to decode pcm_s24le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s24le.set(<value>)
```

###### Available codecs to decode pcm_s24le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s24le.available.set(["pcm_s24le"])
```

##### Preferred codec to decode pcm_s24daud

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s24daud.set(<value>)
```

###### Available codecs to decode pcm_s24daud

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s24daud.available.set(["pcm_s24daud"])
```

##### Preferred codec to decode pcm_s24be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s24be.set(<value>)
```

###### Available codecs to decode pcm_s24be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s24be.available.set(["pcm_s24be"])
```

##### Preferred codec to decode pcm_s16le_planar

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s16le_planar.set(<value>)
```

###### Available codecs to decode pcm_s16le_planar

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s16le_planar.available.set(["pcm_s16le_planar"])
```

##### Preferred codec to decode pcm_s16le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s16le.set(<value>)
```

###### Available codecs to decode pcm_s16le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s16le.available.set(["pcm_s16le"])
```

##### Preferred codec to decode pcm_s16be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s16be.set(<value>)
```

###### Available codecs to decode pcm_s16be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_s16be.available.set(["pcm_s16be"])
```

##### Preferred codec to decode pcm_lxf

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_lxf.set(<value>)
```

###### Available codecs to decode pcm_lxf

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_lxf.available.set(["pcm_lxf"])
```

##### Preferred codec to decode pcm_f64le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f64le.set(<value>)
```

###### Available codecs to decode pcm_f64le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f64le.available.set(["pcm_f64le"])
```

##### Preferred codec to decode pcm_f64be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f64be.set(<value>)
```

###### Available codecs to decode pcm_f64be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f64be.available.set(["pcm_f64be"])
```

##### Preferred codec to decode pcm_f32le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f32le.set(<value>)
```

###### Available codecs to decode pcm_f32le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f32le.available.set(["pcm_f32le"])
```

##### Preferred codec to decode pcm_f32be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f32be.set(<value>)
```

###### Available codecs to decode pcm_f32be

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f32be.available.set(["pcm_f32be"])
```

##### Preferred codec to decode pcm_f24le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f24le.set(<value>)
```

###### Available codecs to decode pcm_f24le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f24le.available.set(["pcm_f24le"])
```

##### Preferred codec to decode pcm_f16le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f16le.set(<value>)
```

###### Available codecs to decode pcm_f16le

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_f16le.available.set(["pcm_f16le"])
```

##### Preferred codec to decode pcm_dvd

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_dvd.set(<value>)
```

###### Available codecs to decode pcm_dvd

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_dvd.available.set(["pcm_dvd"])
```

##### Preferred codec to decode pcm_bluray

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_bluray.set(<value>)
```

###### Available codecs to decode pcm_bluray

```liquidsoap
settings.decoder.ffmpeg.codecs.pcm_bluray.available.set(["pcm_bluray"])
```

##### Preferred codec to decode pbm

```liquidsoap
settings.decoder.ffmpeg.codecs.pbm.set(<value>)
```

###### Available codecs to decode pbm

```liquidsoap
settings.decoder.ffmpeg.codecs.pbm.available.set(["pbm"])
```

##### Preferred codec to decode pam

```liquidsoap
settings.decoder.ffmpeg.codecs.pam.set(<value>)
```

###### Available codecs to decode pam

```liquidsoap
settings.decoder.ffmpeg.codecs.pam.available.set(["pam"])
```

##### Preferred codec to decode opus

```liquidsoap
settings.decoder.ffmpeg.codecs.opus.set(<value>)
```

###### Available codecs to decode opus

```liquidsoap
settings.decoder.ffmpeg.codecs.opus.available.set(["opus", "libopus"])
```

##### Preferred codec to decode nuv

```liquidsoap
settings.decoder.ffmpeg.codecs.nuv.set(<value>)
```

###### Available codecs to decode nuv

```liquidsoap
settings.decoder.ffmpeg.codecs.nuv.available.set(["nuv"])
```

##### Preferred codec to decode notchlc

```liquidsoap
settings.decoder.ffmpeg.codecs.notchlc.set(<value>)
```

###### Available codecs to decode notchlc

```liquidsoap
settings.decoder.ffmpeg.codecs.notchlc.available.set(["notchlc"])
```

##### Preferred codec to decode mxpeg

```liquidsoap
settings.decoder.ffmpeg.codecs.mxpeg.set(<value>)
```

###### Available codecs to decode mxpeg

```liquidsoap
settings.decoder.ffmpeg.codecs.mxpeg.available.set(["mxpeg"])
```

##### Preferred codec to decode mwsc

```liquidsoap
settings.decoder.ffmpeg.codecs.mwsc.set(<value>)
```

###### Available codecs to decode mwsc

```liquidsoap
settings.decoder.ffmpeg.codecs.mwsc.available.set(["mwsc"])
```

##### Preferred codec to decode mvha

```liquidsoap
settings.decoder.ffmpeg.codecs.mvha.set(<value>)
```

###### Available codecs to decode mvha

```liquidsoap
settings.decoder.ffmpeg.codecs.mvha.available.set(["mvha"])
```

##### Preferred codec to decode mvdv

```liquidsoap
settings.decoder.ffmpeg.codecs.mvdv.set(<value>)
```

###### Available codecs to decode mvdv

```liquidsoap
settings.decoder.ffmpeg.codecs.mvdv.available.set(["mvdv"])
```

##### Preferred codec to decode mvc2

```liquidsoap
settings.decoder.ffmpeg.codecs.mvc2.set(<value>)
```

###### Available codecs to decode mvc2

```liquidsoap
settings.decoder.ffmpeg.codecs.mvc2.available.set(["mvc2"])
```

##### Preferred codec to decode mvc1

```liquidsoap
settings.decoder.ffmpeg.codecs.mvc1.set(<value>)
```

###### Available codecs to decode mvc1

```liquidsoap
settings.decoder.ffmpeg.codecs.mvc1.available.set(["mvc1"])
```

##### Preferred codec to decode mv30

```liquidsoap
settings.decoder.ffmpeg.codecs.mv30.set(<value>)
```

###### Available codecs to decode mv30

```liquidsoap
settings.decoder.ffmpeg.codecs.mv30.available.set(["mv30"])
```

##### Preferred codec to decode mts2

```liquidsoap
settings.decoder.ffmpeg.codecs.mts2.set(<value>)
```

###### Available codecs to decode mts2

```liquidsoap
settings.decoder.ffmpeg.codecs.mts2.available.set(["mts2"])
```

##### Preferred codec to decode mszh

```liquidsoap
settings.decoder.ffmpeg.codecs.mszh.set(<value>)
```

###### Available codecs to decode mszh

```liquidsoap
settings.decoder.ffmpeg.codecs.mszh.available.set(["mszh"])
```

##### Preferred codec to decode mss2

```liquidsoap
settings.decoder.ffmpeg.codecs.mss2.set(<value>)
```

###### Available codecs to decode mss2

```liquidsoap
settings.decoder.ffmpeg.codecs.mss2.available.set(["mss2"])
```

##### Preferred codec to decode mss1

```liquidsoap
settings.decoder.ffmpeg.codecs.mss1.set(<value>)
```

###### Available codecs to decode mss1

```liquidsoap
settings.decoder.ffmpeg.codecs.mss1.available.set(["mss1"])
```

##### Preferred codec to decode msrle

```liquidsoap
settings.decoder.ffmpeg.codecs.msrle.set(<value>)
```

###### Available codecs to decode msrle

```liquidsoap
settings.decoder.ffmpeg.codecs.msrle.available.set(["msrle"])
```

##### Preferred codec to decode msp2

```liquidsoap
settings.decoder.ffmpeg.codecs.msp2.set(<value>)
```

###### Available codecs to decode msp2

```liquidsoap
settings.decoder.ffmpeg.codecs.msp2.available.set(["msp2"])
```

##### Preferred codec to decode msmpeg4v3

```liquidsoap
settings.decoder.ffmpeg.codecs.msmpeg4v3.set(<value>)
```

###### Available codecs to decode msmpeg4v3

```liquidsoap
settings.decoder.ffmpeg.codecs.msmpeg4v3.available.set(["msmpeg4"])
```

##### Preferred codec to decode msmpeg4v2

```liquidsoap
settings.decoder.ffmpeg.codecs.msmpeg4v2.set(<value>)
```

###### Available codecs to decode msmpeg4v2

```liquidsoap
settings.decoder.ffmpeg.codecs.msmpeg4v2.available.set(["msmpeg4v2"])
```

##### Preferred codec to decode msmpeg4v1

```liquidsoap
settings.decoder.ffmpeg.codecs.msmpeg4v1.set(<value>)
```

###### Available codecs to decode msmpeg4v1

```liquidsoap
settings.decoder.ffmpeg.codecs.msmpeg4v1.available.set(["msmpeg4v1"])
```

##### Preferred codec to decode mscc

```liquidsoap
settings.decoder.ffmpeg.codecs.mscc.set(<value>)
```

###### Available codecs to decode mscc

```liquidsoap
settings.decoder.ffmpeg.codecs.mscc.available.set(["mscc"])
```

##### Preferred codec to decode msa1

```liquidsoap
settings.decoder.ffmpeg.codecs.msa1.set(<value>)
```

###### Available codecs to decode msa1

```liquidsoap
settings.decoder.ffmpeg.codecs.msa1.available.set(["msa1"])
```

##### Preferred codec to decode mpeg4

```liquidsoap
settings.decoder.ffmpeg.codecs.mpeg4.set(<value>)
```

###### Available codecs to decode mpeg4

```liquidsoap
settings.decoder.ffmpeg.codecs.mpeg4.available.set(["mpeg4", "mpeg4_v4l2m2m", "mpeg4_cuvid"])
```

##### Preferred codec to decode mpeg2video

```liquidsoap
settings.decoder.ffmpeg.codecs.mpeg2video.set(<value>)
```

###### Available codecs to decode mpeg2video

```liquidsoap
settings.decoder.ffmpeg.codecs.mpeg2video.available.set(["mpeg2video", "mpegvideo", "mpeg2_v4l2m2m", "mpeg2_qsv", "mpeg2_cuvid"])
```

##### Preferred codec to decode mpeg1video

```liquidsoap
settings.decoder.ffmpeg.codecs.mpeg1video.set(<value>)
```

###### Available codecs to decode mpeg1video

```liquidsoap
settings.decoder.ffmpeg.codecs.mpeg1video.available.set(["mpeg1video", "mpeg1_v4l2m2m", "mpeg1_cuvid"])
```

##### Preferred codec to decode mp3

```liquidsoap
settings.decoder.ffmpeg.codecs.mp3.set(<value>)
```

###### Available codecs to decode mp3

```liquidsoap
settings.decoder.ffmpeg.codecs.mp3.available.set(["mp3float", "mp3"])
```

##### Preferred codec to decode mp2

```liquidsoap
settings.decoder.ffmpeg.codecs.mp2.set(<value>)
```

###### Available codecs to decode mp2

```liquidsoap
settings.decoder.ffmpeg.codecs.mp2.available.set(["mp2", "mp2float"])
```

##### Preferred codec to decode mp1

```liquidsoap
settings.decoder.ffmpeg.codecs.mp1.set(<value>)
```

###### Available codecs to decode mp1

```liquidsoap
settings.decoder.ffmpeg.codecs.mp1.available.set(["mp1", "mp1float"])
```

##### Preferred codec to decode motionpixels

```liquidsoap
settings.decoder.ffmpeg.codecs.motionpixels.set(<value>)
```

###### Available codecs to decode motionpixels

```liquidsoap
settings.decoder.ffmpeg.codecs.motionpixels.available.set(["motionpixels"])
```

##### Preferred codec to decode mobiclip

```liquidsoap
settings.decoder.ffmpeg.codecs.mobiclip.set(<value>)
```

###### Available codecs to decode mobiclip

```liquidsoap
settings.decoder.ffmpeg.codecs.mobiclip.available.set(["mobiclip"])
```

##### Preferred codec to decode mlp

```liquidsoap
settings.decoder.ffmpeg.codecs.mlp.set(<value>)
```

###### Available codecs to decode mlp

```liquidsoap
settings.decoder.ffmpeg.codecs.mlp.available.set(["mlp"])
```

##### Preferred codec to decode mjpegb

```liquidsoap
settings.decoder.ffmpeg.codecs.mjpegb.set(<value>)
```

###### Available codecs to decode mjpegb

```liquidsoap
settings.decoder.ffmpeg.codecs.mjpegb.available.set(["mjpegb"])
```

##### Preferred codec to decode mjpeg

```liquidsoap
settings.decoder.ffmpeg.codecs.mjpeg.set(<value>)
```

###### Available codecs to decode mjpeg

```liquidsoap
settings.decoder.ffmpeg.codecs.mjpeg.available.set(["mjpeg", "mjpeg_cuvid", "mjpeg_qsv"])
```

##### Preferred codec to decode mimic

```liquidsoap
settings.decoder.ffmpeg.codecs.mimic.set(<value>)
```

###### Available codecs to decode mimic

```liquidsoap
settings.decoder.ffmpeg.codecs.mimic.available.set(["mimic"])
```

##### Preferred codec to decode metasound

```liquidsoap
settings.decoder.ffmpeg.codecs.metasound.set(<value>)
```

###### Available codecs to decode metasound

```liquidsoap
settings.decoder.ffmpeg.codecs.metasound.available.set(["metasound"])
```

##### Preferred codec to decode mdec

```liquidsoap
settings.decoder.ffmpeg.codecs.mdec.set(<value>)
```

###### Available codecs to decode mdec

```liquidsoap
settings.decoder.ffmpeg.codecs.mdec.available.set(["mdec"])
```

##### Preferred codec to decode mad

```liquidsoap
settings.decoder.ffmpeg.codecs.mad.set(<value>)
```

###### Available codecs to decode mad

```liquidsoap
settings.decoder.ffmpeg.codecs.mad.available.set(["eamad"])
```

##### Preferred codec to decode mace6

```liquidsoap
settings.decoder.ffmpeg.codecs.mace6.set(<value>)
```

###### Available codecs to decode mace6

```liquidsoap
settings.decoder.ffmpeg.codecs.mace6.available.set(["mace6"])
```

##### Preferred codec to decode mace3

```liquidsoap
settings.decoder.ffmpeg.codecs.mace3.set(<value>)
```

###### Available codecs to decode mace3

```liquidsoap
settings.decoder.ffmpeg.codecs.mace3.available.set(["mace3"])
```

##### Preferred codec to decode m101

```liquidsoap
settings.decoder.ffmpeg.codecs.m101.set(<value>)
```

###### Available codecs to decode m101

```liquidsoap
settings.decoder.ffmpeg.codecs.m101.available.set(["m101"])
```

##### Preferred codec to decode lscr

```liquidsoap
settings.decoder.ffmpeg.codecs.lscr.set(<value>)
```

###### Available codecs to decode lscr

```liquidsoap
settings.decoder.ffmpeg.codecs.lscr.available.set(["lscr"])
```

##### Preferred codec to decode loco

```liquidsoap
settings.decoder.ffmpeg.codecs.loco.set(<value>)
```

###### Available codecs to decode loco

```liquidsoap
settings.decoder.ffmpeg.codecs.loco.available.set(["loco"])
```

##### Preferred codec to decode lagarith

```liquidsoap
settings.decoder.ffmpeg.codecs.lagarith.set(<value>)
```

###### Available codecs to decode lagarith

```liquidsoap
settings.decoder.ffmpeg.codecs.lagarith.available.set(["lagarith"])
```

##### Preferred codec to decode kmvc

```liquidsoap
settings.decoder.ffmpeg.codecs.kmvc.set(<value>)
```

###### Available codecs to decode kmvc

```liquidsoap
settings.decoder.ffmpeg.codecs.kmvc.available.set(["kmvc"])
```

##### Preferred codec to decode kgv1

```liquidsoap
settings.decoder.ffmpeg.codecs.kgv1.set(<value>)
```

###### Available codecs to decode kgv1

```liquidsoap
settings.decoder.ffmpeg.codecs.kgv1.available.set(["kgv1"])
```

##### Preferred codec to decode jv

```liquidsoap
settings.decoder.ffmpeg.codecs.jv.set(<value>)
```

###### Available codecs to decode jv

```liquidsoap
settings.decoder.ffmpeg.codecs.jv.available.set(["jv"])
```

##### Preferred codec to decode jpeg2000

```liquidsoap
settings.decoder.ffmpeg.codecs.jpeg2000.set(<value>)
```

###### Available codecs to decode jpeg2000

```liquidsoap
settings.decoder.ffmpeg.codecs.jpeg2000.available.set(["jpeg2000", "libopenjpeg"])
```

##### Preferred codec to decode ipu

```liquidsoap
settings.decoder.ffmpeg.codecs.ipu.set(<value>)
```

###### Available codecs to decode ipu

```liquidsoap
settings.decoder.ffmpeg.codecs.ipu.available.set(["ipu"])
```

##### Preferred codec to decode interplayvideo

```liquidsoap
settings.decoder.ffmpeg.codecs.interplayvideo.set(<value>)
```

###### Available codecs to decode interplayvideo

```liquidsoap
settings.decoder.ffmpeg.codecs.interplayvideo.available.set(["interplayvideo"])
```

##### Preferred codec to decode interplayacm

```liquidsoap
settings.decoder.ffmpeg.codecs.interplayacm.set(<value>)
```

###### Available codecs to decode interplayacm

```liquidsoap
settings.decoder.ffmpeg.codecs.interplayacm.available.set(["interplayacm"])
```

##### Preferred codec to decode imm5

```liquidsoap
settings.decoder.ffmpeg.codecs.imm5.set(<value>)
```

###### Available codecs to decode imm5

```liquidsoap
settings.decoder.ffmpeg.codecs.imm5.available.set(["imm5"])
```

##### Preferred codec to decode imm4

```liquidsoap
settings.decoder.ffmpeg.codecs.imm4.set(<value>)
```

###### Available codecs to decode imm4

```liquidsoap
settings.decoder.ffmpeg.codecs.imm4.available.set(["imm4"])
```

##### Preferred codec to decode imc

```liquidsoap
settings.decoder.ffmpeg.codecs.imc.set(<value>)
```

###### Available codecs to decode imc

```liquidsoap
settings.decoder.ffmpeg.codecs.imc.available.set(["imc"])
```

##### Preferred codec to decode ilbc

```liquidsoap
settings.decoder.ffmpeg.codecs.ilbc.set(<value>)
```

###### Available codecs to decode ilbc

```liquidsoap
settings.decoder.ffmpeg.codecs.ilbc.available.set(["ilbc"])
```

##### Preferred codec to decode iff_ilbm

```liquidsoap
settings.decoder.ffmpeg.codecs.iff_ilbm.set(<value>)
```

###### Available codecs to decode iff_ilbm

```liquidsoap
settings.decoder.ffmpeg.codecs.iff_ilbm.available.set(["iff"])
```

##### Preferred codec to decode iac

```liquidsoap
settings.decoder.ffmpeg.codecs.iac.set(<value>)
```

###### Available codecs to decode iac

```liquidsoap
settings.decoder.ffmpeg.codecs.iac.available.set(["iac"])
```

##### Preferred codec to decode hymt

```liquidsoap
settings.decoder.ffmpeg.codecs.hymt.set(<value>)
```

###### Available codecs to decode hymt

```liquidsoap
settings.decoder.ffmpeg.codecs.hymt.available.set(["hymt"])
```

##### Preferred codec to decode hqx

```liquidsoap
settings.decoder.ffmpeg.codecs.hqx.set(<value>)
```

###### Available codecs to decode hqx

```liquidsoap
settings.decoder.ffmpeg.codecs.hqx.available.set(["hqx"])
```

##### Preferred codec to decode hq_hqa

```liquidsoap
settings.decoder.ffmpeg.codecs.hq_hqa.set(<value>)
```

###### Available codecs to decode hq_hqa

```liquidsoap
settings.decoder.ffmpeg.codecs.hq_hqa.available.set(["hq_hqa"])
```

##### Preferred codec to decode hnm4video

```liquidsoap
settings.decoder.ffmpeg.codecs.hnm4video.set(<value>)
```

###### Available codecs to decode hnm4video

```liquidsoap
settings.decoder.ffmpeg.codecs.hnm4video.available.set(["hnm4video"])
```

##### Preferred codec to decode hevc

```liquidsoap
settings.decoder.ffmpeg.codecs.hevc.set(<value>)
```

###### Available codecs to decode hevc

```liquidsoap
settings.decoder.ffmpeg.codecs.hevc.available.set(["hevc", "hevc_qsv", "hevc_v4l2m2m", "hevc_cuvid"])
```

##### Preferred codec to decode hcom

```liquidsoap
settings.decoder.ffmpeg.codecs.hcom.set(<value>)
```

###### Available codecs to decode hcom

```liquidsoap
settings.decoder.ffmpeg.codecs.hcom.available.set(["hcom"])
```

##### Preferred codec to decode hca

```liquidsoap
settings.decoder.ffmpeg.codecs.hca.set(<value>)
```

###### Available codecs to decode hca

```liquidsoap
settings.decoder.ffmpeg.codecs.hca.available.set(["hca"])
```

##### Preferred codec to decode hap

```liquidsoap
settings.decoder.ffmpeg.codecs.hap.set(<value>)
```

###### Available codecs to decode hap

```liquidsoap
settings.decoder.ffmpeg.codecs.hap.available.set(["hap"])
```

##### Preferred codec to decode h264

```liquidsoap
settings.decoder.ffmpeg.codecs.h264.set(<value>)
```

###### Available codecs to decode h264

```liquidsoap
settings.decoder.ffmpeg.codecs.h264.available.set(["h264", "h264_v4l2m2m", "h264_qsv", "h264_cuvid"])
```

##### Preferred codec to decode h263p

```liquidsoap
settings.decoder.ffmpeg.codecs.h263p.set(<value>)
```

###### Available codecs to decode h263p

```liquidsoap
settings.decoder.ffmpeg.codecs.h263p.available.set(["h263p"])
```

##### Preferred codec to decode h263i

```liquidsoap
settings.decoder.ffmpeg.codecs.h263i.set(<value>)
```

###### Available codecs to decode h263i

```liquidsoap
settings.decoder.ffmpeg.codecs.h263i.available.set(["h263i"])
```

##### Preferred codec to decode h263

```liquidsoap
settings.decoder.ffmpeg.codecs.h263.set(<value>)
```

###### Available codecs to decode h263

```liquidsoap
settings.decoder.ffmpeg.codecs.h263.available.set(["h263", "h263_v4l2m2m"])
```

##### Preferred codec to decode h261

```liquidsoap
settings.decoder.ffmpeg.codecs.h261.set(<value>)
```

###### Available codecs to decode h261

```liquidsoap
settings.decoder.ffmpeg.codecs.h261.available.set(["h261"])
```

##### Preferred codec to decode gsm

```liquidsoap
settings.decoder.ffmpeg.codecs.gsm.set(<value>)
```

###### Available codecs to decode gsm

```liquidsoap
settings.decoder.ffmpeg.codecs.gsm.available.set(["gsm", "libgsm"])
```

##### Preferred codec to decode gif

```liquidsoap
settings.decoder.ffmpeg.codecs.gif.set(<value>)
```

###### Available codecs to decode gif

```liquidsoap
settings.decoder.ffmpeg.codecs.gif.available.set(["gif"])
```

##### Preferred codec to decode gem

```liquidsoap
settings.decoder.ffmpeg.codecs.gem.set(<value>)
```

###### Available codecs to decode gem

```liquidsoap
settings.decoder.ffmpeg.codecs.gem.available.set(["gem"])
```

##### Preferred codec to decode gdv

```liquidsoap
settings.decoder.ffmpeg.codecs.gdv.set(<value>)
```

###### Available codecs to decode gdv

```liquidsoap
settings.decoder.ffmpeg.codecs.gdv.available.set(["gdv"])
```

##### Preferred codec to decode g729

```liquidsoap
settings.decoder.ffmpeg.codecs.g729.set(<value>)
```

###### Available codecs to decode g729

```liquidsoap
settings.decoder.ffmpeg.codecs.g729.available.set(["g729"])
```

##### Preferred codec to decode g723_1

```liquidsoap
settings.decoder.ffmpeg.codecs.g723_1.set(<value>)
```

###### Available codecs to decode g723_1

```liquidsoap
settings.decoder.ffmpeg.codecs.g723_1.available.set(["g723_1"])
```

##### Preferred codec to decode g2m

```liquidsoap
settings.decoder.ffmpeg.codecs.g2m.set(<value>)
```

###### Available codecs to decode g2m

```liquidsoap
settings.decoder.ffmpeg.codecs.g2m.available.set(["g2m"])
```

##### Preferred codec to decode frwu

```liquidsoap
settings.decoder.ffmpeg.codecs.frwu.set(<value>)
```

###### Available codecs to decode frwu

```liquidsoap
settings.decoder.ffmpeg.codecs.frwu.available.set(["frwu"])
```

##### Preferred codec to decode fraps

```liquidsoap
settings.decoder.ffmpeg.codecs.fraps.set(<value>)
```

###### Available codecs to decode fraps

```liquidsoap
settings.decoder.ffmpeg.codecs.fraps.available.set(["fraps"])
```

##### Preferred codec to decode fmvc

```liquidsoap
settings.decoder.ffmpeg.codecs.fmvc.set(<value>)
```

###### Available codecs to decode fmvc

```liquidsoap
settings.decoder.ffmpeg.codecs.fmvc.available.set(["fmvc"])
```

##### Preferred codec to decode flv1

```liquidsoap
settings.decoder.ffmpeg.codecs.flv1.set(<value>)
```

###### Available codecs to decode flv1

```liquidsoap
settings.decoder.ffmpeg.codecs.flv1.available.set(["flv"])
```

##### Preferred codec to decode flic

```liquidsoap
settings.decoder.ffmpeg.codecs.flic.set(<value>)
```

###### Available codecs to decode flic

```liquidsoap
settings.decoder.ffmpeg.codecs.flic.available.set(["flic"])
```

##### Preferred codec to decode flashsv

```liquidsoap
settings.decoder.ffmpeg.codecs.flashsv.set(<value>)
```

###### Available codecs to decode flashsv

```liquidsoap
settings.decoder.ffmpeg.codecs.flashsv.available.set(["flashsv"])
```

##### Preferred codec to decode flac

```liquidsoap
settings.decoder.ffmpeg.codecs.flac.set(<value>)
```

###### Available codecs to decode flac

```liquidsoap
settings.decoder.ffmpeg.codecs.flac.available.set(["flac"])
```

##### Preferred codec to decode fits

```liquidsoap
settings.decoder.ffmpeg.codecs.fits.set(<value>)
```

###### Available codecs to decode fits

```liquidsoap
settings.decoder.ffmpeg.codecs.fits.available.set(["fits"])
```

##### Preferred codec to decode fic

```liquidsoap
settings.decoder.ffmpeg.codecs.fic.set(<value>)
```

###### Available codecs to decode fic

```liquidsoap
settings.decoder.ffmpeg.codecs.fic.available.set(["fic"])
```

##### Preferred codec to decode ffv1

```liquidsoap
settings.decoder.ffmpeg.codecs.ffv1.set(<value>)
```

###### Available codecs to decode ffv1

```liquidsoap
settings.decoder.ffmpeg.codecs.ffv1.available.set(["ffv1"])
```

##### Preferred codec to decode fastaudio

```liquidsoap
settings.decoder.ffmpeg.codecs.fastaudio.set(<value>)
```

###### Available codecs to decode fastaudio

```liquidsoap
settings.decoder.ffmpeg.codecs.fastaudio.available.set(["fastaudio"])
```

##### Preferred codec to decode exr

```liquidsoap
settings.decoder.ffmpeg.codecs.exr.set(<value>)
```

###### Available codecs to decode exr

```liquidsoap
settings.decoder.ffmpeg.codecs.exr.available.set(["exr"])
```

##### Preferred codec to decode evrc

```liquidsoap
settings.decoder.ffmpeg.codecs.evrc.set(<value>)
```

###### Available codecs to decode evrc

```liquidsoap
settings.decoder.ffmpeg.codecs.evrc.available.set(["evrc"])
```

##### Preferred codec to decode escape130

```liquidsoap
settings.decoder.ffmpeg.codecs.escape130.set(<value>)
```

###### Available codecs to decode escape130

```liquidsoap
settings.decoder.ffmpeg.codecs.escape130.available.set(["escape130"])
```

##### Preferred codec to decode escape124

```liquidsoap
settings.decoder.ffmpeg.codecs.escape124.set(<value>)
```

###### Available codecs to decode escape124

```liquidsoap
settings.decoder.ffmpeg.codecs.escape124.available.set(["escape124"])
```

##### Preferred codec to decode eac3

```liquidsoap
settings.decoder.ffmpeg.codecs.eac3.set(<value>)
```

###### Available codecs to decode eac3

```liquidsoap
settings.decoder.ffmpeg.codecs.eac3.available.set(["eac3"])
```

##### Preferred codec to decode dxv

```liquidsoap
settings.decoder.ffmpeg.codecs.dxv.set(<value>)
```

###### Available codecs to decode dxv

```liquidsoap
settings.decoder.ffmpeg.codecs.dxv.available.set(["dxv"])
```

##### Preferred codec to decode dxtory

```liquidsoap
settings.decoder.ffmpeg.codecs.dxtory.set(<value>)
```

###### Available codecs to decode dxtory

```liquidsoap
settings.decoder.ffmpeg.codecs.dxtory.available.set(["dxtory"])
```

##### Preferred codec to decode dxa

```liquidsoap
settings.decoder.ffmpeg.codecs.dxa.set(<value>)
```

###### Available codecs to decode dxa

```liquidsoap
settings.decoder.ffmpeg.codecs.dxa.available.set(["dxa"])
```

##### Preferred codec to decode dts

```liquidsoap
settings.decoder.ffmpeg.codecs.dts.set(<value>)
```

###### Available codecs to decode dts

```liquidsoap
settings.decoder.ffmpeg.codecs.dts.available.set(["dca"])
```

##### Preferred codec to decode dst

```liquidsoap
settings.decoder.ffmpeg.codecs.dst.set(<value>)
```

###### Available codecs to decode dst

```liquidsoap
settings.decoder.ffmpeg.codecs.dst.available.set(["dst"])
```

##### Preferred codec to decode dss_sp

```liquidsoap
settings.decoder.ffmpeg.codecs.dss_sp.set(<value>)
```

###### Available codecs to decode dss_sp

```liquidsoap
settings.decoder.ffmpeg.codecs.dss_sp.available.set(["dss_sp"])
```

##### Preferred codec to decode dsicinvideo

```liquidsoap
settings.decoder.ffmpeg.codecs.dsicinvideo.set(<value>)
```

###### Available codecs to decode dsicinvideo

```liquidsoap
settings.decoder.ffmpeg.codecs.dsicinvideo.available.set(["dsicinvideo"])
```

##### Preferred codec to decode dsd_msbf_planar

```liquidsoap
settings.decoder.ffmpeg.codecs.dsd_msbf_planar.set(<value>)
```

###### Available codecs to decode dsd_msbf_planar

```liquidsoap
settings.decoder.ffmpeg.codecs.dsd_msbf_planar.available.set(["dsd_msbf_planar"])
```

##### Preferred codec to decode dsd_lsbf_planar

```liquidsoap
settings.decoder.ffmpeg.codecs.dsd_lsbf_planar.set(<value>)
```

###### Available codecs to decode dsd_lsbf_planar

```liquidsoap
settings.decoder.ffmpeg.codecs.dsd_lsbf_planar.available.set(["dsd_lsbf_planar"])
```

##### Preferred codec to decode dpx

```liquidsoap
settings.decoder.ffmpeg.codecs.dpx.set(<value>)
```

###### Available codecs to decode dpx

```liquidsoap
settings.decoder.ffmpeg.codecs.dpx.available.set(["dpx"])
```

##### Preferred codec to decode dfa

```liquidsoap
settings.decoder.ffmpeg.codecs.dfa.set(<value>)
```

###### Available codecs to decode dfa

```liquidsoap
settings.decoder.ffmpeg.codecs.dfa.available.set(["dfa"])
```

##### Preferred codec to decode dds

```liquidsoap
settings.decoder.ffmpeg.codecs.dds.set(<value>)
```

###### Available codecs to decode dds

```liquidsoap
settings.decoder.ffmpeg.codecs.dds.available.set(["dds"])
```

##### Preferred codec to decode cyuv

```liquidsoap
settings.decoder.ffmpeg.codecs.cyuv.set(<value>)
```

###### Available codecs to decode cyuv

```liquidsoap
settings.decoder.ffmpeg.codecs.cyuv.available.set(["cyuv"])
```

##### Preferred codec to decode cscd

```liquidsoap
settings.decoder.ffmpeg.codecs.cscd.set(<value>)
```

###### Available codecs to decode cscd

```liquidsoap
settings.decoder.ffmpeg.codecs.cscd.available.set(["camstudio"])
```

##### Preferred codec to decode cri

```liquidsoap
settings.decoder.ffmpeg.codecs.cri.set(<value>)
```

###### Available codecs to decode cri

```liquidsoap
settings.decoder.ffmpeg.codecs.cri.available.set(["cri"])
```

##### Preferred codec to decode cpia

```liquidsoap
settings.decoder.ffmpeg.codecs.cpia.set(<value>)
```

###### Available codecs to decode cpia

```liquidsoap
settings.decoder.ffmpeg.codecs.cpia.available.set(["cpia"])
```

##### Preferred codec to decode cook

```liquidsoap
settings.decoder.ffmpeg.codecs.cook.set(<value>)
```

###### Available codecs to decode cook

```liquidsoap
settings.decoder.ffmpeg.codecs.cook.available.set(["cook"])
```

##### Preferred codec to decode comfortnoise

```liquidsoap
settings.decoder.ffmpeg.codecs.comfortnoise.set(<value>)
```

###### Available codecs to decode comfortnoise

```liquidsoap
settings.decoder.ffmpeg.codecs.comfortnoise.available.set(["comfortnoise"])
```

##### Preferred codec to decode cmv

```liquidsoap
settings.decoder.ffmpeg.codecs.cmv.set(<value>)
```

###### Available codecs to decode cmv

```liquidsoap
settings.decoder.ffmpeg.codecs.cmv.available.set(["eacmv"])
```

##### Preferred codec to decode cllc

```liquidsoap
settings.decoder.ffmpeg.codecs.cllc.set(<value>)
```

###### Available codecs to decode cllc

```liquidsoap
settings.decoder.ffmpeg.codecs.cllc.available.set(["cllc"])
```

##### Preferred codec to decode cljr

```liquidsoap
settings.decoder.ffmpeg.codecs.cljr.set(<value>)
```

###### Available codecs to decode cljr

```liquidsoap
settings.decoder.ffmpeg.codecs.cljr.available.set(["cljr"])
```

##### Preferred codec to decode cfhd

```liquidsoap
settings.decoder.ffmpeg.codecs.cfhd.set(<value>)
```

###### Available codecs to decode cfhd

```liquidsoap
settings.decoder.ffmpeg.codecs.cfhd.available.set(["cfhd"])
```

##### Preferred codec to decode cdxl

```liquidsoap
settings.decoder.ffmpeg.codecs.cdxl.set(<value>)
```

###### Available codecs to decode cdxl

```liquidsoap
settings.decoder.ffmpeg.codecs.cdxl.available.set(["cdxl"])
```

##### Preferred codec to decode cavs

```liquidsoap
settings.decoder.ffmpeg.codecs.cavs.set(<value>)
```

###### Available codecs to decode cavs

```liquidsoap
settings.decoder.ffmpeg.codecs.cavs.available.set(["cavs"])
```

##### Preferred codec to decode c93

```liquidsoap
settings.decoder.ffmpeg.codecs.c93.set(<value>)
```

###### Available codecs to decode c93

```liquidsoap
settings.decoder.ffmpeg.codecs.c93.available.set(["c93"])
```

##### Preferred codec to decode brender_pix

```liquidsoap
settings.decoder.ffmpeg.codecs.brender_pix.set(<value>)
```

###### Available codecs to decode brender_pix

```liquidsoap
settings.decoder.ffmpeg.codecs.brender_pix.available.set(["brender_pix"])
```

##### Preferred codec to decode bmv_video

```liquidsoap
settings.decoder.ffmpeg.codecs.bmv_video.set(<value>)
```

###### Available codecs to decode bmv_video

```liquidsoap
settings.decoder.ffmpeg.codecs.bmv_video.available.set(["bmv_video"])
```

##### Preferred codec to decode bmv_audio

```liquidsoap
settings.decoder.ffmpeg.codecs.bmv_audio.set(<value>)
```

###### Available codecs to decode bmv_audio

```liquidsoap
settings.decoder.ffmpeg.codecs.bmv_audio.available.set(["bmv_audio"])
```

##### Preferred codec to decode bmp

```liquidsoap
settings.decoder.ffmpeg.codecs.bmp.set(<value>)
```

###### Available codecs to decode bmp

```liquidsoap
settings.decoder.ffmpeg.codecs.bmp.available.set(["bmp"])
```

##### Preferred codec to decode bitpacked

```liquidsoap
settings.decoder.ffmpeg.codecs.bitpacked.set(<value>)
```

###### Available codecs to decode bitpacked

```liquidsoap
settings.decoder.ffmpeg.codecs.bitpacked.available.set(["bitpacked"])
```

##### Preferred codec to decode binkvideo

```liquidsoap
settings.decoder.ffmpeg.codecs.binkvideo.set(<value>)
```

###### Available codecs to decode binkvideo

```liquidsoap
settings.decoder.ffmpeg.codecs.binkvideo.available.set(["binkvideo"])
```

##### Preferred codec to decode binkaudio_dct

```liquidsoap
settings.decoder.ffmpeg.codecs.binkaudio_dct.set(<value>)
```

###### Available codecs to decode binkaudio_dct

```liquidsoap
settings.decoder.ffmpeg.codecs.binkaudio_dct.available.set(["binkaudio_dct"])
```

##### Preferred codec to decode bfi

```liquidsoap
settings.decoder.ffmpeg.codecs.bfi.set(<value>)
```

###### Available codecs to decode bfi

```liquidsoap
settings.decoder.ffmpeg.codecs.bfi.available.set(["bfi"])
```

##### Preferred codec to decode bethsoftvid

```liquidsoap
settings.decoder.ffmpeg.codecs.bethsoftvid.set(<value>)
```

###### Available codecs to decode bethsoftvid

```liquidsoap
settings.decoder.ffmpeg.codecs.bethsoftvid.available.set(["bethsoftvid"])
```

##### Preferred codec to decode ayuv

```liquidsoap
settings.decoder.ffmpeg.codecs.ayuv.set(<value>)
```

###### Available codecs to decode ayuv

```liquidsoap
settings.decoder.ffmpeg.codecs.ayuv.available.set(["ayuv"])
```

##### Preferred codec to decode avui

```liquidsoap
settings.decoder.ffmpeg.codecs.avui.set(<value>)
```

###### Available codecs to decode avui

```liquidsoap
settings.decoder.ffmpeg.codecs.avui.available.set(["avui"])
```

##### Preferred codec to decode avs

```liquidsoap
settings.decoder.ffmpeg.codecs.avs.set(<value>)
```

###### Available codecs to decode avs

```liquidsoap
settings.decoder.ffmpeg.codecs.avs.available.set(["avs"])
```

##### Preferred codec to decode avrp

```liquidsoap
settings.decoder.ffmpeg.codecs.avrp.set(<value>)
```

###### Available codecs to decode avrp

```liquidsoap
settings.decoder.ffmpeg.codecs.avrp.available.set(["avrp"])
```

##### Preferred codec to decode avrn

```liquidsoap
settings.decoder.ffmpeg.codecs.avrn.set(<value>)
```

###### Available codecs to decode avrn

```liquidsoap
settings.decoder.ffmpeg.codecs.avrn.available.set(["avrn"])
```

##### Preferred codec to decode avc

```liquidsoap
settings.decoder.ffmpeg.codecs.avc.set(<value>)
```

###### Available codecs to decode avc

```liquidsoap
settings.decoder.ffmpeg.codecs.avc.available.set(["on2avc"])
```

##### Preferred codec to decode av1

```liquidsoap
settings.decoder.ffmpeg.codecs.av1.set(<value>)
```

###### Available codecs to decode av1

```liquidsoap
settings.decoder.ffmpeg.codecs.av1.available.set(["libdav1d", "libaom-av1", "av1", "av1_cuvid", "av1_qsv"])
```

##### Preferred codec to decode aura2

```liquidsoap
settings.decoder.ffmpeg.codecs.aura2.set(<value>)
```

###### Available codecs to decode aura2

```liquidsoap
settings.decoder.ffmpeg.codecs.aura2.available.set(["aura2"])
```

##### Preferred codec to decode aura

```liquidsoap
settings.decoder.ffmpeg.codecs.aura.set(<value>)
```

###### Available codecs to decode aura

```liquidsoap
settings.decoder.ffmpeg.codecs.aura.available.set(["aura"])
```

##### Preferred codec to decode atrac9

```liquidsoap
settings.decoder.ffmpeg.codecs.atrac9.set(<value>)
```

###### Available codecs to decode atrac9

```liquidsoap
settings.decoder.ffmpeg.codecs.atrac9.available.set(["atrac9"])
```

##### Preferred codec to decode atrac3al

```liquidsoap
settings.decoder.ffmpeg.codecs.atrac3al.set(<value>)
```

###### Available codecs to decode atrac3al

```liquidsoap
settings.decoder.ffmpeg.codecs.atrac3al.available.set(["atrac3al"])
```

##### Preferred codec to decode atrac3

```liquidsoap
settings.decoder.ffmpeg.codecs.atrac3.set(<value>)
```

###### Available codecs to decode atrac3

```liquidsoap
settings.decoder.ffmpeg.codecs.atrac3.available.set(["atrac3"])
```

##### Preferred codec to decode atrac1

```liquidsoap
settings.decoder.ffmpeg.codecs.atrac1.set(<value>)
```

###### Available codecs to decode atrac1

```liquidsoap
settings.decoder.ffmpeg.codecs.atrac1.available.set(["atrac1"])
```

##### Preferred codec to decode asv2

```liquidsoap
settings.decoder.ffmpeg.codecs.asv2.set(<value>)
```

###### Available codecs to decode asv2

```liquidsoap
settings.decoder.ffmpeg.codecs.asv2.available.set(["asv2"])
```

##### Preferred codec to decode asv1

```liquidsoap
settings.decoder.ffmpeg.codecs.asv1.set(<value>)
```

###### Available codecs to decode asv1

```liquidsoap
settings.decoder.ffmpeg.codecs.asv1.available.set(["asv1"])
```

##### Preferred codec to decode argo

```liquidsoap
settings.decoder.ffmpeg.codecs.argo.set(<value>)
```

###### Available codecs to decode argo

```liquidsoap
settings.decoder.ffmpeg.codecs.argo.available.set(["argo"])
```

##### Preferred codec to decode arbc

```liquidsoap
settings.decoder.ffmpeg.codecs.arbc.set(<value>)
```

###### Available codecs to decode arbc

```liquidsoap
settings.decoder.ffmpeg.codecs.arbc.available.set(["arbc"])
```

##### Preferred codec to decode aptx

```liquidsoap
settings.decoder.ffmpeg.codecs.aptx.set(<value>)
```

###### Available codecs to decode aptx

```liquidsoap
settings.decoder.ffmpeg.codecs.aptx.available.set(["aptx"])
```

##### Preferred codec to decode apng

```liquidsoap
settings.decoder.ffmpeg.codecs.apng.set(<value>)
```

###### Available codecs to decode apng

```liquidsoap
settings.decoder.ffmpeg.codecs.apng.available.set(["apng"])
```

##### Preferred codec to decode ape

```liquidsoap
settings.decoder.ffmpeg.codecs.ape.set(<value>)
```

###### Available codecs to decode ape

```liquidsoap
settings.decoder.ffmpeg.codecs.ape.available.set(["ape"])
```

##### Preferred codec to decode ansi

```liquidsoap
settings.decoder.ffmpeg.codecs.ansi.set(<value>)
```

###### Available codecs to decode ansi

```liquidsoap
settings.decoder.ffmpeg.codecs.ansi.available.set(["ansi"])
```

##### Preferred codec to decode anm

```liquidsoap
settings.decoder.ffmpeg.codecs.anm.set(<value>)
```

###### Available codecs to decode anm

```liquidsoap
settings.decoder.ffmpeg.codecs.anm.available.set(["anm"])
```

##### Preferred codec to decode amv

```liquidsoap
settings.decoder.ffmpeg.codecs.amv.set(<value>)
```

###### Available codecs to decode amv

```liquidsoap
settings.decoder.ffmpeg.codecs.amv.available.set(["amv"])
```

##### Preferred codec to decode amr_wb

```liquidsoap
settings.decoder.ffmpeg.codecs.amr_wb.set(<value>)
```

###### Available codecs to decode amr_wb

```liquidsoap
settings.decoder.ffmpeg.codecs.amr_wb.available.set(["amrwb"])
```

##### Preferred codec to decode amr_nb

```liquidsoap
settings.decoder.ffmpeg.codecs.amr_nb.set(<value>)
```

###### Available codecs to decode amr_nb

```liquidsoap
settings.decoder.ffmpeg.codecs.amr_nb.available.set(["amrnb"])
```

##### Preferred codec to decode alac

```liquidsoap
settings.decoder.ffmpeg.codecs.alac.set(<value>)
```

###### Available codecs to decode alac

```liquidsoap
settings.decoder.ffmpeg.codecs.alac.available.set(["alac"])
```

##### Preferred codec to decode aic

```liquidsoap
settings.decoder.ffmpeg.codecs.aic.set(<value>)
```

###### Available codecs to decode aic

```liquidsoap
settings.decoder.ffmpeg.codecs.aic.available.set(["aic"])
```

##### Preferred codec to decode agm

```liquidsoap
settings.decoder.ffmpeg.codecs.agm.set(<value>)
```

###### Available codecs to decode agm

```liquidsoap
settings.decoder.ffmpeg.codecs.agm.available.set(["agm"])
```

##### Preferred codec to decode adpcm_yamaha

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_yamaha.set(<value>)
```

###### Available codecs to decode adpcm_yamaha

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_yamaha.available.set(["adpcm_yamaha"])
```

##### Preferred codec to decode adpcm_thp_le

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_thp_le.set(<value>)
```

###### Available codecs to decode adpcm_thp_le

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_thp_le.available.set(["adpcm_thp_le"])
```

##### Preferred codec to decode adpcm_thp

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_thp.set(<value>)
```

###### Available codecs to decode adpcm_thp

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_thp.available.set(["adpcm_thp"])
```

##### Preferred codec to decode adpcm_swf

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_swf.set(<value>)
```

###### Available codecs to decode adpcm_swf

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_swf.available.set(["adpcm_swf"])
```

##### Preferred codec to decode adpcm_psx

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_psx.set(<value>)
```

###### Available codecs to decode adpcm_psx

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_psx.available.set(["adpcm_psx"])
```

##### Preferred codec to decode adpcm_ima_ws

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ima_ws.set(<value>)
```

###### Available codecs to decode adpcm_ima_ws

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ima_ws.available.set(["adpcm_ima_ws"])
```

##### Preferred codec to decode adpcm_ima_smjpeg

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ima_smjpeg.set(<value>)
```

###### Available codecs to decode adpcm_ima_smjpeg

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ima_smjpeg.available.set(["adpcm_ima_smjpeg"])
```

##### Preferred codec to decode adpcm_ima_qt

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ima_qt.set(<value>)
```

###### Available codecs to decode adpcm_ima_qt

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ima_qt.available.set(["adpcm_ima_qt"])
```

##### Preferred codec to decode adpcm_ima_ea_sead

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ima_ea_sead.set(<value>)
```

###### Available codecs to decode adpcm_ima_ea_sead

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ima_ea_sead.available.set(["adpcm_ima_ea_sead"])
```

##### Preferred codec to decode adpcm_ima_ea_eacs

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ima_ea_eacs.set(<value>)
```

###### Available codecs to decode adpcm_ima_ea_eacs

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ima_ea_eacs.available.set(["adpcm_ima_ea_eacs"])
```

##### Preferred codec to decode adpcm_g726le

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_g726le.set(<value>)
```

###### Available codecs to decode adpcm_g726le

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_g726le.available.set(["g726le"])
```

##### Preferred codec to decode adpcm_ea_xas

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ea_xas.set(<value>)
```

###### Available codecs to decode adpcm_ea_xas

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_ea_xas.available.set(["adpcm_ea_xas"])
```

##### Preferred codec to decode adpcm_dtk

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_dtk.set(<value>)
```

###### Available codecs to decode adpcm_dtk

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_dtk.available.set(["adpcm_dtk"])
```

##### Preferred codec to decode adpcm_agm

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_agm.set(<value>)
```

###### Available codecs to decode adpcm_agm

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_agm.available.set(["adpcm_agm"])
```

##### Preferred codec to decode adpcm_afc

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_afc.set(<value>)
```

###### Available codecs to decode adpcm_afc

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_afc.available.set(["adpcm_afc"])
```

##### Preferred codec to decode adpcm_adx

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_adx.set(<value>)
```

###### Available codecs to decode adpcm_adx

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_adx.available.set(["adpcm_adx"])
```

##### Preferred codec to decode adpcm_4xm

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_4xm.set(<value>)
```

###### Available codecs to decode adpcm_4xm

```liquidsoap
settings.decoder.ffmpeg.codecs.adpcm_4xm.available.set(["adpcm_4xm"])
```

##### Preferred codec to decode acelp.kelvin

```liquidsoap
settings.decoder.ffmpeg.codecs.acelpkelvin.set(<value>)
```

###### Available codecs to decode acelp.kelvin

```liquidsoap
settings.decoder.ffmpeg.codecs.acelpkelvin.available.set(["acelp.kelvin"])
```

##### Preferred codec to decode ac3

```liquidsoap
settings.decoder.ffmpeg.codecs.ac3.set(<value>)
```

###### Available codecs to decode ac3

```liquidsoap
settings.decoder.ffmpeg.codecs.ac3.available.set(["ac3", "ac3_fixed"])
```

##### Preferred codec to decode aasc

```liquidsoap
settings.decoder.ffmpeg.codecs.aasc.set(<value>)
```

###### Available codecs to decode aasc

```liquidsoap
settings.decoder.ffmpeg.codecs.aasc.available.set(["aasc"])
```

##### Preferred codec to decode aac

```liquidsoap
settings.decoder.ffmpeg.codecs.aac.set(<value>)
```

###### Available codecs to decode aac

```liquidsoap
settings.decoder.ffmpeg.codecs.aac.available.set(["aac", "aac_fixed"])
```

##### Preferred codec to decode 4xm

```liquidsoap
settings.decoder.ffmpeg.codecs._4xm.set(<value>)
```

###### Available codecs to decode 4xm

```liquidsoap
settings.decoder.ffmpeg.codecs._4xm.available.set(["4xm"])
```

### Media decoders.

```liquidsoap
settings.decoder.decoders.set(["WAV", "AIFF", "PCM/BASIC", "MIDI", "IMAGE", "RAW AUDIO", "SRT", "FFMPEG", "FLAC", "AAC", "MP4", "OGG", "MAD"])
```

### Maximum debugging information (dev only)

WARNING: Do not enable unless a developer instructed you to do so!The debugging mode makes it easier to understand why decoding fails,but as a side effect it will crash liquidsoap at the end of everytrack.

```liquidsoap
settings.decoder.debug.set(false)
```

### External decoders settings

#### Settings for the FFprobe external decoder

##### Path to ffprobe binary

```liquidsoap
settings.decoder.external.ffprobe.path.set("ffprobe")
```

#### Settings for the FFmpeg external decoder

##### Path to ffmpeg binary

```liquidsoap
settings.decoder.external.ffmpeg.path.set("ffmpeg")
```

##### Mime types supported by the external ffmpeg stream decoder

```liquidsoap
settings.decoder.external.ffmpeg.mime_types.set([])
```

#### Settings for the mpcdec external decoder

##### Path to mpcdec binary

```liquidsoap
settings.decoder.external.mpcdec.path.set("mpcdec")
```

#### Settings for the flac external decoder

##### Path to flac binary

```liquidsoap
settings.decoder.external.flac.path.set("flac")
```

#### Settings for the metaflac external decoder

##### Path to metaflac binary

```liquidsoap
settings.decoder.external.metaflac.path.set("metaflac")
```

#### Settings for the faad external decoder

##### Path to faad binary

```liquidsoap
settings.decoder.external.faad.path.set("faad")
```

## Video settings

Options related to video.

### Video conversion

Options related to video conversion.

#### Preferred proportional scale.

```liquidsoap
settings.video.converter.proportional_scale.set(true)
```

#### Preferred video converter

```liquidsoap
settings.video.converter.preferred.set("ffmpeg")
```

### `video.text` implementation.

```liquidsoap
settings.video.text.set("camlimages")
```
