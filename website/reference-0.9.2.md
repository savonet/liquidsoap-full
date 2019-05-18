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

* [Source / Input](#SourceInput)
* [Source / MIDI Processing](#SourceMIDIProcessing)
* [Source / Output](#SourceOutput)
* [Source / Sound Processing](#SourceSoundProcessing)
* [Source / Sound Synthesis](#SourceSoundSynthesis)
* [Source / Track Processing](#SourceTrackProcessing)
* [Source / Video Processing](#SourceVideoProcessing)
* [Source / Visualization](#SourceVisualization)
* [Bool](#Bool)
* [Control](#Control)
* [Deprecated](#Deprecated)
* [Interaction](#Interaction)
* [Liquidsoap](#Liquidsoap)
* [List](#List)
* [Math](#Math)
* [String](#String)
* [System](#System)
* [Uncategorized](#Uncategorized)

Source / Input
--------------
#### blank
```
(?id:string, ?duration:float)->source```

Produce silence.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `duration` (`float` -- defaults to `0.`): Duration of blank tracks in seconds, default means forever.

#### dolebrai
```
()->source```

Relay the audio stream of Dolebraï, a libre music netradio running liquidsoap.

#### fail
```
()->source```

Creates a source that fails to produce anything.

#### in
```
()->source```

Create a source from the first available input driver in this list:
portaudio, alsa, oss, blank

#### input.alsa
```
(?id:string, ?bufferize:bool, ?device:string)
 ->source```

Stream from an ALSA input device.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `bufferize` (`bool` -- defaults to `true`): Bufferize input.
* `device` (`string` -- defaults to `&quot;default&quot;`): Alsa device to use.

#### input.external
```
(?id:string, ?buffer:float, ?max:float,
 ?channels:int, ?samplerate:int, ?restart:bool,
 ?restart_on_error:bool, string)->source```

Stream data from an external application.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `buffer` (`float` -- defaults to `2.`): Duration of the pre-buffered data.
* `max` (`float` -- defaults to `10.`): Maximum duration of the buffered data.
* `channels` (`int` -- defaults to `2`): Number of channels.
* `samplerate` (`int` -- defaults to `44100`): Samplerate.
* `restart` (`bool` -- defaults to `true`): Restart process when exited.
* `restart_on_error` (`bool` -- defaults to `false`): Restart process when exited with error.
* `(unlabeled)` (`string`): Command to execute.

#### input.harbor
```
(?id:string, ?buffer:float, ?max:float,
 ?on_connect:(([(string*string)])->unit),
 ?on_disconnect:(()->unit), ?user:string,
 ?password:string, ?auth:((string, string)->bool),
 ?dumpfile:string, ?logfile:string, ?debug:bool,
 string)->source```

Retrieves the given http stream from the harbor.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `buffer` (`float` -- defaults to `2.`): Duration of the pre-buffered data.
* `max` (`float` -- defaults to `10.`): Maximum duration of the buffered data.
* `on_connect` (`([(string*string)])-&gt;unit` -- defaults to `{()}`): Function to execute when a source is connected. Its receives the list of headers, of the form: (``label'',``value''). All labels are lowercase.
* `on_disconnect` (`()-&gt;unit` -- defaults to `{()}`): Functions to excecute when a source is disconnected
* `user` (`string` -- defaults to `&quot;&quot;`): Source user. Override default if not empty.
* `password` (`string` -- defaults to `&quot;&quot;`): Source password. Override default if not empty.
* `auth` (`(string, string)-&gt;bool` -- defaults to `{false}`): Authentification function. `f(login,password)` returns `true` if the user should be granted access for this login. Override any other method if used.
* `dumpfile` (`string` -- defaults to `&quot;&quot;`): Dump stream to file, for debugging purpose. Disabled if empty.
* `logfile` (`string` -- defaults to `&quot;&quot;`): Log buffer status to file, for debugging purpose. Disabled if empty.
* `debug` (`bool` -- defaults to `false`): Run in debugging mode by not catching some exceptions.
* `(unlabeled)` (`string`): Mountpoint to look for.

#### input.http
```
(?id:string, ?autostart:bool, ?bind_address:string,
 ?buffer:float, ?timeout:float,
 ?new_track_on_metadata:bool, ?force_mime:string,
 ?playlist_mode:string, ?poll_delay:float,
 ?max:float, ?logfile:string, ?debug:bool,
 ?user_agent:string, string)->source```

Forwards the given http stream. The relay can be paused/resumed using the start/stop telnet commands.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `autostart` (`bool` -- defaults to `true`): Initially start relaying or not.
* `bind_address` (`string` -- defaults to `&quot;&quot;`): Address to bind on the local machine. This option can be useful if your machine is bound to multiple IPs. Empty means no bind address.
* `buffer` (`float` -- defaults to `2.`): Duration of the pre-buffered data.
* `timeout` (`float` -- defaults to `10.`): Timeout for http connection.
* `new_track_on_metadata` (`bool` -- defaults to `true`): Treat new metadata as new track.
* `force_mime` (`string` -- defaults to `&quot;&quot;`): Force mime data type. Not used if empty.
* `playlist_mode` (`string` -- defaults to `&quot;normal&quot;`): Valid modes are ``normal'', ``random'', ``randomize'' and ``first''. The first ones have the same meaning as for the mode parameter of the playlist operator. The last one discards all entries but the first one.
* `poll_delay` (`float` -- defaults to `2.`): Polling delay when trying to connect to the stream.
* `max` (`float` -- defaults to `10.`): Maximum duration of the buffered data.
* `logfile` (`string` -- defaults to `&quot;&quot;`): Log buffer status to file, for debugging purpose. Disabled if empty.
* `debug` (`bool` -- defaults to `false`): Run in debugging mode, not catching some exceptions.
* `user_agent` (`string` -- defaults to ```
&quot;liquidsoap/0.9.1+svn (Unix; ocaml 3.11.1)&quot;```
): User agent.
* `(unlabeled)` (`string`): URL of an http stream (default port is 80).

#### input.jack
```
(?id:string, ?buffer_size:int, ?server:string)
 ->source```

Get stream from jack.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `buffer_size` (`int` -- defaults to `2`): Set buffer size, in frames. Must be >= 1.
* `server` (`string` -- defaults to `&quot;&quot;`): Jack server to connect to.

#### input.jack.legacy
```
(?id:string, ?ports:[string], ?synchronize:bool)
 ->source```

WARNING: This is DEPRECATED!

Deprecated jack input.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `ports` (`[string]` -- defaults to ```
[ &quot;input_0&quot;, &quot;input_1&quot; ]```
): Port names.
* `synchronize` (`bool` -- defaults to `true`): Synchronize on jack input.

#### input.lastfm
```
(?id:string, ?autostart:bool, ?buffer:float,
 ?bind_address:string, ?timeout:float,
 ?poll_delay:float, ?submit:bool,
 ?submit_host:string, ?submit_port:int,
 ?new_track_on_metadata:bool, ?debug:bool,
 ?max:float, ?user_agent:string, string)->source```

Forwards the given lastfm stream. The relay can be paused/resumed using the start/stop telnet commands.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `autostart` (`bool` -- defaults to `true`): Initially start relaying or not.
* `buffer` (`float` -- defaults to `2.`): Duration of the pre-buffered data.
* `bind_address` (`string` -- defaults to `&quot;&quot;`): address to bind on the local machine. This option can be useful if your machine is bound to multiple IPs. ``'' means no bind address.
* `timeout` (`float` -- defaults to `10.`): Timeout for HTTP connections.
* `poll_delay` (`float` -- defaults to `2.`): Polling delay.
* `submit` (`bool` -- defaults to `false`): Submit song to Audioscrobbler. Only when the url is not anonymous, e.g. `lastfm://user:password@artist/foo`.
* `submit_host` (`string` -- defaults to `&quot;post.audioscrobbler.com&quot;`): Host for audioscrobbling submissions.
* `submit_port` (`int` -- defaults to `80`): Port for audioscrobbling submissions.
* `new_track_on_metadata` (`bool` -- defaults to `true`): Treat new metadata as new track.
* `debug` (`bool` -- defaults to `false`): Run in debugging mode by not catching some exceptions.
* `max` (`float` -- defaults to `10.`): Maximum duration of the buffered data.
* `user_agent` (`string` -- defaults to ```
&quot;liquidsoap/0.9.1+svn (Unix; ocaml 3.11.1)&quot;```
): User agent.
* `(unlabeled)` (`string`): URI of a lastfm stream (e.g. lastfm://user/toots5446/playlist).

#### input.marshal
```
(?id:string, ?reopen:bool, string)->source```

WARNING: This is only EXPERIMENTAL!

Get a stream from a pipe using marshaling.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `reopen` (`bool` -- defaults to `false`): Try to reopen the pipe after a failure.
* `(unlabeled)` (`string`): Pipe to get the stream from.

#### input.mplayer
```
(?id:string, ?restart:bool, ?restart_on_error:bool,
 ?buffer:float, ?max:float, string)->source```

Stream data from mplayer

* `id` (`string` -- defaults to `&quot;input.mplayer&quot;`)
* `restart` (`bool` -- defaults to `true`): restart on exit.
* `restart_on_error` (`bool` -- defaults to `false`): restart on exit with error.
* `buffer` (`float` -- defaults to `0.2`): Duration of the pre-buffered data.
* `max` (`float` -- defaults to `10.`): Maximum duration of the buffered data.
* `(unlabeled)` (`string`): data URI.

#### input.oss
```
(?id:string, ?device:string)->source```

Stream from an OSS input device.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `device` (`string` -- defaults to `&quot;/dev/dsp&quot;`): OSS device to use.

#### input.portaudio
```
(?id:string, ?buflen:int)->source```

Stream from a portaudio input device.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `buflen` (`int` -- defaults to `256`): Length of a buffer in samples.

#### input.pulseaudio
```
(?id:string, ?client:string, ?device:string)
 ->source```

Stream from a portaudio input device.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `client` (`string` -- defaults to `&quot;liquidsoap&quot;`)
* `device` (`string` -- defaults to `&quot;&quot;`): Device to use. Uses default if set to ``''.

#### input.v4l
```
(?id:string, ?device:string)->source```

Stream from a V4L (= video 4 linux) input device, such as a webcam.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `device` (`string` -- defaults to `&quot;/dev/video0&quot;`): V4L device to use.

#### mksafe
```
(source)->source```

Turn a source into an infaillible source.
by adding blank when the source is not available.

* `(unlabeled)` (`source`): the source to turn infaillible

#### noise
```
(?id:string, ?duration:float)->source```

Generate white noise.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `duration` (`float` -- defaults to `0.`)

#### playlist
```
(?id:string, ?length:float, ?default_duration:float,
 ?conservative:bool, ?timeout:float, ?mode:string,
 ?reload:int, ?reload_mode:string,
 ?mime_type:string, ?prefix:string, ?timeout:float,
 string)->source```

Loop on a playlist of URIs.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `length` (`float` -- defaults to `10.`): How much audio (in sec.) should be queued in advance.
* `default_duration` (`float` -- defaults to `30.`): When unknown, assume this duration (in sec.) for files.
* `conservative` (`bool` -- defaults to `false`): If true, estimated remaining time on the current track is not considered when computing queue length.
* `timeout` (`float` -- defaults to `20.`): Timeout (in sec.) for a single download.
* `mode` (`string` -- defaults to `&quot;randomize&quot;`): Play the files in the playlist either in the order (``normal'' mode), or shuffle the playlist each time it is loaded, and play it in this order for a whole round (``randomize'' mode), or pick a random file in the playlist each time (``random'' mode).
* `reload` (`int` -- defaults to `0`): Amount of time (in seconds or rounds) before which the playlist is reloaded; 0 means never.
* `reload_mode` (`string` -- defaults to `&quot;seconds&quot;`): Unit of the reload parameter, either 'rounds' or 'seconds'.
* `mime_type` (`string` -- defaults to `&quot;&quot;`): Default MIME type for the playlist. Empty string means automatic detection.
* `prefix` (`string` -- defaults to `&quot;&quot;`): Add a constant prefix to all requests. Usefull for passing extra information using annotate, or for resolution through a particular protocol, such as replaygain.
* `timeout` (`float` -- defaults to `20.`): Timeout (in seconds) for a single download.
* `(unlabeled)` (`string`): URI where to find the playlist.

#### playlist.once
```
(?random:bool, ?on_done:(()->unit), string)->source```

Custom playlist source written using the script language.
Will read directory or playlist, play all files and stop

* `random` (`bool` -- defaults to `false`): Randomize playlist content
* `on_done` (`()-&gt;unit` -- defaults to `{()}`): Function to execute when the playlist is finished
* `(unlabeled)` (`string`): Playlist URI

#### playlist.safe
```
(?id:string, ?mode:string, ?reload:int,
 ?reload_mode:string, ?mime_type:string,
 ?prefix:string, ?timeout:float, string)->source```

Loop on a playlist of local files, and never fail. In order to do so, it has to check every file at the loading, so the streamer startup may take a few seconds. To avoid this, use a standard playlist, and put only a few local files in a default safe_playlist in order to ensure the liveness of the streamer.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `mode` (`string` -- defaults to `&quot;randomize&quot;`): Play the files in the playlist either in the order (``normal'' mode), or shuffle the playlist each time it is loaded, and play it in this order for a whole round (``randomize'' mode), or pick a random file in the playlist each time (``random'' mode).
* `reload` (`int` -- defaults to `0`): Amount of time (in seconds or rounds) before which the playlist is reloaded; 0 means never.
* `reload_mode` (`string` -- defaults to `&quot;seconds&quot;`): Unit of the reload parameter, either 'rounds' or 'seconds'.
* `mime_type` (`string` -- defaults to `&quot;&quot;`): Default MIME type for the playlist. Empty string means automatic detection.
* `prefix` (`string` -- defaults to `&quot;&quot;`): Add a constant prefix to all requests. Usefull for passing extra information using annotate, or for resolution through a particular protocol, such as replaygain.
* `timeout` (`float` -- defaults to `20.`): Timeout (in seconds) for a single download.
* `(unlabeled)` (`string`): URI where to find the playlist.

#### request.dynamic
```
(?id:string, (()->request), ?length:float,
 ?default_duration:float, ?conservative:bool,
 ?timeout:float)->source```

Play request dynamically created by a given function.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `(unlabeled)` (`()-&gt;request`): A function generating requests: an initial URI (possibly fake) together with an initial list of alternative indicators.
* `length` (`float` -- defaults to `10.`): How much audio (in sec.) should be queued in advance.
* `default_duration` (`float` -- defaults to `30.`): When unknown, assume this duration (in sec.) for files.
* `conservative` (`bool` -- defaults to `false`): If true, estimated remaining time on the current track is not considered when computing queue length.
* `timeout` (`float` -- defaults to `20.`): Timeout (in sec.) for a single download.

#### request.equeue
```
(?id:string, ?length:float, ?default_duration:float,
 ?conservative:bool, ?timeout:float)->source```

Receive URIs from users, and play them. Insertion and deletion possible at any position.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `length` (`float` -- defaults to `10.`): How much audio (in sec.) should be queued in advance.
* `default_duration` (`float` -- defaults to `30.`): When unknown, assume this duration (in sec.) for files.
* `conservative` (`bool` -- defaults to `false`): If true, estimated remaining time on the current track is not considered when computing queue length.
* `timeout` (`float` -- defaults to `20.`): Timeout (in sec.) for a single download.

#### request.queue
```
(?id:string, ?queue:[request], ?interactive:bool,
 ?length:float, ?default_duration:float,
 ?conservative:bool, ?timeout:float)->source```

Receive URIs from users, and play them.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `queue` (`[request]` -- defaults to `[  ]`): Initial queue of requests.
* `interactive` (`bool` -- defaults to `true`): Should the queue be controllable via telnet?
* `length` (`float` -- defaults to `10.`): How much audio (in sec.) should be queued in advance.
* `default_duration` (`float` -- defaults to `30.`): When unknown, assume this duration (in sec.) for files.
* `conservative` (`bool` -- defaults to `false`): If true, estimated remaining time on the current track is not considered when computing queue length.
* `timeout` (`float` -- defaults to `20.`): Timeout (in sec.) for a single download.

#### saw
```
(?id:string, ?duration:float, ?float)->source```

Generate a saw wave.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `duration` (`float` -- defaults to `0.`)
* `(unlabeled)` (`float` -- defaults to `440.`): Frequency of the saw.

#### sine
```
(?id:string, ?duration:float, ?float)->source```

Generate a sine wave.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `duration` (`float` -- defaults to `0.`)
* `(unlabeled)` (`float` -- defaults to `440.`): Frequency of the sine.

#### single
```
(?id:string, string, ?length:float,
 ?default_duration:float, ?conservative:bool,
 ?timeout:float)->source```

Loop on a request. It never fails if the request is static, meaning that it can be fetched once. Typically, http, ftp, say requests are static, and time is not.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `(unlabeled)` (`string`): URI where to find the file
* `length` (`float` -- defaults to `10.`): How much audio (in sec.) should be queued in advance.
* `default_duration` (`float` -- defaults to `30.`): When unknown, assume this duration (in sec.) for files.
* `conservative` (`bool` -- defaults to `false`): If true, estimated remaining time on the current track is not considered when computing queue length.
* `timeout` (`float` -- defaults to `20.`): Timeout (in sec.) for a single download.

#### square
```
(?id:string, ?duration:float, ?float)->source```

Generate a square wave.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `duration` (`float` -- defaults to `0.`)
* `(unlabeled)` (`float` -- defaults to `440.`): Frequency of the square.

#### video.image
```
(?id:string, ?width:int, ?height:int, ?x:int,
 ?y:int, ?alpha:int, ?duration:float, string)
 ->source```

Display a static image.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `width` (`int` -- defaults to `-1`): Scale to width (negative means original width).
* `height` (`int` -- defaults to `-1`): Scale to width (negative means original height).
* `x` (`int` -- defaults to `0`): x position (negative means from right).
* `y` (`int` -- defaults to `0`): y position (negative means from bottom).
* `alpha` (`int` -- defaults to `-1`): Color to convert to alpha (in 0xRRGGBB format, negative means no alpha).
* `duration` (`float` -- defaults to `0.`)
* `(unlabeled)` (`string`): Path to image file.

#### video.noise
```
(?id:string, ?duration:float)->source```

Generate white noise.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `duration` (`float` -- defaults to `0.`)

Source / MIDI Processing
------------------------
#### midi.merge_all
```
(?id:string, ?track_out:int, source)->source```

Merge all MIDI tracks in one.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `track_out` (`int` -- defaults to `0`): Destination track.
* `(unlabeled)` (`source`)

#### midi.remove
```
(?id:string, [int], source)->source```

Remove MIDI tracks.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `(unlabeled)` (`[int]`): Tracks to remove.
* `(unlabeled)` (`source`)

Source / Output
---------------
#### out
```
(source)->source```

Output a stream using the 'output.prefered' operator. The input source does
not need to be infallible, blank will just be played during failures.

* `(unlabeled)` (`source`): the source to output

#### output.alsa
```
(?id:string, ?bufferize:bool, ?device:string,
 source)->source```

Output the source's stream to an ALSA output device.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `bufferize` (`bool` -- defaults to `true`): Bufferize output
* `device` (`string` -- defaults to `&quot;default&quot;`): Alsa device to use
* `(unlabeled)` (`source`)

#### output.ao
```
(?id:string, ?fallible:bool, ?on_start:(()->unit),
 ?on_stop:(()->unit), ?start:bool, ?driver:string,
 ?buffer_size:int, ?options:[(string*string)],
 source)->source```

Output stream to local sound card using libao.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `driver` (`string` -- defaults to `&quot;&quot;`): libao driver to use.
* `buffer_size` (`int` -- defaults to `2`): Set buffer size, in frames.
* `options` (`[(string*string)]` -- defaults to `[  ]`): List of parameters, depends on driver.
* `(unlabeled)` (`source`)

#### output.aplay
```
(?id:string, ?device:string, ?fallible:bool,
 ?on_start:(()->unit), ?on_stop:(()->unit),
 ?restart_on_crash:bool, source)->source```

Output the stream using aplay.
Using this turns ``root.sync'' to false
since aplay will do the synchronisation

* `id` (`string` -- defaults to `&quot;output.aplay&quot;`): Output's ID
* `device` (`string` -- defaults to `&quot;default&quot;`): Alsa pcm device name
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `restart_on_crash` (`bool` -- defaults to `false`): Restart external process on crash. If false, liquidsoap will stop.
* `(unlabeled)` (`source`): Source to play

#### output.dummy
```
(?id:string, ?fallible:bool, ?autostart:bool,
 ?on_start:(()->unit), ?on_stop:(()->unit), source)
 ->source```

Dummy output for debugging purposes.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `fallible` (`bool` -- defaults to `false`)
* `autostart` (`bool` -- defaults to `true`)
* `on_start` (`()-&gt;unit` -- defaults to `{()}`)
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`)
* `(unlabeled)` (`source`)

#### output.file.aac
```
(?id:string, ?fallible:bool, ?on_start:(()->unit),
 ?on_stop:(()->unit), ?start:bool, ?bandwidth:int,
 ?bitrate:int, ?quality:int, string, source)
 ->source```

Output the source's stream as an AAC file.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `bandwidth` (`int` -- defaults to `16000`)
* `bitrate` (`int` -- defaults to `128`)
* `quality` (`int` -- defaults to `100`)
* `(unlabeled)` (`string`): Filename where to output the AAC stream.
* `(unlabeled)` (`source`)

#### output.file.aacplus
```
(?id:string, ?samplerate:int, ?bitrate:int,
 ?append:bool, ?perm:int, ?dir_perm:int,
 ?reopen_delay:float, ?reopen_on_metadata:bool,
 ?reopen_when:(()->bool), string, ?fallible:bool,
 ?on_start:(()->unit), ?on_stop:(()->unit),
 ?start:bool, source)->source```

Output the source's stream as an AAC+ file.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `samplerate` (`int` -- defaults to `44100`)
* `bitrate` (`int` -- defaults to `64`)
* `append` (`bool` -- defaults to `false`): Do not truncate but append in the file if it exists.
* `perm` (`int` -- defaults to `438`): Permission of the file if it has to be created, up to umask. You can and should write this number in octal notation: 0oXXX. The default value is however displayed in decimal (0o666 = 6*8^2 + 6*8 + 6 = 438).
* `dir_perm` (`int` -- defaults to `511`): Permission of the directories if some have to be created, up to umask. Although you can enter values in octal notation (0oXXX) they will be displayed in decimal (for instance, 0o777 = 7*8^2 + 7*8 + 7 = 511).
* `reopen_delay` (`float` -- defaults to `120.`): Prevent re-opening of the file within that delay, in seconds.
* `reopen_on_metadata` (`bool` -- defaults to `false`): Re-open on every new metadata information.
* `reopen_when` (`()-&gt;bool` -- defaults to `{false}`): When should the output file be re-opened.
* `(unlabeled)` (`string`): Filename where to output the stream. Some strftime conversion specifiers are available: `%SMHdmY`. You can also use `$(..)` interpolation notation for metadata.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source`)

#### output.file.dirac
```
(?id:string, ?quality:int, ?vorbis_quality:float,
 ?skeleton:bool, ?append:bool, ?perm:int,
 ?dir_perm:int, ?reopen_delay:float,
 ?reopen_on_metadata:bool, ?reopen_when:(()->bool),
 string, ?fallible:bool, ?on_start:(()->unit),
 ?on_stop:(()->unit), ?start:bool, source)->source```

Output the source's stream as an ogg/theora file.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `quality` (`int` -- defaults to `100`): Quality setting for dirac encoding.
* `vorbis_quality` (`float` -- defaults to `2.`): Quality setting for vorbis encoding. Don't encode audio if value is negative or null.
* `skeleton` (`bool` -- defaults to `true`): Add an ogg skeleton to the stream. Recommended for theora only.
* `append` (`bool` -- defaults to `false`): Do not truncate but append in the file if it exists.
* `perm` (`int` -- defaults to `438`): Permission of the file if it has to be created, up to umask. You can and should write this number in octal notation: 0oXXX. The default value is however displayed in decimal (0o666 = 6*8^2 + 6*8 + 6 = 438).
* `dir_perm` (`int` -- defaults to `511`): Permission of the directories if some have to be created, up to umask. Although you can enter values in octal notation (0oXXX) they will be displayed in decimal (for instance, 0o777 = 7*8^2 + 7*8 + 7 = 511).
* `reopen_delay` (`float` -- defaults to `120.`): Prevent re-opening of the file within that delay, in seconds.
* `reopen_on_metadata` (`bool` -- defaults to `false`): Re-open on every new metadata information.
* `reopen_when` (`()-&gt;bool` -- defaults to `{false}`): When should the output file be re-opened.
* `(unlabeled)` (`string`): Filename where to output the stream. Some strftime conversion specifiers are available: `%SMHdmY`. You can also use `$(..)` interpolation notation for metadata.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source`)

#### output.file.external
```
(?id:string, ~process:(([(string*string)])->string),
 ?samplerate:int, ?header:bool,
 ?restart_on_crash:bool, ?restart_on_new_track:bool,
 ?restart_encoder_delay:int, ?fallible:bool,
 ?on_start:(()->unit), ?on_stop:(()->unit),
 ?start:bool, ?append:bool, ?perm:int,
 ?dir_perm:int, ?reopen_delay:float,
 ?reopen_on_metadata:bool, ?reopen_when:(()->bool),
 string, source)->source```

Output the source's stream as a file, using an external encoding process.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `process` (`([(string*string)])-&gt;string`): External encoding process. Takes initial metadata and return the command to start.
* `samplerate` (`int` -- defaults to `44100`): Output sample rate.
* `header` (`bool` -- defaults to `true`): Write wav header at beginning of encoded input.
* `restart_on_crash` (`bool` -- defaults to `false`): Restart external process when it crashed. If false, liquidsoap exits.
* `restart_on_new_track` (`bool` -- defaults to `false`): Restart encoder on new track.
* `restart_encoder_delay` (`int` -- defaults to `-1`): Restart the encoder after this delay, in seconds.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `append` (`bool` -- defaults to `false`): Do not truncate but append in the file if it exists.
* `perm` (`int` -- defaults to `438`): Permission of the file if it has to be created, up to umask. You can and should write this number in octal notation: 0oXXX. The default value is however displayed in decimal (0o666 = 6*8^2 + 6*8 + 6 = 438).
* `dir_perm` (`int` -- defaults to `511`): Permission of the directories if some have to be created, up to umask. Although you can enter values in octal notation (0oXXX) they will be displayed in decimal (for instance, 0o777 = 7*8^2 + 7*8 + 7 = 511).
* `reopen_delay` (`float` -- defaults to `120.`): Prevent re-opening of the file within that delay, in seconds.
* `reopen_on_metadata` (`bool` -- defaults to `false`): Re-open on every new metadata information.
* `reopen_when` (`()-&gt;bool` -- defaults to `{false}`): When should the output file be re-opened.
* `(unlabeled)` (`string`): Filename where to output the stream. Some strftime conversion specifiers are available: `%SMHdmY`. You can also use `$(..)` interpolation notation for metadata.
* `(unlabeled)` (`source`)

#### output.file.mp3
```
(?id:string, ?samplerate:int, ?bitrate:int,
 ?quality:int, ?stereo:bool, ?append:bool,
 ?perm:int, ?dir_perm:int, ?reopen_delay:float,
 ?reopen_on_metadata:bool, ?reopen_when:(()->bool),
 string, ?fallible:bool, ?on_start:(()->unit),
 ?on_stop:(()->unit), ?start:bool, source)->source```

Output the source's stream as an MP3 file.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `samplerate` (`int` -- defaults to `44100`)
* `bitrate` (`int` -- defaults to `128`)
* `quality` (`int` -- defaults to `5`)
* `stereo` (`bool` -- defaults to `true`)
* `append` (`bool` -- defaults to `false`): Do not truncate but append in the file if it exists.
* `perm` (`int` -- defaults to `438`): Permission of the file if it has to be created, up to umask. You can and should write this number in octal notation: 0oXXX. The default value is however displayed in decimal (0o666 = 6*8^2 + 6*8 + 6 = 438).
* `dir_perm` (`int` -- defaults to `511`): Permission of the directories if some have to be created, up to umask. Although you can enter values in octal notation (0oXXX) they will be displayed in decimal (for instance, 0o777 = 7*8^2 + 7*8 + 7 = 511).
* `reopen_delay` (`float` -- defaults to `120.`): Prevent re-opening of the file within that delay, in seconds.
* `reopen_on_metadata` (`bool` -- defaults to `false`): Re-open on every new metadata information.
* `reopen_when` (`()-&gt;bool` -- defaults to `{false}`): When should the output file be re-opened.
* `(unlabeled)` (`string`): Filename where to output the stream. Some strftime conversion specifiers are available: `%SMHdmY`. You can also use `$(..)` interpolation notation for metadata.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source`)

#### output.file.speex
```
(?id:string, ?samplerate:int, ?bitrate:int,
 ?quality:int, ?mode:string, ?stereo:bool,
 ?vbr:bool, ?frames_per_packet:int, ?complexity:int,
 ?abr:int, ?skeleton:bool, ?append:bool, ?perm:int,
 ?dir_perm:int, ?reopen_delay:float,
 ?reopen_on_metadata:bool, ?reopen_when:(()->bool),
 string, ?fallible:bool, ?on_start:(()->unit),
 ?on_stop:(()->unit), ?start:bool, source)->source```

Output the source stream as an Ogg speex file.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `samplerate` (`int` -- defaults to `-1`): Output sample rate. Use liquidsoap's default if <= 0.
* `bitrate` (`int` -- defaults to `-1`): Target bitrate (in kbps). Not used if <= 0.
* `quality` (`int` -- defaults to `7`): Target quality (0 to 10). Not used if <= 0.
* `mode` (`string` -- defaults to `&quot;narrowband&quot;`): Encoding mode, one of ``narrowband'', ``wideband'' or ``ultra-wideband''.
* `stereo` (`bool` -- defaults to `false`)
* `vbr` (`bool` -- defaults to `false`): Encode in vbr mode.
* `frames_per_packet` (`int` -- defaults to `1`): Number of frame per Ogg packet (1 to 10).
* `complexity` (`int` -- defaults to `-1`): Encoding complexity (0-10). Not used if <= 0.
* `abr` (`int` -- defaults to `-1`): Set average bitrate. Not used if <= 0.
* `skeleton` (`bool` -- defaults to `false`): Add an ogg skeleton to the stream. Recommended for theora only.
* `append` (`bool` -- defaults to `false`): Do not truncate but append in the file if it exists.
* `perm` (`int` -- defaults to `438`): Permission of the file if it has to be created, up to umask. You can and should write this number in octal notation: 0oXXX. The default value is however displayed in decimal (0o666 = 6*8^2 + 6*8 + 6 = 438).
* `dir_perm` (`int` -- defaults to `511`): Permission of the directories if some have to be created, up to umask. Although you can enter values in octal notation (0oXXX) they will be displayed in decimal (for instance, 0o777 = 7*8^2 + 7*8 + 7 = 511).
* `reopen_delay` (`float` -- defaults to `120.`): Prevent re-opening of the file within that delay, in seconds.
* `reopen_on_metadata` (`bool` -- defaults to `false`): Re-open on every new metadata information.
* `reopen_when` (`()-&gt;bool` -- defaults to `{false}`): When should the output file be re-opened.
* `(unlabeled)` (`string`): Filename where to output the stream. Some strftime conversion specifiers are available: `%SMHdmY`. You can also use `$(..)` interpolation notation for metadata.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source`)

#### output.file.theora
```
(?id:string, ?quality:int, ?vorbis_quality:float,
 ?skeleton:bool, ?append:bool, ?perm:int,
 ?dir_perm:int, ?reopen_delay:float,
 ?reopen_on_metadata:bool, ?reopen_when:(()->bool),
 string, ?fallible:bool, ?on_start:(()->unit),
 ?on_stop:(()->unit), ?start:bool, source)->source```

Output the source's stream as an ogg/theora file.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `quality` (`int` -- defaults to `100`): Quality setting for theora encoding.
* `vorbis_quality` (`float` -- defaults to `2.`): Quality setting for vorbis encoding. Don't encode audio if value is negative or null.
* `skeleton` (`bool` -- defaults to `true`): Add an ogg skeleton to the stream. Recommended for theora only.
* `append` (`bool` -- defaults to `false`): Do not truncate but append in the file if it exists.
* `perm` (`int` -- defaults to `438`): Permission of the file if it has to be created, up to umask. You can and should write this number in octal notation: 0oXXX. The default value is however displayed in decimal (0o666 = 6*8^2 + 6*8 + 6 = 438).
* `dir_perm` (`int` -- defaults to `511`): Permission of the directories if some have to be created, up to umask. Although you can enter values in octal notation (0oXXX) they will be displayed in decimal (for instance, 0o777 = 7*8^2 + 7*8 + 7 = 511).
* `reopen_delay` (`float` -- defaults to `120.`): Prevent re-opening of the file within that delay, in seconds.
* `reopen_on_metadata` (`bool` -- defaults to `false`): Re-open on every new metadata information.
* `reopen_when` (`()-&gt;bool` -- defaults to `{false}`): When should the output file be re-opened.
* `(unlabeled)` (`string`): Filename where to output the stream. Some strftime conversion specifiers are available: `%SMHdmY`. You can also use `$(..)` interpolation notation for metadata.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source`)

#### output.file.vorbis
```
(?id:string, ?samplerate:int, ?stereo:bool,
 ?skeleton:bool, ?start:bool, ?quality:float,
 ?append:bool, ?perm:int, ?dir_perm:int,
 ?reopen_delay:float, ?reopen_on_metadata:bool,
 ?reopen_when:(()->bool), string, ?fallible:bool,
 ?on_start:(()->unit), ?on_stop:(()->unit),
 ?start:bool, source)->source```

Output the source stream as an Ogg Vorbis file in Variable BitRate mode.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `samplerate` (`int` -- defaults to `44100`)
* `stereo` (`bool` -- defaults to `true`)
* `skeleton` (`bool` -- defaults to `false`): Add an ogg skeleton to the stream. Recommended for theora only.
* `start` (`bool` -- defaults to `true`): Start output on operator initialization.
* `quality` (`float` -- defaults to `2.`): Desired quality level, currently from -1. to 10. (low to high).
* `append` (`bool` -- defaults to `false`): Do not truncate but append in the file if it exists.
* `perm` (`int` -- defaults to `438`): Permission of the file if it has to be created, up to umask. You can and should write this number in octal notation: 0oXXX. The default value is however displayed in decimal (0o666 = 6*8^2 + 6*8 + 6 = 438).
* `dir_perm` (`int` -- defaults to `511`): Permission of the directories if some have to be created, up to umask. Although you can enter values in octal notation (0oXXX) they will be displayed in decimal (for instance, 0o777 = 7*8^2 + 7*8 + 7 = 511).
* `reopen_delay` (`float` -- defaults to `120.`): Prevent re-opening of the file within that delay, in seconds.
* `reopen_on_metadata` (`bool` -- defaults to `false`): Re-open on every new metadata information.
* `reopen_when` (`()-&gt;bool` -- defaults to `{false}`): When should the output file be re-opened.
* `(unlabeled)` (`string`): Filename where to output the stream. Some strftime conversion specifiers are available: `%SMHdmY`. You can also use `$(..)` interpolation notation for metadata.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source`)

#### output.file.vorbis.abr
```
(?id:string, ?samplerate:int, ?stereo:bool,
 ?skeleton:bool, ?append:bool, ?perm:int,
 ?dir_perm:int, ?reopen_delay:float,
 ?reopen_on_metadata:bool, ?reopen_when:(()->bool),
 string, ?fallible:bool, ?on_start:(()->unit),
 ?on_stop:(()->unit), ?start:bool, ?bitrate:int,
 ?min_bitrate:int, ?max_bitrate:int, source)
 ->source```

Output the source stream as an Ogg Vorbis file in Average BitRate mode.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `samplerate` (`int` -- defaults to `44100`)
* `stereo` (`bool` -- defaults to `true`)
* `skeleton` (`bool` -- defaults to `false`): Add an ogg skeleton to the stream. Recommended for theora only.
* `append` (`bool` -- defaults to `false`): Do not truncate but append in the file if it exists.
* `perm` (`int` -- defaults to `438`): Permission of the file if it has to be created, up to umask. You can and should write this number in octal notation: 0oXXX. The default value is however displayed in decimal (0o666 = 6*8^2 + 6*8 + 6 = 438).
* `dir_perm` (`int` -- defaults to `511`): Permission of the directories if some have to be created, up to umask. Although you can enter values in octal notation (0oXXX) they will be displayed in decimal (for instance, 0o777 = 7*8^2 + 7*8 + 7 = 511).
* `reopen_delay` (`float` -- defaults to `120.`): Prevent re-opening of the file within that delay, in seconds.
* `reopen_on_metadata` (`bool` -- defaults to `false`): Re-open on every new metadata information.
* `reopen_when` (`()-&gt;bool` -- defaults to `{false}`): When should the output file be re-opened.
* `(unlabeled)` (`string`): Filename where to output the stream. Some strftime conversion specifiers are available: `%SMHdmY`. You can also use `$(..)` interpolation notation for metadata.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `bitrate` (`int` -- defaults to `128`): Target bitrate (in kbps).
* `min_bitrate` (`int` -- defaults to `118`): Minimum bitrate (in kbps).
* `max_bitrate` (`int` -- defaults to `138`): Maximum bitrate (in kbps).
* `(unlabeled)` (`source`)

#### output.file.vorbis.cbr
```
(?id:string, ?samplerate:int, ?stereo:bool,
 ?skeleton:bool, ?start:bool, ?bitrate:int,
 ?append:bool, ?perm:int, ?dir_perm:int,
 ?reopen_delay:float, ?reopen_on_metadata:bool,
 ?reopen_when:(()->bool), string, ?fallible:bool,
 ?on_start:(()->unit), ?on_stop:(()->unit),
 ?start:bool, source)->source```

Output the source stream as an Ogg Vorbis file in Constant BitRate mode.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `samplerate` (`int` -- defaults to `44100`)
* `stereo` (`bool` -- defaults to `true`)
* `skeleton` (`bool` -- defaults to `false`): Add an ogg skeleton to the stream. Recommended for theora only.
* `start` (`bool` -- defaults to `true`): Start output on operator initialization.
* `bitrate` (`int` -- defaults to `128`): Bitrate (in kbps).
* `append` (`bool` -- defaults to `false`): Do not truncate but append in the file if it exists.
* `perm` (`int` -- defaults to `438`): Permission of the file if it has to be created, up to umask. You can and should write this number in octal notation: 0oXXX. The default value is however displayed in decimal (0o666 = 6*8^2 + 6*8 + 6 = 438).
* `dir_perm` (`int` -- defaults to `511`): Permission of the directories if some have to be created, up to umask. Although you can enter values in octal notation (0oXXX) they will be displayed in decimal (for instance, 0o777 = 7*8^2 + 7*8 + 7 = 511).
* `reopen_delay` (`float` -- defaults to `120.`): Prevent re-opening of the file within that delay, in seconds.
* `reopen_on_metadata` (`bool` -- defaults to `false`): Re-open on every new metadata information.
* `reopen_when` (`()-&gt;bool` -- defaults to `{false}`): When should the output file be re-opened.
* `(unlabeled)` (`string`): Filename where to output the stream. Some strftime conversion specifiers are available: `%SMHdmY`. You can also use `$(..)` interpolation notation for metadata.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source`)

#### output.file.wav
```
(?id:string, ?append:bool, ?perm:int, ?dir_perm:int,
 ?reopen_delay:float, ?reopen_on_metadata:bool,
 ?reopen_when:(()->bool), string, ?fallible:bool,
 ?on_start:(()->unit), ?on_stop:(()->unit),
 ?start:bool, source)->source```

Output the source's stream to a WAV file.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `append` (`bool` -- defaults to `false`): Do not truncate but append in the file if it exists.
* `perm` (`int` -- defaults to `438`): Permission of the file if it has to be created, up to umask. You can and should write this number in octal notation: 0oXXX. The default value is however displayed in decimal (0o666 = 6*8^2 + 6*8 + 6 = 438).
* `dir_perm` (`int` -- defaults to `511`): Permission of the directories if some have to be created, up to umask. Although you can enter values in octal notation (0oXXX) they will be displayed in decimal (for instance, 0o777 = 7*8^2 + 7*8 + 7 = 511).
* `reopen_delay` (`float` -- defaults to `120.`): Prevent re-opening of the file within that delay, in seconds.
* `reopen_on_metadata` (`bool` -- defaults to `false`): Re-open on every new metadata information.
* `reopen_when` (`()-&gt;bool` -- defaults to `{false}`): When should the output file be re-opened.
* `(unlabeled)` (`string`): Filename where to output the stream. Some strftime conversion specifiers are available: `%SMHdmY`. You can also use `$(..)` interpolation notation for metadata.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source`)

#### output.icecast.aacplus
```
(?id:string, ?restart:bool, ?restart_delay:int,
 ?mount:string, ?name:string, ?protocol:string,
 ?host:string, ?port:int, ?user:string,
 ?password:string, ?genre:string, ?url:string,
 ?description:string, ?public:bool,
 ?headers:[(string*string)], ?format:string,
 ?dumpfile:string, ?fallible:bool,
 ?on_start:(()->unit), ?on_stop:(()->unit),
 ?start:bool, ?samplerate:int, ?bitrate:int, source)
 ->source```

Output the source's stream to an icecast2-compatible server in AAC+ format.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `restart` (`bool` -- defaults to `false`): Restart output after a failure. By default, liquidsoap will stop if the output failed.
* `restart_delay` (`int` -- defaults to `3`): Delay, in seconds, before attempting new connection, if restart is enabled.
* `mount` (`string` -- defaults to `&quot;Use [name]&quot;`)
* `name` (`string` -- defaults to `&quot;Use [mount]&quot;`)
* `protocol` (`string` -- defaults to `&quot;http&quot;`): Protocol of the streaming server: 'http' for Icecast, 'icy' for shoutcast.
* `host` (`string` -- defaults to `&quot;localhost&quot;`)
* `port` (`int` -- defaults to `8000`)
* `user` (`string` -- defaults to `&quot;source&quot;`): User for shout source connection. Useful only in special cases, like with per-mountpoint users.
* `password` (`string` -- defaults to `&quot;hackme&quot;`)
* `genre` (`string` -- defaults to `&quot;Misc&quot;`)
* `url` (`string` -- defaults to ```
&quot;&quot;http://savonet.sf.net&quot;:http://savonet.sf.net&quot;```
)
* `description` (`string` -- defaults to `&quot;OCaml Radio!&quot;`)
* `public` (`bool` -- defaults to `true`)
* `headers` (`[(string*string)]` -- defaults to `[  ]`): Additional headers.
* `format` (`string` -- defaults to `&quot;audio/aacp&quot;`): Content-type (mime) for the format. ``mp3'' is a short-hand for mpeg audio, ``ogg'' for ogg data.
* `dumpfile` (`string` -- defaults to `&quot;&quot;`): Dump stream to file, for debugging purpose. Disabled if empty.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `samplerate` (`int` -- defaults to `44100`)
* `bitrate` (`int` -- defaults to `64`)
* `(unlabeled)` (`source`)

#### output.icecast.aacplusenc
```
(?id:string, ?start:bool, ?restart:bool,
 ?restart_delay:int, ?host:string, ?port:int,
 ?user:string, ?password:string, ?genre:string,
 ?url:string, ?description:string, ?public:bool,
 ?dumpfile:string, ?mount:string, ?name:string,
 ?protocol:string, ?aacplusenc:string, ?bitrate:int,
 ?fallible:bool, ?on_start:(()->unit),
 ?on_stop:(()->unit), ?restart_on_crash:bool,
 ?restart_on_new_track:bool,
 ?restart_encoder_delay:int,
 ?headers:[(string*string)], source)->source```

Output to icecast using the aacplusenc command line encoder.

* `id` (`string` -- defaults to `&quot;output.icecast.aacplusenc&quot;`): Output's ID
* `start` (`bool` -- defaults to `true`): Start output threads on operator initialization.
* `restart` (`bool` -- defaults to `false`): Restart output after a failure. By default, liquidsoap will stop if the output failed.
* `restart_delay` (`int` -- defaults to `3`): Delay, in seconds, before attempting new connection, if restart is enabled.
* `host` (`string` -- defaults to `&quot;localhost&quot;`)
* `port` (`int` -- defaults to `8000`)
* `user` (`string` -- defaults to `&quot;source&quot;`): User for shout source connection. Useful only in special cases, like with per-mountpoint users.
* `password` (`string` -- defaults to `&quot;hackme&quot;`)
* `genre` (`string` -- defaults to `&quot;Misc&quot;`)
* `url` (`string` -- defaults to ```
&quot;&quot;http://savonet.sf.net&quot;:http://savonet.sf.net/&quot;```
)
* `description` (`string` -- defaults to `&quot;OCaml Radio!&quot;`)
* `public` (`bool` -- defaults to `true`)
* `dumpfile` (`string` -- defaults to `&quot;&quot;`): Dump stream to file, for debugging purpose. Disabled if empty.
* `mount` (`string` -- defaults to `&quot;Use [name]&quot;`)
* `name` (`string` -- defaults to `&quot;Use [mount]&quot;`)
* `protocol` (`string` -- defaults to `&quot;http&quot;`): Protocol of the streaming server: 'http' for Icecast, 'icy' for Shoutcast.
* `aacplusenc` (`string` -- defaults to `&quot;aacplusenc&quot;`): The aacplusenc binary
* `bitrate` (`int` -- defaults to `64`): Encoder bitrate
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `restart_on_crash` (`bool` -- defaults to `false`): Restart external process on crash. If false, liquidsoap will stop.
* `restart_on_new_track` (`bool` -- defaults to `false`): Restart encoder upon new track.
* `restart_encoder_delay` (`int` -- defaults to `3600`): Restart the encoder after this delay, in seconds.
* `headers` (`[(string*string)]` -- defaults to `[  ]`)
* `(unlabeled)` (`source`): The source to output

#### output.icecast.external
```
(?id:string, ?restart:bool, ?restart_delay:int,
 ?mount:string, ?name:string, ?protocol:string,
 ?host:string, ?port:int, ?user:string,
 ?password:string, ?genre:string, ?url:string,
 ?description:string, ?public:bool,
 ?headers:[(string*string)], ?format:string,
 ?dumpfile:string,
 ~process:(([(string*string)])->string),
 ?samplerate:int, ?header:bool,
 ?restart_on_crash:bool, ?restart_on_new_track:bool,
 ?restart_encoder_delay:int, ?fallible:bool,
 ?on_start:(()->unit), ?on_stop:(()->unit),
 ?start:bool, ?bitrate:int, ?quality:float,
 ?channels:int, ?icy_metadata:bool, source)->source```

Output the source's stream to an Icecast2 compatible server using an external encoder.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `restart` (`bool` -- defaults to `false`): Restart output after a failure. By default, liquidsoap will stop if the output failed.
* `restart_delay` (`int` -- defaults to `3`): Delay, in seconds, before attempting new connection, if restart is enabled.
* `mount` (`string` -- defaults to `&quot;Use [name]&quot;`)
* `name` (`string` -- defaults to `&quot;Use [mount]&quot;`)
* `protocol` (`string` -- defaults to `&quot;http&quot;`): Protocol of the streaming server: 'http' for Icecast, 'icy' for shoutcast.
* `host` (`string` -- defaults to `&quot;localhost&quot;`)
* `port` (`int` -- defaults to `8000`)
* `user` (`string` -- defaults to `&quot;source&quot;`): User for shout source connection. Useful only in special cases, like with per-mountpoint users.
* `password` (`string` -- defaults to `&quot;hackme&quot;`)
* `genre` (`string` -- defaults to `&quot;Misc&quot;`)
* `url` (`string` -- defaults to ```
&quot;&quot;http://savonet.sf.net&quot;:http://savonet.sf.net&quot;```
)
* `description` (`string` -- defaults to `&quot;OCaml Radio!&quot;`)
* `public` (`bool` -- defaults to `true`)
* `headers` (`[(string*string)]` -- defaults to `[  ]`): Additional headers.
* `format` (`string` -- defaults to `&quot;mp3&quot;`): Content-type (mime) for the format. ``mp3'' is a short-hand for mpeg audio, ``ogg'' for ogg data.
* `dumpfile` (`string` -- defaults to `&quot;&quot;`): Dump stream to file, for debugging purpose. Disabled if empty.
* `process` (`([(string*string)])-&gt;string`): External encoding process. Takes initial metadata and return the command to start.
* `samplerate` (`int` -- defaults to `44100`): Output sample rate.
* `header` (`bool` -- defaults to `true`): Write wav header at beginning of encoded input.
* `restart_on_crash` (`bool` -- defaults to `false`): Restart external process when it crashed. If false, liquidsoap exits.
* `restart_on_new_track` (`bool` -- defaults to `false`): Restart encoder on new track.
* `restart_encoder_delay` (`int` -- defaults to `-1`): Restart the encoder after this delay, in seconds.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `bitrate` (`int` -- defaults to `-1`): Bitrate information for icecast. Not used if negative.
* `quality` (`float` -- defaults to `-1.`): Quality information for icecast. Not used if negative.
* `channels` (`int` -- defaults to `-1`): Channels information for icecast. Not used if negative.
* `icy_metadata` (`bool` -- defaults to `true`): Send new metadata using the ICY protocol.
* `(unlabeled)` (`source`)

#### output.icecast.flac
```
(?id:string, ?start:bool, ?restart:bool,
 ?restart_delay:int, ?host:string, ?port:int,
 ?user:string, ?password:string, ?genre:string,
 ?url:string, ?description:string, ?public:bool,
 ?dumpfile:string, ?mount:string, ?name:string,
 ?protocol:string, ?flac:string, ?quality:int,
 ?restart_on_crash:bool, ?restart_on_new_track:bool,
 ?restart_encoder_delay:int, ?fallible:bool,
 ?on_start:(()->unit), ?on_stop:(()->unit), source)
 ->source```

Output to icecast using the flac command line encoder.

* `id` (`string` -- defaults to `&quot;output.icecast.flac&quot;`): Output's ID
* `start` (`bool` -- defaults to `true`): Start output threads on operator initialization.
* `restart` (`bool` -- defaults to `false`): Restart output after a failure. By default, liquidsoap will stop if the output failed.
* `restart_delay` (`int` -- defaults to `3`): Delay, in seconds, before attempting new connection, if restart is enabled.
* `host` (`string` -- defaults to `&quot;localhost&quot;`)
* `port` (`int` -- defaults to `8000`)
* `user` (`string` -- defaults to `&quot;source&quot;`): User for shout source connection. Useful only in special cases, like with per-mountpoint users.
* `password` (`string` -- defaults to `&quot;hackme&quot;`)
* `genre` (`string` -- defaults to `&quot;Misc&quot;`)
* `url` (`string` -- defaults to ```
&quot;&quot;http://savonet.sf.net&quot;:http://savonet.sf.net/&quot;```
)
* `description` (`string` -- defaults to `&quot;OCaml Radio!&quot;`)
* `public` (`bool` -- defaults to `true`)
* `dumpfile` (`string` -- defaults to `&quot;&quot;`): Dump stream to file, for debugging purpose. Disabled if empty.
* `mount` (`string` -- defaults to `&quot;Use [name]&quot;`)
* `name` (`string` -- defaults to `&quot;Use [mount]&quot;`)
* `protocol` (`string` -- defaults to `&quot;http&quot;`): Protocol of the streaming server: 'http' for Icecast, 'icy' for Shoutcast.
* `flac` (`string` -- defaults to `&quot;flac&quot;`): The flac binary
* `quality` (`int` -- defaults to `6`): Encoder quality (0..8)
* `restart_on_crash` (`bool` -- defaults to `false`): Restart external process on crash. If false, liquidsoap will stop.
* `restart_on_new_track` (`bool` -- defaults to `true`): Restart encoder upon new track. If false, the resulting stream will have a single track.
* `restart_encoder_delay` (`int` -- defaults to `-1`): Restart the encoder after this delay, in seconds.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `(unlabeled)` (`source`): The source to output

#### output.icecast.lame
```
(?id:string, ?start:bool, ?restart:bool,
 ?restart_delay:int, ?host:string, ?port:int,
 ?user:string, ?password:string, ?genre:string,
 ?url:string, ?description:string, ?public:bool,
 ?dumpfile:string, ?mount:string, ?name:string,
 ?protocol:string, ?lame:string, ?bitrate:int,
 ?swap:bool, ?fallible:bool, ?on_start:(()->unit),
 ?on_stop:(()->unit), ?restart_on_crash:bool,
 ?restart_on_new_track:bool,
 ?restart_encoder_delay:int,
 ?headers:[(string*string)], source)->source```

Output to icecast using the lame command line encoder.

* `id` (`string` -- defaults to `&quot;output.icecast.lame&quot;`): Output's ID
* `start` (`bool` -- defaults to `true`): Start output threads on operator initialization.
* `restart` (`bool` -- defaults to `false`): Restart output after a failure. By default, liquidsoap will stop if the output failed.
* `restart_delay` (`int` -- defaults to `3`): Delay, in seconds, before attempting new connection, if restart is enabled.
* `host` (`string` -- defaults to `&quot;localhost&quot;`)
* `port` (`int` -- defaults to `8000`)
* `user` (`string` -- defaults to `&quot;source&quot;`): User for shout source connection. Useful only in special cases, like with per-mountpoint users.
* `password` (`string` -- defaults to `&quot;hackme&quot;`)
* `genre` (`string` -- defaults to `&quot;Misc&quot;`)
* `url` (`string` -- defaults to ```
&quot;&quot;http://savonet.sf.net&quot;:http://savonet.sf.net/&quot;```
)
* `description` (`string` -- defaults to `&quot;OCaml Radio!&quot;`)
* `public` (`bool` -- defaults to `true`)
* `dumpfile` (`string` -- defaults to `&quot;&quot;`): Dump stream to file, for debugging purpose. Disabled if empty.
* `mount` (`string` -- defaults to `&quot;Use [name]&quot;`)
* `name` (`string` -- defaults to `&quot;Use [mount]&quot;`)
* `protocol` (`string` -- defaults to `&quot;http&quot;`): Protocol of the streaming server: 'http' for Icecast, 'icy' for Shoutcast.
* `lame` (`string` -- defaults to `&quot;lame&quot;`): The lame binary
* `bitrate` (`int` -- defaults to `128`): Encoder bitrate
* `swap` (`bool` -- defaults to `false`): Swap audio samples. Depends on local machine's endianess and lame's version. Test this parameter if you experience garbaged mp3 audio data. On intel 32 and 64 architectures, the parameter should be ``true'' for lame version >= 3.98.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `restart_on_crash` (`bool` -- defaults to `false`): Restart external process on crash. If false, liquidsoap will stop.
* `restart_on_new_track` (`bool` -- defaults to `false`): Restart encoder upon new track.
* `restart_encoder_delay` (`int` -- defaults to `3600`): Restart the encoder after this delay, in seconds.
* `headers` (`[(string*string)]` -- defaults to `[  ]`)
* `(unlabeled)` (`source`): The source to output

#### output.icecast.mp3
```
(?id:string, ?restart:bool, ?restart_delay:int,
 ?mount:string, ?name:string, ?protocol:string,
 ?host:string, ?port:int, ?user:string,
 ?password:string, ?genre:string, ?url:string,
 ?description:string, ?public:bool,
 ?headers:[(string*string)], ?format:string,
 ?dumpfile:string, ?fallible:bool,
 ?on_start:(()->unit), ?on_stop:(()->unit),
 ?start:bool, ?samplerate:int, ?bitrate:int,
 ?quality:int, ?stereo:bool, source)->source```

Output the source's stream to an icecast2-compatible server in MP3 format.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `restart` (`bool` -- defaults to `false`): Restart output after a failure. By default, liquidsoap will stop if the output failed.
* `restart_delay` (`int` -- defaults to `3`): Delay, in seconds, before attempting new connection, if restart is enabled.
* `mount` (`string` -- defaults to `&quot;Use [name]&quot;`)
* `name` (`string` -- defaults to `&quot;Use [mount]&quot;`)
* `protocol` (`string` -- defaults to `&quot;http&quot;`): Protocol of the streaming server: 'http' for Icecast, 'icy' for shoutcast.
* `host` (`string` -- defaults to `&quot;localhost&quot;`)
* `port` (`int` -- defaults to `8000`)
* `user` (`string` -- defaults to `&quot;source&quot;`): User for shout source connection. Useful only in special cases, like with per-mountpoint users.
* `password` (`string` -- defaults to `&quot;hackme&quot;`)
* `genre` (`string` -- defaults to `&quot;Misc&quot;`)
* `url` (`string` -- defaults to ```
&quot;&quot;http://savonet.sf.net&quot;:http://savonet.sf.net&quot;```
)
* `description` (`string` -- defaults to `&quot;OCaml Radio!&quot;`)
* `public` (`bool` -- defaults to `true`)
* `headers` (`[(string*string)]` -- defaults to `[  ]`): Additional headers.
* `format` (`string` -- defaults to `&quot;mp3&quot;`): Content-type (mime) for the format. ``mp3'' is a short-hand for mpeg audio, ``ogg'' for ogg data.
* `dumpfile` (`string` -- defaults to `&quot;&quot;`): Dump stream to file, for debugging purpose. Disabled if empty.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `samplerate` (`int` -- defaults to `44100`)
* `bitrate` (`int` -- defaults to `128`)
* `quality` (`int` -- defaults to `5`)
* `stereo` (`bool` -- defaults to `true`)
* `(unlabeled)` (`source`)

#### output.icecast.speex
```
(?id:string, ?samplerate:int, ?bitrate:int,
 ?quality:int, ?mode:string, ?stereo:bool,
 ?vbr:bool, ?frames_per_packet:int, ?complexity:int,
 ?abr:int, ?skeleton:bool, ?restart:bool,
 ?restart_delay:int, ?mount:string, ?name:string,
 ?protocol:string, ?host:string, ?port:int,
 ?user:string, ?password:string, ?genre:string,
 ?url:string, ?description:string, ?public:bool,
 ?headers:[(string*string)], ?format:string,
 ?dumpfile:string, ?fallible:bool,
 ?on_start:(()->unit), ?on_stop:(()->unit),
 ?start:bool, source)->source```

Output the source stream as an Ogg Speex stream to an Icecast-compatible server.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `samplerate` (`int` -- defaults to `-1`): Output sample rate. Use liquidsoap's default if <= 0.
* `bitrate` (`int` -- defaults to `-1`): Target bitrate (in kbps). Not used if <= 0.
* `quality` (`int` -- defaults to `7`): Target quality (0 to 10). Not used if <= 0.
* `mode` (`string` -- defaults to `&quot;narrowband&quot;`): Encoding mode, one of ``narrowband'', ``wideband'' or ``ultra-wideband''.
* `stereo` (`bool` -- defaults to `false`)
* `vbr` (`bool` -- defaults to `false`): Encode in vbr mode.
* `frames_per_packet` (`int` -- defaults to `1`): Number of frame per Ogg packet (1 to 10).
* `complexity` (`int` -- defaults to `-1`): Encoding complexity (0-10). Not used if <= 0.
* `abr` (`int` -- defaults to `-1`): Set average bitrate. Not used if <= 0.
* `skeleton` (`bool` -- defaults to `false`): Add an ogg skeleton to the stream. Recommended for theora only.
* `restart` (`bool` -- defaults to `false`): Restart output after a failure. By default, liquidsoap will stop if the output failed.
* `restart_delay` (`int` -- defaults to `3`): Delay, in seconds, before attempting new connection, if restart is enabled.
* `mount` (`string` -- defaults to `&quot;Use [name].ogg&quot;`)
* `name` (`string` -- defaults to `&quot;Use [mount]&quot;`)
* `protocol` (`string` -- defaults to `&quot;http&quot;`): Protocol of the streaming server: 'http' for Icecast, 'icy' for shoutcast.
* `host` (`string` -- defaults to `&quot;localhost&quot;`)
* `port` (`int` -- defaults to `8000`)
* `user` (`string` -- defaults to `&quot;source&quot;`): User for shout source connection. Useful only in special cases, like with per-mountpoint users.
* `password` (`string` -- defaults to `&quot;hackme&quot;`)
* `genre` (`string` -- defaults to `&quot;Misc&quot;`)
* `url` (`string` -- defaults to ```
&quot;&quot;http://savonet.sf.net&quot;:http://savonet.sf.net&quot;```
)
* `description` (`string` -- defaults to `&quot;OCaml Radio!&quot;`)
* `public` (`bool` -- defaults to `true`)
* `headers` (`[(string*string)]` -- defaults to `[  ]`): Additional headers.
* `format` (`string` -- defaults to `&quot;ogg&quot;`): Content-type (mime) for the format. ``mp3'' is a short-hand for mpeg audio, ``ogg'' for ogg data.
* `dumpfile` (`string` -- defaults to `&quot;&quot;`): Dump stream to file, for debugging purpose. Disabled if empty.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source`)

#### output.icecast.theora
```
(?id:string, ?quality:int, ?vorbis_quality:float,
 ?skeleton:bool, ?restart:bool, ?restart_delay:int,
 ?mount:string, ?name:string, ?protocol:string,
 ?host:string, ?port:int, ?user:string,
 ?password:string, ?genre:string, ?url:string,
 ?description:string, ?public:bool,
 ?headers:[(string*string)], ?format:string,
 ?dumpfile:string, ?fallible:bool,
 ?on_start:(()->unit), ?on_stop:(()->unit),
 ?start:bool, source)->source```

Output the source stream as an Ogg Theora stream to an Icecast-compatible.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `quality` (`int` -- defaults to `100`): Quality setting for theora encoding.
* `vorbis_quality` (`float` -- defaults to `2.`): Quality setting for vorbis encoding. Don't encode audio if value is negative or null.
* `skeleton` (`bool` -- defaults to `true`): Add an ogg skeleton to the stream. Recommended for theora only.
* `restart` (`bool` -- defaults to `false`): Restart output after a failure. By default, liquidsoap will stop if the output failed.
* `restart_delay` (`int` -- defaults to `3`): Delay, in seconds, before attempting new connection, if restart is enabled.
* `mount` (`string` -- defaults to `&quot;Use [name].ogg&quot;`)
* `name` (`string` -- defaults to `&quot;Use [mount]&quot;`)
* `protocol` (`string` -- defaults to `&quot;http&quot;`): Protocol of the streaming server: 'http' for Icecast, 'icy' for shoutcast.
* `host` (`string` -- defaults to `&quot;localhost&quot;`)
* `port` (`int` -- defaults to `8000`)
* `user` (`string` -- defaults to `&quot;source&quot;`): User for shout source connection. Useful only in special cases, like with per-mountpoint users.
* `password` (`string` -- defaults to `&quot;hackme&quot;`)
* `genre` (`string` -- defaults to `&quot;Misc&quot;`)
* `url` (`string` -- defaults to ```
&quot;&quot;http://savonet.sf.net&quot;:http://savonet.sf.net&quot;```
)
* `description` (`string` -- defaults to `&quot;OCaml Radio!&quot;`)
* `public` (`bool` -- defaults to `true`)
* `headers` (`[(string*string)]` -- defaults to `[  ]`): Additional headers.
* `format` (`string` -- defaults to `&quot;ogg&quot;`): Content-type (mime) for the format. ``mp3'' is a short-hand for mpeg audio, ``ogg'' for ogg data.
* `dumpfile` (`string` -- defaults to `&quot;&quot;`): Dump stream to file, for debugging purpose. Disabled if empty.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source`)

#### output.icecast.vorbis
```
(?id:string, ?samplerate:int, ?stereo:bool,
 ?skeleton:bool, ?restart:bool, ?restart_delay:int,
 ?mount:string, ?name:string, ?protocol:string,
 ?host:string, ?port:int, ?user:string,
 ?password:string, ?genre:string, ?url:string,
 ?description:string, ?public:bool,
 ?headers:[(string*string)], ?format:string,
 ?dumpfile:string, ?fallible:bool,
 ?on_start:(()->unit), ?on_stop:(()->unit),
 ?start:bool, source, ?quality:float)->source```

Output the source stream as an Ogg Vorbis stream to an Icecast-compatible server in Variable BitRate mode.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `samplerate` (`int` -- defaults to `44100`)
* `stereo` (`bool` -- defaults to `true`)
* `skeleton` (`bool` -- defaults to `false`): Add an ogg skeleton to the stream. Recommended for theora only.
* `restart` (`bool` -- defaults to `false`): Restart output after a failure. By default, liquidsoap will stop if the output failed.
* `restart_delay` (`int` -- defaults to `3`): Delay, in seconds, before attempting new connection, if restart is enabled.
* `mount` (`string` -- defaults to `&quot;Use [name].ogg&quot;`)
* `name` (`string` -- defaults to `&quot;Use [mount]&quot;`)
* `protocol` (`string` -- defaults to `&quot;http&quot;`): Protocol of the streaming server: 'http' for Icecast, 'icy' for shoutcast.
* `host` (`string` -- defaults to `&quot;localhost&quot;`)
* `port` (`int` -- defaults to `8000`)
* `user` (`string` -- defaults to `&quot;source&quot;`): User for shout source connection. Useful only in special cases, like with per-mountpoint users.
* `password` (`string` -- defaults to `&quot;hackme&quot;`)
* `genre` (`string` -- defaults to `&quot;Misc&quot;`)
* `url` (`string` -- defaults to ```
&quot;&quot;http://savonet.sf.net&quot;:http://savonet.sf.net&quot;```
)
* `description` (`string` -- defaults to `&quot;OCaml Radio!&quot;`)
* `public` (`bool` -- defaults to `true`)
* `headers` (`[(string*string)]` -- defaults to `[  ]`): Additional headers.
* `format` (`string` -- defaults to `&quot;ogg&quot;`): Content-type (mime) for the format. ``mp3'' is a short-hand for mpeg audio, ``ogg'' for ogg data.
* `dumpfile` (`string` -- defaults to `&quot;&quot;`): Dump stream to file, for debugging purpose. Disabled if empty.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source`)
* `quality` (`float` -- defaults to `2.`): Desired quality level, currently from -1. to 10. (low to high).

#### output.icecast.vorbis.abr
```
(?id:string, ?samplerate:int, ?stereo:bool,
 ?skeleton:bool, ?restart:bool, ?restart_delay:int,
 ?mount:string, ?name:string, ?protocol:string,
 ?host:string, ?port:int, ?user:string,
 ?password:string, ?genre:string, ?url:string,
 ?description:string, ?public:bool,
 ?headers:[(string*string)], ?format:string,
 ?dumpfile:string, ?fallible:bool,
 ?on_start:(()->unit), ?on_stop:(()->unit),
 ?start:bool, source, ?bitrate:int,
 ?min_bitrate:int, ?max_bitrate:int)->source```

Output the source stream as an Ogg Vorbis stream to an Icecast-compatible server in Average BitRate mode.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `samplerate` (`int` -- defaults to `44100`)
* `stereo` (`bool` -- defaults to `true`)
* `skeleton` (`bool` -- defaults to `false`): Add an ogg skeleton to the stream. Recommended for theora only.
* `restart` (`bool` -- defaults to `false`): Restart output after a failure. By default, liquidsoap will stop if the output failed.
* `restart_delay` (`int` -- defaults to `3`): Delay, in seconds, before attempting new connection, if restart is enabled.
* `mount` (`string` -- defaults to `&quot;Use [name].ogg&quot;`)
* `name` (`string` -- defaults to `&quot;Use [mount]&quot;`)
* `protocol` (`string` -- defaults to `&quot;http&quot;`): Protocol of the streaming server: 'http' for Icecast, 'icy' for shoutcast.
* `host` (`string` -- defaults to `&quot;localhost&quot;`)
* `port` (`int` -- defaults to `8000`)
* `user` (`string` -- defaults to `&quot;source&quot;`): User for shout source connection. Useful only in special cases, like with per-mountpoint users.
* `password` (`string` -- defaults to `&quot;hackme&quot;`)
* `genre` (`string` -- defaults to `&quot;Misc&quot;`)
* `url` (`string` -- defaults to ```
&quot;&quot;http://savonet.sf.net&quot;:http://savonet.sf.net&quot;```
)
* `description` (`string` -- defaults to `&quot;OCaml Radio!&quot;`)
* `public` (`bool` -- defaults to `true`)
* `headers` (`[(string*string)]` -- defaults to `[  ]`): Additional headers.
* `format` (`string` -- defaults to `&quot;ogg&quot;`): Content-type (mime) for the format. ``mp3'' is a short-hand for mpeg audio, ``ogg'' for ogg data.
* `dumpfile` (`string` -- defaults to `&quot;&quot;`): Dump stream to file, for debugging purpose. Disabled if empty.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source`)
* `bitrate` (`int` -- defaults to `128`): Target bitrate (in kbps).
* `min_bitrate` (`int` -- defaults to `118`): Minimum bitrate (in kbps).
* `max_bitrate` (`int` -- defaults to `138`): Maximum bitrate (in kbps).

#### output.icecast.vorbis.cbr
```
(?id:string, ?samplerate:int, ?stereo:bool,
 ?skeleton:bool, ?restart:bool, ?restart_delay:int,
 ?mount:string, ?name:string, ?protocol:string,
 ?host:string, ?port:int, ?user:string,
 ?password:string, ?genre:string, ?url:string,
 ?description:string, ?public:bool,
 ?headers:[(string*string)], ?format:string,
 ?dumpfile:string, ?fallible:bool,
 ?on_start:(()->unit), ?on_stop:(()->unit),
 ?start:bool, source, ?bitrate:int)->source```

Output the source stream as an Ogg Vorbis stream to an Icecast-compatible server in Constant BitRate mode.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `samplerate` (`int` -- defaults to `44100`)
* `stereo` (`bool` -- defaults to `true`)
* `skeleton` (`bool` -- defaults to `false`): Add an ogg skeleton to the stream. Recommended for theora only.
* `restart` (`bool` -- defaults to `false`): Restart output after a failure. By default, liquidsoap will stop if the output failed.
* `restart_delay` (`int` -- defaults to `3`): Delay, in seconds, before attempting new connection, if restart is enabled.
* `mount` (`string` -- defaults to `&quot;Use [name].ogg&quot;`)
* `name` (`string` -- defaults to `&quot;Use [mount]&quot;`)
* `protocol` (`string` -- defaults to `&quot;http&quot;`): Protocol of the streaming server: 'http' for Icecast, 'icy' for shoutcast.
* `host` (`string` -- defaults to `&quot;localhost&quot;`)
* `port` (`int` -- defaults to `8000`)
* `user` (`string` -- defaults to `&quot;source&quot;`): User for shout source connection. Useful only in special cases, like with per-mountpoint users.
* `password` (`string` -- defaults to `&quot;hackme&quot;`)
* `genre` (`string` -- defaults to `&quot;Misc&quot;`)
* `url` (`string` -- defaults to ```
&quot;&quot;http://savonet.sf.net&quot;:http://savonet.sf.net&quot;```
)
* `description` (`string` -- defaults to `&quot;OCaml Radio!&quot;`)
* `public` (`bool` -- defaults to `true`)
* `headers` (`[(string*string)]` -- defaults to `[  ]`): Additional headers.
* `format` (`string` -- defaults to `&quot;ogg&quot;`): Content-type (mime) for the format. ``mp3'' is a short-hand for mpeg audio, ``ogg'' for ogg data.
* `dumpfile` (`string` -- defaults to `&quot;&quot;`): Dump stream to file, for debugging purpose. Disabled if empty.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source`)
* `bitrate` (`int` -- defaults to `128`): Bitrate (in kbps).

#### output.jack
```
(?id:string, ?fallible:bool, ?on_start:(()->unit),
 ?on_stop:(()->unit), ?start:bool, ?buffer_size:int,
 ?server:string, source)->source```

Output stream to jack.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `buffer_size` (`int` -- defaults to `2`): Set buffer size, in frames.
* `server` (`string` -- defaults to `&quot;&quot;`): Jack server to connect to.
* `(unlabeled)` (`source`)

#### output.jack.legacy
```
(?id:string, ?ports:[string], ?synchronize:bool,
 source)->source```

WARNING: This is DEPRECATED!

Deprecated jack output.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `ports` (`[string]` -- defaults to ```
[ &quot;output_0&quot;, &quot;output_1&quot; ]```
): Port names.
* `synchronize` (`bool` -- defaults to `true`): Synchronize on jack output.
* `(unlabeled)` (`source`)

#### output.marshal
```
(?id:string, ?reopen:bool, string, source)->source```

WARNING: This is only EXPERIMENTAL!

Output the source's stream to a pipe using marshaling.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `reopen` (`bool` -- defaults to `false`): Try to reopen the pipe after a failure.
* `(unlabeled)` (`string`): Pipe to send the stream to.
* `(unlabeled)` (`source`)

#### output.oss
```
(?id:string, ?device:string, source)->source```

Output the source's stream to an OSS output device.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `device` (`string` -- defaults to `&quot;/dev/dsp&quot;`): OSS device to use.
* `(unlabeled)` (`source`)

#### output.pipe.external
```
(?id:string, ?start:bool,
 ~process:(([(string*string)])->string),
 ?samplerate:int, ?header:bool,
 ?restart_on_crash:bool, ?restart_on_new_track:bool,
 ?restart_encoder_delay:int, ?fallible:bool,
 ?on_start:(()->unit), ?on_stop:(()->unit),
 ?start:bool, source)->source```

Output the source's stream to an external process.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `start` (`bool` -- defaults to `true`): Start output threads on operator initialization.
* `process` (`([(string*string)])-&gt;string`): External encoding process. Takes initial metadata and return the command to start.
* `samplerate` (`int` -- defaults to `44100`): Output sample rate.
* `header` (`bool` -- defaults to `true`): Write wav header at beginning of encoded input.
* `restart_on_crash` (`bool` -- defaults to `false`): Restart external process when it crashed. If false, liquidsoap exits.
* `restart_on_new_track` (`bool` -- defaults to `false`): Restart encoder on new track.
* `restart_encoder_delay` (`int` -- defaults to `-1`): Restart the encoder after this delay, in seconds.
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `start` (`bool` -- defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
* `(unlabeled)` (`source`)

#### output.portaudio
```
(?id:string, ?buflen:int, source)->source```

Output the source's stream to a portaudio output device.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `buflen` (`int` -- defaults to `256`): Length of a buffer in samples.
* `(unlabeled)` (`source`)

#### output.prefered
```
(?id:string, source)->source```

Output to local audio card using the first available driver in this list:
ao, pulseaudio, alsa, oss, dummy

* `id` (`string` -- defaults to `&quot;&quot;`)
* `(unlabeled)` (`source`)

#### output.pulseaudio
```
(?id:string, ?client:string, ?device:string, source)
 ->source```

Output the source's stream to a portaudio output device.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `client` (`string` -- defaults to `&quot;liquidsoap&quot;`)
* `device` (`string` -- defaults to `&quot;&quot;`): Device to use. Uses default if set to ``''.
* `(unlabeled)` (`source`)

#### output.shoutcast.aacplus
```
(?id:string, ?start:bool, ?restart:bool,
 ?restart_delay:int, ?host:string, ?port:int,
 ?user:string, ?password:string, ?genre:string,
 ?url:string, ?description:string, ?public:bool,
 ?dumpfile:string, ?name:string, ?aim:string,
 ?icq:string, ?irc:string, ?icy_reset:bool,
 ?bitrate:int, ?samplerate:int, ?fallible:bool,
 ?on_start:(()->unit), ?on_stop:(()->unit),
 ?format:string, source)->source```

Output to shoutcast using the AAC+ format.

* `id` (`string` -- defaults to `&quot;output.shoutcast.aacplus&quot;`): Output's ID
* `start` (`bool` -- defaults to `true`): Start output threads on operator initialization.
* `restart` (`bool` -- defaults to `false`): Restart output after a failure. By default, liquidsoap will stop if the output failed.
* `restart_delay` (`int` -- defaults to `3`): Delay, in seconds, before attempting new connection, if restart is enabled.
* `host` (`string` -- defaults to `&quot;localhost&quot;`)
* `port` (`int` -- defaults to `8000`)
* `user` (`string` -- defaults to `&quot;source&quot;`): User for shout source connection. Useful only in special cases, like with per-mountpoint users.
* `password` (`string` -- defaults to `&quot;hackme&quot;`)
* `genre` (`string` -- defaults to `&quot;Misc&quot;`)
* `url` (`string` -- defaults to ```
&quot;&quot;http://savonet.sf.net&quot;:http://savonet.sf.net/&quot;```
)
* `description` (`string` -- defaults to `&quot;OCaml Radio!&quot;`)
* `public` (`bool` -- defaults to `true`)
* `dumpfile` (`string` -- defaults to `&quot;&quot;`): Dump stream to file, for debugging purpose. Disabled if empty.
* `name` (`string` -- defaults to `&quot;Use [mount]&quot;`)
* `aim` (`string` -- defaults to `&quot;&quot;`)
* `icq` (`string` -- defaults to `&quot;&quot;`)
* `irc` (`string` -- defaults to `&quot;&quot;`)
* `icy_reset` (`bool` -- defaults to `true`): Reset shoutcast source buffer upon connecting (necessary for NSV).
* `bitrate` (`int` -- defaults to `64`): Encoder bitrate
* `samplerate` (`int` -- defaults to `44100`)
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `format` (`string` -- defaults to `&quot;audio/aacp&quot;`)
* `(unlabeled)` (`source`): The source to output

#### output.shoutcast.aacplusenc
```
(?id:string, ?start:bool, ?restart:bool,
 ?restart_delay:int, ?host:string, ?port:int,
 ?user:string, ?password:string, ?genre:string,
 ?url:string, ?description:string, ?public:bool,
 ?fallible:bool, ?on_start:(()->unit),
 ?on_stop:(()->unit), ?dumpfile:string,
 ?name:string, ?icy_reset:bool, ?aim:string,
 ?icq:string, ?irc:string, ?aacplusenc:string,
 ?restart_on_crash:bool, ?restart_on_new_track:bool,
 ?restart_encoder_delay:int, ?bitrate:int, source)
 ->source```

Output to shoutcast using the aacplusenc encoder.

* `id` (`string` -- defaults to `&quot;output.shoutcast.aacplusenc&quot;`): Output's ID
* `start` (`bool` -- defaults to `true`): Start output threads on operator initialization.
* `restart` (`bool` -- defaults to `false`): Restart output after a failure. By default, liquidsoap will stop if the output failed.
* `restart_delay` (`int` -- defaults to `3`): Delay, in seconds, before attempting new connection, if restart is enabled.
* `host` (`string` -- defaults to `&quot;localhost&quot;`)
* `port` (`int` -- defaults to `8000`)
* `user` (`string` -- defaults to `&quot;source&quot;`): User for shout source connection. Useful only in special cases, like with per-mountpoint users.
* `password` (`string` -- defaults to `&quot;hackme&quot;`)
* `genre` (`string` -- defaults to `&quot;Misc&quot;`)
* `url` (`string` -- defaults to ```
&quot;&quot;http://savonet.sf.net&quot;:http://savonet.sf.net/&quot;```
)
* `description` (`string` -- defaults to `&quot;OCaml Radio!&quot;`)
* `public` (`bool` -- defaults to `true`)
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `dumpfile` (`string` -- defaults to `&quot;&quot;`): Dump stream to file, for debugging purpose. Disabled if empty.
* `name` (`string` -- defaults to `&quot;Use [mount]&quot;`)
* `icy_reset` (`bool` -- defaults to `true`): Reset shoutcast source buffer upon connecting (necessary for NSV).
* `aim` (`string` -- defaults to `&quot;&quot;`)
* `icq` (`string` -- defaults to `&quot;&quot;`)
* `irc` (`string` -- defaults to `&quot;&quot;`)
* `aacplusenc` (`string` -- defaults to `&quot;aacplusenc&quot;`): The aacplusenc binary
* `restart_on_crash` (`bool` -- defaults to `false`): Restart external process on crash. If false, liquidsoap will stop.
* `restart_on_new_track` (`bool` -- defaults to `false`): Restart encoder upon new track.
* `restart_encoder_delay` (`int` -- defaults to `3600`): Restart the encoder after this delay, in seconds.
* `bitrate` (`int` -- defaults to `64`): Encoder bitrate
* `(unlabeled)` (`source`): The source to output

#### output.shoutcast.lame
```
(?id:string, ?start:bool, ?restart:bool,
 ?restart_delay:int, ?host:string, ?port:int,
 ?user:string, ?password:string, ?genre:string,
 ?url:string, ?description:string, ?public:bool,
 ?dumpfile:string, ?name:string, ?icy_reset:bool,
 ?lame:string, ?aim:string, ?icq:string,
 ?irc:string, ?fallible:bool, ?on_start:(()->unit),
 ?on_stop:(()->unit), ?restart_on_crash:bool,
 ?restart_on_new_track:bool,
 ?restart_encoder_delay:int, ?bitrate:int, source)
 ->source```

Output to shoutcast using the lame encoder.

* `id` (`string` -- defaults to `&quot;output.shoutcast.mp3&quot;`): Output's ID
* `start` (`bool` -- defaults to `true`): Start output threads on operator initialization.
* `restart` (`bool` -- defaults to `false`): Restart output after a failure. By default, liquidsoap will stop if the output failed.
* `restart_delay` (`int` -- defaults to `3`): Delay, in seconds, before attempting new connection, if restart is enabled.
* `host` (`string` -- defaults to `&quot;localhost&quot;`)
* `port` (`int` -- defaults to `8000`)
* `user` (`string` -- defaults to `&quot;source&quot;`): User for shout source connection. Useful only in special cases, like with per-mountpoint users.
* `password` (`string` -- defaults to `&quot;hackme&quot;`)
* `genre` (`string` -- defaults to `&quot;Misc&quot;`)
* `url` (`string` -- defaults to ```
&quot;&quot;http://savonet.sf.net&quot;:http://savonet.sf.net/&quot;```
)
* `description` (`string` -- defaults to `&quot;OCaml Radio!&quot;`)
* `public` (`bool` -- defaults to `true`)
* `dumpfile` (`string` -- defaults to `&quot;&quot;`): Dump stream to file, for debugging purpose. Disabled if empty.
* `name` (`string` -- defaults to `&quot;Use [mount]&quot;`)
* `icy_reset` (`bool` -- defaults to `true`): Reset shoutcast source buffer upon connecting (necessary for NSV).
* `lame` (`string` -- defaults to `&quot;lame&quot;`): The lame binary
* `aim` (`string` -- defaults to `&quot;&quot;`)
* `icq` (`string` -- defaults to `&quot;&quot;`)
* `irc` (`string` -- defaults to `&quot;&quot;`)
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `restart_on_crash` (`bool` -- defaults to `false`): Restart external process on crash. If false, liquidsoap will stop.
* `restart_on_new_track` (`bool` -- defaults to `false`): Restart encoder upon new track.
* `restart_encoder_delay` (`int` -- defaults to `3600`): Restart the encoder after this delay, in seconds.
* `bitrate` (`int` -- defaults to `128`): Encoder bitrate
* `(unlabeled)` (`source`): The source to output

#### output.shoutcast.mp3
```
(?id:string, ?start:bool, ?restart:bool,
 ?restart_delay:int, ?host:string, ?port:int,
 ?user:string, ?password:string, ?genre:string,
 ?url:string, ?description:string, ?public:bool,
 ?dumpfile:string, ?name:string, ?aim:string,
 ?icq:string, ?irc:string, ?icy_reset:bool,
 ?bitrate:int, ?samplerate:int, ?stereo:bool,
 ?fallible:bool, ?on_start:(()->unit),
 ?on_stop:(()->unit), source)->source```

Output to shoutcast using the MP3 format.

* `id` (`string` -- defaults to `&quot;output.shoutcast.mp3&quot;`): Output's ID
* `start` (`bool` -- defaults to `true`): Start output threads on operator initialization.
* `restart` (`bool` -- defaults to `false`): Restart output after a failure. By default, liquidsoap will stop if the output failed.
* `restart_delay` (`int` -- defaults to `3`): Delay, in seconds, before attempting new connection, if restart is enabled.
* `host` (`string` -- defaults to `&quot;localhost&quot;`)
* `port` (`int` -- defaults to `8000`)
* `user` (`string` -- defaults to `&quot;source&quot;`): User for shout source connection. Useful only in special cases, like with per-mountpoint users.
* `password` (`string` -- defaults to `&quot;hackme&quot;`)
* `genre` (`string` -- defaults to `&quot;Misc&quot;`)
* `url` (`string` -- defaults to ```
&quot;&quot;http://savonet.sf.net&quot;:http://savonet.sf.net/&quot;```
)
* `description` (`string` -- defaults to `&quot;OCaml Radio!&quot;`)
* `public` (`bool` -- defaults to `true`)
* `dumpfile` (`string` -- defaults to `&quot;&quot;`): Dump stream to file, for debugging purpose. Disabled if empty.
* `name` (`string` -- defaults to `&quot;Use [mount]&quot;`)
* `aim` (`string` -- defaults to `&quot;&quot;`)
* `icq` (`string` -- defaults to `&quot;&quot;`)
* `irc` (`string` -- defaults to `&quot;&quot;`)
* `icy_reset` (`bool` -- defaults to `true`): Reset shoutcast source buffer upon connecting (necessary for NSV).
* `bitrate` (`int` -- defaults to `128`): Encoder bitrate
* `samplerate` (`int` -- defaults to `44100`)
* `stereo` (`bool` -- defaults to `true`)
* `fallible` (`bool` -- defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
* `on_start` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting starts.
* `on_stop` (`()-&gt;unit` -- defaults to `{()}`): Callback executed when outputting stops.
* `(unlabeled)` (`source`): The source to output

Source / Sound Processing
-------------------------
#### accelerate
```
(?id:string, float, ?before:float, ?after:float,
 source)->source```

WARNING: This is only EXPERIMENTAL!

Accelerates a stream, possibly only the middle of the tracks. Useful for testing transitions.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `(unlabeled)` (`float`)
* `before` (`float` -- defaults to `10.`): Do not accelerate during that period of time at the beginning of a track.
* `after` (`float` -- defaults to `10.`): Do not accelerate during that period of time before the end of a track.
* `(unlabeled)` (`source`)

#### add
```
(?id:string, ?normalize:bool, ?weights:[int],
 [source])->source```

Mix sources, with optional normalization. Only relay metadata from the first source that is effectively summed.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `normalize` (`bool` -- defaults to `true`)
* `weights` (`[int]` -- defaults to `[  ]`): Relative weight of the sources in the sum. The empty list stands for the homogeneous distribution.
* `(unlabeled)` (`[source]`)

#### amplify
```
(?id:string, 'a, ?override:string,
 source)->source where 'a is either float or ()
 ->float```

Multiply the amplitude of the signal.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `(unlabeled)` (```
anything that is either float or ()-&gt;float```
): Multiplicative factor.
* `override` (`string` -- defaults to `&quot;liq_amplify&quot;`): Specify the name of a metadata field that, when present and well-formed, overrides the amplification factor for the current track. Well-formed values are floats in decimal notation (e.g. '0.7') which are taken as normal/linear multiplicative factors; values can be passed in decibels with the suffix 'dB' (e.g. '-8.2 dB', but the spaces do not matter).
* `(unlabeled)` (`source`)

#### bpm
```
(?id:string, ?every:int, source)->source```

WARNING: This is only EXPERIMENTAL!

Detect the BPM.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `every` (`int` -- defaults to `500`)
* `(unlabeled)` (`source`)

#### clip
```
(?id:string, ?min:float, ?max:float, source)
 ->source```

Clip sound.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `min` (`float` -- defaults to `-0.999`): Minimal acceptable value.
* `max` (`float` -- defaults to `0.999`): Maximal acceptable value.
* `(unlabeled)` (`source`)

#### comb
```
(?id:string, ?delay:float, ?feedback:'a,
 source)->source where 'a is either float or ()
 ->float```

Comb filter.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `delay` (`float` -- defaults to `0.001`): Delay in seconds.
* `feedback` (```
anything that is either float or ()-&gt;float```
 -- defaults to `-6.`): Feedback coefficient in dB.
* `(unlabeled)` (`source`)

#### compand
```
(?id:string, ?mu:float, source)->source```

Compand the signal

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `mu` (`float` -- defaults to `1.`)
* `(unlabeled)` (`source`)

#### compress
```
(?id:string, ?ratio:float, ?attack:'a, ?release:'b,
 ?threshold:'c, ?knee:'d, ?rms_window:float,
 ?gain:'e, ?debug:bool, source)->source where 'a,
 'b, 'c, 'd, 'e is either float or ()->float```

Compress the signal.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `ratio` (`float` -- defaults to `2.`): Gain reduction ratio (n:1).
* `attack` (```
anything that is either float or ()-&gt;float```
 -- defaults to `100.`): Attack time (ms).
* `release` (```
anything that is either float or ()-&gt;float```
 -- defaults to `400.`): Release time (ms).
* `threshold` (```
anything that is either float or ()-&gt;float```
 -- defaults to `-10.`): Threshold level (dB).
* `knee` (```
anything that is either float or ()-&gt;float```
 -- defaults to `1.`): Knee radius (dB).
* `rms_window` (`float` -- defaults to `0.1`): Window for computing RMS (in sec).
* `gain` (```
anything that is either float or ()-&gt;float```
 -- defaults to `0.`): Additional gain (dB).
* `debug` (`bool` -- defaults to `false`)
* `(unlabeled)` (`source`)

#### compress.exponential
```
(?id:string, ?mu:float, source)->source```

Exponential compressor.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `mu` (`float` -- defaults to `2.`): Exponential compression factor, typically greater than 1.
* `(unlabeled)` (`source`)

#### cross
```
(?id:string, ?duration:float, ?override:string,
 ?inhibit:float, ?minimum:float, ?conservative:bool,
 ((source, source)->source), source)->source```

Generic cross operator, allowing the composition of the N last seconds of a track with the beginning of the next track.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `duration` (`float` -- defaults to `5.`): Duration in seconds of the crossed end of track. This value can be changed on a per-file basis using a special metadata field.
* `override` (`string` -- defaults to `&quot;liq_start_next&quot;`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
* `inhibit` (`float` -- defaults to `-1.`): Minimum delay between two transitions. It is useful in order to avoid that a transition is triggered on top of another when an end-of-track occurs in the first one. Negative values mean `duration+1`. Warning: zero inhibition can cause infinite loops.
* `minimum` (`float` -- defaults to `-1.`): Minimum duration (in sec.) for a cross: If the track ends without any warning (e.g. in case of skip) there may not be enough data for a decent composition. Set to 0. to avoid having transitions after skips, or more to avoid transitions on short tracks. With the negative default, transitions always occur.
* `conservative` (`bool` -- defaults to `false`): Do not trust remaining time estimations, always buffering data in advance. This avoids being tricked by skips, either manual or caused by skip_blank().
* `(unlabeled)` (`(source, source)-&gt;source`): Composition of an end of track and the next track.
* `(unlabeled)` (`source`)

#### echo
```
(?id:string, ?delay:float, ?feedback:'a,
 source)->source where 'a is either float or ()
 ->float```

Add echo.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `delay` (`float` -- defaults to `0.5`): Delay in seconds.
* `feedback` (```
anything that is either float or ()-&gt;float```
 -- defaults to `-6.`): Feedback coefficient in dB (negative).
* `(unlabeled)` (`source`)

#### fade.final
```
(?id:string, ?duration:float, ?type:string, source)
 ->source```

Fade a stream to silence.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `duration` (`float` -- defaults to `3.`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `(unlabeled)` (`source`)

#### fade.in
```
(?id:string, ?override:string, ?duration:float,
 ?type:string, source)->source```

Fade the beginning of tracks. Metadata 'liq_fade_in' can be used to set the duration for a specific track (float in seconds).

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `override` (`string` -- defaults to `&quot;liq_fade_in&quot;`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
* `duration` (`float` -- defaults to `3.`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `(unlabeled)` (`source`)

#### fade.initial
```
(?id:string, ?duration:float, ?type:string, source)
 ->source```

Fade the beginning of a stream.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `duration` (`float` -- defaults to `3.`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `(unlabeled)` (`source`)

#### fade.out
```
(?id:string, ?override:string, ?duration:float,
 ?type:string, source)->source```

Fade the end of tracks. Metadata 'liq_fade_out' can be used to set the duration for a specific track (float in seconds).

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `override` (`string` -- defaults to `&quot;liq_fade_out&quot;`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
* `duration` (`float` -- defaults to `3.`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `(unlabeled)` (`source`)

#### filter
```
(?id:string, ~freq:'a, ?q:'b, ~mode:string,
 ?wetness:'c, source)->source where 'a, 'b,
 'c is either float or ()->float```

Perform several kinds of filtering on the signal

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `freq` (```
anything that is either float or ()-&gt;float```
)
* `q` (```
anything that is either float or ()-&gt;float```
 -- defaults to `1.`)
* `mode` (`string`): Available modes are 'low', 'high', 'band' and 'notch'.
* `wetness` (```
anything that is either float or ()-&gt;float```
 -- defaults to `1.`): How much of the original signal should be added (1. means only filtered and 0. means only original signal).
* `(unlabeled)` (`source`)

#### filter.fir
```
(?id:string, ~frequency:float, ~beta:float,
 ?coeffs:int, ?debug:bool, source)->source```

Low-pass FIR filter.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency in Hz (frequency at which the response is 0.5, that is -6 dB).
* `beta` (`float`): Beta should range between 0 and 1.
* `coeffs` (`int` -- defaults to `255`): Number of coefficients
* `debug` (`bool` -- defaults to `false`): Debug output
* `(unlabeled)` (`source`)

#### filter.iir.butterworth.bandpass
```
(?id:string, ~frequency1:float, ~frequency2:float,
 ?order:int, ?debug:bool, source)->source```

IIR filter

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `frequency1` (`float`): First corner frequency
* `frequency2` (`float`): Second corner frequency
* `order` (`int` -- defaults to `4`): Filter order
* `debug` (`bool` -- defaults to `false`): Debug output
* `(unlabeled)` (`source`)

#### filter.iir.butterworth.bandstop
```
(?id:string, ~frequency1:float, ~frequency2:float,
 ?order:int, ?debug:bool, source)->source```

IIR filter

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `frequency1` (`float`): First corner frequency
* `frequency2` (`float`): Second corner frequency
* `order` (`int` -- defaults to `4`): Filter order
* `debug` (`bool` -- defaults to `false`): Debug output
* `(unlabeled)` (`source`)

#### filter.iir.butterworth.high
```
(?id:string, ~frequency:float, ?order:int,
 ?debug:bool, source)->source```

IIR filter

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `order` (`int` -- defaults to `4`): Filter order
* `debug` (`bool` -- defaults to `false`): Debug output
* `(unlabeled)` (`source`)

#### filter.iir.butterworth.low
```
(?id:string, ~frequency:float, ?order:int,
 ?debug:bool, source)->source```

IIR filter

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `order` (`int` -- defaults to `4`): Filter order
* `debug` (`bool` -- defaults to `false`): Debug output
* `(unlabeled)` (`source`)

#### filter.iir.eq.allpass
```
(?id:string, ~frequency:float, ?bandwidth:float,
 ?debug:bool, source)->source```

All pass biquad filter.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `frequency` (`float`): Center frequency
* `bandwidth` (`float` -- defaults to `0.333333333333`): Bandwidth (in octaves)
* `debug` (`bool` -- defaults to `false`): Debug output
* `(unlabeled)` (`source`)

#### filter.iir.eq.bandpass
```
(?id:string, ~frequency:float, ?q:float,
 ?debug:bool, source)->source```

Band pass biquad filter.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `frequency` (`float`): Center frequency
* `q` (`float` -- defaults to `1.`): Q
* `debug` (`bool` -- defaults to `false`): Debug output
* `(unlabeled)` (`source`)

#### filter.iir.eq.high
```
(?id:string, ~frequency:float, ?q:float,
 ?debug:bool, source)->source```

High pass biquad filter.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `q` (`float` -- defaults to `1.`): Q
* `debug` (`bool` -- defaults to `false`): Debug output
* `(unlabeled)` (`source`)

#### filter.iir.eq.highshelf
```
(?id:string, ~frequency:float, ?slope:float,
 ?debug:bool, source)->source```

High shelf biquad filter.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `frequency` (`float`): Center frequency
* `slope` (`float` -- defaults to `1.`): Shelf slope (in dB/octave)
* `debug` (`bool` -- defaults to `false`): Debug output
* `(unlabeled)` (`source`)

#### filter.iir.eq.low
```
(?id:string, ~frequency:float, ?q:float,
 ?debug:bool, source)->source```

Low pass biquad filter.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `q` (`float` -- defaults to `1.`): Q
* `debug` (`bool` -- defaults to `false`): Debug output
* `(unlabeled)` (`source`)

#### filter.iir.eq.lowshelf
```
(?id:string, ~frequency:float, ?slope:float,
 ?debug:bool, source)->source```

Low shelf biquad filter.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `slope` (`float` -- defaults to `1.`): Shelf slope (dB/octave)
* `debug` (`bool` -- defaults to `false`): Debug output
* `(unlabeled)` (`source`)

#### filter.iir.eq.notch
```
(?id:string, ~frequency:float, ?q:float,
 ?debug:bool, source)->source```

Band pass biquad filter.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `frequency` (`float`): Center frequency
* `q` (`float` -- defaults to `1.`): Q
* `debug` (`bool` -- defaults to `false`): Debug output
* `(unlabeled)` (`source`)

#### filter.iir.eq.peak
```
(?id:string, ~frequency:float, ?q:float,
 ?gain:float, ?debug:bool, source)->source```

Peak EQ biquad filter.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `frequency` (`float`): Center frequency
* `q` (`float` -- defaults to `1.`): Q
* `gain` (`float` -- defaults to `1.`): Gain (in dB)
* `debug` (`bool` -- defaults to `false`): Debug output
* `(unlabeled)` (`source`)

#### filter.iir.resonator.allpass
```
(?id:string, ~frequency:float, ?q:float,
 ?debug:bool, source)->source```

IIR filter

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `q` (`float` -- defaults to `60.`): Quality factor
* `debug` (`bool` -- defaults to `false`): Debug output
* `(unlabeled)` (`source`)

#### filter.iir.resonator.bandpass
```
(?id:string, ~frequency:float, ?q:float,
 ?debug:bool, source)->source```

IIR filter

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `q` (`float` -- defaults to `60.`): Quality factor
* `debug` (`bool` -- defaults to `false`): Debug output
* `(unlabeled)` (`source`)

#### filter.iir.resonator.bandstop
```
(?id:string, ~frequency:float, ?q:float,
 ?debug:bool, source)->source```

IIR filter

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `frequency` (`float`): Corner frequency
* `q` (`float` -- defaults to `60.`): Quality factor
* `debug` (`bool` -- defaults to `false`): Debug output
* `(unlabeled)` (`source`)

#### flanger
```
(?id:string, ?delay:float, ?freq:'a, ?feedback:'b,
 ?phase:'c, source)->source where 'a, 'b,
 'c is either float or ()->float```

Flanger effect.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `delay` (`float` -- defaults to `0.001`): Delay in seconds.
* `freq` (```
anything that is either float or ()-&gt;float```
 -- defaults to `0.5`): Frequency in Hz.
* `feedback` (```
anything that is either float or ()-&gt;float```
 -- defaults to `0.`): Feedback coefficient in dB.
* `phase` (```
anything that is either float or ()-&gt;float```
 -- defaults to `1.`): Phasse difference between channels in radians.
* `(unlabeled)` (`source`)

#### helium
```
(source)->source```

Increases the pitch, making voices sound like on helium.

* `(unlabeled)` (`source`): The input source.

#### insert_metadata
```
(?id:string, source)->source```

Interactively insert metadata using the command `ID.insert key1="val1",key2="val2",...`.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `(unlabeled)` (`source`)

#### lag
```
(?id:string, float, source)->source```

Add a constant delay to a stream, filling with blank when not available. This operator should be used just before the final output.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `(unlabeled)` (`float`): Delay in seconds.
* `(unlabeled)` (`source`): Original source. Must be infaillible.

#### limit
```
(?id:string, ?ratio:float, ?attack:'a, ?release:'b,
 ?threshold:'c, ?knee:'d, ?rms_window:float,
 ?gain:'e, ?debug:bool, source)->source where 'a,
 'b, 'c, 'd, 'e is either float or ()->float```

Limit the signal.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `ratio` (`float` -- defaults to `20.`): Gain reduction ratio (n:1).
* `attack` (```
anything that is either float or ()-&gt;float```
 -- defaults to `100.`): Attack time (ms).
* `release` (```
anything that is either float or ()-&gt;float```
 -- defaults to `400.`): Release time (ms).
* `threshold` (```
anything that is either float or ()-&gt;float```
 -- defaults to `-10.`): Threshold level (dB).
* `knee` (```
anything that is either float or ()-&gt;float```
 -- defaults to `1.`): Knee radius (dB).
* `rms_window` (`float` -- defaults to `0.1`): Window for computing RMS (in sec).
* `gain` (```
anything that is either float or ()-&gt;float```
 -- defaults to `0.`): Additional gain (dB).
* `debug` (`bool` -- defaults to `false`)
* `(unlabeled)` (`source`)

#### mean
```
(?id:string, ?channels:[int], source)->source```

Compute the mean of a list of audio channels and use it for all of them.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `channels` (`[int]` -- defaults to `[ 0, 1 ]`): List of channels to compute the means.
* `(unlabeled)` (`source`)

#### mic_filter
```
(source)->source```

Remove low frequencies often produced by microphones.

* `(unlabeled)` (`source`): The input source.

#### mix
```
(?id:string, [source])->source```

Mixing table controllable via the telnet interface.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `(unlabeled)` (`[source]`)

#### normalize
```
(?id:string, ?target:'a, ?window:float, ?k_up:'b,
 ?k_down:'c, ?threshold:'d, ?gain_min:'e,
 ?gain_max:'f, ?debug:bool,
 source)->source where 'a, 'b, 'c, 'd, 'e,
 'f is either float or ()->float```

Normalize the signal. Dynamic normalization of the signal is sometimes the only option, and can make a listening experience much nicer. However, its dynamic aspect implies some limitations which can go as far as creating saturation in some extreme cases. If possible, consider using some track-based normalization techniques such as those based on replay gain. See the documentation for more details.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `target` (```
anything that is either float or ()-&gt;float```
 -- defaults to `-13.`): Desired RMS (dB).
* `window` (`float` -- defaults to `0.1`): Duration of the window used to compute the current RMS power (second).
* `k_up` (```
anything that is either float or ()-&gt;float```
 -- defaults to `0.005`): Coefficient when the power must go up (between 0 and 1, slowest to fastest).
* `k_down` (```
anything that is either float or ()-&gt;float```
 -- defaults to `0.1`): Coefficient when the power must go down (between 0 and 1, slowest to fastest).
* `threshold` (```
anything that is either float or ()-&gt;float```
 -- defaults to `-40.`): Minimal RMS for activaing gain control (dB).
* `gain_min` (```
anything that is either float or ()-&gt;float```
 -- defaults to `-6.`): Minimal gain value (dB).
* `gain_max` (```
anything that is either float or ()-&gt;float```
 -- defaults to `6.`): Maximal gain value (dB).
* `debug` (`bool` -- defaults to `false`): Show coefficients.
* `(unlabeled)` (`source`)

#### nrj
```
(source)->source```

Compress and normalize, producing a more uniform and ``full'' sound.

* `(unlabeled)` (`source`): The input source.

#### resample
```
(?id:string, ~ratio:'a,
 source)->source where 'a is either float or ()
 ->float```

Resample source's sound using a resampling factor

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `ratio` (```
anything that is either float or ()-&gt;float```
): Conversion ratio
* `(unlabeled)` (`source`)

#### sky
```
(source)->source```

Multiband-compression.

* `(unlabeled)` (`source`): The input source.

#### smart_cross
```
(?id:string, ?duration:float, ?inhibit:float,
 ?minimum:float, ?width:float, ?conservative:bool,
 ((float, float, [(string*string)],
 [(string*string)], source, source)->source),
 source)->source```

Cross operator, allowing the composition of the N last seconds of a track with the beginning of the next track, using a transition function depending on the relative power of the signal before and after the end of track.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `duration` (`float` -- defaults to `5.`): Duration in seconds of the crossed end of track.
* `inhibit` (`float` -- defaults to `-1.`): Minimum delay between two transitions. It is useful in order to avoid that a transition is triggered on top of another when an end-of-track occurs in the first one. Negative values mean `duration+1`. Warning: zero inhibition can cause infinite loops.
* `minimum` (`float` -- defaults to `-1.`): Minimum duration (in sec.) for a cross: If the track ends without any warning (e.g. in case of skip) there may not be enough data for a decent composition. Set to 0. to avoid having transitions after skips, or more to avoid transitions on short tracks. With the negative default, transitions always occur.
* `width` (`float` -- defaults to `1.`): Width of the power computation window.
* `conservative` (`bool` -- defaults to `false`): Do not trust remaining time estimations, always buffering data in advance. This avoids being tricked by skips, either manual or caused by skip_blank().
* `(unlabeled)` (```
(float, float, [(string*string)], [(string*string)], source, source)-&gt;source```
): Transition function, composing from the end of a track and the next track. It also takes the power of the signal before and after the transition, and the metadata.
* `(unlabeled)` (`source`)

#### soundtouch
```
(?id:string, ?rate:'a, ?tempo:'b, ?pitch:'c,
 source)->source where 'a, 'b,
 'c is either float or ()->float```

WARNING: This is only EXPERIMENTAL!

Change the rate, the tempo or the pitch of the sound.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `rate` (```
anything that is either float or ()-&gt;float```
 -- defaults to `1.`)
* `tempo` (```
anything that is either float or ()-&gt;float```
 -- defaults to `1.`)
* `pitch` (```
anything that is either float or ()-&gt;float```
 -- defaults to `1.`)
* `(unlabeled)` (`source`)

#### stereo.ms.decode
```
(?id:string, ?width:float, source)->source```

Decode mid+side stereo (M/S) to left+right stereo.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `width` (`float` -- defaults to `1.`): Width of the stereo field.
* `(unlabeled)` (`source`)

#### stereo.ms.encode
```
(?id:string, source)->source```

Encode left+right stereo to mid+side stereo (M/S).

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `(unlabeled)` (`source`)

#### stereo.pan
```
(?id:string, ?pan:'a, ?field:'b,
 source)->source where 'a, 'b is either float or ()
 ->float```

Pan a stereo sound.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `pan` (```
anything that is either float or ()-&gt;float```
 -- defaults to `0.`): Pan ranges between -1 and 1.
* `field` (```
anything that is either float or ()-&gt;float```
 -- defaults to `90.`): Field width in degrees (between 0 and 90).
* `(unlabeled)` (`source`)

#### substract
```
(?id:string, source, source)->source```

Compute the difference y-x of two sources y and x.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `(unlabeled)` (`source`): y
* `(unlabeled)` (`source`): x

#### swap
```
(?id:string, ?chan1:int, ?chan2:int, source)
 ->source```

swap two channels

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `chan1` (`int` -- defaults to `0`): Channel one
* `chan2` (`int` -- defaults to `1`): Channel two
* `(unlabeled)` (`source`)

Source / Sound Synthesis
------------------------
#### synth.all.hammond
```
(?id:string, ?attack:float, ?decay:float,
 ?sustain:float, ?release:float, source)->source```

Hammond synthsizer. It creates one synthesizer for each channel.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `attack` (`float` -- defaults to `0.02`): Envelope attack (in seconds).
* `decay` (`float` -- defaults to `0.01`): Envelope decay (in seconds).
* `sustain` (`float` -- defaults to `0.9`): Envelope sustain level.
* `release` (`float` -- defaults to `0.01`): Envelope release (in seconds).
* `(unlabeled)` (`source`)

#### synth.all.saw
```
(?id:string, ?attack:float, ?decay:float,
 ?sustain:float, ?release:float, source)->source```

Saw synthesizer. It creates one synthesizer for each channel.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `attack` (`float` -- defaults to `0.02`): Envelope attack (in seconds).
* `decay` (`float` -- defaults to `0.01`): Envelope decay (in seconds).
* `sustain` (`float` -- defaults to `0.9`): Envelope sustain level.
* `release` (`float` -- defaults to `0.01`): Envelope release (in seconds).
* `(unlabeled)` (`source`)

#### synth.all.sine
```
(?id:string, ?attack:float, ?decay:float,
 ?sustain:float, ?release:float, source)->source```

Sine synthesizer. It creates one synthesizer for each channel.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `attack` (`float` -- defaults to `0.02`): Envelope attack (in seconds).
* `decay` (`float` -- defaults to `0.01`): Envelope decay (in seconds).
* `sustain` (`float` -- defaults to `0.9`): Envelope sustain level.
* `release` (`float` -- defaults to `0.01`): Envelope release (in seconds).
* `(unlabeled)` (`source`)

#### synth.all.square
```
(?id:string, ?attack:float, ?decay:float,
 ?sustain:float, ?release:float, source)->source```

Square synthesizer. It creates one synthesizer for each channel.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `attack` (`float` -- defaults to `0.02`): Envelope attack (in seconds).
* `decay` (`float` -- defaults to `0.01`): Envelope decay (in seconds).
* `sustain` (`float` -- defaults to `0.9`): Envelope sustain level.
* `release` (`float` -- defaults to `0.01`): Envelope release (in seconds).
* `(unlabeled)` (`source`)

#### synth.hammond
```
(?id:string, ?channel:int, ?volume:float,
 ?attack:float, ?decay:float, ?sustain:float,
 ?release:float, source)->source```

Hammond synthsizer.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `channel` (`int` -- defaults to `0`): MIDI channel to handle.
* `volume` (`float` -- defaults to `0.3`): Initial volume.
* `attack` (`float` -- defaults to `0.02`): Envelope attack (in seconds).
* `decay` (`float` -- defaults to `0.01`): Envelope decay (in seconds).
* `sustain` (`float` -- defaults to `0.9`): Envelope sustain level.
* `release` (`float` -- defaults to `0.05`): Envelope release (in seconds).
* `(unlabeled)` (`source`)

#### synth.saw
```
(?id:string, ?channel:int, ?volume:float,
 ?attack:float, ?decay:float, ?sustain:float,
 ?release:float, source)->source```

Saw synthesizer.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `channel` (`int` -- defaults to `0`): MIDI channel to handle.
* `volume` (`float` -- defaults to `0.3`): Initial volume.
* `attack` (`float` -- defaults to `0.02`): Envelope attack (in seconds).
* `decay` (`float` -- defaults to `0.01`): Envelope decay (in seconds).
* `sustain` (`float` -- defaults to `0.9`): Envelope sustain level.
* `release` (`float` -- defaults to `0.05`): Envelope release (in seconds).
* `(unlabeled)` (`source`)

#### synth.sine
```
(?id:string, ?channel:int, ?volume:float,
 ?attack:float, ?decay:float, ?sustain:float,
 ?release:float, source)->source```

Sine synthesizer.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `channel` (`int` -- defaults to `0`): MIDI channel to handle.
* `volume` (`float` -- defaults to `0.3`): Initial volume.
* `attack` (`float` -- defaults to `0.02`): Envelope attack (in seconds).
* `decay` (`float` -- defaults to `0.01`): Envelope decay (in seconds).
* `sustain` (`float` -- defaults to `0.9`): Envelope sustain level.
* `release` (`float` -- defaults to `0.05`): Envelope release (in seconds).
* `(unlabeled)` (`source`)

#### synth.square
```
(?id:string, ?channel:int, ?volume:float,
 ?attack:float, ?decay:float, ?sustain:float,
 ?release:float, source)->source```

Square synthesizer.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `channel` (`int` -- defaults to `0`): MIDI channel to handle.
* `volume` (`float` -- defaults to `0.3`): Initial volume.
* `attack` (`float` -- defaults to `0.02`): Envelope attack (in seconds).
* `decay` (`float` -- defaults to `0.01`): Envelope decay (in seconds).
* `sustain` (`float` -- defaults to `0.9`): Envelope sustain level.
* `release` (`float` -- defaults to `0.05`): Envelope release (in seconds).
* `(unlabeled)` (`source`)

Source / Track Processing
-------------------------
#### append
```
(?id:string, ?merge:bool, ?insert_missing:bool,
 source, (([(string*string)])->source))->source```

Append an extra track to every track. Set the metadata 'liq_append' to 'false' to inhibit appending on one track.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `merge` (`bool` -- defaults to `false`): Merge the track with its appended track.
* `insert_missing` (`bool` -- defaults to `true`): Treat track beginnings without metadata as having empty one.
* `(unlabeled)` (`source`)
* `(unlabeled)` (`([(string*string)])-&gt;source`): Given the metadata, build the source producing the track to append. This source is allowed to fail (produce nothing) if no relevant track is to be appended.

#### at
```
((()->bool), source)->source```

Restrict a source to play only when a predicate is true.

* `(unlabeled)` (`()-&gt;bool`): The predicate, typically a time interval such as `{10h-10h30}`.
* `(unlabeled)` (`source`)

#### clear_metadata
```
(source)->source```

Removes all metadata coming from a source

* `(unlabeled)` (`source`)

#### crossfade
```
(~start_next:float, ~fade_in:float, ~fade_out:float,
 source)->source```

Simple crossfade.

* `start_next` (`float`): Duration in seconds of the crossed end of track.
* `fade_in` (`float`): Duration of the fade in for next track
* `fade_out` (`float`): Duration of the fade out for previous track
* `(unlabeled)` (`source`): The source to use

#### delay
```
(?id:string, float, source)->source```

Prevents the child from being ready again too fast after a end of track

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `(unlabeled)` (`float`): The source won't be ready less than this amount of seconds after any end of track
* `(unlabeled)` (`source`)

#### eat_blank
```
(?id:string, ?at_beginning:bool, ?threshold:float,
 ?length:float, source)->source```

Eat blanks, i.e., drop the contents of the stream until it is not blank anymore.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `at_beginning` (`bool` -- defaults to `false`): Only eat at the beginning of a track.
* `threshold` (`float` -- defaults to `-40.`): Power in decibels under which the stream is considered silent.
* `length` (`float` -- defaults to `20.`): Maximum silence length allowed, in seconds.
* `(unlabeled)` (`source`)

#### fallback
```
(?id:string, ?track_sensitive:bool,
 ?replay_metadata:bool, ?before:float,
 ?transitions:[(source, source)->source], [source])
 ->source```

At the beginning of each track, select the first ready child.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `track_sensitive` (`bool` -- defaults to `true`): Re-select only on end of tracks.
* `replay_metadata` (`bool` -- defaults to `true`): Replay the last metadata of a child when switching to it in the middle of a track.
* `before` (`float` -- defaults to `0.`): EXPERIMENTAL: for track_sensitive switches, trigger transitions before the end of track.
* `transitions` (`[(source, source)-&gt;source]` -- defaults to `[  ]`): Transition functions, padded with `fun (x,y) -> y` functions.
* `(unlabeled)` (`[source]`): Select the first ready source in this list.

#### fallback.skip
```
(~input:source, source)->source```

Special track insensitive fallback that
always skip current song before switching.

* `input` (`source`): The input source
* `(unlabeled)` (`source`): The fallback source

#### map_metadata
```
(?id:string,
 (([(string*string)])->[(string*string)]),
 ?update:bool, ?strip:bool, ?insert_missing:bool,
 source)->source```

Rewrite metadata on the fly using a function.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `(unlabeled)` (```
([(string*string)])-&gt;[(string*string)]```
): A function that returns new metadata.
* `update` (`bool` -- defaults to `true`): Only update metadata. If false, only returned values will be set as metadata.
* `strip` (`bool` -- defaults to `false`): Completly remove empty metadata. Operates on both empty values and empty metadata chunk.
* `insert_missing` (`bool` -- defaults to `true`): Treat track beginnings without metadata as having empty ones. The operational order is: create empty if needed, map and strip if enabled.
* `(unlabeled)` (`source`)

#### on_blank
```
(?id:string, (()->unit), ?on_noise:(()->unit),
 ?threshold:float, ?length:float, source)->source```

Calls a given handler when detecting a blank.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `(unlabeled)` (`()-&gt;unit`): Handler called when blank is detected.
* `on_noise` (`()-&gt;unit` -- defaults to `{()}`): Handler called when noise is detected.
* `threshold` (`float` -- defaults to `-40.`): Power in decibels under which the stream is considered silent.
* `length` (`float` -- defaults to `20.`): Maximum silence length allowed, in seconds.
* `(unlabeled)` (`source`)

#### on_end
```
(?id:string, ?delay:float, ((float,
 [(string*string)])->unit), source)->source```

Call a given handler when there is less than a given amount of time remaining before then end of track.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `delay` (`float` -- defaults to `5.`): Execute handler when remaining time is less or equal to this value.
* `(unlabeled)` (`(float, [(string*string)])-&gt;unit`): Function to execute. First argument is the remaining time, second is the latest metadata.
* `(unlabeled)` (`source`)

#### on_metadata
```
(?id:string, (([(string*string)])->unit), source)
 ->source```

Call a given handler on metadata packets.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `(unlabeled)` (`([(string*string)])-&gt;unit`): Function called on every metadata packet in the stream. It should be fast because it is ran in the main thread.
* `(unlabeled)` (`source`)

#### on_track
```
(?id:string, (([(string*string)])->unit), source)
 ->source```

Call a given handler on new tracks.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `(unlabeled)` (`([(string*string)])-&gt;unit`): Function called on every beginning of track in the stream, with the corresponding metadata as argument. If there is no metadata at the beginning of track, the empty list is passed. That function should be fast because it is ran in the main thread.
* `(unlabeled)` (`source`)

#### once
```
(source)->source```

Creates a source that plays only one track of the input source.

* `(unlabeled)` (`source`): The input source.

#### prepend
```
(?id:string, ?merge:bool, source,
 (([(string*string)])->source))->source```

Prepend an extra track before every track. Set the metadata 'liq_prepend' to 'false' to inhibit prepending on one track.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `merge` (`bool` -- defaults to `false`): Merge the track with its appended track.
* `(unlabeled)` (`source`)
* `(unlabeled)` (`([(string*string)])-&gt;source`): Given the metadata, build the source producing the track to prepend. This source is allowed to fail (produce nothing) if no relevant track is to be appended. However, success must be immediate.

#### random
```
(?id:string, ?track_sensitive:bool,
 ?replay_metadata:bool, ?before:float,
 ?transitions:[(source, source)->source],
 ?weights:[int], [source])->source```

At the beginning of every track, select a random ready child.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `track_sensitive` (`bool` -- defaults to `true`): Re-select only on end of tracks.
* `replay_metadata` (`bool` -- defaults to `true`): Replay the last metadata of a child when switching to it in the middle of a track.
* `before` (`float` -- defaults to `0.`): EXPERIMENTAL: for track_sensitive switches, trigger transitions before the end of track.
* `transitions` (`[(source, source)-&gt;source]` -- defaults to `[  ]`): Transition functions, padded with `fun (x,y) -> y` functions.
* `weights` (`[int]` -- defaults to `[  ]`): Weights of the children (padded with 1), defining for each child the probability that it is selected.
* `(unlabeled)` (`[source]`)

#### rewrite_metadata
```
([(string*string)], ?insert_missing:bool,
 ?update:bool, ?strip:bool, source)->source```

Rewrite metadata on the fly using a list of (target,rules).

* `(unlabeled)` (`[(string*string)]`): list of (target,value) rewriting rules
* `insert_missing` (`bool` -- defaults to `true`): Treat track beginnings without metadata as having empty ones. The operational order is: create empty if needed, map and strip if enabled.
* `update` (`bool` -- defaults to `true`): Only update metadata. If false, only returned values will be set as metadata.
* `strip` (`bool` -- defaults to `false`): Completly remove empty metadata. Operates on both empty values and empty metadata chunk.
* `(unlabeled)` (`source`)

#### rotate
```
(?id:string, ?track_sensitive:bool,
 ?replay_metadata:bool, ?before:float,
 ?transitions:[(source, source)->source],
 ?weights:[int], [source])->source```

Rotate between the sources.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `track_sensitive` (`bool` -- defaults to `true`): Re-select only on end of tracks.
* `replay_metadata` (`bool` -- defaults to `true`): Replay the last metadata of a child when switching to it in the middle of a track.
* `before` (`float` -- defaults to `0.`): EXPERIMENTAL: for track_sensitive switches, trigger transitions before the end of track.
* `transitions` (`[(source, source)-&gt;source]` -- defaults to `[  ]`): Transition functions, padded with `fun (x,y) -> y` functions.
* `weights` (`[int]` -- defaults to `[  ]`): Weights of the children (padded with 1), defining for each child how many tracks are played from it per round, if that many are actually available.
* `(unlabeled)` (`[source]`)

#### say_metadata
```
(source, ?pattern:string)->source```

Append speech-synthesized tracks reading the metadata.

* `(unlabeled)` (`source`): The source to use
* `pattern` (`string` -- defaults to ```
&quot;say:$(if $(artist),\&quot;It was $(artist)$(if $(title),\\\&quot;, $(title)\\\&quot;).\&quot;)&quot;```
): Pattern to use

#### sequence
```
(?id:string, ?merge:bool, [source])->source```

Play only one track of every successive source, except for the last one which is played as much as available.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `merge` (`bool` -- defaults to `false`)
* `(unlabeled)` (`[source]`)

#### skip_blank
```
(?id:string, ?threshold:float, ?length:float,
 source)->source```

Skip track when detecting a blank.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `threshold` (`float` -- defaults to `-40.`): Power in decibels under which the stream is considered silent.
* `length` (`float` -- defaults to `20.`): Maximum silence length allowed, in seconds.
* `(unlabeled)` (`source`)

#### smart_crossfade
```
(?start_next:float, ?fade_in:float, ?fade_out:float,
 ?default:((source, source)->source), ?high:float,
 ?medium:float, ?margin:float, ?width:float,
 ?conservative:bool, source)->source```

Crossfade between tracks, taking the respective volume levels into account in
the choice of the transition.

* `start_next` (`float` -- defaults to `5.`): Crossing duration, if any.
* `fade_in` (`float` -- defaults to `3.`): Fade-in duration, if any.
* `fade_out` (`float` -- defaults to `3.`): Fade-out duration, if any.
* `default` (`(source, source)-&gt;source` -- defaults to `&lt;fun&gt;`): Default transition when no rule can apply (default: sequence)
* `high` (`float` -- defaults to `-15.`): Value, in dB, for loud sound level
* `medium` (`float` -- defaults to `-32.`): Value, in dB, for medium sound level
* `margin` (`float` -- defaults to `4.`): Margin to detect sources that have too different sound level
* `width` (`float` -- defaults to `2.`): Width of the volume analysis window.
* `conservative` (`bool` -- defaults to `false`): Always prepare for a premature end-of-track.
* `(unlabeled)` (`source`): The input source.

#### smooth_add
```
(?delay:float, ?p:float, ~normal:source,
 ~special:source)->source```

Mixes two streams, with faded transitions between the state when only the
normal stream is available and when the special stream gets added on top of
it.

* `delay` (`float` -- defaults to `0.5`): Delay before starting the special source.
* `p` (`float` -- defaults to `0.2`): Portion of amplitude of the normal source in the mix.
* `normal` (`source`): The normal source, which could be called the carrier too.
* `special` (`source`): The special source.

#### store_metadata
```
(?id:string, ?size:int, source)->source```

Keep track of the last N metadata packets in the stream, and make the history available via a server command.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `size` (`int` -- defaults to `10`): Size of the history
* `(unlabeled)` (`source`)

#### strip_blank
```
(?id:string, ?threshold:float, ?length:float,
 source)->source```

Make the source unavailable when it is streaming blank.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `threshold` (`float` -- defaults to `-40.`): Power in decibels under which the stream is considered silent.
* `length` (`float` -- defaults to `20.`): Maximum silence length allowed, in seconds.
* `(unlabeled)` (`source`)

#### switch
```
(?id:string, ?track_sensitive:bool,
 ?replay_metadata:bool, ?before:float,
 ?transitions:[(source, source)->source],
 ?single:[bool], [((()->bool)*source)])->source```

At the beginning of a track, select the first source whose predicate is true.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `track_sensitive` (`bool` -- defaults to `true`): Re-select only on end of tracks.
* `replay_metadata` (`bool` -- defaults to `true`): Replay the last metadata of a child when switching to it in the middle of a track.
* `before` (`float` -- defaults to `0.`): EXPERIMENTAL: for track_sensitive switches, trigger transitions before the end of track.
* `transitions` (`[(source, source)-&gt;source]` -- defaults to `[  ]`): Transition functions, padded with `fun (x,y) -> y` functions.
* `single` (`[bool]` -- defaults to `[  ]`): Forbid the selection of a branch for two tracks in a row. The empty list stands for `[false,...,false]`.
* `(unlabeled)` (`[((()-&gt;bool)*source)]`): Sources with the predicate telling when they can be played.

Source / Video Processing
-------------------------
#### video.fade.final
```
(?id:string, ?duration:float, ?transition:string,
 ?type:string, source)->source```

Fade a stream to black.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `duration` (`float` -- defaults to `3.`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `transition` (`string` -- defaults to `&quot;fade&quot;`): Kind of transition (fade|slide_left|slide_right|slide_up|slide_down|grow|disc|random).
* `(unlabeled)` (`source`)

#### video.fade.in
```
(?id:string, ?override:string, ?duration:float,
 ?transition:string, ?type:string, source)->source```

Fade the beginning of tracks. Metadata 'liq_video_fade_in' can be used to set the duration for a specific track (float in seconds).

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `override` (`string` -- defaults to `&quot;liq_video_fade_in&quot;`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
* `duration` (`float` -- defaults to `3.`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `transition` (`string` -- defaults to `&quot;fade&quot;`): Kind of transition (fade|slide_left|slide_right|slide_up|slide_down|grow|disc|random).
* `(unlabeled)` (`source`)

#### video.fade.initial
```
(?id:string, ?duration:float, ?transition:string,
 ?type:string, source)->source```

Fade the beginning of a stream.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `duration` (`float` -- defaults to `3.`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `transition` (`string` -- defaults to `&quot;fade&quot;`): Kind of transition (fade|slide_left|slide_right|slide_up|slide_down|grow|disc|random).
* `(unlabeled)` (`source`)

#### video.fade.out
```
(?id:string, ?override:string, ?duration:float,
 ?transition:string, ?type:string, source)->source```

Fade the end of tracks. Metadata 'liq_video_fade_out' can be used to set the duration for a specific track (float in seconds).

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `override` (`string` -- defaults to `&quot;liq_video_fade_out&quot;`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
* `duration` (`float` -- defaults to `3.`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
* `transition` (`string` -- defaults to `&quot;fade&quot;`): Kind of transition (fade|slide_left|slide_right|slide_up|slide_down|grow|disc|random).
* `(unlabeled)` (`source`)

#### video.fill
```
(?id:string, ?color:int, source)->source```

Fill frame with a color.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `color` (`int` -- defaults to `0`): Color to fill the image with.
* `(unlabeled)` (`source`)

#### video.greyscale
```
(?id:string, source)->source```

Convert video to greyscale.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `(unlabeled)` (`source`)

#### video.invert
```
(?id:string, source)->source```

Invert video.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `(unlabeled)` (`source`)

#### video.lomo
```
(?id:string, source)->source```

Emulate the ``Lomo effect''.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `(unlabeled)` (`source`)

#### video.opacity
```
(?id:string, float, source)->source```

Scale opacity of video.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `(unlabeled)` (`float`): Coefficient to scale opacity with.
* `(unlabeled)` (`source`)

#### video.opacity.blur
```
(?id:string, source)->source```

Blur opacity of video.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `(unlabeled)` (`source`)

#### video.rotate
```
(?id:string, ?angle:float, ?speed:float, source)
 ->source```

Rotate video.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `angle` (`float` -- defaults to `0.`): Initial angle in radians.
* `speed` (`float` -- defaults to `3.1416`): Rotation speed in radians per sec.
* `(unlabeled)` (`source`)

#### video.scale
```
(?id:string, ?coef:float, ?coef_x:float,
 ?coef_y:float, ?offset_x:int, ?offset_y:int,
 source)->source```

Scale and translate video.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `coef` (`float` -- defaults to `1.`): Scaling coefficient in both directions.
* `coef_x` (`float` -- defaults to `1.`): x scaling
* `coef_y` (`float` -- defaults to `1.`): y scaling
* `offset_x` (`int` -- defaults to `1`): x offset
* `offset_y` (`int` -- defaults to `1`): y offset
* `(unlabeled)` (`source`)

#### video.sepia
```
(?id:string, source)->source```

Convert video to sepia.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `(unlabeled)` (`source`)

#### video.tile
```
(?id:string, ?normalize:bool, ?weights:[int],
 ?proportional:bool, [source])->source```

Tile sources (same as add but produces tiles of videos).

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `normalize` (`bool` -- defaults to `true`)
* `weights` (`[int]` -- defaults to `[  ]`): Relative weight of the sources in the sum. The empty list stands for the homogeneous distribution.
* `proportional` (`bool` -- defaults to `true`): Scale preserving the proportions.
* `(unlabeled)` (`[source]`)

#### video.transparent
```
(?id:string, ?precision:float, ?color:int, source)
 ->source```

Set a color to be transparent.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `precision` (`float` -- defaults to `0.`): Precision in color matching (0. means match precisely the color and 1. means match every color).
* `color` (`int` -- defaults to `0`): Color which should be transparent (in 0xRRGGBB format).
* `(unlabeled)` (`source`)

Source / Visualization
----------------------
#### video.volume
```
(?id:string, source)->source```

Graphical visualization of the sound.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `(unlabeled)` (`source`)

#### visu.glvolume
```
(?id:string, source)->source```

Graphical visualization of the volume using openGL.

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `(unlabeled)` (`source`)

#### vumeter
```
(?id:string, ?scroll:bool, source)->source```

VU meter (display the volume).

* `id` (`string` -- defaults to `&quot;&quot;`): Force the value of the source ID.
* `scroll` (`bool` -- defaults to `false`): Scroll.
* `(unlabeled)` (`source`)

Bool
----
#### !=
```
('a, 'a)->bool where 'a is an orderable type```

Comparison of comparable values.

* `(unlabeled)` (`anything that is an orderable type`)
* `(unlabeled)` (`anything that is an orderable type`)

#### <
```
('a, 'a)->bool where 'a is an orderable type```

Comparison of comparable values.

* `(unlabeled)` (`anything that is an orderable type`)
* `(unlabeled)` (`anything that is an orderable type`)

#### <=
```
('a, 'a)->bool where 'a is an orderable type```

Comparison of comparable values.

* `(unlabeled)` (`anything that is an orderable type`)
* `(unlabeled)` (`anything that is an orderable type`)

#### ==
```
('a, 'a)->bool where 'a is an orderable type```

Comparison of comparable values.

* `(unlabeled)` (`anything that is an orderable type`)
* `(unlabeled)` (`anything that is an orderable type`)

#### >
```
('a, 'a)->bool where 'a is an orderable type```

Comparison of comparable values.

* `(unlabeled)` (`anything that is an orderable type`)
* `(unlabeled)` (`anything that is an orderable type`)

#### >=
```
('a, 'a)->bool where 'a is an orderable type```

Comparison of comparable values.

* `(unlabeled)` (`anything that is an orderable type`)
* `(unlabeled)` (`anything that is an orderable type`)

#### and
```
(bool, bool)->bool```

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
(bool, bool)->bool```

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
(?fast:bool, float, (()->float))->unit```

Call a function in N seconds. If the result of the function is a positive or null integer, the task will be scheduled after this amount of time (in seconds.)

* `fast` (`bool` -- defaults to `true`): Set to `false` if the execution of the code can take long in order to lower its priority below that of request resolutions and fast timeouts. This is only effective if you set a dedicated queue for fast tasks, see the ``scheduler'' settings for more details.
* `(unlabeled)` (`float`)
* `(unlabeled)` (`()-&gt;float`)

#### ignore
```
('a)->unit```

Convert anything to unit, preventing warnings.

* `(unlabeled)` (`'a`)

Deprecated
----------
#### request
```
(string)->request```

Backward compatible function for request.create().

* `(unlabeled)` (`string`)

Interaction
-----------
#### audioscrobbler.nowplaying
```
(~user:string, ~password:string, ?host:string,
 ?port:int, ?length:bool, [(string*string)])->unit```

Submit a now playing song using the audioscrobbler protocol.

* `user` (`string`)
* `password` (`string`)
* `host` (`string` -- defaults to `&quot;post.audioscrobbler.com&quot;`): Host for audioscrobbling submissions.
* `port` (`int` -- defaults to `80`): Port for audioscrobbling submissions.
* `length` (`bool` -- defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the ``user'' source type.
* `(unlabeled)` (`[(string*string)]`)

#### audioscrobbler.submit
```
(?source:string, ~user:string, ~password:string,
 ?host:string, ?port:int, ?length:bool,
 [(string*string)])->unit```

Submit a played song using the audioscrobbler protocol.

* `source` (`string` -- defaults to `&quot;broadcast&quot;`): Source for tracks. Should be one of: ``broadcast'', ``user'', ``recommendation'' or ``unknown''. Since liquidsoap is intented for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
* `user` (`string`)
* `password` (`string`)
* `host` (`string` -- defaults to `&quot;post.audioscrobbler.com&quot;`): Host for audioscrobbling submissions.
* `port` (`int` -- defaults to `80`): Port for audioscrobbling submissions.
* `length` (`bool` -- defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the ``user'' source type.
* `(unlabeled)` (`[(string*string)]`)

#### audioscrobbler.submit.full
```
(~user:string, ~password:string, ?host:string,
 ?port:int, ?source:string, ?length:bool,
 ?delay:float, ?force:bool, source)->source```

Submit songs using audioscrobbler, respecting the full protocol:
First signal song as now playing when starting, and
then submit song when it ends.

* `user` (`string`)
* `password` (`string`)
* `host` (`string` -- defaults to `&quot;post.audioscrobbler.com&quot;`)
* `port` (`int` -- defaults to `80`)
* `source` (`string` -- defaults to `&quot;broadcast&quot;`): Source for tracks. Should be one of: ``broadcast'', ``user'', ``recommendation'' or ``unknown''. Since liquidsoap is intented for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
* `length` (`bool` -- defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the ``user'' source type.
* `delay` (`float` -- defaults to `10.`): Submit song when there is only this delay left, in seconds. 
* `force` (`bool` -- defaults to `false`): If remaining time is null, the song will be assumed to be skipped or cuted, and not submitted. Set to zero to disable this behaviour.
* `(unlabeled)` (`source`)

#### interactive.float
```
(string, float)->()->float```

Read a float from an interactive input.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`float`)

#### interactive.string
```
(string, string)->()->string```

Read a string from an interactive input.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`string`)

#### lastfm.nowplaying
```
(~user:string, ~password:string, ?length:bool,
 [(string*string)])->unit```

Submit metadata to lastfm.fm using the audioscrobbler protocol (nowplaying mode).

* `user` (`string`)
* `password` (`string`)
* `length` (`bool` -- defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the ``user'' source type.
* `(unlabeled)` (`[(string*string)]`)

#### lastfm.submit
```
(~user:string, ~password:string, ?source:string,
 ?length:bool, [(string*string)])->unit```

Submit metadata to lastfm.fm using the audioscrobbler protocol.

* `user` (`string`)
* `password` (`string`)
* `source` (`string` -- defaults to `&quot;broadcast&quot;`): Source for tracks. Should be one of: ``broadcast'', ``user'', ``recommendation'' or ``unknown''. Since liquidsoap is intented for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
* `length` (`bool` -- defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the ``user'' source type.
* `(unlabeled)` (`[(string*string)]`)

#### lastfm.submit.full
```
(~user:string, ~password:string, ?source:string,
 ?length:bool, ?delay:float, ?force:bool, source)
 ->source```

Submit songs to lastfm using audioscrobbler, respecting the full protocol:
First signal song as now playing when starting, and
then submit song when it ends.

* `user` (`string`)
* `password` (`string`)
* `source` (`string` -- defaults to `&quot;broadcast&quot;`): Source for tracks. Should be one of: ``broadcast'', ``user'', ``recommendation'' or ``unknown''. Since liquidsoap is intented for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
* `length` (`bool` -- defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the ``user'' source type.
* `delay` (`float` -- defaults to `10.`): Submit song when there is only this delay left, in seconds. If remaining time is less than this value, the song will be assumed to be skipped or cuted, and not submitted. Set to zero to disable this behaviour.
* `force` (`bool` -- defaults to `false`): If remaining time is null, the song will be assumed to be skipped or cuted, and not submitted. Set to zero to disable this behaviour.
* `(unlabeled)` (`source`)

#### librefm.nowplaying
```
(~user:string, ~password:string, ?length:bool,
 [(string*string)])->unit```

Submit metadata to libre.fm using the audioscrobbler protocol (nowplaying mode).

* `user` (`string`)
* `password` (`string`)
* `length` (`bool` -- defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the ``user'' source type.
* `(unlabeled)` (`[(string*string)]`)

#### librefm.submit
```
(~user:string, ~password:string, ?source:string,
 ?length:bool, [(string*string)])->unit```

Submit metadata to libre.fm using the audioscrobbler protocol.

* `user` (`string`)
* `password` (`string`)
* `source` (`string` -- defaults to `&quot;broadcast&quot;`): Source for tracks. Should be one of: ``broadcast'', ``user'', ``recommendation'' or ``unknown''. Since liquidsoap is intented for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
* `length` (`bool` -- defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the ``user'' source type.
* `(unlabeled)` (`[(string*string)]`)

#### librefm.submit.full
```
(~user:string, ~password:string, ?source:string,
 ?length:bool, ?delay:float, ?force:bool, source)
 ->source```

Submit songs to librefm using audioscrobbler, respecting the full protocol:
First signal song as now playing when starting, and
then submit song when it ends.

* `user` (`string`)
* `password` (`string`)
* `source` (`string` -- defaults to `&quot;broadcast&quot;`): Source for tracks. Should be one of: ``broadcast'', ``user'', ``recommendation'' or ``unknown''. Since liquidsoap is intented for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
* `length` (`bool` -- defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the ``user'' source type.
* `delay` (`float` -- defaults to `10.`): Submit song when there is only this delay left, in seconds. If remaining time is less than this value, the song will be assumed to be skipped or cuted, and not submitted. Set to zero to disable this behaviour.
* `force` (`bool` -- defaults to `false`): If remaining time is null, the song will be assumed to be skipped or cuted, and not submitted. Set to zero to disable this behaviour.
* `(unlabeled)` (`source`)

#### print
```
(?newline:bool, 'a)->unit```

Print on standard output.

* `newline` (`bool` -- defaults to `true`): If true, a newline is added after displaying the value.
* `(unlabeled)` (`'a`)

Liquidsoap
----------
#### add_decoder
```
(string, ((string)->string))->unit```

Register an external file decoder. The encoder should output in WAV format to his standard output (stdout).

* `(unlabeled)` (`string`): Format/decoder's name.
* `(unlabeled)` (`(string)-&gt;string`): Process to start. The function takes the filename as argument and returns the process to start.

#### add_metadata_resolver
```
(string, ((~format:string,
 string)->[(string*string)]))->unit```

Register an external file metadata decoder.

* `(unlabeled)` (`string`): Format/resolver's name.
* `(unlabeled)` (```
(~format:string, string)-&gt;[(string*string)]```
): Process to start. The function takes the format and filename as argument and returns a list of (name,value) fields.

#### add_protocol
```
(?temporary:bool, string, ((string,
 float)->[string]))->unit```

Register a new protocol.

* `temporary` (`bool` -- defaults to `false`): if true, file removed when it is finished.
* `(unlabeled)` (`string`)
* `(unlabeled)` (`(string, float)-&gt;[string]`)

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

#### enable_faad
```
()->unit```

Enable faad decoding (needs faad binary in path)

#### enable_gstreamer
```
(?debug:bool)->unit```

Enable gstreamer decoder (needs gst-launch binary in path)

* `debug` (`bool` -- defaults to `false`)

#### enable_mplayer
```
(?debug:bool)->unit```

Enable mplayer decoder (needs mplayer binary in path)

* `debug` (`bool` -- defaults to `false`)

#### enable_replaygain_metadata
```
(?extract_replaygain:string)->unit```

Enable replay gain metadata resolver. This resolver will 
process any file decoded by liquidsoap and add a `replay_gain` 
metadata when this value could be computed. For a finer-grained 
replay gain processing, use the `replay_gain` protocol.

* `extract_replaygain` (`string` -- defaults to ```
&quot;/usr/local/lib/liquidsoap/svn/extract-replaygain&quot;```
): The extraction program

#### execute
```
(string, ?string)->[string]```

WARNING: This is DEPRECATED!

Execute a liquidsoap server command.
This operator is deprecated, in favor of 'server.execute'.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`string` -- defaults to `&quot;&quot;`)

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

#### get
```
(~default:'a, string)
 ->'a where 'a is bool, int, float, string or [string]```

Get a setting's value.

* `default` (```
anything that is bool, int, float, string or [string]```
)
* `(unlabeled)` (`string`)

#### liquidsoap.version
```
string```

Liquidsoap version string.

#### playlist.parse
```
(string)->[([(string*string)]*string)]```

Try to parse a local playlist. Return a list of (metadata,URI) items, where metadata is a list of (key,value) bindings.

* `(unlabeled)` (`string`)

#### request.create
```
(?indicators:[string], ?persistent:bool,
 ?audio:bool, string)->request```

Create a request. Creation may fail if there is no available RID, which cannot be detected currently: in that case one will obtain a request that will fail to be resolved.

* `indicators` (`[string]` -- defaults to `[  ]`)
* `persistent` (`bool` -- defaults to `false`)
* `audio` (`bool` -- defaults to `true`): If set, resolving includes checking that the resulting file can be decoded as audio.
* `(unlabeled)` (`string`)

#### request.destroy
```
(?force:bool, request)->unit```

Destroying a request causes any temporary associated file to be deleted, and releases its RID. Persistent requests resist to destroying, unless forced.

* `force` (`bool` -- defaults to `false`): Destroy the request even if it is persistent.
* `(unlabeled)` (`request`)

#### request.filename
```
(request)->string```

Return a valid local filename if the request is ready, and the empty string otherwise.

* `(unlabeled)` (`request`)

#### request.ready
```
(request)->bool```

Check if a request is ready, i.e. is associated to a valid local file. Unless the initial URI was such a file, a request has to be resolved before being ready.

* `(unlabeled)` (`request`)

#### request.resolve
```
(?timeout:float, request)->bool```

Resolve a request, i.e. attempt to get a valid local file. The operation can take some time. Return true if the resolving was successful, false otherwise (timeout or invalid URI).

* `timeout` (`float` -- defaults to `30.`): Limit in seconds to the duration of the resolving.
* `(unlabeled)` (`request`)

#### server.execute
```
(string, ?string)->[string]```

Execute a liquidsoap server command.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`string` -- defaults to `&quot;&quot;`)

#### set
```
(string, 'a)
 ->unit where 'a is bool, int, float, string or [string]```

Change some setting. Use `liquidsoap --conf-descr` and `liquidsoap --conf-descr-key KEY` on the command-line to get some information about available settings.

* `(unlabeled)` (`string`)
* `(unlabeled)` (```
anything that is bool, int, float, string or [string]```
)

#### shutdown
```
()->unit```

Shutdown the application.

#### source.id
```
(source)->string```

Get one source's identifier.

* `(unlabeled)` (`source`)

#### source.skip
```
(source)->unit```

Skip to the next track.

* `(unlabeled)` (`source`)

List
----
#### _[_]
```
(string, [(string*string)])->string```

`l[k]` returns the first `v` such that `(k,v)` is in the list `l`.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`[(string*string)]`)

#### fst
```
(('a*'b))->'a```

Get the first component of a pair.

* `(unlabeled)` (`('a*'b)`)

#### list.append
```
(['a], ['a])->['a]```

Catenate two lists.

* `(unlabeled)` (`['a]`)
* `(unlabeled)` (`['a]`)

#### list.assoc
```
(string, [(string*string)])->string```

Alias for the `l[k]` notation.

* `(unlabeled)` (`string`): Key to look for
* `(unlabeled)` (`[(string*string)]`): List of pairs (key,value)

#### list.fold
```
((('a, 'b)->'a), 'a, ['b])->'a```

Fold a function on every element of a list.

* `(unlabeled)` (`('a, 'b)-&gt;'a`)
* `(unlabeled)` (`'a`)
* `(unlabeled)` (`['b]`)

#### list.hd
```
([string])->string```

Return the head (first element) of a list, or ``'' if the list is empty.

* `(unlabeled)` (`[string]`)

#### list.iter
```
((('a)->unit), ['a])->unit```

Call a function on every element of a list.

* `(unlabeled)` (`('a)-&gt;unit`)
* `(unlabeled)` (`['a]`)

#### list.length
```
(['a])->int```

Get the length of a list, i.e. its number of elements.

* `(unlabeled)` (`['a]`)

#### list.map
```
((('a)->'b), ['a])->['b]```

Map a function on every element of a list.

* `(unlabeled)` (`('a)-&gt;'b`)
* `(unlabeled)` (`['a]`)

#### list.mem
```
('a, ['a])->bool where 'a is an orderable type```

Check if an element belongs to a list.

* `(unlabeled)` (`anything that is an orderable type`)
* `(unlabeled)` (`['a] where 'a is an orderable type`)

#### list.mem_assoc
```
(string, [(string*string)])->bool```

list.mem_assoc(key,l) returns true if l contains a pair
(key,value)

* `(unlabeled)` (`string`): Key to look for
* `(unlabeled)` (`[(string*string)]`): List of pairs (key,value)

#### list.nth
```
(['a], int)->'a```

Get the n-th element of a list.

* `(unlabeled)` (`['a]`)
* `(unlabeled)` (`int`)

#### list.remove
```
('a, ['a])->['a]```

Remove a value from a list.

* `(unlabeled)` (`'a`)
* `(unlabeled)` (`['a]`)

#### list.remove_assoc
```
(string, [(string*string)])->[(string*string)]```

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
((('a, 'a)->int), ['a])->['a]```

Sort a list according to a comparison function.

* `(unlabeled)` (`('a, 'a)-&gt;int`)
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
('a, 'a)->'a where 'a is a number type```

Multiplication of numbers.

* `(unlabeled)` (`anything that is a number type`)
* `(unlabeled)` (`anything that is a number type`)

#### +
```
('a, 'a)->'a where 'a is a number type```

Addition of numbers.

* `(unlabeled)` (`anything that is a number type`)
* `(unlabeled)` (`anything that is a number type`)

#### -
```
('a, 'a)->'a where 'a is a number type```

Substraction of numbers.

* `(unlabeled)` (`anything that is a number type`)
* `(unlabeled)` (`anything that is a number type`)

#### /
```
('a, 'a)->'a where 'a is a number type```

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

#### pow
```
('a, 'a)->'a where 'a is a number type```

Exponentiation of numbers.

* `(unlabeled)` (`anything that is a number type`)
* `(unlabeled)` (`anything that is a number type`)

#### random.float
```
(?min:float, ?max:float)->float```

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
(string, [(string*string)])->string```

`pattern % [...,(k,v),...]` changes in the pattern occurences of:
- `$(k)` into `v`;
- `$(if $(k2),"a","b")` into ``a'' if k2 is found in the list, ``b'' otherwise.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`[(string*string)]`)

#### ^
```
(string, string)->string```

Concatenate strings.

* `(unlabeled)` (`string`)
* `(unlabeled)` (`string`)

#### bool_of_string
```
(?default:bool, string)->bool```

Convert a string to a bool.

* `default` (`bool` -- defaults to `false`)
* `(unlabeled)` (`string`)

#### float_of_string
```
(?default:float, string)->float```

Convert a string to a float.

* `default` (`float` -- defaults to `0.`)
* `(unlabeled)` (`string`)

#### int_of_string
```
(?default:int, string)->int```

Convert a string to a int.

* `default` (`int` -- defaults to `0`)
* `(unlabeled)` (`string`)

#### lastfm.uri
```
(?user:string, ?password:string, ?discovery:bool,
 ?string)->string```

Utility to compose last.fm URIs.

* `user` (`string` -- defaults to `&quot;&quot;`): Lastfm user
* `password` (`string` -- defaults to `&quot;&quot;`): Lastfm password
* `discovery` (`bool` -- defaults to `false`): Allow lastfm suggestions
* `(unlabeled)` (`string` -- defaults to `&quot;globaltags/creative-commons&quot;`): URI, e.g. user/toots5446/playlist, globaltags/rocksteady.

#### quote
```
(string)->string```

Escape shell metacharacters.

* `(unlabeled)` (`string`)

#### string.capitalize
```
(?capitalize:bool, ?space_sensitive:bool, string)
 ->string```

Return a string with the first character set to upper case (capitalize), or to lower case (uncapitalize).

* `capitalize` (`bool` -- defaults to `true`): Capitalize if true, uncapitalize otherwise
* `space_sensitive` (`bool` -- defaults to `true`): Capitalize each space seperated sub-string.
* `(unlabeled)` (`string`)

#### string.case
```
(?lower:bool, string)->string```

Convert a string to lower or upper case.

* `lower` (`bool` -- defaults to `true`): Convert to lower case if true and uppercase otherwise.
* `(unlabeled)` (`string`)

#### string.concat
```
(?separator:string, [string])->string```

Concatenate strings.

* `separator` (`string` -- defaults to `&quot;&quot;`)
* `(unlabeled)` (`[string]`)

#### string.extract
```
(~pattern:string, string)->[(string*string)]```

Extract substrings from a string. 
Perl compatible regular expressions are recognized. Hence, special characters should be escaped. 
Returns a list of (index,value).
If the list does not have a pair associated to some index, it means that the corresponding pattern was not found.

* `pattern` (`string`)
* `(unlabeled)` (`string`)

#### string.match
```
(~pattern:string, string)->bool```

Match a string with an expression. 
Perl compatible regular expressions are recognized. Hence, special characters should be escaped.

* `pattern` (`string`)
* `(unlabeled)` (`string`)

#### string.ref
```
(string)->((()->string)*((string)->unit))```

Returns a pair (get,set) where get is a function of type `unit -> string`, to get current value, and set a function of type `string -> unit`, to set a new value. 
This is a workaround, and it shall be removed when variable references are implemented.

* `(unlabeled)` (`string`): Initial value

#### string.replace
```
(~pattern:string, ((string)->string), string)
 ->string```

Replace substrings in a string. 
Will replace all substrings matched in the pattern by the string returned by the replace function.

* `pattern` (`string`)
* `(unlabeled)` (`(string)-&gt;string`)
* `(unlabeled)` (`string`)

#### string.split
```
(~separator:string, string)->[string]```

Split a string at 'separator'. 
Perl compatible regular expressions are recognized. Hence, special characters should be escaped.

* `separator` (`string`)
* `(unlabeled)` (`string`)

#### string_of
```
('a)->string```

Return the representation of a value.

* `(unlabeled)` (`'a`)

System
------
#### argv
```
(?default:string, int)->string```

Get command-line parameters.

* `default` (`string` -- defaults to `&quot;&quot;`)
* `(unlabeled)` (`int`)

#### basename
```
(string)->string```

Get the base name of a path.
Implemented using the corresponding shell command.

* `(unlabeled)` (`string`): Path

#### dirname
```
(string)->string```

Get the directory name of a path.
Implemented using the corresponding shell command.

* `(unlabeled)` (`string`): Path

#### exec_at
```
(?freq:float, ~pred:(()->bool), (()->unit))->unit```

Execute a given action when a predicate is true. This will be run in background.

* `freq` (`float` -- defaults to `1.`): Frequency for checking the predicate, in seconds.
* `pred` (`()-&gt;bool`): Predicate, typically a time interval such as `{10h-10h30}`.
* `(unlabeled)` (`()-&gt;unit`): Function to execute when the predicate is true.

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
(?default:string, string)->string```

Parse command line options:
`getopt("-o")` returns ``1'' if ``-o'' was passed without any parameter, ``0'' otherwise.
`getopt(default="X","-o")` returns ``Y'' if ``-o Y'' was passed, ``X'' otherwise.
The result is removed from the list of arguments, affecting subsequent
calls to `argv()` and `getopt()`.

* `default` (`string` -- defaults to `&quot;&quot;`)
* `(unlabeled)` (`string`)

#### getpid
```
()->int```

Get the process' pid.

#### log
```
(?label:string, ?level:int, string)->unit```

Log a message.

* `label` (`string` -- defaults to `&quot;lang&quot;`)
* `level` (`int` -- defaults to `3`)
* `(unlabeled)` (`string`)

#### on_shutdown
```
((()->unit))->unit```

Register a function to be called when Liquidsoap shuts down.

* `(unlabeled)` (`()-&gt;unit`)

#### read
```
(?hide:bool)->string```

Read some value from standard input (console).

* `hide` (`bool` -- defaults to `false`): Hide typed characters (for passwords).

#### server.register
```
(?namespace:string, ?description:string,
 ?usage:string, string, ((string)->string))->unit```

Register a command. You can then execute this function through the server, either telnet or socket.

* `namespace` (`string` -- defaults to `&quot;&quot;`)
* `description` (`string` -- defaults to `&quot;No documentation available.&quot;`): A description of your command.
* `usage` (`string` -- defaults to `&quot;&quot;`)
* `(unlabeled)` (`string`)
* `(unlabeled)` (`(string)-&gt;string`)

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

Uncategorized
-------------
#### replaygain_protocol
```
(string, 'a)->[string]```

Register the replaygain protocol

* `(unlabeled)` (`string`)
* `(unlabeled)` (`'a`)


