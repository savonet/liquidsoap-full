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
* [String](#String)
* [System](#System)

Source / Conversions
--------------------
#### audio_to_stereo
```
(?id:string,source(audio=*+1,video=0,midi=0))->
source(audio=2,video=0,midi=0)```

Convert any kind of audio source into a stereo source.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio=*+1,video=0,midi=0)`)

#### drop_audio
```
(?id:string,source(audio='#a,video='#b,midi='#c))->
source(audio=0,video='#b,midi='#c)```

Drop all audio channels of a stream.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### drop_midi
```
(?id:string,source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi=0)```

Drop all midi channels of a stream.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### drop_video
```
(?id:string,source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video=0,midi='#c)```

Drop all video channels of a stream.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### id
```
(?id:string,source('a))->source('a)```

Does not do anything, simply forwards its input stream.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source('a)`)

#### mean
```
(?id:string,source(audio='#a,video='#b,midi='#c))->
source(audio=1,video='#b,midi='#c)```

Produce mono audio by taking the mean of all audio channels.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### mux_audio
```
(?id:string,audio:source(audio='#a,video=0,midi=0),
 source(audio=0,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Add audio channnels to a stream.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `audio` (`source(audio='#a,video=0,midi=0)`)
* `(unlabeled)` (`source(audio=0,video='#b,midi='#c)`)

#### mux_mono
```
(?id:string,mono:source(audio=1,video=0,midi=0),
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a+1,video='#b,midi='#c)```

Add audio channnels to a stream.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `mono` (`source(audio=1,video=0,midi=0)`)
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### mux_video
```
(?id:string,video:source(audio=0,video='#a,midi=0),
 source(audio='#b,video=0,midi='#c))->
source(audio='#b,video='#a,midi='#c)```

Add video channnels to a stream.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `video` (`source(audio=0,video='#a,midi=0)`)
* `(unlabeled)` (`source(audio='#b,video=0,midi='#c)`)

#### swap
```
(?id:string,source(audio=2,video=0,midi=0))->
source(audio=2,video=0,midi=0)```

Swap two channels of a stereo source.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

Source / Input
--------------
#### blank
```
(?id:string,?duration:float)->source('a)```

Produce silence and blank images.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (`float` -- defaults to `0.`): Duration of blank tracks in seconds, default means forever.

#### empty
```
(?id:string)->source(audio='a,video='b,midi='c)```

A source that does not produce anything. No silence, no track at all.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.

#### fail
```
(?id:string)->source('a)```

Creates a source that fails to produce anything.

* `id` (`string` -- defaults to `""`)

#### in
```
(?id:string,?start:bool,?on_start:(()->unit),
 ?on_stop:(()->unit),?fallible:bool)->
active_source(audio='#a+1,video='#b,midi='#c)```

Create a source from the first available input driver in
pulseaudio, portaudio, oss, alsa, blank.

* `id` (`string` -- defaults to `""`)
* `start` (`bool` -- defaults to `true`)
* `on_start` (`()->unit` -- defaults to `{()}`)
* `on_stop` (`()->unit` -- defaults to `{()}`)
* `fallible` (`bool` -- defaults to `false`)

#### input.alsa
```
(?id:string,?bufferize:bool,?clock_safe:bool,
 ?device:string,?fallible:bool,?on_start:(()->unit),
 ?on_stop:(()->unit),?start:bool)->
active_source(audio='#a+1,video=0,midi=0)```

Stream from an ALSA input device.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `bufferize` (`bool` -- defaults to `true`): Bufferize input
* `clock_safe` (`bool` -- defaults to `true`): Force the use of the dedicated ALSA clock
* `device` (`string` -- defaults to `"default"`): Alsa device to use
* `fallible` (`bool` -- defaults to `false`): Allow the input to stop. When false, the source will be infallible but the stop command won't have any effect.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when input starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when input stops.
* `start` (`bool` -- defaults to `true`): Start input as soon as it is created. Disabling it is only taken into account for a fallible input.

#### input.external
```
(?id:string,?buffer:float,?channels:int,?max:float,
 ?restart:bool,?restart_on_error:bool,?samplerate:int,
 string)->source(audio='#a+1,video=0,midi=0)```

Stream data from an external application.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `buffer` (`float` -- defaults to `2.`): Duration of the pre-buffered data.
* `channels` (`int` -- defaults to `2`): Number of channels.
* `max` (`float` -- defaults to `10.`): Maximum duration of the buffered data.
* `restart` (`bool` -- defaults to `true`): Restart process when exited.
* `restart_on_error` (`bool` -- defaults to `false`): Restart process when exited with error.
* `samplerate` (`int` -- defaults to `44100`): Samplerate.
* `(unlabeled)` (`string`): Command to execute.

#### input.harbor
```
(?id:string,?auth:((string,string)->bool),?buffer:float,
 ?debug:bool,?dumpfile:string,?icy:bool,
 ?icy_metadata_charset:string,?logfile:string,?max:float,
 ?metadata_charset:string,
 ?on_connect:(([(string*string)])->unit),
 ?on_disconnect:(()->unit),?password:string,?port:int,
 ?timeout:float,?user:string,string)->
source(audio='#a+1,video=0,midi=0)```

Retrieves the given http stream from the harbor.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `auth` (`(string,string)->bool` -- defaults to `fun (_,_) -> false`): Authentication function. `f(login,password)` returns `true` if the user should be granted access for this login. Override any other method if used.
* `buffer` (`float` -- defaults to `2.`): Duration of the pre-buffered data.
* `debug` (`bool` -- defaults to `false`): Run in debugging mode by not catching some exceptions.
* `dumpfile` (`string` -- defaults to `""`): Dump stream to file, for debugging purpose. Disabled if empty.
* `icy` (`bool` -- defaults to `false`): Enable ICY (shoutcast) protocol.
* `icy_metadata_charset` (`string` -- defaults to `""`): ICY (shoutcast) metadata charset. Guessed if empty. Default for shoutcast is ISO-8859-1. Set to that value if all your clients send metadata using this charset and automatic detection is not working for you.
* `logfile` (`string` -- defaults to `""`): Log buffer status to file, for debugging purpose. Disabled if empty.
* `max` (`float` -- defaults to `10.`): Maximum duration of the buffered data.
* `metadata_charset` (`string` -- defaults to `""`): Metadata charset for non-ICY (shoutcast) source protocols. Guessed if empty.
* `on_connect` (`([(string*string)])->unit` -- defaults to `fun (_) -> ()`): Function to execute when a source is connected. Its receives the list of headers, of the form: (<label>,<value>). All labels are lowercase.
* `on_disconnect` (`()->unit` -- defaults to `{()}`): Functions to excecute when a source is disconnected
* `password` (`string` -- defaults to `"hackme"`): Source password.
* `port` (`int` -- defaults to `8005`): Port used to connect to the source.
* `timeout` (`float` -- defaults to `30.`): Timeout for source connectionn.
* `user` (`string` -- defaults to `"source"`): Source user.
* `(unlabeled)` (`string`): Mountpoint to look for.

#### input.http
```
(?id:string,?autostart:bool,?bind_address:string,
 ?buffer:float,?debug:bool,?force_mime:string,
 ?logfile:string,?max:float,?new_track_on_metadata:bool,
 ?playlist_mode:string,?poll_delay:float,?timeout:float,
 ?user_agent:string,string)->
source(audio='#a,video='#b,midi=0)```

Forwards the given http stream. The relay can be paused/resumed using the start/stop telnet commands.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `autostart` (`bool` -- defaults to `true`): Initially start relaying or not.
* `bind_address` (`string` -- defaults to `""`): Address to bind on the local machine. This option can be useful if your machine is bound to multiple IPs. Empty means no bind address.
* `buffer` (`float` -- defaults to `2.`): Duration of the pre-buffered data.
* `debug` (`bool` -- defaults to `false`): Run in debugging mode, not catching some exceptions.
* `force_mime` (`string` -- defaults to `""`): Force mime data type. Not used if empty.
* `logfile` (`string` -- defaults to `""`): Log buffer status to file, for debugging purpose. Disabled if empty.
* `max` (`float` -- defaults to `10.`): Maximum duration of the buffered data.
* `new_track_on_metadata` (`bool` -- defaults to `true`): Treat new metadata as new track.
* `playlist_mode` (`string` -- defaults to `"normal"`): Valid modes are ``normal'', ``random'', ``randomize'' and ``first''. The first ones have the same meaning as for the mode parameter of the playlist operator. The last one discards all entries but the first one.
* `poll_delay` (`float` -- defaults to `2.`): Polling delay when trying to connect to the stream.
* `timeout` (`float` -- defaults to `30.`): Timeout for source connectionn.
* `user_agent` (`string` -- defaults to `"Liquidsoap/1.0.0 (Unix; OCaml 3.12.0)"`): User agent.
* `(unlabeled)` (`string`): URL of an http stream (default port is 80).

#### input.jack
```
(?id:string,?buffer_size:int,?clock_safe:bool,
 ?server:string)->source(audio='#a+1,video=0,midi=0)```

Get stream from jack.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `buffer_size` (`int` -- defaults to `2`): Set buffer size, in frames. Must be >= 1.
* `clock_safe` (`bool` -- defaults to `true`): Force the use of the dedicated bjack clock.
* `server` (`string` -- defaults to `""`): Jack server to connect to.

#### input.keyboard.sdl
```
(?id:string,?velocity:float)->
source(audio='#a,video=0,midi='#b+1)```

WARNING: This is only EXPERIMENTAL!

Play notes from the keyboard.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `velocity` (`float` -- defaults to `0.8`): Velocity of notes.

#### input.lastfm
```
(?id:string,?autostart:bool,?bind_address:string,
 ?buffer:float,?debug:bool,?max:float,
 ?new_track_on_metadata:bool,password:string,
 ?poll_delay:float,?timeout:float,user:string,
 ?user_agent:string,string)->
source(audio=2,video=0,midi=0)```

Forwards the given lastfm stream. The relay can be paused/resumed using the start/stop telnet commands.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `autostart` (`bool` -- defaults to `true`): Initially start relaying or not.
* `bind_address` (`string` -- defaults to `""`): Address to bind on the local machine. This option can be useful if your machine is bound to multiple IPs. ``'' means no bind address.
* `buffer` (`float` -- defaults to `10.`): Duration of the pre-buffered data.
* `debug` (`bool` -- defaults to `false`): Run in debugging mode by not catching some exceptions.
* `max` (`float` -- defaults to `25.`): Maximum duration of the buffered data.
* `new_track_on_metadata` (`bool` -- defaults to `true`): Treat new metadata as new track.
* `password` (`string`): Lastfm password.
* `poll_delay` (`float` -- defaults to `2.`): Polling delay.
* `timeout` (`float` -- defaults to `10.`): Timeout for HTTP connections.
* `user` (`string`): Lastfm user.
* `user_agent` (`string` -- defaults to `"Liquidsoap/1.0.0 (Unix; OCaml 3.12.0)"`): User agent.
* `(unlabeled)` (`string`): URI of a lastfm stream (e.g. lastfm://user/toots5446/playlist).

#### input.mplayer
```
(?id:string,?restart:bool,?restart_on_error:bool,
 ?buffer:float,?max:float,string)->
source(audio='#a+1,video=0,midi=0)```

Stream data from mplayer

* `id` (`string` -- defaults to `"input.mplayer"`)
* `restart` (`bool` -- defaults to `true`): restart on exit.
* `restart_on_error` (`bool` -- defaults to `false`): restart on exit with error.
* `buffer` (`float` -- defaults to `0.2`): Duration of the pre-buffered data.
* `max` (`float` -- defaults to `10.`): Maximum duration of the buffered data.
* `(unlabeled)` (`string`): data URI.

#### input.oss
```
(?id:string,?clock_safe:bool,?device:string,
 ?fallible:bool,?on_start:(()->unit),?on_stop:(()->unit),
 ?start:bool)->active_source(audio='#a+1,video=0,midi=0)```

Stream from an OSS input device.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `clock_safe` (`bool` -- defaults to `true`): Force the use of the dedicated OSS clock.
* `device` (`string` -- defaults to `"/dev/dsp"`): OSS device to use.
* `fallible` (`bool` -- defaults to `false`): Allow the input to stop. When false, the source will be infallible but the stop command won't have any effect.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when input starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when input stops.
* `start` (`bool` -- defaults to `true`): Start input as soon as it is created. Disabling it is only taken into account for a fallible input.

#### input.portaudio
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

#### input.pulseaudio
```
(?id:string,?client:string,?clock_safe:bool,
 ?device:string,?fallible:bool,?fallible:bool,
 ?on_start:(()->unit),?on_start:(()->unit),
 ?on_stop:(()->unit),?on_stop:(()->unit),?start:bool,
 ?start:bool)->
active_source(audio='#a+1,video='#b,midi='#c)```

Stream from a portaudio input device.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `client` (`string` -- defaults to `"liquidsoap"`)
* `clock_safe` (`bool` -- defaults to `true`): Force the use of the dedicated Pulseaudio clock.
* `device` (`string` -- defaults to `""`): Device to use. Uses default if set to ``''.
* `fallible` (`bool` -- defaults to `false`): Allow the input to stop. When false, the source will be infallible but the stop command won't have any effect.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when input starts.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when input stops.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Start input as soon as it is created. Disabling it is only taken into account for a fallible input.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.

#### input.udp
```
(?id:string,?buffer:float,host:string,port:int,string)->
active_source('a)```

WARNING: This is only EXPERIMENTAL!

Input encoded data from UDP, without any control whatsoever.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `buffer` (`float` -- defaults to `1.`): Duration of buffered data before starting playout.
* `host` (`string`)
* `port` (`int`)
* `(unlabeled)` (`string`): Mime type.

#### input.v4l
```
(?id:string,?buffer_size:int,?clock_safe:bool,
 ?device:string,?drop:bool)->
active_source(audio='#a,video=1,midi=0)```

Stream from a video4linux input device, such as a webcam. The most recent version of this library is provided by input.v4l2, only use this one if the other does not work.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `buffer_size` (`int` -- defaults to `2`): Set buffer size, in frames. Must be >= 1.
* `clock_safe` (`bool` -- defaults to `true`): Force the use of the dedicated v4l clock.
* `device` (`string` -- defaults to `"/dev/video0"`): V4L device to use.
* `drop` (`bool` -- defaults to `true`): Drop frames when execution is too slow.

#### input.v4l2
```
(?id:string,?buffer_size:int,?clock_safe:bool,
 ?device:string,?drop:bool)->
active_source(audio='#a,video=1,midi=0)```

Stream from a video4linux 2 input device, such as a webcam.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `buffer_size` (`int` -- defaults to `2`): Set buffer size, in frames. Must be >= 1.
* `clock_safe` (`bool` -- defaults to `true`): Force the use of the dedicated v4l clock.
* `device` (`string` -- defaults to `"/dev/video0"`): V4L device to use.
* `drop` (`bool` -- defaults to `true`): Drop frames when execution is too slow.

#### noise
```
(?id:string,?duration:float)->
source(audio='a,video='b,midi=0)```

Generate white noise.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (`float` -- defaults to `0.`)

#### playlist
```
(?id:string,?conservative:bool,?default_duration:float,
 ?length:float,?mime_type:string,?mode:string,
 ?prefix:string,?reload:int,?reload_mode:string,
 ?timeout:float,string)->source('a)```

Loop on a playlist of URIs.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `conservative` (`bool` -- defaults to `false`): If true, estimated remaining time on the current track is not considered when computing queue length.
* `default_duration` (`float` -- defaults to `30.`): When unknown, assume this duration (in sec.) for files.
* `length` (`float` -- defaults to `10.`): How much audio (in sec.) should be queued in advance.
* `mime_type` (`string` -- defaults to `""`): Default MIME type for the playlist. Empty string means automatic detection.
* `mode` (`string` -- defaults to `"randomize"`): Play the files in the playlist either in the order (``normal'' mode), or shuffle the playlist each time it is loaded, and play it in this order for a whole round (``randomize'' mode), or pick a random file in the playlist each time (``random'' mode).
* `prefix` (`string` -- defaults to `""`): Add a constant prefix to all requests. Useful for passing extra information using annotate, or for resolution through a particular protocol, such as replaygain.
* `reload` (`int` -- defaults to `0`): Amount of time (in seconds or rounds) before which the playlist is reloaded; 0 means never.
* `reload_mode` (`string` -- defaults to `"seconds"`): Unit of the reload parameter, either 'rounds' or 'seconds'.
* `timeout` (`float` -- defaults to `20.`): Timeout (in sec.) for a single download.
* `(unlabeled)` (`string`): URI where to find the playlist.

#### playlist.once
```
(?id:string,?random:bool,?on_done:(()->unit),string)->
source('a)```

Custom playlist source written using the script language.
Will read directory or playlist, play all files and stop

* `id` (`string` -- defaults to `""`): Force the value of the source ID. 
* `random` (`bool` -- defaults to `false`): Randomize playlist content
* `on_done` (`()->unit` -- defaults to `{()}`): Function to execute when the playlist is finished
* `(unlabeled)` (`string`): Playlist URI

#### playlist.reloadable
```
(?id:string,?random:bool,?on_done:(()->unit),string)->
(((?uri:string)->unit)*source('a))```

Custom playlist source written using the script language.
Will read directory or playlist, play all files and stop.
Returns a pair `(reload,source)` where `reload` is a function
of type `(?uri:string)->unit` used to reload the source and `source`
is the actual source. The reload function can optionally be called
with a new playlist URI. Otherwise, it reloads the previous URI.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `random` (`bool` -- defaults to `false`): Randomize playlist content
* `on_done` (`()->unit` -- defaults to `{()}`): Function to execute when the playlist is finished
* `(unlabeled)` (`string`): Playlist URI

#### playlist.safe
```
(?id:string,?mime_type:string,?mode:string,
 ?prefix:string,?reload:int,?reload_mode:string,string)->
source('a)```

Loop on a playlist of local files, and never fail. In order to do so, it has to check every file at the loading, so the streamer startup may take a few seconds. To avoid this, use a standard playlist, and put only a few local files in a default safe_playlist in order to ensure the liveness of the streamer.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `mime_type` (`string` -- defaults to `""`): Default MIME type for the playlist. Empty string means automatic detection.
* `mode` (`string` -- defaults to `"randomize"`): Play the files in the playlist either in the order (``normal'' mode), or shuffle the playlist each time it is loaded, and play it in this order for a whole round (``randomize'' mode), or pick a random file in the playlist each time (``random'' mode).
* `prefix` (`string` -- defaults to `""`): Add a constant prefix to all requests. Useful for passing extra information using annotate, or for resolution through a particular protocol, such as replaygain.
* `reload` (`int` -- defaults to `0`): Amount of time (in seconds or rounds) before which the playlist is reloaded; 0 means never.
* `reload_mode` (`string` -- defaults to `"seconds"`): Unit of the reload parameter, either 'rounds' or 'seconds'.
* `(unlabeled)` (`string`): URI where to find the playlist.

#### request.dynamic
```
(?id:string,?conservative:bool,?default_duration:float,
 ?length:float,?timeout:float,(()->request('a)))->
source('a)```

Play request dynamically created by a given function.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `conservative` (`bool` -- defaults to `false`): If true, estimated remaining time on the current track is not considered when computing queue length.
* `default_duration` (`float` -- defaults to `30.`): When unknown, assume this duration (in sec.) for files.
* `length` (`float` -- defaults to `10.`): How much audio (in sec.) should be queued in advance.
* `timeout` (`float` -- defaults to `20.`): Timeout (in sec.) for a single download.
* `(unlabeled)` (`()->request('a)`)

#### request.equeue
```
(?id:string,?conservative:bool,?default_duration:float,
 ?length:float,?timeout:float)->source('a)```

Receive URIs from users, and play them. Insertion and deletion possible at any position.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `conservative` (`bool` -- defaults to `false`): If true, estimated remaining time on the current track is not considered when computing queue length.
* `default_duration` (`float` -- defaults to `30.`): When unknown, assume this duration (in sec.) for files.
* `length` (`float` -- defaults to `10.`): How much audio (in sec.) should be queued in advance.
* `timeout` (`float` -- defaults to `20.`): Timeout (in sec.) for a single download.

#### request.queue
```
(?id:string,?conservative:bool,?default_duration:float,
 ?interactive:bool,?length:float,?queue:[request('a)],
 ?timeout:float)->source('a)```

Receive URIs from users, and play them.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `conservative` (`bool` -- defaults to `false`): If true, estimated remaining time on the current track is not considered when computing queue length.
* `default_duration` (`float` -- defaults to `30.`): When unknown, assume this duration (in sec.) for files.
* `interactive` (`bool` -- defaults to `true`): Should the queue be controllable via telnet?
* `length` (`float` -- defaults to `10.`): How much audio (in sec.) should be queued in advance.
* `queue` (`[request('a)]` -- defaults to `[]`): Initial queue of requests.
* `timeout` (`float` -- defaults to `20.`): Timeout (in sec.) for a single download.

#### saw
```
(?id:string,?amplitude:float,?duration:float,?float)->
source(audio='#a+1,video=0,midi=0)```

Generate a saw wave.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `amplitude` (`float` -- defaults to `1.`): Maximal value of the waveform.
* `duration` (`float` -- defaults to `0.`)
* `(unlabeled)` (`float` -- defaults to `440.`): Frequency of the saw.

#### sine
```
(?id:string,?amplitude:float,?duration:float,?float)->
source(audio='#a+1,video=0,midi=0)```

Generate a sine wave.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `amplitude` (`float` -- defaults to `1.`): Maximal value of the waveform.
* `duration` (`float` -- defaults to `0.`)
* `(unlabeled)` (`float` -- defaults to `440.`): Frequency of the sine.

#### single
```
(?id:string,?conservative:bool,?default_duration:float,
 ?length:float,?timeout:float,string)->source('a)```

Loop on a request. It never fails if the request is static, meaning that it can be fetched once. Typically, http, ftp, say requests are static, and time is not.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `conservative` (`bool` -- defaults to `false`): If true, estimated remaining time on the current track is not considered when computing queue length.
* `default_duration` (`float` -- defaults to `30.`): When unknown, assume this duration (in sec.) for files.
* `length` (`float` -- defaults to `10.`): How much audio (in sec.) should be queued in advance.
* `timeout` (`float` -- defaults to `20.`): Timeout (in sec.) for a single download.
* `(unlabeled)` (`string`): URI where to find the file

#### square
```
(?id:string,?amplitude:float,?duration:float,?float)->
source(audio='#a+1,video=0,midi=0)```

Generate a square wave.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `amplitude` (`float` -- defaults to `1.`): Maximal value of the waveform.
* `duration` (`float` -- defaults to `0.`)
* `(unlabeled)` (`float` -- defaults to `440.`): Frequency of the square.

Source / Liquidsoap
-------------------
#### buffer
```
(?id:string,?buffer:float,?fallible:bool,?max:float,
 ?on_start:(()->unit),?on_stop:(()->unit),?start:bool,
 source('a))->source('a)```

Create a buffer between two different clocks.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `buffer` (`float` -- defaults to `1.`): Amount of data to pre-buffer, in seconds.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `max` (`float` -- defaults to `10.`): Maximum amount of buffered data, in seconds.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source('a)`)

Source / MIDI Processing
------------------------
#### midi.chord
```
(?id:string,?metadata:string,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c+1)```

Generate a chord.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `metadata` (`string` -- defaults to `"chord"`): Name of the metadata containing the chords.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### midi.merge_all
```
(?id:string,?track_out:int,
 source(audio='#a,video='#b,midi='#c+1))->
source(audio='#a,video='#b,midi='#c+1)```

Merge all MIDI tracks in one.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `track_out` (`int` -- defaults to `0`): Destination track.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c+1)`)

#### midi.remove
```
(?id:string,[int],source(audio='#a,video='#b,midi='#c+1))->
source(audio='#a,video='#b,midi='#c+1)```

Remove MIDI tracks.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`[int]`): Tracks to remove.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c+1)`)

Source / Output
---------------
#### out
```
(source(audio='#a+1,video='#b,midi='#c))->
active_source(audio='#a+1,video='#b,midi='#c)```

Output a stream using the 'output.prefered' operator. The input source does
not need to be infallible, blank will just be played during failures.

* `(unlabeled)` (`source(audio='#a+1,video='#b,midi='#c)`): the source to output

#### output.alsa
```
(?id:string,?bufferize:bool,?clock_safe:bool,
 ?device:string,?fallible:bool,?on_start:(()->unit),
 ?on_stop:(()->unit),?start:bool,
 source(audio='#a+1,video='#b,midi='#c))->
active_source(audio='#a+1,video='#b,midi='#c)```

Output the source's stream to an ALSA output device.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `bufferize` (`bool` -- defaults to `true`): Bufferize output
* `clock_safe` (`bool` -- defaults to `true`): Force the use of the dedicated ALSA clock
* `device` (`string` -- defaults to `"default"`): Alsa device to use
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source(audio='#a+1,video='#b,midi='#c)`)

#### output.ao
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

#### output.dummy
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

#### output.external
```
(?id:string,?fallible:bool,?flush:int,
 ?on_start:(()->unit),?on_stop:(()->unit),
 ?reopen_delay:float,?reopen_on_metadata:bool,
 ?reopen_when:(()->bool),?start:bool,format('a),string,
 source('a))->active_source('a)```

Send the stream to a process' standard input.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `flush` (`int` -- defaults to `false`): Perform a flush after each write.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `reopen_delay` (`float` -- defaults to `120.`): Prevent re-opening within that delay, in seconds.
* `reopen_on_metadata` (`bool` -- defaults to `false`): Re-open on every new metadata information.
* `reopen_when` (`()->bool` -- defaults to `{false}`): When should the output be re-opened.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`format('a)`): Encoding format.
* `(unlabeled)` (`string`): Process to pipe data to. Some strftime conversion specifiers are available: `%SMHdmY`. You can also use `$(..)` interpolation notation for metadata.
* `(unlabeled)` (`source('a)`)

#### output.file
```
(?id:string,?append:bool,?dir_perm:int,?fallible:bool,
 ?flush:int,?on_close:((string)->unit),
 ?on_start:(()->unit),?on_stop:(()->unit),?perm:int,
 ?reopen_delay:float,?reopen_on_metadata:bool,
 ?reopen_when:(()->bool),?start:bool,format('a),string,
 source('a))->active_source('a)```

Output the source stream to a file.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `append` (`bool` -- defaults to `false`): Do not truncate but append in the file if it exists.
* `dir_perm` (`int` -- defaults to `511`): Permission of the directories if some have to be created, up to umask. Although you can enter values in octal notation (0oXXX) they will be displayed in decimal (for instance, 0o777 = 7*8^2 + 7*8 + 7 = 511).
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `flush` (`int` -- defaults to `false`): Perform a flush after each write.
* `on_close` (`(string)->unit` -- defaults to `fun (_) -> ()`): This function will be called for each file, after that it is finished and closed. The filename will be passed as argument.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `perm` (`int` -- defaults to `438`): Permission of the file if it has to be created, up to umask. You can and should write this number in octal notation: 0oXXX. The default value is however displayed in decimal (0o666 = 6*8^2 + 6*8 + 6 = 438).
* `reopen_delay` (`float` -- defaults to `120.`): Prevent re-opening within that delay, in seconds.
* `reopen_on_metadata` (`bool` -- defaults to `false`): Re-open on every new metadata information.
* `reopen_when` (`()->bool` -- defaults to `{false}`): When should the output be re-opened.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`format('a)`): Encoding format.
* `(unlabeled)` (`string`): Filename where to output the stream. Some strftime conversion specifiers are available: `%SMHdmY`. You can also use `$(..)` interpolation notation for metadata.
* `(unlabeled)` (`source('a)`)

#### output.graphics
```
(?id:string,?fallible:bool,?on_start:(()->unit),
 ?on_stop:(()->unit),?start:bool,
 source(audio=0,video=1,midi=0))->
active_source(audio=0,video=1,midi=0)```

Display video stream using the Graphics library.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source(audio=0,video=1,midi=0)`)

#### output.harbor
```
(?id:string,?auth:((string,string)->bool),?buffer:int,
 ?burst:int,?chunk:int,?dumpfile:string,?encoding:string,
 ?fallible:bool,?format:string,
 ?headers:[(string*string)],?icy_metadata:string,
 ?metaint:int,mount:string,
 ?on_connect:((headers:[(string*string)],uri:string,
               protocol:string,string)->unit),
 ?on_disconnect:((string)->unit),?on_start:(()->unit),
 ?on_stop:(()->unit),?password:string,?port:int,
 ?protocol:string,?start:bool,?timeout:float,?url:string,
 ?user:string,format('a),source('a))->active_source('a)```

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
* `icy_metadata` (`string` -- defaults to `"guess"`): Send new metadata using the ICY protocol. One of: ``guess'', ``true'', ``false''
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
* `protocol` (`string` -- defaults to `"http"`): Protocol of the streaming server: 'http' for Icecast, 'icy' for shoutcast.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `timeout` (`float` -- defaults to `30.`): Timeout for network operations.
* `url` (`string` -- defaults to `""`)
* `user` (`string` -- defaults to `""`): User for client connection, disabled if empty.
* `(unlabeled)` (`format('a)`): Encoding format.
* `(unlabeled)` (`source('a)`)

#### output.icecast
```
(?id:string,?connection_timeout:float,
 ?description:string,?dumpfile:string,?encoding:string,
 ?fallible:bool,?format:string,?genre:string,
 ?headers:[(string*string)],?host:string,
 ?icy_metadata:string,?mount:string,?name:string,
 ?on_connect:(()->unit),?on_disconnect:(()->unit),
 ?on_error:((string)->float),?on_start:(()->unit),
 ?on_stop:(()->unit),?password:string,?port:int,
 ?protocol:string,?public:bool,?start:bool,
 ?timeout:float,?url:string,?user:string,format('a),
 source('a))->active_source('a)```

Encode and output the stream to an icecast2 or shoutcast server.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `connection_timeout` (`float` -- defaults to `5.`): Timeout for establishing network connections (disabled is negative).
* `description` (`string` -- defaults to `"Liquidsoap Radio!"`)
* `dumpfile` (`string` -- defaults to `""`): Dump stream to file, for debugging purpose. Disabled if empty.
* `encoding` (`string` -- defaults to `""`): Encoding used to send metadata. If empty, defaults to ``UTF-8'' for ``http'' protocol and ``ISO-8859-1'' for ``icy'' protocol.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `format` (`string` -- defaults to `""`): Format, e.g. ``audio/ogg''. When empty, the encoder is used to guess.
* `genre` (`string` -- defaults to `"Misc"`)
* `headers` (`[(string*string)]` -- defaults to ```
[("User-Agent","Liquidsoap/1.0.0 (Unix; OCaml 3.12.0)")]```
): Additional headers.
* `host` (`string` -- defaults to `"localhost"`)
* `icy_metadata` (`string` -- defaults to `"guess"`): Send new metadata using the ICY protocol. One of: ``guess'', ``true'', ``false''
* `mount` (`string` -- defaults to ```
"Use [name] with .ogg extension if relevant"```
)
* `name` (`string` -- defaults to `"Use [mount]"`)
* `on_connect` (`()->unit` -- defaults to `{()}`): Callback executed when connection is established.
* `on_disconnect` (`()->unit` -- defaults to `{()}`): Callback executed when connection stops.
* `on_error` (`(string)->float` -- defaults to `fun (_) -> 3.`): Callback executed when an error happens. The callback receives a string representation of the error that occured and returns a float. If returned value is positive, connection will be tried again after this amount of time (in seconds).
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `password` (`string` -- defaults to `"hackme"`)
* `port` (`int` -- defaults to `8000`)
* `protocol` (`string` -- defaults to `"http"`): Protocol of the streaming server: 'http' for Icecast, 'icy' for shoutcast.
* `public` (`bool` -- defaults to `true`)
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `timeout` (`float` -- defaults to `30.`): Timeout for network read and write.
* `url` (`string` -- defaults to `"http://savonet.sf.net"`)
* `user` (`string` -- defaults to `"source"`): User for shout source connection. Useful only in special cases, like with per-mountpoint users.
* `(unlabeled)` (`format('a)`): Encoding format.
* `(unlabeled)` (`source('a)`)

#### output.jack
```
(?id:string,?buffer_size:int,?clock_safe:bool,
 ?fallible:bool,?on_start:(()->unit),?on_stop:(()->unit),
 ?server:string,?start:bool,
 source(audio='#a+1,video=0,midi=0))->
active_source(audio='#a+1,video=0,midi=0)```

Output stream to jack.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `buffer_size` (`int` -- defaults to `2`): Set buffer size, in frames.
* `clock_safe` (`bool` -- defaults to `true`): Force the use of the dedicated bjack clock.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `server` (`string` -- defaults to `""`): Jack server to connect to.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source(audio='#a+1,video=0,midi=0)`)

#### output.oss
```
(?id:string,?clock_safe:bool,?device:string,
 ?fallible:bool,?on_start:(()->unit),?on_stop:(()->unit),
 ?start:bool,source(audio='#a+1,video='#b,midi='#c))->
active_source(audio='#a+1,video='#b,midi='#c)```

Output the source's stream to an OSS output device.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `clock_safe` (`bool` -- defaults to `true`): Force the use of the dedicated OSS clock.
* `device` (`string` -- defaults to `"/dev/dsp"`): OSS device to use.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source(audio='#a+1,video='#b,midi='#c)`)

#### output.portaudio
```
(?id:string,?buflen:int,?clock_safe:bool,?fallible:bool,
 ?on_start:(()->unit),?on_stop:(()->unit),?start:bool,
 source(audio='#a+1,video='#b,midi='#c))->
source(audio='#a+1,video='#b,midi='#c)```

Output the source's stream to a portaudio output device.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `buflen` (`int` -- defaults to `256`): Length of a buffer in samples.
* `clock_safe` (`bool` -- defaults to `true`): Force the use of the dedicated Portaudio clock.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source(audio='#a+1,video='#b,midi='#c)`)

#### output.prefered
```
(?id:string,?fallible:bool,?on_start:(()->unit),
 ?on_stop:(()->unit),?start:bool,
 source(audio='#a+1,video='#b,midi='#c))->
active_source(audio='#a+1,video='#b,midi='#c)```

Output to local audio card using the first available driver in
pulseaudio, portaudio, oss, alsa, ao, dummy.

* `id` (`string` -- defaults to `""`)
* `fallible` (`bool` -- defaults to `false`)
* `on_start` (`()->unit` -- defaults to `{()}`)
* `on_stop` (`()->unit` -- defaults to `{()}`)
* `start` (`bool` -- defaults to `true`)
* `(unlabeled)` (`source(audio='#a+1,video='#b,midi='#c)`)

#### output.pulseaudio
```
(?id:string,?client:string,?clock_safe:bool,
 ?device:string,?fallible:bool,?on_start:(()->unit),
 ?on_stop:(()->unit),?start:bool,
 source(audio='#a+1,video='#b,midi='#c))->
active_source(audio='#a+1,video='#b,midi='#c)```

Output the source's stream to a portaudio output device.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `client` (`string` -- defaults to `"liquidsoap"`)
* `clock_safe` (`bool` -- defaults to `true`): Force the use of the dedicated Pulseaudio clock.
* `device` (`string` -- defaults to `""`): Device to use. Uses default if set to ``''.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source(audio='#a+1,video='#b,midi='#c)`)

#### output.sdl
```
(?id:string,?fallible:bool,?on_start:(()->unit),
 ?on_stop:(()->unit),?start:bool,
 source(audio=0,video=1,midi=0))->
active_source(audio=0,video=1,midi=0)```

Display a video using SDL.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()->unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()->unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source(audio=0,video=1,midi=0)`)

#### output.shoutcast
```
(?id:string,?start:bool,?host:string,?port:int,
 ?user:string,?password:string,?genre:string,?url:string,
 ?name:string,?public:bool,?format:string,
 ?dumpfile:string,?icy_metadata:string,
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
* `user` (`string` -- defaults to `"source"`): User for shout source connection. Useful only in special cases, like with per-mountpoint users.
* `password` (`string` -- defaults to `"hackme"`)
* `genre` (`string` -- defaults to `"Misc"`)
* `url` (`string` -- defaults to `"http://savonet.sf.net/"`)
* `name` (`string` -- defaults to `"Liquidsoap Radio!"`)
* `public` (`bool` -- defaults to `true`)
* `format` (`string` -- defaults to `""`): Format, e.g. ``audio/ogg''. When empty, the encoder is used to guess.
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
* `(unlabeled)` (`format('a)`): Endoding format. For shoutcast, should be mp3 or AAC(+).
* `(unlabeled)` (`source('a)`): The source to output

#### output.udp
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
#### add
```
(?id:string,?normalize:bool,?weights:[int],
 [source(audio='#a,video='#b,midi=0)])->
source(audio='#a,video='#b,midi=0)```

Mix sources, with optional normalization. Only relay metadata from the first source that is effectively summed.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `normalize` (`bool` -- defaults to `true`)
* `weights` (`[int]` -- defaults to `[]`): Relative weight of the sources in the sum. The empty list stands for the homogeneous distribution.
* `(unlabeled)` (`[source(audio='#a,video='#b,midi=0)]`)

#### amplify
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

#### bpm
```
(?id:string,?every:int,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

WARNING: This is only EXPERIMENTAL!

Detect the BPM.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `every` (`int` -- defaults to `500`)
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### clip
```
(?id:string,?max:float,?min:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Clip sound.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `max` (`float` -- defaults to `0.999`): Maximal acceptable value.
* `min` (`float` -- defaults to `-0.999`): Minimal acceptable value.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### comb
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
 -- defaults to `-6.`): Feedback coefficient in dB.
* `(unlabeled)` (`source(audio='#b,video='#c,midi='#d)`)

#### compand
```
(?id:string,?mu:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Compand the signal

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `mu` (`float` -- defaults to `1.`)
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### compress
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
 -- defaults to `100.`): Attack time (ms).
* `gain` (```
anything that is either float or ()->float```
 -- defaults to `0.`): Additional gain (dB).
* `knee` (```
anything that is either float or ()->float```
 -- defaults to `1.`): Knee radius (dB).
* `ratio` (`float` -- defaults to `2.`): Gain reduction ratio (n:1).
* `release` (```
anything that is either float or ()->float```
 -- defaults to `400.`): Release time (ms).
* `rms_window` (`float` -- defaults to `0.1`): Window for computing RMS (in sec).
* `threshold` (```
anything that is either float or ()->float```
 -- defaults to `-10.`): Threshold level (dB).
* `(unlabeled)` (`source(audio='#f,video='#g,midi='#h)`)

#### compress.exponential
```
(?id:string,?mu:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Exponential compressor.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `mu` (`float` -- defaults to `2.`): Exponential compression factor, typically greater than 1.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### cross
```
(?id:string,?active:bool,?conservative:bool,
 ?duration:float,?inhibit:float,?minimum:float,
 ?override:string,((source('a),source('a))->source('a)),
 source('a))->source('a)```

Generic cross operator, allowing the composition of the N last seconds of a track with the beginning of the next track.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `active` (`bool` -- defaults to `false`): The active behavior is to keep ticking the child's clock when the operator is not streaming. Otherwise the child's clock is strictly based on what is streamed off the child source, which results in time-dependent active sources to be frozen when that source is stopped.
* `conservative` (`bool` -- defaults to `false`): Do not trust remaining time estimations, always buffering data in advance. This avoids being tricked by skips, either manual or caused by skip_blank().
* `duration` (`float` -- defaults to `5.`): Duration in seconds of the crossed end of track. This value can be changed on a per-file basis using a special metadata field.
* `inhibit` (`float` -- defaults to `-1.`): Minimum delay between two transitions. It is useful in order to avoid that a transition is triggered on top of another when an end-of-track occurs in the first one. Negative values mean `duration+1`. Warning: zero inhibition can cause infinite loops.
* `minimum` (`float` -- defaults to `-1.`): Minimum duration (in sec.) for a cross: If the track ends without any warning (e.g. in case of skip) there may not be enough data for a decent composition. Set to 0. to avoid having transitions after skips, or more to avoid transitions on short tracks. With the negative default, transitions always occur.
* `override` (`string` -- defaults to `"liq_start_next"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
* `(unlabeled)` (`(source('a),source('a))->source('a)`): Composition of an end of track and the next track.
* `(unlabeled)` (`source('a)`)

#### echo
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
 -- defaults to `-6.`): Feedback coefficient in dB (negative).
* `ping_pong` (`bool` -- defaults to `false`): Use ping-pong delay.
* `(unlabeled)` (`source(audio='#c,video='#d,midi='#e)`)

#### fade.final
```
(?id:string,?duration:float,?type:string,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Fade a stream to silence.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (`float` -- defaults to `3.`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `type` (`string` -- defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### fade.in
```
(?id:string,?duration:float,?override:string,
 ?type:string,source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Fade the beginning of tracks. A special override metadata field can be used to set the duration for a specific track (float in seconds).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (`float` -- defaults to `3.`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `override` (`string` -- defaults to `"liq_fade_in"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
* `type` (`string` -- defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### fade.initial
```
(?id:string,?duration:float,?type:string,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Fade the beginning of a stream.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (`float` -- defaults to `3.`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `type` (`string` -- defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### fade.out
```
(?id:string,?duration:float,?override:string,
 ?type:string,source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Fade the end of tracks. A special override metadata field can be used to set the duration for a specific track (float in seconds).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (`float` -- defaults to `3.`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `override` (`string` -- defaults to `"liq_fade_out"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
* `type` (`string` -- defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### filter
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
 -- defaults to `1.`)
* `wetness` (```
anything that is either float or ()->float```
 -- defaults to `1.`): How much of the original signal should be added (1. means only filtered and 0. means only original signal).
* `(unlabeled)` (`source(audio='#d,video='#e,midi='#f)`)

#### filter.fir
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

#### filter.iir.butterworth.bandpass
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

#### filter.iir.butterworth.bandstop
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

#### filter.iir.butterworth.high
```
(?id:string,frequency:float,?order:int,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

IIR filter

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `order` (`int` -- defaults to `4`): Filter order
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### filter.iir.butterworth.low
```
(?id:string,frequency:float,?order:int,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

IIR filter

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `order` (`int` -- defaults to `4`): Filter order
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### filter.iir.eq.allpass
```
(?id:string,?bandwidth:float,frequency:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

All pass biquad filter.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `bandwidth` (`float` -- defaults to `0.333333333333`): Bandwidth (in octaves)
* `frequency` (`float`): Center frequency
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### filter.iir.eq.bandpass
```
(?id:string,frequency:float,?q:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Band pass biquad filter.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Center frequency
* `q` (`float` -- defaults to `1.`): Q
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### filter.iir.eq.high
```
(?id:string,frequency:float,?q:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

High pass biquad filter.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `q` (`float` -- defaults to `1.`): Q
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### filter.iir.eq.highshelf
```
(?id:string,frequency:float,?slope:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

High shelf biquad filter.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Center frequency
* `slope` (`float` -- defaults to `1.`): Shelf slope (in dB/octave)
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### filter.iir.eq.low
```
(?id:string,frequency:float,?q:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Low pass biquad filter.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `q` (`float` -- defaults to `1.`): Q
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### filter.iir.eq.lowshelf
```
(?id:string,frequency:float,?slope:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Low shelf biquad filter.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `slope` (`float` -- defaults to `1.`): Shelf slope (dB/octave)
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### filter.iir.eq.notch
```
(?id:string,frequency:float,?q:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Band pass biquad filter.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Center frequency
* `q` (`float` -- defaults to `1.`): Q
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### filter.iir.eq.peak
```
(?id:string,frequency:float,?gain:float,?q:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Peak EQ biquad filter.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Center frequency
* `gain` (`float` -- defaults to `1.`): Gain (in dB)
* `q` (`float` -- defaults to `1.`): Q
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### filter.iir.resonator.allpass
```
(?id:string,frequency:float,?q:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

IIR filter

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `q` (`float` -- defaults to `60.`): Quality factor
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### filter.iir.resonator.bandpass
```
(?id:string,frequency:float,?q:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

IIR filter

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `q` (`float` -- defaults to `60.`): Quality factor
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### filter.iir.resonator.bandstop
```
(?id:string,frequency:float,?q:float,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

IIR filter

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `q` (`float` -- defaults to `60.`): Quality factor
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### flanger
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
 -- defaults to `0.`): Feedback coefficient in dB.
* `freq` (```
anything that is either float or ()->float```
 -- defaults to `0.5`): Frequency in Hz.
* `phase` (```
anything that is either float or ()->float```
 -- defaults to `1.`): Phase difference between channels in radians.
* `(unlabeled)` (`source(audio='#d,video='#e,midi='#f)`)

#### helium
```
(source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Increases the pitch, making voices sound like on helium.

* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`): The input source.

#### limit
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
 -- defaults to `100.`): Attack time (ms).
* `gain` (```
anything that is either float or ()->float```
 -- defaults to `0.`): Additional gain (dB).
* `knee` (```
anything that is either float or ()->float```
 -- defaults to `1.`): Knee radius (dB).
* `ratio` (`float` -- defaults to `20.`): Gain reduction ratio (n:1).
* `release` (```
anything that is either float or ()->float```
 -- defaults to `400.`): Release time (ms).
* `rms_window` (`float` -- defaults to `0.1`): Window for computing RMS (in sec).
* `threshold` (```
anything that is either float or ()->float```
 -- defaults to `-10.`): Threshold level (dB).
* `(unlabeled)` (`source(audio='#f,video='#g,midi='#h)`)

#### mic_filter
```
(source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Remove low frequencies often produced by microphones.

* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`): The input source.

#### mix
```
(?id:string,[source(audio='#a,video='#b,midi='#c)])->
source(audio='#a,video='#b,midi='#c)```

Mixing table controllable via the telnet interface.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`[source(audio='#a,video='#b,midi='#c)]`)

#### normalize
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
 -- defaults to `6.`): Maximal gain value (dB).
* `gain_min` (```
anything that is either float or ()->float```
 -- defaults to `-6.`): Minimal gain value (dB).
* `k_down` (```
anything that is either float or ()->float```
 -- defaults to `0.1`): Coefficient when the power must go down (between 0 and 1, slowest to fastest).
* `k_up` (```
anything that is either float or ()->float```
 -- defaults to `0.005`): Coefficient when the power must go up (between 0 and 1, slowest to fastest).
* `target` (```
anything that is either float or ()->float```
 -- defaults to `-13.`): Desired RMS (dB).
* `threshold` (```
anything that is either float or ()->float```
 -- defaults to `-40.`): Minimal RMS for activaing gain control (dB).
* `window` (`float` -- defaults to `0.1`): Duration of the window used to compute the current RMS power (second).
* `(unlabeled)` (`source(audio='#g,video='#h,midi='#i)`)

#### nrj
```
(source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Compress and normalize, producing a more uniform and ``full'' sound.

* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`): The input source.

#### sky
```
(source(audio='#a,video='#b,midi=0))->
source(audio='#a,video='#b,midi=0)```

Multiband-compression.

* `(unlabeled)` (`source(audio='#a,video='#b,midi=0)`): The input source.

#### smart_cross
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
* `conservative` (`bool` -- defaults to `false`): Do not trust remaining time estimations, always buffering data in advance. This avoids being tricked by skips, either manual or caused by skip_blank().
* `duration` (`float` -- defaults to `5.`): Duration in seconds of the crossed end of track.
* `inhibit` (`float` -- defaults to `-1.`): Minimum delay between two transitions. It is useful in order to avoid that a transition is triggered on top of another when an end-of-track occurs in the first one. Negative values mean `duration+1`. Warning: zero inhibition can cause infinite loops.
* `minimum` (`float` -- defaults to `-1.`): Minimum duration (in sec.) for a cross: If the track ends without any warning (e.g. in case of skip) there may not be enough data for a decent composition. Set to 0. to avoid having transitions after skips, or more to avoid transitions on short tracks. With the negative default, transitions always occur.
* `width` (`float` -- defaults to `1.`): Width of the power computation window.
* `(unlabeled)` (```
(float,float,[(string*string)],[(string*string)],
 source(audio='#a+1,video=0,midi=0),
 source(audio='#a+1,video=0,midi=0))->
source(audio='#a+1,video=0,midi=0)```
): Transition function, composing from the end of a track and the next track. It also takes the power of the signal before and after the transition, and the metadata.
* `(unlabeled)` (`source(audio='#a+1,video=0,midi=0)`)

#### soundtouch
```
(?id:string,?pitch:'a,?rate:'b,?tempo:'c,
 source(audio='#d,video='#e,midi='#f))->
source(audio='#d,video='#e,midi='#f)
where 'a, 'b, 'c is either float or ()->float```

WARNING: This is only EXPERIMENTAL!

Change the rate, the tempo or the pitch of the sound.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `pitch` (```
anything that is either float or ()->float```
 -- defaults to `1.`)
* `rate` (```
anything that is either float or ()->float```
 -- defaults to `1.`)
* `tempo` (```
anything that is either float or ()->float```
 -- defaults to `1.`)
* `(unlabeled)` (`source(audio='#d,video='#e,midi='#f)`)

#### stereo.ms.decode
```
(?id:string,?width:float,source(audio=2,video=0,midi=0))->
source(audio=2,video=0,midi=0)```

Decode mid+side stereo (M/S) to left+right stereo.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `width` (`float` -- defaults to `1.`): Width of the stereo field.
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

#### stereo.ms.encode
```
(?id:string,source(audio=2,video=0,midi=0))->
source(audio=2,video=0,midi=0)```

Encode left+right stereo to mid+side stereo (M/S).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

#### stereo.pan
```
(?id:string,?field:'a,?pan:'b,
 source(audio=2,video=0,midi=0))->
source(audio=2,video=0,midi=0)
where 'a, 'b is either float or ()->float```

Pan a stereo sound.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `field` (```
anything that is either float or ()->float```
 -- defaults to `90.`): Field width in degrees (between 0 and 90).
* `pan` (```
anything that is either float or ()->float```
 -- defaults to `0.`): Pan ranges between -1 and 1.
* `(unlabeled)` (`source(audio=2,video=0,midi=0)`)

#### stretch
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
#### synth.all.saw
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

#### synth.all.sine
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

#### synth.all.square
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

#### synth.saw
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

#### synth.sine
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

#### synth.square
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
#### append
```
(?id:string,?insert_missing:bool,?merge:bool,source('a),
 (([(string*string)])->source('a)))->source('a)```

Append an extra track to every track. Set the metadata 'liq_append' to 'false' to inhibit appending on one track.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `insert_missing` (`bool` -- defaults to `true`): Treat track beginnings without metadata as having empty one.
* `merge` (`bool` -- defaults to `false`): Merge the track with its appended track.
* `(unlabeled)` (`source('a)`)
* `(unlabeled)` (`([(string*string)])->source('a)`): Given the metadata, build the source producing the track to append. This source is allowed to fail (produce nothing) if no relevant track is to be appended.

#### at
```
((()->bool),source('a))->source('a)```

Restrict a source to play only when a predicate is true.

* `(unlabeled)` (`()->bool`): The predicate, typically a time interval such as `{10h-10h30}`.
* `(unlabeled)` (`source('a)`)

#### crossfade
```
(?id:string,start_next:float,fade_in:float,
 fade_out:float,source(audio='#a,video='#b,midi=0))->
source(audio='#a,video='#b,midi=0)```

Simple crossfade.

* `id` (`string` -- defaults to `""`)
* `start_next` (`float`): Duration in seconds of the crossed end of track.
* `fade_in` (`float`): Duration of the fade in for next track
* `fade_out` (`float`): Duration of the fade out for previous track
* `(unlabeled)` (`source(audio='#a,video='#b,midi=0)`): The source to use

#### cue_cut
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

#### delay
```
(?id:string,?initial:bool,float,source('a))->source('a)```

Prevents the child from being ready again too fast after a end of track

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `initial` (`bool` -- defaults to `false`): Start in unavailable state, as if a track had just finished.
* `(unlabeled)` (`float`): The source won't be ready less than this amount of seconds after any end of track
* `(unlabeled)` (`source('a)`)

#### drop_metadata
```
(source('a))->source('a)```

Removes all metadata coming from a source

* `(unlabeled)` (`source('a)`)

#### eat_blank
```
(?id:string,?at_beginning:bool,?length:float,
 ?threshold:float,?track_sensitive:bool,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Eat blanks, i.e., drop the contents of the stream until it is not blank anymore.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `at_beginning` (`bool` -- defaults to `false`): Only eat at the beginning of a track.
* `length` (`float` -- defaults to `20.`): Maximum silence length allowed, in seconds.
* `threshold` (`float` -- defaults to `-40.`): Power in decibels under which the stream is considered silent.
* `track_sensitive` (`bool` -- defaults to `true`): Reset blank counter at each track.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### fallback
```
(?id:string,?replay_metadata:bool,?track_sensitive:bool,
 ?transitions:[(source('a),source('a))->source('a)],
 [source('a)])->source('a)```

At the beginning of each track, select the first ready child.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `replay_metadata` (`bool` -- defaults to `true`): Replay the last metadata of a child when switching to it in the middle of a track.
* `track_sensitive` (`bool` -- defaults to `true`): Re-select only on end of tracks.
* `transitions` (`[(source('a),source('a))->source('a)]` -- defaults to `[]`): Transition functions, padded with `fun (x,y) -> y` functions.
* `(unlabeled)` (`[source('a)]`): Select the first ready source in this list.

#### fallback.skip
```
(input:source('a),source('a))->source('a)```

Special track insensitive fallback that
always skip current song before switching.

* `input` (`source('a)`): The input source
* `(unlabeled)` (`source('a)`): The fallback source

#### insert_metadata
```
(?id:string,source('a))->
((([(string*string)])->unit)*source('a))```

Dynamically insert metadata in a stream. Returns a pair (f,s) where s is a new source and f is a function of type (metadata)->unit, used to insert metadata in s.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source('a)`)

#### map_metadata
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

#### merge_tracks
```
(source('a))->source('a)```

Merge all tracks from a source, provided that it does not fail

* `(unlabeled)` (`source('a)`)

#### mksafe
```
(source('a))->source('a)```

Turn a source into an infaillible source.
by adding blank when the source is not available.

* `(unlabeled)` (`source('a)`): the source to turn infaillible

#### notify_metadata
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

#### on_blank
```
(?id:string,?length:float,?on_noise:(()->unit),
 ?threshold:float,?track_sensitive:bool,(()->unit),
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Calls a given handler when detecting a blank.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `length` (`float` -- defaults to `20.`): Maximum silence length allowed, in seconds.
* `on_noise` (`()->unit` -- defaults to `{()}`): Handler called when noise is detected.
* `threshold` (`float` -- defaults to `-40.`): Power in decibels under which the stream is considered silent.
* `track_sensitive` (`bool` -- defaults to `true`): Reset blank counter at each track.
* `(unlabeled)` (`()->unit`): Handler called when blank is detected.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### on_end
```
(?id:string,?delay:float,
 ((float,[(string*string)])->unit),source('a))->
source('a)```

Call a given handler when there is less than a given amount of time remaining before then end of track.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `delay` (`float` -- defaults to `5.`): Execute handler when remaining time is less or equal to this value.
* `(unlabeled)` (`(float,[(string*string)])->unit`): Function to execute. First argument is the remaining time, second is the latest metadata.
* `(unlabeled)` (`source('a)`)

#### on_metadata
```
(?id:string,(([(string*string)])->unit),source('a))->
source('a)```

Call a given handler on metadata packets.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`([(string*string)])->unit`): Function called on every metadata packet in the stream. It should be fast because it is ran in the main thread.
* `(unlabeled)` (`source('a)`)

#### on_track
```
(?id:string,(([(string*string)])->unit),source('a))->
source('a)```

Call a given handler on new tracks.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`([(string*string)])->unit`): Function called on every beginning of track in the stream, with the corresponding metadata as argument. If there is no metadata at the beginning of track, the empty list is passed. That function should be fast because it is ran in the main thread.
* `(unlabeled)` (`source('a)`)

#### once
```
(source('a))->source('a)```

Creates a source that plays only one track of the input source.

* `(unlabeled)` (`source('a)`): The input source.

#### osd_metadata
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

#### prepend
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

#### random
```
(?id:string,?replay_metadata:bool,?track_sensitive:bool,
 ?transitions:[(source('a),source('a))->source('a)],
 ?weights:[int],[source('a)])->source('a)```

At the beginning of every track, select a random ready child.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `replay_metadata` (`bool` -- defaults to `true`): Replay the last metadata of a child when switching to it in the middle of a track.
* `track_sensitive` (`bool` -- defaults to `true`): Re-select only on end of tracks.
* `transitions` (`[(source('a),source('a))->source('a)]` -- defaults to `[]`): Transition functions, padded with `fun (x,y) -> y` functions.
* `weights` (`[int]` -- defaults to `[]`): Weights of the children (padded with 1), defining for each child the probability that it is selected.
* `(unlabeled)` (`[source('a)]`)

#### rewrite_metadata
```
([(string*string)],?insert_missing:bool,?update:bool,
 ?strip:bool,source('a))->source('a)```

Rewrite metadata on the fly using a list of (target,rules).

* `(unlabeled)` (`[(string*string)]`): List of (target,value) rewriting rules.
* `insert_missing` (`bool` -- defaults to `true`): Treat track beginnings without metadata as having empty ones. The operational order is: create empty if needed, map and strip if enabled.
* `update` (`bool` -- defaults to `true`): Only update metadata. If false, only returned values will be set as metadata.
* `strip` (`bool` -- defaults to `false`): Completly remove empty metadata. Operates on both empty values and empty metadata chunk.
* `(unlabeled)` (`source('a)`)

#### rotate
```
(?id:string,?replay_metadata:bool,?track_sensitive:bool,
 ?transitions:[(source('a),source('a))->source('a)],
 ?weights:[int],[source('a)])->source('a)```

Rotate between the sources.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `replay_metadata` (`bool` -- defaults to `true`): Replay the last metadata of a child when switching to it in the middle of a track.
* `track_sensitive` (`bool` -- defaults to `true`): Re-select only on end of tracks.
* `transitions` (`[(source('a),source('a))->source('a)]` -- defaults to `[]`): Transition functions, padded with `fun (x,y) -> y` functions.
* `weights` (`[int]` -- defaults to `[]`): Weights of the children (padded with 1), defining for each child how many tracks are played from it per round, if that many are actually available.
* `(unlabeled)` (`[source('a)]`)

#### say_metadata
```
(source(?A),?pattern:string)->source(?A)```

Append speech-synthesized tracks reading the metadata.

* `(unlabeled)` (`source(?A)`): The source to use
* `pattern` (`string` -- defaults to ```
"say:$(if $(artist),\"It was $(artist)$(if $(title),\\\", $(title)\\\").\")"```
): Pattern to use

#### sequence
```
(?id:string,?merge:bool,[source('a)])->source('a)```

Play only one track of every successive source, except for the last one which is played as much as available.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `merge` (`bool` -- defaults to `false`)
* `(unlabeled)` (`[source('a)]`)

#### server.insert_metadata
```
(?id:string,source('a))->source('a)```

Register a server/telnet command to 
update a source's metadata. Returns
a new source, which will receive the 
updated metadata. It behaves just like
the pre-1.0 insert_metadata() operator, 
i.e. insert key1=``val1'',key2=``val2'',...

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source('a)`)

#### skip_blank
```
(?id:string,?length:float,?threshold:float,
 ?track_sensitive:bool,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Skip track when detecting a blank.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `length` (`float` -- defaults to `20.`): Maximum silence length allowed, in seconds.
* `threshold` (`float` -- defaults to `-40.`): Power in decibels under which the stream is considered silent.
* `track_sensitive` (`bool` -- defaults to `true`): Reset blank counter at each track.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### smart_crossfade
```
(?start_next:float,?fade_in:float,?fade_out:float,
 ?default:((source(audio='#a+1,video=0,midi=0),
            source(audio='#a+1,video=0,midi=0))->
           source(audio='#a+1,video=0,midi=0)),
 ?high:float,?medium:float,?margin:float,?width:float,
 ?conservative:bool,source(audio='#a+1,video=0,midi=0))->
source(audio='#a+1,video=0,midi=0)```

Crossfade between tracks, taking the respective volume levels into account in
the choice of the transition.

* `start_next` (`float` -- defaults to `5.`): Crossing duration, if any.
* `fade_in` (`float` -- defaults to `3.`): Fade-in duration, if any.
* `fade_out` (`float` -- defaults to `3.`): Fade-out duration, if any.
* `default` (```
(source(audio='#a+1,video=0,midi=0),
 source(audio='#a+1,video=0,midi=0))->
source(audio='#a+1,video=0,midi=0)```
 -- defaults to <code><fun></code>): Transition used when no rule applies (default: sequence).
* `high` (`float` -- defaults to `-15.`): Value, in dB, for loud sound level
* `medium` (`float` -- defaults to `-32.`): Value, in dB, for medium sound level
* `margin` (`float` -- defaults to `4.`): Margin to detect sources that have too different sound level for crossing.
* `width` (`float` -- defaults to `2.`): Width of the volume analysis window.
* `conservative` (`bool` -- defaults to `false`): Always prepare for a premature end-of-track.
* `(unlabeled)` (`source(audio='#a+1,video=0,midi=0)`): The input source.

#### smooth_add
```
(?delay:float,?p:float,
 normal:source(audio='#a,video='#b,midi=0),
 special:source(audio='#a,video='#b,midi=0))->
source(audio='#a,video='#b,midi=0)```

Mixes two streams, with faded transitions between the state when only the
normal stream is available and when the special stream gets added on top of
it.

* `delay` (`float` -- defaults to `0.5`): Delay before starting the special source.
* `p` (`float` -- defaults to `0.2`): Portion of amplitude of the normal source in the mix.
* `normal` (`source(audio='#a,video='#b,midi=0)`): The normal source, which could be called the carrier too.
* `special` (`source(audio='#a,video='#b,midi=0)`): The special source.

#### source.dynamic
```
(?id:string,(()->[source('a)]))->source('a)```

WARNING: This is only EXPERIMENTAL!

Dynamically change the underlying source.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`()->[source('a)]`)

#### store_metadata
```
(?id:string,?size:int,source('a))->source('a)```

Keep track of the last N metadata packets in the stream, and make the history available via a server command.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `size` (`int` -- defaults to `10`): Size of the history
* `(unlabeled)` (`source('a)`)

#### strip_blank
```
(?id:string,?length:float,?threshold:float,
 ?track_sensitive:bool,
 source(audio='#a,video='#b,midi='#c))->
source(audio='#a,video='#b,midi='#c)```

Make the source unavailable when it is streaming blank.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `length` (`float` -- defaults to `20.`): Maximum silence length allowed, in seconds.
* `threshold` (`float` -- defaults to `-40.`): Power in decibels under which the stream is considered silent.
* `track_sensitive` (`bool` -- defaults to `true`): Reset blank counter at each track.
* `(unlabeled)` (`source(audio='#a,video='#b,midi='#c)`)

#### switch
```
(?id:string,?replay_metadata:bool,?single:[bool],
 ?track_sensitive:bool,
 ?transitions:[(source('a),source('a))->source('a)],
 [((()->bool)*source('a))])->source('a)```

At the beginning of a track, select the first source
whose predicate is true.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `replay_metadata` (`bool` -- defaults to `true`): Replay the last metadata of a child when switching to it in the middle of a track.
* `single` (`[bool]` -- defaults to `[]`): Forbid the selection of a branch for two tracks in a row. The empty list stands for `[false,...,false]`.
* `track_sensitive` (`bool` -- defaults to `true`): Re-select only on end of tracks.
* `transitions` (`[(source('a),source('a))->source('a)]` -- defaults to `[]`): Transition functions, padded with `fun (x,y) -> y` functions.
* `(unlabeled)` (`[((()->bool)*source('a))]`): Sources with the predicate telling when they can be played.

Source / Video Processing
-------------------------
#### video.add_image
```
(?id:string,?alpha:int,?duration:float,?file:string,
 ?height:int,?metadata:string,?width:int,?x:int,?y:int,
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Add a static image on the first video channel. The image can be changed based on metadata found at the beginning of a track.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `alpha` (`int` -- defaults to `-1`): Color to convert to alpha (in 0xRRGGBB format, negative means no alpha).
* `duration` (`float` -- defaults to `0.`)
* `file` (`string` -- defaults to `""`): Path to image file.
* `height` (`int` -- defaults to `-1`): Scale to width (negative means original height).
* `metadata` (`string` -- defaults to `""`): Metadata on which file name should be read (empty means disabled).
* `width` (`int` -- defaults to `-1`): Scale to width (negative means original width).
* `x` (`int` -- defaults to `0`): x position (negative means from right).
* `y` (`int` -- defaults to `0`): y position (negative means from bottom).
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

#### video.add_text.sdl
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
* `font` (`string` -- defaults to ```
"/usr/share/fonts/truetype/ttf-dejavu/DejaVuSans.ttf"```
): Path to ttf font file.
* `metadata` (`string` -- defaults to `""`): Change text on a particular metadata (empty string means disabled).
* `size` (`int` -- defaults to `18`): Font size.
* `speed` (`int` -- defaults to `70`): Speed in pixels per second (0 means no scrolling).
* `x` (`int` -- defaults to `-1`): x offset (negative means from right).
* `y` (`int` -- defaults to `-5`): y offset (negative means from bottom).
* `(unlabeled)` (```
anything that is either string or ()->string```
): Text to display.
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

#### video.add_text
```
(?id:string,?color:int,?cycle:bool,?font:string,
 ?metadata:string,?size:int,?speed:int,?x:int,?y:int,'a,
 source(audio='#b,video='#c+1,midi='#d))->
source(audio='#b,video='#c+1,midi='#d)
where 'a is either string or ()->string```

Add a scrolling line of text on video frames.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `color` (`int` -- defaults to `16777215`): Text color (in 0xRRGGBB format).
* `cycle` (`bool` -- defaults to `true`): Cycle text.
* `font` (`string` -- defaults to ```
"/usr/share/fonts/truetype/ttf-dejavu/DejaVuSans.ttf"```
): Path to ttf font file.
* `metadata` (`string` -- defaults to `""`): Change text on a particular metadata (empty string means disabled).
* `size` (`int` -- defaults to `18`): Font size.
* `speed` (`int` -- defaults to `70`): Speed in pixels per second (0 means no scrolling).
* `x` (`int` -- defaults to `-1`): x offset (negative means from right).
* `y` (`int` -- defaults to `-5`): y offset (negative means from bottom).
* `(unlabeled)` (```
anything that is either string or ()->string```
): Text to display.
* `(unlabeled)` (`source(audio='#b,video='#c+1,midi='#d)`)

#### video.fade.final
```
(?id:string,?duration:float,?transition:string,
 ?type:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Fade a stream to black.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (`float` -- defaults to `3.`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `transition` (`string` -- defaults to `"fade"`): Kind of transition (fade|slide_left|slide_right|slide_up|slide_down|grow|disc|random).
* `type` (`string` -- defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

#### video.fade.in
```
(?id:string,?duration:float,?override:string,
 ?transition:string,?type:string,
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Fade the beginning of tracks. Metadata 'liq_video_fade_in' can be used to set the duration for a specific track (float in seconds).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (`float` -- defaults to `3.`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `override` (`string` -- defaults to `"liq_video_fade_in"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
* `transition` (`string` -- defaults to `"fade"`): Kind of transition (fade|slide_left|slide_right|slide_up|slide_down|grow|disc|random).
* `type` (`string` -- defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

#### video.fade.initial
```
(?id:string,?duration:float,?transition:string,
 ?type:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Fade the beginning of a stream.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (`float` -- defaults to `3.`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `transition` (`string` -- defaults to `"fade"`): Kind of transition (fade|slide_left|slide_right|slide_up|slide_down|grow|disc|random).
* `type` (`string` -- defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

#### video.fade.out
```
(?id:string,?duration:float,?override:string,
 ?transition:string,?type:string,
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Fade the end of tracks. Metadata 'liq_video_fade_out' can be used to set the duration for a specific track (float in seconds).

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `duration` (`float` -- defaults to `3.`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `override` (`string` -- defaults to `"liq_video_fade_out"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
* `transition` (`string` -- defaults to `"fade"`): Kind of transition (fade|slide_left|slide_right|slide_up|slide_down|grow|disc|random).
* `type` (`string` -- defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

#### video.fill
```
(?id:string,?color:int,
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Fill frame with a color.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `color` (`int` -- defaults to `0`): Color to fill the image with.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

#### video.greyscale
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Convert video to greyscale.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

#### video.invert
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Invert video.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

#### video.lomo
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Emulate the ``Lomo effect''.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

#### video.opacity
```
(?id:string,float,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Scale opacity of video.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`float`): Coefficient to scale opacity with.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

#### video.opacity.blur
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Blur opacity of video.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

#### video.rotate
```
(?id:string,?angle:float,?speed:float,
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Rotate video.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `angle` (`float` -- defaults to `0.`): Initial angle in radians.
* `speed` (`float` -- defaults to `3.1416`): Rotation speed in radians per sec.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

#### video.scale
```
(?id:string,?coef:float,?coef_x:float,?coef_y:float,
 ?offset_x:int,?offset_y:int,
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Scale and translate video.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `coef` (`float` -- defaults to `1.`): Scaling coefficient in both directions.
* `coef_x` (`float` -- defaults to `1.`): x scaling
* `coef_y` (`float` -- defaults to `1.`): y scaling
* `offset_x` (`int` -- defaults to `1`): x offset
* `offset_y` (`int` -- defaults to `1`): y offset
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

#### video.sepia
```
(?id:string,source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Convert video to sepia.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

#### video.tile
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

#### video.transparent
```
(?id:string,?color:int,?precision:float,
 source(audio='#a,video='#b+1,midi='#c))->
source(audio='#a,video='#b+1,midi='#c)```

Set a color to be transparent.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `color` (`int` -- defaults to `0`): Color which should be transparent (in 0xRRGGBB format).
* `precision` (`float` -- defaults to `0.`): Precision in color matching (0. means match precisely the color and 1. means match every color).
* `(unlabeled)` (`source(audio='#a,video='#b+1,midi='#c)`)

Source / Visualization
----------------------
#### rms
```
(?id:string,source(audio='#a+1,video='#b,midi='#c))->
((()->float)*source(audio='#a+1,video='#b,midi='#c))```

Get current audio RMS volume of the source. Returns a pair `(f,s)` where s is a new source and `f` is a function of type `() -> float` and returns the current RMS of the source.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a+1,video='#b,midi='#c)`)

#### server.rms
```
(?id:string,source(audio='#a+1,video='#b,midi='#c))->
source(audio='#a+1,video='#b,midi='#c)```

Register a command that outputs the RMS of the returned source.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a+1,video='#b,midi='#c)`)

#### video.volume
```
(?id:string,source(audio='#a+1,video=0,midi=0))->
source(audio='#a+1,video=1,midi=0)```

Graphical visualization of the sound.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a+1,video=0,midi=0)`)

#### visu.volume
```
(?id:string,source(audio='#a+1,video=0,midi=0))->
source(audio='#a+1,video=0,midi=0)```

Graphical visualization of the volume.

* `id` (`string` -- defaults to `""`): Force the value of the source ID.
* `(unlabeled)` (`source(audio='#a+1,video=0,midi=0)`)

#### vumeter
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
#### !=
```
('a,'a)->bool where 'a is an orderable type```

Comparison of comparable values.

* `(unlabeled)` (`anything that is an orderable type`)
* `(unlabeled)` (`anything that is an orderable type`)

#### <
```
('a,'a)->bool where 'a is an orderable type```

Comparison of comparable values.

* `(unlabeled)` (`anything that is an orderable type`)
* `(unlabeled)` (`anything that is an orderable type`)

#### <=
```
('a,'a)->bool where 'a is an orderable type```

Comparison of comparable values.

* `(unlabeled)` (`anything that is an orderable type`)
* `(unlabeled)` (`anything that is an orderable type`)

#### ==
```
('a,'a)->bool where 'a is an orderable type```

Comparison of comparable values.

* `(unlabeled)` (`anything that is an orderable type`)
* `(unlabeled)` (`anything that is an orderable type`)

#### >
```
('a,'a)->bool where 'a is an orderable type```

Comparison of comparable values.

* `(unlabeled)` (`anything that is an orderable type`)
* `(unlabeled)` (`anything that is an orderable type`)

#### >=
```
('a,'a)->bool where 'a is an orderable type```

Comparison of comparable values.

* `(unlabeled)` (`anything that is an orderable type`)
* `(unlabeled)` (`anything that is an orderable type`)

#### and
```
(bool,bool)->bool```

Return the conjunction of its arguments

* `(unlabeled)` (`bool`)
* `(unlabeled)` (`bool`)

#### not
```
(bool)->bool```

Returns the negation of its argument.

* `(unlabeled)` (`bool`)

#### or
```
(bool,bool)->bool```

Return the disjunction of its arguments

* `(unlabeled)` (`bool`)
* `(unlabeled)` (`bool`)

#### random.bool
```
()->bool```

Generate a random value.

Control
-------
#### add_timeout
```
(?fast:bool,float,(()->float))->unit```

Call a function in N seconds. If the result of the function is positive or null, the task will be scheduled after this amount of time (in seconds.)

* `fast` (`bool` -- defaults to `true`): Set to `false` if the execution of the code can take long in order to lower its priority below that of request resolutions and fast timeouts. This is only effective if you set a dedicated queue for fast tasks, see the ``scheduler'' settings for more details.
* `(unlabeled)` (`float`)
* `(unlabeled)` (`()->float`)

#### ignore
```
('a)->unit```

Convert anything to unit, preventing warnings.

* `(unlabeled)` (`'a`)

Interaction
-----------
#### add_skip_command
```
(source('a))->unit```

Add a skip function to a source
when it does not have one
by default

* `(unlabeled)` (`source('a)`): The source to attach the command to.

#### audioscrobbler.nowplaying
```
(user:string,password:string,?host:string,?port:int,
 ?length:bool,[(string*string)])->unit```

Submit a now playing song using the audioscrobbler protocol.

* `user` (`string`)
* `password` (`string`)
* `host` (`string` -- defaults to `"post.audioscrobbler.com"`): Host for audioscrobbling submissions.
* `port` (`int` -- defaults to `80`): Port for audioscrobbling submissions.
* `length` (`bool` -- defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the ``user'' source type.
* `(unlabeled)` (`[(string*string)]`)

#### audioscrobbler.submit
```
(?source:string,user:string,password:string,?host:string,
 ?port:int,?length:bool,[(string*string)])->unit```

Submit a played song using the audioscrobbler protocol.

* `source` (`string` -- defaults to `"broadcast"`): Source for tracks. Should be one of: ``broadcast'', ``user'', ``recommendation'' or ``unknown''. Since liquidsoap is intented for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
* `user` (`string`)
* `password` (`string`)
* `host` (`string` -- defaults to `"post.audioscrobbler.com"`): Host for audioscrobbling submissions.
* `port` (`int` -- defaults to `80`): Port for audioscrobbling submissions.
* `length` (`bool` -- defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the ``user'' source type.
* `(unlabeled)` (`[(string*string)]`)

#### audioscrobbler.submit.full
```
(user:string,password:string,?host:string,?port:int,
 ?source:string,?length:bool,?delay:float,?force:bool,
 source('a))->source('a)```

Submit songs using audioscrobbler, respecting the full protocol:
First signal song as now playing when starting, and
then submit song when it ends.

* `user` (`string`)
* `password` (`string`)
* `host` (`string` -- defaults to `"post.audioscrobbler.com"`)
* `port` (`int` -- defaults to `80`)
* `source` (`string` -- defaults to `"broadcast"`): Source for tracks. Should be one of: ``broadcast'', ``user'', ``recommendation'' or ``unknown''. Since liquidsoap is intented for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
* `length` (`bool` -- defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the ``user'' source type.
* `delay` (`float` -- defaults to `10.`): Submit song when there is only this delay left, in seconds. 
* `force` (`bool` -- defaults to `false`): If remaining time is null, the song will be assumed to be skipped or cuted, and not submitted. Set to zero to disable this behaviour.
* `(unlabeled)` (`source('a)`)

#### http.get
```
(?headers:[(string*string)],?timeout:float,string)->
((((string*int)*string)*[(string*string)])*string)```

Perform a full Http GET request and return (status,headers),data.

* `headers` (`[(string*string)]` -- defaults to `[]`): Additional headers.
* `timeout` (`float` -- defaults to `10.`): Timeout for network operations.
* `(unlabeled)` (`string`): Requested URL, e.g. ``http://www.google.com:80/index.html''.

#### http.post
```
(?data:string,?headers:[(string*string)],?timeout:float,
 string)->
((((string*int)*string)*[(string*string)])*string)```

Perform a full Http POST request and return (status,headers),data.

* `data` (`string` -- defaults to `""`): Http POST data.
* `headers` (`[(string*string)]` -- defaults to `[]`): Additional headers.
* `timeout` (`float` -- defaults to `10.`): Timeout for network operations.
* `(unlabeled)` (`string`): Requested URL, e.g. ``http://www.google.com:80/index.html''.

#### http_codes
```
[(string*string)]```

List of HTTP response codes and statuses.

#### http_response
```
(?protocol:string,?code:int,?headers:[(string*string)],
 ?data:string)->string```

Create a HTTP response string

* `protocol` (`string` -- defaults to `"HTTP/1.1"`): HTTP protocol used.
* `code` (`int` -- defaults to `200`): Response code.
* `headers` (`[(string*string)]` -- defaults to `[]`): Response headers.
* `data` (`string` -- defaults to `""`): Response data

#### icy.update_metadata
```
(?host:string,?port:int,?user:string,?password:string,
 mount:string,?protocol:string,?encoding:string,
 ?headers:[(string*string)],[(string*string)])->unit```

Update metata on an icecast mountpoint using the ICY protocol.

* `host` (`string` -- defaults to `"localhost"`)
* `port` (`int` -- defaults to `8000`)
* `user` (`string` -- defaults to `"source"`)
* `password` (`string` -- defaults to `"hackme"`)
* `mount` (`string`)
* `protocol` (`string` -- defaults to `"http"`): Protocol to use. One of: ``icy'' or ``http''
* `encoding` (`string` -- defaults to `""`): Encoding used to send metadata, default (UTF-8) if empty.
* `headers` (`[(string*string)]` -- defaults to ```
[("User-Agent","Liquidsoap/1.0.0 (Unix; OCaml 3.12.0)")]```
): Additional headers.
* `(unlabeled)` (`[(string*string)]`)

#### interactive.float
```
(string,float)->()->float```

Read a float from an interactive input.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`float`)

#### interactive.string
```
(string,string)->()->string```

Read a string from an interactive input.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`string`)

#### lastfm.nowplaying
```
(user:string,password:string,?length:bool,
 [(string*string)])->unit```

Submit metadata to lastfm.fm using the audioscrobbler protocol (nowplaying mode).

* `user` (`string`)
* `password` (`string`)
* `length` (`bool` -- defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the ``user'' source type.
* `(unlabeled)` (`[(string*string)]`)

#### lastfm.submit
```
(user:string,password:string,?source:string,?length:bool,
 [(string*string)])->unit```

Submit metadata to lastfm.fm using the audioscrobbler protocol.

* `user` (`string`)
* `password` (`string`)
* `source` (`string` -- defaults to `"broadcast"`): Source for tracks. Should be one of: ``broadcast'', ``user'', ``recommendation'' or ``unknown''. Since liquidsoap is intented for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
* `length` (`bool` -- defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the ``user'' source type.
* `(unlabeled)` (`[(string*string)]`)

#### lastfm.submit.full
```
(user:string,password:string,?source:string,?length:bool,
 ?delay:float,?force:bool,source('a))->source('a)```

Submit songs to lastfm using audioscrobbler, respecting the full protocol:
First signal song as now playing when starting, and
then submit song when it ends.

* `user` (`string`)
* `password` (`string`)
* `source` (`string` -- defaults to `"broadcast"`): Source for tracks. Should be one of: ``broadcast'', ``user'', ``recommendation'' or ``unknown''. Since liquidsoap is intented for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
* `length` (`bool` -- defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the ``user'' source type.
* `delay` (`float` -- defaults to `10.`): Submit song when there is only this delay left, in seconds. If remaining time is less than this value, the song will be assumed to be skipped or cuted, and not submitted. Set to zero to disable this behaviour.
* `force` (`bool` -- defaults to `false`): If remaining time is null, the song will be assumed to be skipped or cuted, and not submitted. Set to zero to disable this behaviour.
* `(unlabeled)` (`source('a)`)

#### librefm.nowplaying
```
(user:string,password:string,?length:bool,
 [(string*string)])->unit```

Submit metadata to libre.fm using the audioscrobbler protocol (nowplaying mode).

* `user` (`string`)
* `password` (`string`)
* `length` (`bool` -- defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the ``user'' source type.
* `(unlabeled)` (`[(string*string)]`)

#### librefm.submit
```
(user:string,password:string,?source:string,?length:bool,
 [(string*string)])->unit```

Submit metadata to libre.fm using the audioscrobbler protocol.

* `user` (`string`)
* `password` (`string`)
* `source` (`string` -- defaults to `"broadcast"`): Source for tracks. Should be one of: ``broadcast'', ``user'', ``recommendation'' or ``unknown''. Since liquidsoap is intented for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
* `length` (`bool` -- defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the ``user'' source type.
* `(unlabeled)` (`[(string*string)]`)

#### librefm.submit.full
```
(user:string,password:string,?source:string,?length:bool,
 ?delay:float,?force:bool,source('a))->source('a)```

Submit songs to librefm using audioscrobbler, respecting the full protocol:
First signal song as now playing when starting, and
then submit song when it ends.

* `user` (`string`)
* `password` (`string`)
* `source` (`string` -- defaults to `"broadcast"`): Source for tracks. Should be one of: ``broadcast'', ``user'', ``recommendation'' or ``unknown''. Since liquidsoap is intented for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
* `length` (`bool` -- defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the ``user'' source type.
* `delay` (`float` -- defaults to `10.`): Submit song when there is only this delay left, in seconds. If remaining time is less than this value, the song will be assumed to be skipped or cuted, and not submitted. Set to zero to disable this behaviour.
* `force` (`bool` -- defaults to `false`): If remaining time is null, the song will be assumed to be skipped or cuted, and not submitted. Set to zero to disable this behaviour.
* `(unlabeled)` (`source('a)`)

#### osc.bool
```
(string,bool)->()->bool```

Read a boolean from an OSC path.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`bool`)

#### osc.float
```
(string,float)->()->float```

Read a float from an OSC path.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`float`)

#### osc.float_pair
```
(string,(float*float))->()->(float*float)```

Read a float from an OSC path.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`(float*float)`)

#### print
```
(?newline:bool,'a)->unit```

Print on standard output.

* `newline` (`bool` -- defaults to `true`): If true, a newline is added after displaying the value.
* `(unlabeled)` (`'a`)

Liquidsoap
----------
#### add_decoder
```
(name:string,description:string,test:((string)->int),
 string)->unit```

Register an external file decoder. The encoder should output in WAV format to his standard output (stdout) and read data from its standard input (stdin).

* `name` (`string`): Format/decoder's name.
* `description` (`string`): Description of the decoder.
* `test` (`(string)->int`): Function used to determine if the file should be decoded by the decoder. Returned values are: 0: no decodable audio, -1: decodable audio but number of audio channels unknown, x: fixed number of decodable audio channels.
* `(unlabeled)` (`string`): Process to start.

#### add_metadata_resolver
```
(string,((string)->[(string*string)]))->unit```

Register an external file metadata decoder.

* `(unlabeled)` (`string`): Format/resolver's name.
* `(unlabeled)` (`(string)->[(string*string)]`): Process to start. The function takes the format and filename as argument and returns a list of (name,value) fields.

#### add_oblivious_decoder
```
(name:string,description:string,test:((string)->int),
 ?buffer:float,((string)->string))->unit```

Register an external file decoder. The encoder should output in WAV format to his standard output (stdout) and read data from the file it receives. The estimated remaining duration for this decoder will be unknown until the `buffer` last seconds of the file. If possible, it is recommended to decode from stdin and use `add_decoder`.

* `name` (`string`): Format/decoder's name.
* `description` (`string`): Description of the decoder.
* `test` (`(string)->int`): Function used to determine if the file should be decoded by the decoder. Returned values are: 0: no decodable audio, -1: decodable audio but number of audio channels unknown, x: fixed number of decodable audio channels.
* `buffer` (`float` -- defaults to `5.`)
* `(unlabeled)` (`(string)->string`): Process to start. The function takes the filename as argument and returns the process to start.

#### add_protocol
```
(?temporary:bool,string,((string,float)->[string]))->unit```

Register a new protocol.

* `temporary` (`bool` -- defaults to `false`): if true, file removed when it is finished.
* `(unlabeled)` (`string`)
* `(unlabeled)` (`(string,float)->[string]`)

#### clock
```
(?sync:bool,?id:string,source('a))->source('a)```

Assign a new clock to the given source (and to other time-dependent
sources) and return the source. It is a conveniency wrapper around
clock.assign_new(), allowing more concise scripts in some cases.

* `sync` (`bool` -- defaults to `true`): Do not synchronize the clock on regular wallclock time, but try to run as fast as possible (CPU burning mode).
* `id` (`string` -- defaults to `""`)
* `(unlabeled)` (`source('a)`)

#### clock.assign_new
```
(?id:string,?sync:bool,[source('a)])->unit```

Create a new clock and assign it to a list of sources.

* `id` (`string` -- defaults to `""`): Identifier for the new clock. The default empty string means that the identifier of the first source will be used.
* `sync` (`bool` -- defaults to `true`): Do not synchronize the clock on regular wallclock time, but try to run as fast as possible (CPU burning mode).
* `(unlabeled)` (`[source('a)]`): List of sources to which the new clock will be assigned

#### configure.default_font
```
string```

Liquidsoap's default font file.

#### configure.libdir
```
string```

Liquidsoap's library directory.

#### configure.logdir
```
string```

Liquidsoap's logging directory.

#### configure.rundir
```
string```

Liquidsoap's PID file directory.

#### enable_external_faad_decoder
```
()->unit```

Enable or disable external FAAD (AAC/AAC+/M4A) decoders. 
Requires faad binary in the path for audio decoding and 
metaflac binary for metadata. Does not work on Win32.
Please note that built-in support for faad is available
in liquidsoap if compiled and should be preferred over
the external decoder.

#### enable_external_flac_decoder
```
()->unit```

Enable external FLAC decoders. Requires flac binary
in the path for audio decoding and metaflac binary for 
metadata. Does not work on Win32. Default: disabled.
Please note that built-in support for FLAC is available
in liquidsoap if compiled and should be preferred over
the external decoder.

#### enable_external_mpc_decoder
```
()->unit```

Enable external Musepack decoder. Requires the
mpcdec binary in the path. Does not work on
Win32.

#### enable_replaygain_metadata
```
(?extract_replaygain:string)->unit```

Enable replay gain metadata resolver. This resolver will
process any file decoded by liquidsoap and add a replay_gain
metadata when this value could be computed. For a finer-grained
replay gain processing, use the replay_gain protocol.

* `extract_replaygain` (`string` -- defaults to ```
"/usr/local/lib/liquidsoap/1.0.0/extract-replaygain"```
): The extraction program

#### file.duration
```
(string)->float```

Compute the duration in seconds of audio data contained in a file. The computation may be expensive. Returns -1. if computation failed, typically if the file was not recognized as valid audio.

* `(unlabeled)` (`string`)

#### file.mime
```
(string)->string```

Get the MIME type of a file, according to libmagic.

* `(unlabeled)` (`string`)

#### garbage_collect
```
()->unit```

Trigger full major garbage collection.

#### get
```
(default:'a,string)->'a
where 'a is bool, int, float, string or [string]```

Get a setting's value.

* `default` (```
anything that is bool, int, float, string or [string]```
)
* `(unlabeled)` (`string`)

#### get_clock_status
```
()->[(string*int)]```

Get the current time for all allocated clocks.

#### harbor.http.register
```
(port:int,string,
 ((method:string,protocol:string,data:string,
   headers:[(string*string)],string)->string))->unit```

Register a HTTP handler on the harbor. The given function receives as argument the full requested uri (e.g. ``foo?var=bar''), method type, http protocol version, possible input data and the list of HTTP headers and returns the answer sent to the client, including HTTP headers. Registered uri can be regular expressions (e.g. ``.+\.php'') and can override default metadata handlers.

* `port` (`int`): Port to server.
* `(unlabeled)` (`string`): URI to serve.
* `(unlabeled)` (```
(method:string,protocol:string,data:string,
 headers:[(string*string)],string)->string```
): Function to execute. method argument is ``PUT'' or ``GET'', protocol argument is ``HTTP/1.1'' or ``HTTP/1.0'' etc., data argument contains data passed in case of a PUT request, and ``'' otherwise. headers argument contains the HTTP headers. Unlabeled argument contains the requested URI.

#### harbor.http.remove
```
(port:int,string)->unit```

Remove a registered HTTP handler on the harbor.

* `port` (`int`): Port to server.
* `(unlabeled)` (`string`): URI to serve.

#### liquidsoap.version
```
string```

Liquidsoap version string.

#### log
```
(?label:string,?level:int,string)->unit```

Log a message.

* `label` (`string` -- defaults to `"lang"`)
* `level` (`int` -- defaults to `3`)
* `(unlabeled)` (`string`)

#### log_clocks
```
(?delay:float,?interval:float,string)->unit```

Create a log of clock times for all the clocks initially present.
The log is in a simple format which you can directly use with gnuplot.

* `delay` (`float` -- defaults to `0.`): Delay before setting up the clock logger. This should be used to ensure that the logger starts only after the clocks are created.
* `interval` (`float` -- defaults to `1.`): Polling interval.
* `(unlabeled)` (`string`): Path of the log file.

#### metadata.export
```
([(string*string)])->[(string*string)]```

Filter-out internal metadata.

* `(unlabeled)` (`[(string*string)]`)

#### playlist.parse
```
(string)->[([(string*string)]*string)]```

Try to parse a local playlist. Return a list of (metadata,URI) items, where metadata is a list of (key,value) bindings.

* `(unlabeled)` (`string`)

#### register_flow
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

#### replaygain_protocol
```
(string,'a)->[string]```

Register the replaygain protocol.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`'a`)

#### request.create
```
(?indicators:[string],?persistent:bool,string)->
request('a)```

Create a request. Creation may fail if there is no available RID, which cannot be detected currently: in that case one will obtain a request that will fail to be resolved.

* `indicators` (`[string]` -- defaults to `[]`)
* `persistent` (`bool` -- defaults to `false`)
* `(unlabeled)` (`string`)

#### request.create.raw
```
(?indicators:[string],?persistent:bool,string)->
request(audio=0,video=0,midi=0)```

Create a raw request, i.e. for files that should not be decoded for streaming. Creation may fail if there is no available RID, which cannot be detected currently: in that case one will obtain a request that will fail to be resolved.

* `indicators` (`[string]` -- defaults to `[]`)
* `persistent` (`bool` -- defaults to `false`)
* `(unlabeled)` (`string`)

#### request.destroy
```
(?force:bool,request('a))->unit```

Destroying a request causes any temporary associated file to be deleted, and releases its RID. Persistent requests resist to destroying, unless forced.

* `force` (`bool` -- defaults to `false`): Destroy the request even if it is persistent.
* `(unlabeled)` (`request('a)`)

#### request.filename
```
(request('a))->string```

Return a valid local filename if the request is ready, and the empty string otherwise.

* `(unlabeled)` (`request('a)`)

#### request.metadata
```
(request('a))->[(string*string)]```

Get the metadata associated to a request.

* `(unlabeled)` (`request('a)`)

#### request.ready
```
(request('a))->bool```

Check if a request is ready, i.e. is associated to a valid local file. Unless the initial URI was such a file, a request has to be resolved before being ready.

* `(unlabeled)` (`request('a)`)

#### request.resolve
```
(?timeout:float,request('a))->bool```

Resolve a request, i.e. attempt to get a valid local file. The operation can take some time. Return true if the resolving was successful, false otherwise (timeout or invalid URI).

* `timeout` (`float` -- defaults to `30.`): Limit in seconds to the duration of the resolving.
* `(unlabeled)` (`request('a)`)

#### server.execute
```
(string,?string)->[string]```

Execute a liquidsoap server command.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`string` -- defaults to `""`)

#### set
```
(string,'a)->unit
where 'a is bool, int, float, string or [string]```

Change some setting. Use `liquidsoap --conf-descr` and `liquidsoap --conf-descr-key KEY` on the command-line to get some information about available settings.

* `(unlabeled)` (`string`)
* `(unlabeled)` (```
anything that is bool, int, float, string or [string]```
)

#### source.id
```
(source('a))->string```

Get one source's identifier.

* `(unlabeled)` (`source('a)`)

#### source.init
```
([source(audio=*,video=*,midi=*)])->
[source(audio=*,video=*,midi=*)]```

Simultaneously initialize sources, return the sublist of sources that failed to initialized.

* `(unlabeled)` (`[source(audio=*,video=*,midi=*)]`)

#### source.is_ready
```
(source('a))->bool```

Indicate if a source is ready to stream, or currently streaming.

* `(unlabeled)` (`source('a)`)

#### source.remaining
```
(source('a))->float```

Estimation of remaining time in the current track.

* `(unlabeled)` (`source('a)`)

#### source.seek
```
(source('a),float)->float```

Seek forward, in seconds. Returns the amount of time effectively seeked.

* `(unlabeled)` (`source('a)`)
* `(unlabeled)` (`float`)

#### source.shutdown
```
(source('a))->unit```

Desactivate a source.

* `(unlabeled)` (`source('a)`)

#### source.skip
```
(source('a))->unit```

Skip to the next track.

* `(unlabeled)` (`source('a)`)

List
----
#### _[_]
```
(string,[(string*string)])->string```

l[k] returns the first v such that (k,v) is in the list l.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`[(string*string)]`)

#### fst
```
(('a*'b))->'a```

Get the first component of a pair.

* `(unlabeled)` (`('a*'b)`)

#### list.append
```
(['a],['a])->['a]```

Catenate two lists.

* `(unlabeled)` (`['a]`)
* `(unlabeled)` (`['a]`)

#### list.assoc
```
(string,[(string*string)])->string```

Alias for the `l[k]` notation.

* `(unlabeled)` (`string`): Key to look for
* `(unlabeled)` (`[(string*string)]`): List of pairs (key,value)

#### list.fold
```
((('a,'b)->'a),'a,['b])->'a```

Fold a function on every element of a list: list.fold(f,x1,[e1,..,en]) is f(...f(f(x1,e1),e2)...,en).

* `(unlabeled)` (`('a,'b)->'a`): Function f for which f(x,e) which will be called on every element e with the current value of x, returning the new value of x.
* `(unlabeled)` (`'a`): Initial value x1, to be updated by successive calls of f(x,e).
* `(unlabeled)` (`['b]`)

#### list.hd
```
([string])->string```

Return the head (first element) of a list, or ``'' if the list is empty.

* `(unlabeled)` (`[string]`)

#### list.iter
```
((('a)->unit),['a])->unit```

Call a function on every element of a list.

* `(unlabeled)` (`('a)->unit`)
* `(unlabeled)` (`['a]`)

#### list.length
```
(['a])->int```

Get the length of a list, i.e. its number of elements.

* `(unlabeled)` (`['a]`)

#### list.map
```
((('a)->'b),['a])->['b]```

Map a function on every element of a list.

* `(unlabeled)` (`('a)->'b`)
* `(unlabeled)` (`['a]`)

#### list.mem
```
('a,['a])->bool where 'a is an orderable type```

Check if an element belongs to a list.

* `(unlabeled)` (`anything that is an orderable type`)
* `(unlabeled)` (`['a] where 'a is an orderable type`)

#### list.mem_assoc
```
(string,[(string*string)])->bool```

list.mem_assoc(key,l) returns true if l contains a pair
(key,value)

* `(unlabeled)` (`string`): Key to look for
* `(unlabeled)` (`[(string*string)]`): List of pairs (key,value)

#### list.nth
```
(['a],int)->'a```

Get the n-th element of a list (the first element is at position 0).

* `(unlabeled)` (`['a]`)
* `(unlabeled)` (`int`)

#### list.remove
```
('a,['a])->['a]```

Remove a value from a list.

* `(unlabeled)` (`'a`)
* `(unlabeled)` (`['a]`)

#### list.remove_assoc
```
(string,[(string*string)])->[(string*string)]```

Remove a pair from an associative list

* `(unlabeled)` (`string`): Key of pair to be removed
* `(unlabeled)` (`[(string*string)]`): List of pairs (key,value)

#### list.rev
```
(['a])->['a]```

Revert list order.

* `(unlabeled)` (`['a]`)

#### list.sort
```
((('a,'a)->int),['a])->['a]```

Sort a list according to a comparison function.

* `(unlabeled)` (`('a,'a)->int`)
* `(unlabeled)` (`['a]`)

#### list.tl
```
(['a])->['a]```

Return the list without its first element.

* `(unlabeled)` (`['a]`)

#### snd
```
(('a*'b))->'b```

Get the second component of a pair.

* `(unlabeled)` (`('a*'b)`)

Math
----
#### *
```
('a,'a)->'a where 'a is a number type```

Multiplication of numbers.

* `(unlabeled)` (`anything that is a number type`)
* `(unlabeled)` (`anything that is a number type`)

#### +
```
('a,'a)->'a where 'a is a number type```

Addition of numbers.

* `(unlabeled)` (`anything that is a number type`)
* `(unlabeled)` (`anything that is a number type`)

#### -
```
('a,'a)->'a where 'a is a number type```

Substraction of numbers.

* `(unlabeled)` (`anything that is a number type`)
* `(unlabeled)` (`anything that is a number type`)

#### /
```
('a,'a)->'a where 'a is a number type```

Division of numbers.

* `(unlabeled)` (`anything that is a number type`)
* `(unlabeled)` (`anything that is a number type`)

#### abs
```
('a)->'a where 'a is a number type```

Absolute value.

* `(unlabeled)` (`anything that is a number type`)

#### bool_of_float
```
(float)->bool```

Convert a float to a bool.

* `(unlabeled)` (`float`)

#### bool_of_int
```
(int)->bool```

Convert an int to a bool.

* `(unlabeled)` (`int`)

#### dB_of_lin
```
(float)->float```

Convert linear scale into decibels.

* `(unlabeled)` (`float`)

#### float_of_int
```
(int)->float```

Convert an int to a float.

* `(unlabeled)` (`int`)

#### int_of_float
```
(float)->int```

Convert a float to a int.

* `(unlabeled)` (`float`)

#### lin_of_dB
```
(float)->float```

Convert decibels into linear scale.

* `(unlabeled)` (`float`)

#### mod
```
(int,int)->int```

Integer remainder. If y is not zero, x == (x / y) * y + x mod y, and abs(x mod y) <= abs(y)-1.

* `(unlabeled)` (`int`)
* `(unlabeled)` (`int`)

#### pow
```
('a,'a)->'a where 'a is a number type```

Exponentiation of numbers.

* `(unlabeled)` (`anything that is a number type`)
* `(unlabeled)` (`anything that is a number type`)

#### random.float
```
(?min:float,?max:float)->float```

Generate a random value.

* `min` (`float` -- defaults to `-1000000.`)
* `max` (`float` -- defaults to `1000000.`)

#### ~-
```
('a)->'a where 'a is a number type```

Returns the opposite of its argument.

* `(unlabeled)` (`anything that is a number type`)

String
------
#### %
```
(string,[(string*string)])->string```

`pattern % [...,(k,v),...]` changes in the pattern occurences of:
- `$(k)` into `v`;
- `$(if $(k2),"a","b")` into ``a'' if k2 is found in the list, ``b'' otherwise.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`[(string*string)]`)

#### ^
```
(string,string)->string```

Concatenate strings.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`string`)

#### base64.decode
```
(string)->string```

Decode a Base64 encoded string.

* `(unlabeled)` (`string`)

#### base64.encode
```
(string)->string```

Encode a string in Base64.

* `(unlabeled)` (`string`)

#### bool_of_string
```
(?default:bool,string)->bool```

Convert a string to a bool.

* `default` (`bool` -- defaults to `false`)
* `(unlabeled)` (`string`)

#### float_of_string
```
(?default:float,string)->float```

Convert a string to a float.

* `default` (`float` -- defaults to `0.`)
* `(unlabeled)` (`string`)

#### int_of_string
```
(?default:int,string)->int```

Convert a string to a int.

* `default` (`int` -- defaults to `0`)
* `(unlabeled)` (`string`)

#### json_of
```
(?compact:bool,'a)->string```

Convert a value to a json string.

* `compact` (`bool` -- defaults to `false`): Output compact text.
* `(unlabeled)` (`'a`)

#### lastfm.uri
```
(?user:string,?password:string,?discovery:bool,?string)->
string```

Utility to compose last.fm URIs.

* `user` (`string` -- defaults to `""`): Lastfm user
* `password` (`string` -- defaults to `""`): Lastfm password
* `discovery` (`bool` -- defaults to `false`): Allow lastfm suggestions
* `(unlabeled)` (`string` -- defaults to `"globaltags/creative-commons"`): URI, e.g. user/toots5446/playlist, globaltags/rocksteady.

#### of_json
```
(default:'a,string)->'a```

Parse a json string into a liquidsoap value.

* `default` (`'a`): Default value if string cannot be parsed.
* `(unlabeled)` (`string`)

#### quote
```
(string)->string```

Escape shell metacharacters.

* `(unlabeled)` (`string`)

#### string.capitalize
```
(?capitalize:bool,?space_sensitive:bool,string)->string```

Return a string with the first character set to upper case (capitalize), or to lower case (uncapitalize).

* `capitalize` (`bool` -- defaults to `true`): Capitalize if true, uncapitalize otherwise
* `space_sensitive` (`bool` -- defaults to `true`): Capitalize each space separated sub-string.
* `(unlabeled)` (`string`)

#### string.case
```
(?lower:bool,string)->string```

Convert a string to lower or upper case.

* `lower` (`bool` -- defaults to `true`): Convert to lower case if true and uppercase otherwise.
* `(unlabeled)` (`string`)

#### string.concat
```
(?separator:string,[string])->string```

Concatenate strings.

* `separator` (`string` -- defaults to `""`)
* `(unlabeled)` (`[string]`)

#### string.escape
```
(?special_chars:[string],?escape_char:((string)->string),
 string)->string```

Escape special charaters in a string. String is parsed char by char. See `string.utf8.escape` for an UTF8-aware parsing function.

* `special_chars` (`[string]` -- defaults to ```
["\127", "\\", "\"", "\000", "\001", "\002", "\003", "\004", "\005", "\006", "\007", "\b", "\t", "\n", "\011", "\012", "\r", "\014", "\015", "\016", "\017", "\018", "\019", "\020", "\021", "\022", "\023", "\024", "\025", "\026", "\027", "\028", "\029", "\030", "\031"]```
): List of characters that should be escaped. The first character of each element in the list is considered.
* `escape_char` (`(string)->string` -- defaults to <code><fun></code>): Function used to escape a character.
* `(unlabeled)` (`string`)

#### string.extract
```
(pattern:string,string)->[(string*string)]```

Extract substrings from a string. 
Perl compatible regular expressions are recognized. Hence, special characters should be escaped. 
Returns a list of (index,value).
If the list does not have a pair associated to some index, it means that the corresponding pattern was not found.

* `pattern` (`string`)
* `(unlabeled)` (`string`)

#### string.length
```
(string)->int```

Get the length of a string.

* `(unlabeled)` (`string`)

#### string.match
```
(pattern:string,string)->bool```

Match a string with an expression. 
Perl compatible regular expressions are recognized. Hence, special characters should be escaped.

* `pattern` (`string`)
* `(unlabeled)` (`string`)

#### string.recode
```
(?in_enc:string,?out_enc:string,string)->string```

Convert a string. Effective only if Camomile is enabled.

* `in_enc` (`string` -- defaults to `""`): Input encoding. Autodetected if empty.
* `out_enc` (`string` -- defaults to `"UTF-8"`): Output encoding.
* `(unlabeled)` (`string`)

#### string.replace
```
(pattern:string,((string)->string),string)->string```

Replace substrings in a string. 
Will replace all substrings matched in the pattern by the string returned by the replace function.

* `pattern` (`string`)
* `(unlabeled)` (`(string)->string`)
* `(unlabeled)` (`string`)

#### string.split
```
(separator:string,string)->[string]```

Split a string at 'separator'. 
Perl compatible regular expressions are recognized. Hence, special characters should be escaped.

* `separator` (`string`)
* `(unlabeled)` (`string`)

#### string.utf8.escape
```
(?special_chars:[string],?escape_char:((string)->string),
 string)->string```

Escape special charaters in an UTF8 string.

* `special_chars` (`[string]` -- defaults to ```
["\127", "\\", "\"", "\000", "\001", "\002", "\003", "\004", "\005", "\006", "\007", "\b", "\t", "\n", "\011", "\012", "\r", "\014", "\015", "\016", "\017", "\018", "\019", "\020", "\021", "\022", "\023", "\024", "\025", "\026", "\027", "\028", "\029", "\030", "\031"]```
): List of characters that should be escaped. The first character of each element in the list is considered.
* `escape_char` (`(string)->string` -- defaults to <code><fun></code>): Function used to escape a character.
* `(unlabeled)` (`string`)

#### string_of
```
('a)->string```

Return the representation of a value.

* `(unlabeled)` (`'a`)

#### string_of_metadata
```
([(string*string)])->string```

Standard function for displaying metadata.
Shows artist and title, using ``Unknown'' when a field is empty.

* `(unlabeled)` (`[(string*string)]`): Metadata packet to be displayed.

#### url.decode
```
(?plus:bool,string)->string```

Decode an encoded url (e.g. ``%20'' becomes `` '').

* `plus` (`bool` -- defaults to `true`)
* `(unlabeled)` (`string`)

#### url.encode
```
(?plus:bool,string)->string```

Encode an url (e.g. `` '' becomes ``%20'').

* `plus` (`bool` -- defaults to `true`)
* `(unlabeled)` (`string`)

#### url.split
```
(string)->(string*[(string*string)])```

Split an url of the form foo?arg=bar&arg2=bar2
into (``foo'',[(``arg'',``bar''),(``arg2'',``bar2'')]).

* `(unlabeled)` (`string`): Url to split

System
------
#### argv
```
(?default:string,int)->string```

Get command-line parameters.

* `default` (`string` -- defaults to `""`)
* `(unlabeled)` (`int`)

#### basename
```
(string)->string```

Get the base name of a path.

* `(unlabeled)` (`string`)

#### dirname
```
(string)->string```

Get the directory name of a path.

* `(unlabeled)` (`string`)

#### exec_at
```
(?freq:float,pred:(()->bool),(()->unit))->unit```

Execute a given action when a predicate is true.
This will be run in background.

* `freq` (`float` -- defaults to `1.`): Frequency for checking the predicate, in seconds.
* `pred` (`()->bool`): Predicate indicating when to execute the function, typically a time interval such as `{10h-10h30}`.
* `(unlabeled)` (`()->unit`): Function to execute when the predicate is true.

#### file.exists
```
(string)->bool```

Returns true if the file or directory exists.

* `(unlabeled)` (`string`)

#### file.mime_default
```
(string)->string```

Alias of file.mime (because it is available)

* `(unlabeled)` (`string`)

#### get_mime
```
(string)->string```

Generic mime test. First try to use file.mime if it exist.
Otherwise try to get the value using the file binary.
Returns ``'' (empty string) if no value can be find.

* `(unlabeled)` (`string`): The file to test

#### get_process_lines
```
(string)->[string]```

Perform a shell call and return the list of its output lines.

* `(unlabeled)` (`string`)

#### get_process_output
```
(string)->string```

Perform a shell call and return its output.

* `(unlabeled)` (`string`)

#### getopt
```
(?default:string,string)->string```

Parse command line options:
`getopt("-o")` returns ``1'' if ``-o'' was passed without any parameter, ``0'' otherwise.
`getopt(default="X","-o")` returns ``Y'' if ``-o Y'' was passed, ``X'' otherwise.
The result is removed from the list of arguments, affecting subsequent
calls to `argv()` and `getopt()`.

* `default` (`string` -- defaults to `""`)
* `(unlabeled)` (`string`)

#### getpid
```
()->int```

Get the process' pid.

#### gettimeofday
```
()->float```

Return the current time since 00:00:00 GMT, Jan. 1, 1970, in seconds.

#### is_directory
```
(string)->bool```

Returns true if the directory exists.

* `(unlabeled)` (`string`)

#### on_shutdown
```
((()->unit))->unit```

Register a function to be called when Liquidsoap shuts down.

* `(unlabeled)` (`()->unit`)

#### os.type
```
string```

Type of OS running liquidsoap.

#### path.concat
```
(string,string)->string```

Concatenate two paths, using the appropriate directory separator.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`string`)

#### read
```
(?hide:bool)->string```

Read some value from standard input (console).

* `hide` (`bool` -- defaults to `false`): Hide typed characters (for passwords).

#### reopen.stderr
```
(string)->unit```

Reopen standard error on the given file

* `(unlabeled)` (`string`)

#### reopen.stdin
```
(string)->unit```

Reopen standard input on the given file

* `(unlabeled)` (`string`)

#### reopen.stdout
```
(string)->unit```

Reopen standard output on the given file

* `(unlabeled)` (`string`)

#### server.register
```
(?namespace:string,?description:string,?usage:string,
 string,((string)->string))->unit```

Register a command. You can then execute this function through the server, either telnet or socket.

* `namespace` (`string` -- defaults to `""`)
* `description` (`string` -- defaults to `"No documentation available."`): A description of your command.
* `usage` (`string` -- defaults to `""`)
* `(unlabeled)` (`string`)
* `(unlabeled)` (`(string)->string`)

#### shutdown
```
()->unit```

Shutdown the application.

#### system
```
(string)->unit```

Shell command call. Set verbose to true to log process' output and errors.

* `(unlabeled)` (`string`)

#### test_process
```
(string)->bool```

Return true if process exited with 0 code.
Command should return quickly.

* `(unlabeled)` (`string`): Command to test


