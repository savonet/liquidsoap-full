Liquidsoap scripting language reference
=======================================
Categories
----------
The **Source / ...** categories contain all functions that return sources.
The **Input** functions are those which build elementary sources
(playing files, synthesizing sound, etc.).
The **Output** functions are those which take a source and register it
for being streamed to the outside (file, soundcard, audio server, etc.).
The **Visualization** functions are experimental ones that let you 
visualize in real-time some aspects of the audio stream.
The **Sound Processing** functions are those which basically work on the source 
as a continuous audio stream. They would typically be mixers of streams,
audio effects or analysis.
Finally, **Track Processing** functions are basically all 
others, often having a behaviour that depends on or affects the extra 
information that liquidsoap puts in streams: track limits and metadata.

* [Source / Conversions](#Source___Conversions)
* [Source / Input](#Source___Input)
* [Source / Liquidsoap](#Source___Liquidsoap)
* [Source / MIDI Processing](#Source___MIDI_Processing)
* [Source / Output](#Source___Output)
* [Source / Sound Processing](#Source___Sound_Processing)
* [Source / Sound Synthesis](#Source___Sound_Synthesis)
* [Source / Track Processing](#Source___Track_Processing)
* [Source / Video Processing](#Source___Video_Processing)
* [Source / Visualization](#Source___Visualization)
* [Bool](#Bool)
* [Control](#Control)
* [Interaction](#Interaction)
* [Liquidsoap](#Liquidsoap)
* [List](#List)
* [Math](#Math)
* [Pair](#Pair)
* [String](#String)
* [System](#System)

Source / Conversions
--------------------
### audio_to_stereo
```
(?id:string,source(audio=*+1,video=0,midi=0))->
source(audio=2,video=0,midi=0)```

Convert any kind of audio source into a stereo source.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio=*+1,video=0,midi=0)`)

### drop_audio
```
(?id:string,source(audio='#a,video='#b,midi='#c))->
source(audio=0,video='#b,midi='#c)```

Drop all audio channels of a stream.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### drop_midi
```
(?id:string,source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi=0)```

Drop all midi channels of a stream.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### drop_video
```
(?id:string,source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video=0,midi='#c)```

Drop all video channels of a stream.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### id
```
(?id:string,source('a))->source('a)```

Does not do anything, simply forwards its input stream.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source('a)`)

### mean
```
(?id:string,source(audio='#a,video='#b,midi='#c))->
source(audio=1,video='#b,midi='#c)```

Produce mono audio by taking the mean of all audio channels.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### mux_audio
```
(?id:string,audio:source(audio='#a,video=0,midi=0),
 source(audio=0,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Mux an audio stream into an audio-free stream.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `audio` (`source(audio='#a,video=0,midi=0)`)
* `(unlabeled)` (`source(audio=0,video='#b,midi='#c)`)

### mux_mono
```
(?id:string,mono:source(audio=1,video=0,midi=0),
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a+1,video='#b,midi='#c)```

Mux a mono audio stream into another stream.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `mono` (`source(audio=1,video=0,midi=0)`)
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### mux_stereo
```
(?id:string,stereo:source(audio=2,video=0,midi=0),
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a+2,video='#b,midi='#c)```

Mux a stereo audio stream into another stream.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `stereo` (`source(audio=2,video=0,midi=0)`)
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### mux_video
```
(?id:string,video:source(audio=0,video='#a,midi=0),
 source(audio='#b,video=0,midi='#c))->
source(audio='#b,video='#a,midi='#c)```

Add video channnels to a stream.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `video` (`source(audio=0,video='#a,midi=0)`)
* `(unlabeled)` (`source(audio='#b,video=0,midi='#c)`)

### stereo.left
```
(source(audio=2,video=0,midi=0))->
source(audio=1,video=0,midi=0)```

Extract the left channel of a stereo source

* `(unlabeled)` (`source(audio=2,video=0,midi=0)`): Source to extract from

### stereo.right
```
(source(audio=2,video=0,midi=0))->
source(audio=1,video=0,midi=0)```

Extract the right channel of a stereo source

* `(unlabeled)` (`source(audio=2,video=0,midi=0)`): Source to extract from

### swap
```
(?id:string,source(audio=2,video=0,midi=0))->
source(audio=2,video=0,midi=0)```

Swap two channels of a stereo source.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

Source / Input
--------------
### blank
```
(?id:string,?duration:float)->source('a)```

Produce silence and blank images.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (`float` -- defaults to `0.0`): Duration of blank tracks in seconds, default means forever.

### empty
```
(?id:string)->source(audio='a,video='b,midi='c)```

A source that does not produce anything. No silence, no track at all.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.

### fail
```
(?id:string)->source('b)```

Creates a source that fails to produce anything.

* `id` (`string` -- defaults to `""`)

### gstreamer.hls
```
(?id:string,'a)->source(audio=2,video=1,midi=0)```

Play an http live stream.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`'a`): URI of the HLS stream index.

### in
```
(?id:string,?start:bool,?on_start:(()->unit),
 ?on_stop:(()->unit),?fallible:bool)->
source(audio='#a+1,video='#b,midi='#c)```

Create a source from the first available input driver in pulseaudio, portaudio, oss, alsa, blank.

* `id` (`string` -- defaults to `""`)
* `start` (`bool` -- defaults to `true`)
* `on_start` (`()->unit` -- defaults to `{()}`)
* `on_stop` (`()->unit` -- defaults to `{()}`)
* `fallible` (`bool` -- defaults to `false`)

### input.external
```
(?id:string,?buffer:float,?channels:int,?max:float,
 ?restart:bool,?restart_on_error:bool,?samplerate:int,
 string)->source(audio='#a+1,video=0,midi=0)```

Stream data from an external application.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `buffer` (`float` -- defaults to `2.0`): Duration of the pre-buffered data.
* `channels` (`int` -- defaults to `2`): Number of channels.
* `max` (`float` -- defaults to `10.0`): Maximum duration of the buffered data.
* `restart` (`bool` -- defaults to `true`): Restart process when exited.
* `restart_on_error` (`bool` -- defaults to `false`): Restart process when exited with error.
* `samplerate` (`int` -- defaults to `44100`): Samplerate.
* `(unlabeled)` (`string`): Command to execute.

### input.external.avi
```
(?id:string,?buffer:float,?max:float,?restart:bool,
 ?restart_on_error:bool,string)->
source(audio='#a,video='#b,midi=0)```

WARNING: This is only EXPERIMENTAL!

Stream data from an external application.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `buffer` (`float` -- defaults to `1.0`): Duration of the pre-buffered data.
* `max` (`float` -- defaults to `10.0`): Maximum duration of the buffered data.
* `restart` (`bool` -- defaults to `true`): Restart process when exited.
* `restart_on_error` (`bool` -- defaults to `false`): Restart process when exited with error.
* `(unlabeled)` (`string`): Command to execute.

### input.external.rawvideo
```
(?id:string,?buffer:float,?max:float,?restart:bool,
 ?restart_on_error:bool,string)->
source(audio=0,video=1,midi=0)```

WARNING: This is only EXPERIMENTAL!

Stream data from an external application.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `buffer` (`float` -- defaults to `1.0`): Duration of the pre-buffered data.
* `max` (`float` -- defaults to `10.0`): Maximum duration of the buffered data.
* `restart` (`bool` -- defaults to `true`): Restart process when exited.
* `restart_on_error` (`bool` -- defaults to `false`): Restart process when exited with error.
* `(unlabeled)` (`string`): Command to execute.

### input.ffmpeg.video
```
(?id:string,?restart:bool,?restart_on_error:bool,
 ?buffer:float,?max:float,?format:string,string)->
source(audio='#a,video='#b,midi=0)```

No documentation available.

* `id` (`string` -- defaults to `"input.ffmpeg.video"`)
* `restart` (`bool` -- defaults to `true`)
* `restart_on_error` (`bool` -- defaults to `false`)
* `buffer` (`float` -- defaults to `0.2`)
* `max` (`float` -- defaults to `10.0`)
* `format` (`string` -- defaults to `""`)
* `(unlabeled)` (`string`)

### input.gstreamer.audio
```
(?id:string,?max:float,?pipeline:string)->
source(audio='#a+1,video=0,midi=0)```

Stream audio from a GStreamer pipeline.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `max` (`float` -- defaults to `10.0`): Maximum duration of the buffered data.
* `pipeline` (`string` -- defaults to `"audiotestsrc"`): GStreamer pipeline to input from.

### input.gstreamer.audio_video
```
(?id:string,?audio_pipeline:string,?max:float,
 ?pipeline:string,?video_pipeline:string)->
source(audio=2,video=1,midi=0)```

Stream audio+video from a GStreamer pipeline.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `audio_pipeline` (`string` -- defaults to `"audiotestsrc"`): Audio pipeline to input from.
* `max` (`float` -- defaults to `10.0`): Maximum duration of the buffered data.
* `pipeline` (`string` -- defaults to `""`): Main GStreamer pipeline.
* `video_pipeline` (`string` -- defaults to `"videotestsrc"`): Video pipeline to input from.

### input.gstreamer.video
```
(?id:string,?max:float,?pipeline:string)->
source(audio=0,video=1,midi=0)```

Stream video from a GStreamer pipeline.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `max` (`float` -- defaults to `10.0`): Maximum duration of the buffered data.
* `pipeline` (`string` -- defaults to `"videotestsrc"`): GStreamer pipeline to input from.

### input.harbor
```
(?id:string,?auth:((string,string)->bool),?buffer:float,
 ?debug:bool,?dumpfile:string,?icy:bool,
 ?icy_metadata_charset:string,?logfile:string,?max:float,
 ?metadata_charset:string,
 ?on_connect:(([(string*string)])->unit),
 ?on_disconnect:(()->unit),?password:string,?port:int,
 ?replay_metadata:bool,?timeout:float,?user:string,
 string)->source('a)```

Retrieves the given http stream from the harbor.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `auth` (`(string,string)->bool` -- defaults to `fun (_,_) -> false`): Authentication function. `f(login,password)` returns `true` if the user should be granted access for this login. Override any other method if used.
* `buffer` (`float` -- defaults to `2.0`): Duration of the pre-buffered data.
* `debug` (`bool` -- defaults to `false`): Run in debugging mode by not catching some exceptions.
* `dumpfile` (`string` -- defaults to `""`): Dump stream to file, for debugging purpose. Disabled if empty.
* `icy` (`bool` -- defaults to `false`): Enable ICY (shoutcast) protocol.
* `icy_metadata_charset` (`string` -- defaults to `""`): ICY (shoutcast) metadata charset. Guessed if empty. Default for shoutcast is ISO-8859-1. Set to that value if all your clients send metadata using this charset and automatic detection is not working for you.
* `logfile` (`string` -- defaults to `""`): Log buffer status to file, for debugging purpose. Disabled if empty.
* `max` (`float` -- defaults to `10.0`): Maximum duration of the buffered data.
* `metadata_charset` (`string` -- defaults to `""`): Metadata charset for non-ICY (shoutcast) source protocols. Guessed if empty.
* `on_connect` (`([(string*string)])->unit` -- defaults to `fun (_) -> ()`): Function to execute when a source is connected. Its receives the list of headers, of the form: (<label>,<value>). All labels are lowercase.
* `on_disconnect` (`()->unit` -- defaults to `{()}`): Functions to excecute when a source is disconnected
* `password` (`string` -- defaults to `"hackme"`): Source password.
* `port` (`int` -- defaults to `8005`): Port used to connect to the source.
* `replay_metadata` (`bool` -- defaults to `false`): Replay last known metadata when switching back to this source. This helps when source has dropped due to temporary connection issues.
* `timeout` (`float` -- defaults to `30.0`): Timeout for source connectionn.
* `user` (`string` -- defaults to `"source"`): Source user.
* `(unlabeled)` (`string`): Mountpoint to look for.

### input.harbor.ssl
```
(?id:string,?auth:((string,string)->bool),?buffer:float,
 ?debug:bool,?dumpfile:string,?icy:bool,
 ?icy_metadata_charset:string,?logfile:string,?max:float,
 ?metadata_charset:string,
 ?on_connect:(([(string*string)])->unit),
 ?on_disconnect:(()->unit),?password:string,?port:int,
 ?replay_metadata:bool,?timeout:float,?user:string,
 string)->source('a)```

Retrieves the given https stream from the harbor.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `auth` (`(string,string)->bool` -- defaults to `fun (_,_) -> false`): Authentication function. `f(login,password)` returns `true` if the user should be granted access for this login. Override any other method if used.
* `buffer` (`float` -- defaults to `2.0`): Duration of the pre-buffered data.
* `debug` (`bool` -- defaults to `false`): Run in debugging mode by not catching some exceptions.
* `dumpfile` (`string` -- defaults to `""`): Dump stream to file, for debugging purpose. Disabled if empty.
* `icy` (`bool` -- defaults to `false`): Enable ICY (shoutcast) protocol.
* `icy_metadata_charset` (`string` -- defaults to `""`): ICY (shoutcast) metadata charset. Guessed if empty. Default for shoutcast is ISO-8859-1. Set to that value if all your clients send metadata using this charset and automatic detection is not working for you.
* `logfile` (`string` -- defaults to `""`): Log buffer status to file, for debugging purpose. Disabled if empty.
* `max` (`float` -- defaults to `10.0`): Maximum duration of the buffered data.
* `metadata_charset` (`string` -- defaults to `""`): Metadata charset for non-ICY (shoutcast) source protocols. Guessed if empty.
* `on_connect` (`([(string*string)])->unit` -- defaults to `fun (_) -> ()`): Function to execute when a source is connected. Its receives the list of headers, of the form: (<label>,<value>). All labels are lowercase.
* `on_disconnect` (`()->unit` -- defaults to `{()}`): Functions to excecute when a source is disconnected
* `password` (`string` -- defaults to `"hackme"`): Source password.
* `port` (`int` -- defaults to `8005`): Port used to connect to the source.
* `replay_metadata` (`bool` -- defaults to `false`): Replay last known metadata when switching back to this source. This helps when source has dropped due to temporary connection issues.
* `timeout` (`float` -- defaults to `30.0`): Timeout for source connectionn.
* `user` (`string` -- defaults to `"source"`): Source user.
* `(unlabeled)` (`string`): Mountpoint to look for.

### input.http
```
(?id:string,?autostart:bool,?bind_address:string,
 ?buffer:float,?debug:bool,?force_mime:string,
 ?logfile:string,?max:float,?new_track_on_metadata:bool,
 ?on_connect:(([(string*string)])->unit),
 ?on_disconnect:(()->unit),?playlist_mode:string,
 ?poll_delay:float,?timeout:float,?user_agent:string,
 string)->source('a)```

Forwards the given http stream. The relay can be paused/resumed using the start/stop telnet commands.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `autostart` (`bool` -- defaults to `true`): Initially start relaying or not.
* `bind_address` (`string` -- defaults to `""`): Address to bind on the local machine. This option can be useful if your machine is bound to multiple IPs. Empty means no bind address.
* `buffer` (`float` -- defaults to `2.0`): Duration of the pre-buffered data.
* `debug` (`bool` -- defaults to `false`): Run in debugging mode, not catching some exceptions.
* `force_mime` (`string` -- defaults to `""`): Force mime data type. Not used if empty.
* `logfile` (`string` -- defaults to `""`): Log buffer status to file, for debugging purpose. Disabled if empty.
* `max` (`float` -- defaults to `10.0`): Maximum duration of the buffered data.
* `new_track_on_metadata` (`bool` -- defaults to `true`): Treat new metadata as new track.
* `on_connect` (`([(string*string)])->unit` -- defaults to `fun (_) -> ()`): Function to execute when a source is connected. Its receives the list of headers, of the form: (<label>,<value>). All labels are lowercase.
* `on_disconnect` (`()->unit` -- defaults to `{()}`): Function to excecute when a source is disconnected
* `playlist_mode` (`string` -- defaults to `"normal"`): Valid modes are ``normal'', ``random'', ``randomize'' and ``first''. The first ones have the same meaning as for the mode parameter of the playlist operator. The last one discards all entries but the first one.
* `poll_delay` (`float` -- defaults to `2.0`): Polling delay when trying to connect to the stream.
* `timeout` (`float` -- defaults to `30.0`): Timeout for source connectionn.
* `user_agent` (`string` -- defaults to ```
"Liquidsoap/1.3.0+scm (Unix; OCaml 4.04.0)"```
): User agent.
* `(unlabeled)` (`string`): URL of an http stream (default port is 80).

### input.https
```
(?id:string,?autostart:bool,?bind_address:string,
 ?buffer:float,?debug:bool,?force_mime:string,
 ?logfile:string,?max:float,?new_track_on_metadata:bool,
 ?on_connect:(([(string*string)])->unit),
 ?on_disconnect:(()->unit),?playlist_mode:string,
 ?poll_delay:float,?timeout:float,?user_agent:string,
 string)->source('a)```

Forwards the given https stream. The relay can be paused/resumed using the start/stop telnet commands.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `autostart` (`bool` -- defaults to `true`): Initially start relaying or not.
* `bind_address` (`string` -- defaults to `""`): Address to bind on the local machine. This option can be useful if your machine is bound to multiple IPs. Empty means no bind address.
* `buffer` (`float` -- defaults to `2.0`): Duration of the pre-buffered data.
* `debug` (`bool` -- defaults to `false`): Run in debugging mode, not catching some exceptions.
* `force_mime` (`string` -- defaults to `""`): Force mime data type. Not used if empty.
* `logfile` (`string` -- defaults to `""`): Log buffer status to file, for debugging purpose. Disabled if empty.
* `max` (`float` -- defaults to `10.0`): Maximum duration of the buffered data.
* `new_track_on_metadata` (`bool` -- defaults to `true`): Treat new metadata as new track.
* `on_connect` (`([(string*string)])->unit` -- defaults to `fun (_) -> ()`): Function to execute when a source is connected. Its receives the list of headers, of the form: (<label>,<value>). All labels are lowercase.
* `on_disconnect` (`()->unit` -- defaults to `{()}`): Function to excecute when a source is disconnected
* `playlist_mode` (`string` -- defaults to `"normal"`): Valid modes are ``normal'', ``random'', ``randomize'' and ``first''. The first ones have the same meaning as for the mode parameter of the playlist operator. The last one discards all entries but the first one.
* `poll_delay` (`float` -- defaults to `2.0`): Polling delay when trying to connect to the stream.
* `timeout` (`float` -- defaults to `30.0`): Timeout for source connectionn.
* `user_agent` (`string` -- defaults to ```
"Liquidsoap/1.3.0+scm (Unix; OCaml 4.04.0)"```
): User agent.
* `(unlabeled)` (`string`): URL of an https stream (default port is 80).

### input.mencoder.video
```
(?id:string,?restart:bool,?restart_on_error:bool,
 ?buffer:float,?max:float,string)->
source(audio=0,video=1,midi=0)```

No documentation available.

* `id` (`string` -- defaults to `"input.mencoder.video"`)
* `restart` (`bool` -- defaults to `true`)
* `restart_on_error` (`bool` -- defaults to `false`)
* `buffer` (`float` -- defaults to `0.2`)
* `max` (`float` -- defaults to `10.0`)
* `(unlabeled)` (`string`)

### input.mplayer
```
(?id:string,?restart:bool,?restart_on_error:bool,
 ?buffer:float,?max:float,string)->
source(audio='#a+1,video=0,midi=0)```

Stream data from mplayer

* `id` (`string` -- defaults to `"input.mplayer"`)
* `restart` (`bool` -- defaults to `true`): restart on exit.
* `restart_on_error` (`bool` -- defaults to `false`): restart on exit with error.
* `buffer` (`float` -- defaults to `0.2`): Duration of the pre-buffered data.
* `max` (`float` -- defaults to `10.0`): Maximum duration of the buffered data.
* `(unlabeled)` (`string`): data URI.

### input.portaudio
```
(?id:string,?buflen:int,?clock_safe:bool,?fallible:bool,
 ?on_start:(()->unit),?on_stop:(()->unit),?start:bool)->
source(audio='#a+1,video='#b,midi='#c)```

Stream from a portaudio input device.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `buflen` (`int` -- defaults to `256`): Length of a buffer in samples.
* `clock_safe` (`bool` -- defaults to `true`): Force the use of the dedicated Portaudio clock.
* `fallible` (`bool` -- defaults to `false`): Allow the input to stop. When false, the source will be infallible but the stop command won't have any effect.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when input starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when input stops.
* `start` (`bool` -- defaults to `true`): Start input as soon as it is created. Disabling it is only taken into account for a fallible input.

### input.udp
```
(?id:string,?buffer:float,host:string,port:int,string)->
active_source('a)```

WARNING: This is only EXPERIMENTAL!

Input encoded data from UDP, without any control whatsoever.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `buffer` (`float` -- defaults to `1.0`): Duration of buffered data before starting playout.
* `host` (`string`)
* `port` (`int`)
* `(unlabeled)` (`string`): Mime type.

### input.v4l2
```
(?id:string,?device:string)->
source(audio=0,video=1,midi=0)```

Stream from a video4linux 2 input device, such as a webcam.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `device` (`string` -- defaults to `"/dev/video0"`): V4L2 device to use.

### input.v4l2_with_audio
```
(?id:string,?device:string)->
source(audio=2,video=1,midi=0)```

Stream from a video4linux 2 input device, such as a webcam.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `device` (`string` -- defaults to `"/dev/video0"`): V4L2 device to use.

### noise
```
(?id:string,?duration:float)->
source(audio='a,video='b,midi=0)```

Generate (audio and/or video) white noise.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (`float` -- defaults to `0.0`)

### playlist
```
(?id:string,?check_next:((request('a))->bool),
 ?conservative:bool,?default_duration:float,
 ?length:float,?mime_type:string,?mode:string,
 ?prefix:string,?reload:int,?reload_mode:string,
 ?timeout:float,string)->source('a)```

Loop on a playlist of URIs.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `check_next` (`(request('a))->bool` -- defaults to <code><fun></code>): Function used to filter next tracks. A candidate track is only validated if the function returns true on it. The function is called before resolution, hence metadata will only be available for requests corresponding to local files. This is typically used to avoid repetitions, but be careful: if the function rejects all attempts, the playlist will enter into a consuming loop and stop playing anything.
* `conservative` (`bool` -- defaults to `false`): If true, estimated remaining time on the current track is not considered when computing queue length.
* `default_duration` (`float` -- defaults to `30.0`): When unknown, assume this duration (in sec.) for files.
* `length` (`float` -- defaults to `10.0`): How much audio (in sec.) should be queued in advance.
* `mime_type` (`string` -- defaults to `""`): Default MIME type for the playlist. Empty string means automatic detection.
* `mode` (`string` -- defaults to `"randomize"`): Play the files in the playlist either in the order (``normal'' mode), or shuffle the playlist each time it is loaded, and play it in this order for a whole round (``randomize'' mode), or pick a random file in the playlist each time (``random'' mode).
* `prefix` (`string` -- defaults to `""`): Add a constant prefix to all requests. Useful for passing extra information using annotate, or for resolution through a particular protocol, such as replaygain.
* `reload` (`int` -- defaults to `0`): Amount of time (in seconds or rounds), when applicable, before which the playlist is reloaded; 0 means never.
* `reload_mode` (`string` -- defaults to `"seconds"`): Unit of the reload parameter, either 'rounds', 'seconds' or 'watch' (reload the file whenever it is changed).
* `timeout` (`float` -- defaults to `20.0`): Timeout (in sec.) for a single download.
* `(unlabeled)` (`string`): URI where to find the playlist.

### playlist.once
```
(?id:string,?random:bool,?on_done:(()->unit),
 ?reload_mode:string,string)->source('a)```

Custom playlist source written using the script language. It will read directory or playlist, play all files and stop.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `random` (`bool` -- defaults to `false`): Randomize playlist content
* `on_done` (`()->unit` -- defaults to `{()}`): Function to execute when the playlist is finished
* `reload_mode` (`string` -- defaults to `""`): If set to ``watch'', will be reloaded when the playlist is changed
* `(unlabeled)` (`string`): Playlist URI

### playlist.reloadable
```
(?id:string,?random:bool,?on_done:(()->unit),
 ?filter:(([(string*string)])->bool),string)->
(((?uri:string)->unit)*source('a))```

Custom playlist source written using the script language. Will read directory or playlist, play all files and stop. Returns a pair `(reload,source)` where `reload` is a function of type `(?uri:string)->unit` used to reload the source and `source` is the actual source. The reload function can optionally be called with a new playlist URI. Otherwise, it reloads the previous URI.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `random` (`bool` -- defaults to `false`): Randomize playlist content
* `on_done` (`()->unit` -- defaults to `{()}`): Function to execute when the playlist is finished
* `filter` (`([(string*string)])->bool` -- defaults to `fun (_) -> true`): Filter out some files depending on metadata
* `(unlabeled)` (`string`): Playlist URI

### playlist.safe
```
(?id:string,?mime_type:string,?mode:string,
 ?prefix:string,?reload:int,?reload_mode:string,string)->
source('a)```

Loop on a playlist of local files, and never fail. In order to do so, it has to check every file at the loading, so the streamer startup may take a few seconds. To avoid this, use a standard playlist, and put only a few local files in a default safe_playlist in order to ensure the liveness of the streamer.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `mime_type` (`string` -- defaults to `""`): Default MIME type for the playlist. Empty string means automatic detection.
* `mode` (`string` -- defaults to `"randomize"`): Play the files in the playlist either in the order (``normal'' mode), or shuffle the playlist each time it is loaded, and play it in this order for a whole round (``randomize'' mode), or pick a random file in the playlist each time (``random'' mode).
* `prefix` (`string` -- defaults to `""`): Add a constant prefix to all requests. Useful for passing extra information using annotate, or for resolution through a particular protocol, such as replaygain.
* `reload` (`int` -- defaults to `0`): Amount of time (in seconds or rounds), when applicable, before which the playlist is reloaded; 0 means never.
* `reload_mode` (`string` -- defaults to `"seconds"`): Unit of the reload parameter, either 'rounds', 'seconds' or 'watch' (reload the file whenever it is changed).
* `(unlabeled)` (`string`): URI where to find the playlist.

### request.dynamic
```
(?id:string,?conservative:bool,?default_duration:float,
 ?length:float,?timeout:float,(()->request('a)))->
source('a)```

Play request dynamically created by a given function.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `conservative` (`bool` -- defaults to `false`): If true, estimated remaining time on the current track is not considered when computing queue length.
* `default_duration` (`float` -- defaults to `30.0`): When unknown, assume this duration (in sec.) for files.
* `length` (`float` -- defaults to `10.0`): How much audio (in sec.) should be queued in advance.
* `timeout` (`float` -- defaults to `20.0`): Timeout (in sec.) for a single download.
* `(unlabeled)` (`()->request('a)`)

### request.equeue
```
(?id:string,?conservative:bool,?default_duration:float,
 ?length:float,?timeout:float)->source('a)```

Receive URIs from users, and play them. Insertion and deletion possible at any position.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `conservative` (`bool` -- defaults to `false`): If true, estimated remaining time on the current track is not considered when computing queue length.
* `default_duration` (`float` -- defaults to `30.0`): When unknown, assume this duration (in sec.) for files.
* `length` (`float` -- defaults to `10.0`): How much audio (in sec.) should be queued in advance.
* `timeout` (`float` -- defaults to `20.0`): Timeout (in sec.) for a single download.

### request.queue
```
(?id:string,?conservative:bool,?default_duration:float,
 ?interactive:bool,?length:float,?queue:[request('a)],
 ?timeout:float)->source('a)```

Receive URIs from users, and play them.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `conservative` (`bool` -- defaults to `false`): If true, estimated remaining time on the current track is not considered when computing queue length.
* `default_duration` (`float` -- defaults to `30.0`): When unknown, assume this duration (in sec.) for files.
* `interactive` (`bool` -- defaults to `true`): Should the queue be controllable via telnet?
* `length` (`float` -- defaults to `10.0`): How much audio (in sec.) should be queued in advance.
* `queue` (`[request('a)]` -- defaults to `[]`): Initial queue of requests.
* `timeout` (`float` -- defaults to `20.0`): Timeout (in sec.) for a single download.

### saw
```
(?id:string,?amplitude:float,?duration:float,?float)->
source(audio='#a+1,video=0,midi=0)```

Generate a saw wave.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `amplitude` (`float` -- defaults to `1.0`): Maximal value of the waveform.
* `duration` (`float` -- defaults to `0.0`): Duration in seconds (0. means infinite).
* `(unlabeled)` (`float` -- defaults to `440.0`): Frequency of the saw.

### sine
```
(?id:string,?amplitude:float,?duration:float,?float)->
source(audio='#a+1,video=0,midi=0)```

Generate a sine wave.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `amplitude` (`float` -- defaults to `1.0`): Maximal value of the waveform.
* `duration` (`float` -- defaults to `0.0`): Duration in seconds (0. means infinite).
* `(unlabeled)` (`float` -- defaults to `440.0`): Frequency of the sine.

### single
```
(?id:string,?conservative:bool,?default_duration:float,
 ?length:float,?timeout:float,string)->source('a)```

Loop on a request. It never fails if the request is static, meaning that it can be fetched once. Typically, http, ftp, say requests are static, and time is not.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `conservative` (`bool` -- defaults to `false`): If true, estimated remaining time on the current track is not considered when computing queue length.
* `default_duration` (`float` -- defaults to `30.0`): When unknown, assume this duration (in sec.) for files.
* `length` (`float` -- defaults to `10.0`): How much audio (in sec.) should be queued in advance.
* `timeout` (`float` -- defaults to `20.0`): Timeout (in sec.) for a single download.
* `(unlabeled)` (`string`): URI where to find the file

### square
```
(?id:string,?amplitude:float,?duration:float,?float)->
source(audio='#a+1,video=0,midi=0)```

Generate a square wave.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `amplitude` (`float` -- defaults to `1.0`): Maximal value of the waveform.
* `duration` (`float` -- defaults to `0.0`): Duration in seconds (0. means infinite).
* `(unlabeled)` (`float` -- defaults to `440.0`): Frequency of the square.

Source / Liquidsoap
-------------------
### buffer
```
(?id:string,?buffer:float,?fallible:bool,?max:float,
 ?on_start:(()->unit),?on_stop:(()->unit),?start:bool,
 source('a))->source('a)```

Create a buffer between two different clocks.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `buffer` (`float` -- defaults to `1.0`): Amount of data to pre-buffer, in seconds.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `max` (`float` -- defaults to `10.0`): Maximum amount of buffered data, in seconds.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source('a)`)

### buffer.adaptative
```
(?id:string,?averaging:float,?buffer:float,
 ?fallible:bool,?limit:float,?max:float,
 ?on_start:(()->unit),?on_stop:(()->unit),?reset:bool,
 ?start:bool,source(audio='#a+1,video=0,midi=0))->
source(audio='#a+1,video=0,midi=0)```

WARNING: This is only EXPERIMENTAL!

Create a buffer between two different clocks. The speed of the output is adapted so that no buffer underrun or overrun occurs. This wonderful behavior has a cost: the pitch of the sound might be changed a little.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `averaging` (`float` -- defaults to `30.0`): Half-life for the averaging of the buffer size, in seconds.
* `buffer` (`float` -- defaults to `1.0`): Amount of data to pre-buffer, in seconds.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `limit` (`float` -- defaults to `1.25`): Maximum acceleration or deceleration factor.
* `max` (`float` -- defaults to `10.0`): Maximum amount of buffered data, in seconds.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `reset` (`bool` -- defaults to `false`): Reset speed estimation to 1. when the source becomes available again.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source(audio='#a+1,video=0,midi=0)`)

Source / MIDI Processing
------------------------
### midi.chord
```
(?id:string,?metadata:string,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c+1)```

Generate a chord.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `metadata` (`string` -- defaults to `"chord"`): Name of the metadata containing the chords.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### midi.merge_all
```
(?id:string,?track_out:int,
 source(audio='#a,video='#b,midi='#c+1))->
source(audio='#a,video='#b,midi='#c+1)```

Merge all MIDI tracks in one.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `track_out` (`int` -- defaults to `0`): Destination track.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c+1)`)

### midi.remove
```
(?id:string,[int],source(audio='#a,video='#b,midi='#c+1))->
source(audio='#a,video='#b,midi='#c+1)```

Remove MIDI tracks.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`[int]`): Tracks to remove.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c+1)`)

Source / Output
---------------
### gstreamer.encode_jpeg_avi
```
('a,source(audio='#b,video='#c+1,midi='#d))->
active_source(audio='#b,video='#c+1,midi='#d)```

Encode jpeg video file using gstreamer

* `(unlabeled)` (`'a`): Encoded file name
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`): Source

### gstreamer.encode_mp3
```
('a,source(audio='#b+1,video='#c,midi='#d))->
active_source(audio='#b+1,video='#c,midi='#d)```

Encode a mp3 file using gstreamer

* `(unlabeled)` (`'a`): Encoded file name
* `(unlabeled)` (`source(audio='#b+1,video='#c,midi='#d)`): Source

### gstreamer.encode_x264_avi
```
('a,source(audio='#b,video='#c+1,midi='#d))->
active_source(audio='#b,video='#c+1,midi='#d)```

Encode an x264 video file using gstreamer

* `(unlabeled)` (`'a`): Encoded file name
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`): Source

### gstreamer.rtp.mpeg4
```
(?host:string,?port:int,
 source(audio='#a,video='#b+1,midi='#c))->
active_source(audio='#a,video='#b+1,midi='#c)```

Broadcast a video in RTP. In order to play it, save the following in xxx.sdp and use vlc xxx.sdp: v=0 m=video 5000 RTP/AVP 96 c=IN IP4 127.0.0.1 a=rtpmap:96 MP4V-ES/90000

* `host` (`string` -- defaults to `"127.0.0.1"`)
* `port` (`int` -- defaults to `5000`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### out
```
(source(audio='#a+1,video='#b,midi='#c))->
active_source(audio='#a+1,video='#b,midi='#c)```

Output a stream using the 'output.prefered' operator. The input source does not need to be infallible, blank will just be played during failures.

* `(unlabeled)` (`source(audio='#a+1,video='#b,midi='#c)`): the source to output

### output.ao
```
(?id:string,?buffer_size:int,?channels_matrix:string,
 ?clock_safe:bool,?driver:string,?fallible:bool,
 ?on_start:(()->unit),?on_stop:(()->unit),
 ?options:[(string*string)],?start:bool,
 source(audio='#a+1,video='#b,midi='#c))->
active_source(audio='#a+1,video='#b,midi='#c)```

Output stream to local sound card using libao.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `buffer_size` (`int` -- defaults to `2`): Set buffer size, in frames.
* `channels_matrix` (`string` -- defaults to `""`): Output channels matrix, ``'' for AO's default.
* `clock_safe` (`bool` -- defaults to `true`): Use the dedicated AO clock.
* `driver` (`string` -- defaults to `""`): Driver to be used, ``'' for AO's default.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `options` (`[(string*string)]` -- defaults to `[]`): List of parameters, depends on the driver.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source(audio='#a+1,video='#b,midi='#c)`)

### output.dummy
```
(?id:string,?fallible:bool,?on_start:(()->unit),
 ?on_stop:(()->unit),?start:bool,source('a))->
active_source('a)```

Dummy output for debugging purposes.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source('a)`)

### output.external
```
(?id:string,?fallible:bool,?flush:bool,
 ?on_start:(()->unit),?on_stop:(()->unit),
 ?reopen_delay:float,?reopen_on_metadata:bool,
 ?reopen_when:(()->bool),?start:bool,format('a),string,
 source('a))->active_source('a)```

Send the stream to a process' standard input.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `flush` (`bool` -- defaults to `false`): Perform a flush after each write.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `reopen_delay` (`float` -- defaults to `120.0`): Prevent re-opening within that delay, in seconds.
* `reopen_on_metadata` (`bool` -- defaults to `false`): Re-open on every new metadata information.
* `reopen_when` (`()->bool` -- defaults to `{false}`): When should the output be re-opened.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`format('a)`): Encoding format.
* `(unlabeled)` (`string`): Process to pipe data to. Some strftime conversion specifiers are available: `%SMHdmY`. You can also use `$(..)` interpolation notation for metadata.
* `(unlabeled)` (`source('a)`)

### output.file
```
(?id:string,?append:bool,?dir_perm:int,?fallible:bool,
 ?flush:bool,?on_close:((string)->unit),
 ?on_start:(()->unit),?on_stop:(()->unit),?perm:int,
 ?reopen_delay:float,?reopen_on_metadata:bool,
 ?reopen_when:(()->bool),?start:bool,format('a),string,
 source('a))->active_source('a)```

Output the source stream to a file.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `append` (`bool` -- defaults to `false`): Do not truncate but append in the file if it exists.
* `dir_perm` (`int` -- defaults to `511`): Permission of the directories if some have to be created, up to umask. Although you can enter values in octal notation (0oXXX) they will be displayed in decimal (for instance, 0o777 = 7*8^2 + 7*8 + 7 = 511).
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `flush` (`bool` -- defaults to `false`): Perform a flush after each write.
* `on_close` (`(string)->unit` -- defaults to `fun (_) -> ()`): This function will be called for each file, after that it is finished and closed. The filename will be passed as argument.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `perm` (`int` -- defaults to `438`): Permission of the file if it has to be created, up to umask. You can and should write this number in octal notation: 0oXXX. The default value is however displayed in decimal (0o666 = 6*8^2 + 6*8 + 6 = 438).
* `reopen_delay` (`float` -- defaults to `120.0`): Prevent re-opening within that delay, in seconds.
* `reopen_on_metadata` (`bool` -- defaults to `false`): Re-open on every new metadata information.
* `reopen_when` (`()->bool` -- defaults to `{false}`): When should the output be re-opened.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`format('a)`): Encoding format.
* `(unlabeled)` (`string`): Filename where to output the stream. Some strftime conversion specifiers are available: `%SMHdmY`. You can also use `$(..)` interpolation notation for metadata.
* `(unlabeled)` (`source('a)`)

### output.gstreamer.audio
```
(?id:string,?clock_safe:bool,?fallible:bool,
 ?on_start:(()->unit),?on_stop:(()->unit),
 ?pipeline:string,?start:bool,
 source(audio='#a+1,video='#b,midi='#c))->
active_source(audio='#a+1,video='#b,midi='#c)```

Output stream to a GStreamer pipeline.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `clock_safe` (`bool` -- defaults to `true`): Use the dedicated GStreamer clock.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `pipeline` (`string` -- defaults to `"autoaudiosink"`): GStreamer pipeline for sink.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source(audio='#a+1,video='#b,midi='#c)`)

### output.gstreamer.audio_video
```
(?id:string,?asynchronous:bool,?audio_pipeline:string,
 ?blocking:bool,?clock_safe:bool,?fallible:bool,
 ?on_start:(()->unit),?on_stop:(()->unit),
 ?pipeline:string,?start:bool,?video_pipeline:string,
 source(audio='#a+1,video='#b+1,midi='#c))->
active_source(audio='#a+1,video='#b+1,midi='#c)```

Output stream to a GStreamer pipeline.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `asynchronous` (`bool` -- defaults to `false`): Use asynchronous implementation (GStreamer is pulling from us).
* `audio_pipeline` (`string` -- defaults to `"autoaudiosink"`): GStreamer pipeline for audio sink.
* `blocking` (`bool` -- defaults to `true`): Pushing buffers is blocking.
* `clock_safe` (`bool` -- defaults to `true`): Use the dedicated GStreamer clock.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `pipeline` (`string` -- defaults to `""`): GStreamer pipeline for sink.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `video_pipeline` (`string` -- defaults to `"videoconvert ! autovideosink"`): GStreamer pipeline for video sink.
* `(unlabeled)` (```
source(audio='#a+1,video='#b+1,midi='#c)```
)

### output.gstreamer.video
```
(?id:string,?clock_safe:bool,?fallible:bool,
 ?on_start:(()->unit),?on_stop:(()->unit),
 ?pipeline:string,?start:bool,
 source(audio='#a,video='#b+1,midi='#c))->
active_source(audio='#a,video='#b+1,midi='#c)```

Output stream to a GStreamer pipeline.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `clock_safe` (`bool` -- defaults to `true`): Use the dedicated GStreamer clock.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `pipeline` (`string` -- defaults to `"videoconvert ! autovideosink"`): GStreamer pipeline for sink.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### output.harbor
```
(?id:string,?auth:((string,string)->bool),?buffer:int,
 ?burst:int,?chunk:int,?dumpfile:string,?encoding:string,
 ?fallible:bool,?format:string,
 ?headers:[(string*string)],?metaint:int,mount:string,
 ?on_connect:((headers:[(string*string)],uri:string,
               protocol:string,string)->unit),
 ?on_disconnect:((string)->unit),?on_start:(()->unit),
 ?on_stop:(()->unit),?password:string,?port:int,
 ?start:bool,?timeout:float,?url:string,?user:string,
 format('a),source('a))->active_source('a)```

Encode and output the stream using the harbor server.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `auth` (`(string,string)->bool` -- defaults to `fun (_,_) -> false`): Authentication function. `f(login,password)` returns `true` if the user should be granted access for this login. Override any other method if used.
* `buffer` (`int` -- defaults to `327675`): Maximun buffer per-client.
* `burst` (`int` -- defaults to `65534`): Initial burst of data sent to the client.
* `chunk` (`int` -- defaults to `1024`): Send data to clients using chunks of at least this length.
* `dumpfile` (`string` -- defaults to `""`): Dump stream to file, for debugging purpose. Disabled if empty.
* `encoding` (`string` -- defaults to `""`): Encoding used to send metadata. If empty, defaults to ``ISO-8859-1'' for non-ogg formats and ``UTF-8'' otherwise.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `format` (`string` -- defaults to `""`): Format, e.g. ``audio/ogg''. When empty, the encoder is used to guess.
* `headers` (`[(string*string)]` -- defaults to `[]`): Additional headers.
* `metaint` (`int` -- defaults to `16000`): Interval used to send ICY metadata
* `mount` (`string`)
* `on_connect` (```
(headers:[(string*string)],uri:string,protocol:string,
 string)->unit```
 -- defaults to `fun (~headers,~uri,~protocol,_) -> ()`): Callback executed when connection is established.
* `on_disconnect` (`(string)->unit` -- defaults to `fun (_) -> ()`): Callback executed when connection stops.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `password` (`string` -- defaults to `"hackme"`)
* `port` (`int` -- defaults to `8000`)
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `timeout` (`float` -- defaults to `30.0`): Timeout for network operations.
* `url` (`string` -- defaults to `""`)
* `user` (`string` -- defaults to `""`): User for client connection, disabled if empty.
* `(unlabeled)` (`format('a)`): Encoding format.
* `(unlabeled)` (`source('a)`)

### output.harbor.ssl
```
(?id:string,?auth:((string,string)->bool),?buffer:int,
 ?burst:int,?chunk:int,?dumpfile:string,?encoding:string,
 ?fallible:bool,?format:string,
 ?headers:[(string*string)],?metaint:int,mount:string,
 ?on_connect:((headers:[(string*string)],uri:string,
               protocol:string,string)->unit),
 ?on_disconnect:((string)->unit),?on_start:(()->unit),
 ?on_stop:(()->unit),?password:string,?port:int,
 ?start:bool,?timeout:float,?url:string,?user:string,
 format('a),source('a))->active_source('a)```

Encode and output the stream using the SSL harbor server.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `auth` (`(string,string)->bool` -- defaults to `fun (_,_) -> false`): Authentication function. `f(login,password)` returns `true` if the user should be granted access for this login. Override any other method if used.
* `buffer` (`int` -- defaults to `327675`): Maximun buffer per-client.
* `burst` (`int` -- defaults to `65534`): Initial burst of data sent to the client.
* `chunk` (`int` -- defaults to `1024`): Send data to clients using chunks of at least this length.
* `dumpfile` (`string` -- defaults to `""`): Dump stream to file, for debugging purpose. Disabled if empty.
* `encoding` (`string` -- defaults to `""`): Encoding used to send metadata. If empty, defaults to ``ISO-8859-1'' for non-ogg formats and ``UTF-8'' otherwise.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `format` (`string` -- defaults to `""`): Format, e.g. ``audio/ogg''. When empty, the encoder is used to guess.
* `headers` (`[(string*string)]` -- defaults to `[]`): Additional headers.
* `metaint` (`int` -- defaults to `16000`): Interval used to send ICY metadata
* `mount` (`string`)
* `on_connect` (```
(headers:[(string*string)],uri:string,protocol:string,
 string)->unit```
 -- defaults to `fun (~headers,~uri,~protocol,_) -> ()`): Callback executed when connection is established.
* `on_disconnect` (`(string)->unit` -- defaults to `fun (_) -> ()`): Callback executed when connection stops.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `password` (`string` -- defaults to `"hackme"`)
* `port` (`int` -- defaults to `8000`)
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `timeout` (`float` -- defaults to `30.0`): Timeout for network operations.
* `url` (`string` -- defaults to `""`)
* `user` (`string` -- defaults to `""`): User for client connection, disabled if empty.
* `(unlabeled)` (`format('a)`): Encoding format.
* `(unlabeled)` (`source('a)`)

### output.icecast
```
(?id:string,?chunked:bool,?connection_timeout:float,
 ?description:string,?dumpfile:string,?encoding:string,
 ?fallible:bool,?format:string,?genre:string,
 ?headers:[(string*string)],?host:string,?icy_id:int,
 ?icy_metadata:string,?mount:string,?name:string,
 ?on_connect:(()->unit),?on_disconnect:(()->unit),
 ?on_error:((string)->float),?on_start:(()->unit),
 ?on_stop:(()->unit),?password:string,?port:int,
 ?protocol:string,?public:bool,?start:bool,
 ?timeout:float,?url:string,?user:string,?verb:string,
 format('a),source('a))->active_source('a)```

Encode and output the stream to an icecast2 or shoutcast server.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `chunked` (`bool` -- defaults to `false`): Used cunked transfer with the 'http(s)' protocol.
* `connection_timeout` (`float` -- defaults to `5.0`): Timeout for establishing network connections (disabled is negative).
* `description` (`string` -- defaults to `""`)
* `dumpfile` (`string` -- defaults to `""`): Dump stream to file, for debugging purpose. Disabled if empty.
* `encoding` (`string` -- defaults to `""`): Encoding used to send metadata. If empty, defaults to ``UTF-8'' for ``http(s)'' protocol and ``ISO-8859-1'' for ``icy'' protocol.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `format` (`string` -- defaults to `""`): Format, e.g. ``audio/ogg''. When empty, the encoder is used to guess.
* `genre` (`string` -- defaults to `""`)
* `headers` (`[(string*string)]` -- defaults to ```
[("User-Agent","Liquidsoap/1.3.0+scm (Unix; OCaml 4.04.0)")]```
): Additional headers.
* `host` (`string` -- defaults to `"localhost"`)
* `icy_id` (`int` -- defaults to `1`): Shoutcast source ID. Only supported by Shoutcast v2.
* `icy_metadata` (`string` -- defaults to `"guess"`): Send new metadata using the ICY protocol. One of: ``guess'', ``true'', ``false''
* `mount` (`string` -- defaults to `"Use [name]"`): Source mount point. Mandatory when streaming to icecast.
* `name` (`string` -- defaults to `"Use [mount]"`)
* `on_connect` (`()->unit` -- defaults to `{()}`): Callback executed when connection is established.
* `on_disconnect` (`()->unit` -- defaults to `{()}`): Callback executed when connection stops.
* `on_error` (`(string)->float` -- defaults to `fun (_) -> 3.`): Callback executed when an error happens. The callback receives a string representation of the error that occured and returns a float. If returned value is positive, connection will be tried again after this amount of time (in seconds).
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `password` (`string` -- defaults to `"hackme"`)
* `port` (`int` -- defaults to `8000`)
* `protocol` (`string` -- defaults to `"http"`): Protocol of the streaming server: 'http' or 'https' for Icecast, 'icy' for shoutcast.
* `public` (`bool` -- defaults to `true`)
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `timeout` (`float` -- defaults to `30.0`): Timeout for network read and write.
* `url` (`string` -- defaults to `""`)
* `user` (`string` -- defaults to `""`): User for shout source connection. Defaults to ``source'' for icecast connections. Useful only in special cases, like with per-mountpoint users.
* `verb` (`string` -- defaults to `"source"`): Verb to use with the 'http(s)' protocol. One of: 'source', 'put' or 'post'.
* `(unlabeled)` (`format('a)`): Encoding format.
* `(unlabeled)` (`source('a)`)

### output.portaudio
```
(?id:string,?buflen:int,?clock_safe:bool,?fallible:bool,
 ?on_start:(()->unit),?on_stop:(()->unit),?start:bool,
 source(audio='#a+1,video='#b,midi='#c))->
active_source(audio='#a+1,video='#b,midi='#c)```

Output the source's stream to a portaudio output device.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `buflen` (`int` -- defaults to `256`): Length of a buffer in samples.
* `clock_safe` (`bool` -- defaults to `true`): Force the use of the dedicated Portaudio clock.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source(audio='#a+1,video='#b,midi='#c)`)

### output.prefered
```
(?id:string,?fallible:bool,?on_start:(()->unit),
 ?on_stop:(()->unit),?start:bool,
 source(audio='#a+1,video='#b,midi='#c))->
active_source(audio='#a+1,video='#b,midi='#c)```

Output to local audio card using the first available driver in pulseaudio, portaudio, oss, alsa, ao, dummy.

* `id` (`string` -- defaults to `""`)
* `fallible` (`bool` -- defaults to `false`)
* `on_start` (`()->unit` -- defaults to `{()}`)
* `on_stop` (`()->unit` -- defaults to `{()}`)
* `start` (`bool` -- defaults to `true`)
* `(unlabeled)` (`source(audio='#a+1,video='#b,midi='#c)`)

### output.shoutcast
```
(?id:string,?start:bool,?host:string,?port:int,
 ?user:string,?password:string,?genre:string,?url:string,
 ?name:string,?public:bool,?icy_id:int,?format:string,
 ?dj:(()->string),?dumpfile:string,?icy_metadata:string,
 ?on_connect:(()->unit),?on_disconnect:(()->unit),
 ?aim:string,?icq:string,?irc:string,?icy_reset:bool,
 ?fallible:bool,?on_start:(()->unit),?on_stop:(()->unit),
 ?on_error:((string)->float),format('a),source('a))->
active_source('a)```

Output to shoutcast.

* `id` (`string` -- defaults to `"output.shoutcast"`): Output's ID
* `start` (`bool` -- defaults to `true`): Start output threads on operator initialization.
* `host` (`string` -- defaults to `"localhost"`)
* `port` (`int` -- defaults to `8000`)
* `user` (`string` -- defaults to `""`): User for shout source connection. Useful only in special cases, like with per-mountpoint users.
* `password` (`string` -- defaults to `"hackme"`)
* `genre` (`string` -- defaults to `""`)
* `url` (`string` -- defaults to `""`)
* `name` (`string` -- defaults to `""`)
* `public` (`bool` -- defaults to `true`)
* `icy_id` (`int` -- defaults to `1`): Shoutcast source ID. Only supported by Shoutcast v2.
* `format` (`string` -- defaults to `""`): Format, e.g. ``audio/ogg''. When empty, the encoder is used to guess.
* `dj` (`()->string` -- defaults to `{""}`): Callback to set dj name.
* `dumpfile` (`string` -- defaults to `""`): Dump stream to file, for debugging purpose. Disabled if empty.
* `icy_metadata` (`string` -- defaults to `"guess"`): Send new metadata using the ICY protocol. One of: ``guess'', ``true'', ``false''
* `on_connect` (`()->unit` -- defaults to `{()}`): Callback executed when connection starts.
* `on_disconnect` (`()->unit` -- defaults to `{()}`): Callback executed when connection stops.
* `aim` (`string` -- defaults to `""`)
* `icq` (`string` -- defaults to `""`)
* `irc` (`string` -- defaults to `""`)
* `icy_reset` (`bool` -- defaults to `true`): Reset shoutcast source buffer upon connecting (necessary for NSV).
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `on_error` (`(string)->float` -- defaults to `fun (_) -> 3.`): Callback executed when an error happens. If returned value is positive, connection wll be tried again after this amount of time (in seconds).
* `(unlabeled)` (`format('a)`): Encoding format. For shoutcast, should be mp3 or AAC(+).
* `(unlabeled)` (`source('a)`): The source to output

### output.udp
```
(?id:string,?fallible:bool,host:string,
 ?on_start:(()->unit),?on_stop:(()->unit),port:int,
 ?start:bool,format('a),source('a))->active_source('a)```

WARNING: This is only EXPERIMENTAL!

Output encoded data to UDP, without any control whatsoever.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `host` (`string`)
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `port` (`int`)
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`format('a)`): Encoding format.
* `(unlabeled)` (`source('a)`)

Source / Sound Processing
-------------------------
### add
```
(?id:string,?normalize:bool,?weights:[int],
 [source(audio='#a,video='#b,midi=0)])->
source(audio='#a,video='#b,midi=0)```

Mix sources, with optional normalization. Only relay metadata from the first source that is effectively summed.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `normalize` (`bool` -- defaults to `true`)
* `weights` (`[int]` -- defaults to `[]`): Relative weight of the sources in the sum. The empty list stands for the homogeneous distribution.
* `(unlabeled)` (`[source(audio='#a,video='#b,midi=0)]`)

### amplify
```
(?id:string,?override:string,'a,
 source(audio='#b,video='#c,midi='#d))->
source(audio='#b,video='#c,midi='#d)
where 'a is either float or ()->float```

Multiply the amplitude of the signal.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `override` (`string` -- defaults to `"liq_amplify"`): Specify the name of a metadata field that, when present and well-formed, overrides the amplification factor for the current track. Well-formed values are floats in decimal notation (e.g. '0.7') which are taken as normal/linear multiplicative factors; values can be passed in decibels with the suffix 'dB' (e.g. '-8.2 dB', but the spaces do not matter).
* `(unlabeled)` (```
anything that is either float or ()->float```
): Multiplicative factor.
* `(unlabeled)` (`source(audio='#b,video='#c,midi='#d)`)

### clip
```
(?id:string,source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Clip sound.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### comb
```
(?id:string,?delay:float,?feedback:'a,
 source(audio='#b,video='#c,midi='#d))->
source(audio='#b,video='#c,midi='#d)
where 'a is either float or ()->float```

Comb filter.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `delay` (`float` -- defaults to `0.001`): Delay in seconds.
* `feedback` (```
anything that is either float or ()->float```
 -- defaults to `-6.0`): Feedback coefficient in dB.
* `(unlabeled)` (`source(audio='#b,video='#c,midi='#d)`)

### compand
```
(?id:string,?mu:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Compand the signal

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `mu` (`float` -- defaults to `1.0`)
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### compress
```
(?id:string,?attack:'a,?gain:'b,?knee:'c,?ratio:float,
 ?release:'d,?rms_window:float,?threshold:'e,
 source(audio='#f,video='#g,midi='#h))->
source(audio='#f,video='#g,midi='#h)
where 'a, 'b, 'c, 'd, 'e is either float or ()->float```

Compress the signal.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `attack` (```
anything that is either float or ()->float```
 -- defaults to `100.0`): Attack time (ms).
* `gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Additional gain (dB).
* `knee` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Knee radius (dB).
* `ratio` (`float` -- defaults to `2.0`): Gain reduction ratio (n:1).
* `release` (```
anything that is either float or ()->float```
 -- defaults to `400.0`): Release time (ms).
* `rms_window` (`float` -- defaults to `0.1`): Window for computing RMS (in sec).
* `threshold` (```
anything that is either float or ()->float```
 -- defaults to `-10.0`): Threshold level (dB).
* `(unlabeled)` (`source(audio='#f,video='#g,midi='#h)`)

### compress.exponential
```
(?id:string,?mu:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Exponential compressor.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `mu` (`float` -- defaults to `2.0`): Exponential compression factor, typically greater than 1.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### cross
```
(?id:string,?active:bool,?conservative:bool,
 ?duration:float,?inhibit:float,?minimum:float,
 ?override:string,((source('a),source('a))->source('a)),
 source('a))->source('a)```

Generic cross operator, allowing the composition of the N last seconds of a track with the beginning of the next track.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `active` (`bool` -- defaults to `false`): The active behavior is to keep ticking the child's clock when the operator is not streaming. Otherwise the child's clock is strictly based on what is streamed off the child source, which results in time-dependent active sources to be frozen when that source is stopped.
* `conservative` (`bool` -- defaults to `true`): Do not trust remaining time estimations, always buffering data in advance. This avoids being tricked by skips, either manual or caused by skip_blank().
* `duration` (`float` -- defaults to `5.0`): Duration in seconds of the crossed end of track. This value can be changed on a per-file basis using a special metadata field.
* `inhibit` (`float` -- defaults to `-1.0`): Minimum delay between two transitions. It is useful in order to avoid that a transition is triggered on top of another when an end-of-track occurs in the first one. Negative values mean `duration+1`. Warning: zero inhibition can cause infinite loops.
* `minimum` (`float` -- defaults to `-1.0`): Minimum duration (in sec.) for a cross: If the track ends without any warning (e.g. in case of skip) there may not be enough data for a decent composition. Set to 0. to avoid having transitions after skips, or more to avoid transitions on short tracks. With the negative default, transitions always occur.
* `override` (`string` -- defaults to `"liq_start_next"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
* `(unlabeled)` (`(source('a),source('a))->source('a)`): Composition of an end of track and the next track.
* `(unlabeled)` (`source('a)`)

### echo
```
(?id:string,?delay:'a,?feedback:'b,?ping_pong:bool,
 source(audio='#c,video='#d,midi='#e))->
source(audio='#c,video='#d,midi='#e)
where 'a, 'b is either float or ()->float```

Add echo.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `delay` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Delay in seconds.
* `feedback` (```
anything that is either float or ()->float```
 -- defaults to `-6.0`): Feedback coefficient in dB (negative).
* `ping_pong` (`bool` -- defaults to `false`): Use ping-pong delay.
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

### fade.final
```
(?id:string,?duration:float,?override_duration:string,
 ?override_type:string,?type:string,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Fade a stream to silence.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (`float` -- defaults to `3.0`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `override_duration` (`string` -- defaults to `"liq_fade_final"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
* `override_type` (`string` -- defaults to `"liq_fade_type"`): Metadata field which, if present and correct, overrides the 'type' parameter for current track.
* `type` (`string` -- defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### fade.in
```
(?id:string,?duration:float,?override_duration:string,
 ?override_type:string,?type:string,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Fade the beginning of tracks.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (`float` -- defaults to `3.0`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `override_duration` (`string` -- defaults to `"liq_fade_in"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
* `override_type` (`string` -- defaults to `"liq_fade_type"`): Metadata field which, if present and correct, overrides the 'type' parameter for current track.
* `type` (`string` -- defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### fade.initial
```
(?id:string,?duration:float,?override_duration:string,
 ?override_type:string,?type:string,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Fade the beginning of a stream.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (`float` -- defaults to `3.0`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `override_duration` (`string` -- defaults to `"liq_fade_initial"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
* `override_type` (`string` -- defaults to `"liq_fade_type"`): Metadata field which, if present and correct, overrides the 'type' parameter for current track.
* `type` (`string` -- defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### fade.out
```
(?id:string,?duration:float,?override_duration:string,
 ?override_type:string,?type:string,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Fade the end of tracks.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (`float` -- defaults to `3.0`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `override_duration` (`string` -- defaults to `"liq_fade_out"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
* `override_type` (`string` -- defaults to `"liq_fade_type"`): Metadata field which, if present and correct, overrides the 'type' parameter for current track.
* `type` (`string` -- defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### filter
```
(?id:string,freq:'a,mode:string,?q:'b,?wetness:'c,
 source(audio='#d,video='#e,midi='#f))->
source(audio='#d,video='#e,midi='#f)
where 'a, 'b, 'c is either float or ()->float```

Perform several kinds of filtering on the signal

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `freq` (```
anything that is either float or ()->float```
)
* `mode` (`string`): Available modes are 'low' (for low-pass filter), 'high' (for high-pass filter), 'band' (for band-pass filter) and 'notch' (for notch / band-stop / band-rejection filter).
* `q` (```
anything that is either float or ()->float```
 -- defaults to `1.0`)
* `wetness` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): How much of the original signal should be added (1. means only filtered and 0. means only original signal).
* `(unlabeled)` (`source(audio='#d,video='#e,midi='#f)`)

### filter.fir
```
(?id:string,beta:float,?coeffs:int,frequency:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Low-pass FIR filter.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `beta` (`float`): Beta should range between 0 and 1.
* `coeffs` (`int` -- defaults to `255`): Number of coefficients
* `frequency` (`float`): Corner frequency in Hz (frequency at which the response is 0.5, that is -6 dB).
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### filter.iir.butterworth.bandpass
```
(?id:string,frequency1:float,frequency2:float,?order:int,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

IIR filter

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency1` (`float`): First corner frequency
* `frequency2` (`float`): Second corner frequency
* `order` (`int` -- defaults to `4`): Filter order
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### filter.iir.butterworth.bandstop
```
(?id:string,frequency1:float,frequency2:float,?order:int,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

IIR filter

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency1` (`float`): First corner frequency
* `frequency2` (`float`): Second corner frequency
* `order` (`int` -- defaults to `4`): Filter order
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### filter.iir.butterworth.high
```
(?id:string,frequency:float,?order:int,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

IIR filter

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `order` (`int` -- defaults to `4`): Filter order
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### filter.iir.butterworth.low
```
(?id:string,frequency:float,?order:int,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

IIR filter

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `order` (`int` -- defaults to `4`): Filter order
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### filter.iir.eq.allpass
```
(?id:string,?bandwidth:float,frequency:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

All pass biquad filter.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `bandwidth` (`float` -- defaults to `0.333333333333`): Bandwidth (in octaves)
* `frequency` (`float`): Center frequency
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### filter.iir.eq.bandpass
```
(?id:string,frequency:float,?q:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Band pass biquad filter.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Center frequency
* `q` (`float` -- defaults to `1.0`): Q
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### filter.iir.eq.high
```
(?id:string,frequency:float,?q:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

High pass biquad filter.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `q` (`float` -- defaults to `1.0`): Q
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### filter.iir.eq.highshelf
```
(?id:string,frequency:float,?slope:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

High shelf biquad filter.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Center frequency
* `slope` (`float` -- defaults to `1.0`): Shelf slope (in dB/octave)
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### filter.iir.eq.low
```
(?id:string,frequency:float,?q:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Low pass biquad filter.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `q` (`float` -- defaults to `1.0`): Q
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### filter.iir.eq.lowshelf
```
(?id:string,frequency:float,?slope:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Low shelf biquad filter.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `slope` (`float` -- defaults to `1.0`): Shelf slope (dB/octave)
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### filter.iir.eq.notch
```
(?id:string,frequency:float,?q:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Band pass biquad filter.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Center frequency
* `q` (`float` -- defaults to `1.0`): Q
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### filter.iir.eq.peak
```
(?id:string,frequency:float,?gain:float,?q:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Peak EQ biquad filter.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Center frequency
* `gain` (`float` -- defaults to `1.0`): Gain (in dB)
* `q` (`float` -- defaults to `1.0`): Q
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### filter.iir.resonator.allpass
```
(?id:string,frequency:float,?q:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

IIR filter

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `q` (`float` -- defaults to `60.0`): Quality factor
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### filter.iir.resonator.bandpass
```
(?id:string,frequency:float,?q:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

IIR filter

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `q` (`float` -- defaults to `60.0`): Quality factor
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### filter.iir.resonator.bandstop
```
(?id:string,frequency:float,?q:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

IIR filter

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `q` (`float` -- defaults to `60.0`): Quality factor
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### filter.rc
```
(?id:string,mode:string,rc:'a,?wetness:'b,
 source(audio='#c,video='#d,midi='#e))->
source(audio='#c,video='#d,midi='#e)
where 'a, 'b is either float or ()->float```

First-order filter (RC filter).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `mode` (`string`): Available modes are 'low' (for low-pass filter), 'high' (for high-pass filter).
* `rc` (```
anything that is either float or ()->float```
): Time constant (in seconds).
* `wetness` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): How much of the original signal should be added (1. means only filtered and 0. means only original signal).
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

### flanger
```
(?id:string,?delay:float,?feedback:'a,?freq:'b,?phase:'c,
 source(audio='#d,video='#e,midi='#f))->
source(audio='#d,video='#e,midi='#f)
where 'a, 'b, 'c is either float or ()->float```

Flanger effect.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `delay` (`float` -- defaults to `0.001`): Delay in seconds.
* `feedback` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Feedback coefficient in dB.
* `freq` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Frequency in Hz.
* `phase` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Phase difference between channels in radians.
* `(unlabeled)` (`source(audio='#d,video='#e,midi='#f)`)

### ladspa.alias
```
(?id:string,?aliasing_level:'a,
 source(audio='#b,video='#c,midi='#d))->
source(audio='#b,video='#c,midi='#d)
where 'a is either float or ()->float```

Aliasing by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `aliasing_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Aliasing level (0 <= `aliasing_level` <= 1).
* `(unlabeled)` (`source(audio='#b,video='#c,midi='#d)`)

### ladspa.allpass_c
```
(?id:string,decay_time:'a,delay_time:'b,max_delay:'c,
 source(audio='#d,video='#e,midi='#f))->
source(audio='#d,video='#e,midi='#f)
where 'a, 'b, 'c is either float or ()->float```

Allpass delay line, cubic spline interpolation by Andy Wingo <wingo at pobox dot com>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `decay_time` (```
anything that is either float or ()->float```
): Decay Time (s) (0 <= `decay_time`).
* `delay_time` (```
anything that is either float or ()->float```
): Delay Time (s) (0 <= `delay_time`).
* `max_delay` (```
anything that is either float or ()->float```
): Max Delay (s) (0 <= `max_delay`).
* `(unlabeled)` (`source(audio='#d,video='#e,midi='#f)`)

### ladspa.allpass_l
```
(?id:string,decay_time:'a,delay_time:'b,max_delay:'c,
 source(audio='#d,video='#e,midi='#f))->
source(audio='#d,video='#e,midi='#f)
where 'a, 'b, 'c is either float or ()->float```

Allpass delay line, linear interpolation by Andy Wingo <wingo at pobox dot com>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `decay_time` (```
anything that is either float or ()->float```
): Decay Time (s) (0 <= `decay_time`).
* `delay_time` (```
anything that is either float or ()->float```
): Delay Time (s) (0 <= `delay_time`).
* `max_delay` (```
anything that is either float or ()->float```
): Max Delay (s) (0 <= `max_delay`).
* `(unlabeled)` (`source(audio='#d,video='#e,midi='#f)`)

### ladspa.allpass_n
```
(?id:string,decay_time:'a,delay_time:'b,max_delay:'c,
 source(audio='#d,video='#e,midi='#f))->
source(audio='#d,video='#e,midi='#f)
where 'a, 'b, 'c is either float or ()->float```

Allpass delay line, noninterpolating by Andy Wingo <wingo at pobox dot com>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `decay_time` (```
anything that is either float or ()->float```
): Decay Time (s) (0 <= `decay_time`).
* `delay_time` (```
anything that is either float or ()->float```
): Delay Time (s) (0 <= `delay_time`).
* `max_delay` (```
anything that is either float or ()->float```
): Max Delay (s) (0 <= `max_delay`).
* `(unlabeled)` (`source(audio='#d,video='#e,midi='#f)`)

### ladspa.amp
```
(?id:string,?amps_gain:'a,
 source(audio='#b,video='#c,midi='#d))->
source(audio='#b,video='#c,midi='#d)
where 'a is either float or ()->float```

Simple amplifier by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `amps_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Amps gain (dB) (-70 <= `amps_gain` <= 70).
* `(unlabeled)` (`source(audio='#b,video='#c,midi='#d)`)

### ladspa.ampitchshift
```
(?id:string,?buffer_size:'a,?pitch_shift:'b,
 source(audio='#c,video='#d,midi='#e))->
source(audio='#c,video='#d,midi='#e)
where 'b is either float or ()->float,
  'a is either int or ()->int```

AM pitchshifter by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `buffer_size` (`anything that is either int or ()->int` -- defaults to `4`): Buffer size (1 <= `buffer_size` <= 7).
* `pitch_shift` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Pitch shift (0.25 <= `pitch_shift` <= 4).
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

### ladspa.analogueosc
```
(?id:string,?frequency:'a,?instability:'b,?warmth:'c,
 ?waveform:'d)->source(audio=1,video=0,midi=0)
where 'a, 'b, 'c is either float or ()->float,
  'd is either int or ()->int```

Analogue Oscillator by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (```
anything that is either float or ()->float```
 -- defaults to `440.0`): Frequency (Hz) (0.0441 <= `frequency` <= 22005.9).
* `instability` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Instability (0 <= `instability` <= 1).
* `warmth` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Warmth (0 <= `warmth` <= 1).
* `waveform` (`anything that is either int or ()->int` -- defaults to `1`): Waveform (1=sin, 2=tri, 3=squ, 4=saw) (1 <= `waveform` <= 4).

### ladspa.artificiallatency
```
(?id:string,?delay:'a,
 source(audio='#b,video='#c,midi='#d))->
source(audio='#b,video='#c,midi='#d)
where 'a is either float or ()->float```

Artificial latency by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `delay` (```
anything that is either float or ()->float```
 -- defaults to `2500.0`): Delay (ms) (0 <= `delay` <= 10000).
* `(unlabeled)` (`source(audio='#b,video='#c,midi='#d)`)

### ladspa.autophaser
```
(?id:string,?attack_time:'a,?decay_time:'b,?feedback:'c,
 ?modulation_depth:'d,?spread:'e,
 source(audio='#f,video='#g,midi='#h))->
source(audio='#f,video='#g,midi='#h)
where 'a, 'b, 'c, 'd, 'e is either float or ()->float```

Auto phaser by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `attack_time` (```
anything that is either float or ()->float```
 -- defaults to `0.25`): Attack time (s) (0 <= `attack_time` <= 1).
* `decay_time` (```
anything that is either float or ()->float```
 -- defaults to `0.25`): Decay time (s) (0 <= `decay_time` <= 1).
* `feedback` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Feedback (-1 <= `feedback` <= 1).
* `modulation_depth` (```
anything that is either float or ()->float```
 -- defaults to `0.25`): Modulation depth (0 <= `modulation_depth` <= 1).
* `spread` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Spread (octaves) (0 <= `spread` <= 2).
* `(unlabeled)` (`source(audio='#f,video='#g,midi='#h)`)

### ladspa.bandpass_a_iir
```
(?id:string,?bandwidth:'a,?center_frequency:'b,
 source(audio='#c,video='#d,midi='#e))->
source(audio='#c,video='#d,midi='#e)
where 'a, 'b is either float or ()->float```

Glame Bandpass Analog Filter by Alexander Ehlert <mag(at)glame.de>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `bandwidth` (```
anything that is either float or ()->float```
 -- defaults to `295.831787109`): Bandwidth (Hz) (4.41 <= `bandwidth` <= 19845).
* `center_frequency` (```
anything that is either float or ()->float```
 -- defaults to `36.1194992065`): Center Frequency (Hz) (4.41 <= `center_frequency` <= 19845).
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

### ladspa.bandpass_iir
```
(?id:string,?bandwidth:'a,?center_frequency:'b,
 ?stages:'c,source(audio='#d,video='#e,midi='#f))->
source(audio='#d,video='#e,midi='#f)
where 'a, 'b is either float or ()->float,
  'c is either int or ()->int```

Glame Bandpass Filter by Alexander Ehlert <mag(at)glame.de>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `bandwidth` (```
anything that is either float or ()->float```
 -- defaults to `295.831787109`): Bandwidth (Hz) (4.41 <= `bandwidth` <= 19845).
* `center_frequency` (```
anything that is either float or ()->float```
 -- defaults to `295.831787109`): Center Frequency (Hz) (4.41 <= `center_frequency` <= 19845).
* `stages` (`anything that is either int or ()->int` -- defaults to `1`): Stages(2 poles per stage) (1 <= `stages` <= 10).
* `(unlabeled)` (`source(audio='#d,video='#e,midi='#f)`)

### ladspa.bodeshifter
```
(?id:string,?frequency_shift:'a,
 source(audio=1,video=0,midi=0))->
source(audio=2,video=0,midi=0)
where 'a is either float or ()->float```

Bode frequency shifter by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency_shift` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Frequency shift (0 <= `frequency_shift` <= 5000).
* `(unlabeled)` (`source(audio=1,video=0,midi=0)`)

### ladspa.bodeshiftercv
```
(?id:string,?base_shift:'a,?cv_attenuation:'b,?mix:'c,
 source(audio=2,video=0,midi=0))->
source(audio=3,video=0,midi=0)
where 'a, 'b, 'c is either float or ()->float```

Bode frequency shifter (CV) by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `base_shift` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Base shift (0 <= `base_shift` <= 5000).
* `cv_attenuation` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): CV Attenuation (0 <= `cv_attenuation` <= 1).
* `mix` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Mix (-1=down, +1=up) (-1 <= `mix` <= 1).
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

### ladspa.butthigh_iir
```
(?id:string,?cutoff_frequency:'a,?resonance:'b,
 source(audio='#c,video='#d,midi='#e))->
source(audio='#c,video='#d,midi='#e)
where 'a, 'b is either float or ()->float```

GLAME Butterworth Highpass by Alexander Ehlert <mag(at)glame.de>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `cutoff_frequency` (```
anything that is either float or ()->float```
 -- defaults to `36.1194992065`): Cutoff Frequency (Hz) (4.41 <= `cutoff_frequency` <= 19845).
* `resonance` (```
anything that is either float or ()->float```
 -- defaults to `0.754999995232`): Resonance (0.1 <= `resonance` <= 1.41).
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

### ladspa.buttlow_iir
```
(?id:string,?cutoff_frequency:'a,?resonance:'b,
 source(audio='#c,video='#d,midi='#e))->
source(audio='#c,video='#d,midi='#e)
where 'a, 'b is either float or ()->float```

GLAME Butterworth Lowpass by Alexander Ehlert <mag(at)glame.de>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `cutoff_frequency` (```
anything that is either float or ()->float```
 -- defaults to `36.1194992065`): Cutoff Frequency (Hz) (4.41 <= `cutoff_frequency` <= 19845).
* `resonance` (```
anything that is either float or ()->float```
 -- defaults to `0.754999995232`): Resonance (0.1 <= `resonance` <= 1.41).
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

### ladspa.bwxover_iir
```
(?id:string,?cutoff_frequency:'a,?resonance:'b,
 source(audio=1,video=0,midi=0))->
source(audio=2,video=0,midi=0)
where 'a, 'b is either float or ()->float```

Glame Butterworth X-over Filter by Alexander Ehlert <mag(at)glame.de>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `cutoff_frequency` (```
anything that is either float or ()->float```
 -- defaults to `36.1194992065`): Cutoff Frequency (Hz) (4.41 <= `cutoff_frequency` <= 19845).
* `resonance` (```
anything that is either float or ()->float```
 -- defaults to `0.754999995232`): Resonance (0.1 <= `resonance` <= 1.41).
* `(unlabeled)` (`source(audio=1,video=0,midi=0)`)

### ladspa.chebstortion
```
(?id:string,?distortion:'a,
 source(audio='#b,video='#c,midi='#d))->
source(audio='#b,video='#c,midi='#d)
where 'a is either float or ()->float```

Chebyshev distortion by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `distortion` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Distortion (0 <= `distortion` <= 3).
* `(unlabeled)` (`source(audio='#b,video='#c,midi='#d)`)

### ladspa.comb
```
(?id:string,?band_separation:'a,?feedback:'b,
 source(audio='#c,video='#d,midi='#e))->
source(audio='#c,video='#d,midi='#e)
where 'a, 'b is either float or ()->float```

Comb Filter by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `band_separation` (```
anything that is either float or ()->float```
 -- defaults to `172.0`): Band separation (Hz) (16 <= `band_separation` <= 640).
* `feedback` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Feedback (-0.99 <= `feedback` <= 0.99).
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

### ladspa.comb_c
```
(?id:string,decay_time:'a,delay_time:'b,max_delay:'c,
 source(audio='#d,video='#e,midi='#f))->
source(audio='#d,video='#e,midi='#f)
where 'a, 'b, 'c is either float or ()->float```

Comb delay line, cubic spline interpolation by Andy Wingo <wingo at pobox dot com>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `decay_time` (```
anything that is either float or ()->float```
): Decay Time (s) (0 <= `decay_time`).
* `delay_time` (```
anything that is either float or ()->float```
): Delay Time (s) (0 <= `delay_time`).
* `max_delay` (```
anything that is either float or ()->float```
): Max Delay (s) (0 <= `max_delay`).
* `(unlabeled)` (`source(audio='#d,video='#e,midi='#f)`)

### ladspa.comb_l
```
(?id:string,decay_time:'a,delay_time:'b,max_delay:'c,
 source(audio='#d,video='#e,midi='#f))->
source(audio='#d,video='#e,midi='#f)
where 'a, 'b, 'c is either float or ()->float```

Comb delay line, linear interpolation by Andy Wingo <wingo at pobox dot com>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `decay_time` (```
anything that is either float or ()->float```
): Decay Time (s) (0 <= `decay_time`).
* `delay_time` (```
anything that is either float or ()->float```
): Delay Time (s) (0 <= `delay_time`).
* `max_delay` (```
anything that is either float or ()->float```
): Max Delay (s) (0 <= `max_delay`).
* `(unlabeled)` (`source(audio='#d,video='#e,midi='#f)`)

### ladspa.comb_n
```
(?id:string,decay_time:'a,delay_time:'b,max_delay:'c,
 source(audio='#d,video='#e,midi='#f))->
source(audio='#d,video='#e,midi='#f)
where 'a, 'b, 'c is either float or ()->float```

Comb delay line, noninterpolating by Andy Wingo <wingo at pobox dot com>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `decay_time` (```
anything that is either float or ()->float```
): Decay Time (s) (0 <= `decay_time`).
* `delay_time` (```
anything that is either float or ()->float```
): Delay Time (s) (0 <= `delay_time`).
* `max_delay` (```
anything that is either float or ()->float```
): Max Delay (s) (0 <= `max_delay`).
* `(unlabeled)` (`source(audio='#d,video='#e,midi='#f)`)

### ladspa.combsplitter
```
(?id:string,?band_separation:'a,
 source(audio=1,video=0,midi=0))->
source(audio=2,video=0,midi=0)
where 'a is either float or ()->float```

Comb Splitter by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `band_separation` (```
anything that is either float or ()->float```
 -- defaults to `172.0`): Band separation (Hz) (16 <= `band_separation` <= 640).
* `(unlabeled)` (`source(audio=1,video=0,midi=0)`)

### ladspa.const
```
(?id:string,?signal_amplitude:'a,
 source(audio='#b,video='#c,midi='#d))->
source(audio='#b,video='#c,midi='#d)
where 'a is either float or ()->float```

Constant Signal Generator by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `signal_amplitude` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Signal amplitude (-1 <= `signal_amplitude` <= 1.1).
* `(unlabeled)` (`source(audio='#b,video='#c,midi='#d)`)

### ladspa.crossoverdist
```
(?id:string,?crossover_amplitude:'a,?smoothing:'b,
 source(audio='#c,video='#d,midi='#e))->
source(audio='#c,video='#d,midi='#e)
where 'a, 'b is either float or ()->float```

Crossover distortion by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `crossover_amplitude` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Crossover amplitude (0 <= `crossover_amplitude` <= 0.1).
* `smoothing` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Smoothing (0 <= `smoothing` <= 1).
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

### ladspa.dcremove
```
(?id:string,source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

DC Offset Remover by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### ladspa.decay
```
(?id:string,decay_time:'a,
 source(audio='#b,video='#c,midi='#d))->
source(audio='#b,video='#c,midi='#d)
where 'a is either float or ()->float```

Exponential signal decay by Andy Wingo <wingo at pobox dot com>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `decay_time` (```
anything that is either float or ()->float```
): Decay Time (s) (0 <= `decay_time`).
* `(unlabeled)` (`source(audio='#b,video='#c,midi='#d)`)

### ladspa.decimator
```
(?id:string,?bit_depth:'a,?sample_rate:'b,
 source(audio='#c,video='#d,midi='#e))->
source(audio='#c,video='#d,midi='#e)
where 'a, 'b is either float or ()->float```

Decimator by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `bit_depth` (```
anything that is either float or ()->float```
 -- defaults to `24.0`): Bit depth (1 <= `bit_depth` <= 24).
* `sample_rate` (```
anything that is either float or ()->float```
 -- defaults to `44100.0`): Sample rate (Hz) (44.1 <= `sample_rate` <= 44100).
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

### ladspa.declip
```
(?id:string,source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Declipper by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### ladspa.delay_c
```
(?id:string,delay_time:'a,max_delay:'b,
 source(audio='#c,video='#d,midi='#e))->
source(audio='#c,video='#d,midi='#e)
where 'a, 'b is either float or ()->float```

Simple delay line, cubic spline interpolation by Andy Wingo <wingo at pobox dot com>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `delay_time` (```
anything that is either float or ()->float```
): Delay Time (s) (0 <= `delay_time`).
* `max_delay` (```
anything that is either float or ()->float```
): Max Delay (s) (0 <= `max_delay`).
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

### ladspa.delay_l
```
(?id:string,delay_time:'a,max_delay:'b,
 source(audio='#c,video='#d,midi='#e))->
source(audio='#c,video='#d,midi='#e)
where 'a, 'b is either float or ()->float```

Simple delay line, linear interpolation by Andy Wingo <wingo at pobox dot com>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `delay_time` (```
anything that is either float or ()->float```
): Delay Time (s) (0 <= `delay_time`).
* `max_delay` (```
anything that is either float or ()->float```
): Max Delay (s) (0 <= `max_delay`).
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

### ladspa.delay_n
```
(?id:string,delay_time:'a,max_delay:'b,
 source(audio='#c,video='#d,midi='#e))->
source(audio='#c,video='#d,midi='#e)
where 'a, 'b is either float or ()->float```

Simple delay line, noninterpolating by Andy Wingo <wingo at pobox dot com>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `delay_time` (```
anything that is either float or ()->float```
): Delay Time (s) (0 <= `delay_time`).
* `max_delay` (```
anything that is either float or ()->float```
): Max Delay (s) (0 <= `max_delay`).
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

### ladspa.delayorama
```
(?id:string,?amplitude_change:'a,?amplitude_random:'b,
 ?delay_change:'c,?delay_random:'d,?delay_range:'e,
 ?dry_wet_mix:'f,?feedback:'g,?first_delay:'h,
 ?input_gain:'i,?number_of_taps:'j,?random_seed:'k,
 source(audio='#l,video='#m,midi='#n))->
source(audio='#l,video='#m,midi='#n)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g, 'h, 'i is either float or ()->float,
  'j, 'k is either int or ()->int```

Delayorama by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `amplitude_change` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Amplitude change (0.2 <= `amplitude_change` <= 5).
* `amplitude_random` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Amplitude random (%) (0 <= `amplitude_random` <= 100).
* `delay_change` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Delay change (0.2 <= `delay_change` <= 5).
* `delay_random` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Delay random (%) (0 <= `delay_random` <= 100).
* `delay_range` (```
anything that is either float or ()->float```
 -- defaults to `6.0`): Delay range (s) (0.0001 <= `delay_range` <= 6).
* `dry_wet_mix` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Dry/wet mix (0 <= `dry_wet_mix` <= 1).
* `feedback` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Feedback (%) (0 <= `feedback` <= 100).
* `first_delay` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): First delay (s) (0 <= `first_delay` <= 5).
* `input_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Input gain (dB) (-96 <= `input_gain` <= 24).
* `number_of_taps` (`anything that is either int or ()->int` -- defaults to `2`): Number of taps (2 <= `number_of_taps` <= 128).
* `random_seed` (`anything that is either int or ()->int` -- defaults to `0`): Random seed (0 <= `random_seed` <= 1000).
* `(unlabeled)` (`source(audio='#l,video='#m,midi='#n)`)

### ladspa.diode
```
(?id:string,?mode:'a,
 source(audio='#b,video='#c,midi='#d))->
source(audio='#b,video='#c,midi='#d)
where 'a is either float or ()->float```

Diode Processor by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `mode` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Mode (0 for none, 1 for half wave, 2 for full wave) (0 <= `mode` <= 3).
* `(unlabeled)` (`source(audio='#b,video='#c,midi='#d)`)

### ladspa.divider
```
(?id:string,?denominator:'a,
 source(audio='#b,video='#c,midi='#d))->
source(audio='#b,video='#c,midi='#d)
where 'a is either int or ()->int```

Audio Divider (Suboctave Generator) by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `denominator` (`anything that is either int or ()->int` -- defaults to `1`): Denominator (1 <= `denominator` <= 8).
* `(unlabeled)` (`source(audio='#b,video='#c,midi='#d)`)

### ladspa.dj_eq
```
(?id:string,?hi_gain:'a,?lo_gain:'b,?mid_gain:'c,
 source(audio=2,video=0,midi=0))->
source(audio=2,video=0,midi=0)
where 'a, 'b, 'c is either float or ()->float```

DJ EQ by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `hi_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Hi gain (dB) (-70 <= `hi_gain` <= 6).
* `lo_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Lo gain (dB) (-70 <= `lo_gain` <= 6).
* `mid_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Mid gain (dB) (-70 <= `mid_gain` <= 6).
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

### ladspa.dj_eq_mono
```
(?id:string,?hi_gain:'a,?lo_gain:'b,?mid_gain:'c,
 source(audio='#d,video='#e,midi='#f))->
source(audio='#d,video='#e,midi='#f)
where 'a, 'b, 'c is either float or ()->float```

DJ EQ (mono) by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `hi_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Hi gain (dB) (-70 <= `hi_gain` <= 6).
* `lo_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Lo gain (dB) (-70 <= `lo_gain` <= 6).
* `mid_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Mid gain (dB) (-70 <= `mid_gain` <= 6).
* `(unlabeled)` (`source(audio='#d,video='#e,midi='#f)`)

### ladspa.djflanger
```
(?id:string,?feedback:'a,?lfo_depth:'b,?lfo_period:'c,
 lfo_sync:'d,source(audio='#e,video='#f,midi='#g))->
source(audio='#e,video='#f,midi='#g)
where 'a, 'b, 'c, 'd is either float or ()->float```

DJ flanger by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `feedback` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Feedback (%) (-100 <= `feedback` <= 100).
* `lfo_depth` (```
anything that is either float or ()->float```
 -- defaults to `4.0`): LFO depth (ms) (1 <= `lfo_depth` <= 5).
* `lfo_period` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): LFO period (s) (0.1 <= `lfo_period` <= 32).
* `lfo_sync` (```
anything that is either float or ()->float```
): LFO sync.
* `(unlabeled)` (`source(audio='#e,video='#f,midi='#g)`)

### ladspa.dysoncompress
```
(?id:string,?compression_ratio:'a,
 ?fast_compression_ratio:'b,?peak_limit:'c,
 ?release_time:'d,source(audio='#e,video='#f,midi='#g))->
source(audio='#e,video='#f,midi='#g)
where 'a, 'b, 'c, 'd is either float or ()->float```

Dyson compressor by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `compression_ratio` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Compression ratio (0 <= `compression_ratio` <= 1).
* `fast_compression_ratio` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Fast compression ratio (0 <= `fast_compression_ratio` <= 1).
* `peak_limit` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Peak limit (dB) (-30 <= `peak_limit` <= 0).
* `release_time` (```
anything that is either float or ()->float```
 -- defaults to `0.25`): Release time (s) (0 <= `release_time` <= 1).
* `(unlabeled)` (`source(audio='#e,video='#f,midi='#g)`)

### ladspa.faddelay
```
(?id:string,?delay:'a,?feedback:'b,
 source(audio='#c,video='#d,midi='#e))->
source(audio='#c,video='#d,midi='#e)
where 'a, 'b is either float or ()->float```

Fractionally Addressed Delay Line by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `delay` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Delay (seconds) (0.1 <= `delay` <= 10).
* `feedback` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Feedback (dB) (-70 <= `feedback` <= 0).
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

### ladspa.fastlookaheadlimiter
```
(?id:string,?input_gain:'a,?limit:'b,?release_time:'c,
 source(audio=2,video=0,midi=0))->
source(audio=2,video=0,midi=0)
where 'a, 'b, 'c is either float or ()->float```

Fast Lookahead limiter by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `input_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Input gain (dB) (-20 <= `input_gain` <= 20).
* `limit` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Limit (dB) (-20 <= `limit` <= 0).
* `release_time` (```
anything that is either float or ()->float```
 -- defaults to `0.507499992847`): Release time (s) (0.01 <= `release_time` <= 2).
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

### ladspa.flanger
```
(?id:string,?delay_base:'a,?feedback:'b,
 ?lfo_frequency:'c,?max_slowdown:'d,
 source(audio='#e,video='#f,midi='#g))->
source(audio='#e,video='#f,midi='#g)
where 'a, 'b, 'c, 'd is either float or ()->float```

Flanger by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `delay_base` (```
anything that is either float or ()->float```
 -- defaults to `6.32499980927`): Delay base (ms) (0.1 <= `delay_base` <= 25).
* `feedback` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Feedback (-1 <= `feedback` <= 1).
* `lfo_frequency` (```
anything that is either float or ()->float```
 -- defaults to `0.334370166063`): LFO frequency (Hz) (0.05 <= `lfo_frequency` <= 100).
* `max_slowdown` (```
anything that is either float or ()->float```
 -- defaults to `2.5`): Max slowdown (ms) (0 <= `max_slowdown` <= 10).
* `(unlabeled)` (`source(audio='#e,video='#f,midi='#g)`)

### ladspa.fmosc
```
(?id:string,?waveform:'a,
 source(audio='#b,video='#c,midi='#d))->
source(audio='#b,video='#c,midi='#d)
where 'a is either int or ()->int```

FM Oscillator by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `waveform` (`anything that is either int or ()->int` -- defaults to `1`): Waveform (1=sin, 2=tri, 3=squ, 4=saw) (1 <= `waveform` <= 4).
* `(unlabeled)` (`source(audio='#b,video='#c,midi='#d)`)

### ladspa.foldover
```
(?id:string,?drive:'a,?skew:'b,
 source(audio='#c,video='#d,midi='#e))->
source(audio='#c,video='#d,midi='#e)
where 'a, 'b is either float or ()->float```

Foldover distortion by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `drive` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Drive (0 <= `drive` <= 1).
* `skew` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Skew (0 <= `skew` <= 1).
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

### ladspa.fourbyfourpole
```
(?id:string,?feedback_1:'a,?feedback_2:'b,?feedback_3:'c,
 ?feedback_4:'d,?frequency_1:'e,?frequency_2:'f,
 ?frequency_3:'g,?frequency_4:'h,
 source(audio='#i,video='#j,midi='#k))->
source(audio='#i,video='#j,midi='#k)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g, 'h is either float or ()->float```

4 x 4 pole allpass by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `feedback_1` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Feedback 1 (-1 <= `feedback_1` <= 1).
* `feedback_2` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Feedback 2 (-1 <= `feedback_2` <= 1).
* `feedback_3` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Feedback 3 (-1 <= `feedback_3` <= 1).
* `feedback_4` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Feedback 4 (-1 <= `feedback_4` <= 1).
* `frequency_1` (```
anything that is either float or ()->float```
 -- defaults to `5000.75`): Frequency 1 (1 <= `frequency_1` <= 20000).
* `frequency_2` (```
anything that is either float or ()->float```
 -- defaults to `10000.5`): Frequency 2 (1 <= `frequency_2` <= 20000).
* `frequency_3` (```
anything that is either float or ()->float```
 -- defaults to `15000.25`): Frequency 3 (1 <= `frequency_3` <= 20000).
* `frequency_4` (```
anything that is either float or ()->float```
 -- defaults to `20000.0`): Frequency 4 (1 <= `frequency_4` <= 20000).
* `(unlabeled)` (`source(audio='#i,video='#j,midi='#k)`)

### ladspa.foverdrive
```
(?id:string,?drive_level:'a,
 source(audio='#b,video='#c,midi='#d))->
source(audio='#b,video='#c,midi='#d)
where 'a is either float or ()->float```

Fast overdrive by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `drive_level` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Drive level (1 <= `drive_level` <= 3).
* `(unlabeled)` (`source(audio='#b,video='#c,midi='#d)`)

### ladspa.freqtracker
```
(?id:string,?tracking_speed:'a,
 source(audio='#b,video='#c,midi='#d))->
source(audio='#b,video='#c,midi='#d)
where 'a is either float or ()->float```

Frequency tracker by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `tracking_speed` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Tracking speed (0 <= `tracking_speed` <= 1).
* `(unlabeled)` (`source(audio='#b,video='#c,midi='#d)`)

### ladspa.gate
```
(?id:string,?attack:'a,?decay:'b,?hf_key_filter:'c,
 ?hold:'d,?lf_key_filter:'e,?output_select:'f,?range:'g,
 ?threshold:'h,source(audio='#i,video='#j,midi='#k))->
source(audio='#i,video='#j,midi='#k)
where
  'a, 'b, 'c, 'd, 'e, 'g, 'h is either float or ()->float,
  'f is either int or ()->int```

Gate by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `attack` (```
anything that is either float or ()->float```
 -- defaults to `250.007507324`): Attack (ms) (0.01 <= `attack` <= 1000).
* `decay` (```
anything that is either float or ()->float```
 -- defaults to `2001.0`): Decay (ms) (2 <= `decay` <= 4000).
* `hf_key_filter` (```
anything that is either float or ()->float```
 -- defaults to `21609.0`): HF key filter (Hz) (220.5 <= `hf_key_filter` <= 21609).
* `hold` (```
anything that is either float or ()->float```
 -- defaults to `1500.5`): Hold (ms) (2 <= `hold` <= 2000).
* `lf_key_filter` (```
anything that is either float or ()->float```
 -- defaults to `30.8699989319`): LF key filter (Hz) (30.87 <= `lf_key_filter` <= 4410).
* `output_select` (`anything that is either int or ()->int` -- defaults to `0`): Output select (-1 = key listen, 0 = gate, 1 = bypass) (-1 <= `output_select` <= 1).
* `range` (```
anything that is either float or ()->float```
 -- defaults to `-90.0`): Range (dB) (-90 <= `range` <= 0).
* `threshold` (```
anything that is either float or ()->float```
 -- defaults to `-70.0`): Threshold (dB) (-70 <= `threshold` <= 20).
* `(unlabeled)` (`source(audio='#i,video='#j,midi='#k)`)

### ladspa.giantflange
```
(?id:string,?delay_1_range:'a,?delay_2_range:'b,
 double_delay:'c,?dry_wet_level:'d,?feedback:'e,
 ?lfo_frequency_1:'f,?lfo_frequency_2:'g,
 source(audio='#h,video='#i,midi='#j))->
source(audio='#h,video='#i,midi='#j)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g is either float or ()->float```

Giant flange by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `delay_1_range` (```
anything that is either float or ()->float```
 -- defaults to `2.625`): Delay 1 range (s) (0 <= `delay_1_range` <= 10.5).
* `delay_2_range` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Delay 2 range (s) (0 <= `delay_2_range` <= 10.5).
* `double_delay` (```
anything that is either float or ()->float```
): Double delay.
* `dry_wet_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Dry/Wet level (0 <= `dry_wet_level` <= 1).
* `feedback` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Feedback (-100 <= `feedback` <= 100).
* `lfo_frequency_1` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): LFO frequency 1 (Hz) (0 <= `lfo_frequency_1` <= 30).
* `lfo_frequency_2` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): LFO frequency 2 (Hz) (0 <= `lfo_frequency_2` <= 30).
* `(unlabeled)` (`source(audio='#h,video='#i,midi='#j)`)

### ladspa.gong
```
(?id:string,?inner_damping:'a,?inner_size_1:'b,
 ?inner_size_2:'c,?inner_size_3:'d,?inner_size_4:'e,
 ?inner_stiffness_1:'f,?inner_stiffness_1__:'g,
 ?inner_stiffness_2:'h,?inner_stiffness_2__:'i,
 ?inner_stiffness_3:'j,?inner_stiffness_3__:'k,
 ?inner_stiffness_4:'l,?inner_stiffness_4__:'m,
 ?mic_position:'n,?outer_damping:'o,?outer_size_1:'p,
 ?outer_size_2:'q,?outer_size_3:'r,?outer_size_4:'s,
 ?outer_stiffness_1:'t,?outer_stiffness_1__:'u,
 ?outer_stiffness_2:'v,?outer_stiffness_2__:'w,
 ?outer_stiffness_3:'x,?outer_stiffness_3__:'y,
 ?outer_stiffness_4:'z,?outer_stiffness_4__:'aa,
 source(audio='#ab,video='#ac,midi='#ad))->
source(audio='#ab,video='#ac,midi='#ad)
where
  'a, 'aa, 'b, 'c, 'd, 'e, 'f, 'g, 'h, 'i, 'j, 'k, 'l, 'm, 'n, 'o, 'p, 'q, 'r, 's, 't, 'u, 'v, 'w, 'x, 'y, 'z is either float or ()->float```

Gong model by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `inner_damping` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Inner damping (0 <= `inner_damping` <= 1).
* `inner_size_1` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Inner size 1 (0 <= `inner_size_1` <= 1).
* `inner_size_2` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Inner size 2 (0 <= `inner_size_2` <= 1).
* `inner_size_3` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Inner size 3 (0 <= `inner_size_3` <= 1).
* `inner_size_4` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Inner size 4 (0 <= `inner_size_4` <= 1).
* `inner_stiffness_1` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Inner stiffness 1 + (0 <= `inner_stiffness_1` <= 1).
* `inner_stiffness_1__` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Inner stiffness 1 - (0 <= `inner_stiffness_1__` <= 1).
* `inner_stiffness_2` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Inner stiffness 2 + (0 <= `inner_stiffness_2` <= 1).
* `inner_stiffness_2__` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Inner stiffness 2 - (0 <= `inner_stiffness_2__` <= 1).
* `inner_stiffness_3` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Inner stiffness 3 + (0 <= `inner_stiffness_3` <= 1).
* `inner_stiffness_3__` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Inner stiffness 3 - (0 <= `inner_stiffness_3__` <= 1).
* `inner_stiffness_4` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Inner stiffness 4 + (0 <= `inner_stiffness_4` <= 1).
* `inner_stiffness_4__` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Inner stiffness 4 - (0 <= `inner_stiffness_4__` <= 1).
* `mic_position` (```
anything that is either float or ()->float```
 -- defaults to `0.25`): Mic position (0 <= `mic_position` <= 1).
* `outer_damping` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Outer damping (0 <= `outer_damping` <= 1).
* `outer_size_1` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Outer size 1 (0 <= `outer_size_1` <= 1).
* `outer_size_2` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Outer size 2 (0 <= `outer_size_2` <= 1).
* `outer_size_3` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Outer size 3 (0 <= `outer_size_3` <= 1).
* `outer_size_4` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Outer size 4 (0 <= `outer_size_4` <= 1).
* `outer_stiffness_1` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Outer stiffness 1 + (0 <= `outer_stiffness_1` <= 1).
* `outer_stiffness_1__` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Outer stiffness 1 - (0 <= `outer_stiffness_1__` <= 1).
* `outer_stiffness_2` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Outer stiffness 2 + (0 <= `outer_stiffness_2` <= 1).
* `outer_stiffness_2__` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Outer stiffness 2 - (0 <= `outer_stiffness_2__` <= 1).
* `outer_stiffness_3` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Outer stiffness 3 + (0 <= `outer_stiffness_3` <= 1).
* `outer_stiffness_3__` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Outer stiffness 3 - (0 <= `outer_stiffness_3__` <= 1).
* `outer_stiffness_4` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Outer stiffness 4 + (0 <= `outer_stiffness_4` <= 1).
* `outer_stiffness_4__` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Outer stiffness 4 - (0 <= `outer_stiffness_4__` <= 1).
* `(unlabeled)` (`source(audio='#ab,video='#ac,midi='#ad)`)

### ladspa.gongbeater
```
(?id:string,?impulse_gain:'a,?strike_duration:'b,
 ?strike_gain:'c,source(audio='#d,video='#e,midi='#f))->
source(audio='#d,video='#e,midi='#f)
where 'a, 'b, 'c is either float or ()->float```

Gong beater by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `impulse_gain` (```
anything that is either float or ()->float```
 -- defaults to `-70.0`): Impulse gain (dB) (-70 <= `impulse_gain` <= 0).
* `strike_duration` (```
anything that is either float or ()->float```
 -- defaults to `0.100500002503`): Strike duration (s) (0.001 <= `strike_duration` <= 0.2).
* `strike_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Strike gain (dB) (-70 <= `strike_gain` <= 0).
* `(unlabeled)` (`source(audio='#d,video='#e,midi='#f)`)

### ladspa.gsm
```
(?id:string,?dry_wet_mix:'a,?error_rate:'b,
 ?number_of_passes:'c,
 source(audio='#d,video='#e,midi='#f))->
source(audio='#d,video='#e,midi='#f)
where 'a, 'b is either float or ()->float,
  'c is either int or ()->int```

GSM simulator by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `dry_wet_mix` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Dry/wet mix (0 <= `dry_wet_mix` <= 1).
* `error_rate` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Error rate (bits/block) (0 <= `error_rate` <= 30).
* `number_of_passes` (`anything that is either int or ()->int` -- defaults to `1`): Number of passes (0 <= `number_of_passes` <= 10).
* `(unlabeled)` (`source(audio='#d,video='#e,midi='#f)`)

### ladspa.gverb
```
(?id:string,?damping:'a,?dry_signal_level:'b,
 ?early_reflection_level:'c,?input_bandwidth:'d,
 ?reverb_time:'e,?roomsize:'f,?tail_level:'g,
 source(audio=1,video=0,midi=0))->
source(audio=2,video=0,midi=0)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g is either float or ()->float```

GVerb by Juhana Sadeharju <kouhia at nic.funet.fi>, LADSPAification by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `damping` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Damping (0 <= `damping` <= 1).
* `dry_signal_level` (```
anything that is either float or ()->float```
 -- defaults to `-70.0`): Dry signal level (dB) (-70 <= `dry_signal_level` <= 0).
* `early_reflection_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Early reflection level (dB) (-70 <= `early_reflection_level` <= 0).
* `input_bandwidth` (```
anything that is either float or ()->float```
 -- defaults to `0.75`): Input bandwidth (0 <= `input_bandwidth` <= 1).
* `reverb_time` (```
anything that is either float or ()->float```
 -- defaults to `7.57499980927`): Reverb time (s) (0.1 <= `reverb_time` <= 30).
* `roomsize` (```
anything that is either float or ()->float```
 -- defaults to `75.75`): Roomsize (m) (1 <= `roomsize` <= 300).
* `tail_level` (```
anything that is either float or ()->float```
 -- defaults to `-17.5`): Tail level (dB) (-70 <= `tail_level` <= 0).
* `(unlabeled)` (`source(audio=1,video=0,midi=0)`)

### ladspa.hardlimiter
```
(?id:string,?db_limit:'a,?residue_level:'b,?wet_level:'c,
 source(audio='#d,video='#e,midi='#f))->
source(audio='#d,video='#e,midi='#f)
where 'a, 'b, 'c is either float or ()->float```

Hard Limiter by Marcus Andersson.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `db_limit` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): dB limit (-50 <= `db_limit` <= 0).
* `residue_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Residue level (0 <= `residue_level` <= 1).
* `wet_level` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Wet level (0 <= `wet_level` <= 1).
* `(unlabeled)` (`source(audio='#d,video='#e,midi='#f)`)

### ladspa.harmonicgen
```
(?id:string,?_10th_harmonic_magnitude:'a,
 ?_2nd_harmonic_magnitude:'b,?_3rd_harmonic_magnitude:'c,
 ?_4th_harmonic_magnitude:'d,?_5th_harmonic_magnitude:'e,
 ?_6th_harmonic_magnitude:'f,?_7th_harmonic_magnitude:'g,
 ?_8th_harmonic_magnitude:'h,?_9th_harmonic_magnitude:'i,
 ?fundamental_magnitude:'j,
 source(audio='#k,video='#l,midi='#m))->
source(audio='#k,video='#l,midi='#m)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g, 'h, 'i, 'j is either float or ()->float```

Harmonic generator by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `_10th_harmonic_magnitude` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 10th harmonic magnitude (-1 <= `_10th_harmonic_magnitude` <= 1).
* `_2nd_harmonic_magnitude` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 2nd harmonic magnitude (-1 <= `_2nd_harmonic_magnitude` <= 1).
* `_3rd_harmonic_magnitude` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 3rd harmonic magnitude (-1 <= `_3rd_harmonic_magnitude` <= 1).
* `_4th_harmonic_magnitude` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 4th harmonic magnitude (-1 <= `_4th_harmonic_magnitude` <= 1).
* `_5th_harmonic_magnitude` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 5th harmonic magnitude (-1 <= `_5th_harmonic_magnitude` <= 1).
* `_6th_harmonic_magnitude` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 6th harmonic magnitude (-1 <= `_6th_harmonic_magnitude` <= 1).
* `_7th_harmonic_magnitude` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 7th harmonic magnitude (-1 <= `_7th_harmonic_magnitude` <= 1).
* `_8th_harmonic_magnitude` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 8th harmonic magnitude (-1 <= `_8th_harmonic_magnitude` <= 1).
* `_9th_harmonic_magnitude` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 9th harmonic magnitude (-1 <= `_9th_harmonic_magnitude` <= 1).
* `fundamental_magnitude` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Fundamental magnitude (-1 <= `fundamental_magnitude` <= 1).
* `(unlabeled)` (`source(audio='#k,video='#l,midi='#m)`)

### ladspa.hermesfilter
```
(?id:string,?band_1_gain:'a,?band_2_gain:'b,
 ?band_3_gain:'c,?delay1_feedback:'d,?delay1_length:'e,
 ?delay1_wetness:'f,?delay2_feedback:'g,
 ?delay2_length:'h,?delay2_wetness:'i,
 ?delay3_feedback:'j,?delay3_length:'k,
 ?delay3_wetness:'l,?dist1_drive:'m,?dist2_drive:'n,
 ?dist3_drive:'o,?filt1_freq:'p,?filt1_lfo1_level:'q,
 ?filt1_lfo2_level:'r,?filt1_q:'s,?filt1_resonance:'t,
 ?filt1_type:'u,?filt2_freq:'v,?filt2_lfo1_level:'w,
 ?filt2_lfo2_level:'x,?filt2_q:'y,?filt2_resonance:'z,
 ?filt2_type:'aa,?filt3_freq:'ab,?filt3_lfo1_level:'ac,
 ?filt3_lfo2_level:'ad,?filt3_q:'ae,?filt3_resonance:'af,
 ?filt3_type:'ag,?input_gain:'ah,?lfo1_freq:'ai,
 ?lfo1_wave:'aj,?lfo2_freq:'ak,?lfo2_wave:'al,
 ?osc1_freq:'am,?osc1_gain:'an,?osc1_wave:'ao,
 ?osc2_freq:'ap,?osc2_gain:'aq,?osc2_wave:'ar,
 ?ringmod_1_depth:'as,?ringmod_2_depth:'at,
 ?ringmod_3_depth:'au,?rm1_gain:'av,?rm2_gain:'aw,
 ?rm3_gain:'ax,?xover_lower_freq:'ay,
 ?xover_upper_freq:'az,
 source(audio='#ba,video='#bb,midi='#bc))->
source(audio='#ba,video='#bb,midi='#bc)
where
  'a, 'ab, 'ac, 'ad, 'ae, 'af, 'ah, 'ai, 'ak, 'am, 'an, 'ap, 'aq, 'as, 'at, 'au, 'av, 'aw, 'ax, 'ay, 'az, 'b, 'c, 'd, 'e, 'f, 'g, 'h, 'i, 'j, 'k, 'l, 'm, 'n, 'o, 'p, 'q, 'r, 's, 't, 'v, 'w, 'x, 'y, 'z is either float or ()->float,
  'aa, 'ag, 'aj, 'al, 'ao, 'ar, 'u is either int or ()->int```

Hermes Filter by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `band_1_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Band 1 gain (dB) (-70 <= `band_1_gain` <= 20).
* `band_2_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Band 2 gain (dB) (-70 <= `band_2_gain` <= 20).
* `band_3_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Band 3 gain (dB) (-70 <= `band_3_gain` <= 20).
* `delay1_feedback` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Delay1 feedback (0 <= `delay1_feedback` <= 1).
* `delay1_length` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Delay1 length (s) (0 <= `delay1_length` <= 2).
* `delay1_wetness` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Delay1 wetness (0 <= `delay1_wetness` <= 1).
* `delay2_feedback` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Delay2 feedback (0 <= `delay2_feedback` <= 1).
* `delay2_length` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Delay2 length (s) (0 <= `delay2_length` <= 2).
* `delay2_wetness` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Delay2 wetness (0 <= `delay2_wetness` <= 1).
* `delay3_feedback` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Delay3 feedback (0 <= `delay3_feedback` <= 1).
* `delay3_length` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Delay3 length (s) (0 <= `delay3_length` <= 2).
* `delay3_wetness` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Delay3 wetness (0 <= `delay3_wetness` <= 1).
* `dist1_drive` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Dist1 drive (0 <= `dist1_drive` <= 3).
* `dist2_drive` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Dist2 drive (0 <= `dist2_drive` <= 3).
* `dist3_drive` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Dist3 drive (0 <= `dist3_drive` <= 3).
* `filt1_freq` (```
anything that is either float or ()->float```
 -- defaults to `440.0`): Filt1 freq (0 <= `filt1_freq` <= 8000).
* `filt1_lfo1_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Filt1 LFO1 level (-500 <= `filt1_lfo1_level` <= 500).
* `filt1_lfo2_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Filt1 LFO2 level (-500 <= `filt1_lfo2_level` <= 500).
* `filt1_q` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Filt1 q (0 <= `filt1_q` <= 1).
* `filt1_resonance` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Filt1 resonance (0 <= `filt1_resonance` <= 1).
* `filt1_type` (`anything that is either int or ()->int` -- defaults to `0`): Filt1 type (0=none, 1=LP, 2=HP, 3=BP, 4=BR, 5=AP) (0 <= `filt1_type` <= 5).
* `filt2_freq` (```
anything that is either float or ()->float```
 -- defaults to `440.0`): Filt2 freq (0 <= `filt2_freq` <= 8000).
* `filt2_lfo1_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Filt2 LFO1 level (-500 <= `filt2_lfo1_level` <= 500).
* `filt2_lfo2_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Filt2 LFO2 level (-500 <= `filt2_lfo2_level` <= 500).
* `filt2_q` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Filt2 q (0 <= `filt2_q` <= 1).
* `filt2_resonance` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Filt2 resonance (0 <= `filt2_resonance` <= 1).
* `filt2_type` (`anything that is either int or ()->int` -- defaults to `0`): Filt2 type (0=none, 1=LP, 2=HP, 3=BP, 4=BR, 5=AP) (0 <= `filt2_type` <= 5).
* `filt3_freq` (```
anything that is either float or ()->float```
 -- defaults to `440.0`): Filt3 freq (0 <= `filt3_freq` <= 8000).
* `filt3_lfo1_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Filt3 LFO1 level (-500 <= `filt3_lfo1_level` <= 500).
* `filt3_lfo2_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Filt3 LFO2 level (-500 <= `filt3_lfo2_level` <= 500).
* `filt3_q` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Filt3 q (0 <= `filt3_q` <= 1).
* `filt3_resonance` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Filt3 resonance (0 <= `filt3_resonance` <= 1).
* `filt3_type` (`anything that is either int or ()->int` -- defaults to `0`): Filt3 type (0=none, 1=LP, 2=HP, 3=BP, 4=BR, 5=AP) (0 <= `filt3_type` <= 5).
* `input_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Input gain (dB) (-70 <= `input_gain` <= 20).
* `lfo1_freq` (```
anything that is either float or ()->float```
 -- defaults to `250.0`): LFO1 freq (Hz) (0 <= `lfo1_freq` <= 1000).
* `lfo1_wave` (`anything that is either int or ()->int` -- defaults to `0`): LFO1 wave (0 = sin, 1 = tri, 2 = saw, 3 = squ, 4 = s&h) (0 <= `lfo1_wave` <= 4).
* `lfo2_freq` (```
anything that is either float or ()->float```
 -- defaults to `250.0`): LFO2 freq (Hz) (0 <= `lfo2_freq` <= 1000).
* `lfo2_wave` (`anything that is either int or ()->int` -- defaults to `0`): LFO2 wave (0 = sin, 1 = tri, 2 = saw, 3 = squ, 4 = s&h) (0 <= `lfo2_wave` <= 4).
* `osc1_freq` (```
anything that is either float or ()->float```
 -- defaults to `440.0`): Osc1 freq (Hz) (0 <= `osc1_freq` <= 4000).
* `osc1_gain` (```
anything that is either float or ()->float```
 -- defaults to `-70.0`): Osc1 gain (dB) (-70 <= `osc1_gain` <= 20).
* `osc1_wave` (`anything that is either int or ()->int` -- defaults to `0`): Osc1 wave (0 = sin, 1 = tri, 2 = saw, 3 = squ, 4 = noise) (0 <= `osc1_wave` <= 4).
* `osc2_freq` (```
anything that is either float or ()->float```
 -- defaults to `440.0`): Osc2 freq (Hz) (0 <= `osc2_freq` <= 4000).
* `osc2_gain` (```
anything that is either float or ()->float```
 -- defaults to `-70.0`): Osc2 gain (dB) (-70 <= `osc2_gain` <= 20).
* `osc2_wave` (`anything that is either int or ()->int` -- defaults to `0`): Osc2 wave (0 = sin, 1 = tri, 2 = saw, 3 = squ, 4 = noise) (0 <= `osc2_wave` <= 4).
* `ringmod_1_depth` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Ringmod 1 depth (0=none, 1=AM, 2=RM) (0 <= `ringmod_1_depth` <= 2).
* `ringmod_2_depth` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Ringmod 2 depth (0=none, 1=AM, 2=RM) (0 <= `ringmod_2_depth` <= 2).
* `ringmod_3_depth` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Ringmod 3 depth (0=none, 1=AM, 2=RM) (0 <= `ringmod_3_depth` <= 2).
* `rm1_gain` (```
anything that is either float or ()->float```
 -- defaults to `-70.0`): RM1 gain (dB) (-70 <= `rm1_gain` <= 20).
* `rm2_gain` (```
anything that is either float or ()->float```
 -- defaults to `-70.0`): RM2 gain (dB) (-70 <= `rm2_gain` <= 20).
* `rm3_gain` (```
anything that is either float or ()->float```
 -- defaults to `-70.0`): RM3 gain (dB) (-70 <= `rm3_gain` <= 20).
* `xover_lower_freq` (```
anything that is either float or ()->float```
 -- defaults to `1537.5`): Xover lower freq (50 <= `xover_lower_freq` <= 6000).
* `xover_upper_freq` (```
anything that is either float or ()->float```
 -- defaults to `7750.0`): Xover upper freq (1000 <= `xover_upper_freq` <= 10000).
* `(unlabeled)` (`source(audio='#ba,video='#bb,midi='#bc)`)

### ladspa.highpass_iir
```
(?id:string,?cutoff_frequency:'a,?stages:'b,
 source(audio='#c,video='#d,midi='#e))->
source(audio='#c,video='#d,midi='#e)
where 'a is either float or ()->float,
  'b is either int or ()->int```

Glame Highpass Filter by Alexander Ehlert <mag(at)glame.de>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `cutoff_frequency` (```
anything that is either float or ()->float```
 -- defaults to `36.1194992065`): Cutoff Frequency (4.41 <= `cutoff_frequency` <= 19845).
* `stages` (`anything that is either int or ()->int` -- defaults to `1`): Stages(2 poles per stage) (1 <= `stages` <= 10).
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

### ladspa.hilbert
```
(?id:string,source(audio=1,video=0,midi=0))->
source(audio=2,video=0,midi=0)```

Hilbert transformer by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio=1,video=0,midi=0)`)

### ladspa.imp
```
(?id:string,?gain:'a,?high_latency_mode:'b,
 ?impulse_id:'c,source(audio='#d,video='#e,midi='#f))->
source(audio='#d,video='#e,midi='#f)
where 'a is either float or ()->float,
  'b, 'c is either int or ()->int```

Impulse convolver by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Gain (dB) (-90 <= `gain` <= 24).
* `high_latency_mode` (`anything that is either int or ()->int` -- defaults to `0`): High latency mode (0 <= `high_latency_mode` <= 1).
* `impulse_id` (`anything that is either int or ()->int` -- defaults to `1`): Impulse ID (1 <= `impulse_id` <= 21).
* `(unlabeled)` (`source(audio='#d,video='#e,midi='#f)`)

### ladspa.impulse_fc
```
(?id:string,frequency:'a)->source(audio=1,video=0,midi=0)
where 'a is either float or ()->float```

Nonbandlimited single-sample impulses (Frequency: Control) by Andy Wingo <wingo at pobox dot com>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (```
anything that is either float or ()->float```
): Frequency (Hz) (0 <= `frequency`).

### ladspa.inv
```
(?id:string,source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Inverter by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### ladspa.karaoke
```
(?id:string,?vocal_volume:'a,
 source(audio=2,video=0,midi=0))->
source(audio=2,video=0,midi=0)
where 'a is either float or ()->float```

Karaoke by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `vocal_volume` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Vocal volume (dB) (-70 <= `vocal_volume` <= 0).
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

### ladspa.lcrdelay
```
(?id:string,?c_delay:'a,?c_level:'b,?dry_wet_level:'c,
 ?feedback:'d,?high_damp:'e,?l_delay:'f,?l_level:'g,
 ?low_damp:'h,?r_delay:'i,?r_level:'j,?spread:'k,
 source(audio=2,video=0,midi=0))->
source(audio=2,video=0,midi=0)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g, 'h, 'i, 'j, 'k is either float or ()->float```

L/C/R Delay by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `c_delay` (```
anything that is either float or ()->float```
 -- defaults to `675.0`): C delay (ms) (0 <= `c_delay` <= 2700).
* `c_level` (```
anything that is either float or ()->float```
 -- defaults to `25.0`): C level (0 <= `c_level` <= 50).
* `dry_wet_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Dry/Wet level (0 <= `dry_wet_level` <= 1).
* `feedback` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Feedback (-100 <= `feedback` <= 100).
* `high_damp` (```
anything that is either float or ()->float```
 -- defaults to `50.0`): High damp (%) (0 <= `high_damp` <= 100).
* `l_delay` (```
anything that is either float or ()->float```
 -- defaults to `675.0`): L delay (ms) (0 <= `l_delay` <= 2700).
* `l_level` (```
anything that is either float or ()->float```
 -- defaults to `25.0`): L level (0 <= `l_level` <= 50).
* `low_damp` (```
anything that is either float or ()->float```
 -- defaults to `50.0`): Low damp (%) (0 <= `low_damp` <= 100).
* `r_delay` (```
anything that is either float or ()->float```
 -- defaults to `675.0`): R delay (ms) (0 <= `r_delay` <= 2700).
* `r_level` (```
anything that is either float or ()->float```
 -- defaults to `25.0`): R level (0 <= `r_level` <= 50).
* `spread` (```
anything that is either float or ()->float```
 -- defaults to `25.0`): Spread (0 <= `spread` <= 50).
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

### ladspa.lfophaser
```
(?id:string,?feedback:'a,?lfo_depth:'b,?lfo_rate:'c,
 ?spread:'d,source(audio='#e,video='#f,midi='#g))->
source(audio='#e,video='#f,midi='#g)
where 'a, 'b, 'c, 'd is either float or ()->float```

LFO Phaser by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `feedback` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Feedback (-1 <= `feedback` <= 1).
* `lfo_depth` (```
anything that is either float or ()->float```
 -- defaults to `0.25`): LFO depth (0 <= `lfo_depth` <= 1).
* `lfo_rate` (```
anything that is either float or ()->float```
 -- defaults to `25.0`): LFO rate (Hz) (0 <= `lfo_rate` <= 100).
* `spread` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Spread (octaves) (0 <= `spread` <= 2).
* `(unlabeled)` (`source(audio='#e,video='#f,midi='#g)`)

### ladspa.lowpass_iir
```
(?id:string,?cutoff_frequency:'a,?stages:'b,
 source(audio='#c,video='#d,midi='#e))->
source(audio='#c,video='#d,midi='#e)
where 'a is either float or ()->float,
  'b is either int or ()->int```

Glame Lowpass Filter by Alexander Ehlert <mag(at)glame.de>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `cutoff_frequency` (```
anything that is either float or ()->float```
 -- defaults to `2422.96972656`): Cutoff Frequency (4.41 <= `cutoff_frequency` <= 19845).
* `stages` (`anything that is either int or ()->int` -- defaults to `1`): Stages(2 poles per stage) (1 <= `stages` <= 10).
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

### ladspa.lsfilter
```
(?id:string,?cutoff_frequency:'a,?filter_type:'b,
 ?resonance:'c,source(audio='#d,video='#e,midi='#f))->
source(audio='#d,video='#e,midi='#f)
where 'a, 'c is either float or ()->float,
  'b is either int or ()->int```

LS Filter by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `cutoff_frequency` (```
anything that is either float or ()->float```
 -- defaults to `1394.56445312`): Cutoff frequency (Hz) (88.2 <= `cutoff_frequency` <= 22050).
* `filter_type` (`anything that is either int or ()->int` -- defaults to `0`): Filter type (0=LP, 1=BP, 2=HP) (0 <= `filter_type` <= 2).
* `resonance` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Resonance (0 <= `resonance` <= 1).
* `(unlabeled)` (`source(audio='#d,video='#e,midi='#f)`)

### ladspa.matrixmsst
```
(?id:string,?width:'a,source(audio=2,video=0,midi=0))->
source(audio=2,video=0,midi=0)
where 'a is either float or ()->float```

Matrix: MS to Stereo by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `width` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Width (0 <= `width` <= 2).
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

### ladspa.matrixspatialiser
```
(?id:string,?width:'a,source(audio=2,video=0,midi=0))->
source(audio=2,video=0,midi=0)
where 'a is either int or ()->int```

Matrix Spatialiser by Joern Nettingsmeier <nettings(at)folkwang-hochschule.de>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `width` (`anything that is either int or ()->int` -- defaults to `0`): Width (-512 <= `width` <= 512).
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

### ladspa.matrixstms
```
(?id:string,source(audio=2,video=0,midi=0))->
source(audio=2,video=0,midi=0)```

Matrix: Stereo to MS by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

### ladspa.mbeq
```
(?id:string,?_10000hz_gain:'a,?_100hz_gain:'b,
 ?_1250hz_gain:'c,?_156hz_gain:'d,?_1750hz_gain:'e,
 ?_20000hz_gain:'f,?_220hz_gain:'g,?_2500hz_gain:'h,
 ?_311hz_gain:'i,?_3500hz_gain:'j,?_440hz_gain:'k,
 ?_5000hz_gain:'l,?_50hz_gain:'m,?_622hz_gain:'n,
 ?_880hz_gain:'o,source(audio='#p,video='#q,midi='#r))->
source(audio='#p,video='#q,midi='#r)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g, 'h, 'i, 'j, 'k, 'l, 'm, 'n, 'o is either float or ()->float```

Multiband EQ by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `_10000hz_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 10000Hz gain (-70 <= `_10000hz_gain` <= 30).
* `_100hz_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 100Hz gain (-70 <= `_100hz_gain` <= 30).
* `_1250hz_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 1250Hz gain (-70 <= `_1250hz_gain` <= 30).
* `_156hz_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 156Hz gain (-70 <= `_156hz_gain` <= 30).
* `_1750hz_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 1750Hz gain (-70 <= `_1750hz_gain` <= 30).
* `_20000hz_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 20000Hz gain (-70 <= `_20000hz_gain` <= 30).
* `_220hz_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 220Hz gain (-70 <= `_220hz_gain` <= 30).
* `_2500hz_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 2500Hz gain (-70 <= `_2500hz_gain` <= 30).
* `_311hz_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 311Hz gain (-70 <= `_311hz_gain` <= 30).
* `_3500hz_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 3500Hz gain (-70 <= `_3500hz_gain` <= 30).
* `_440hz_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 440Hz gain (-70 <= `_440hz_gain` <= 30).
* `_5000hz_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 5000Hz gain (-70 <= `_5000hz_gain` <= 30).
* `_50hz_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 50Hz gain (low shelving) (-70 <= `_50hz_gain` <= 30).
* `_622hz_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 622Hz gain (-70 <= `_622hz_gain` <= 30).
* `_880hz_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 880Hz gain (-70 <= `_880hz_gain` <= 30).
* `(unlabeled)` (`source(audio='#p,video='#q,midi='#r)`)

### ladspa.moddelay
```
(?id:string,?base_delay:'a,
 source(audio=2,video=0,midi=0))->
source(audio=1,video=0,midi=0)
where 'a is either float or ()->float```

Modulatable delay by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `base_delay` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Base delay (s) (0 <= `base_delay` <= 1).
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

### ladspa.multivoicechorus
```
(?id:string,?delay_base:'a,?detune:'b,?lfo_frequency:'c,
 ?number_of_voices:'d,?output_attenuation:'e,
 ?voice_separation:'f,
 source(audio='#g,video='#h,midi='#i))->
source(audio='#g,video='#h,midi='#i)
where 'a, 'b, 'c, 'e, 'f is either float or ()->float,
  'd is either int or ()->int```

Multivoice Chorus by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `delay_base` (```
anything that is either float or ()->float```
 -- defaults to `10.0`): Delay base (ms) (10 <= `delay_base` <= 40).
* `detune` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Detune (%) (0 <= `detune` <= 5).
* `lfo_frequency` (```
anything that is either float or ()->float```
 -- defaults to `9.0`): LFO frequency (Hz) (2 <= `lfo_frequency` <= 30).
* `number_of_voices` (`anything that is either int or ()->int` -- defaults to `1`): Number of voices (1 <= `number_of_voices` <= 8).
* `output_attenuation` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Output attenuation (dB) (-20 <= `output_attenuation` <= 0).
* `voice_separation` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Voice separation (ms) (0 <= `voice_separation` <= 2).
* `(unlabeled)` (`source(audio='#g,video='#h,midi='#i)`)

### ladspa.notch_iir
```
(?id:string,?bandwidth:'a,?center_frequency:'b,
 ?stages:'c,source(audio='#d,video='#e,midi='#f))->
source(audio='#d,video='#e,midi='#f)
where 'a, 'b is either float or ()->float,
  'c is either int or ()->int```

Mag's Notch Filter by Alexander Ehlert <mag(at)glame.de>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `bandwidth` (```
anything that is either float or ()->float```
 -- defaults to `295.831787109`): Bandwidth (Hz) (4.41 <= `bandwidth` <= 19845).
* `center_frequency` (```
anything that is either float or ()->float```
 -- defaults to `295.831787109`): Center Frequency (Hz) (4.41 <= `center_frequency` <= 19845).
* `stages` (`anything that is either int or ()->int` -- defaults to `1`): Stages(2 poles per stage) (1 <= `stages` <= 10).
* `(unlabeled)` (`source(audio='#d,video='#e,midi='#f)`)

### ladspa.pitchscale
```
(?id:string,?pitch_co_efficient:'a,
 source(audio='#b,video='#c,midi='#d))->
source(audio='#b,video='#c,midi='#d)
where 'a is either float or ()->float```

Pitch Scaler by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `pitch_co_efficient` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Pitch co-efficient (0.5 <= `pitch_co_efficient` <= 2).
* `(unlabeled)` (`source(audio='#b,video='#c,midi='#d)`)

### ladspa.pitchscalehq
```
(?id:string,?pitch_co_efficient:'a,
 source(audio='#b,video='#c,midi='#d))->
source(audio='#b,video='#c,midi='#d)
where 'a is either float or ()->float```

Higher Quality Pitch Scaler by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `pitch_co_efficient` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Pitch co-efficient (0.5 <= `pitch_co_efficient` <= 2).
* `(unlabeled)` (`source(audio='#b,video='#c,midi='#d)`)

### ladspa.plate
```
(?id:string,?damping:'a,?dry_wet_mix:'b,?reverb_time:'c,
 source(audio=1,video=0,midi=0))->
source(audio=2,video=0,midi=0)
where 'a, 'b, 'c is either float or ()->float```

Plate reverb by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `damping` (```
anything that is either float or ()->float```
 -- defaults to `0.25`): Damping (0 <= `damping` <= 1).
* `dry_wet_mix` (```
anything that is either float or ()->float```
 -- defaults to `0.25`): Dry/wet mix (0 <= `dry_wet_mix` <= 1).
* `reverb_time` (```
anything that is either float or ()->float```
 -- defaults to `4.25500011444`): Reverb time (0.01 <= `reverb_time` <= 8.5).
* `(unlabeled)` (`source(audio=1,video=0,midi=0)`)

### ladspa.pointercastdistortion
```
(?id:string,?dry_wet_mix:'a,?effect_cutoff_freq:'b,
 source(audio='#c,video='#d,midi='#e))->
source(audio='#c,video='#d,midi='#e)
where 'a, 'b is either float or ()->float```

Pointer cast distortion by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `dry_wet_mix` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Dry/wet mix (0 <= `dry_wet_mix` <= 1).
* `effect_cutoff_freq` (```
anything that is either float or ()->float```
 -- defaults to `32.6376495361`): Effect cutoff freq (Hz) (4.41 <= `effect_cutoff_freq` <= 13230).
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

### ladspa.rateshifter
```
(?id:string,?rate:'a,
 source(audio='#b,video='#c,midi='#d))->
source(audio='#b,video='#c,midi='#d)
where 'a is either float or ()->float```

Rate shifter by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `rate` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Rate (-4 <= `rate` <= 4).
* `(unlabeled)` (`source(audio='#b,video='#c,midi='#d)`)

### ladspa.retroflange
```
(?id:string,?average_stall:'a,?flange_frequency:'b,
 source(audio='#c,video='#d,midi='#e))->
source(audio='#c,video='#d,midi='#e)
where 'a, 'b is either float or ()->float```

Retro Flanger by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `average_stall` (```
anything that is either float or ()->float```
 -- defaults to `2.5`): Average stall (ms) (0 <= `average_stall` <= 10).
* `flange_frequency` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Flange frequency (Hz) (0.5 <= `flange_frequency` <= 8).
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

### ladspa.revdelay
```
(?id:string,?crossfade_samples:'a,?delay_time:'b,
 ?dry_level:'c,?feedback:'d,?wet_level:'e,
 source(audio='#f,video='#g,midi='#h))->
source(audio='#f,video='#g,midi='#h)
where 'b, 'c, 'd, 'e is either float or ()->float,
  'a is either int or ()->int```

Reverse Delay (5s max) by Jesse Chappell <jesse at essej dot net>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `crossfade_samples` (`anything that is either int or ()->int` -- defaults to `1250`): Crossfade samples (0 <= `crossfade_samples` <= 5000).
* `delay_time` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Delay Time (s) (0 <= `delay_time` <= 5).
* `dry_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Dry Level (dB) (-70 <= `dry_level` <= 0).
* `feedback` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Feedback (0 <= `feedback` <= 1).
* `wet_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Wet Level (dB) (-70 <= `wet_level` <= 0).
* `(unlabeled)` (`source(audio='#f,video='#g,midi='#h)`)

### ladspa.ringmod_1i1o1l
```
(?id:string,?frequency:'a,?modulation_depth:'b,
 ?sawtooth_level:'c,?sine_level:'d,?square_level:'e,
 ?triangle_level:'f,source(audio='#g,video='#h,midi='#i))->
source(audio='#g,video='#h,midi='#i)
where 'a, 'b, 'c, 'd, 'e, 'f is either float or ()->float```

Ringmod with LFO by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (```
anything that is either float or ()->float```
 -- defaults to `440.0`): Frequency (Hz) (1 <= `frequency` <= 1000).
* `modulation_depth` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Modulation depth (0=none, 1=AM, 2=RM) (0 <= `modulation_depth` <= 2).
* `sawtooth_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Sawtooth level (-1 <= `sawtooth_level` <= 1).
* `sine_level` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Sine level (-1 <= `sine_level` <= 1).
* `square_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Square level (-1 <= `square_level` <= 1).
* `triangle_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Triangle level (-1 <= `triangle_level` <= 1).
* `(unlabeled)` (`source(audio='#g,video='#h,midi='#i)`)

### ladspa.ringmod_2i1o
```
(?id:string,?modulation_depth:'a,
 source(audio=2,video=0,midi=0))->
source(audio=1,video=0,midi=0)
where 'a is either float or ()->float```

Ringmod with two inputs by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `modulation_depth` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Modulation depth (0=none, 1=AM, 2=RM) (0 <= `modulation_depth` <= 2).
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

### ladspa.satanmaximiser
```
(?id:string,?decay_time:'a,?knee_point:'b,
 source(audio='#c,video='#d,midi='#e))->
source(audio='#c,video='#d,midi='#e)
where 'a, 'b is either float or ()->float```

Barry's Satan Maximiser by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `decay_time` (```
anything that is either float or ()->float```
 -- defaults to `30.0`): Decay time (samples) (2 <= `decay_time` <= 30).
* `knee_point` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Knee point (dB) (-90 <= `knee_point` <= 0).
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

### ladspa.sc1
```
(?id:string,?attack_time:'a,?knee_radius:'b,
 ?makeup_gain:'c,?ratio:'d,?release_time:'e,
 ?threshold_level:'f,
 source(audio='#g,video='#h,midi='#i))->
source(audio='#g,video='#h,midi='#i)
where 'a, 'b, 'c, 'd, 'e, 'f is either float or ()->float```

SC1 by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `attack_time` (```
anything that is either float or ()->float```
 -- defaults to `101.5`): Attack time (ms) (2 <= `attack_time` <= 400).
* `knee_radius` (```
anything that is either float or ()->float```
 -- defaults to `3.25`): Knee radius (dB) (1 <= `knee_radius` <= 10).
* `makeup_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Makeup gain (dB) (0 <= `makeup_gain` <= 24).
* `ratio` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Ratio (1:n) (1 <= `ratio` <= 10).
* `release_time` (```
anything that is either float or ()->float```
 -- defaults to `401.0`): Release time (ms) (2 <= `release_time` <= 800).
* `threshold_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Threshold level (dB) (-30 <= `threshold_level` <= 0).
* `(unlabeled)` (`source(audio='#g,video='#h,midi='#i)`)

### ladspa.sc2
```
(?id:string,?attack_time:'a,?knee_radius:'b,
 ?makeup_gain:'c,?ratio:'d,?release_time:'e,
 ?threshold_level:'f,source(audio=2,video=0,midi=0))->
source(audio=1,video=0,midi=0)
where 'a, 'b, 'c, 'd, 'e, 'f is either float or ()->float```

SC2 by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `attack_time` (```
anything that is either float or ()->float```
 -- defaults to `101.5`): Attack time (ms) (2 <= `attack_time` <= 400).
* `knee_radius` (```
anything that is either float or ()->float```
 -- defaults to `3.25`): Knee radius (dB) (1 <= `knee_radius` <= 10).
* `makeup_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Makeup gain (dB) (0 <= `makeup_gain` <= 24).
* `ratio` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Ratio (1:n) (1 <= `ratio` <= 10).
* `release_time` (```
anything that is either float or ()->float```
 -- defaults to `401.0`): Release time (ms) (2 <= `release_time` <= 800).
* `threshold_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Threshold level (dB) (-30 <= `threshold_level` <= 0).
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

### ladspa.sc3
```
(?id:string,?attack_time:'a,?chain_balance:'b,
 ?knee_radius:'c,?makeup_gain:'d,?ratio:'e,
 ?release_time:'f,?threshold_level:'g,
 source(audio=3,video=0,midi=0))->
source(audio=2,video=0,midi=0)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g is either float or ()->float```

SC3 by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `attack_time` (```
anything that is either float or ()->float```
 -- defaults to `101.5`): Attack time (ms) (2 <= `attack_time` <= 400).
* `chain_balance` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Chain balance (0 <= `chain_balance` <= 1).
* `knee_radius` (```
anything that is either float or ()->float```
 -- defaults to `3.25`): Knee radius (dB) (1 <= `knee_radius` <= 10).
* `makeup_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Makeup gain (dB) (0 <= `makeup_gain` <= 24).
* `ratio` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Ratio (1:n) (1 <= `ratio` <= 10).
* `release_time` (```
anything that is either float or ()->float```
 -- defaults to `401.0`): Release time (ms) (2 <= `release_time` <= 800).
* `threshold_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Threshold level (dB) (-30 <= `threshold_level` <= 0).
* `(unlabeled)` (`source(audio=3,video=0,midi=0)`)

### ladspa.sc4
```
(?id:string,?attack_time:'a,?knee_radius:'b,
 ?makeup_gain:'c,?ratio:'d,?release_time:'e,?rms_peak:'f,
 ?threshold_level:'g,source(audio=2,video=0,midi=0))->
source(audio=2,video=0,midi=0)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g is either float or ()->float```

SC4 by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `attack_time` (```
anything that is either float or ()->float```
 -- defaults to `101.125`): Attack time (ms) (1.5 <= `attack_time` <= 400).
* `knee_radius` (```
anything that is either float or ()->float```
 -- defaults to `3.25`): Knee radius (dB) (1 <= `knee_radius` <= 10).
* `makeup_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Makeup gain (dB) (0 <= `makeup_gain` <= 24).
* `ratio` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Ratio (1:n) (1 <= `ratio` <= 20).
* `release_time` (```
anything that is either float or ()->float```
 -- defaults to `401.0`): Release time (ms) (2 <= `release_time` <= 800).
* `rms_peak` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): RMS/peak (0 <= `rms_peak` <= 1).
* `threshold_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Threshold level (dB) (-30 <= `threshold_level` <= 0).
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

### ladspa.sc4m
```
(?id:string,?attack_time:'a,?knee_radius:'b,
 ?makeup_gain:'c,?ratio:'d,?release_time:'e,?rms_peak:'f,
 ?threshold_level:'g,
 source(audio='#h,video='#i,midi='#j))->
source(audio='#h,video='#i,midi='#j)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g is either float or ()->float```

SC4 mono by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `attack_time` (```
anything that is either float or ()->float```
 -- defaults to `101.125`): Attack time (ms) (1.5 <= `attack_time` <= 400).
* `knee_radius` (```
anything that is either float or ()->float```
 -- defaults to `3.25`): Knee radius (dB) (1 <= `knee_radius` <= 10).
* `makeup_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Makeup gain (dB) (0 <= `makeup_gain` <= 24).
* `ratio` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Ratio (1:n) (1 <= `ratio` <= 20).
* `release_time` (```
anything that is either float or ()->float```
 -- defaults to `401.0`): Release time (ms) (2 <= `release_time` <= 800).
* `rms_peak` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): RMS/peak (0 <= `rms_peak` <= 1).
* `threshold_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Threshold level (dB) (-30 <= `threshold_level` <= 0).
* `(unlabeled)` (`source(audio='#h,video='#i,midi='#j)`)

### ladspa.se4
```
(?id:string,?attack_time:'a,?attenuation:'b,
 ?knee_radius:'c,?ratio:'d,?release_time:'e,?rms_peak:'f,
 ?threshold_level:'g,source(audio=2,video=0,midi=0))->
source(audio=2,video=0,midi=0)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g is either float or ()->float```

SE4 by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `attack_time` (```
anything that is either float or ()->float```
 -- defaults to `101.125`): Attack time (ms) (1.5 <= `attack_time` <= 400).
* `attenuation` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Attenuation (dB) (-24 <= `attenuation` <= 0).
* `knee_radius` (```
anything that is either float or ()->float```
 -- defaults to `3.25`): Knee radius (dB) (1 <= `knee_radius` <= 10).
* `ratio` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Ratio (1:n) (1 <= `ratio` <= 20).
* `release_time` (```
anything that is either float or ()->float```
 -- defaults to `401.0`): Release time (ms) (2 <= `release_time` <= 800).
* `rms_peak` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): RMS/peak (0 <= `rms_peak` <= 1).
* `threshold_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Threshold level (dB) (-30 <= `threshold_level` <= 0).
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

### ladspa.shaper
```
(?id:string,?waveshape:'a,
 source(audio='#b,video='#c,midi='#d))->
source(audio='#b,video='#c,midi='#d)
where 'a is either float or ()->float```

Wave shaper by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `waveshape` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Waveshape (-10 <= `waveshape` <= 10).
* `(unlabeled)` (`source(audio='#b,video='#c,midi='#d)`)

### ladspa.sifter
```
(?id:string,?sift_size:'a,
 source(audio='#b,video='#c,midi='#d))->
source(audio='#b,video='#c,midi='#d)
where 'a is either float or ()->float```

Signal sifter by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `sift_size` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Sift size (1 <= `sift_size` <= 1000).
* `(unlabeled)` (`source(audio='#b,video='#c,midi='#d)`)

### ladspa.sincos
```
(?id:string,?base_frequency:'a,?pitch_offset:'b)->
source(audio=2,video=0,midi=0)
where 'a, 'b is either float or ()->float```

Sine + cosine oscillator by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `base_frequency` (```
anything that is either float or ()->float```
 -- defaults to `440.0`): Base frequency (Hz) (0.0441 <= `base_frequency` <= 22050).
* `pitch_offset` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Pitch offset (0 <= `pitch_offset` <= 8).

### ladspa.singlepara
```
(?id:string,?bandwidth:'a,?frequency:'b,?gain:'c,
 source(audio='#d,video='#e,midi='#f))->
source(audio='#d,video='#e,midi='#f)
where 'a, 'b, 'c is either float or ()->float```

Single band parametric by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `bandwidth` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Bandwidth (octaves) (0 <= `bandwidth` <= 4).
* `frequency` (```
anything that is either float or ()->float```
 -- defaults to `440.0`): Frequency (Hz) (0 <= `frequency` <= 17640).
* `gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Gain (dB) (-70 <= `gain` <= 30).
* `(unlabeled)` (`source(audio='#d,video='#e,midi='#f)`)

### ladspa.sinuswavewrapper
```
(?id:string,?wrap_degree:'a,
 source(audio='#b,video='#c,midi='#d))->
source(audio='#b,video='#c,midi='#d)
where 'a is either float or ()->float```

Sinus wavewrapper by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `wrap_degree` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Wrap degree (0 <= `wrap_degree` <= 10).
* `(unlabeled)` (`source(audio='#b,video='#c,midi='#d)`)

### ladspa.smoothdecimate
```
(?id:string,?resample_rate:'a,?smoothing:'b,
 source(audio='#c,video='#d,midi='#e))->
source(audio='#c,video='#d,midi='#e)
where 'a, 'b is either float or ()->float```

Smooth Decimator by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `resample_rate` (```
anything that is either float or ()->float```
 -- defaults to `44100.0`): Resample rate (0 <= `resample_rate` <= 44100).
* `smoothing` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Smoothing (0 <= `smoothing` <= 1).
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

### ladspa.split
```
(?id:string,source(audio=1,video=0,midi=0))->
source(audio=2,video=0,midi=0)```

Mono to Stereo splitter by Frank Neumann <franky(at)users.sourceforge.net>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio=1,video=0,midi=0)`)

### ladspa.stepmuxer
```
(?id:string,?crossfade_time:'a,
 source(audio=9,video=0,midi=0))->
source(audio=1,video=0,midi=0)
where 'a is either float or ()->float```

Step Demuxer by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `crossfade_time` (```
anything that is either float or ()->float```
 -- defaults to `50.0`): Crossfade time (in ms) (0 <= `crossfade_time` <= 100).
* `(unlabeled)` (`source(audio=9,video=0,midi=0)`)

### ladspa.surroundencoder
```
(?id:string,source(audio=4,video=0,midi=0))->
source(audio=2,video=0,midi=0)```

Surround matrix encoder by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio=4,video=0,midi=0)`)

### ladspa.svf
```
(?id:string,?filter_freq:'a,?filter_q:'b,
 ?filter_resonance:'c,?filter_type:'d,
 source(audio='#e,video='#f,midi='#g))->
source(audio='#e,video='#f,midi='#g)
where 'a, 'b, 'c is either float or ()->float,
  'd is either int or ()->int```

State Variable Filter by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `filter_freq` (```
anything that is either float or ()->float```
 -- defaults to `440.0`): Filter freq (0 <= `filter_freq` <= 6000).
* `filter_q` (```
anything that is either float or ()->float```
 -- defaults to `0.25`): Filter Q (0 <= `filter_q` <= 1).
* `filter_resonance` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Filter resonance (0 <= `filter_resonance` <= 1).
* `filter_type` (`anything that is either int or ()->int` -- defaults to `0`): Filter type (0=none, 1=LP, 2=HP, 3=BP, 4=BR, 5=AP) (0 <= `filter_type` <= 5).
* `(unlabeled)` (`source(audio='#e,video='#f,midi='#g)`)

### ladspa.tapedelay
```
(?id:string,?dry_level:'a,?tap_1_distance:'b,
 ?tap_1_level:'c,?tap_2_distance:'d,?tap_2_level:'e,
 ?tap_3_distance:'f,?tap_3_level:'g,?tap_4_distance:'h,
 ?tap_4_level:'i,?tape_speed:'j,
 source(audio='#k,video='#l,midi='#m))->
source(audio='#k,video='#l,midi='#m)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g, 'h, 'i, 'j is either float or ()->float```

Tape Delay Simulation by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `dry_level` (```
anything that is either float or ()->float```
 -- defaults to `-90.0`): Dry level (dB) (-90 <= `dry_level` <= 0).
* `tap_1_distance` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Tap 1 distance (inches) (0 <= `tap_1_distance` <= 4).
* `tap_1_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Tap 1 level (dB) (-90 <= `tap_1_level` <= 0).
* `tap_2_distance` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Tap 2 distance (inches) (0 <= `tap_2_distance` <= 4).
* `tap_2_level` (```
anything that is either float or ()->float```
 -- defaults to `-90.0`): Tap 2 level (dB) (-90 <= `tap_2_level` <= 0).
* `tap_3_distance` (```
anything that is either float or ()->float```
 -- defaults to `2.0`): Tap 3 distance (inches) (0 <= `tap_3_distance` <= 4).
* `tap_3_level` (```
anything that is either float or ()->float```
 -- defaults to `-90.0`): Tap 3 level (dB) (-90 <= `tap_3_level` <= 0).
* `tap_4_distance` (```
anything that is either float or ()->float```
 -- defaults to `3.0`): Tap 4 distance (inches) (0 <= `tap_4_distance` <= 4).
* `tap_4_level` (```
anything that is either float or ()->float```
 -- defaults to `-90.0`): Tap 4 level (dB) (-90 <= `tap_4_level` <= 0).
* `tape_speed` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Tape speed (inches/sec, 1=normal) (0 <= `tape_speed` <= 10).
* `(unlabeled)` (`source(audio='#k,video='#l,midi='#m)`)

### ladspa.transient
```
(?id:string,?attack_speed:'a,?sustain_time:'b,
 source(audio='#c,video='#d,midi='#e))->
source(audio='#c,video='#d,midi='#e)
where 'a, 'b is either float or ()->float```

Transient mangler by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `attack_speed` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Attack speed (-1 <= `attack_speed` <= 1).
* `sustain_time` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Sustain time (-1 <= `sustain_time` <= 1).
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

### ladspa.triplepara
```
(?id:string,?band_1_bandwidth:'a,?band_1_frequency:'b,
 ?band_1_gain:'c,?band_2_bandwidth:'d,
 ?band_2_frequency:'e,?band_2_gain:'f,
 ?band_3_bandwidth:'g,?band_3_frequency:'h,
 ?band_3_gain:'i,?high_shelving_frequency:'j,
 ?high_shelving_gain:'k,?high_shelving_slope:'l,
 ?low_shelving_frequency:'m,?low_shelving_gain:'n,
 ?low_shelving_slope:'o,
 source(audio='#p,video='#q,midi='#r))->
source(audio='#p,video='#q,midi='#r)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g, 'h, 'i, 'j, 'k, 'l, 'm, 'n, 'o is either float or ()->float```

Triple band parametric with shelves by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `band_1_bandwidth` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Band 1 bandwidth (octaves) (0 <= `band_1_bandwidth` <= 4).
* `band_1_frequency` (```
anything that is either float or ()->float```
 -- defaults to `36.8967056274`): Band 1 frequency (Hz) (4.41 <= `band_1_frequency` <= 21609).
* `band_1_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Band 1 gain (dB) (-70 <= `band_1_gain` <= 30).
* `band_2_bandwidth` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Band 2 bandwidth (octaves) (0 <= `band_2_bandwidth` <= 4).
* `band_2_frequency` (```
anything that is either float or ()->float```
 -- defaults to `308.699981689`): Band 2 frequency (Hz) (4.41 <= `band_2_frequency` <= 21609).
* `band_2_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Band 2 gain (dB) (-70 <= `band_2_gain` <= 30).
* `band_3_bandwidth` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Band 3 bandwidth (octaves) (0 <= `band_3_bandwidth` <= 4).
* `band_3_frequency` (```
anything that is either float or ()->float```
 -- defaults to `2582.76953125`): Band 3 frequency (Hz) (4.41 <= `band_3_frequency` <= 21609).
* `band_3_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Band 3 gain (dB) (-70 <= `band_3_gain` <= 30).
* `high_shelving_frequency` (```
anything that is either float or ()->float```
 -- defaults to `21609.0`): High-shelving frequency (Hz) (4.41 <= `high_shelving_frequency` <= 21609).
* `high_shelving_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): High-shelving gain (dB) (-70 <= `high_shelving_gain` <= 30).
* `high_shelving_slope` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): High-shelving slope (0 <= `high_shelving_slope` <= 1).
* `low_shelving_frequency` (```
anything that is either float or ()->float```
 -- defaults to `4.40999984741`): Low-shelving frequency (Hz) (4.41 <= `low_shelving_frequency` <= 21609).
* `low_shelving_gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Low-shelving gain (dB) (-70 <= `low_shelving_gain` <= 30).
* `low_shelving_slope` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Low-shelving slope (0 <= `low_shelving_slope` <= 1).
* `(unlabeled)` (`source(audio='#p,video='#q,midi='#r)`)

### ladspa.valve
```
(?id:string,?distortion_character:'a,
 ?distortion_level:'b,
 source(audio='#c,video='#d,midi='#e))->
source(audio='#c,video='#d,midi='#e)
where 'a, 'b is either float or ()->float```

Valve saturation by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `distortion_character` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Distortion character (0 <= `distortion_character` <= 1).
* `distortion_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Distortion level (0 <= `distortion_level` <= 1).
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

### ladspa.valverect
```
(?id:string,?distortion:'a,?sag_level:'b,
 source(audio='#c,video='#d,midi='#e))->
source(audio='#c,video='#d,midi='#e)
where 'a, 'b is either float or ()->float```

Valve rectifier by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `distortion` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Distortion (0 <= `distortion` <= 1).
* `sag_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Sag level (0 <= `sag_level` <= 1).
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

### ladspa.vocoder
```
(?id:string,band_10_level:'a,band_11_level:'b,
 band_12_level:'c,band_13_level:'d,band_14_level:'e,
 band_15_level:'f,band_16_level:'g,band_1_level:'h,
 band_2_level:'i,band_3_level:'j,band_4_level:'k,
 band_5_level:'l,band_6_level:'m,band_7_level:'n,
 band_8_level:'o,band_9_level:'p,left_right:'q,
 number_of_bands:'r,source(audio=2,video=0,midi=0))->
source(audio=2,video=0,midi=0)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g, 'h, 'i, 'j, 'k, 'l, 'm, 'n, 'o, 'p is either float or ()->float,
  'q, 'r is either int or ()->int```

Vocoder by Achim Settelmeier <settel-linux(at)sirlab.de> (adapted by Josh Green and Hexasoft).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `band_10_level` (```
anything that is either float or ()->float```
): Band 10 Level (0 <= `band_10_level` <= 1).
* `band_11_level` (```
anything that is either float or ()->float```
): Band 11 Level (0 <= `band_11_level` <= 1).
* `band_12_level` (```
anything that is either float or ()->float```
): Band 12 Level (0 <= `band_12_level` <= 1).
* `band_13_level` (```
anything that is either float or ()->float```
): Band 13 Level (0 <= `band_13_level` <= 1).
* `band_14_level` (```
anything that is either float or ()->float```
): Band 14 Level (0 <= `band_14_level` <= 1).
* `band_15_level` (```
anything that is either float or ()->float```
): Band 15 Level (0 <= `band_15_level` <= 1).
* `band_16_level` (```
anything that is either float or ()->float```
): Band 16 Level (0 <= `band_16_level` <= 1).
* `band_1_level` (```
anything that is either float or ()->float```
): Band 1 Level (0 <= `band_1_level` <= 1).
* `band_2_level` (```
anything that is either float or ()->float```
): Band 2 Level (0 <= `band_2_level` <= 1).
* `band_3_level` (```
anything that is either float or ()->float```
): Band 3 Level (0 <= `band_3_level` <= 1).
* `band_4_level` (```
anything that is either float or ()->float```
): Band 4 Level (0 <= `band_4_level` <= 1).
* `band_5_level` (```
anything that is either float or ()->float```
): Band 5 Level (0 <= `band_5_level` <= 1).
* `band_6_level` (```
anything that is either float or ()->float```
): Band 6 Level (0 <= `band_6_level` <= 1).
* `band_7_level` (```
anything that is either float or ()->float```
): Band 7 Level (0 <= `band_7_level` <= 1).
* `band_8_level` (```
anything that is either float or ()->float```
): Band 8 Level (0 <= `band_8_level` <= 1).
* `band_9_level` (```
anything that is either float or ()->float```
): Band 9 Level (0 <= `band_9_level` <= 1).
* `left_right` (`anything that is either int or ()->int`): Left/Right (-100 <= `left_right` <= 100).
* `number_of_bands` (`anything that is either int or ()->int`): Number of bands (1 <= `number_of_bands` <= 16).
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

### ladspa.vynil
```
(?id:string,?crackle:'a,?rpm:'b,?surface_warping:'c,
 ?wear:'d,?year:'e,source(audio=2,video=0,midi=0))->
source(audio=2,video=0,midi=0)
where 'a, 'b, 'c, 'd, 'e is either float or ()->float```

VyNil (Vinyl Effect) by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `crackle` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Crackle (0 <= `crackle` <= 1).
* `rpm` (```
anything that is either float or ()->float```
 -- defaults to `33.0`): RPM (33 <= `rpm` <= 78).
* `surface_warping` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Surface warping (0 <= `surface_warping` <= 1).
* `wear` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Wear (0 <= `wear` <= 1).
* `year` (```
anything that is either float or ()->float```
 -- defaults to `1990.0`): Year (1900 <= `year` <= 1990).
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

### ladspa.waveterrain
```
(?id:string,source(audio=2,video=0,midi=0))->
source(audio=1,video=0,midi=0)```

Wave Terrain Oscillator by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

### ladspa.xfade
```
(?id:string,?crossfade:'a,source(audio=4,video=0,midi=0))->
source(audio=2,video=0,midi=0)
where 'a is either float or ()->float```

Crossfade by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `crossfade` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Crossfade (-1 <= `crossfade` <= 1).
* `(unlabeled)` (`source(audio=4,video=0,midi=0)`)

### ladspa.xfade4
```
(?id:string,?crossfade:'a,source(audio=4,video=0,midi=0))->
source(audio=4,video=0,midi=0)
where 'a is either float or ()->float```

Crossfade (4 outs) by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `crossfade` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Crossfade (-1 <= `crossfade` <= 1).
* `(unlabeled)` (`source(audio=4,video=0,midi=0)`)

### ladspa.zm1
```
(?id:string,source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

z-1 by Steve Harris <steve(at)plugin.org.uk>.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### limit
```
(?id:string,?attack:'a,?gain:'b,?knee:'c,?ratio:float,
 ?release:'d,?rms_window:float,?threshold:'e,
 source(audio='#f,video='#g,midi='#h))->
source(audio='#f,video='#g,midi='#h)
where 'a, 'b, 'c, 'd, 'e is either float or ()->float```

Limit the signal.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `attack` (```
anything that is either float or ()->float```
 -- defaults to `100.0`): Attack time (ms).
* `gain` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Additional gain (dB).
* `knee` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Knee radius (dB).
* `ratio` (`float` -- defaults to `20.0`): Gain reduction ratio (n:1).
* `release` (```
anything that is either float or ()->float```
 -- defaults to `400.0`): Release time (ms).
* `rms_window` (`float` -- defaults to `0.1`): Window for computing RMS (in sec).
* `threshold` (```
anything that is either float or ()->float```
 -- defaults to `-10.0`): Threshold level (dB).
* `(unlabeled)` (`source(audio='#f,video='#g,midi='#h)`)

### mic_filter
```
(source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Remove low frequencies often produced by microphones.

* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`): The input source.

### mix
```
(?id:string,[source(audio='#a,video='#b,midi='#c)])->
source(audio='#a,video='#b,midi='#c)```

Mixing table controllable via the telnet interface.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`[source(audio='#a,video='#b,midi='#c)]`)

### normalize
```
(?id:string,?gain_max:'a,?gain_min:'b,?k_down:'c,
 ?k_up:'d,?target:'e,?threshold:'f,?window:float,
 source(audio='#g,video='#h,midi='#i))->
source(audio='#g,video='#h,midi='#i)
where 'a, 'b, 'c, 'd, 'e, 'f is either float or ()->float```

Normalize the signal. Dynamic normalization of the signal is sometimes the only option, and can make a listening experience much nicer. However, its dynamic aspect implies some limitations which can go as far as creating saturation in some extreme cases. If possible, consider using some track-based normalization techniques such as those based on replay gain. See the documentation for more details.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `gain_max` (```
anything that is either float or ()->float```
 -- defaults to `6.0`): Maximal gain value (dB).
* `gain_min` (```
anything that is either float or ()->float```
 -- defaults to `-6.0`): Minimal gain value (dB).
* `k_down` (```
anything that is either float or ()->float```
 -- defaults to `0.1`): Coefficient when the power must go down (between 0 and 1, slowest to fastest).
* `k_up` (```
anything that is either float or ()->float```
 -- defaults to `0.005`): Coefficient when the power must go up (between 0 and 1, slowest to fastest).
* `target` (```
anything that is either float or ()->float```
 -- defaults to `-13.0`): Desired RMS (dB).
* `threshold` (```
anything that is either float or ()->float```
 -- defaults to `-40.0`): Minimal RMS for activaing gain control (dB).
* `window` (`float` -- defaults to `0.1`): Duration of the window used to compute the current RMS power (second).
* `(unlabeled)` (`source(audio='#g,video='#h,midi='#i)`)

### nrj
```
(source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Compress and normalize, producing a more uniform and ``full'' sound.

* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`): The input source.

### pipe
```
(?id:string,?buffer:float,?max:float,process:string,
 ?restart:bool,?restart_on_error:bool,
 source(audio='#a+1,video=0,midi=0))->
source(audio='#b+1,video=0,midi=0)```

Process audio signal through a given process stdin/stdout.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `buffer` (`float` -- defaults to `1.0`): Duration of the pre-buffered data.
* `max` (`float` -- defaults to `10.0`): Maximum duration of the buffered data.
* `process` (`string`): Process used to pipe data to.
* `restart` (`bool` -- defaults to `true`): Restart process when exited.
* `restart_on_error` (`bool` -- defaults to `false`): Restart process when exited with error.
* `(unlabeled)` (`source(audio='#a+1,video=0,midi=0)`)

### sky
```
(source(audio='#a,video='#b,midi=0))->
source(audio='#a,video='#b,midi=0)```

Multiband-compression.

* `(unlabeled)` (`source(audio='#a,video='#b,midi=0)`): The input source.

### smart_cross
```
(?id:string,?active:bool,?conservative:bool,
 ?duration:float,?inhibit:float,?minimum:float,
 ?width:float,
 ((float,float,[(string*string)],[(string*string)],
   source(audio='#a+1,video=0,midi=0),
   source(audio='#a+1,video=0,midi=0))->
  source(audio='#a+1,video=0,midi=0)),
 source(audio='#a+1,video=0,midi=0))->
source(audio='#a+1,video=0,midi=0)```

Cross operator, allowing the composition of the N last seconds of a track with the beginning of the next track, using a transition function depending on the relative power of the signal before and after the end of track.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `active` (`bool` -- defaults to `false`): The active behavior is to keep ticking the child's clock when the operator is not streaming. Otherwise the child's clock is strictly based on what is streamed off the child source, which results in time-dependent active sources to be frozen when that source is stopped.
* `conservative` (`bool` -- defaults to `true`): Do not trust remaining time estimations, always buffering data in advance. This avoids being tricked by skips, either manual or caused by skip_blank().
* `duration` (`float` -- defaults to `5.0`): Duration in seconds of the crossed end of track.
* `inhibit` (`float` -- defaults to `-1.0`): Minimum delay between two transitions. It is useful in order to avoid that a transition is triggered on top of another when an end-of-track occurs in the first one. Negative values mean `duration+1`. Warning: zero inhibition can cause infinite loops.
* `minimum` (`float` -- defaults to `-1.0`): Minimum duration (in sec.) for a cross: If the track ends without any warning (e.g. in case of skip) there may not be enough data for a decent composition. Set to 0. to avoid having transitions after skips, or more to avoid transitions on short tracks. With the negative default, transitions always occur.
* `width` (`float` -- defaults to `1.0`): Width of the power computation window.
* `(unlabeled)` (```
(float,float,[(string*string)],[(string*string)],
 source(audio='#a+1,video=0,midi=0),
 source(audio='#a+1,video=0,midi=0))->
source(audio='#a+1,video=0,midi=0)```
): Transition function, composing from the end of a track and the next track. It also takes the power of the signal before and after the transition, and the metadata.
* `(unlabeled)` (`source(audio='#a+1,video=0,midi=0)`)

### stereo.ms.decode
```
(?id:string,?width:float,source(audio=2,video=0,midi=0))->
source(audio=2,video=0,midi=0)```

Decode mid+side stereo (M/S) to left+right stereo.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `width` (`float` -- defaults to `1.0`): Width of the stereo field.
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

### stereo.ms.encode
```
(?id:string,source(audio=2,video=0,midi=0))->
source(audio=2,video=0,midi=0)```

Encode left+right stereo to mid+side stereo (M/S).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

### stereo.pan
```
(?id:string,?field:'a,?pan:'b,
 source(audio=2,video=0,midi=0))->
source(audio=2,video=0,midi=0)
where 'a, 'b is either float or ()->float```

Pan a stereo sound.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `field` (```
anything that is either float or ()->float```
 -- defaults to `90.0`): Field width in degrees (between 0 and 90).
* `pan` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Pan ranges between -1 and 1.
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

### stretch
```
(?id:string,?active:bool,ratio:'a,
 source(audio='#b+1,video=0,midi=0))->
source(audio='#c+1,video=0,midi=0)
where 'a is either float or ()->float```

Slow down or accelerate an audio stream by stretching (sounds lower) or squeezing it (sounds higher).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `active` (`bool` -- defaults to `true`): The active behavior is to keep ticking the child's clock when the operator is not streaming. Otherwise the child's clock is strictly based on what is streamed off the child source, which results in time-dependent active sources to be frozen when that source is stopped.
* `ratio` (```
anything that is either float or ()->float```
): A value higher than 1 means slowing down.
* `(unlabeled)` (`source(audio='#b+1,video=0,midi=0)`)

Source / Sound Synthesis
------------------------
### synth.all.saw
```
(?id:string,?attack:float,?decay:float,?envelope:bool,
 ?release:float,?sustain:float,
 source(audio='#a+1,video='#b,midi='#c+16))->
source(audio='#a+1,video='#b,midi='#c+16)```

Saw synthesizer. It creates one synthesizer for each channel.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `attack` (`float` -- defaults to `0.02`): Envelope attack (in seconds).
* `decay` (`float` -- defaults to `0.01`): Envelope decay (in seconds).
* `envelope` (`bool` -- defaults to `true`): Use envelope.
* `release` (`float` -- defaults to `0.01`): Envelope release (in seconds).
* `sustain` (`float` -- defaults to `0.9`): Envelope sustain level.
* `(unlabeled)` (```
source(audio='#a+1,video='#b,midi='#c+16)```
)

### synth.all.sine
```
(?id:string,?attack:float,?decay:float,?envelope:bool,
 ?release:float,?sustain:float,
 source(audio='#a+1,video='#b,midi='#c+16))->
source(audio='#a+1,video='#b,midi='#c+16)```

Sine synthesizer. It creates one synthesizer for each channel.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `attack` (`float` -- defaults to `0.02`): Envelope attack (in seconds).
* `decay` (`float` -- defaults to `0.01`): Envelope decay (in seconds).
* `envelope` (`bool` -- defaults to `true`): Use envelope.
* `release` (`float` -- defaults to `0.01`): Envelope release (in seconds).
* `sustain` (`float` -- defaults to `0.9`): Envelope sustain level.
* `(unlabeled)` (```
source(audio='#a+1,video='#b,midi='#c+16)```
)

### synth.all.square
```
(?id:string,?attack:float,?decay:float,?envelope:bool,
 ?release:float,?sustain:float,
 source(audio='#a+1,video='#b,midi='#c+16))->
source(audio='#a+1,video='#b,midi='#c+16)```

Square synthesizer. It creates one synthesizer for each channel.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `attack` (`float` -- defaults to `0.02`): Envelope attack (in seconds).
* `decay` (`float` -- defaults to `0.01`): Envelope decay (in seconds).
* `envelope` (`bool` -- defaults to `true`): Use envelope.
* `release` (`float` -- defaults to `0.01`): Envelope release (in seconds).
* `sustain` (`float` -- defaults to `0.9`): Envelope sustain level.
* `(unlabeled)` (```
source(audio='#a+1,video='#b,midi='#c+16)```
)

### synth.saw
```
(?id:string,?attack:float,?channel:int,?decay:float,
 ?envelope:bool,?release:float,?sustain:float,
 ?volume:float,source(audio='#a+1,video='#b,midi='#c+1))->
source(audio='#a+1,video='#b,midi='#c+1)```

Saw synthesizer.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `attack` (`float` -- defaults to `0.02`): Envelope attack (in seconds).
* `channel` (`int` -- defaults to `0`): MIDI channel to handle.
* `decay` (`float` -- defaults to `0.01`): Envelope decay (in seconds).
* `envelope` (`bool` -- defaults to `true`): Use envelope.
* `release` (`float` -- defaults to `0.05`): Envelope release (in seconds).
* `sustain` (`float` -- defaults to `0.9`): Envelope sustain level.
* `volume` (`float` -- defaults to `0.3`): Initial volume.
* `(unlabeled)` (```
source(audio='#a+1,video='#b,midi='#c+1)```
)

### synth.sine
```
(?id:string,?attack:float,?channel:int,?decay:float,
 ?envelope:bool,?release:float,?sustain:float,
 ?volume:float,source(audio='#a+1,video='#b,midi='#c+1))->
source(audio='#a+1,video='#b,midi='#c+1)```

Sine synthesizer.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `attack` (`float` -- defaults to `0.02`): Envelope attack (in seconds).
* `channel` (`int` -- defaults to `0`): MIDI channel to handle.
* `decay` (`float` -- defaults to `0.01`): Envelope decay (in seconds).
* `envelope` (`bool` -- defaults to `true`): Use envelope.
* `release` (`float` -- defaults to `0.05`): Envelope release (in seconds).
* `sustain` (`float` -- defaults to `0.9`): Envelope sustain level.
* `volume` (`float` -- defaults to `0.3`): Initial volume.
* `(unlabeled)` (```
source(audio='#a+1,video='#b,midi='#c+1)```
)

### synth.square
```
(?id:string,?attack:float,?channel:int,?decay:float,
 ?envelope:bool,?release:float,?sustain:float,
 ?volume:float,source(audio='#a+1,video='#b,midi='#c+1))->
source(audio='#a+1,video='#b,midi='#c+1)```

Square synthesizer.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `attack` (`float` -- defaults to `0.02`): Envelope attack (in seconds).
* `channel` (`int` -- defaults to `0`): MIDI channel to handle.
* `decay` (`float` -- defaults to `0.01`): Envelope decay (in seconds).
* `envelope` (`bool` -- defaults to `true`): Use envelope.
* `release` (`float` -- defaults to `0.05`): Envelope release (in seconds).
* `sustain` (`float` -- defaults to `0.9`): Envelope sustain level.
* `volume` (`float` -- defaults to `0.3`): Initial volume.
* `(unlabeled)` (```
source(audio='#a+1,video='#b,midi='#c+1)```
)

Source / Track Processing
-------------------------
### append
```
(?id:string,?insert_missing:bool,?merge:bool,source('a),
 (([(string*string)])->source('a)))->source('a)```

Append an extra track to every track. Set the metadata 'liq_append' to 'false' to inhibit appending on one track.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `insert_missing` (`bool` -- defaults to `true`): Treat track beginnings without metadata as having empty one.
* `merge` (`bool` -- defaults to `false`): Merge the track with its appended track.
* `(unlabeled)` (`source('a)`)
* `(unlabeled)` (`([(string*string)])->source('a)`): Given the metadata, build the source producing the track to append. This source is allowed to fail (produce nothing) if no relevant track is to be appended.

### at
```
((()->bool),source('a))->source('a)```

Restrict a source to play only when a predicate is true.

* `(unlabeled)` (`()->bool`): The predicate, typically a time interval such as `{10h-10h30}`.
* `(unlabeled)` (`source('a)`)

### crossfade
```
(?id:string,?conservative:bool,?start_next:float,
 ?fade_in:float,?fade_out:float,
 source(audio='#a,video='#b,midi=0))->
source(audio='#a,video='#b,midi=0)```

Simple crossfade.

* `id` (`string` -- defaults to `""`)
* `conservative` (`bool` -- defaults to `true`): Always prepare for a premature end-of-track.
* `start_next` (`float` -- defaults to `5.0`): Duration in seconds of the crossed end of track.
* `fade_in` (`float` -- defaults to `3.0`): Duration of the fade in for next track.
* `fade_out` (`float` -- defaults to `3.0`): Duration of the fade out for previous track.
* `(unlabeled)` (`source(audio='#a,video='#b,midi=0)`): The source to use.

### cue_cut
```
(?id:string,?cue_in_metadata:string,
 ?cue_out_metadata:string,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Start track after a cue in point and stop it at cue out point. The cue points are given as metadata, in seconds from the begining of tracks.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `cue_in_metadata` (`string` -- defaults to `"liq_cue_in"`): Metadata for cue in points.
* `cue_out_metadata` (`string` -- defaults to `"liq_cue_out"`): Metadata for cue out points.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### delay
```
(?id:string,?initial:bool,float,source('a))->source('a)```

Prevents the child from being ready again too fast after a end of track

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `initial` (`bool` -- defaults to `false`): Start in unavailable state, as if a track had just finished.
* `(unlabeled)` (`float`): The source won't be ready less than this amount of seconds after any end of track
* `(unlabeled)` (`source('a)`)

### drop_metadata
```
(source('a))->source('a)```

Removes all metadata coming from a source.

* `(unlabeled)` (`source('a)`)

### eat_blank
```
(?id:string,?at_beginning:bool,?max_blank:float,
 ?min_noise:float,?start_blank:bool,?threshold:float,
 ?track_sensitive:bool,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Eat blanks, i.e., drop the contents of the stream until it is not blank anymore.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `at_beginning` (`bool` -- defaults to `false`): Only eat at the beginning of a track.
* `max_blank` (`float` -- defaults to `20.0`): Maximum duration of silence allowed, in seconds.
* `min_noise` (`float` -- defaults to `0.0`): Minimum duration of noise required to end silence, in seconds.
* `start_blank` (`bool` -- defaults to `false`): Start assuming we have blank.
* `threshold` (`float` -- defaults to `-40.0`): Power in decibels under which the stream is considered silent.
* `track_sensitive` (`bool` -- defaults to `true`): Reset blank counter at each track.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### fallback
```
(?id:string,?replay_metadata:bool,?track_sensitive:'a,
 ?transitions:[(source('b),source('b))->source('b)],
 [source('b)])->source('b)
where 'a is either bool or ()->bool```

At the beginning of each track, select the first ready child.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `replay_metadata` (`bool` -- defaults to `true`): Replay the last metadata of a child when switching to it in the middle of a track.
* `track_sensitive` (```
anything that is either bool or ()->bool```
 -- defaults to `true`): Re-select only on end of tracks.
* `transitions` (`[(source('b),source('b))->source('b)]` -- defaults to `[]`): Transition functions, padded with `fun (x,y) -> y` functions.
* `(unlabeled)` (`[source('b)]`): Select the first ready source in this list.

### fallback.skip
```
(input:source('a),source('a))->source('a)```

Special track insensitive fallback that always skips current song before switching.

* `input` (`source('a)`): The input source
* `(unlabeled)` (`source('a)`): The fallback source

### insert_metadata
```
(?id:string,source('a))->
((([(string*string)])->unit)*source('a))```

Dynamically insert metadata in a stream. Returns a pair (f,s) where s is a new source and f is a function of type (metadata)->unit, used to insert metadata in s.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source('a)`)

### map_metadata
```
(?id:string,?insert_missing:bool,?strip:bool,
 ?update:bool,(([(string*string)])->[(string*string)]),
 source('a))->source('a)```

Rewrite metadata on the fly using a function.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `insert_missing` (`bool` -- defaults to `true`): Treat track beginnings without metadata as having empty ones. The operational order is: create empty if needed, map and strip if enabled.
* `strip` (`bool` -- defaults to `false`): Completely remove empty metadata. Operates on both empty values and empty metadata chunk.
* `update` (`bool` -- defaults to `true`): Only update metadata. If false, only returned values will be set as metadata.
* `(unlabeled)` (`([(string*string)])->[(string*string)]`): A function that returns new metadata.
* `(unlabeled)` (`source('a)`)

### merge_tracks
```
(?id:string,source('a))->source('a)```

Merge consecutive tracks from the input source.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source('a)`)

### mksafe
```
(?id:string,source('a))->source('a)```

Turn a source into an infaillible source by adding blank when the source is not available.

* `id` (`string` -- defaults to `"mksafe"`)
* `(unlabeled)` (`source('a)`): the source to turn infaillible

### notify_metadata
```
(?urgency:string,?icon:string,?time:int,
 ?display:(([(string*string)])->string),?title:string,
 source('a))->source('a)```

Use notify to display metadata info.

* `urgency` (`string` -- defaults to `"low"`): Urgency (low|normal|critical).
* `icon` (`string` -- defaults to `"stock_smiley-22"`): Icon filename or stock icon to display.
* `time` (`int` -- defaults to `3000`): Timeout in milliseconds.
* `display` (`([(string*string)])->string` -- defaults to <code><fun></code>): Function used to display a metadata packet.
* `title` (`string` -- defaults to `"Liquidsoap: new track"`): Title of the notification message.
* `(unlabeled)` (`source('a)`)

### on_blank
```
(?id:string,?max_blank:float,?min_noise:float,
 ?on_noise:(()->unit),?start_blank:bool,?threshold:float,
 ?track_sensitive:bool,(()->unit),
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Calls a given handler when detecting a blank.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `max_blank` (`float` -- defaults to `20.0`): Maximum duration of silence allowed, in seconds.
* `min_noise` (`float` -- defaults to `0.0`): Minimum duration of noise required to end silence, in seconds.
* `on_noise` (`()->unit` -- defaults to `{()}`): Handler called when noise is detected.
* `start_blank` (`bool` -- defaults to `false`): Start assuming we have blank.
* `threshold` (`float` -- defaults to `-40.0`): Power in decibels under which the stream is considered silent.
* `track_sensitive` (`bool` -- defaults to `true`): Reset blank counter at each track.
* `(unlabeled)` (`()->unit`): Handler called when blank is detected.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### on_end
```
(?id:string,?delay:float,
 ((float,[(string*string)])->unit),source('a))->
source('a)```

Call a given handler when there is less than a given amount of time remaining before then end of track.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `delay` (`float` -- defaults to `5.0`): Execute handler when remaining time is less or equal to this value.
* `(unlabeled)` (`(float,[(string*string)])->unit`): Function to execute. First argument is the remaining time, second is the latest metadata. That function should be fast because it is executed in the main streaming thread.
* `(unlabeled)` (`source('a)`)

### on_metadata
```
(?id:string,(([(string*string)])->unit),source('a))->
source('a)```

Call a given handler on metadata packets.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`([(string*string)])->unit`): Function called on every metadata packet in the stream. It should be fast because it is executed in the main streaming thread.
* `(unlabeled)` (`source('a)`)

### on_offset
```
(?id:string,?force:bool,?offset:float,?override:string,
 ((float,[(string*string)])->unit),source('a))->
source('a)```

Call a given handler when position in track is equal or more than a given amount of time.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `force` (`bool` -- defaults to `false`): Force execution of callback if track ends before 'offset' position has been reached.
* `offset` (`float` -- defaults to `-1.0`): Execute handler when position in track is equal or more than to this value.
* `override` (`string` -- defaults to `"liq_on_offset"`): Metadata field which, if present and containing a float, overrides the 'offset' parameter.
* `(unlabeled)` (`(float,[(string*string)])->unit`): Function to execute. First argument is the actual position within the current track, second is the latest metadata. That function should be fast because it is executed in the main streaming thread.
* `(unlabeled)` (`source('a)`)

### on_track
```
(?id:string,(([(string*string)])->unit),source('a))->
source('a)```

Call a given handler on new tracks.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`([(string*string)])->unit`): Function called on every beginning of track in the stream, with the corresponding metadata as argument. If there is no metadata at the beginning of track, the empty list is passed. That function should be fast because it is executed in the main streaming thread.
* `(unlabeled)` (`source('a)`)

### once
```
(source('a))->source('a)```

Creates a source that plays only one track of the input source.

* `(unlabeled)` (`source('a)`): The input source.

### osd_metadata
```
(?color:string,?position:string,?font:string,
 ?display:(([(string*string)])->string),source('a))->
source('a)```

Use X On Screen Display to display metadata info.

* `color` (`string` -- defaults to `"green"`): Color of the text.
* `position` (`string` -- defaults to `"top"`): Position of the text (top|middle|bottom).
* `font` (`string` -- defaults to `"-*-courier-*-r-*-*-*-240-*-*-*-*-*-*"`): Font used (xfontsel is your friend...)
* `display` (`([(string*string)])->string` -- defaults to <code><fun></code>): Function used to display a metadata packet.
* `(unlabeled)` (`source('a)`)

### overlap_sources
```
(?id:string,?normalize:bool,?start_next:string,
 ?weights:[int],[source(audio='#a,video='#b,midi=0)])->
source(audio='#a,video='#b,midi=0)```

Rotate between overlapping sources. Next track starts according to 'liq_start_next' offset metadata.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `normalize` (`bool` -- defaults to `false`)
* `start_next` (`string` -- defaults to `"liq_start_next"`): Metadata field indicating when the next track should start, relative to current track's time.
* `weights` (`[int]` -- defaults to `[]`): Relative weight of the sources in the sum. The empty list stands for the homogeneous distribution.
* `(unlabeled)` (`[source(audio='#a,video='#b,midi=0)]`): Sources to toggle from

### playlist.merge
```
(?id:string,?random:bool,string)->source('a)```

Play the whole playlist as one track.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `random` (`bool` -- defaults to `false`): Randomize playlist content
* `(unlabeled)` (`string`): Playlist URI.

### prepend
```
(?id:string,?merge:bool,
 source(audio='#a,video='#b,midi='#c),
 (([(string*string)])->
  source(audio='#a,video='#b,midi='#c)))->
source(audio='#a,video='#b,midi='#c)```

Prepend an extra track before every track. Set the metadata 'liq_prepend' to 'false' to inhibit prepending on one track.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `merge` (`bool` -- defaults to `false`): Merge the track with its appended track.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)
* `(unlabeled)` (```
([(string*string)])->source(audio='#a,video='#b,midi='#c)```
): Given the metadata, build the source producing the track to prepend. This source is allowed to fail (produce nothing) if no relevant track is to be appended. However, success must be immediate or it will not be taken into account.

### random
```
(?id:string,?replay_metadata:bool,?track_sensitive:'a,
 ?transitions:[(source('b),source('b))->source('b)],
 ?weights:[int],[source('b)])->source('b)
where 'a is either bool or ()->bool```

At the beginning of every track, select a random ready child.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `replay_metadata` (`bool` -- defaults to `true`): Replay the last metadata of a child when switching to it in the middle of a track.
* `track_sensitive` (```
anything that is either bool or ()->bool```
 -- defaults to `true`): Re-select only on end of tracks.
* `transitions` (`[(source('b),source('b))->source('b)]` -- defaults to `[]`): Transition functions, padded with `fun (x,y) -> y` functions.
* `weights` (`[int]` -- defaults to `[]`): Weights of the children (padded with 1), defining for each child the probability that it is selected.
* `(unlabeled)` (`[source('b)]`)

### rewrite_metadata
```
([(string*string)],?insert_missing:bool,?update:bool,
 ?strip:bool,source('a))->source('a)```

Rewrite metadata on the fly using a list of (target,rules).

* `(unlabeled)` (`[(string*string)]`): List of (target,value) rewriting rules.
* `insert_missing` (`bool` -- defaults to `true`): Treat track beginnings without metadata as having empty ones. The operational order is: create empty if needed, map and strip if enabled.
* `update` (`bool` -- defaults to `true`): Only update metadata. If false, only returned values will be set as metadata.
* `strip` (`bool` -- defaults to `false`): Completly remove empty metadata. Operates on both empty values and empty metadata chunk.
* `(unlabeled)` (`source('a)`)

### rotate
```
(?id:string,?replay_metadata:bool,?track_sensitive:'a,
 ?transitions:[(source('b),source('b))->source('b)],
 ?weights:[int],[source('b)])->source('b)
where 'a is either bool or ()->bool```

Rotate between the sources.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `replay_metadata` (`bool` -- defaults to `true`): Replay the last metadata of a child when switching to it in the middle of a track.
* `track_sensitive` (```
anything that is either bool or ()->bool```
 -- defaults to `true`): Re-select only on end of tracks.
* `transitions` (`[(source('b),source('b))->source('b)]` -- defaults to `[]`): Transition functions, padded with `fun (x,y) -> y` functions.
* `weights` (`[int]` -- defaults to `[]`): Weights of the children (padded with 1), defining for each child how many tracks are played from it per round, if that many are actually available.
* `(unlabeled)` (`[source('b)]`)

### rotate.merge
```
(?id:string,?track_sensitive:bool,
 ?transitions:[(source('a),source('a))->source('a)],
 ?weights:[int],[source('a)])->source('a)```

Same operator as rotate but merges tracks from each sources.
For instance, `rotate.merge([intro,main,outro])` creates a source that plays a sequence `[intro,main,outro]` as single track and loops back.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `track_sensitive` (`bool` -- defaults to `true`): Re-select only on end of tracks.
* `transitions` (`[(source('a),source('a))->source('a)]` -- defaults to `[]`): Transition functions, padded with `fun (x,y) -> y` functions.
* `weights` (`[int]` -- defaults to `[]`): Weights of the children (padded with 1), defining for each child how many tracks are played from it per round, if that many are actually available.
* `(unlabeled)` (`[source('a)]`): Sequence of sources to be merged

### say_metadata
```
(source(?A),?pattern:string)->source(?A)```

Append speech-synthesized tracks reading the metadata.

* `(unlabeled)` (`source(?A)`): The source to use
* `pattern` (`string` -- defaults to ```
"say:$(if $(artist),\"It was $(artist)$(if $(title),\\\", $(title)\\\").\")"```
): Pattern to use

### sequence
```
(?id:string,?merge:bool,[source('a)])->source('a)```

Play only one track of every successive source, except for the last one which is played as much as available. Sources are released after being used, allowing them to shutdown cleanly and free their resources.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `merge` (`bool` -- defaults to `false`): Merge tracks when advancing from one source to the next one. This will NOT merge consecutive tracks from the last source; see merge_tracks() if you need that too.
* `(unlabeled)` (`[source('a)]`)

### server.insert_metadata
```
(?id:string,source('a))->source('a)```

Register a server/telnet command to update a source's metadata. Returns a new source, which will receive the updated metadata. The command has the following format: insert key1=``val1'',key2=``val2'',...

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source('a)`)

### skip_blank
```
(?id:string,?threshold:float,?max_blank:float,
 ?min_noise:float,?track_sensitive:bool,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Skip track when detecting a blank.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `threshold` (`float` -- defaults to `-40.0`): Power in decibels under which the stream is considered silent.
* `max_blank` (`float` -- defaults to `20.0`): Maximum silence length allowed, in seconds.
* `min_noise` (`float` -- defaults to `0.0`): Minimum duration of noise required to end silence, in seconds.
* `track_sensitive` (`bool` -- defaults to `true`): Reset blank counter at each track.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### smart_crossfade
```
(?start_next:float,?fade_in:float,?fade_out:float,
 ?default:((source(audio='#a+1,video=0,midi=0),
            source(audio='#a+1,video=0,midi=0))->
           source(audio='#a+1,video=0,midi=0)),
 ?high:float,?medium:float,?margin:float,?width:float,
 ?conservative:bool,source(audio='#a+1,video=0,midi=0))->
source(audio='#a+1,video=0,midi=0)```

Crossfade between tracks, taking the respective volume levels into account in the choice of the transition.

* `start_next` (`float` -- defaults to `5.0`): Crossing duration, if any.
* `fade_in` (`float` -- defaults to `3.0`): Fade-in duration, if any.
* `fade_out` (`float` -- defaults to `3.0`): Fade-out duration, if any.
* `default` (```
(source(audio='#a+1,video=0,midi=0),
 source(audio='#a+1,video=0,midi=0))->
source(audio='#a+1,video=0,midi=0)```
 -- defaults to <code><fun></code>): Transition used when no rule applies (default: sequence).
* `high` (`float` -- defaults to `-15.0`): Value, in dB, for loud sound level.
* `medium` (`float` -- defaults to `-32.0`): Value, in dB, for medium sound level.
* `margin` (`float` -- defaults to `4.0`): Margin to detect sources that have too different sound level for crossing.
* `width` (`float` -- defaults to `2.0`): Width of the volume analysis window.
* `conservative` (`bool` -- defaults to `true`): Always prepare for a premature end-of-track.
* `(unlabeled)` (`source(audio='#a+1,video=0,midi=0)`): The input source.

### smooth_add
```
(?delay:float,?p:float,
 normal:source(audio='#a,video='#b,midi=0),
 special:source(audio='#a,video='#b,midi=0))->
source(audio='#a,video='#b,midi=0)```

Mixes two streams, with faded transitions between the state when only the normal stream is available and when the special stream gets added on top of it.

* `delay` (`float` -- defaults to `0.5`): Delay before starting the special source.
* `p` (`float` -- defaults to `0.2`): Portion of amplitude of the normal source in the mix.
* `normal` (`source(audio='#a,video='#b,midi=0)`): The normal source, which could be called the carrier too.
* `special` (`source(audio='#a,video='#b,midi=0)`): The special source.

### source.dynamic
```
(?id:string,(()->[source('a)]))->source('a)```

WARNING: This is only EXPERIMENTAL!

Dynamically change the underlying source.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`()->[source('a)]`)

### store_metadata
```
(?id:string,?size:int,source('a))->source('a)```

Keep track of the last N metadata packets in the stream, and make the history available via a server command.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `size` (`int` -- defaults to `10`): Size of the history
* `(unlabeled)` (`source('a)`)

### strip_blank
```
(?id:string,?max_blank:float,?min_noise:float,
 ?start_blank:bool,?threshold:float,
 ?track_sensitive:bool,
 source(audio='#a,video='#b,midi='#c))->
active_source(audio='#a,video='#b,midi='#c)```

Make the source unavailable when it is streaming blank.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `max_blank` (`float` -- defaults to `20.0`): Maximum duration of silence allowed, in seconds.
* `min_noise` (`float` -- defaults to `0.0`): Minimum duration of noise required to end silence, in seconds.
* `start_blank` (`bool` -- defaults to `false`): Start assuming we have blank.
* `threshold` (`float` -- defaults to `-40.0`): Power in decibels under which the stream is considered silent.
* `track_sensitive` (`bool` -- defaults to `true`): Reset blank counter at each track.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### switch
```
(?id:string,?replay_metadata:bool,?single:[bool],
 ?track_sensitive:'a,
 ?transitions:[(source('b),source('b))->source('b)],
 [((()->bool)*source('b))])->source('b)
where 'a is either bool or ()->bool```

At the beginning of a track, select the first source whose predicate is true.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `replay_metadata` (`bool` -- defaults to `true`): Replay the last metadata of a child when switching to it in the middle of a track.
* `single` (`[bool]` -- defaults to `[]`): Forbid the selection of a branch for two tracks in a row. The empty list stands for `[false,...,false]`.
* `track_sensitive` (```
anything that is either bool or ()->bool```
 -- defaults to `true`): Re-select only on end of tracks.
* `transitions` (`[(source('b),source('b))->source('b)]` -- defaults to `[]`): Transition functions, padded with `fun (x,y) -> y` functions.
* `(unlabeled)` (`[((()->bool)*source('b))]`): Sources with the predicate telling when they can be played.

Source / Video Processing
-------------------------
### video.add_image
```
(?id:string,?width:int,?height:int,?x:int,?y:int,file:'a,
 source(audio='#b,video='#c,midi=0))->
source(audio='#b,video='#c,midi=0)```

Add a static image on the first video channel.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `width` (`int` -- defaults to `0`): Scale to width (zero means frame width, negative means original width).
* `height` (`int` -- defaults to `0`): Scale to height (zero means frame height, negative means original height).
* `x` (`int` -- defaults to `4611686018427387903`): x position.
* `y` (`int` -- defaults to `4611686018427387903`): y position.
* `file` (`'a`): Path to the image file.
* `(unlabeled)` (`source(audio='#b,video='#c,midi=0)`)

### video.add_text.gstreamer
```
(?id:string,?color:int,?cycle:bool,?font:string,
 ?metadata:string,?size:int,?speed:int,?x:int,?y:int,'a,
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either string or ()->string```

Display a text (using the SDL library).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `color` (`int` -- defaults to `16777215`): Text color (in 0xRRGGBB format).
* `cycle` (`bool` -- defaults to `true`): Cycle text.
* `font` (`string` -- defaults to `""`): Path to ttf font file.
* `metadata` (`string` -- defaults to `""`): Change text on a particular metadata (empty string means disabled).
* `size` (`int` -- defaults to `18`): Font size.
* `speed` (`int` -- defaults to `70`): Speed in pixels per second (0 means no scrolling).
* `x` (`int` -- defaults to `-1`): x offset (negative means from right).
* `y` (`int` -- defaults to `-5`): y offset (negative means from bottom).
* `(unlabeled)` (```
anything that is either string or ()->string```
): Text to display.
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.fade.final
```
(?id:string,?duration:float,?transition:string,
 ?type:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Fade a stream to black.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (`float` -- defaults to `3.0`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `transition` (`string` -- defaults to `"fade"`): Kind of transition (fade|slide_left|slide_right|slide_up|slide_down|grow|disc|random).
* `type` (`string` -- defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.fade.in
```
(?id:string,?duration:float,?override:string,
 ?transition:string,?type:string,
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Fade the beginning of tracks. Metadata 'liq_video_fade_in' can be used to set the duration for a specific track (float in seconds).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (`float` -- defaults to `3.0`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `override` (`string` -- defaults to `"liq_video_fade_in"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
* `transition` (`string` -- defaults to `"fade"`): Kind of transition (fade|slide_left|slide_right|slide_up|slide_down|grow|disc|random).
* `type` (`string` -- defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.fade.initial
```
(?id:string,?duration:float,?transition:string,
 ?type:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Fade the beginning of a stream.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (`float` -- defaults to `3.0`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `transition` (`string` -- defaults to `"fade"`): Kind of transition (fade|slide_left|slide_right|slide_up|slide_down|grow|disc|random).
* `type` (`string` -- defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.fade.out
```
(?id:string,?duration:float,?override:string,
 ?transition:string,?type:string,
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Fade the end of tracks. Metadata 'liq_video_fade_out' can be used to set the duration for a specific track (float in seconds).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (`float` -- defaults to `3.0`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `override` (`string` -- defaults to `"liq_video_fade_out"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
* `transition` (`string` -- defaults to `"fade"`): Kind of transition (fade|slide_left|slide_right|slide_up|slide_down|grow|disc|random).
* `type` (`string` -- defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.fill
```
(?id:string,?color:int,
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Fill frame with a color.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `color` (`int` -- defaults to `0`): Color to fill the image with.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r._3_point_color_balance
```
(?id:string,?black_color:int,?gray_color:int,
 ?source_image_on_left_side:bool,?split_preview:bool,
 ?white_color:int,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Adjust color balance with 3 color points (by Maksim Golovkin).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `black_color` (`int` -- defaults to `0`): Black color.
* `gray_color` (`int` -- defaults to `8355711`): Gray color.
* `source_image_on_left_side` (`bool` -- defaults to `true`): Source image on left side.
* `split_preview` (`bool` -- defaults to `true`): Split privew.
* `white_color` (`int` -- defaults to `16777215`): White color.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r._3dflippo
```
(?id:string,?center_position:'a,?center_position:'b,
 ?don't_blank_mask:bool,?fill_with_image_or_black:bool,
 ?invert_rotation_assignment:bool,?x_axis_rotation:'c,
 ?x_axis_rotation_rate:'d,?y_axis_rotation:'e,
 ?y_axis_rotation_rate:'f,?z_axis_rotation:'g,
 ?z_axis_rotation_rate:'h,
 source(audio='#i,video='#j+1,midi='#k))->
source(audio='#i,video='#j+1,midi='#k)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g, 'h is either float or ()->float```

Frame rotation in 3d-space (by c.e. prelz AS FLUIDO <fluido(at)fluido.as>).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `center_position` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Position of the center of rotation on the X axis.
* `center_position` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Position of the center of rotation on the Y axis.
* `don't_blank_mask` (`bool` -- defaults to `false`): Mask for frame transposition is not blanked, so a trace of old transpositions is maintained.
* `fill_with_image_or_black` (`bool` -- defaults to `false`): If true, pixels that are not transposed are black, otherwise, they are copied with the original.
* `invert_rotation_assignment` (`bool` -- defaults to `false`): If true, when mapping rotation, make inverted (wrong) assignment.
* `x_axis_rotation` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Rotation on the X axis.
* `x_axis_rotation_rate` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Rotation rate on the X axis.
* `y_axis_rotation` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Rotation on the Y axis.
* `y_axis_rotation_rate` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Rotation rate on the Y axis.
* `z_axis_rotation` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Rotation on the Z axis.
* `z_axis_rotation_rate` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Rotation rate on the Z axis.
* `(unlabeled)` (`source(audio='#i,video='#j+1,midi='#k)`)

### video.frei0r.addition
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Perform an RGB[A] addition operation of the pixel sources (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.addition_alpha
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Perform an RGB[A] addition_alpha operation of the pixel sources (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.alpha0ps
```
(?id:string,?display:'a,?display_input_alpha:bool,
 ?invert:bool,?operation:'b,?shrink_grow_blur_amount:'c,
 ?threshold:'d,source(audio='#e,video='#f+1,midi='#g))->
source(audio='#e,video='#f+1,midi='#g)
where 'a, 'b, 'c, 'd is either float or ()->float```

Display and manipulation of the alpha channel (by Marko Cebokli).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `display` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): .
* `display_input_alpha` (`bool` -- defaults to `false`): .
* `invert` (`bool` -- defaults to `false`): .
* `operation` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): .
* `shrink_grow_blur_amount` (```
anything that is either float or ()->float```
 -- defaults to `0.333344429731`): .
* `threshold` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): .
* `(unlabeled)` (`source(audio='#e,video='#f+1,midi='#g)`)

### video.frei0r.alpha_injection
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Averages Input 1 and uses this as Alpha Channel on Input 2 (by Richard Spindler).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.alphaatop
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

The alpha ATOP operation (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.alphagrad
```
(?id:string,?max:'a,?min:'b,?operation:'c,?position:'d,
 ?tilt:'e,?transition_width:'f,
 source(audio='#g,video='#h+1,midi='#i))->
source(audio='#g,video='#h+1,midi='#i)
where 'a, 'b, 'c, 'd, 'e, 'f is either float or ()->float```

Fills alpha channel with a gradient (by Marko Cebokli).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `max` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): .
* `min` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): .
* `operation` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): .
* `position` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): .
* `tilt` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): .
* `transition_width` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): .
* `(unlabeled)` (`source(audio='#g,video='#h+1,midi='#i)`)

### video.frei0r.alphain
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

The alpha IN operation (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.alphaout
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

The alpha OUT operation (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.alphaover
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

The alpha OVER operation (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.alphaspot
```
(?id:string,?max:'a,?min:'b,?operation:'c,?position_x:'d,
 ?position_y:'e,?shape:'f,?size_x:'g,?size_y:'h,?tilt:'i,
 ?transition_width:'j,
 source(audio='#k,video='#l+1,midi='#m))->
source(audio='#k,video='#l+1,midi='#m)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g, 'h, 'i, 'j is either float or ()->float```

Draws simple shapes into the alpha channel (by Marko Cebokli).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `max` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): .
* `min` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): .
* `operation` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): .
* `position_x` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): .
* `position_y` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): .
* `shape` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): .
* `size_x` (```
anything that is either float or ()->float```
 -- defaults to `0.10000000149`): .
* `size_y` (```
anything that is either float or ()->float```
 -- defaults to `0.10000000149`): .
* `tilt` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): .
* `transition_width` (```
anything that is either float or ()->float```
 -- defaults to `0.20000000298`): .
* `(unlabeled)` (`source(audio='#k,video='#l+1,midi='#m)`)

### video.frei0r.alphaxor
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

The alpha XOR operation (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.b
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Extracts Blue from Image (by Richard Spindler).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.baltan
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Delayed alpha smoothed blit of time (by Kentaro, Jaromil).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.blend
```
(?id:string,?blend:'a,
 source(audio='#b,video='#c+1,midi='#d),
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either float or ()->float```

Perform a blend operation between two sources (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `blend` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): blend factor.
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.frei0r.bluescreen0r
```
(?id:string,?color:int,?distance:'a,
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either float or ()->float```

Color to alpha (blit SRCALPHA) (by Hedde Bosman).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `color` (`int` -- defaults to `61184`): The color to make transparent (B G R).
* `distance` (```
anything that is either float or ()->float```
 -- defaults to `0.288`): Distance to Color (127 is good).
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.frei0r.brightness
```
(?id:string,?brightness:'a,
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either float or ()->float```

Adjusts the brightness of a source image (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `brightness` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): The brightness value.
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.frei0r.burn
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Perform an RGB[A] dodge operation between the pixel sources, using the generalised algorithm:
D = saturation of 255 or depletion of 0, of ((255 - A) * 256) / (B + 1) (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.bw0r
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Turns image black/white (by coma(at)gephex.org).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.c0rners
```
(?id:string,?alpha_operation:'a,?corner_1_x:'b,
 ?corner_1_y:'c,?corner_2_x:'d,?corner_2_y:'e,
 ?corner_3_x:'f,?corner_3_y:'g,?corner_4_x:'h,
 ?corner_4_y:'i,?enable_stretch:bool,?feather_alpha:'j,
 ?interpolator:'k,?stretch_x:'l,?stretch_y:'m,
 ?transparent_background:bool,
 source(audio='#n,video='#o+1,midi='#p))->
source(audio='#n,video='#o+1,midi='#p)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g, 'h, 'i, 'j, 'k, 'l, 'm is either float or ()->float```

Four corners geometry engine (by Marko Cebokli).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `alpha_operation` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): .
* `corner_1_x` (```
anything that is either float or ()->float```
 -- defaults to `0.33333298564`): X coordinate of corner 1.
* `corner_1_y` (```
anything that is either float or ()->float```
 -- defaults to `0.33333298564`): Y coordinate of corner 1.
* `corner_2_x` (```
anything that is either float or ()->float```
 -- defaults to `0.666665971279`): X coordinate of corner 2.
* `corner_2_y` (```
anything that is either float or ()->float```
 -- defaults to `0.33333298564`): Y coordinate of corner 2.
* `corner_3_x` (```
anything that is either float or ()->float```
 -- defaults to `0.666665971279`): X coordinate of corner 3.
* `corner_3_y` (```
anything that is either float or ()->float```
 -- defaults to `0.666665971279`): Y coordinate of corner 3.
* `corner_4_x` (```
anything that is either float or ()->float```
 -- defaults to `0.33333298564`): X coordinate of corner 4.
* `corner_4_y` (```
anything that is either float or ()->float```
 -- defaults to `0.666665971279`): Y coordinate of corner 4.
* `enable_stretch` (`bool` -- defaults to `false`): Enable stretching.
* `feather_alpha` (```
anything that is either float or ()->float```
 -- defaults to `0.00999999977648`): Makes smooth transition into transparent.
* `interpolator` (```
anything that is either float or ()->float```
 -- defaults to `0.166666671634`): Quality of interpolation.
* `stretch_x` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Amount of stretching in X direction.
* `stretch_y` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Amount of stretching in Y direction.
* `transparent_background` (`bool` -- defaults to `false`): Makes background transparent.
* `(unlabeled)` (`source(audio='#n,video='#o+1,midi='#p)`)

### video.frei0r.cartoon
```
(?id:string,?diffspace:'a,?triplevel:'b,
 source(audio='#c,video='#d+1,midi='#e))->
source(audio='#c,video='#d+1,midi='#e)
where 'a, 'b is either float or ()->float```

Cartoonify video, do a form of edge detect (by Dries Pruimboom, Jaromil).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `diffspace` (```
anything that is either float or ()->float```
 -- defaults to `0.00390625`): difference space: a value from 0 to 256 (mapped to [0,1]).
* `triplevel` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): level of trip: mapped to [0,1] asymptotical.
* `(unlabeled)` (`source(audio='#c,video='#d+1,midi='#e)`)

### video.frei0r.color_distance
```
(?id:string,?color:int,
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Calculates the distance between the selected color and the current pixel and uses that value as new pixel value (by Richard Spindler).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `color` (`int` -- defaults to `8355711`): The Source Color.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.color_only
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Perform a conversion to color only of the source input1 using the hue and saturation values of input2 (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.coloradj_rgb
```
(?id:string,?action:'a,?alpha_controlled:bool,?b:'b,
 ?g:'c,?keep_luma:bool,?luma_formula:'d,?r:'e,
 source(audio='#f,video='#g+1,midi='#h))->
source(audio='#f,video='#g+1,midi='#h)
where 'a, 'b, 'c, 'd, 'e is either float or ()->float```

Simple color adjustment (by Marko Cebokli).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `action` (```
anything that is either float or ()->float```
 -- defaults to `0.333344429731`): Type of color adjustment.
* `alpha_controlled` (`bool` -- defaults to `false`): Adjust only areas with nonzero alpha.
* `b` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Amount of blue.
* `g` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Amount of green.
* `keep_luma` (`bool` -- defaults to `true`): Don't change brightness.
* `luma_formula` (```
anything that is either float or ()->float```
 -- defaults to `0.500025033951`): .
* `r` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Amount of red.
* `(unlabeled)` (`source(audio='#f,video='#g+1,midi='#h)`)

### video.frei0r.colorhalftone
```
(?id:string,?cyan_angle:'a,?dot_radius:'b,
 ?magenta_angle:'c,?yellow_angle:'d,
 source(audio='#e,video='#f+1,midi='#g))->
source(audio='#e,video='#f+1,midi='#g)
where 'a, 'b, 'c, 'd is either float or ()->float```

Filters image to resemble a halftone print in which tones are represented as variable sized dots (by Janne Liljeblad).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `cyan_angle` (```
anything that is either float or ()->float```
 -- defaults to `0.3`): Cyan dots angle.
* `dot_radius` (```
anything that is either float or ()->float```
 -- defaults to `0.4`): Halftone pattern dot size.
* `magenta_angle` (```
anything that is either float or ()->float```
 -- defaults to `0.45`): Magenta dots angle.
* `yellow_angle` (```
anything that is either float or ()->float```
 -- defaults to `0.25`): Yellow dots angle.
* `(unlabeled)` (`source(audio='#e,video='#f+1,midi='#g)`)

### video.frei0r.colorize
```
(?id:string,?hue:'a,?lightness:'b,?saturation:'c,
 source(audio='#d,video='#e+1,midi='#f))->
source(audio='#d,video='#e+1,midi='#f)
where 'a, 'b, 'c is either float or ()->float```

Colorizes image to selected hue, saturation and lightness (by Janne Liljeblad).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `hue` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Color shade of the colorized image.
* `lightness` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Lightness of the colorized image.
* `saturation` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Amount of color in the colorized image.
* `(unlabeled)` (`source(audio='#d,video='#e+1,midi='#f)`)

### video.frei0r.colortap
```
(?id:string,?table:string,
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Applies a pre-made color effect to image (by Janne Liljeblad).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `table` (`string` -- defaults to `"\128\192\241\229\233\127"`): Lookup table used to filter colors. One of: xpro, sepia, heat, red_green, old_photo, xray, esses, yellow_blue.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.composition
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Composites Image 2 onto Image 1 according to its Alpha Channel (by Richard Spindler).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.contrast0r
```
(?id:string,?contrast:'a,
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either float or ()->float```

Adjusts the contrast of a source image (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `contrast` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): The contrast value.
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.frei0r.darken
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Perform a darken operation between two sources (minimum value of both sources) (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.defish0r
```
(?id:string,?amount:'a,?aspect_type:'b,?defish:bool,
 ?interpolator:'c,?manual_aspect:'d,?manual_scale:'e,
 ?scaling:'f,?type:'g,
 source(audio='#h,video='#i+1,midi='#j))->
source(audio='#h,video='#i+1,midi='#j)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g is either float or ()->float```

Non rectilinear lens mappings (by Marko Cebokli).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `amount` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Focal Ratio.
* `aspect_type` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Pixel aspect ratio presets.
* `defish` (`bool` -- defaults to `false`): Fish or Defish.
* `interpolator` (```
anything that is either float or ()->float```
 -- defaults to `0.166666671634`): Quality of interpolation.
* `manual_aspect` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Manual Pixel Aspect ratio.
* `manual_scale` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Manual Scale.
* `scaling` (```
anything that is either float or ()->float```
 -- defaults to `0.666666686535`): Scaling method.
* `type` (```
anything that is either float or ()->float```
 -- defaults to `0.666666686535`): Mapping function.
* `(unlabeled)` (`source(audio='#h,video='#i+1,midi='#j)`)

### video.frei0r.delay0r
```
(?id:string,?delaytime:'a,
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either float or ()->float```

Video delay (by Martin Bayer).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `delaytime` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): the delay time.
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.frei0r.delaygrab
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Delayed frame blitting mapped on a time bitmap (by Bill Spinhover, Andreas Schiffler, Jaromil).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.difference
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Perform an RGB[A] difference operation between the pixel sources (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.distort0r
```
(?id:string,?amplitude:'a,?frequency:'b,
 source(audio='#c,video='#d+1,midi='#e))->
source(audio='#c,video='#d+1,midi='#e)
where 'a, 'b is either float or ()->float```

Plasma (by Gephex crew).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `amplitude` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): The amplitude of the plasma signal.
* `frequency` (```
anything that is either float or ()->float```
 -- defaults to `0.005`): The frequency of the plasma signal.
* `(unlabeled)` (`source(audio='#c,video='#d+1,midi='#e)`)

### video.frei0r.dither
```
(?id:string,?levels:'a,?matrixid:'b,
 source(audio='#c,video='#d+1,midi='#e))->
source(audio='#c,video='#d+1,midi='#e)
where 'a, 'b is either float or ()->float```

Dithers the image and reduces the number of available colors (by Janne Liljeblad).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `levels` (```
anything that is either float or ()->float```
 -- defaults to `0.104166666667`): Number of values per channel.
* `matrixid` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Id of matrix used for dithering.
* `(unlabeled)` (`source(audio='#c,video='#d+1,midi='#e)`)

### video.frei0r.divide
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Perform an RGB[A] divide operation between the pixel sources: input1 is the numerator, input2 the denominator (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.dodge
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Perform an RGB[A] dodge operation between the pixel sources, using the generalised algorithm:
D = saturation of 255 or (A * 256) / (256 - B) (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.edgeglow
```
(?id:string,?lredscale:'a,?lthresh:'b,?lupscale:'c,
 source(audio='#d,video='#e+1,midi='#f))->
source(audio='#d,video='#e+1,midi='#f)
where 'a, 'b, 'c is either float or ()->float```

Edgeglow filter (by Salsaman).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `lredscale` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): multiplier for downscaling non-edge brightness.
* `lthresh` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): threshold for edge lightening.
* `lupscale` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): multiplier for upscaling edge brightness.
* `(unlabeled)` (`source(audio='#d,video='#e+1,midi='#f)`)

### video.frei0r.emboss
```
(?id:string,?azimuth:'a,?elevation:'b,?width45:'c,
 source(audio='#d,video='#e+1,midi='#f))->
source(audio='#d,video='#e+1,midi='#f)
where 'a, 'b, 'c is either float or ()->float```

Creates embossed relief image of source image (by Janne Liljeblad).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `azimuth` (```
anything that is either float or ()->float```
 -- defaults to `0.375`): Light direction.
* `elevation` (```
anything that is either float or ()->float```
 -- defaults to `0.333333333333`): Background lightness.
* `width45` (```
anything that is either float or ()->float```
 -- defaults to `0.25`): Bump height.
* `(unlabeled)` (`source(audio='#d,video='#e+1,midi='#f)`)

### video.frei0r.equaliz0r
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Equalizes the intensity histograms (by Jean-Sebastien Senecal (Drone)).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.flippo
```
(?id:string,?x_axis:bool,?y_axis:bool,
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Flipping in x and y axis (by Carlo Emilio, Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `x_axis` (`bool` -- defaults to `false`): Flipping on the horizontal axis.
* `y_axis` (`bool` -- defaults to `false`): Flipping on the vertical axis.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.g
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Extracts Green from Image (by Richard Spindler).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.gamma
```
(?id:string,?gamma:'a,
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either float or ()->float```

Adjusts the gamma value of a source image (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `gamma` (```
anything that is either float or ()->float```
 -- defaults to `3.52371672488e-294`): The gamma value.
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.frei0r.glow
```
(?id:string,?blur:'a,
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either float or ()->float```

Creates a Glamorous Glow (by Richard Spindler).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `blur` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Blur of the glow.
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.frei0r.grain_extract
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Perform an RGB[A] grain-extract operation between the pixel sources (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.grain_merge
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Perform an RGB[A] grain-merge operation between the pixel sources (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.hardlight
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Perform an RGB[A] hardlight operation between the pixel sources (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.hqdn3d
```
(?id:string,?spatial:'a,?temporal:'b,
 source(audio='#c,video='#d+1,midi='#e))->
source(audio='#c,video='#d+1,midi='#e)
where 'a, 'b is either float or ()->float```

High quality 3D denoiser from Mplayer (by Marko Cebokli, Daniel Moreno).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `spatial` (```
anything that is either float or ()->float```
 -- defaults to `0.0399999991059`): Amount of spatial filtering.
* `temporal` (```
anything that is either float or ()->float```
 -- defaults to `0.0599999986589`): Amount of temporal filtering.
* `(unlabeled)` (`source(audio='#c,video='#d+1,midi='#e)`)

### video.frei0r.hue
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Perform a conversion to hue only of the source input1 using the hue of input2 (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.hueshift0r
```
(?id:string,?hue:'a,
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either float or ()->float```

Shifts the hue of a source image (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `hue` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): The shift value.
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.frei0r.iir_blur
```
(?id:string,?amount:'a,?edge:bool,?type:'b,
 source(audio='#c,video='#d+1,midi='#e))->
source(audio='#c,video='#d+1,midi='#e)
where 'a, 'b is either float or ()->float```

Three types of fast IIR blurring (by Marko Cebokli).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `amount` (```
anything that is either float or ()->float```
 -- defaults to `0.200000017881`): Amount of blur.
* `edge` (`bool` -- defaults to `true`): Edge compensation.
* `type` (```
anything that is either float or ()->float```
 -- defaults to `0.333344429731`): Blur type.
* `(unlabeled)` (`source(audio='#c,video='#d+1,midi='#e)`)

### video.frei0r.invert0r
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Inverts all colors of a source image (by Gephex crew).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.ising0r
```
(?id:string,?border_growth:'a,?spontaneous_growth:'b,
 ?temperature:'c)->source(audio=0,video=1,midi=0)
where 'a, 'b, 'c is either float or ()->float```

Generates ising noise (by Gephex crew).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `border_growth` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Border Growth.
* `spontaneous_growth` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Spontaneous Growth.
* `temperature` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Noise Temperature.

### video.frei0r.k_means_clustering
```
(?id:string,?dist_weight:'a,?num:'b,
 source(audio='#c,video='#d+1,midi='#e))->
source(audio='#c,video='#d+1,midi='#e)
where 'a, 'b is either float or ()->float```

Clusters of a source image by color and spatial distance (by binarymillenium).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `dist_weight` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): The weight on distance.
* `num` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): The number of clusters.
* `(unlabeled)` (`source(audio='#c,video='#d+1,midi='#e)`)

### video.frei0r.lens_correction
```
(?id:string,?brightness:'a,?correctionnearcenter:'b,
 ?correctionnearedges:'c,?xcenter:'d,?ycenter:'e,
 source(audio='#f,video='#g+1,midi='#h))->
source(audio='#f,video='#g+1,midi='#h)
where 'a, 'b, 'c, 'd, 'e is either float or ()->float```

Allows compensation of lens distortion (by Richard Spindler).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `brightness` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): .
* `correctionnearcenter` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): .
* `correctionnearedges` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): .
* `xcenter` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): .
* `ycenter` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): .
* `(unlabeled)` (`source(audio='#f,video='#g+1,midi='#h)`)

### video.frei0r.letterb0xed
```
(?id:string,?border_width:'a,?transparency:bool,
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either float or ()->float```

Adds Black Borders at top and bottom for Cinema Look (by Richard Spindler).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `border_width` (```
anything that is either float or ()->float```
 -- defaults to `0.4`): .
* `transparency` (`bool` -- defaults to `false`): .
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.frei0r.levels
```
(?id:string,?black_output:'a,?channel:'b,?gamma:'c,
 ?histogram_position:'d,?input_black_level:'e,
 ?input_white_level:'f,?show_histogram:bool,
 ?white_output:'g,source(audio='#h,video='#i+1,midi='#j))->
source(audio='#h,video='#i+1,midi='#j)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g is either float or ()->float```

Adjust luminance or color channel intensity (by Maksim Golovkin).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `black_output` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Black output.
* `channel` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Channel to adjust levels.
* `gamma` (```
anything that is either float or ()->float```
 -- defaults to `0.25`): Gamma.
* `histogram_position` (```
anything that is either float or ()->float```
 -- defaults to `0.3`): Histogram position.
* `input_black_level` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Input black level.
* `input_white_level` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): Input white level.
* `show_histogram` (`bool` -- defaults to `true`): Show histogram.
* `white_output` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): White output.
* `(unlabeled)` (`source(audio='#h,video='#i+1,midi='#j)`)

### video.frei0r.light_graffiti
```
(?id:string,?backgroundweight:'a,?blackreference:'b,
 ?dim:'c,?longalpha:'d,?loweroverexposure:'e,
 ?nonlineardim:'f,?reset:'g,?saturation:'h,
 ?sensitivity:'i,?statsbrightness:'j,?statsdifference:'k,
 ?statsdiffsum:'l,?thresholdbrightness:'m,
 ?thresholddifference:'n,?thresholddiffsum:'o,
 ?transparentbackground:'p,
 source(audio='#q,video='#r+1,midi='#s))->
source(audio='#q,video='#r+1,midi='#s)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g, 'h, 'i, 'j, 'k, 'l, 'm, 'n, 'o, 'p is either float or ()->float```

Creates light graffitis from a video by keeping the brightest spots (by Simon A. Eugster (Granjow)).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `backgroundweight` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Describes how strong the (accumulated) background should shine through.
* `blackreference` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Uses black as background image instead of the first frame..
* `dim` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Dimming of the light mask.
* `longalpha` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Alpha value for moving average.
* `loweroverexposure` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Prevents some overexposure if the light source stays steady too long (varying speed).
* `nonlineardim` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Nonlinear dimming (may look more natural).
* `reset` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Reset filter masks.
* `saturation` (```
anything that is either float or ()->float```
 -- defaults to `0.25`): Saturation of lights.
* `sensitivity` (```
anything that is either float or ()->float```
 -- defaults to `0.2`): Sensitivity of the effect for light (higher sensitivity will lead to brighter lights).
* `statsbrightness` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Display the brightness and threshold, for adjusting the brightness threshold parameter.
* `statsdifference` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Display the background difference and threshold.
* `statsdiffsum` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Display the sum of the background difference and the threshold.
* `thresholdbrightness` (```
anything that is either float or ()->float```
 -- defaults to `0.588235294118`): Brightness threshold to distinguish between foreground and background.
* `thresholddifference` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Threshold: Difference to background to distinguish between fore- and background.
* `thresholddiffsum` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Threshold for sum of differences. Can in most cases be ignored (set to 0)..
* `transparentbackground` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Make the background transparent.
* `(unlabeled)` (`source(audio='#q,video='#r+1,midi='#s)`)

### video.frei0r.lighten
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Perform a lighten operation between two sources (maximum value of both sources) (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.lissajous0r
```
(?id:string,?ratiox:'a,?ratioy:'b)->
source(audio=0,video=1,midi=0)
where 'a, 'b is either float or ()->float```

Generates Lissajous0r images (by Martin Bayer).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `ratiox` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): x-ratio.
* `ratioy` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): y-ratio.

### video.frei0r.luminance
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Creates a luminance map of the image (by Richard Spindler).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.mask0mate
```
(?id:string,?blur:'a,?bottom:'b,?invert:bool,?left:'c,
 ?right:'d,?top:'e,
 source(audio='#f,video='#g+1,midi='#h))->
source(audio='#f,video='#g+1,midi='#h)
where 'a, 'b, 'c, 'd, 'e is either float or ()->float```

Creates an square alpha-channel mask (by Richard Spindler).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `blur` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Blur the outline of the mask.
* `bottom` (```
anything that is either float or ()->float```
 -- defaults to `0.2`): .
* `invert` (`bool` -- defaults to `false`): Invert the mask, creates a hole in the frame..
* `left` (```
anything that is either float or ()->float```
 -- defaults to `0.2`): .
* `right` (```
anything that is either float or ()->float```
 -- defaults to `0.2`): .
* `top` (```
anything that is either float or ()->float```
 -- defaults to `0.2`): .
* `(unlabeled)` (`source(audio='#f,video='#g+1,midi='#h)`)

### video.frei0r.medians
```
(?id:string,?size:'a,?type:string,
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either float or ()->float```

Implements several median-type filters (by Marko Cebokli).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `size` (```
anything that is either float or ()->float```
 -- defaults to `0.10000000149`): Size for 'var size' type filter.
* `type` (`string` -- defaults to `"\192\188\224\229\233\127"`): Choose type of median: Cross5, Square3x3, Bilevel, Diamond3x3, Square5x5, Temp3, Temp5, ArceBI, ML3D, ML3dEX, VarSize.
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.frei0r.multiply
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Perform an RGB[A] multiply operation between the pixel sources (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.nervous
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Flushes frames in time in a nervous way (by Tannenbaum, Kentaro, Jaromil).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.nikon_d90_stairstepping_fix
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Removes the Stairstepping from Nikon D90 videos (720p only) by interpolation (by Simon A. Eugster (Granjow)).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.nois0r
```
(?id:string)->source(audio=0,video=1,midi=0)```

Generates white noise images (by Martin Bayer).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.

### video.frei0r.nosync0r
```
(?id:string,?hsync:'a,
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either float or ()->float```

Broken tv (by Martin Bayer).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `hsync` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): the hsync offset.
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.frei0r.onecol0r
```
(?id:string,?color:int)->source(audio=0,video=1,midi=0)```

Image with just one color (by Martin Bayer).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `color` (`int` -- defaults to `0`): the color of the image.

### video.frei0r.overlay
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Perform an RGB[A] overlay operation between the pixel sources, using the generalised algorithm:
D = A * (B + (2 * B) * (255 - A)) (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.partik0l
```
(?id:string,?down:'a,?up:'b)->
source(audio=0,video=1,midi=0)
where 'a, 'b is either float or ()->float```

Particles generated on prime number sinusoidal blossoming (by Jaromil).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `down` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): blossom on a lower prime number.
* `up` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): blossom on a higher prime number.

### video.frei0r.perspective
```
(?id:string,?bottom_left:(float*float),
 ?bottom_right:(float*float),?top_left:(float*float),
 ?top_right:(float*float),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Distorts the image for a pseudo perspective (by Richard Spindler).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `bottom_left` (`(float*float)` -- defaults to `(0.0,1.0)`): .
* `bottom_right` (`(float*float)` -- defaults to `(1.0,1.0)`): .
* `top_left` (`(float*float)` -- defaults to `(0.0,0.0)`): .
* `top_right` (`(float*float)` -- defaults to `(1.0,0.0)`): .
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.pixeliz0r
```
(?id:string,?blocksizex:'a,?blocksizey:'b,
 source(audio='#c,video='#d+1,midi='#e))->
source(audio='#c,video='#d+1,midi='#e)
where 'a, 'b is either float or ()->float```

Pixelize input image (by Gephex crew).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `blocksizex` (```
anything that is either float or ()->float```
 -- defaults to `inf`): Horizontal size of one ``pixel''.
* `blocksizey` (```
anything that is either float or ()->float```
 -- defaults to `inf`): Vertical size of one ``pixel''.
* `(unlabeled)` (`source(audio='#c,video='#d+1,midi='#e)`)

### video.frei0r.plasma
```
(?id:string,?_1_move:'a,?_1_speed:'b,?_2_move:'c,
 ?_2_speed:'d,?_3_speed:'e,?_4_speed:'f)->
source(audio=0,video=1,midi=0)
where 'a, 'b, 'c, 'd, 'e, 'f is either float or ()->float```

Demo scene 8bit plasma (by Jaromil).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `_1_move` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): .
* `_1_speed` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): .
* `_2_move` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): .
* `_2_speed` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): .
* `_3_speed` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): .
* `_4_speed` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): .

### video.frei0r.posterize
```
(?id:string,?levels:'a,
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either float or ()->float```

Posterizes image by reducing the number of colors used in image (by Janne Liljeblad).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `levels` (```
anything that is either float or ()->float```
 -- defaults to `0.104166666667`): Number of values per channel.
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.frei0r.pr0be
```
(?id:string,?_256_scale:bool,?big_window:bool,
 ?measurement:'a,?show_alpha:bool,?x:'b,?x_size:'c,?y:'d,
 ?y_size:'e,source(audio='#f,video='#g+1,midi='#h))->
source(audio='#f,video='#g+1,midi='#h)
where 'a, 'b, 'c, 'd, 'e is either float or ()->float```

Measure video values (by Marko Cebokli).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `_256_scale` (`bool` -- defaults to `false`): use 0-255 instead of 0.0-1.0.
* `big_window` (`bool` -- defaults to `false`): Display more data.
* `measurement` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): What measurement to display.
* `show_alpha` (`bool` -- defaults to `false`): Display alpha value too.
* `x` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): X position of probe.
* `x_size` (```
anything that is either float or ()->float```
 -- defaults to `0.25`): X size of probe.
* `y` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Y position of probe.
* `y_size` (```
anything that is either float or ()->float```
 -- defaults to `0.25`): Y size of probe.
* `(unlabeled)` (`source(audio='#f,video='#g+1,midi='#h)`)

### video.frei0r.pr0file
```
(?id:string,?_256_scale:bool,?alpha_trace:bool,
 ?b_trace:bool,?channel:'a,?color:'b,?crosshair_color:'c,
 ?display_average:bool,?display_maximum:bool,
 ?display_minimum:bool,?display_rms:bool,?g_trace:bool,
 ?length:'d,?marker_1:'e,?marker_2:'f,?pb_trace:bool,
 ?pr_trace:bool,?r_trace:bool,?tilt:'g,?x:'h,?y:'i,
 ?y_trace:bool,source(audio='#j,video='#k+1,midi='#l))->
source(audio='#j,video='#k+1,midi='#l)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g, 'h, 'i is either float or ()->float```

2D video oscilloscope (by Marko Cebokli).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `_256_scale` (`bool` -- defaults to `false`): use 0-255 instead of 0.0-1.0.
* `alpha_trace` (`bool` -- defaults to `false`): Show Alpha trace on scope.
* `b_trace` (`bool` -- defaults to `true`): Show B trace on scope.
* `channel` (```
anything that is either float or ()->float```
 -- defaults to `0.375004708767`): Channel to numerically display.
* `color` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): rec 601 or rec 709.
* `crosshair_color` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Color of the profile marker.
* `display_average` (`bool` -- defaults to `true`): e.
* `display_maximum` (`bool` -- defaults to `false`): .
* `display_minimum` (`bool` -- defaults to `false`): .
* `display_rms` (`bool` -- defaults to `true`): .
* `g_trace` (`bool` -- defaults to `true`): Show G trace on scope.
* `length` (```
anything that is either float or ()->float```
 -- defaults to `1.07609117031`): Length of profile.
* `marker_1` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Position of marker 1.
* `marker_2` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Position of marker 2.
* `pb_trace` (`bool` -- defaults to `false`): Show Pb trace on scope.
* `pr_trace` (`bool` -- defaults to `false`): Show Pr trace on scope.
* `r_trace` (`bool` -- defaults to `true`): Show R trace on scope.
* `tilt` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Tilt of profile.
* `x` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): X position of profile.
* `y` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Y position of profile.
* `y_trace` (`bool` -- defaults to `false`): Show Y' trace on scope.
* `(unlabeled)` (`source(audio='#j,video='#k+1,midi='#l)`)

### video.frei0r.primaries
```
(?id:string,?factor:'a,
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either float or ()->float```

Reduce image to primary colors (by Hedde Bosman).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `factor` (```
anything that is either float or ()->float```
 -- defaults to `1.0`): influence of mean px value. > 32 = 0.
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.frei0r.r
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Extracts Red from Image (by Richard Spindler).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.rgbnoise
```
(?id:string,?noise:'a,
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either float or ()->float```

Adds RGB noise to image (by Janne Liljeblad).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `noise` (```
anything that is either float or ()->float```
 -- defaults to `0.2`): Amount of noise added.
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.frei0r.saturat0r
```
(?id:string,?saturation:'a,
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either float or ()->float```

Adjusts the saturation of a source image (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `saturation` (```
anything that is either float or ()->float```
 -- defaults to `0.125`): The saturation value.
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.frei0r.saturation
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Perform a conversion to saturation only of the source input1 using the saturation level of input2 (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.scanline0r
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Interlaced blak lines (by Martin Bayer).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.screen
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Perform an RGB[A] screen operation between the pixel sources, using the generalised algorithm:
D = 255 - (255 - A) * (255 - B) (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.select0r
```
(?id:string,?color_to_select:int,?delta_b___i___i:'a,
 ?delta_g___b___chroma:'b,?delta_r___a___hue:'c,
 ?edge_mode:'d,?invert_selection:bool,?operation:'e,
 ?selection_subspace:'f,?slope:'g,?subspace_shape:'h,
 source(audio='#i,video='#j+1,midi='#k))->
source(audio='#i,video='#j+1,midi='#k)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g, 'h is either float or ()->float```

Color based alpha selection (by Marko Cebokli).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `color_to_select` (`int` -- defaults to `52224`): .
* `delta_b___i___i` (```
anything that is either float or ()->float```
 -- defaults to `0.20000000298`): .
* `delta_g___b___chroma` (```
anything that is either float or ()->float```
 -- defaults to `0.20000000298`): .
* `delta_r___a___hue` (```
anything that is either float or ()->float```
 -- defaults to `0.20000000298`): .
* `edge_mode` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): .
* `invert_selection` (`bool` -- defaults to `false`): .
* `operation` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): .
* `selection_subspace` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): .
* `slope` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): .
* `subspace_shape` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): .
* `(unlabeled)` (`source(audio='#i,video='#j+1,midi='#k)`)

### video.frei0r.sharpness
```
(?id:string,?amount:'a,?size:'b,
 source(audio='#c,video='#d+1,midi='#e))->
source(audio='#c,video='#d+1,midi='#e)
where 'a, 'b is either float or ()->float```

Unsharp masking (port from Mplayer) (by Marko Cebokli, Remi Guyomarch).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `amount` (```
anything that is either float or ()->float```
 -- defaults to `0.300000011921`): .
* `size` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): .
* `(unlabeled)` (`source(audio='#c,video='#d+1,midi='#e)`)

### video.frei0r.sigmoidaltransfer
```
(?id:string,?brightness:'a,?sharpness:'b,
 source(audio='#c,video='#d+1,midi='#e))->
source(audio='#c,video='#d+1,midi='#e)
where 'a, 'b is either float or ()->float```

Desaturates image and creates a particular look that could be called Stamp, Newspaper or Photocopy (by Janne Liljeblad).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `brightness` (```
anything that is either float or ()->float```
 -- defaults to `0.75`): Brightnesss of image.
* `sharpness` (```
anything that is either float or ()->float```
 -- defaults to `0.85`): Sharpness of transfer.
* `(unlabeled)` (`source(audio='#c,video='#d+1,midi='#e)`)

### video.frei0r.sobel
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Sobel filter (by Jean-Sebastien Senecal (Drone)).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.softglow
```
(?id:string,?blur:'a,?blurblend:'b,?brightness:'c,
 ?sharpness:'d,source(audio='#e,video='#f+1,midi='#g))->
source(audio='#e,video='#f+1,midi='#g)
where 'a, 'b, 'c, 'd is either float or ()->float```

Does softglow effect on highlights (by Janne Liljeblad).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `blur` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Blur of the glow.
* `blurblend` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Blend mode used to blend highlight blur with input image.
* `brightness` (```
anything that is either float or ()->float```
 -- defaults to `0.75`): Brightness of highlight areas.
* `sharpness` (```
anything that is either float or ()->float```
 -- defaults to `0.85`): Sharpness of highlight areas.
* `(unlabeled)` (`source(audio='#e,video='#f+1,midi='#g)`)

### video.frei0r.softlight
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Perform an RGB[A] softlight operation between the pixel sources (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.sop_sat
```
(?id:string,?aoffset:'a,?apower:'b,?aslope:'c,
 ?boffset:'d,?bpower:'e,?bslope:'f,?goffset:'g,
 ?gpower:'h,?gslope:'i,?roffset:'j,?rpower:'k,?rslope:'l,
 ?saturation:'m,source(audio='#n,video='#o+1,midi='#p))->
source(audio='#n,video='#o+1,midi='#p)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g, 'h, 'i, 'j, 'k, 'l, 'm is either float or ()->float```

Slope/Offset/Power and Saturation color corrections according to the ASC CDL (Color Decision List) (by Simon A. Eugster (Granjow)).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `aoffset` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Offset of the alpha component.
* `apower` (```
anything that is either float or ()->float```
 -- defaults to `0.05`): Power (Gamma) of the alpha component.
* `aslope` (```
anything that is either float or ()->float```
 -- defaults to `0.05`): Slope of the alpha component.
* `boffset` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Offset of the blue color component.
* `bpower` (```
anything that is either float or ()->float```
 -- defaults to `0.05`): Power (Gamma) of the blue color component.
* `bslope` (```
anything that is either float or ()->float```
 -- defaults to `0.05`): Slope of the blue color component.
* `goffset` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Offset of the green color component.
* `gpower` (```
anything that is either float or ()->float```
 -- defaults to `0.05`): Power (Gamma) of the green color component.
* `gslope` (```
anything that is either float or ()->float```
 -- defaults to `0.05`): Slope of the green color component.
* `roffset` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Offset of the red color component.
* `rpower` (```
anything that is either float or ()->float```
 -- defaults to `0.05`): Power (Gamma) of the red color component.
* `rslope` (```
anything that is either float or ()->float```
 -- defaults to `0.05`): Slope of the red color component.
* `saturation` (```
anything that is either float or ()->float```
 -- defaults to `0.1`): Overall saturation.
* `(unlabeled)` (`source(audio='#n,video='#o+1,midi='#p)`)

### video.frei0r.spillsupress
```
(?id:string,?supresstype:'a,
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either float or ()->float```

Remove green or blue spill light from subjects shot in front of green or blue screen (by Janne Liljeblad).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `supresstype` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Defines if green or blue screen spill supress is applied.
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.frei0r.squareblur
```
(?id:string,?kernel_size:'a,
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either float or ()->float```

Variable-size square blur (by Drone).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `kernel_size` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): The size of the kernel, as a proportion to its coverage of the image.
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.frei0r.subtract
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Perform an RGB[A] subtract operation of the pixel source input2 from input1 (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.tehroxx0r
```
(?id:string,?interval:'a,
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either float or ()->float```

Something videowall-ish (by Coma).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `interval` (```
anything that is either float or ()->float```
 -- defaults to `0.01`): Changing speed of small blocks.
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.frei0r.test_pat_b
```
(?id:string,?aspect_type:'a,?manual_aspect:'b,?type:'c)->
source(audio=0,video=1,midi=0)
where 'a, 'b, 'c is either float or ()->float```

Generates test card lookalikes (by Marko Cebokli).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `aspect_type` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 7 choices, pixel aspect ratio.
* `manual_aspect` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Manual pixel aspect ratio (Aspect type 6).
* `type` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): 8 choices, select test pattern.

### video.frei0r.test_pat_c
```
(?id:string,?color_space:'a,?cross_section:'b,
 ?fullscreen:bool,?third_axis_value:'c)->
source(audio=0,video=1,midi=0)
where 'a, 'b, 'c is either float or ()->float```

Generates cross sections of color spaces (by Marko Cebokli).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `color_space` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): .
* `cross_section` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): .
* `fullscreen` (`bool` -- defaults to `false`): .
* `third_axis_value` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): .

### video.frei0r.test_pat_g
```
(?id:string,?aspect_type:'a,?manual_aspect:'b,
 ?negative:bool,?size_1:'c,?size_2:'d,?type:'e)->
source(audio=0,video=1,midi=0)
where 'a, 'b, 'c, 'd, 'e is either float or ()->float```

Generates geometry test pattern images (by Marko Cebokli).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `aspect_type` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Pixel aspect ratio presets.
* `manual_aspect` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Manual pixel aspect ratio.
* `negative` (`bool` -- defaults to `false`): Polarity of image.
* `size_1` (```
anything that is either float or ()->float```
 -- defaults to `0.28125`): Size of major features.
* `size_2` (```
anything that is either float or ()->float```
 -- defaults to `0.0625`): Size of minor features.
* `type` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Type of test pattern.

### video.frei0r.test_pat_i
```
(?id:string,?amplitude:'a,?channel:'b,?negative:bool,
 ?tilt:'c,?type:'d,?width:'e)->
source(audio=0,video=1,midi=0)
where 'a, 'b, 'c, 'd, 'e is either float or ()->float```

Generates spatial impulse and step test patterns (by Marko Cebokli).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `amplitude` (```
anything that is either float or ()->float```
 -- defaults to `0.800000011921`): Amplitude (contrast) of the pattern.
* `channel` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Into which color channel to draw.
* `negative` (`bool` -- defaults to `false`): Change polarity of impulse/step.
* `tilt` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Angle of step function.
* `type` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Type of test pattern.
* `width` (```
anything that is either float or ()->float```
 -- defaults to `0.0404040403664`): Width of impulse.

### video.frei0r.test_pat_l
```
(?id:string,?channel:'a,?type:'b)->
source(audio=0,video=1,midi=0)
where 'a, 'b is either float or ()->float```

Generates linearity checking patterns (by Marko Cebokli).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `channel` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Into which color channel to draw.
* `type` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Type of test pattern.

### video.frei0r.test_pat_r
```
(?id:string,?amplitude:'a,?aspect_type:'b,?channel:'c,
 ?freq_1:'d,?freq_2:'e,?lin_p_swp:bool,?manual_aspect:'f,
 ?type:'g)->source(audio=0,video=1,midi=0)
where
  'a, 'b, 'c, 'd, 'e, 'f, 'g is either float or ()->float```

Generates resolution test patterns (by Marko Cebokli).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `amplitude` (```
anything that is either float or ()->float```
 -- defaults to `0.800000011921`): Amplitude (contrast) of the pattern.
* `aspect_type` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Pixel aspect ratio presets.
* `channel` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Into which color channel to draw.
* `freq_1` (```
anything that is either float or ()->float```
 -- defaults to `0.0299999993294`): Pattern 7 H frequency.
* `freq_2` (```
anything that is either float or ()->float```
 -- defaults to `0.0299999993294`): Pattern 7 V frequency.
* `lin_p_swp` (`bool` -- defaults to `false`): Use linear period sweep.
* `manual_aspect` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Manual pixel aspect ratio.
* `type` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Type of test pattern.

### video.frei0r.threelay0r
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Dynamic 3 level thresholding (by Hedde Bosman).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.threshold0r
```
(?id:string,?threshold:'a,
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either float or ()->float```

Thresholds a source image (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `threshold` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): The threshold.
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.frei0r.timeout_indicator
```
(?id:string,?color:int,?time:'a,?transparency:'b,
 source(audio='#c,video='#d+1,midi='#e))->
source(audio='#c,video='#d+1,midi='#e)
where 'a, 'b is either float or ()->float```

Timeout indicators e.g. for slides (by Simon A. Eugster).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `color` (`int` -- defaults to `219053274609745920`): Indicator colour.
* `time` (```
anything that is either float or ()->float```
 -- defaults to `1.08227592478e-304`): Current time.
* `transparency` (```
anything that is either float or ()->float```
 -- defaults to `nan`): Indicator transparency.
* `(unlabeled)` (`source(audio='#c,video='#d+1,midi='#e)`)

### video.frei0r.tint0r
```
(?id:string,?map_black_to:int,?map_white_to:int,
 ?tint_amount:'a,source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either float or ()->float```

Tint a source image with specified color (by Maksim Golovkin).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `map_black_to` (`int` -- defaults to `0`): The color to map source color with null luminance.
* `map_white_to` (`int` -- defaults to `8388479`): The color to map source color with full luminance.
* `tint_amount` (```
anything that is either float or ()->float```
 -- defaults to `0.25`): Amount of color.
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.frei0r.transparency
```
(?id:string,?transparency:'a,
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either float or ()->float```

Tunes the alpha channel (by Richard Spindler).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `transparency` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): The transparency value.
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.frei0r.twolay0r
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Dynamic thresholding (by Martin Bayer).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.uv_map
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Uses Input 1 as UV Map to distort Input 2 (by Richard Spindler).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.value
```
(?id:string,source(audio='#a,video='#b+1,midi='#c),
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Perform a conversion to value only of the source input1 using the value of input2 (by Jean-Sebastien Senecal).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.frei0r.vertigo
```
(?id:string,?phaseincrement:'a,?zoomrate:'b,
 source(audio='#c,video='#d+1,midi='#e))->
source(audio='#c,video='#d+1,midi='#e)
where 'a, 'b is either float or ()->float```

Alpha blending with zoomed and rotated images (by Fukuchi Kentarou).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `phaseincrement` (```
anything that is either float or ()->float```
 -- defaults to `0.02`): Phase increment.
* `zoomrate` (```
anything that is either float or ()->float```
 -- defaults to `0.202`): Zoomrate.
* `(unlabeled)` (`source(audio='#c,video='#d+1,midi='#e)`)

### video.frei0r.vignette
```
(?id:string,?aspect:'a,?clearcenter:'b,?soft:'c,
 source(audio='#d,video='#e+1,midi='#f))->
source(audio='#d,video='#e+1,midi='#f)
where 'a, 'b, 'c is either float or ()->float```

Lens vignetting effect, applies natural vignetting (by Simon A. Eugster (Granjow)).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `aspect` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Aspect ratio.
* `clearcenter` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Size of the unaffected center.
* `soft` (```
anything that is either float or ()->float```
 -- defaults to `0.6`): Softness.
* `(unlabeled)` (`source(audio='#d,video='#e+1,midi='#f)`)

### video.frei0r.white_balance
```
(?id:string,?color_temperature:'a,?neutral_color:int,
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either float or ()->float```

Do simple color correction, in a physically meaningful way (by Steinar H. Gunderson).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `color_temperature` (```
anything that is either float or ()->float```
 -- defaults to `0.433333333333`): Choose an output color temperature, if different from 6500 K..
* `neutral_color` (`int` -- defaults to `8355711`): Choose a color from the source image that should be white..
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.frei0r.xfade0r
```
(?id:string,?fader:'a,
 source(audio='#b,video='#c+1,midi='#d),
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either float or ()->float```

A simple xfader (by Martin Bayer).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `fader` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): the fader position.
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

### video.greyscale
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Convert video to greyscale.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.invert
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Invert video.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.lomo
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Emulate the ``Lomo effect''.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.opacity
```
(?id:string,float,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Scale opacity of video.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`float`): Coefficient to scale opacity with.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.opacity.blur
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Blur opacity of video.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.rotate
```
(?id:string,?angle:'a,?speed:'b,
 source(audio='#c,video='#d+1,midi='#e))->
source(audio='#c,video='#d+1,midi='#e)
where 'a, 'b is either float or ()->float```

Rotate video.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `angle` (```
anything that is either float or ()->float```
 -- defaults to `0.0`): Initial angle in radians.
* `speed` (```
anything that is either float or ()->float```
 -- defaults to `3.14159265359`): Rotation speed in radians per sec.
* `(unlabeled)` (`source(audio='#c,video='#d+1,midi='#e)`)

### video.scale
```
(?id:string,?scale:float,?x:int,?xscale:float,?y:int,
 ?yscale:float,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Scale and translate video.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `scale` (`float` -- defaults to `1.0`): Scaling coefficient in both directions.
* `x` (`int` -- defaults to `0`): x offset.
* `xscale` (`float` -- defaults to `1.0`): x scaling.
* `y` (`int` -- defaults to `0`): y offset.
* `yscale` (`float` -- defaults to `1.0`): y scaling.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.sepia
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Convert video to sepia.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

### video.tile
```
(?id:string,?normalize:bool,?proportional:bool,
 ?weights:[int],[source(audio='#a,video='#b+1,midi='#c)])->
source(audio='#a,video='#b+1,midi='#c)```

Tile sources (same as add but produces tiles of videos).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `normalize` (`bool` -- defaults to `true`)
* `proportional` (`bool` -- defaults to `true`): Scale preserving the proportions.
* `weights` (`[int]` -- defaults to `[]`): Relative weight of the sources in the sum. The empty list stands for the homogeneous distribution.
* `(unlabeled)` (```
[source(audio='#a,video='#b+1,midi='#c)]```
)

### video.transparent
```
(?id:string,?color:int,?precision:float,
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Set a color to be transparent.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `color` (`int` -- defaults to `0`): Color which should be transparent (in 0xRRGGBB format).
* `precision` (`float` -- defaults to `0.0`): Precision in color matching (0. means match precisely the color and 1. means match every color).
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

Source / Visualization
----------------------
### peak
```
(?id:string,?duration:'a,
 source(audio='#b,video='#c,midi='#d))->
((()->float)*source(audio='#b,video='#c,midi='#d))
where 'a is either float or ()->float```

Get current peak volume of the source. Returns a pair `(f,s)` where s is a new source and `f` is a function of type `() -> float` and returns the current peak volume of the source.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Duration of the window (in seconds). A value <= 0, means that computation should not be performed.
* `(unlabeled)` (`source(audio='#b,video='#c,midi='#d)`)

### peak.stereo
```
(?id:string,?duration:'a,
 source(audio='#b+2,video='#c,midi='#d))->
((()->(float*float))*
 source(audio='#b+2,video='#c,midi='#d))
where 'a is either float or ()->float```

Get current peak volume of the source. Returns a pair `(f,s)` where s is a new source and `f` is a function of type `() -> float` and returns the current peak volume of the source.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Duration of the window (in seconds). A value <= 0, means that computation should not be performed.
* `(unlabeled)` (`source(audio='#b+2,video='#c,midi='#d)`)

### rms
```
(?id:string,?duration:'a,
 source(audio='#b,video='#c,midi='#d))->
((()->float)*source(audio='#b,video='#c,midi='#d))
where 'a is either float or ()->float```

Get current RMS volume of the source. Returns a pair `(f,s)` where s is a new source and `f` is a function of type `() -> float` and returns the current RMS volume of the source.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Duration of the window (in seconds). A value <= 0, means that computation should not be performed.
* `(unlabeled)` (`source(audio='#b,video='#c,midi='#d)`)

### rms.stereo
```
(?id:string,?duration:'a,
 source(audio='#b+2,video='#c,midi='#d))->
((()->(float*float))*
 source(audio='#b+2,video='#c,midi='#d))
where 'a is either float or ()->float```

Get current RMS volume of the source. Returns a pair `(f,s)` where s is a new source and `f` is a function of type `() -> float` and returns the current RMS volume of the source.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Duration of the window (in seconds). A value <= 0, means that computation should not be performed.
* `(unlabeled)` (`source(audio='#b+2,video='#c,midi='#d)`)

### server.rms
```
(?id:string,source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Register a command that outputs the RMS of the returned source.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

### video.volume
```
(?id:string,source(audio='#a+1,video=0,midi=0))->
source(audio='#a+1,video=1,midi=0)```

Graphical visualization of the sound.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a+1,video=0,midi=0)`)

### vumeter
```
(?id:string,?scroll:bool,
 source(audio='#a+1,video='#b,midi='#c))->
source(audio='#a+1,video='#b,midi='#c)```

VU meter (display the audio volume).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `scroll` (`bool` -- defaults to `false`): Scroll.
* `(unlabeled)` (`source(audio='#a+1,video='#b,midi='#c)`)

Bool
----
### !=
```
('a,'a)->bool where 'a is an orderable type```

Comparison of comparable values.

* `(unlabeled)` (`anything that is an orderable type`)
* `(unlabeled)` (`anything that is an orderable type`)

### <
```
('a,'a)->bool where 'a is an orderable type```

Comparison of comparable values.

* `(unlabeled)` (`anything that is an orderable type`)
* `(unlabeled)` (`anything that is an orderable type`)

### <=
```
('a,'a)->bool where 'a is an orderable type```

Comparison of comparable values.

* `(unlabeled)` (`anything that is an orderable type`)
* `(unlabeled)` (`anything that is an orderable type`)

### ==
```
('a,'a)->bool where 'a is an orderable type```

Comparison of comparable values.

* `(unlabeled)` (`anything that is an orderable type`)
* `(unlabeled)` (`anything that is an orderable type`)

### >
```
('a,'a)->bool where 'a is an orderable type```

Comparison of comparable values.

* `(unlabeled)` (`anything that is an orderable type`)
* `(unlabeled)` (`anything that is an orderable type`)

### >=
```
('a,'a)->bool where 'a is an orderable type```

Comparison of comparable values.

* `(unlabeled)` (`anything that is an orderable type`)
* `(unlabeled)` (`anything that is an orderable type`)

### and
```
(bool,bool)->bool```

Return the conjunction of its arguments

* `(unlabeled)` (`bool`)
* `(unlabeled)` (`bool`)

### not
```
(bool)->bool```

Returns the negation of its argument.

* `(unlabeled)` (`bool`)

### or
```
(bool,bool)->bool```

Return the disjunction of its arguments

* `(unlabeled)` (`bool`)
* `(unlabeled)` (`bool`)

### random.bool
```
()->bool```

Generate a random value.

Control
-------
### add_timeout
```
(?fast:bool,float,(()->float))->unit```

Call a function in N seconds. If the result of the function is positive or null, the task will be scheduled again after this amount of time (in seconds).

* `fast` (`bool` -- defaults to `true`): Set to `false` if the execution of the code can take long in order to lower its priority below that of request resolutions and fast timeouts. This is only effective if you set a dedicated queue for fast tasks, see the ``scheduler'' settings for more details.
* `(unlabeled)` (`float`)
* `(unlabeled)` (`()->float`)

### ignore
```
('a)->unit```

Convert anything to unit, preventing warnings.

* `(unlabeled)` (`'a`)

Interaction
-----------
### add_skip_command
```
(source('a))->unit```

Add a skip function to a source when it does not have one by default.

* `(unlabeled)` (`source('a)`): The source to attach the command to.

### http.delete
```
(?headers:[(string*string)],?timeout:float,string)->
((((string*int)*string)*[(string*string)])*string)```

Perform a full Http DELETE request and return (status,headers),data.

* `headers` (`[(string*string)]` -- defaults to `[]`): Additional headers.
* `timeout` (`float` -- defaults to `10.0`): Timeout for network operations.
* `(unlabeled)` (`string`): Requested URL, e.g. ``http://www.google.com:80/index.html''.

### http.get
```
(?headers:[(string*string)],?timeout:float,string)->
((((string*int)*string)*[(string*string)])*string)```

Perform a full Http GET request and return (status,headers),data.

* `headers` (`[(string*string)]` -- defaults to `[]`): Additional headers.
* `timeout` (`float` -- defaults to `10.0`): Timeout for network operations.
* `(unlabeled)` (`string`): Requested URL, e.g. ``http://www.google.com:80/index.html''.

### http.head
```
(?headers:[(string*string)],?timeout:float,string)->
((((string*int)*string)*[(string*string)])*string)```

Perform a full Http HEAD request and return (status,headers),data.

* `headers` (`[(string*string)]` -- defaults to `[]`): Additional headers.
* `timeout` (`float` -- defaults to `10.0`): Timeout for network operations.
* `(unlabeled)` (`string`): Requested URL, e.g. ``http://www.google.com:80/index.html''.

### http.post
```
(?data:string,?headers:[(string*string)],?timeout:float,
 string)->
((((string*int)*string)*[(string*string)])*string)```

Perform a full Http POST request and return (status,headers),data.

* `data` (`string` -- defaults to `""`): POST data.
* `headers` (`[(string*string)]` -- defaults to `[]`): Additional headers.
* `timeout` (`float` -- defaults to `10.0`): Timeout for network operations.
* `(unlabeled)` (`string`): Requested URL, e.g. ``http://www.google.com:80/index.html''.

### http.put
```
(?data:string,?headers:[(string*string)],?timeout:float,
 string)->
((((string*int)*string)*[(string*string)])*string)```

Perform a full Http PUT request and return (status,headers),data.

* `data` (`string` -- defaults to `""`): POST data.
* `headers` (`[(string*string)]` -- defaults to `[]`): Additional headers.
* `timeout` (`float` -- defaults to `10.0`): Timeout for network operations.
* `(unlabeled)` (`string`): Requested URL, e.g. ``http://www.google.com:80/index.html''.

### http_codes
```
[(string*string)]```

List of HTTP response codes and statuses.

### http_response
```
(?protocol:string,?code:int,?headers:[(string*string)],
 ?data:string)->string```

Create a HTTP response string

* `protocol` (`string` -- defaults to `"HTTP/1.1"`): HTTP protocol used.
* `code` (`int` -- defaults to `200`): Response code.
* `headers` (`[(string*string)]` -- defaults to `[]`): Response headers.
* `data` (`string` -- defaults to `""`): Response data

### https.delete
```
(?headers:[(string*string)],?timeout:float,string)->
((((string*int)*string)*[(string*string)])*string)```

Perform a full https DELETE request and return (status,headers),data.

* `headers` (`[(string*string)]` -- defaults to `[]`): Additional headers.
* `timeout` (`float` -- defaults to `10.0`): Timeout for network operations.
* `(unlabeled)` (`string`): Requested URL, e.g. ``http://www.google.com:80/index.html''.

### https.get
```
(?headers:[(string*string)],?timeout:float,string)->
((((string*int)*string)*[(string*string)])*string)```

Perform a full https GET request and return (status,headers),data.

* `headers` (`[(string*string)]` -- defaults to `[]`): Additional headers.
* `timeout` (`float` -- defaults to `10.0`): Timeout for network operations.
* `(unlabeled)` (`string`): Requested URL, e.g. ``http://www.google.com:80/index.html''.

### https.head
```
(?headers:[(string*string)],?timeout:float,string)->
((((string*int)*string)*[(string*string)])*string)```

Perform a full https HEAD request and return (status,headers),data.

* `headers` (`[(string*string)]` -- defaults to `[]`): Additional headers.
* `timeout` (`float` -- defaults to `10.0`): Timeout for network operations.
* `(unlabeled)` (`string`): Requested URL, e.g. ``http://www.google.com:80/index.html''.

### https.post
```
(?data:string,?headers:[(string*string)],?timeout:float,
 string)->
((((string*int)*string)*[(string*string)])*string)```

Perform a full https POST request and return (status,headers),data.

* `data` (`string` -- defaults to `""`): POST data.
* `headers` (`[(string*string)]` -- defaults to `[]`): Additional headers.
* `timeout` (`float` -- defaults to `10.0`): Timeout for network operations.
* `(unlabeled)` (`string`): Requested URL, e.g. ``http://www.google.com:80/index.html''.

### https.put
```
(?data:string,?headers:[(string*string)],?timeout:float,
 string)->
((((string*int)*string)*[(string*string)])*string)```

Perform a full https PUT request and return (status,headers),data.

* `data` (`string` -- defaults to `""`): POST data.
* `headers` (`[(string*string)]` -- defaults to `[]`): Additional headers.
* `timeout` (`float` -- defaults to `10.0`): Timeout for network operations.
* `(unlabeled)` (`string`): Requested URL, e.g. ``http://www.google.com:80/index.html''.

### icy.update_metadata
```
(?host:string,?port:int,?user:string,?password:string,
 ?mount:string,?icy_id:int,?protocol:string,
 ?encoding:string,?headers:[(string*string)],
 [(string*string)])->unit```

Update metata on an icecast mountpoint using the ICY protocol.

* `host` (`string` -- defaults to `"localhost"`)
* `port` (`int` -- defaults to `8000`)
* `user` (`string` -- defaults to `"source"`)
* `password` (`string` -- defaults to `"hackme"`)
* `mount` (`string` -- defaults to `""`): Source mount point. Mandatory when streaming to icecast.
* `icy_id` (`int` -- defaults to `1`): Shoutcast source ID. Only supported by Shoutcast v2.
* `protocol` (`string` -- defaults to `"http"`): Protocol to use. One of: ``icy'', ``http'' or ``https''
* `encoding` (`string` -- defaults to `""`): Encoding used to send metadata, default (UTF-8) if empty.
* `headers` (`[(string*string)]` -- defaults to ```
[("User-Agent","Liquidsoap/1.3.0+scm (Unix; OCaml 4.04.0)")]```
): Additional headers.
* `(unlabeled)` (`[(string*string)]`)

### interactive.bool
```
(string,bool)->()->bool```

Read a boolean from an interactive input.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`bool`)

### interactive.float
```
(string,float)->()->float```

Read a float from an interactive input.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`float`)

### interactive.string
```
(string,string)->()->string```

Read a string from an interactive input.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`string`)

### print
```
(?newline:bool,'a)->unit```

Print on standard output.

* `newline` (`bool` -- defaults to `true`): If true, a newline is added after displaying the value.
* `(unlabeled)` (`'a`)

### server.register
```
(?namespace:string,?description:string,?usage:string,
 string,((string)->string))->unit```

Register a command. You can then execute this function through the server, either telnet or socket.

* `namespace` (`string` -- defaults to `""`)
* `description` (`string` -- defaults to `"No documentation available."`): A description of your command.
* `usage` (`string` -- defaults to `""`)
* `(unlabeled)` (`string`)
* `(unlabeled)` (`(string)->string`)

Liquidsoap
----------
### add_decoder
```
(name:string,description:string,?mimes:[string],
 test:((string)->int),string)->unit```

Register an external decoder. The encoder should output in WAV format to his standard output (stdout) and read data from its standard input (stdin).

* `name` (`string`): Format/decoder's name.
* `description` (`string`): Description of the decoder.
* `mimes` (`[string]` -- defaults to `[]`): List of mime types supported by this decoder for decoding streams.
* `test` (`(string)->int`): Function used to determine if a file should be decoded by the decoder. Returned values are: 0: no decodable audio, -1: decodable audio but number of audio channels unknown, x: fixed number of decodable audio channels.
* `(unlabeled)` (`string`): Process to start.

### add_metadata_resolver
```
(string,((string)->[(string*string)]))->unit```

Register an external file metadata decoder.

* `(unlabeled)` (`string`): Format/resolver's name.
* `(unlabeled)` (`(string)->[(string*string)]`): Process to start. The function takes the format and filename as argument and returns a list of (name,value) fields.

### add_oblivious_decoder
```
(name:string,description:string,test:((string)->int),
 ?buffer:float,((string)->string))->unit```

Register an external file decoder. The encoder should output in WAV format to his standard output (stdout) and read data from the file it receives. The estimated remaining duration for this decoder will be unknown until the `buffer` last seconds of the file. If possible, it is recommended to decode from stdin and use `add_decoder`.

* `name` (`string`): Format/decoder's name.
* `description` (`string`): Description of the decoder.
* `test` (`(string)->int`): Function used to determine if a file should be decoded by the decoder. Returned values are: 0: no decodable audio, -1: decodable audio but number of audio channels unknown, x: fixed number of decodable audio channels.
* `buffer` (`float` -- defaults to `5.0`)
* `(unlabeled)` (`(string)->string`): Process to start. The function takes the filename as argument and returns the process to start.

### add_playlist_parser
```
(format:string,strict:bool,
 ((?pwd:string,string)->[([(string*string)]*string)]))->
unit```

Register a new playlist parser.

* `format` (`string`): Playlist format. If possible, a mime-type.
* `strict` (`bool`): True if playlist format can be detected unambiguously.
* `(unlabeled)` (```
(?pwd:string,string)->[([(string*string)]*string)]```
): Playlist parser

### add_protocol
```
(?temporary:bool,?static:bool,?syntax:string,?doc:string,
 string,
 ((rlog:((string)->unit),maxtime:float,string)->[string]))->
unit```

Register a new protocol.

* `temporary` (`bool` -- defaults to `false`): if true, file is removed when it is finished.
* `static` (`bool` -- defaults to `false`): if true, then requests can be resolved once and for all. Typically, static protocols can be used to create infallible sources.
* `syntax` (`string` -- defaults to `"Undocumented"`): URI syntax.
* `doc` (`string` -- defaults to `"Undocumented"`): Protocol documentation.
* `(unlabeled)` (`string`): Protocol name. Resolver will be called on uris of the form: `<protocol name>:...`.
* `(unlabeled)` (```
(rlog:((string)->unit),maxtime:float,string)->[string]```
): Protocol resolver. Receives a function to log protocol resolution, the `<arg>` in `<protocol name>:<arg>` and the max delay that resolution should take.

### clock
```
(?sync:bool,?id:string,source('a))->source('a)```

Assign a new clock to the given source (and to other time-dependent sources) and return the source. It is a conveniency wrapper around clock.assign_new(), allowing more concise scripts in some cases.

* `sync` (`bool` -- defaults to `true`): Do not synchronize the clock on regular wallclock time, but try to run as fast as possible (CPU burning mode).
* `id` (`string` -- defaults to `""`)
* `(unlabeled)` (`source('a)`)

### clock.assign_new
```
(?id:string,?sync:bool,[source('a)])->unit```

Create a new clock and assign it to a list of sources.

* `id` (`string` -- defaults to `""`): Identifier for the new clock. The default empty string means that the identifier of the first source will be used.
* `sync` (`bool` -- defaults to `true`): Do not synchronize the clock on regular wallclock time, but try to run as fast as possible (CPU burning mode).
* `(unlabeled)` (`[source('a)]`): List of sources to which the new clock will be assigned

### clock.unify
```
([source('a)])->unit```

Enforce that a list of sources all belong to the same clock.

* `(unlabeled)` (`[source('a)]`)

### configure.default_font
```
string```

Liquidsoap's default font file.

### configure.libdir
```
string```

Liquidsoap's library directory.

### configure.logdir
```
string```

Liquidsoap's logging directory.

### configure.rundir
```
string```

Liquidsoap's PID file directory.

### enable_external_faad_decoder
```
()->unit```

Enable or disable external FAAD (AAC/AAC+/M4A) decoders. Requires faad binary in the path for audio decoding and metaflac binary for metadata. Does not work on Win32.
Please note that built-in support for faad is available in liquidsoap if compiled and should be preferred over the external decoder.

### enable_external_flac_decoder
```
()->unit```

Enable external FLAC decoders. Requires flac binary in the path for audio decoding and metaflac binary for metadata. Default: disabled.
Please note that built-in support for FLAC is available in liquidsoap if compiled and should be preferred over the external decoder.

### enable_external_mpc_decoder
```
()->unit```

Enable external Musepack decoder. Requires the mpcdec binary in the path.

### enable_replaygain_metadata
```
(?extract_replaygain:string)->unit```

Enable replay gain metadata resolver. This resolver will process any file decoded by liquidsoap and add a replay_gain metadata when this value could be computed. For a finer-grained replay gain processing, use the replay_gain protocol.

* `extract_replaygain` (`string` -- defaults to ```
"/usr/local/lib/liquidsoap/scm/extract-replaygain"```
): The extraction program

### file.duration
```
(string)->float```

Compute the duration in seconds of audio data contained in a file. The computation may be expensive. Returns -1. if computation failed, typically if the file was not recognized as valid audio.

* `(unlabeled)` (`string`)

### garbage_collect
```
()->unit```

Trigger full major garbage collection.

### get
```
(default:'a,string)->'a
where 'a is unit, bool, int, float, string or [string]```

Get a setting's value.

* `default` (```
anything that is unit, bool, int, float, string or [string]```
)
* `(unlabeled)` (`string`)

### get_clock_status
```
()->[(string*int)]```

Get the current time for all allocated clocks.

### harbor.http.register
```
(port:int,method:string,string,
 ((protocol:string,data:string,headers:[(string*string)],
   string)->string))->unit```

Register a HTTP handler on the harbor. The given function receives as argument the full requested uri (e.g. ``foo?var=bar''), http protocol version, possible input data and the list of HTTP headers and returns the answer sent to the client, including HTTP headers. Registered uri can be regular expressions (e.g. ``.+\.php'') and can override default metadata handlers.

* `port` (`int`): Port to server.
* `method` (`string`): Accepted method
* `(unlabeled)` (`string`): URI to serve.
* `(unlabeled)` (```
(protocol:string,data:string,headers:[(string*string)],
 string)->string```
): Function to execute. method argument is ``PUT'' or ``GET'', protocol argument is ``HTTP/1.1'' or ``HTTP/1.0'' etc., data argument contains data passed in case of a PUT request, and ``'' otherwise. headers argument contains the HTTP headers. Unlabeled argument contains the requested URI.

### harbor.http.remove
```
(method:string,port:int,string)->unit```

Remove a registered HTTP handler on the harbor.

* `method` (`string`): Method served.
* `port` (`int`): Port to server.
* `(unlabeled)` (`string`): URI served.

### harbor.https.register
```
(port:int,method:string,string,
 ((protocol:string,data:string,headers:[(string*string)],
   string)->string))->unit```

Register a HTTPS handler on the harbor. The given function receives as argument the full requested uri (e.g. ``foo?var=bar''), http protocol version, possible input data and the list of HTTP headers and returns the answer sent to the client, including HTTP headers. Registered uri can be regular expressions (e.g. ``.+\.php'') and can override default metadata handlers.

* `port` (`int`): Port to server.
* `method` (`string`): Accepted method
* `(unlabeled)` (`string`): URI to serve.
* `(unlabeled)` (```
(protocol:string,data:string,headers:[(string*string)],
 string)->string```
): Function to execute. method argument is ``PUT'' or ``GET'', protocol argument is ``HTTP/1.1'' or ``HTTP/1.0'' etc., data argument contains data passed in case of a PUT request, and ``'' otherwise. headers argument contains the HTTP headers. Unlabeled argument contains the requested URI.

### harbor.https.remove
```
(method:string,port:int,string)->unit```

Remove a registered HTTPS handler on the harbor.

* `method` (`string`): Method served.
* `port` (`int`): Port to server.
* `(unlabeled)` (`string`): URI served.

### liquidsoap.version
```
string```

Liquidsoap version string.

### log
```
(?label:string,?level:int,string)->unit```

Log a message.

* `label` (`string` -- defaults to `"lang"`)
* `level` (`int` -- defaults to `3`)
* `(unlabeled)` (`string`)

### log_clocks
```
(?delay:float,?interval:float,string)->unit```

Create a log of clock times for all the clocks initially present. The log is in a simple format which you can directly use with gnuplot.

* `delay` (`float` -- defaults to `0.0`): Delay before setting up the clock logger. This should be used to ensure that the logger starts only after the clocks are created.
* `interval` (`float` -- defaults to `1.0`): Polling interval.
* `(unlabeled)` (`string`): Path of the log file.

### metadata.export
```
([(string*string)])->[(string*string)]```

Filter-out internal metadata.

* `(unlabeled)` (`[(string*string)]`)

### mutexify
```
('a)->'a```

Protect functions with a mutex to avoid concurrent calls, return original value otherwise.

* `(unlabeled)` (`'a`)

### playlist.parse
```
(string)->[([(string*string)]*string)]```

Try to parse a local playlist. Return a list of (metadata,URI) items, where metadata is a list of (key,value) bindings.

* `(unlabeled)` (`string`)

### process_uri
```
(extname:'a,?uri:string,string)->string```

Create a process: uri, replacing `:` with `$(colon)`

* `extname` (`'a`): Output file extension (with no leading '.')
* `uri` (`string` -- defaults to `""`): Input uri
* `(unlabeled)` (`string`): Command line to execute

### register
```
(name:string,?descr:string,string,'a)->unit
where 'a is unit, bool, int, float, string or [string]```

Register a new setting.

* `name` (`string`): Settings name
* `descr` (`string` -- defaults to `""`): Settings description
* `(unlabeled)` (`string`): Setting key
* `(unlabeled)` (```
anything that is unit, bool, int, float, string or [string]```
): Setting initial value

### register_flow
```
(?server:string,?user:string,?password:string,
 ?email:string,radio:string,website:string,
 description:string,genre:string,
 streams:[(string*string)],source('a))->source('a)```

Register a radio on Liquidsoap Flows.

* `server` (`string` -- defaults to `""`)
* `user` (`string` -- defaults to `"default"`)
* `password` (`string` -- defaults to `"default"`)
* `email` (`string` -- defaults to `""`)
* `radio` (`string`): Name of the radio.
* `website` (`string`): URL of the website of the radio.
* `description` (`string`): Description of the radio.
* `genre` (`string`): Genre of the radio (rock or rap or etc.).
* `streams` (`[(string*string)]`): List of streams for the radio described by a pair of strings consisting of the format of the stream and the url of the stream. The format should be of the form ``ogg/128k'' consisting of the codec and the bitrate, separated by ``/''.
* `(unlabeled)` (`source('a)`)

### request.create
```
(?indicators:[string],?persistent:bool,string)->
request('a)```

Create a request. Creation may fail if there is no available RID, which cannot be detected currently: in that case one will obtain a request that will fail to be resolved.

* `indicators` (`[string]` -- defaults to `[]`)
* `persistent` (`bool` -- defaults to `false`)
* `(unlabeled)` (`string`)

### request.create.raw
```
(?indicators:[string],?persistent:bool,string)->
request(audio=0,video=0,midi=0)```

Create a raw request, i.e. for files that should not be decoded for streaming. Creation may fail if there is no available RID, which cannot be detected currently: in that case one will obtain a request that will fail to be resolved.

* `indicators` (`[string]` -- defaults to `[]`)
* `persistent` (`bool` -- defaults to `false`)
* `(unlabeled)` (`string`)

### request.destroy
```
(?force:bool,request('a))->unit```

Destroying a request causes any temporary associated file to be deleted, and releases its RID. Persistent requests resist to destroying, unless forced.

* `force` (`bool` -- defaults to `false`): Destroy the request even if it is persistent.
* `(unlabeled)` (`request('a)`)

### request.filename
```
(request('a))->string```

Return a valid local filename if the request is ready, and the empty string otherwise.

* `(unlabeled)` (`request('a)`)

### request.log
```
(request('a))->string```

Get log data associated to a request.

* `(unlabeled)` (`request('a)`)

### request.metadata
```
(request('a))->[(string*string)]```

Get the metadata associated to a request.

* `(unlabeled)` (`request('a)`)

### request.ready
```
(request('a))->bool```

Check if a request is ready, i.e. is associated to a valid local file. Unless the initial URI was such a file, a request has to be resolved before being ready.

* `(unlabeled)` (`request('a)`)

### request.resolve
```
(?timeout:float,request('a))->bool```

Resolve a request, i.e. attempt to get a valid local file. The operation can take some time. Return true if the resolving was successful, false otherwise (timeout or invalid URI).

* `timeout` (`float` -- defaults to `30.0`): Limit in seconds to the duration of the resolving.
* `(unlabeled)` (`request('a)`)

### server.execute
```
(string,?string)->[string]```

Execute a liquidsoap server command.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`string` -- defaults to `""`)

### set
```
(string,'a)->unit
where 'a is unit, bool, int, float, string or [string]```

Change some setting. Use `liquidsoap --conf-descr` and `liquidsoap --conf-descr-key KEY` on the command-line to get some information about available settings.

* `(unlabeled)` (`string`)
* `(unlabeled)` (```
anything that is unit, bool, int, float, string or [string]```
)

### source.fallible
```
(source('a))->bool```

Indicate if a source may fail, i.e. may not be ready to stream.

* `(unlabeled)` (`source('a)`)

### source.id
```
(source('a))->string```

Get one source's identifier.

* `(unlabeled)` (`source('a)`)

### source.init
```
([source(audio=*,video=*,midi=*)])->
[source(audio=*,video=*,midi=*)]```

Simultaneously initialize sources, return the sublist of sources that failed to initialized.

* `(unlabeled)` (`[source(audio=*,video=*,midi=*)]`)

### source.is_ready
```
(source('a))->bool```

Indicate if a source is ready to stream, or currently streaming.

* `(unlabeled)` (`source('a)`)

### source.remaining
```
(source('a))->float```

Estimation of remaining time in the current track.

* `(unlabeled)` (`source('a)`)

### source.seek
```
(source('a),float)->float```

Seek forward, in seconds. Returns the amount of time effectively seeked.

* `(unlabeled)` (`source('a)`)
* `(unlabeled)` (`float`)

### source.shutdown
```
(source('a))->unit```

Desactivate a source.

* `(unlabeled)` (`source('a)`)

### source.skip
```
(source('a))->unit```

Skip to the next track.

* `(unlabeled)` (`source('a)`)

List
----
### _[_]
```
(string,[(string*string)])->string```

l[k] returns the first v such that (k,v) is in the list l (or ``'' if no such v exists).

* `(unlabeled)` (`string`)
* `(unlabeled)` (`[(string*string)]`)

### list.add
```
('a,['a])->['a]```

Add an element at the top of a list.

* `(unlabeled)` (`'a`)
* `(unlabeled)` (`['a]`)

### list.append
```
(['a],['a])->['a]```

Catenate two lists.

* `(unlabeled)` (`['a]`)
* `(unlabeled)` (`['a]`)

### list.assoc
```
(default:'a,'b,[('b*'a)])->'a```

Generalized l[k] with default value.

* `default` (`'a`): Default value if key does not exist
* `(unlabeled)` (`'b`)
* `(unlabeled)` (`[('b*'a)]`)

### list.filter
```
((('a)->bool),['a])->['a]```

Filter a list according to a filtering function.

* `(unlabeled)` (`('a)->bool`)
* `(unlabeled)` (`['a]`)

### list.filter_assoc
```
('a,[('a*'b)])->[('a*'b)] where 'a is an orderable type```

list.filter_assoc(key,l) returns all the elements of the form (key, value) from l.

* `(unlabeled)` (`anything that is an orderable type`): Key to look for
* `(unlabeled)` (`[('a*'b)] where 'a is an orderable type`): List of pairs (key,value)

### list.fold
```
((('a,'b)->'a),'a,['b])->'a```

Fold a function on every element of a list: list.fold(f,x1,[e1,..,en]) is f(...f(f(x1,e1),e2)...,en).

* `(unlabeled)` (`('a,'b)->'a`): Function f for which f(x,e) which will be called on every element e with the current value of x, returning the new value of x.
* `(unlabeled)` (`'a`): Initial value x1, to be updated by successive calls of f(x,e).
* `(unlabeled)` (`['b]`)

### list.hd
```
(default:'a,['a])->'a```

Return the head (first element) of a list, or 'default' if the list is empty.

* `default` (`'a`): Default value if key does not exist
* `(unlabeled)` (`['a]`)

### list.iter
```
((('a)->unit),['a])->unit```

Call a function on every element of a list.

* `(unlabeled)` (`('a)->unit`)
* `(unlabeled)` (`['a]`)

### list.length
```
(['a])->int```

Get the length of a list, i.e. its number of elements.

* `(unlabeled)` (`['a]`)

### list.map
```
((('a)->'b),['a])->['b]```

Map a function on every element of a list.

* `(unlabeled)` (`('a)->'b`)
* `(unlabeled)` (`['a]`)

### list.mapi
```
(((int,'a)->'b),['a])->['b]```

Map a function on every element of a list, along with its index.

* `(unlabeled)` (`(int,'a)->'b`)
* `(unlabeled)` (`['a]`)

### list.mem
```
('a,['a])->bool where 'a is an orderable type```

Check if an element belongs to a list.

* `(unlabeled)` (`anything that is an orderable type`)
* `(unlabeled)` (`['a] where 'a is an orderable type`)

### list.mem_assoc
```
('a,[('a*'b)])->bool where 'a is an orderable type```

list.mem_assoc(key,l) returns true if l contains a pair (key,value)

* `(unlabeled)` (`anything that is an orderable type`): Key to look for
* `(unlabeled)` (`[('a*'b)] where 'a is an orderable type`): List of pairs (key,value)

### list.nth
```
(default:'a,['a],int)->'a```

Get the n-th element of a list (the first element is at position 0), or'default' if element does not exist.

* `default` (`'a`): Default value if key does not exist
* `(unlabeled)` (`['a]`)
* `(unlabeled)` (`int`)

### list.randomize
```
(['a])->['a]```

Shuffle the content of a list.

* `(unlabeled)` (`['a]`)

### list.remove
```
('a,['a])->['a]```

Remove a value from a list.

* `(unlabeled)` (`'a`)
* `(unlabeled)` (`['a]`)

### list.remove_assoc
```
('a,[('a*'c)])->[('a*'c)]```

Remove the first pair from an associative list.

* `(unlabeled)` (`'a`): Key of pair to be removed
* `(unlabeled)` (`[('a*'c)]`): List of pairs (key,value)

### list.rev
```
(['a])->['a]```

Revert list order.

* `(unlabeled)` (`['a]`)

### list.sort
```
((('a,'a)->int),['a])->['a]```

Sort a list according to a comparison function.

* `(unlabeled)` (`('a,'a)->int`)
* `(unlabeled)` (`['a]`)

### list.tl
```
(['a])->['a]```

Return the list without its first element.

* `(unlabeled)` (`['a]`)

Math
----
### *
```
('a,'a)->'a where 'a is a number type```

Multiplication of numbers.

* `(unlabeled)` (`anything that is a number type`)
* `(unlabeled)` (`anything that is a number type`)

### +
```
('a,'a)->'a where 'a is a number type```

Addition of numbers.

* `(unlabeled)` (`anything that is a number type`)
* `(unlabeled)` (`anything that is a number type`)

### -
```
('a,'a)->'a where 'a is a number type```

Substraction of numbers.

* `(unlabeled)` (`anything that is a number type`)
* `(unlabeled)` (`anything that is a number type`)

### /
```
('a,'a)->'a where 'a is a number type```

Division of numbers.

* `(unlabeled)` (`anything that is a number type`)
* `(unlabeled)` (`anything that is a number type`)

### abs
```
('a)->'a where 'a is a number type```

Absolute value.

* `(unlabeled)` (`anything that is a number type`)

### bool_of_float
```
(float)->bool```

Convert a float to a bool.

* `(unlabeled)` (`float`)

### bool_of_int
```
(int)->bool```

Convert an int to a bool.

* `(unlabeled)` (`int`)

### dB_of_lin
```
(float)->float```

Convert linear scale into decibels.

* `(unlabeled)` (`float`)

### float_of_int
```
(int)->float```

Convert an int to a float.

* `(unlabeled)` (`int`)

### int_of_float
```
(float)->int```

Convert a float to a int.

* `(unlabeled)` (`float`)

### lin_of_dB
```
(float)->float```

Convert decibels into linear scale.

* `(unlabeled)` (`float`)

### mod
```
(int,int)->int```

Integer remainder. If y is not zero, x == (x / y) * y + x mod y, and abs(x mod y) <= abs(y)-1.

* `(unlabeled)` (`int`)
* `(unlabeled)` (`int`)

### pow
```
('a,'a)->'a where 'a is a number type```

Exponentiation of numbers.

* `(unlabeled)` (`anything that is a number type`)
* `(unlabeled)` (`anything that is a number type`)

### random.float
```
(?min:float,?max:float)->float```

Generate a random value.

* `min` (`float` -- defaults to `-1000000.0`)
* `max` (`float` -- defaults to `1000000.0`)

### random.int
```
(?min:float,?max:float)->int```

Generate a random value.

* `min` (`float` -- defaults to `-4611686018427387904`)
* `max` (`float` -- defaults to `4611686018427387903`)

### ~-
```
('a)->'a where 'a is a number type```

Returns the opposite of its argument.

* `(unlabeled)` (`anything that is a number type`)

Pair
----
### fst
```
(('a*'b))->'a```

Get the first component of a pair.

* `(unlabeled)` (`('a*'b)`)

### snd
```
(('a*'b))->'b```

Get the second component of a pair.

* `(unlabeled)` (`('a*'b)`)

String
------
### %
```
(string,[(string*string)])->string```

`pattern % [...,(k,v),...]` changes in the pattern occurences of:
- `$(k)` into `v`;
- `$(if $(k2),"a","b")` into ``a'' if k2 is found in the list, ``b'' otherwise.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`[(string*string)]`)

### ^
```
(string,string)->string```

Concatenate strings.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`string`)

### base64.decode
```
(string)->string```

Decode a Base64 encoded string.

* `(unlabeled)` (`string`)

### base64.encode
```
(string)->string```

Encode a string in Base64.

* `(unlabeled)` (`string`)

### bool_of_string
```
(?default:bool,string)->bool```

Convert a string to a bool.

* `default` (`bool` -- defaults to `false`)
* `(unlabeled)` (`string`)

### float_of_string
```
(?default:float,string)->float```

Convert a string to a float.

* `default` (`float` -- defaults to `0.0`)
* `(unlabeled)` (`string`)

### int_of_string
```
(?default:int,string)->int```

Convert a string to a int.

* `default` (`int` -- defaults to `0`)
* `(unlabeled)` (`string`)

### json_of
```
(?compact:bool,'a)->string```

Convert a value to a json string.

* `compact` (`bool` -- defaults to `false`): Output compact text.
* `(unlabeled)` (`'a`)

### of_json
```
(default:'a,string)->'a```

Parse a json string into a liquidsoap value.

* `default` (`'a`): Default value if string cannot be parsed.
* `(unlabeled)` (`string`)

### quote
```
(string)->string```

Escape shell metacharacters.

* `(unlabeled)` (`string`)

### string.capitalize
```
(?capitalize:bool,?space_sensitive:bool,string)->string```

Return a string with the first character set to upper case (capitalize), or to lower case (uncapitalize).

* `capitalize` (`bool` -- defaults to `true`): Capitalize if true, uncapitalize otherwise
* `space_sensitive` (`bool` -- defaults to `true`): Capitalize each space separated sub-string.
* `(unlabeled)` (`string`)

### string.case
```
(?lower:bool,string)->string```

Convert a string to lower or upper case.

* `lower` (`bool` -- defaults to `true`): Convert to lower case if true and uppercase otherwise.
* `(unlabeled)` (`string`)

### string.concat
```
(?separator:string,[string])->string```

Concatenate strings.

* `separator` (`string` -- defaults to `""`)
* `(unlabeled)` (`[string]`)

### string.escape
```
(?special_chars:[string],?escape_char:((string)->string),
 string)->string```

Escape special charaters in a string. String is parsed char by char. See `string.utf8.escape` for an UTF8-aware parsing function.

* `special_chars` (`[string]` -- defaults to ```
["\127", "\\", "\"", "\000", "\001", "\002", "\003", "\004", "\005", "\006", "\007", "\b", "\t", "\n", "\011", "\012", "\r", "\014", "\015", "\016", "\017", "\018", "\019", "\020", "\021", "\022", "\023", "\024", "\025", "\026", "\027", "\028", "\029", "\030", "\031"]```
): List of characters that should be escaped. The first character of each element in the list is considered.
* `escape_char` (`(string)->string` -- defaults to <code><fun></code>): Function used to escape a character.
* `(unlabeled)` (`string`)

### string.extract
```
(pattern:string,string)->[(string*string)]```

Extract substrings from a string. 
Perl compatible regular expressions are recognized. Hence, special characters should be escaped. 
Returns a list of (index,value).
If the list does not have a pair associated to some index, it means that the corresponding pattern was not found.

* `pattern` (`string`)
* `(unlabeled)` (`string`)

### string.length
```
(string)->int```

Get the length of a string.

* `(unlabeled)` (`string`)

### string.match
```
(pattern:string,string)->bool```

Match a string with an expression. 
Perl compatible regular expressions are recognized. Hence, special characters should be escaped.

* `pattern` (`string`)
* `(unlabeled)` (`string`)

### string.recode
```
(?in_enc:string,?out_enc:string,string)->string```

Convert a string. Effective only if Camomile is enabled.

* `in_enc` (`string` -- defaults to `""`): Input encoding. Autodetected if empty.
* `out_enc` (`string` -- defaults to `"UTF-8"`): Output encoding.
* `(unlabeled)` (`string`)

### string.replace
```
(pattern:string,((string)->string),string)->string```

Replace substrings in a string. 
Will replace all substrings matched in the pattern by the string returned by the replace function.

* `pattern` (`string`)
* `(unlabeled)` (`(string)->string`)
* `(unlabeled)` (`string`)

### string.split
```
(separator:string,string)->[string]```

Split a string at 'separator'. 
Perl compatible regular expressions are recognized. Hence, special characters should be escaped.

* `separator` (`string`)
* `(unlabeled)` (`string`)

### string.sub
```
(string,start:int,length:int)->string```

Get a substring of a string. Returns ``'' if no such substring exists.

* `(unlabeled)` (`string`)
* `start` (`int`): Return a sub string starting at this position. First position is 0.
* `length` (`int`): Return a sub string of `length` characters.

### string.trim
```
(string)->string```

Return a string without leading and trailing whitespace.

* `(unlabeled)` (`string`)

### string.utf8.escape
```
(?special_chars:[string],?escape_char:((string)->string),
 string)->string```

Escape special charaters in an UTF8 string.

* `special_chars` (`[string]` -- defaults to ```
["\127", "\\", "\"", "\000", "\001", "\002", "\003", "\004", "\005", "\006", "\007", "\b", "\t", "\n", "\011", "\012", "\r", "\014", "\015", "\016", "\017", "\018", "\019", "\020", "\021", "\022", "\023", "\024", "\025", "\026", "\027", "\028", "\029", "\030", "\031"]```
): List of characters that should be escaped. The first character of each element in the list is considered.
* `escape_char` (`(string)->string` -- defaults to <code><fun></code>): Function used to escape a character.
* `(unlabeled)` (`string`)

### string_of
```
('a)->string```

Return the representation of a value.

* `(unlabeled)` (`'a`)

### string_of_metadata
```
([(string*string)])->string```

Standard function for displaying metadata.
Shows artist and title, using ``Unknown'' when a field is empty.

* `(unlabeled)` (`[(string*string)]`): Metadata packet to be displayed.

### url.decode
```
(?plus:bool,string)->string```

Decode an encoded url (e.g. ``%20'' becomes `` '').

* `plus` (`bool` -- defaults to `true`)
* `(unlabeled)` (`string`)

### url.encode
```
(?plus:bool,string)->string```

Encode an url (e.g. `` '' becomes ``%20'').

* `plus` (`bool` -- defaults to `true`)
* `(unlabeled)` (`string`)

### url.split
```
(string)->(string*[(string*string)])```

Split an url of the form foo?arg=bar&arg2=bar2 into (``foo'',[(``arg'',``bar''),(``arg2'',``bar2'')]).

* `(unlabeled)` (`string`): Url to split

### url.split_args
```
(string)->[(string*string)]```

Split the arguments of an url of the form arg=bar&arg2=bar2 into [(``arg'',``bar''),(``arg2'',``bar2'')].

* `(unlabeled)` (`string`): Agument string to split

System
------
### argv
```
(?default:string,int)->string```

Get command-line parameters.

* `default` (`string` -- defaults to `""`)
* `(unlabeled)` (`int`)

### basename
```
(string)->string```

Get the base name of a path.

* `(unlabeled)` (`string`)

### dirname
```
(string)->string```

Get the directory name of a path.

* `(unlabeled)` (`string`)

### environment
```
()->[(string*string)]```

Return the process environment.

### exe_ext
```
string```

Executable file extension.

### exec_at
```
(?freq:float,pred:(()->bool),(()->unit))->unit```

Execute a given action when a predicate is true. This will be run in background.

* `freq` (`float` -- defaults to `1.0`): Frequency for checking the predicate, in seconds.
* `pred` (`()->bool`): Predicate indicating when to execute the function, typically a time interval such as `{10h-10h30}`.
* `(unlabeled)` (`()->unit`): Function to execute when the predicate is true.

### exit
```
(int)->unit```

Immediately stop the application. This should only be used in extreme cases or to specify an exit value. The recommended way of stopping Liquidsoap is to use shutdown.

* `(unlabeled)` (`int`): Exit value.

### file.contents
```
(string)->string```

Read the whole contents of a file.

* `(unlabeled)` (`string`)

### file.exists
```
(string)->bool```

Returns true if the file or directory exists.

* `(unlabeled)` (`string`)

### file.extension
```
(?dir_sep:string,string)->string```

Returns a file's extension.

* `dir_sep` (`string` -- defaults to `"/"`): Directory separator.
* `(unlabeled)` (`string`)

### file.is_directory
```
(string)->bool```

Returns true if the file exists and is a directory.

* `(unlabeled)` (`string`)

### file.mime_default
```
('a)->string```

Dummy implementation of file.mime

* `(unlabeled)` (`'a`)

### file.temp
```
(string,string)->string```

Return a fresh temporary filename in the temporary directory.

* `(unlabeled)` (`string`): File prefix
* `(unlabeled)` (`string`): File suffix

### file.watch
```
(string,(()->unit))->()->unit```

Call a function when a file is modified. Returns unwatch function.

* `(unlabeled)` (`string`): File to watch.
* `(unlabeled)` (`()->unit`): Handler function.

### get_mime
```
(string)->string```

Generic mime test. First try to use file.mime if it exist. Otherwise try to get the value using the file binary. Returns ``'' (empty string) if no value can be found.

* `(unlabeled)` (`string`): The file to test

### get_process_lines
```
(?timeout:float,?env:[(string*string)],?inherit_env:bool,
 string)->[string]```

Perform a shell call and return the list of its output lines.

* `timeout` (`float` -- defaults to `-1.0`): Cancel process after `timeout` has elapsed. Ignored if negative.
* `env` (`[(string*string)]` -- defaults to `[]`): Process environment
* `inherit_env` (`bool` -- defaults to `true`): Inherit calling process's environment when `env` parameter is empty.
* `(unlabeled)` (`string`): Command to run

### get_process_output
```
(?timeout:float,?env:[(string*string)],?inherit_env:bool,
 string)->string```

Perform a shell call and return its output.

* `timeout` (`float` -- defaults to `-1.0`): Cancel process after `timeout` has elapsed. Ignored if negative.
* `env` (`[(string*string)]` -- defaults to `[]`): Process environment
* `inherit_env` (`bool` -- defaults to `true`): Inherit calling process's environment when `env` parameter is empty.
* `(unlabeled)` (`string`): Command to run

### getenv
```
(string)->string```

Get the value associated to a variable in the process environment. Return ``'' if variable is not set.

* `(unlabeled)` (`string`)

### getopt
```
(?default:string,string)->string```

Parse command line options:
`getopt("-o")` returns ``1'' if ``-o'' was passed without any parameter, ``0'' otherwise.
`getopt(default="X","-o")` returns ``Y'' if ``-o Y'' was passed, ``X'' otherwise.
The result is removed from the list of arguments, affecting subsequent
calls to `argv()` and `getopt()`.

* `default` (`string` -- defaults to `""`)
* `(unlabeled)` (`string`)

### getpid
```
()->int```

Get the process' pid.

### gettimeofday
```
()->float```

Return the current time since 00:00:00 GMT, Jan. 1, 1970, in seconds.

### is_directory
```
(string)->bool```

Returns true if the directory exists.

* `(unlabeled)` (`string`)

### on_shutdown
```
((()->unit))->unit```

Register a function to be called when Liquidsoap shuts down.

* `(unlabeled)` (`()->unit`)

### os.type
```
string```

Type of OS running liquidsoap.

### path.concat
```
(string,string)->string```

Concatenate two paths, using the appropriate directory separator.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`string`)

### read
```
(?hide:bool)->string```

Read some value from standard input (console).

* `hide` (`bool` -- defaults to `false`): Hide typed characters (for passwords).

### reopen.stderr
```
(string)->unit```

Reopen standard error on the given file

* `(unlabeled)` (`string`)

### reopen.stdin
```
(string)->unit```

Reopen standard input on the given file

* `(unlabeled)` (`string`)

### reopen.stdout
```
(string)->unit```

Reopen standard output on the given file

* `(unlabeled)` (`string`)

### restart
```
()->unit```

Restart the application.

### run_process
```
(?env:[(string*string)],?inherit_env:bool,?timeout:float,
 string)->((string*string)*(string*string))```

Run a process in a shell environment. Returns: `((stdout,stderr),status)` where status is one of: `("exit","<code>")`, `("killed","<signal number>")`, `("stopped","<signal number>")`, ```
("exception","<exception description>", ```
(``timeout'',``<run time>'')```
.

* <code>env</code> (<code>[(string*string)]</code> -- defaults to <code>[]</code>): Process environment
* <code>inherit_env</code> (<code>bool</code> -- defaults to <code>true</code>): Inherit calling process's environment when ```
env```
 parameter is empty.
* <code>timeout</code> (<code>float</code> -- defaults to <code>-1.0</code>): Cancel process after ```
timeout```
 has elapsed. Ignored if negative.
* <code>(unlabeled)</code> (<code>string</code>): Command to run

h5```
setenv. setenv

```
(string,string)->unit```

Set the value associated to a variable in the process environment.

* `(unlabeled)` (`string`): Variable to be set.
* `(unlabeled)` (`string`): Value to set.

### shutdown
```
()->unit```

Shutdown the application.

### source.is_up
```
(source('a))->bool```

Check whether a source is up.

* `(unlabeled)` (`source('a)`)

### source.on_shutdown
```
(source('a),(()->unit))->unit```

Register a function to be called when source shuts down.

* `(unlabeled)` (`source('a)`)
* `(unlabeled)` (`()->unit`)

### system
```
(string)->unit```

Shell command call. Set verbose to true to log process' output and errors.

* `(unlabeled)` (`string`)

### test_process
```
(?timeout:float,?env:[(string*string)],?inherit_env:bool,
 string)->bool```

Return true if process exited with 0 code.

* `timeout` (`float` -- defaults to `-1.0`): Cancel process after `timeout` has elapsed. Ignored if negative.
* `env` (`[(string*string)]` -- defaults to `[]`): Process environment
* `inherit_env` (`bool` -- defaults to `true`): Inherit calling process's environment when `env` parameter is empty.
* `(unlabeled)` (`string`): Command to test

### which
```
(string)->string```

which(``progname'') searches for an executable named ``progname'' using directories from the PATH environment variable and returns ``'' if it could not find one.

* `(unlabeled)` (`string`)


