Liquidsoap scripting language reference
=======================================

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

* [Source / Conversions](#source-conversions)
* [Source / Input](#source-input)
* [Source / Liquidsoap](#source-liquidsoap)
* [Source / MIDI Processing](#source-midi-processing)
* [Source / Output](#source-output)
* [Source / Sound Processing](#source-sound-processing)
* [Source / Sound Synthesis](#source-sound-synthesis)
* [Source / Track Processing](#source-track-processing)
* [Source / Video Processing](#source-video-processing)
* [Source / Visualization](#source-visualization)
* [FFmpeg Filter](#ffmpeg-filter)
* [Bool](#bool)
* [Control](#control)
* [Interaction](#interaction)
* [Liquidsoap](#liquidsoap)
* [List](#list)
* [Math](#math)
* [Pair](#pair)
* [String](#string)
* [System](#system)

## Bool

### `!=`

Comparison of comparable values.

Type:
```
('a, 'a) -> bool where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `anything that is an orderable type`)
- `(unlabeled)` (of type `anything that is an orderable type`)

### `<`

Comparison of comparable values.

Type:
```
('a, 'a) -> bool where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `anything that is an orderable type`)
- `(unlabeled)` (of type `anything that is an orderable type`)

### `<=`

Comparison of comparable values.

Type:
```
('a, 'a) -> bool where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `anything that is an orderable type`)
- `(unlabeled)` (of type `anything that is an orderable type`)

### `==`

Comparison of comparable values.

Type:
```
('a, 'a) -> bool where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `anything that is an orderable type`)
- `(unlabeled)` (of type `anything that is an orderable type`)

### `>`

Comparison of comparable values.

Type:
```
('a, 'a) -> bool where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `anything that is an orderable type`)
- `(unlabeled)` (of type `anything that is an orderable type`)

### `>=`

Comparison of comparable values.

Type:
```
('a, 'a) -> bool where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `anything that is an orderable type`)
- `(unlabeled)` (of type `anything that is an orderable type`)

### `and`

Return the conjunction of its arguments

Type:
```
({bool}, {bool}) -> bool
```

Arguments:

- `(unlabeled)` (of type `{bool}`)
- `(unlabeled)` (of type `{bool}`)

### `not`

Returns the negation of its argument.

Type:
```
(bool) -> bool
```

Arguments:

- `(unlabeled)` (of type `bool`)

### `or`

Return the disjunction of its arguments

Type:
```
({bool}, {bool}) -> bool
```

Arguments:

- `(unlabeled)` (of type `{bool}`)
- `(unlabeled)` (of type `{bool}`)

### `random.bool`

Generate a random boolean.

Type:
```
() -> bool
```

Arguments:


## Control

### `ignore`

Convert anything to unit, preventing warnings.

Type:
```
('a) -> unit
```

Arguments:

- `(unlabeled)` (of type `'a`)

### `thread.run`

Run a function in a separate thread.

Type:
```
(?fast : bool, ?delay : float, ?every : {float}?,
 (() -> unit)) -> unit
```

Arguments:

- `fast` (of type `bool`, which defaults to `true`): Whether the thread is supposed to return quickly or not. Typically, blocking tasks (e.g. fetching data over the internet) should not be considered to be fast. When set to `false` its priority will be lowered below that of request resolutions and fast timeouts. This is only effective if you set a dedicated queue for fast tasks, see the "scheduler" settings for more details.
- `delay` (of type `float`, which defaults to `0.`): Delay (in seconds) after which the thread should be launched.
- `every` (of type `{float}?`, which defaults to `null`): How often (in seconds) the thread should be run. If negative or `null`, run once.
- `(unlabeled)` (of type `() -> unit`): Function to execute.

## File

### `file.digest`

Return an MD5 digest for the given file.

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `file.exists`

Returns true if the file or directory exists.

Type:
```
(string) -> bool
```

Arguments:

- `(unlabeled)` (of type `string`)

### `file.extension`

Returns a file's extension.

Type:
```
(?dir_sep : string, ?leading_dot : bool, string) ->
string
```

Arguments:

- `dir_sep` (of type `string`, which defaults to `"/"`): Directory separator.
- `leading_dot` (of type `bool`, which defaults to `true`): Return extension with a leading dot, e.g. `.foo`.
- `(unlabeled)` (of type `string`)

### `file.is_directory`

Returns true if the file exists and is a directory.

Type:
```
(string) -> bool
```

Arguments:

- `(unlabeled)` (of type `string`)

### `file.ls`

List all the files in a directory.

Type:
```
(?absolute : bool, ?recursive : bool, ?pattern : string?,
 string) -> [string]
```

Arguments:

- `absolute` (of type `bool`, which defaults to `false`): Whether to return absolute paths.
- `recursive` (of type `bool`, which defaults to `false`): Whether to look recursively in subdirectories.
- `pattern` (of type `string?`, which defaults to `null`): Pattern that the filenames should match (e.g. `"*.mp3"`).
- `(unlabeled)` (of type `string`): Directory to look in.

### `file.metadata`

Read metadata from a file.

Type:
```
(string) -> [string * string]
```

Arguments:

- `(unlabeled)` (of type `string`): File from which the metadata should be read.

### `file.metadata.ffmpeg`

Read metadata from a file using the ffmpeg decoder.

Type:
```
(string) -> [string * string]
```

Arguments:

- `(unlabeled)` (of type `string`): File from which the metadata should be read.

### `file.metadata.flac`

Read metadata from a file using the flac decoder.

Type:
```
(string) -> [string * string]
```

Arguments:

- `(unlabeled)` (of type `string`): File from which the metadata should be read.

### `file.metadata.gstreamer`

Read metadata from a file using the gstreamer decoder.

Type:
```
(string) -> [string * string]
```

Arguments:

- `(unlabeled)` (of type `string`): File from which the metadata should be read.

### `file.metadata.id3v2`

Read metadata from a file using the id3v2 decoder.

Type:
```
(string) -> [string * string]
```

Arguments:

- `(unlabeled)` (of type `string`): File from which the metadata should be read.

### `file.metadata.mp4`

Read metadata from a file using the mp4 decoder.

Type:
```
(string) -> [string * string]
```

Arguments:

- `(unlabeled)` (of type `string`): File from which the metadata should be read.

### `file.metadata.ogg`

Read metadata from a file using the ogg decoder.

Type:
```
(string) -> [string * string]
```

Arguments:

- `(unlabeled)` (of type `string`): File from which the metadata should be read.

### `file.metadata.taglib`

Read metadata from a file using the taglib decoder.

Type:
```
(string) -> [string * string]
```

Arguments:

- `(unlabeled)` (of type `string`): File from which the metadata should be read.

### `file.mime`

Get the MIME type of a file, according to libmagic.

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `file.mkdir`

Create a directory.

Type:
```
(?perms : int, string) -> unit
```

Arguments:

- `perms` (of type `int`, which defaults to `493`): Default file rights if created (default is `0o755`).
- `(unlabeled)` (of type `string`)

### `file.read`

Read the content of a file. Returns a function of type `()->string`. File is done reading when function returns the empty string `""`.

Type:
```
(string) -> () -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `file.remove`

Remove a file.

Type:
```
(string) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`)

### `file.rmdir`

Remove a directory and its content.

Type:
```
(string) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`)

### `file.size`

File size in bytes.

Type:
```
(string) -> int
```

Arguments:

- `(unlabeled)` (of type `string`)

### `file.temp`

Return a fresh temporary filename. The temporary file is created empty, with permissions 0o600 (readable and writable only by the file owner).

Type:
```
(string, string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`): File prefix
- `(unlabeled)` (of type `string`): File suffix

### `file.temp_dir`

Return a fresh temporary directory name. The temporary directory is created empty, with permissions 0o700 (readable, writable and listable only by the file owner).

Type:
```
(string, string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`): Directory prefix
- `(unlabeled)` (of type `string`): Directory suffix

### `file.watch`

Call a function when a file is modified. Returns unwatch function in `unwatch` method.

Type:
```
(string, (() -> unit)) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`): File to watch.
- `(unlabeled)` (of type `() -> unit`): Handler function.

Methods:

- `unwatch` (of type `() -> unit`): Function to remove the watch on the file.

### `file.which`

`file.which("progname")` looks for an executable named "progname" using directories from the PATH environment variable and returns "" if it could not find one.

Type:
```
(string) -> string?
```

Arguments:

- `(unlabeled)` (of type `string`)

### `file.write`

Write data to a file.

Type:
```
(data : {string?}, ?append : bool, ?perms : int, string) ->
unit
```

Arguments:

- `data` (of type `{string?}`): Data to write. If passing a callback `() -> string?`, the callback must return `null` when it has finished sending all its data.
- `append` (of type `bool`, which defaults to `false`): Append data if file exists.
- `perms` (of type `int`, which defaults to `420`): Default file rights if created
- `(unlabeled)` (of type `string`): Path to write to

### `file.write.stream`

Stream data to a file. Returns a callback to write to the file. Execute with `null` to signify the end of the writing operation.

Type:
```
(?append : bool, ?perms : int, string) ->
(string?) -> unit
```

Arguments:

- `append` (of type `bool`, which defaults to `false`): Append data if file exists.
- `perms` (of type `int`, which defaults to `420`): Default file rights if created
- `(unlabeled)` (of type `string`): Path to write to

### `path.basename`

Get the base name of a path.

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `path.concat`

Concatenate two paths, using the appropriate directory separator.

Type:
```
(string, string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)
- `(unlabeled)` (of type `string`)

### `path.dirname`

Get the directory name of a path.

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `path.home.unrelate`

Expand path that start with '~' with the current home directory.

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `path.remove_extension`

Remove the file extension from a path.

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `string.apic.parse`

Parse APIC ID3v2 tags (such as those obtained in the APIC tag from `file.metadata.id3v2`). The returned values are: mime, picture type, description, and picture data.

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`): APIC data.

Methods:

- `description` (of type `string`): Description
- `mime` (of type `string`): Mime type
- `picture_type` (of type `int`): Picture type

## Filter

### `ffmpeg.filter.audio.input`

Attach an audio source to a filter's input

Type:
```
(?pass_metadata : bool, ffmpeg.filter.graph,
 source(audio=ffmpeg.audio.raw('a), video=none,
 midi=none)) -> ffmpeg.filter.audio
```

Arguments:

- `pass_metadata` (of type `bool`, which defaults to `true`): Pass liquidsoap's metadata to this stream
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `source(audio=ffmpeg.audio.raw('a), video=none, midi=none)`)

### `ffmpeg.filter.create`

Configure and launch a filter graph

Type:
```
(((ffmpeg.filter.graph) -> 'a)) -> 'a
```

Arguments:

- `(unlabeled)` (of type `(ffmpeg.filter.graph) -> 'a`)

### `ffmpeg.filter.video.input`

Attach a video source to a filter's input

Type:
```
(?pass_metadata : bool, ffmpeg.filter.graph,
 source(audio=none, video=ffmpeg.video.raw('a),
 midi=none)) -> ffmpeg.filter.video
```

Arguments:

- `pass_metadata` (of type `bool`, which defaults to `false`): Pass liquidsoap's metadata to this stream
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `source(audio=none, video=ffmpeg.video.raw('a), midi=none)`)

## Input

### `input`

Input an audio stream using the default operator.

Type:
```
(?id : string?, ?start : bool, ?on_start : (() -> unit),
 ?on_stop : (() -> unit), ?fallible : bool) ->
source(audio=pcm(?A), video=?B, midi=?C)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If `true`, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

## Interaction

### `audioscrobbler.nowplaying`

Submit a now playing song using the audioscrobbler protocol.

Type:
```
(user : string, password : string, ?host : string,
 ?port : int, ?length : bool, [string * string]) -> unit
```

Arguments:

- `user` (of type `string`)
- `password` (of type `string`)
- `host` (of type `string`, which defaults to `"post.audioscrobbler.com"`): Host for audioscrobbling submissions.
- `port` (of type `int`, which defaults to `80`): Port for audioscrobbling submissions.
- `length` (of type `bool`, which defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the "user" source type.
- `(unlabeled)` (of type `[string * string]`)

### `audioscrobbler.submit`

Submit a played song using the audioscrobbler protocol.

Type:
```
(?source : string, user : string, password : string,
 ?host : string, ?port : int, ?length : bool,
 [string * string]) -> unit
```

Arguments:

- `source` (of type `string`, which defaults to `"broadcast"`): Source for tracks. Should be one of: "broadcast", "user", "recommendation" or "unknown". Since liquidsoap is intended for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
- `user` (of type `string`)
- `password` (of type `string`)
- `host` (of type `string`, which defaults to `"post.audioscrobbler.com"`): Host for audioscrobbling submissions.
- `port` (of type `int`, which defaults to `80`): Port for audioscrobbling submissions.
- `length` (of type `bool`, which defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the "user" source type.
- `(unlabeled)` (of type `[string * string]`)

### `compress.multiband.interactive`

Create a multiband compressor whose parameters are interactive variables.

Type:
```
(?id : string, ?bands : int, source(audio=pcm('a),
 video=internal('b), midi=internal('c))) ->
source(audio=pcm('a), video=internal('b),
midi=internal('c))
```

Arguments:

- `id` (of type `string`, which defaults to `"compress"`): Id of the source. Variable names are prefixed with this.
- `bands` (of type `int`, which defaults to `5`): Number of bands.
- `(unlabeled)` (of type `source(audio=pcm('a), video=internal('b),
midi=internal('c))`): Source to compress.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `gain` (of type `() -> float`): Gain (dB).
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `rms` (of type `() -> float`): RMS or peak power (linear).
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `harbor.http.static`

Serve a static path.

Type:
```
(?port : int, ?path : string, ?browse : bool,
 ?content_type : ((string) -> string),
 ?headers : [string * string], string) -> unit
```

Arguments:

- `port` (of type `int`, which defaults to `8000`): Port for incoming harbor (http) connections.
- `path` (of type `string`, which defaults to `"/"`): Base path.
- `browse` (of type `bool`, which defaults to `false`): List files in directories.
- `content_type` (of type `(string) -> string`, which defaults to `<fun>`): Callback to specify Content-Type on a per file basis. Default: file.mime if compiled or file CLI if present.
- `headers` (of type `[string * string]`, which defaults to `[("Access-Control-Allow-Origin", "*")]`): Default response headers.
- `(unlabeled)` (of type `string`): Local path to be served.

### `harbor.https.static`

Serve a static path.

Type:
```
(?port : int, ?path : string, ?browse : bool,
 ?content_type : ((string) -> string),
 ?headers : [string * string], string) -> unit
```

Arguments:

- `port` (of type `int`, which defaults to `8000`): Port for incoming harbor (https) connections.
- `path` (of type `string`, which defaults to `"/"`): Base path.
- `browse` (of type `bool`, which defaults to `false`): List files in directories.
- `content_type` (of type `(string) -> string`, which defaults to `<fun>`): Callback to specify Content-Type on a per file basis. Default: file.mime if compiled or file CLI if present.
- `headers` (of type `[string * string]`, which defaults to `[("Access-Control-Allow-Origin", "*")]`): Default response headers.
- `(unlabeled)` (of type `string`): Local path to be served.

### `http.delete`

Perform a full Http DELETE request.

Type:
```
(?headers : [string * string], ?http_version : string?,
 ?redirect : bool, ?timeout : int, string) -> unit
```

Arguments:

- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `http_version` (of type `string?`, which defaults to `null`): Http request version.
- `redirect` (of type `bool`, which defaults to `true`): Perform redirections if needed.
- `timeout` (of type `int`, which defaults to `10`): Timeout for network operations (in seconds).
- `(unlabeled)` (of type `string`): Requested URL, e.g. "http://www.google.com/".

Methods:

- `headers` (of type `[string * string]`): HTTP headers.
- `protocol_version` (of type `string`): Version of the HTTP protocol.
- `status_code` (of type `int`): Status code.
- `status_message` (of type `string`): Status message.

### `http.delete.stream`

Perform a full Http DELETE request.

Type:
```
(?headers : [string * string], ?http_version : string?,
 ?redirect : bool, ?timeout : int, string,
 on_body_data : ((string?) -> unit)) -> unit
```

Arguments:

- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `http_version` (of type `string?`, which defaults to `null`): Http request version.
- `redirect` (of type `bool`, which defaults to `true`): Perform redirections if needed.
- `timeout` (of type `int`, which defaults to `10`): Timeout for network operations (in seconds).
- `(unlabeled)` (of type `string`): Requested URL, e.g. "http://www.google.com/".
- `on_body_data` (of type `(string?) -> unit`): function called when receiving response body data. `null` means that all the data has been passed.

Methods:

- `headers` (of type `[string * string]`): HTTP headers.
- `protocol_version` (of type `string`): Version of the HTTP protocol.
- `status_code` (of type `int`): Status code.
- `status_message` (of type `string`): Status message.

### `http.get`

Perform a full Http GET request.

Type:
```
(?headers : [string * string], ?http_version : string?,
 ?redirect : bool, ?timeout : int, string) -> string
```

Arguments:

- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `http_version` (of type `string?`, which defaults to `null`): Http request version.
- `redirect` (of type `bool`, which defaults to `true`): Perform redirections if needed.
- `timeout` (of type `int`, which defaults to `10`): Timeout for network operations (in seconds).
- `(unlabeled)` (of type `string`): Requested URL, e.g. "http://www.google.com/".

Methods:

- `headers` (of type `[string * string]`): HTTP headers.
- `protocol_version` (of type `string`): Version of the HTTP protocol.
- `status_code` (of type `int`): Status code.
- `status_message` (of type `string`): Status message.

### `http.get.stream`

Perform a full Http GET request.

Type:
```
(?headers : [string * string], ?http_version : string?,
 ?redirect : bool, ?timeout : int, string,
 on_body_data : ((string?) -> unit)) -> unit
```

Arguments:

- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `http_version` (of type `string?`, which defaults to `null`): Http request version.
- `redirect` (of type `bool`, which defaults to `true`): Perform redirections if needed.
- `timeout` (of type `int`, which defaults to `10`): Timeout for network operations (in seconds).
- `(unlabeled)` (of type `string`): Requested URL, e.g. "http://www.google.com/".
- `on_body_data` (of type `(string?) -> unit`): function called when receiving response body data. `null` means that all the data has been passed.

Methods:

- `headers` (of type `[string * string]`): HTTP headers.
- `protocol_version` (of type `string`): Version of the HTTP protocol.
- `status_code` (of type `int`): Status code.
- `status_message` (of type `string`): Status message.

### `http.head`

Perform a full Http HEAD request.

Type:
```
(?headers : [string * string], ?http_version : string?,
 ?redirect : bool, ?timeout : int, string) -> unit
```

Arguments:

- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `http_version` (of type `string?`, which defaults to `null`): Http request version.
- `redirect` (of type `bool`, which defaults to `true`): Perform redirections if needed.
- `timeout` (of type `int`, which defaults to `10`): Timeout for network operations (in seconds).
- `(unlabeled)` (of type `string`): Requested URL, e.g. "http://www.google.com/".

Methods:

- `headers` (of type `[string * string]`): HTTP headers.
- `protocol_version` (of type `string`): Version of the HTTP protocol.
- `status_code` (of type `int`): Status code.
- `status_message` (of type `string`): Status message.

### `http.head.stream`

Perform a full Http HEAD request.

Type:
```
(?headers : [string * string], ?http_version : string?,
 ?redirect : bool, ?timeout : int, string,
 on_body_data : ((string?) -> unit)) -> unit
```

Arguments:

- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `http_version` (of type `string?`, which defaults to `null`): Http request version.
- `redirect` (of type `bool`, which defaults to `true`): Perform redirections if needed.
- `timeout` (of type `int`, which defaults to `10`): Timeout for network operations (in seconds).
- `(unlabeled)` (of type `string`): Requested URL, e.g. "http://www.google.com/".
- `on_body_data` (of type `(string?) -> unit`): function called when receiving response body data. `null` means that all the data has been passed.

Methods:

- `headers` (of type `[string * string]`): HTTP headers.
- `protocol_version` (of type `string`): Version of the HTTP protocol.
- `status_code` (of type `int`): Status code.
- `status_message` (of type `string`): Status message.

### `http.post`

Perform a full Http POST request`.

Type:
```
(?data : string, ?headers : [string * string],
 ?http_version : string?, ?redirect : bool,
 ?timeout : int, string) -> string
```

Arguments:

- `data` (of type `string`, which defaults to `""`): POST data.
- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `http_version` (of type `string?`, which defaults to `null`): Http request version.
- `redirect` (of type `bool`, which defaults to `true`): Perform redirections if needed.
- `timeout` (of type `int`, which defaults to `10`): Timeout for network operations (in seconds).
- `(unlabeled)` (of type `string`): Requested URL, e.g. "http://www.google.com/".

Methods:

- `headers` (of type `[string * string]`): HTTP headers.
- `protocol_version` (of type `string`): Version of the HTTP protocol.
- `status_code` (of type `int`): Status code.
- `status_message` (of type `string`): Status message.

### `http.post.stream`

Perform a full Http POST request`.

Type:
```
(?data : string, ?headers : [string * string],
 ?http_version : string?, ?redirect : bool,
 ?timeout : int, string,
 on_body_data : ((string?) -> unit)) -> unit
```

Arguments:

- `data` (of type `string`, which defaults to `""`): POST data.
- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `http_version` (of type `string?`, which defaults to `null`): Http request version.
- `redirect` (of type `bool`, which defaults to `true`): Perform redirections if needed.
- `timeout` (of type `int`, which defaults to `10`): Timeout for network operations (in seconds).
- `(unlabeled)` (of type `string`): Requested URL, e.g. "http://www.google.com/".
- `on_body_data` (of type `(string?) -> unit`): function called when receiving response body data. `null` means that all the data has been passed.

Methods:

- `headers` (of type `[string * string]`): HTTP headers.
- `protocol_version` (of type `string`): Version of the HTTP protocol.
- `status_code` (of type `int`): Status code.
- `status_message` (of type `string`): Status message.

### `http.put`

Perform a full Http PUT request.

Type:
```
(?data : string, ?headers : [string * string],
 ?http_version : string?, ?redirect : bool,
 ?timeout : int, string) -> string
```

Arguments:

- `data` (of type `string`, which defaults to `""`): POST data.
- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `http_version` (of type `string?`, which defaults to `null`): Http request version.
- `redirect` (of type `bool`, which defaults to `true`): Perform redirections if needed.
- `timeout` (of type `int`, which defaults to `10`): Timeout for network operations (in seconds).
- `(unlabeled)` (of type `string`): Requested URL, e.g. "http://www.google.com/".

Methods:

- `headers` (of type `[string * string]`): HTTP headers.
- `protocol_version` (of type `string`): Version of the HTTP protocol.
- `status_code` (of type `int`): Status code.
- `status_message` (of type `string`): Status message.

### `http.put.stream`

Perform a full Http PUT request.

Type:
```
(?data : string, ?headers : [string * string],
 ?http_version : string?, ?redirect : bool,
 ?timeout : int, string,
 on_body_data : ((string?) -> unit)) -> unit
```

Arguments:

- `data` (of type `string`, which defaults to `""`): POST data.
- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `http_version` (of type `string?`, which defaults to `null`): Http request version.
- `redirect` (of type `bool`, which defaults to `true`): Perform redirections if needed.
- `timeout` (of type `int`, which defaults to `10`): Timeout for network operations (in seconds).
- `(unlabeled)` (of type `string`): Requested URL, e.g. "http://www.google.com/".
- `on_body_data` (of type `(string?) -> unit`): function called when receiving response body data. `null` means that all the data has been passed.

Methods:

- `headers` (of type `[string * string]`): HTTP headers.
- `protocol_version` (of type `string`): Version of the HTTP protocol.
- `status_code` (of type `int`): Status code.
- `status_message` (of type `string`): Status message.

### `http.response`

Create a HTTP response string.

Type:
```
(?protocol : string, ?code : int,
 ?headers : [string * string], ?content_type : string,
 ?data : string) -> () -> string
```

Arguments:

- `protocol` (of type `string`, which defaults to `"HTTP/1.1"`): HTTP protocol used.
- `code` (of type `int`, which defaults to `200`): Response code.
- `headers` (of type `[string * string]`, which defaults to `[]`): Response headers.
- `content_type` (of type `string`, which defaults to `""`): Content type for the data.
- `data` (of type `string`, which defaults to `""`): Response data.

### `http.response.stream`

Create a streamed HTTP response.

Type:
```
(?protocol : string, ?code : int,
 ?headers : [string * string], ?content_type : string,
 data_len : 'a, data : (() -> string)) -> () -> string
```

Arguments:

- `protocol` (of type `string`, which defaults to `"HTTP/1.1"`): HTTP protocol used.
- `code` (of type `int`, which defaults to `200`): Response code.
- `headers` (of type `[string * string]`, which defaults to `[]`): Response headers.
- `content_type` (of type `string`, which defaults to `""`): Content type for the data.
- `data_len` (of type `'a`): Response length in bytes.
- `data` (of type `() -> string`): Response data.

### `icy.update_metadata`

Update metata on an icecast mountpoint using the ICY protocol.

Type:
```
(?host : string, ?port : int, ?user : string,
 ?password : string, ?mount : string, ?icy_id : int,
 ?protocol : string, ?encoding : string?,
 ?headers : [string * string], [string * string]) -> unit
```

Arguments:

- `host` (of type `string`, which defaults to `"localhost"`)
- `port` (of type `int`, which defaults to `8000`)
- `user` (of type `string`, which defaults to `"source"`)
- `password` (of type `string`, which defaults to `"hackme"`)
- `mount` (of type `string`, which defaults to `""`): Source mount point. Mandatory when streaming to icecast.
- `icy_id` (of type `int`, which defaults to `1`): Shoutcast source ID. Only supported by Shoutcast v2.
- `protocol` (of type `string`, which defaults to `"http"`): Protocol to use. One of: "icy", "http" or "https"
- `encoding` (of type `string?`, which defaults to `null`): Encoding used to send metadata, default (UTF-8) if null.
- `headers` (of type `[string * string]`, which defaults to `[("User-Agent", "Liquidsoap/2.0.0 (Unix; OCaml 4.12.0)")]`): Additional headers.
- `(unlabeled)` (of type `[string * string]`)

### `interactive.bool`

Read a boolean from an interactive input.

Type:
```
(?description : string, ?osc : string, string, bool) ->
() -> bool
```

Arguments:

- `description` (of type `string`, which defaults to `""`): Description of the variable.
- `osc` (of type `string`, which defaults to `""`): OSC address.
- `(unlabeled)` (of type `string`): Name of the variable.
- `(unlabeled)` (of type `bool`): Initial value.

Methods:

- `remove` (of type `() -> unit`)
- `set` (of type `(bool) -> unit`)

### `interactive.float`

Read a float from an interactive input.

Type:
```
(?min : float, ?max : float, ?step : float,
 ?description : string, ?unit : string, ?osc : string,
 string, float) -> () -> float
```

Arguments:

- `min` (of type `float`, which defaults to `-inf`): Minimal value.
- `max` (of type `float`, which defaults to `inf`): Maximal value.
- `step` (of type `float`, which defaults to `0.1`): Typical variation of the value.
- `description` (of type `string`, which defaults to `""`): Description of the variable.
- `unit` (of type `string`, which defaults to `""`): Unit for the variable.
- `osc` (of type `string`, which defaults to `""`): OSC address.
- `(unlabeled)` (of type `string`): Name of the variable.
- `(unlabeled)` (of type `float`): Initial value.

Methods:

- `remove` (of type `() -> unit`)
- `set` (of type `(float) -> unit`)

### `interactive.harbor`

Expose interactive variables through habor http server.

Type:
```
(?port : int, ?uri : string) -> unit
```

Arguments:

- `port` (of type `int`, which defaults to `8000`): Port of the server.
- `uri` (of type `string`, which defaults to `"/interactive"`): URI of the server.

### `interactive.int`

Read an integer from an interactive input.

Type:
```
(?description : string, ?osc : string, string, int) ->
() -> int
```

Arguments:

- `description` (of type `string`, which defaults to `""`): Description of the variable.
- `osc` (of type `string`, which defaults to `""`): OSC address.
- `(unlabeled)` (of type `string`): Name of the variable.
- `(unlabeled)` (of type `int`): Initial value.

Methods:

- `remove` (of type `() -> unit`)
- `set` (of type `(int) -> unit`)

### `interactive.string`

Read a string from an interactive input.

Type:
```
(?description : string, ?osc : string, string, string) ->
() -> string
```

Arguments:

- `description` (of type `string`, which defaults to `""`): Description of the variable.
- `osc` (of type `string`, which defaults to `""`): OSC address.
- `(unlabeled)` (of type `string`): Name of the variable.
- `(unlabeled)` (of type `string`): Initial value.

Methods:

- `remove` (of type `() -> unit`)
- `set` (of type `(string) -> unit`)

### `metadata.getter`

Create a getter from a metadata: this is a string, whose value can be changed with a metadata.

Type:
```
(string, string, source('a)) -> () -> string
```

Arguments:

- `(unlabeled)` (of type `string`): Initial value.
- `(unlabeled)` (of type `string`): Metadata on which the value should be updated.
- `(unlabeled)` (of type `source('a)`): Source containing the metadata.

### `metadata.getter.float`

Create a float getter from a metadata: this is a float, whose value can be changed with a metadata.

Type:
```
(float, string, source('a)) -> () -> float
```

Arguments:

- `(unlabeled)` (of type `float`): Initial value.
- `(unlabeled)` (of type `string`): Metadata on which the value should be updated.
- `(unlabeled)` (of type `source('a)`): Source containing the metadata.

### `osc.bool`

Read from an OSC path.

Type:
```
(string, bool) -> () -> bool
```

Arguments:

- `(unlabeled)` (of type `string`): OSC path.
- `(unlabeled)` (of type `bool`): Initial value.

### `osc.float`

Read from an OSC path.

Type:
```
(string, float) -> () -> float
```

Arguments:

- `(unlabeled)` (of type `string`): OSC path.
- `(unlabeled)` (of type `float`): Initial value.

### `osc.float_pair`

Read from an OSC path.

Type:
```
(string, (float * float)) -> () -> float * float
```

Arguments:

- `(unlabeled)` (of type `string`): OSC path.
- `(unlabeled)` (of type `float * float`): Initial value.

### `osc.int`

Read from an OSC path.

Type:
```
(string, int) -> () -> int
```

Arguments:

- `(unlabeled)` (of type `string`): OSC path.
- `(unlabeled)` (of type `int`): Initial value.

### `osc.int_pair`

Read from an OSC path.

Type:
```
(string, (int * int)) -> () -> int * int
```

Arguments:

- `(unlabeled)` (of type `string`): OSC path.
- `(unlabeled)` (of type `int * int`): Initial value.

### `osc.on_bool`

Register a callback on OSC messages.

Type:
```
(string, ((bool) -> unit)) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`): OSC path.
- `(unlabeled)` (of type `(bool) -> unit`): Callback function.

### `osc.on_float`

Register a callback on OSC messages.

Type:
```
(string, ((float) -> unit)) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`): OSC path.
- `(unlabeled)` (of type `(float) -> unit`): Callback function.

### `osc.on_float_pair`

Register a callback on OSC messages.

Type:
```
(string, (((float * float)) -> unit)) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`): OSC path.
- `(unlabeled)` (of type `((float * float)) -> unit`): Callback function.

### `osc.on_int`

Register a callback on OSC messages.

Type:
```
(string, ((int) -> unit)) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`): OSC path.
- `(unlabeled)` (of type `(int) -> unit`): Callback function.

### `osc.on_int_pair`

Register a callback on OSC messages.

Type:
```
(string, (((int * int)) -> unit)) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`): OSC path.
- `(unlabeled)` (of type `((int * int)) -> unit`): Callback function.

### `osc.on_string`

Register a callback on OSC messages.

Type:
```
(string, ((string) -> unit)) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`): OSC path.
- `(unlabeled)` (of type `(string) -> unit`): Callback function.

### `osc.on_string_pair`

Register a callback on OSC messages.

Type:
```
(string, (((string * string)) -> unit)) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`): OSC path.
- `(unlabeled)` (of type `((string * string)) -> unit`): Callback function.

### `osc.send_bool`

Send a value to an OSC client.

Type:
```
(host : string, port : int, string, bool) -> unit
```

Arguments:

- `host` (of type `string`): OSC client address.
- `port` (of type `int`): OSC client port.
- `(unlabeled)` (of type `string`): OSC path.
- `(unlabeled)` (of type `bool`): Value to send.

### `osc.send_float`

Send a value to an OSC client.

Type:
```
(host : string, port : int, string, float) -> unit
```

Arguments:

- `host` (of type `string`): OSC client address.
- `port` (of type `int`): OSC client port.
- `(unlabeled)` (of type `string`): OSC path.
- `(unlabeled)` (of type `float`): Value to send.

### `osc.send_float_pair`

Send a value to an OSC client.

Type:
```
(host : string, port : int, string, (float * float)) ->
unit
```

Arguments:

- `host` (of type `string`): OSC client address.
- `port` (of type `int`): OSC client port.
- `(unlabeled)` (of type `string`): OSC path.
- `(unlabeled)` (of type `float * float`): Value to send.

### `osc.send_int`

Send a value to an OSC client.

Type:
```
(host : string, port : int, string, int) -> unit
```

Arguments:

- `host` (of type `string`): OSC client address.
- `port` (of type `int`): OSC client port.
- `(unlabeled)` (of type `string`): OSC path.
- `(unlabeled)` (of type `int`): Value to send.

### `osc.send_int_pair`

Send a value to an OSC client.

Type:
```
(host : string, port : int, string, (int * int)) -> unit
```

Arguments:

- `host` (of type `string`): OSC client address.
- `port` (of type `int`): OSC client port.
- `(unlabeled)` (of type `string`): OSC path.
- `(unlabeled)` (of type `int * int`): Value to send.

### `osc.send_string`

Send a value to an OSC client.

Type:
```
(host : string, port : int, string, string) -> unit
```

Arguments:

- `host` (of type `string`): OSC client address.
- `port` (of type `int`): OSC client port.
- `(unlabeled)` (of type `string`): OSC path.
- `(unlabeled)` (of type `string`): Value to send.

### `osc.send_string_pair`

Send a value to an OSC client.

Type:
```
(host : string, port : int, string, (string * string)) ->
unit
```

Arguments:

- `host` (of type `string`): OSC client address.
- `port` (of type `int`): OSC client port.
- `(unlabeled)` (of type `string`): OSC path.
- `(unlabeled)` (of type `string * string`): Value to send.

### `osc.string`

Read from an OSC path.

Type:
```
(string, string) -> () -> string
```

Arguments:

- `(unlabeled)` (of type `string`): OSC path.
- `(unlabeled)` (of type `string`): Initial value.

### `osc.string_pair`

Read from an OSC path.

Type:
```
(string, (string * string)) -> () -> string * string
```

Arguments:

- `(unlabeled)` (of type `string`): OSC path.
- `(unlabeled)` (of type `string * string`): Initial value.

### `print`

Print on standard output.

Type:
```
(?newline : bool, 'a) -> unit
```

Arguments:

- `newline` (of type `bool`, which defaults to `true`): If true, a newline is added after displaying the value.
- `(unlabeled)` (of type `'a`)

### `prometheus.counter`

Register a prometheus counter

Type:
```
(help : string, ?namespace : string, ?subsystem : string,
 labels : [string], string) ->
(label_values : [string]) -> (float) -> unit
```

Arguments:

- `help` (of type `string`): Help of the metric
- `namespace` (of type `string`, which defaults to `""`): namespace of the metric
- `subsystem` (of type `string`, which defaults to `""`): subsystem of the metric
- `labels` (of type `[string]`): labels for the metric
- `(unlabeled)` (of type `string`): Name of the metric

### `prometheus.gauge`

Register a prometheus gauge

Type:
```
(help : string, ?namespace : string, ?subsystem : string,
 labels : [string], string) ->
(label_values : [string]) -> (float) -> unit
```

Arguments:

- `help` (of type `string`): Help of the metric
- `namespace` (of type `string`, which defaults to `""`): namespace of the metric
- `subsystem` (of type `string`, which defaults to `""`): subsystem of the metric
- `labels` (of type `[string]`): labels for the metric
- `(unlabeled)` (of type `string`): Name of the metric

### `prometheus.summary`

Register a prometheus summary

Type:
```
(help : string, ?namespace : string, ?subsystem : string,
 labels : [string], string) ->
(label_values : [string]) -> (float) -> unit
```

Arguments:

- `help` (of type `string`): Help of the metric
- `namespace` (of type `string`, which defaults to `""`): namespace of the metric
- `subsystem` (of type `string`, which defaults to `""`): subsystem of the metric
- `labels` (of type `[string]`): labels for the metric
- `(unlabeled)` (of type `string`): Name of the metric

### `server.broadcast`

Restart all server clients waiting on the given condition.

Type:
```
(('a * ('b * (() -> 'c)))) -> 'c
```

Arguments:

- `(unlabeled)` (of type `'a * ('b * (() -> 'c))`): condition

### `server.register`

Register a command. You can then execute this function through the server, either telnet or socket.

Type:
```
(?namespace : string?, ?description : string,
 ?usage : string?, string, ((string) -> string)) -> unit
```

Arguments:

- `namespace` (of type `string?`, which defaults to `null`): Used to group multiple commands for the same functionality. If specified, the command will be named `namespace.command`.
- `description` (of type `string`, which defaults to `"No documentation available."`): A description of your command.
- `usage` (of type `string?`, which defaults to `null`): Description of how the command should be used.
- `(unlabeled)` (of type `string`): Name of the command.
- `(unlabeled)` (of type `(string) -> string`): Function called when the command is executed. It takes as argument the argument passed on the commandline and returns the message which will be printed on the commandline.

### `server.register_operator`

Register an operator. This is mainly used to populate the `list` command on the telnet server.

Type:
```
(kind : string, string) -> unit
```

Arguments:

- `kind` (of type `string`): Kind of the operator (generally, the name of the function used to create it).
- `(unlabeled)` (of type `string`): Identifier of the operator.

### `server.signal`

Restart one server client waiting on the given condition.

Type:
```
(('a * ((() -> 'b) * 'c))) -> 'b
```

Arguments:

- `(unlabeled)` (of type `'a * ((() -> 'b) * 'c)`): condition

### `server.telnet`

Enable telnet server.

Type:
```
() -> unit
```

Arguments:


## Interactive

### `interactive.bool.remove`

Remove an interactive variable. flag hidden

Type:
```
(string) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`): Name of the variable.

### `interactive.load`

Load the value of interactive variables from a file.

Type:
```
(string) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`): Name of the file.

### `interactive.persistent`

Make the value of interactive variables persistent: they are loaded from the given file and stored there whenever updated. This function should be called after all interactive variables have been defined (variables not declared yet will not be loaded).

Type:
```
(string) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`): Name of the file.

### `interactive.save`

Save the value of all interactive variables in a file.

Type:
```
(string) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`): Name of the file.

## Liquidsoap

### `add_decoder`

Register an external decoder. The encoder should output in WAV format to his standard output (stdout) and read data from its standard input (stdin).

Type:
```
(name : string, description : string, ?mimes : [string],
 ?file_extensions : [string], ?priority : int,
 test : ((string) -> int), string) -> unit
```

Arguments:

- `name` (of type `string`): Format/decoder's name.
- `description` (of type `string`): Description of the decoder.
- `mimes` (of type `[string]`, which defaults to `[]`): List of mime types supported by this decoder. Empty means any mime type should be accepted.
- `file_extensions` (of type `[string]`, which defaults to `[]`): List of file extensions. Empty means any file extension should be accepted.
- `priority` (of type `int`, which defaults to `1`): Decoder priority
- `test` (of type `(string) -> int`): Function used to determine if a file should be decoded by the decoder. Returned values are: 0: no decodable audio, -1: decodable audio but number of audio channels unknown, x: fixed number of decodable audio channels.
- `(unlabeled)` (of type `string`): Process to start.

### `add_metadata_resolver`

Register an external file metadata decoder.

Type:
```
(string, ((string) -> [string * string])) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`): Format/resolver's name.
- `(unlabeled)` (of type `(string) -> [string * string]`): Process to start. The function takes the format and filename as argument and returns a list of (name,value) fields.

### `add_oblivious_decoder`

Register an external file decoder. The encoder should output in WAV format to his standard output (stdout) and read data from the file it receives. The estimated remaining duration for this decoder will be unknown until the `buffer` last seconds of the file. If possible, it is recommended to decode from stdin and use `add_decoder`.

Type:
```
(name : string, description : string,
 test : ((string) -> int), ?priority : int,
 ?mimes : [string], ?file_extensions : [string],
 ?buffer : float, ((string) -> string)) -> unit
```

Arguments:

- `name` (of type `string`): Format/decoder's name.
- `description` (of type `string`): Description of the decoder.
- `test` (of type `(string) -> int`): Function used to determine if a file should be decoded by the decoder. Returned values are: 0: no decodable audio, -1: decodable audio but number of audio channels unknown, x: fixed number of decodable audio channels.
- `priority` (of type `int`, which defaults to `1`): Decoder priority
- `mimes` (of type `[string]`, which defaults to `[]`): List of mime types supported by this decoder. Empty means any mime type should be accepted.
- `file_extensions` (of type `[string]`, which defaults to `[]`): List of file extensions. Empty means any file extension should be accepted.
- `buffer` (of type `float`, which defaults to `5.`)
- `(unlabeled)` (of type `(string) -> string`): Process to start. The function takes the filename as argument and returns the process to start.

### `add_protocol`

Register a new protocol.

Type:
```
(?temporary : bool, ?static : bool, ?syntax : string,
 ?doc : string, string,
 ((rlog : ((string) -> unit), maxtime : float, string) ->
  [string])) -> unit
```

Arguments:

- `temporary` (of type `bool`, which defaults to `false`): if true, file is removed when it is finished.
- `static` (of type `bool`, which defaults to `false`): if true, then requests can be resolved once and for all. Typically, static protocols can be used to create infallible sources.
- `syntax` (of type `string`, which defaults to `"Undocumented"`): URI syntax.
- `doc` (of type `string`, which defaults to `"Undocumented"`): Protocol documentation.
- `(unlabeled)` (of type `string`): Protocol name. Resolver will be called on uris of the form: `<protocol name>:...`.
- `(unlabeled)` (of type `(rlog : ((string) -> unit), maxtime : float, string) ->
[string]`): Protocol resolver. Receives a function to log protocol resolution, the `<arg>` in `<protocol name>:<arg>` and the max delay that resolution should take.

### `assert`

Ensure that a condition is satisfied (raise `error.assertion` exception otherwise).

Type:
```
(bool) -> unit
```

Arguments:

- `(unlabeled)` (of type `bool`): Condition which should be satisfied.

### `audio.channels`

Channels for audio.

Type:
```
() -> int
```

Arguments:


### `audio.samplerate`

Samplerate for audio.

Type:
```
() -> int
```

Arguments:


### `clock`

Assign a new clock to the given source (and to other time-dependent sources) and return the source. It is a conveniency wrapper around clock.assign_new(), allowing more concise scripts in some cases.

Type:
```
(?sync : string, ?id : string?, source('a)) -> source('a)
```

Arguments:

- `sync` (of type `string`, which defaults to `"auto"`): Synchronization mode. One of: `"auto"`, `"cpu"`, or `"none"`. Defaults to `"auto"`, which synchronizes with the CPU clock if none of the active sources are attached to their own clock (e.g. ALSA input, etc). `"cpu"` always synchronizes with the CPU clock. `"none"` removes all synchronization control.
- `id` (of type `string?`, which defaults to `null`)
- `(unlabeled)` (of type `source('a)`)

### `clock.assign_new`

Create a new clock and assign it to a list of sources.

Type:
```
(?id : string?, ?sync : string, [source('a)]) -> unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Identifier for the new clock. The default empty string means that the identifier of the first source will be used.
- `sync` (of type `string`, which defaults to `"auto"`): Synchronization mode. One of: `"auto"`, `"cpu"`, or `"none"`. Defaults to `"auto"`, which synchronizes with the CPU clock if none of the active sources are attached to their own clock (e.g. ALSA input, etc). `"cpu"` always synchronizes with the CPU clock. `"none"` removes all synchronization control.
- `(unlabeled)` (of type `[source('a)]`): List of sources to which the new clock will be assigned.

### `clock.log`

Create a log of clock times for all the clocks initially present. The log is in a simple format which you can directly use with gnuplot.

Type:
```
(?delay : float, ?every : float, string) -> unit
```

Arguments:

- `delay` (of type `float`, which defaults to `0.`): Delay before setting up the clock logger. This should be used to ensure that the logger starts only after the clocks are created.
- `every` (of type `float`, which defaults to `1.`): Polling interval.
- `(unlabeled)` (of type `string`): Path of the log file.

### `clock.status`

Get the current time (in ticks) for all allocated clocks.

Type:
```
() -> [string * int]
```

Arguments:


### `clock.status.seconds`

Get the current time in seconds for all allocated clocks.

Type:
```
() -> [string * float]
```

Arguments:


### `clock.unify`

Enforce that a list of sources all belong to the same clock.

Type:
```
([source('a)]) -> unit
```

Arguments:

- `(unlabeled)` (of type `[source('a)]`)

### `configure.bindir`

Liquidsoap's Internal script directory.

Type:
```
string
```

Arguments:


### `configure.default_font`

Liquidsoap's default font file.

Type:
```
string
```

Arguments:


### `configure.libdir`

Liquidsoap's library directory.

Type:
```
string
```

Arguments:


### `configure.logdir`

Liquidsoap's logging directory.

Type:
```
string
```

Arguments:


### `configure.rundir`

Liquidsoap's PID file directory.

Type:
```
string
```

Arguments:


### `enable_external_faad_decoder`

Enable or disable external FAAD (AAC/AAC+/M4A) decoders. Does not work on Win32. Please note that built-in support for faad is available in liquidsoap if compiled and should be preferred over the external decoder.

Type:
```
() -> unit
```

Arguments:


### `enable_external_ffmpeg_decoder`

Enable ffmpeg decoder.

Type:
```
() -> unit
```

Arguments:


### `enable_external_flac_decoder`

Enable external FLAC decoders. Please note that built-in support for  FLAC is available in liquidsoap if compiled and should be preferred over the external decoder.

Type:
```
() -> unit
```

Arguments:


### `enable_external_mpc_decoder`

Enable external Musepack decoder.

Type:
```
() -> unit
```

Arguments:


### `enable_replaygain_metadata`

Enable ReplayGain metadata resolver. This resolver will process any file decoded by Liquidsoap and add a `replaygain_track_gain` metadata when this value could be computed. For a finer-grained replay gain processing, use the `replaygain:` protocol.

Type:
```
(?delay : float, ?extract_replaygain : string) -> unit
```

Arguments:

- `delay` (of type `float`, which defaults to `-1.`): Maximum delay for extracting metadata.
- `extract_replaygain` (of type `string`, which defaults to `"/usr/share/liquidsoap/2.0.0/bin/extract-replaygain"`): The extraction program.

### `encoder.content_type`

Return the content-type (mime) of an encoder, if known.

Type:
```
(format('a)) -> string
```

Arguments:

- `(unlabeled)` (of type `format('a)`)

### `encoder.extension`

Return the file extension of an encoder, if known.

Type:
```
(format('a)) -> string
```

Arguments:

- `(unlabeled)` (of type `format('a)`)

### `error.kind`

Get the kind of an error

Type:
```
(error) -> string
```

Arguments:

- `(unlabeled)` (of type `error`)

### `error.message`

Get the message of an error

Type:
```
(error) -> string?
```

Arguments:

- `(unlabeled)` (of type `error`)

### `error.raise`

Raise an error.

Type:
```
(error, ?string?) -> 'a
```

Arguments:

- `(unlabeled)` (of type `error`): Error kind.
- `(unlabeled)` (of type `string?`, which defaults to `null`): Description of the error.

### `error.register`

Register an error of the given kind

Type:
```
(string) -> error
```

Arguments:

- `(unlabeled)` (of type `string`): Kind of the error

### `failwith`

Major failure.

Type:
```
(string?) -> 'a
```

Arguments:

- `(unlabeled)` (of type `string?`): Explanation about the failure.

### `frame.duration`

Duration of a frame.

Type:
```
() -> float
```

Arguments:


### `fst`

Get the first component of a pair.

Type:
```
(('a * 'b)) -> 'a
```

Arguments:

- `(unlabeled)` (of type `'a * 'b`)

### `garbage_collect`

Trigger full major garbage collection.

Type:
```
() -> unit
```

Arguments:


### `getter`

Create a getter.

Type:
```
({'a}) -> {'a}
```

Arguments:

- `(unlabeled)` (of type `{'a}`): Value from which the getter should be created.

### `getter.case`

Return a value depending on whether the getter is constant or not.

Type:
```
({'a}, (('a) -> 'c), (((() -> 'a)) -> 'c)) -> 'c
```

Arguments:

- `(unlabeled)` (of type `{'a}`): Getter to inspect.
- `(unlabeled)` (of type `('a) -> 'c`)
- `(unlabeled)` (of type `((() -> 'a)) -> 'c`)

### `getter.changes`

Detect whether the value of the getter changes.

Type:
```
({'a}) -> () -> bool where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `{'a} where 'a is an orderable type`)

### `getter.float_of_int`

Convert an int getter to a float getter.

Type:
```
({int}) -> {float}
```

Arguments:

- `(unlabeled)` (of type `{int}`)

### `getter.function`

Construct a function returning the value of a getter.

Type:
```
({'a}) -> () -> 'a
```

Arguments:

- `(unlabeled)` (of type `{'a}`)

### `getter.get`

Get the value of a getter.

Type:
```
({'a}) -> 'a
```

Arguments:

- `(unlabeled)` (of type `{'a}`)

### `getter.int_of_float`

Convert a float getter to a int getter.

Type:
```
({float}) -> {int}
```

Arguments:

- `(unlabeled)` (of type `{float}`)

### `getter.is_constant`

Determine if a getter is a constant.

Type:
```
({'a}) -> bool
```

Arguments:

- `(unlabeled)` (of type `{'a}`)

### `getter.map`

Apply a function on a getter.

Type:
```
((('a) -> 'b), {'a}) -> {'b}
```

Arguments:

- `(unlabeled)` (of type `('a) -> 'b`): Function to apply.
- `(unlabeled)` (of type `{'a}`)

### `getter.map.memoize`

Apply a function on a getter. If the input value has not changed compared to last call, the previous result is returned without computing the function again.

Type:
```
((('a) -> 'b), {'a}) -> {'b}
where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `('a) -> 'b where 'a is an orderable type`): Function to apply.
- `(unlabeled)` (of type `{'a} where 'a is an orderable type`)

### `getter.on_change`

Execute a function when the value of the getter changes.

Type:
```
((('a) -> unit), {'a}) -> () -> 'a
where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `('a) -> unit where 'a is an orderable type`)
- `(unlabeled)` (of type `{'a} where 'a is an orderable type`)

### `harbor.http.register`

Register a HTTP handler on the harbor. The given function receives as argument the full requested uri (e.g. "foo?var=bar"), http protocol version, possible input data and the list of HTTP headers and returns the answer sent to the client, including HTTP headers. Registered uri can be regular expressions (e.g. ".+\.php") and can override default metadata handlers. Response is a string getter, i.e. either of type `string` or type `()->string`. In the later case, getter function will be called until it returns an empty string.

Type:
```
(?port : int, ?method : string, string,
 ((protocol : string, data : string,
   headers : [string * string], string) -> {string})) ->
unit
```

Arguments:

- `port` (of type `int`, which defaults to `8000`): Port to server.
- `method` (of type `string`, which defaults to `"GET"`): Accepted method ("GET" / "POST" / "PUT" / "DELETE" / "HEAD" / "OPTIONS").
- `(unlabeled)` (of type `string`): URI to serve.
- `(unlabeled)` (of type `(protocol : string, data : string,
 headers : [string * string], string) -> {string}`): Function to execute. Method argument is "PUT" or "GET", protocol argument is "HTTP/1.1" or "HTTP/1.0" etc., data argument contains data passed in case of a PUT request, and "" otherwise. Headers argument contains the HTTP headers. Unlabeled argument contains the requested URI.

### `harbor.http.remove`

Remove a registered HTTP handler on the harbor.

Type:
```
(?port : int, ?method : string, string) -> unit
```

Arguments:

- `port` (of type `int`, which defaults to `8000`): Port to server.
- `method` (of type `string`, which defaults to `"GET"`): Method served.
- `(unlabeled)` (of type `string`): URI served.

### `harbor.https.register`

Register a HTTPS handler on the harbor. The given function receives as argument the full requested uri (e.g. "foo?var=bar"), http protocol version, possible input data and the list of HTTP headers and returns the answer sent to the client, including HTTP headers. Registered uri can be regular expressions (e.g. ".+\.php") and can override default metadata handlers. Response is a string getter, i.e. either of type `string` or type `()->string`. In the later case, getter function will be called until it returns an empty string.

Type:
```
(?port : int, ?method : string, string,
 ((protocol : string, data : string,
   headers : [string * string], string) -> {string})) ->
unit
```

Arguments:

- `port` (of type `int`, which defaults to `8000`): Port to server.
- `method` (of type `string`, which defaults to `"GET"`): Accepted method ("GET" / "POST" / "PUT" / "DELETE" / "HEAD" / "OPTIONS").
- `(unlabeled)` (of type `string`): URI to serve.
- `(unlabeled)` (of type `(protocol : string, data : string,
 headers : [string * string], string) -> {string}`): Function to execute. Method argument is "PUT" or "GET", protocol argument is "HTTP/1.1" or "HTTP/1.0" etc., data argument contains data passed in case of a PUT request, and "" otherwise. Headers argument contains the HTTP headers. Unlabeled argument contains the requested URI.

### `harbor.https.remove`

Remove a registered HTTPS handler on the harbor.

Type:
```
(?port : int, ?method : string, string) -> unit
```

Arguments:

- `port` (of type `int`, which defaults to `8000`): Port to server.
- `method` (of type `string`, which defaults to `"GET"`): Method served.
- `(unlabeled)` (of type `string`): URI served.

### `http.error`

Base error for http

Type:
```
error
```

Arguments:


### `liquidsoap.executable`

Path to the Liquidsoap executable.

Type:
```
string
```

Arguments:


### `liquidsoap.version`

Liquidsoap version string.

Type:
```
string
```

Arguments:


### `log`

Log a message.

Type:
```
(?label : string, ?level : int, string) -> unit
```

Arguments:

- `label` (of type `string`, which defaults to `"lang"`)
- `level` (of type `int`, which defaults to `3`)
- `(unlabeled)` (of type `string`)

### `log.critical`

Log a critical message

Type:
```
(?label : string, string) -> unit
```

Arguments:

- `label` (of type `string`, which defaults to `"lang"`)
- `(unlabeled)` (of type `string`)

### `log.debug`

Log a debug message

Type:
```
(?label : string, string) -> unit
```

Arguments:

- `label` (of type `string`, which defaults to `"lang"`)
- `(unlabeled)` (of type `string`)

### `log.file`

Get and set the file logging

Type:
```
() -> bool
```

Arguments:


### `log.important`

Log an important message

Type:
```
(?label : string, string) -> unit
```

Arguments:

- `label` (of type `string`, which defaults to `"lang"`)
- `(unlabeled)` (of type `string`)

### `log.info`

Log a normal message

Type:
```
(?label : string, string) -> unit
```

Arguments:

- `label` (of type `string`, which defaults to `"lang"`)
- `(unlabeled)` (of type `string`)

### `log.level`

Get and set the log level.

Type:
```
() -> int
```

Arguments:


### `log.severe`

Log a severe message

Type:
```
(?label : string, string) -> unit
```

Arguments:

- `label` (of type `string`, which defaults to `"lang"`)
- `(unlabeled)` (of type `string`)

### `log.stdout`

Get and set logging to stdout

Type:
```
() -> bool
```

Arguments:


### `null`

Create a nullable value.

Type:
```
(?'a?) -> 'a?
```

Arguments:

- `(unlabeled)` (of type `'a?`, which defaults to `null`): Value to make nullable.

### `null.case`

Return a result dending on whether a value is nothing or not.

Type:
```
('a?, (() -> 'b), (('a) -> 'b)) -> 'b
```

Arguments:

- `(unlabeled)` (of type `'a?`): Value to reason by case analysis on.
- `(unlabeled)` (of type `() -> 'b`): Value to return in case we have nothing.
- `(unlabeled)` (of type `('a) -> 'b`): Value to return in case we have something.

### `null.default`

Return a result dending on whether a value is nothing or not.

Type:
```
('a?, (() -> 'a)) -> 'a
```

Arguments:

- `(unlabeled)` (of type `'a?`): Value to reason by case analysis on.
- `(unlabeled)` (of type `() -> 'a`): Value to return in case we have nothing.

### `null.defined`

Determine whether a nullable value is not null.

Type:
```
('a?) -> bool
```

Arguments:

- `(unlabeled)` (of type `'a?`)

### `null.get`

Get the value of a nullable. Raises `error.not_found` if the value is `null` and no default value was specified.

Type:
```
(?default : 'a?, 'a?) -> 'a
```

Arguments:

- `default` (of type `'a?`, which defaults to `null`): Returned value when the value is `null`.
- `(unlabeled)` (of type `'a?`)

### `null.to_list`

Convert a nullable value to a list containing zero or one element depending on whether the value is null or not.

Type:
```
('a?) -> ['a]
```

Arguments:

- `(unlabeled)` (of type `'a?`)

### `playlist.files`

Retrieve the list of files contained in a playlist.

Type:
```
(?id : string?, ?mime_type : string?, ?timeout : float,
 string) -> [string]
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `mime_type` (of type `string?`, which defaults to `null`): Default MIME type for the playlist. `null` means automatic detection.
- `timeout` (of type `float`, which defaults to `20.`): Timeout for resolving the playlist
- `(unlabeled)` (of type `string`): Path to the playlist

### `playlist.id`

Default id assignment for playlists

Type:
```
(default : string, string) -> string
```

Arguments:

- `default` (of type `string`): Default name pattern when no useful name can be extracted from `uri`
- `(unlabeled)` (of type `string`): Playlist uri

### `playlist.parse`

Try to parse a local playlist. Return a list of (metadata,URI) items, where metadata is a list of (key,value) bindings.

Type:
```
(?path : string, ?mime : string?, string) ->
[[string * string] * string]
```

Arguments:

- `path` (of type `string`, which defaults to `""`): Default path for files.
- `mime` (of type `string?`, which defaults to `null`): Mime type for the playlist
- `(unlabeled)` (of type `string`)

### `playlist.parse.register`

Register a new playlist parser. An empty playlist is considered as a failure to resolve.

Type:
```
(format : string, strict : bool,
 ((?pwd : string, string) ->
  [[string * string] * string])) -> unit
```

Arguments:

- `format` (of type `string`): Playlist format. If possible, a mime-type.
- `strict` (of type `bool`): True if playlist format can be detected unambiguously.
- `(unlabeled)` (of type `(?pwd : string, string) -> [[string * string] * string]`): Playlist parser

### `predicate.activates`

Detect when a predicate becomes true.

Type:
```
(?init : bool, (() -> bool)) -> () -> bool
```

Arguments:

- `init` (of type `bool`, which defaults to `false`): Detect at beginning.
- `(unlabeled)` (of type `() -> bool`): Predicate.

### `predicate.changes`

Detect when a predicate changes.

Type:
```
((() -> 'a)) -> () -> bool where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `() -> 'a where 'a is an orderable type`): Predicate.

### `predicate.first`

First occurrence of a predicate.

Type:
```
((() -> bool)) -> () -> bool
```

Arguments:

- `(unlabeled)` (of type `() -> bool`): Predicate.

### `predicate.once`

Become true once every time a predicate is true.

Type:
```
((() -> bool)) -> () -> bool
```

Arguments:

- `(unlabeled)` (of type `() -> bool`): Predicate.

### `predicate.signal`

Predicate which is true when a signal is sent. The returned predicate has a method `signal` to send the signal.

Type:
```
() -> () -> bool
```

Arguments:


Methods:

- `signal` (of type `() -> unit`): Send a signal.

### `process_uri`

Create a process: uri, replacing `:` with `$(colon)`

Type:
```
(extname : 'a, ?uri : string, string) -> string
```

Arguments:

- `extname` (of type `'a`): Output file extension (with no leading '.')
- `uri` (of type `string`, which defaults to `""`): Input uri
- `(unlabeled)` (of type `string`): Command line to execute

### `profiler.disable`

Record profiling statistics.

Type:
```
() -> unit
```

Arguments:


### `profiler.enable`

Record profiling statistics.

Type:
```
() -> unit
```

Arguments:


### `profiler.run`

Time a function with the profiler.

Type:
```
(string, (() -> 'a)) -> 'a
```

Arguments:

- `(unlabeled)` (of type `string`): Name of the profiled function.
- `(unlabeled)` (of type `() -> 'a`): Function to profile.

### `profiler.stats.string`

Profiling statistics.

Type:
```
() -> string
```

Arguments:


### `prometheus.latency`

Monitor a source's internal latencies on Prometheus

Type:
```
(?window : float, ?prefix : string, labels : [string]) ->
(label_values : [string], source('a)) -> unit
```

Arguments:

- `window` (of type `float`, which defaults to `5.`): Window over which mean and peak metrics are reported.
- `prefix` (of type `string`, which defaults to `"liquidsoap_"`): Prefix for the metric's name
- `labels` (of type `[string]`): labels for the metric

### `ref`

Create a reference, i.e. a value which can be modified.

Type:
```
('a) -> ref('a)
```

Arguments:

- `(unlabeled)` (of type `'a`)

### `ref.get`

Retrieve the contents of a reference.

Type:
```
(ref('a)) -> 'a
```

Arguments:

- `(unlabeled)` (of type `ref('a)`)

### `ref.getter`

Create a getter from a reference.

Type:
```
(ref('a)) -> () -> 'a
```

Arguments:

- `(unlabeled)` (of type `ref('a)`)

Methods:

- `set` (of type `(?A) -> unit`)

### `ref.incr`

Increment a reference to an integer.

Type:
```
(ref(int)) -> unit
```

Arguments:

- `(unlabeled)` (of type `ref(int)`)

### `ref.set`

Set the value of a reference.

Type:
```
(ref('a), 'a) -> unit
```

Arguments:

- `(unlabeled)` (of type `ref('a)`)
- `(unlabeled)` (of type `'a`)

### `request.create`

Create a request from an URI.

Type:
```
(?indicators : [string], ?persistent : bool,
 ?temporary : bool, string) -> request
```

Arguments:

- `indicators` (of type `[string]`, which defaults to `[]`)
- `persistent` (of type `bool`, which defaults to `false`): Indicate that the request is persistent, i.e. that it may be used again once it has been played.
- `temporary` (of type `bool`, which defaults to `false`): Indicate that the request is a temporary file: it will be destroyed after being played.
- `(unlabeled)` (of type `string`)

### `request.destroy`

Destroying a request causes any temporary associated file to be deleted, and releases its RID. Persistent requests resist to destroying, unless forced.

Type:
```
(?force : bool, request) -> unit
```

Arguments:

- `force` (of type `bool`, which defaults to `false`): Destroy the request even if it is persistent.
- `(unlabeled)` (of type `request`)

### `request.duration`

Compute the duration in seconds of audio data contained in a request. The computation may be expensive. Returns -1. if computation failed, typically if the file was not recognized as valid audio.

Type:
```
(string) -> float
```

Arguments:

- `(unlabeled)` (of type `string`)

### `request.filename`

Return a valid local filename if the request is ready, and the empty string otherwise.

Type:
```
(request) -> string
```

Arguments:

- `(unlabeled)` (of type `request`)

### `request.id`

Identifier of a request.

Type:
```
(request) -> int
```

Arguments:

- `(unlabeled)` (of type `request`)

### `request.log`

Get log data associated to a request.

Type:
```
(request) -> string
```

Arguments:

- `(unlabeled)` (of type `request`)

### `request.metadata`

Get the metadata associated to a request.

Type:
```
(request) -> [string * string]
```

Arguments:

- `(unlabeled)` (of type `request`)

### `request.read_metadata`

Force reading the metadata of a request.

Type:
```
(request) -> unit
```

Arguments:

- `(unlabeled)` (of type `request`)

### `request.ready`

Check if a request is ready, i.e. is associated to a valid local file. Unless the initial URI was such a file, a request has to be resolved before being ready.

Type:
```
(request) -> bool
```

Arguments:

- `(unlabeled)` (of type `request`)

### `request.resolve`

Resolve a request, i.e. attempt to get a valid local file. The operation can take some time. Return true if the resolving was successful, false otherwise (timeout or invalid URI). The request should not be decoded afterward: this is mostly useful to download files such as playlists, etc.

Type:
```
(?content_type : source('a)?, ?timeout : float, request) ->
bool
```

Arguments:

- `content_type` (of type `source('a)?`, which defaults to `null`): If specified, the request will be decoded with the same content type as the given source.
- `timeout` (of type `float`, which defaults to `30.`): Limit in seconds to the duration of the resolving.
- `(unlabeled)` (of type `request`)

### `request.status`

Current status of a request. Can be idle, resolving, ready, playing or destroyed.

Type:
```
(request) -> string
```

Arguments:

- `(unlabeled)` (of type `request`)

### `request.uri`

Initial URI of a request.

Type:
```
(request) -> string
```

Arguments:

- `(unlabeled)` (of type `request`)

### `seconds_of_main`

Convert a number of main ticks in seconds.

Type:
```
(int) -> float
```

Arguments:

- `(unlabeled)` (of type `int`)

### `server.execute`

Execute a liquidsoap server command.

Type:
```
(string, ?string) -> [string]
```

Arguments:

- `(unlabeled)` (of type `string`): Command to execute.
- `(unlabeled)` (of type `string`, which defaults to `""`): Argument for the command.

### `settings`

All settings.

Type:
```

{
  video : 
  {
    converter : 
    {
      proportional_scale : (() -> bool)
      .{
        set : (bool) -> unit,
        comments : string,
        description : string
      },
      preferred : (() -> string)
      .{
        set : (string) -> unit,
        comments : string,
        description : string
      },
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  tag : 
  {
    encodings : (() -> [string])
    .{
      set : ([string]) -> unit,
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  srt : 
  {
    poll : 
    {
      timeout : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      comments : string,
      description : string
    },
    log : (() -> bool)
    .{
      level : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    enforced_encryption : (() -> bool)
    .{
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  server : 
  {
    timeout : (() -> float)
    .{
      set : (float) -> unit,
      comments : string,
      description : string
    },
    telnet : (() -> bool)
    .{
      revdns : (() -> bool)
      .{
        set : (bool) -> unit,
        comments : string,
        description : string
      },
      port : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      bind_addr : (() -> string)
      .{
        set : (string) -> unit,
        comments : string,
        description : string
      },
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    socket : (() -> bool)
    .{
      permissions : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      path : (() -> string)
      .{
        set : (string) -> unit,
        comments : string,
        description : string
      },
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    log : 
    {
      level : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  scheduler : 
  {
    non_blocking_queues : (() -> int)
    .{
      set : (int) -> unit,
      comments : string,
      description : string
    },
    log : (() -> bool)
    .{
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    generic_queues : (() -> int)
    .{
      set : (int) -> unit,
      comments : string,
      description : string
    },
    fast_queues : (() -> int)
    .{
      set : (int) -> unit,
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  sandbox : (() -> bool)
  .{
    unsetenv : (() -> [string])
    .{
      set : ([string]) -> unit,
      comments : string,
      description : string
    },
    shell : (() -> bool)
    .{
      path : (() -> string)
      .{
        set : (string) -> unit,
        comments : string,
        description : string
      },
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    setenv : (() -> [string])
    .{
      set : ([string]) -> unit,
      comments : string,
      description : string
    },
    rw : (() -> [string])
    .{
      set : ([string]) -> unit,
      comments : string,
      description : string
    },
    ro : (() -> [string])
    .{
      set : ([string]) -> unit,
      comments : string,
      description : string
    },
    network : (() -> bool)
    .{
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    binary : (() -> string)
    .{
      set : (string) -> unit,
      comments : string,
      description : string
    },
    set : (bool) -> unit,
    comments : string,
    description : string
  },
  root : 
  {
    max_latency : (() -> float)
    .{
      set : (float) -> unit,
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  request : 
  {
    metadata_decoders : (() -> [string])
    .{
      override : (() -> bool)
      .{
        set : (bool) -> unit,
        comments : string,
        description : string
      },
      duration : (() -> bool)
      .{
        set : (bool) -> unit,
        comments : string,
        description : string
      },
      set : ([string]) -> unit,
      comments : string,
      description : string
    },
    leak_warning : (() -> int)
    .{
      set : (int) -> unit,
      comments : string,
      description : string
    },
    grace_time : (() -> float)
    .{
      set : (float) -> unit,
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  prometheus : 
  {
    server : (() -> bool)
    .{
      port : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  playlists : 
  {
    mime_types : 
    {
      xml : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      comments : string,
      description : string
    },
    cue_out_metadata : (() -> string)
    .{
      set : (string) -> unit,
      comments : string,
      description : string
    },
    cue_in_metadata : (() -> string)
    .{
      set : (string) -> unit,
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  osc : 
  {
    port : (() -> int)
    .{
      set : (int) -> unit,
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  mpd : 
  {
    randomize : (() -> bool)
    .{
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    port : (() -> int)
    .{
      set : (int) -> unit,
      comments : string,
      description : string
    },
    path : (() -> string)
    .{
      set : (string) -> unit,
      comments : string,
      description : string
    },
    host : (() -> string)
    .{
      set : (string) -> unit,
      comments : string,
      description : string
    },
    debug : (() -> bool)
    .{
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  log : 
  {
    unix_timestamps : (() -> bool)
    .{
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    stdout : (() -> bool)
    .{
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    level : (() -> int)
    .{
      video : (() -> int?)
      .{
        converter : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        set : (int) -> unit,
        comments : string,
        description : string
      },
      threads : (() -> int?)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      srt : (() -> int?)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      source : (() -> int?)
      .{
        dump : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        set : (int) -> unit,
        comments : string,
        description : string
      },
      single : (() -> int?)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      server : (() -> int?)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      sandbox : (() -> int?)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      request : (() -> int?)
      .{
        dynamic : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        set : (int) -> unit,
        comments : string,
        description : string
      },
      prometheus : (() -> int?)
      .{
        server : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        set : (int) -> unit,
        comments : string,
        description : string
      },
      process : (() -> int?)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      playlist_parser : (() -> int?)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      playlist : (() -> int?)
      .{
        xml : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        basic : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        set : (int) -> unit,
        comments : string,
        description : string
      },
      oggmuxer : (() -> int?)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      metadata : (() -> int?)
      .{
        mp4 : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        flac : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        set : (int) -> unit,
        comments : string,
        description : string
      },
      lo : (() -> int?)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      lifecycle : (() -> int?)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      lastfm : (() -> int?)
      .{
        submit : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        set : (int) -> unit,
        comments : string,
        description : string
      },
      langfile : (() -> int?)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      lang : (() -> int?)
      .{
        json : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        set : (int) -> unit,
        comments : string,
        description : string
      },
      io : (() -> int?)
      .{
        gstreamer : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        set : (int) -> unit,
        comments : string,
        description : string
      },
      input : (() -> int?)
      .{
        jack : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        http : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        external : (() -> int?)
        .{
          video : (() -> int?)
          .{
            set : (int) -> unit,
            comments : string,
            description : string
          },
          set : (int) -> unit,
          comments : string,
          description : string
        },
        set : (int) -> unit,
        comments : string,
        description : string
      },
      image : (() -> int?)
      .{
        decoder : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        set : (int) -> unit,
        comments : string,
        description : string
      },
      icy : (() -> int?)
      .{
        update_metadata : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        set : (int) -> unit,
        comments : string,
        description : string
      },
      hls : (() -> int?)
      .{
        output : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        set : (int) -> unit,
        comments : string,
        description : string
      },
      harbor : (() -> int?)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      gstreamer : (() -> int?)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      frei0r : (() -> int?)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      frame : (() -> int?)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      ffmpeg : (() -> int?)
      .{
        internal : (() -> int?)
        .{
          decoder : (() -> int?)
          .{
            set : (int) -> unit,
            comments : string,
            description : string
          },
          set : (int) -> unit,
          comments : string,
          description : string
        },
        filter : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        encoder : (() -> int?)
        .{
          internal : (() -> int?)
          .{
            set : (int) -> unit,
            comments : string,
            description : string
          },
          set : (int) -> unit,
          comments : string,
          description : string
        },
        decoder : (() -> int?)
        .{
          copy : (() -> int?)
          .{
            set : (int) -> unit,
            comments : string,
            description : string
          },
          set : (int) -> unit,
          comments : string,
          description : string
        },
        set : (int) -> unit,
        comments : string,
        description : string
      },
      encoder : (() -> int?)
      .{
        gstreamer : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        set : (int) -> unit,
        comments : string,
        description : string
      },
      dynamic : (() -> int?)
      .{
        loader : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        set : (int) -> unit,
        comments : string,
        description : string
      },
      decoder : (() -> int?)
      .{
        wav_aiff : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        taglib : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        sdlimage : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        raw : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        ppm : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        ogg : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        mp4 : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        midi : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        mad : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        id3v2 : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        gstreamer : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        flac : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        ffmpeg : (() -> int?)
        .{
          internal : (() -> int?)
          .{
            set : (int) -> unit,
            comments : string,
            description : string
          },
          image : (() -> int?)
          .{
            set : (int) -> unit,
            comments : string,
            description : string
          },
          set : (int) -> unit,
          comments : string,
          description : string
        },
        external : (() -> int?)
        .{
          oblivious : (() -> int?)
          .{
            set : (int) -> unit,
            comments : string,
            description : string
          },
          set : (int) -> unit,
          comments : string,
          description : string
        },
        camlimages : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        aac : (() -> int?)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        set : (int) -> unit,
        comments : string,
        description : string
      },
      console : (() -> int?)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      clock : (() -> int?)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      camomile : (() -> int?)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      audioscrobbler : (() -> int?)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      audio : (() -> int?)
      .{
        converter : (() -> int?)
        .{
          libsamplerate : (() -> int?)
          .{
            set : (int) -> unit,
            comments : string,
            description : string
          },
          set : (int) -> unit,
          comments : string,
          description : string
        },
        set : (int) -> unit,
        comments : string,
        description : string
      },
      annotate : (() -> int?)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      ladspa_extension : (() -> int?)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      dssi_synthesizer : (() -> int?)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      set : (int) -> unit,
      comments : string,
      description : string
    },
    file : (() -> bool)
    .{
      perms : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      path : (() -> string?)
      .{
        set : (string) -> unit,
        comments : string,
        description : string
      },
      append : (() -> bool)
      .{
        set : (bool) -> unit,
        comments : string,
        description : string
      },
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  lang : 
  {
    debug_errors : (() -> bool)
    .{
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    debug : (() -> bool)
    .{
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  init : 
  {
    trace : (() -> bool)
    .{
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    force_start : (() -> bool)
    .{
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    daemon : (() -> bool)
    .{
      pidfile : (() -> bool)
      .{
        perms : (() -> int)
        .{
          set : (int) -> unit,
          comments : string,
          description : string
        },
        path : (() -> string?)
        .{
          set : (string) -> unit,
          comments : string,
          description : string
        },
        set : (bool) -> unit,
        comments : string,
        description : string
      },
      change_user : (() -> bool)
      .{
        user : (() -> string)
        .{
          set : (string) -> unit,
          comments : string,
          description : string
        },
        group : (() -> string)
        .{
          set : (string) -> unit,
          comments : string,
          description : string
        },
        set : (bool) -> unit,
        comments : string,
        description : string
      },
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    catch_exn : (() -> bool)
    .{
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    allow_root : (() -> bool)
    .{
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  harbor : 
  {
    verbose : (() -> bool)
    .{
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    timeout : (() -> float)
    .{
      set : (float) -> unit,
      comments : string,
      description : string
    },
    ssl : 
    {
      write_timeout : (() -> float)
      .{
        set : (float) -> unit,
        comments : string,
        description : string
      },
      read_timeout : (() -> float)
      .{
        set : (float) -> unit,
        comments : string,
        description : string
      },
      private_key : (() -> string)
      .{
        set : (string) -> unit,
        comments : string,
        description : string
      },
      password : (() -> string)
      .{
        set : (string) -> unit,
        comments : string,
        description : string
      },
      certificate : (() -> string)
      .{
        set : (string) -> unit,
        comments : string,
        description : string
      },
      comments : string,
      description : string
    },
    reverse_dns : (() -> bool)
    .{
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    max_connections : (() -> int)
    .{
      set : (int) -> unit,
      comments : string,
      description : string
    },
    icy_formats : (() -> [string])
    .{
      set : ([string]) -> unit,
      comments : string,
      description : string
    },
    bind_addrs : (() -> [string])
    .{
      set : ([string]) -> unit,
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  gstreamer : 
  {
    max_buffers : (() -> int)
    .{
      set : (int) -> unit,
      comments : string,
      description : string
    },
    add_borders : (() -> bool)
    .{
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  frame : 
  {
    video : 
    {
      width : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      height : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      framerate : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      default : (() -> bool)
      .{
        set : (bool) -> unit,
        comments : string,
        description : string
      },
      comments : string,
      description : string
    },
    midi : 
    {
      channels : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      comments : string,
      description : string
    },
    duration : (() -> float)
    .{
      set : (float) -> unit,
      comments : string,
      description : string
    },
    audio : 
    {
      size : (() -> int?)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      samplerate : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      channels : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  ffmpeg : 
  {
    scaling_algorithm : (() -> string)
    .{
      set : (string) -> unit,
      comments : string,
      description : string
    },
    log : 
    {
      verbosity : (() -> string)
      .{
        set : (string) -> unit,
        comments : string,
        description : string
      },
      level : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  encoder : 
  {
    metadata : 
    {
      export : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  decoder : 
  {
    taglib : 
    {comments : string, description : string
    },
    priorities : 
    {
      wav : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      ogg : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      mp4 : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      mad : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      gstreamer : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      flac : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      ffmpeg : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      basic : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      aiff : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      aac : (() -> int)
      .{
        set : (int) -> unit,
        comments : string,
        description : string
      },
      comments : string,
      description : string
    },
    mime_types : 
    {
      wav : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      taglib : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      ogg : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      mp4 : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      mp3 : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      mad : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      id3v2 : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      gstreamer : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      flac : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      ffmpeg : (() -> [string])
      .{
        images : (() -> [string])
        .{
          set : ([string]) -> unit,
          comments : string,
          description : string
        },
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      basic : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      aiff : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      aac : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      comments : string,
      description : string
    },
    image_file_decoders : (() -> [string])
    .{
      set : ([string]) -> unit,
      comments : string,
      description : string
    },
    id3v2 : 
    {comments : string, description : string
    },
    file_extensions : 
    {
      wav : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      taglib : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      ogg : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      mp4 : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      mp3 : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      mad : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      id3v2 : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      gstreamer : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      flac : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      ffmpeg : (() -> [string])
      .{
        images : (() -> [string])
        .{
          set : ([string]) -> unit,
          comments : string,
          description : string
        },
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      aiff : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      aac : (() -> [string])
      .{
        set : ([string]) -> unit,
        comments : string,
        description : string
      },
      comments : string,
      description : string
    },
    ffmpeg : 
    {
      codecs : 
      {
        zmbv : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        zlib : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        yuv4 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        yop : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        ylc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        y41p : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        xwd : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        xpm : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        xma2 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        xma1 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        xbm : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        xan_wc4 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        xan_wc3 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        ws_vqa : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        wnv1 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        wmv3 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        wmv2 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        wmv1 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        wmavoice : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        wmalossless : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        westwood_snd1 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        webp : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        wcmv : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        wavpack : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        wavesynth : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        vp9 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        vp8 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        vp7 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        vp6f : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        vp6a : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        vp6 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        vp5 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        vp4 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        vp3 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        vorbis : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        vmnc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        vmdvideo : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        vmdaudio : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        vixl : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        vcr1 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        vc1image : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        vc1 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        vble : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        vb : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        v410 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        v408 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        v308 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        v210x : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        v210 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        ulti : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        txd : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        tta : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        tscc2 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        tscc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        truemotion2rt : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        truemotion2 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        truemotion1 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        truehd : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        tqi : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        tmv : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        tiff : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        tiertexseqvideo : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        thp : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        theora : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        tgv : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        tgq : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        tdsc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        targa_y216 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        targa : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        tak : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        svq3 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        svq1 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        svg : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        srgc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        speex : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        speedhq : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        sp5x : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        sonic : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        sol_dpcm : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        snow : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        smc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        siren : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        sipr : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        sgi : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        sdx2_dpcm : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        screenpresso : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        scpr : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        sbc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        sanm : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        rv40 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        rv30 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        rv20 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        rv10 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        rscc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        rpza : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        roq : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        rl2 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        rasc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        ralf : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        r210 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        r10k : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        qpeg : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        qdmc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        qdm2 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        ptx : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        psd : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        ppm : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        png : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pictor : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pgmyuv : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pgm : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pfm : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcx : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_vidc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_u32le : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_u32be : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_u24le : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_u24be : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_u16le : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_u16be : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_s64le : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_s64be : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_s32le_planar : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_s32le : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_s32be : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_s24le_planar : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_s24le : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_s24daud : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_s24be : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_s16le_planar : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_s16le : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_s16be : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_lxf : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_f64le : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_f64be : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_f32le : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_f32be : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_f24le : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_f16le : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_dvd : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pcm_bluray : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pbm : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        pam : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        opus : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        nuv : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        notchlc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mxpeg : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mwsc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mvha : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mvdv : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mvc2 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mvc1 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mv30 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mts2 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mszh : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mss2 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mss1 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        msrle : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        msmpeg4v3 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        msmpeg4v2 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        msmpeg4v1 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mscc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        msa1 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mpeg4 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mpeg2video : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mpeg1video : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mp3 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mp2 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mp1 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        motionpixels : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mlp : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mjpegb : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mjpeg : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mimic : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        metasound : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mdec : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mad : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mace6 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        mace3 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        m101 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        lscr : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        loco : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        lagarith : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        kmvc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        kgv1 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        jv : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        jpeg2000 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        interplayvideo : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        interplayacm : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        imm5 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        imm4 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        imc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        ilbc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        iff_ilbm : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        iac : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        hymt : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        hqx : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        hq_hqa : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        hnm4video : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        hevc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        hcom : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        hca : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        hap : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        h264 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        h263p : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        h263i : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        h263 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        h261 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        gsm : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        gif : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        gdv : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        g729 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        g723_1 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        g2m : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        frwu : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        fraps : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        fmvc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        flv1 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        flic : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        flashsv : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        flac : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        fits : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        fic : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        ffv1 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        exr : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        evrc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        escape130 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        escape124 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        eac3 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        dxv : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        dxtory : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        dxa : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        dts : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        dst : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        dss_sp : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        dsicinvideo : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        dsd_msbf_planar : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        dsd_lsbf_planar : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        dpx : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        dfa : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        dds : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        cyuv : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        cscd : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        cpia : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        cook : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        comfortnoise : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        cmv : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        cllc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        cljr : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        cfhd : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        cdxl : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        cavs : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        c93 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        brender_pix : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        bmv_video : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        bmv_audio : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        bmp : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        bitpacked : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        binkvideo : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        binkaudio_dct : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        bfi : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        bethsoftvid : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        ayuv : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        avui : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        avs : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        avrp : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        avrn : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        avc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        av1 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        aura2 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        aura : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        atrac9 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        atrac3al : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        atrac3 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        atrac1 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        asv2 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        asv1 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        arbc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        aptx : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        apng : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        ape : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        ansi : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        anm : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        amv : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        amr_wb : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        amr_nb : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        alac : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        aic : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        agm : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        adpcm_yamaha : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        adpcm_thp_le : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        adpcm_thp : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        adpcm_swf : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        adpcm_psx : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        adpcm_ima_ws : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        adpcm_ima_smjpeg : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        adpcm_ima_qt : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        adpcm_ima_ea_sead : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        adpcm_ima_ea_eacs : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        adpcm_g726le : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        adpcm_ea_xas : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        adpcm_dtk : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        adpcm_agm : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        adpcm_afc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        adpcm_adx : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        adpcm_4xm : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        acelpkelvin : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        ac3 : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        aasc : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        aac : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        _4xm : (() -> string?)
        .{
          available : (() -> [string])
          .{
            set : ([string]) -> unit,
            comments : string,
            description : string
          },
          set : (string) -> unit,
          comments : string,
          description : string
        },
        comments : string,
        description : string
      },
      comments : string,
      description : string
    },
    decoders : (() -> [string])
    .{
      set : ([string]) -> unit,
      comments : string,
      description : string
    },
    debug : (() -> bool)
    .{
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  console : 
  {
    colorize : (() -> string)
    .{
      set : (string) -> unit,
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  clock : 
  {
    log_delay : (() -> float)
    .{
      set : (float) -> unit,
      comments : string,
      description : string
    },
    allow_streaming_errors : (() -> bool)
    .{
      set : (bool) -> unit,
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  audio : 
  {
    converter : 
    {
      samplerate : 
      {
        native : 
        {
          quality : (() -> string)
          .{
            set : (string) -> unit,
            comments : string,
            description : string
          },
          comments : string,
          description : string
        },
        libsamplerate : 
        {
          quality : (() -> string)
          .{
            set : (string) -> unit,
            comments : string,
            description : string
          },
          comments : string,
          description : string
        },
        converters : (() -> [string])
        .{
          set : ([string]) -> unit,
          comments : string,
          description : string
        },
        comments : string,
        description : string
      },
      channel_layout : 
      {
        converters : (() -> [string])
        .{
          set : ([string]) -> unit,
          comments : string,
          description : string
        },
        comments : string,
        description : string
      },
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  alsa : 
  {
    periods : (() -> int)
    .{
      set : (int) -> unit,
      comments : string,
      description : string
    },
    buffer_length : (() -> int)
    .{
      set : (int) -> unit,
      comments : string,
      description : string
    },
    alsa_buffer : (() -> int)
    .{
      set : (int) -> unit,
      comments : string,
      description : string
    },
    comments : string,
    description : string
  },
  comments : string,
  description : string
}
```

Arguments:


### `snd`

Get the second component of a pair.

Type:
```
(('a * 'b)) -> 'b
```

Arguments:

- `(unlabeled)` (of type `'a * 'b`)

### `source.dump`

Immediately encode the whole contents of a source into a file.

Type:
```
(format('a), string, source('b)) -> unit
```

Arguments:

- `(unlabeled)` (of type `format('a)`): Encoding format.
- `(unlabeled)` (of type `string`): Name of the file.
- `(unlabeled)` (of type `source('b)`): Source to encode

This function is experimental.

### `source.duration`

Estimation of the duration in the current track.

Type:
```
(source('a)) -> float
```

Arguments:

- `(unlabeled)` (of type `source('a)`)

### `source.elapsed`

Elapsed time in the current track.

Type:
```
(source('a)) -> float
```

Arguments:

- `(unlabeled)` (of type `source('a)`)

### `source.fallible`

Indicate if a source may fail, i.e. may not be ready to stream.

Type:
```
(source('a)) -> bool
```

Arguments:

- `(unlabeled)` (of type `source('a)`)

### `source.id`

Get the identifier of a source.

Type:
```
(source('a)) -> string
```

Arguments:

- `(unlabeled)` (of type `source('a)`)

### `source.init`

Simultaneously initialize sources, return the sublist of sources that failed to initialize.

Type:
```
([source(audio='a, video='b, midi='c)]) ->
[source(audio='a, video='b, midi='c)]
```

Arguments:

- `(unlabeled)` (of type `[source(audio='a, video='b, midi='c)]`)

This function is experimental.

### `source.is_ready`

Indicate if a source is ready to stream (we also say that it is available), or currently streaming.

Type:
```
(source('a)) -> bool
```

Arguments:

- `(unlabeled)` (of type `source('a)`)

### `source.on_metadata`

Call a given handler on metadata packets.

Type:
```
(source('a), (([string * string]) -> unit)) -> unit
```

Arguments:

- `(unlabeled)` (of type `source('a)`)
- `(unlabeled)` (of type `([string * string]) -> unit`)

### `source.on_track`

Call a given handler on new tracks.

Type:
```
(source('a), (([string * string]) -> unit)) -> unit
```

Arguments:

- `(unlabeled)` (of type `source('a)`)
- `(unlabeled)` (of type `([string * string]) -> unit`)

### `source.remaining`

Estimation of remaining time in the current track.

Type:
```
(source('a)) -> float
```

Arguments:

- `(unlabeled)` (of type `source('a)`)

### `source.seek`

Seek forward, in seconds. Returns the amount of time effectively seeked.

Type:
```
(source('a), float) -> float
```

Arguments:

- `(unlabeled)` (of type `source('a)`)
- `(unlabeled)` (of type `float`)

### `source.set_name`

Set the name of an operator.

Type:
```
(source('a), string) -> unit
```

Arguments:

- `(unlabeled)` (of type `source('a)`)
- `(unlabeled)` (of type `string`)

### `source.shutdown`

Deactivate a source.

Type:
```
(source('a)) -> unit
```

Arguments:

- `(unlabeled)` (of type `source('a)`)

### `source.skip`

Skip to the next track.

Type:
```
(source('a)) -> unit
```

Arguments:

- `(unlabeled)` (of type `source('a)`)

### `source.time`

Get a source's time, based on its assigned clock

Type:
```
(source('a)) -> float
```

Arguments:

- `(unlabeled)` (of type `source('a)`)

### `thread.mutexify`

Protect functions with a mutex in order to avoid concurrent calls. It returns the original value when the argument is not a function.

Type:
```
('a) -> 'a
```

Arguments:

- `(unlabeled)` (of type `'a`)

### `thread.on_error`

Register the function to be called when an error of the given kind is raised in a thread. Catches all errors if first argument is `null`.

Type:
```
(error?,
 ((backtrace : string, thread_name : string, error) ->
  unit)) -> unit
```

Arguments:

- `(unlabeled)` (of type `error?`)
- `(unlabeled)` (of type `(backtrace : string, thread_name : string, error) -> unit`)

### `thread.run.recurrent`

Run a recurrent function in a separate thread.

Type:
```
(?fast : bool, ?delay : float, (() -> float)) -> unit
```

Arguments:

- `fast` (of type `bool`, which defaults to `true`): Whether the thread is supposed to return quickly or not. Typically, blocking tasks (e.g. fetching data over the internet) should not be considered to be fast. When set to `false` its priority will be lowered below that of request resolutions and fast timeouts. This is only effective if you set a dedicated queue for fast tasks, see the "scheduler" settings for more details.
- `delay` (of type `float`, which defaults to `0.`): Delay (in sec.) after which the thread should be launched.
- `(unlabeled)` (of type `() -> float`): Function to execute recurrently. The returned value is the delay (in sec.) in which the function should be run again (it won't be run if the value is strictly negative).

### `while`

A while loop.

Type:
```
({bool}, (() -> unit)) -> unit
```

Arguments:

- `(unlabeled)` (of type `{bool}`): Condition guarding the loop.
- `(unlabeled)` (of type `() -> unit`): Function to execute.

## List

### `_[_]`

l[k] returns the first v such that (k,v) is in the list l (or "" if no such v exists).

Type:
```
(['a * string], 'a) -> string
where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `['a * string] where 'a is an orderable type`)
- `(unlabeled)` (of type `anything that is an orderable type`)

### `list.add`

Add an element at the top of a list.

Type:
```
('a, ['a]) -> ['a]
```

Arguments:

- `(unlabeled)` (of type `'a`)
- `(unlabeled)` (of type `['a]`)

### `list.append`

Concatenate two lists.

Type:
```
(['a], ['a]) -> ['a]
```

Arguments:

- `(unlabeled)` (of type `['a]`)
- `(unlabeled)` (of type `['a]`)

### `list.assoc`

Associate a value to a key in an association list. This functions raises `error.not_found` if no default value is specified.

Type:
```
(?default : 'a?, 'b, ['b * 'a]) -> 'a
where 'b is an orderable type
```

Arguments:

- `default` (of type `'a?`, which defaults to `null`): Value returned if the key is not found.
- `(unlabeled)` (of type `anything that is an orderable type`)
- `(unlabeled)` (of type `['b * 'a] where 'b is an orderable type`)

### `list.assoc.filter`

Keep only the elements of an association list satisfying a given predicate.

Type:
```
((('a, 'b) -> bool), ['a * 'b]) -> ['a * 'b]
```

Arguments:

- `(unlabeled)` (of type `('a, 'b) -> bool`)
- `(unlabeled)` (of type `['a * 'b]`)

### `list.assoc.mem`

list.assoc.mem(key,l) returns true if l contains a pair (key,value).

Type:
```
('a, ['a * 'c]) -> bool where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `anything that is an orderable type`): Key to look for
- `(unlabeled)` (of type `['a * 'c] where 'a is an orderable type`): List of pairs (key,value)

### `list.assoc.remove`

Remove the first pair from an associative list.

Type:
```
('a, ['a * 'c]) -> ['a * 'c]
where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `anything that is an orderable type`): Key of pair to be removed.
- `(unlabeled)` (of type `['a * 'c] where 'a is an orderable type`): List of pairs (key,value).

### `list.assoc.remove.all`

Remove all pairs with given key from an associative list.

Type:
```
('a, ['a * 'c]) -> ['a * 'c]
where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `anything that is an orderable type`): Key of pairs to be removed.
- `(unlabeled)` (of type `['a * 'c] where 'a is an orderable type`): List of pairs (key,value).

### `list.case`

Define a function by case analysis, depending on whether a list is empty or not.

Type:
```
(['a], 'b, (('a, ['a]) -> 'b)) -> 'b
```

Arguments:

- `(unlabeled)` (of type `['a]`): List to perform case analysis on.
- `(unlabeled)` (of type `'b`): Result when the list is empty.
- `(unlabeled)` (of type `('a, ['a]) -> 'b`): Result when the list is non-empty.

### `list.cons`

Add an element at the top of a list.

Type:
```
('a, ['a]) -> ['a]
```

Arguments:

- `(unlabeled)` (of type `'a`)
- `(unlabeled)` (of type `['a]`)

### `list.dcase`

"Delayed" version of `list.case` where the value on empty list is only evaluated if necessary.

Type:
```
(['a], (() -> 'b), (('a, ['a]) -> 'b)) -> 'b
```

Arguments:

- `(unlabeled)` (of type `['a]`)
- `(unlabeled)` (of type `() -> 'b`)
- `(unlabeled)` (of type `('a, ['a]) -> 'b`)

### `list.exists`

Check that a predicate is satisfied for some element in a list.

Type:
```
((('a) -> bool), ['a]) -> bool
```

Arguments:

- `(unlabeled)` (of type `('a) -> bool`): Predicate.
- `(unlabeled)` (of type `['a]`): List.

### `list.filter`

Filter a list according to a predicate. The order in which elements are handled is not specified (and is currently implemented from the right).

Type:
```
(?remove : (('a) -> unit), (('a) -> bool), ['a]) -> ['a]
```

Arguments:

- `remove` (of type `('a) -> unit`, which defaults to `<fun>`): Function called on an element when it is removed.
- `(unlabeled)` (of type `('a) -> bool`): Predicate indicating whether an element should be kept or not.
- `(unlabeled)` (of type `['a]`): List to filter.

### `list.find`

First element satisfying a predicate. Raises `error.not_found` if not element is found and no default value was specified.

Type:
```
(?default : 'a?, (('a) -> bool), ['a]) -> 'a
```

Arguments:

- `default` (of type `'a?`, which defaults to `null`): Returned value when the predicate is not found.
- `(unlabeled)` (of type `('a) -> bool`): Predicate.
- `(unlabeled)` (of type `['a]`): List.

### `list.fold`

Fold a function on every element of a list: `list.fold(f,x1,[e1,..,en]) is f(...f(f(x1,e1),e2)...,en)`.

Type:
```
((('a, 'b) -> 'a), 'a, ['b]) -> 'a
```

Arguments:

- `(unlabeled)` (of type `('a, 'b) -> 'a`): Function `f` for which `f(x,e)` which will be called on every element `e` with the current value of `x`, returning the new value of `x`.
- `(unlabeled)` (of type `'a`): Initial value x1, to be updated by successive calls of `f(x,e)`.
- `(unlabeled)` (of type `['b]`)

### `list.fold.right`

Fold a function on every element of a list. Similar to `list.fold` but iterates from the right of the list. It is slightly more efficient than `list.fold`.

Type:
```
((('a, 'b) -> 'b), 'b, ['a]) -> 'b
```

Arguments:

- `(unlabeled)` (of type `('a, 'b) -> 'b`): Function `f` for which `f(x,e)` which will be called on every element `e` with the current value of `x`, returning the new value of `x`.
- `(unlabeled)` (of type `'b`): Initial value x1, to be updated by successive calls of `f(x,e)`.
- `(unlabeled)` (of type `['a]`)

### `list.for_all`

Check that a predicate is satisfied for every element in a list.

Type:
```
((('a) -> bool), ['a]) -> bool
```

Arguments:

- `(unlabeled)` (of type `('a) -> bool`): Predicate.
- `(unlabeled)` (of type `['a]`): List.

### `list.hd`

Return the head (first element) of a list, or `default` if the list is empty.

Type:
```
(?default : 'a?, ['a]) -> 'a
```

Arguments:

- `default` (of type `'a?`, which defaults to `null`): Default value if key does not exist.
- `(unlabeled)` (of type `['a]`)

### `list.ind`

Define a function by induction on a list. This is slightly more efficient than defining a recursive function. The list is scanned from the right.

Type:
```
(['a], 'b, (('a, ['a], 'b) -> 'b)) -> 'b
```

Arguments:

- `(unlabeled)` (of type `['a]`): List to perform induction on.
- `(unlabeled)` (of type `'b`): Result when the list is empty.
- `(unlabeled)` (of type `('a, ['a], 'b) -> 'b`): Result when the list is non-empty, given the current element, the tail and the result of the recursive call on the tail.

### `list.index`

First index where a predicate is satisfied.

Type:
```
((('a) -> bool), ['a]) -> int
```

Arguments:

- `(unlabeled)` (of type `('a) -> bool`): Predicate.
- `(unlabeled)` (of type `['a]`): List.

### `list.indexed`

Add indices to every element of a list, so that it can be accessed with the notation `l[n]`.

Type:
```
(['a]) -> [int * 'a]
```

Arguments:

- `(unlabeled)` (of type `['a]`)

### `list.init`

Initialize a list.

Type:
```
(int, ((int) -> 'a)) -> ['a]
```

Arguments:

- `(unlabeled)` (of type `int`): Number of elements in the list.
- `(unlabeled)` (of type `(int) -> 'a`): Function such that `f i` is the `i`th element.

### `list.insert`

Returns a copy of the given list with a new element inserted at a given position. Raises `error.not_found` if the list has less than `index` elements.

Type:
```
(int, 'a, ['a]) -> ['a]
```

Arguments:

- `(unlabeled)` (of type `int`): Index to insert at, starting at `0`.
- `(unlabeled)` (of type `'a`): Element to insert
- `(unlabeled)` (of type `['a]`): List to insert into.

### `list.is_empty`

Determining whether a list is empty or not.

Type:
```
(['a]) -> bool
```

Arguments:

- `(unlabeled)` (of type `['a]`)

### `list.iter`

Call a function on every element of a list.

Type:
```
((('a) -> unit), ['a]) -> unit
```

Arguments:

- `(unlabeled)` (of type `('a) -> unit`)
- `(unlabeled)` (of type `['a]`)

### `list.iterator`

Create an iterator over the elements of a list.

Type:
```
(['a?]) -> () -> 'a?
```

Arguments:

- `(unlabeled)` (of type `['a?]`)

### `list.iteri`

Call a function on every element of a list, along with its index

Type:
```
(((int, 'a) -> unit), ['a]) -> unit
```

Arguments:

- `(unlabeled)` (of type `(int, 'a) -> unit`)
- `(unlabeled)` (of type `['a]`)

### `list.last`

Return the last element of a list.

Type:
```
(?default : 'a?, ['a]) -> 'a
```

Arguments:

- `default` (of type `'a?`, which defaults to `null`)
- `(unlabeled)` (of type `['a]`)

### `list.length`

Compute the length of a list, i.e., the number of its elements.

Type:
```
(['a]) -> int
```

Arguments:

- `(unlabeled)` (of type `['a]`)

### `list.map`

Map a function on every element of a list.

Type:
```
((('a) -> 'b), ['a]) -> ['b]
```

Arguments:

- `(unlabeled)` (of type `('a) -> 'b`)
- `(unlabeled)` (of type `['a]`)

### `list.mapi`

Map a function on every element of a list, along with its index.

Type:
```
(((int, 'a) -> 'b), ['a]) -> ['b]
```

Arguments:

- `(unlabeled)` (of type `(int, 'a) -> 'b`)
- `(unlabeled)` (of type `['a]`)

### `list.mem`

Check whether an element belongs to a list.

Type:
```
('a, ['a]) -> bool where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `anything that is an orderable type`)
- `(unlabeled)` (of type `['a] where 'a is an orderable type`)

### `list.mem_assoc`

Check whether an element belongs to an associative list.

Type:
```
('a, ['a * 'c]) -> bool where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `anything that is an orderable type`)
- `(unlabeled)` (of type `['a * 'c] where 'a is an orderable type`)

### `list.nth`

Get the n-th element of a list (the first element is at position 0), or `default` if element does not exist.

Type:
```
(?default : 'a?, ['a], int) -> 'a
```

Arguments:

- `default` (of type `'a?`, which defaults to `null`)
- `(unlabeled)` (of type `['a]`)
- `(unlabeled)` (of type `int`)

### `list.pick`

Pick a random element in a list.

Type:
```
(?default : 'a?, ['a]) -> 'a
```

Arguments:

- `default` (of type `'a?`, which defaults to `null`): Value returned if the list is empty.
- `(unlabeled)` (of type `['a]`): List in which the element should be picked.

### `list.prefix`

Compute the beginning of a list.

Type:
```
(int, ['a]) -> ['a]
```

Arguments:

- `(unlabeled)` (of type `int`): Number of elements in the returned list.
- `(unlabeled)` (of type `['a]`): List whose prefix should be taken.

### `list.randomize`

Shuffle the content of a list.

Type:
```
(['a]) -> ['a]
```

Arguments:

- `(unlabeled)` (of type `['a]`)

### `list.remove`

Remove the first occurrence of a value from a list.

Type:
```
('a, ['a]) -> ['a] where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `anything that is an orderable type`)
- `(unlabeled)` (of type `['a] where 'a is an orderable type`)

### `list.rev`

Revert list order.

Type:
```
(['a]) -> ['a]
```

Arguments:

- `(unlabeled)` (of type `['a]`)

### `list.shuffle`

Create a list with the same elements as another, but in a random order.

Type:
```
(['a]) -> ['a]
```

Arguments:

- `(unlabeled)` (of type `['a]`): List of which the elements should be shuffled.

### `list.sort`

Sort a list according to a comparison function.

Type:
```
((('a, 'a) -> int), ['a]) -> ['a]
```

Arguments:

- `(unlabeled)` (of type `('a, 'a) -> int`): Comparison function f such that f(x,y)<0 when x<y, f(x,y)=0 when x=y, and f(x,y)>0 when x>y.
- `(unlabeled)` (of type `['a]`): List to sort.

### `list.tl`

Return the list without its first element.

Type:
```
(['a]) -> ['a]
```

Arguments:

- `(unlabeled)` (of type `['a]`)

### `null.find`

Find the first element of a list for which the image of the function is not `null`. Raises `error.not_found` if not element is found and no default value was specified.

Type:
```
(?default : 'a??, (('b) -> 'a?), ['b]) -> 'a?
```

Arguments:

- `default` (of type `'a??`, which defaults to `null`): Returned value when no element is found.
- `(unlabeled)` (of type `('b) -> 'a?`): Function.
- `(unlabeled)` (of type `['b]`): List.

## Math

### `*`

Multiplication of numbers.

Type:
```
('a, 'a) -> 'a where 'a is a number type
```

Arguments:

- `(unlabeled)` (of type `anything that is a number type`)
- `(unlabeled)` (of type `anything that is a number type`)

### `+`

Addition of numbers.

Type:
```
('a, 'a) -> 'a where 'a is a number type
```

Arguments:

- `(unlabeled)` (of type `anything that is a number type`)
- `(unlabeled)` (of type `anything that is a number type`)

### `-`

Subtraction  of numbers.

Type:
```
('a, 'a) -> 'a where 'a is a number type
```

Arguments:

- `(unlabeled)` (of type `anything that is a number type`)
- `(unlabeled)` (of type `anything that is a number type`)

### `/`

Division of numbers.

Type:
```
('a, 'a) -> 'a where 'a is a number type
```

Arguments:

- `(unlabeled)` (of type `anything that is a number type`)
- `(unlabeled)` (of type `anything that is a number type`)

### `abs`

Absolute value.

Type:
```
('a) -> 'a where 'a is a number type
```

Arguments:

- `(unlabeled)` (of type `anything that is a number type`)

### `acos`

Arc cosine. The argument must fall within the range [-1.0, 1.0]. Result is in radians and is between 0.0 and pi.

Type:
```
(float) -> float
```

Arguments:

- `(unlabeled)` (of type `float`)

### `asin`

Arc sine. The argument must fall within the range [-1.0, 1.0]. Result is in radians and is between -pi/2 and pi/2.

Type:
```
(float) -> float
```

Arguments:

- `(unlabeled)` (of type `float`)

### `atan`

Arc tangent. Result is in radians and is between -pi/2 and pi/2.

Type:
```
(float) -> float
```

Arguments:

- `(unlabeled)` (of type `float`)

### `bool_of_float`

Convert a float to a bool.

Type:
```
(float) -> bool
```

Arguments:

- `(unlabeled)` (of type `float`)

### `bool_of_int`

Convert an int to a bool.

Type:
```
(int) -> bool
```

Arguments:

- `(unlabeled)` (of type `int`)

### `cos`

Cosine. Argument is in radians.

Type:
```
(float) -> float
```

Arguments:

- `(unlabeled)` (of type `float`)

### `cosh`

Hyperbolic cosine. Argument is in radians.

Type:
```
(float) -> float
```

Arguments:

- `(unlabeled)` (of type `float`)

### `dB_of_lin`

Convert linear scale into decibels.

Type:
```
(float) -> float
```

Arguments:

- `(unlabeled)` (of type `float`)

### `exp`

Exponential.

Type:
```
(float) -> float
```

Arguments:

- `(unlabeled)` (of type `float`)

### `float`

Convert a number to a float.

Type:
```
('a) -> float where 'a is a number type
```

Arguments:

- `(unlabeled)` (of type `anything that is a number type`)

### `float_of_int`

Convert an int to a float.

Type:
```
(int) -> float
```

Arguments:

- `(unlabeled)` (of type `int`)

### `infinity`

Float representation of infinity.

Type:
```
float
```

Arguments:


### `int`

Convert a number to an integer.

Type:
```
('a) -> int where 'a is a number type
```

Arguments:

- `(unlabeled)` (of type `anything that is a number type`)

### `int_of_float`

Convert a float to a int.

Type:
```
(float) -> int
```

Arguments:

- `(unlabeled)` (of type `float`)

### `lin_of_dB`

Convert decibels into linear scale.

Type:
```
(float) -> float
```

Arguments:

- `(unlabeled)` (of type `float`)

### `ln`

Natural logarithm.

Type:
```
(float) -> float
```

Arguments:

- `(unlabeled)` (of type `float`)

### `log10`

Base 10 logarithm.

Type:
```
(float) -> float
```

Arguments:

- `(unlabeled)` (of type `float`)

### `lsl`

Logical shift left.

Type:
```
(int, int) -> int
```

Arguments:

- `(unlabeled)` (of type `int`): Number to shift.
- `(unlabeled)` (of type `int`): Number of bits to shift.

### `lsr`

Logical shift right.

Type:
```
(int, int) -> int
```

Arguments:

- `(unlabeled)` (of type `int`): Number to shift.
- `(unlabeled)` (of type `int`): Number of bits to shift.

### `max`

Compute the maximum of two values.

Type:
```
('a, 'a) -> 'a where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `anything that is an orderable type`)
- `(unlabeled)` (of type `anything that is an orderable type`)

### `max_int`

Maximal representable integer.

Type:
```
int
```

Arguments:


### `min`

Compute the minimum of two values.

Type:
```
('a, 'a) -> 'a where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `anything that is an orderable type`)
- `(unlabeled)` (of type `anything that is an orderable type`)

### `min_int`

Minimal representable integer.

Type:
```
int
```

Arguments:


### `mkfade`

Make a fade function based on a source's clock.

Type:
```
(?type : string, ?start : float, ?stop : float,
 ?duration : float, ?on_done : (() -> unit), source('a)) ->
() -> float
```

Arguments:

- `type` (of type `string`, which defaults to `"lin"`): Fade shape. One of: "sin", "exp", "log", "lin"
- `start` (of type `float`, which defaults to `0.`): Start value.
- `stop` (of type `float`, which defaults to `1.`): Stop value.
- `duration` (of type `float`, which defaults to `3.`): Duration in seconds.
- `on_done` (of type `() -> unit`, which defaults to `<fun>`): Function to execute when the fade is finished
- `(unlabeled)` (of type `source('a)`)

### `mod`

Remainder of division of numbers.

Type:
```
('a, 'a) -> 'a where 'a is a number type
```

Arguments:

- `(unlabeled)` (of type `anything that is a number type`)
- `(unlabeled)` (of type `anything that is a number type`)

### `nan`

A special floating-point value denoting the result of an undefined operation such as 0.0 /. 0.0. Stands for 'not a number'. Any floating-point operation with nan as argument returns nan as result. As for floating-point comparisons, `==`, `<`, `<=`, `>` and `>=` return `false` and `!=` returns `true` if one or both of their arguments is `nan`.

Type:
```
float
```

Arguments:


### `pow`

Exponentiation of numbers.

Type:
```
('a, 'a) -> 'a where 'a is a number type
```

Arguments:

- `(unlabeled)` (of type `anything that is a number type`)
- `(unlabeled)` (of type `anything that is a number type`)

### `random.float`

Generate a random value between `min` (included) and `max` (excluded).

Type:
```
(?min : float, ?max : float) -> float
```

Arguments:

- `min` (of type `float`, which defaults to `0.`)
- `max` (of type `float`, which defaults to `1.`)

### `random.int`

Generate a random value between `min` (included) and `max` (excluded).

Type:
```
(?min : int, ?max : int) -> int
```

Arguments:

- `min` (of type `int`, which defaults to `-536870911`)
- `max` (of type `int`, which defaults to `536870912`)

### `sin`

Sine. Argument is in radians.

Type:
```
(float) -> float
```

Arguments:

- `(unlabeled)` (of type `float`)

### `sinh`

Hyperbolic sine. Argument is in radians.

Type:
```
(float) -> float
```

Arguments:

- `(unlabeled)` (of type `float`)

### `sqrt`

Square root.

Type:
```
(float) -> float
```

Arguments:

- `(unlabeled)` (of type `float`)

### `tan`

Tangent. Argument is in radians.

Type:
```
(float) -> float
```

Arguments:

- `(unlabeled)` (of type `float`)

### `tanh`

Hyperbolic tangent. Argument is in radians.

Type:
```
(float) -> float
```

Arguments:

- `(unlabeled)` (of type `float`)

### `~-`

Returns the opposite of its argument.

Type:
```
('a) -> 'a where 'a is a number type
```

Arguments:

- `(unlabeled)` (of type `anything that is a number type`)

## Output

### `output`

Output a stream using the default operator. The input source does not need to be infallible, blank will just be played during failures.

Type:
```
(?id : string?, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?start : bool, source(audio=pcm(?A), video=none,
 midi=?B)) -> unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `fallible` (of type `bool`, which defaults to `true`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If `true`, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `(unlabeled)` (of type `source(audio=pcm(?A), video=none, midi=?B)`): Source to play.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `output.audio_video`

Output a stream with audio and video using the default operator. The input source does not need to be infallible, blank will just be played during failures.

Type:
```
(?id : string?, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?start : bool, source(audio=pcm(?A), video=yuva420p('a),
 midi=?B)) -> unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `fallible` (of type `bool`, which defaults to `true`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If `true`, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `(unlabeled)` (of type `source(audio=pcm(?A), video=yuva420p('a), midi=?B)`): Source to play.

### `output.video`

Output a video stream using the default operator. The input source does not need to be infallible, blank will just be played during failures.

Type:
```
(?id : string?, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?start : bool, source(audio='a, video=yuva420p('b),
 midi='c)) -> unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `fallible` (of type `bool`, which defaults to `true`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If `true`, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `(unlabeled)` (of type `source(audio='a, video=yuva420p('b), midi='c)`): Source to play.

## Source / Audio Processing

### `add`

Mix sources, with optional normalization. Only relay metadata from the first source that is effectively summed.

Type:
```
(?id : string?, ?normalize : {bool}, ?power : {bool},
 ?weights : [{float}],
 [source(audio=internal('a), video=internal('b),
  midi=internal('c))]) -> source(audio=internal('a),
video=internal('b), midi=internal('c))
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `normalize` (of type `{bool}`, which defaults to `true`): Divide by the sum of weights of ready sources (or by the number of ready sources if weights are not specified).
- `power` (of type `{bool}`, which defaults to `false`): Perform constant-power normalization.
- `weights` (of type `[{float}]`, which defaults to `[]`): Relative weight of the sources in the sum. The empty list stands for the homogeneous distribution. These are used as amplification coefficients if we are not normalizing.
- `(unlabeled)` (of type `[source(audio=internal('a), video=internal('b),
 midi=internal('c))]`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `amplify`

Multiply the amplitude of the signal.

Type:
```
(?id : string?, ?override : string?, {float},
 source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `override` (of type `string?`, which defaults to `"liq_amplify"`): Specify the name of a metadata field that, when present and well-formed, overrides the amplification factor for the current track. Well-formed values are floats in decimal notation (e.g. `0.7`) which are taken as normal/linear multiplicative factors; values can be passed in decibels with the suffix `dB` (e.g. `-8.2 dB`, but the spaces do not matter).
- `(unlabeled)` (of type `{float}`): Multiplicative factor.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `audio.map`

Map a function to all audio samples. This is SLOW!

Type:
```
(?id : string?, ((float) -> float), source(audio='a,
 video='b, midi='c)) -> source(audio='a, video='b,
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `(float) -> float`)
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

This function is experimental.

### `clip`

Clip samples, i.e. ensure that all values are between -1 and 1: values lower than -1 become -1 and values higher than 1 become 1.

Type:
```
(?id : string?, source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `comb`

Comb filter.

Type:
```
(?id : string?, ?delay : float, ?feedback : {float},
 source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `delay` (of type `float`, which defaults to `0.001`): Delay in seconds.
- `feedback` (of type `{float}`, which defaults to `-6.`): Feedback coefficient in dB.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `compand`

Compand the signal.

Type:
```
(?id : string?, ?mu : float, source(audio=pcm('a),
 video='b, midi='c)) -> source(audio=pcm('a), video='b,
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `mu` (of type `float`, which defaults to `1.`)
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `compress`

Compress the signal.

Type:
```
(?id : string?, ?attack : {float}, ?gain : {float},
 ?knee : {float}, ?lookahead : {float},
 ?pre_gain : {float}, ?ratio : {float},
 ?release : {float}, ?threshold : {float},
 ?track_sensitive : bool, ?wet : {float},
 ?window : {float}, source(audio=pcm('a), video='b,
 midi='c)) -> source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `attack` (of type `{float}`, which defaults to `50.`): Attack time (ms).
- `gain` (of type `{float}`, which defaults to `0.`): Post-amplification (dB).
- `knee` (of type `{float}`, which defaults to `1.`): Knee width (dB).
- `lookahead` (of type `{float}`, which defaults to `0.`): Lookahead (ms).
- `pre_gain` (of type `{float}`, which defaults to `0.`): Pre-amplification (dB).
- `ratio` (of type `{float}`, which defaults to `2.`): Gain reduction ratio (reduction is ratio:1).
- `release` (of type `{float}`, which defaults to `400.`): Release time (ms).
- `threshold` (of type `{float}`, which defaults to `-10.`): Threshold level (dB).
- `track_sensitive` (of type `bool`, which defaults to `false`): Reset on every track.
- `wet` (of type `{float}`, which defaults to `1.`): How much of input sound to output (between 0 and 1, 0 means only original sound, 1 means only compressed sound).
- `window` (of type `{float}`, which defaults to `0.`): RMS window length (second). `0.` means peak mode.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `gain` (of type `() -> float`): Gain (dB).
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `rms` (of type `() -> float`): RMS or peak power (linear).
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `compress.exponential`

Exponential compressor.

Type:
```
(?id : string?, ?mu : float, source(audio=pcm('a),
 video='b, midi='c)) -> source(audio=pcm('a), video='b,
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `mu` (of type `float`, which defaults to `2.`): Exponential compression factor, typically greater than 1.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `compress.old`

Compress the signal.

Type:
```
(?id : string?, ?attack : {float}, ?gain : {float},
 ?knee : {float}, ?ratio : {float}, ?release : {float},
 ?threshold : {float}, ?window : float,
 source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `attack` (of type `{float}`, which defaults to `100.`): Attack time (ms).
- `gain` (of type `{float}`, which defaults to `0.`): Additional gain (dB).
- `knee` (of type `{float}`, which defaults to `1.`): Knee radius (dB).
- `ratio` (of type `{float}`, which defaults to `2.`): Gain reduction ratio (n:1).
- `release` (of type `{float}`, which defaults to `400.`): Release time (ms).
- `threshold` (of type `{float}`, which defaults to `-10.`): Threshold level (dB).
- `window` (of type `float`, which defaults to `0.1`): Window for computing RMS (in sec).
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `cross`

Cross operator, allowing the composition of the _n_ last seconds of a track with the beginning of the next track, using a transition function depending on the relative power of the signal before and after the end of track.

Type:
```
(?id : string?, ?active : bool, ?conservative : bool,
 ?duration : {float}, ?minimum : float,
 ?override_duration : string, ?width : float,
 ((
   {
     metadata : [string * string],
     db_level : float,
     source : source(audio=pcm('a),
     video='b,
     midi='c)
   }, 
   {
     metadata : [string * string],
     db_level : float,
     source : source(audio=pcm('a),
     video='b,
     midi='c)
   }) -> source(audio=pcm('a), video='b, midi='c)),
 source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `active` (of type `bool`, which defaults to `false`): The active behavior is to keep ticking the child's clock when the operator is not streaming. Otherwise the child's clock is strictly based on what is streamed off the child source, which results in time-dependent active sources to be frozen when that source is stopped.
- `conservative` (of type `bool`, which defaults to `true`): Do not trust remaining time estimations, always buffering data in advance. This avoids being tricked by skips, either manual or caused by blank.skip().
- `duration` (of type `{float}`, which defaults to `5.`): Duration (in seconds) of buffered data from each track that is used to compute the transition between tracks.
- `minimum` (of type `float`, which defaults to `-1.`): Minimum duration (in sec.) for a cross: If the track ends without any warning (e.g. in case of skip) there may not be enough data for a decent composition. Set to 0. to avoid having transitions after skips, or more to avoid transitions on short tracks. With a negative default, transitions always occur.
- `override_duration` (of type `string`, which defaults to `"liq_cross_duration"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
- `width` (of type `float`, which defaults to `2.`): Width of the power computation window.
- `(unlabeled)` (of type `(
 {
   metadata : [string * string],
   db_level : float,
   source : source(audio=pcm('a),
   video='b,
   midi='c)
 }, 
 {
   metadata : [string * string],
   db_level : float,
   source : source(audio=pcm('a),
   video='b,
   midi='c)
 }) -> source(audio=pcm('a), video='b, midi='c)`): Transition function, composing from the end of a track and the next track. The sources corresponding to the two tracks are decorated with fields indicating the power of the signal before and after the transition (`power`), and the metadata (`metadata`).
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `delay_line`

Delay the audio signal by a given amount of time.

Type:
```
(?id : string?, {float}, source(audio=pcm('a), video='b,
 midi='c)) -> source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `{float}`): Duration of the delay in seconds.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `dtmf.detect`

Detect DTMF tones.

Type:
```
(?id : string?, ?bands : int, ?debug : {bool},
 ?duration : {float}, ?smoothing : {float},
 ?threshold : {float}, source(audio=pcm('a), video='b,
 midi='c), ((string) -> unit)) -> source(audio=pcm('a),
video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `bands` (of type `int`, which defaults to `1024`): Number of frequency bands.
- `debug` (of type `{bool}`, which defaults to `false`): Show internal values on standard output in order to fine-tune parameters: band number, band frequency, detected intensity and smoothed intensity.
- `duration` (of type `{float}`, which defaults to `0.05`): Duration for detecting a tone.
- `smoothing` (of type `{float}`, which defaults to `0.01`): Smoothing time (in seconds) for band indensity (the higher, the less sensitive we are to local variations, but the more time we take to detect a band).
- `threshold` (of type `{float}`, which defaults to `50.`): Threshold for detecting a band.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`): Source on which DTMF tones should be detected.
- `(unlabeled)` (of type `(string) -> unit`): Function called with detected key as argument.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `echo`

Add echo.

Type:
```
(?id : string?, ?delay : {float}, ?feedback : {float},
 ?ping_pong : bool, source(audio=pcm('a), video='b,
 midi='c)) -> source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `delay` (of type `{float}`, which defaults to `0.5`): Delay in seconds.
- `feedback` (of type `{float}`, which defaults to `-6.`): Feedback coefficient in dB (negative).
- `ping_pong` (of type `bool`, which defaults to `false`): Use ping-pong delay.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `ffmpeg.filter.audio.output`

Return an audio source from a filter's output

Type:
```
(?id : string?, ?buffer : float, ?pass_metadata : bool,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
source(audio=ffmpeg.audio.raw('a), video=none, midi=none)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `buffer` (of type `float`, which defaults to `0.1`): Duration of the pre-buffered data.
- `pass_metadata` (of type `bool`, which defaults to `true`): Pass ffmpeg stream metadata to liquidsoap
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `filter`

Perform several kinds of filtering on the signal. Only frequencies below the sampling rate / 4 (generally 10 kHz) are handled well for the `freq` parameter.

Type:
```
(?id : string?, freq : {float}, mode : string,
 ?q : {float}, ?wetness : {float}, source(audio=pcm('a),
 video='b, midi='c)) -> source(audio=pcm('a), video='b,
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `freq` (of type `{float}`): Characteristic frequency of the filter.
- `mode` (of type `string`): Available modes are 'low' (for low-pass filter), 'high' (for high-pass filter), 'band' (for band-pass filter) and 'notch' (for notch / band-stop / band-rejection filter).
- `q` (of type `{float}`, which defaults to `1.`)
- `wetness` (of type `{float}`, which defaults to `1.`): How much of the original signal should be added (1. means only filtered and 0. means only original signal).
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `filter.fir`

Low-pass FIR filter.

Type:
```
(?id : string?, beta : float, ?coeffs : int,
 frequency : float, source(audio=pcm('a), video='b,
 midi='c)) -> source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `beta` (of type `float`): Beta should range between 0 and 1.
- `coeffs` (of type `int`, which defaults to `255`): Number of coefficients
- `frequency` (of type `float`): Corner frequency in Hz (frequency at which the response is 0.5, that is -6 dB).
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `filter.iir.butterworth.bandpass`

IIR filter

Type:
```
(?id : string?, frequency1 : float, frequency2 : float,
 ?order : int, source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `frequency1` (of type `float`): First corner frequency
- `frequency2` (of type `float`): Second corner frequency
- `order` (of type `int`, which defaults to `4`): Filter order
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `filter.iir.butterworth.bandstop`

IIR filter

Type:
```
(?id : string?, frequency1 : float, frequency2 : float,
 ?order : int, source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `frequency1` (of type `float`): First corner frequency
- `frequency2` (of type `float`): Second corner frequency
- `order` (of type `int`, which defaults to `4`): Filter order
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `filter.iir.butterworth.high`

IIR filter

Type:
```
(?id : string?, frequency : float, ?order : int,
 source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `frequency` (of type `float`): Corner frequency
- `order` (of type `int`, which defaults to `4`): Filter order
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `filter.iir.butterworth.low`

IIR filter

Type:
```
(?id : string?, frequency : float, ?order : int,
 source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `frequency` (of type `float`): Corner frequency
- `order` (of type `int`, which defaults to `4`): Filter order
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `filter.iir.eq.allpass`

All-pass biquad filter.

Type:
```
(?id : string?, ?bandwidth : {float},
 frequency : {float}, source(audio='a, video='b,
 midi='c)) -> source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `bandwidth` (of type `{float}`, which defaults to `0.333333333333`): Bandwidth (in octaves)
- `frequency` (of type `{float}`): Center frequency
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `filter.iir.eq.bandpass`

Band-pass biquad filter.

Type:
```
(?id : string?, frequency : {float}, ?q : {float},
 source(audio='a, video='b, midi='c)) -> source(audio='a,
video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `frequency` (of type `{float}`): Center frequency
- `q` (of type `{float}`, which defaults to `1.`): Q
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `filter.iir.eq.high`

High-pass biquad filter.

Type:
```
(?id : string?, frequency : {float}, ?q : {float},
 source(audio='a, video='b, midi='c)) -> source(audio='a,
video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `frequency` (of type `{float}`): Corner frequency
- `q` (of type `{float}`, which defaults to `1.`): Q
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `filter.iir.eq.highshelf`

High shelf biquad filter.

Type:
```
(?id : string?, frequency : {float}, ?slope : {float},
 source(audio='a, video='b, midi='c)) -> source(audio='a,
video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `frequency` (of type `{float}`): Center frequency
- `slope` (of type `{float}`, which defaults to `1.`): Shelf slope (in dB/octave)
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `filter.iir.eq.low`

Low-pass biquad filter.

Type:
```
(?id : string?, frequency : {float}, ?q : {float},
 source(audio='a, video='b, midi='c)) -> source(audio='a,
video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `frequency` (of type `{float}`): Corner frequency
- `q` (of type `{float}`, which defaults to `1.`): Q
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `filter.iir.eq.lowshelf`

Low shelf biquad filter.

Type:
```
(?id : string?, frequency : {float}, ?slope : {float},
 source(audio='a, video='b, midi='c)) -> source(audio='a,
video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `frequency` (of type `{float}`): Corner frequency
- `slope` (of type `{float}`, which defaults to `1.`): Shelf slope (dB/octave)
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `filter.iir.eq.notch`

Band-pass biquad filter.

Type:
```
(?id : string?, frequency : {float}, ?q : {float},
 source(audio='a, video='b, midi='c)) -> source(audio='a,
video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `frequency` (of type `{float}`): Center frequency
- `q` (of type `{float}`, which defaults to `1.`): Q
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `filter.iir.eq.peak`

Peak EQ biquad filter.

Type:
```
(?id : string?, frequency : {float}, ?gain : {float},
 ?q : {float}, source(audio='a, video='b, midi='c)) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `frequency` (of type `{float}`): Center frequency
- `gain` (of type `{float}`, which defaults to `1.`): Gain (in dB)
- `q` (of type `{float}`, which defaults to `1.`): Q
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `filter.iir.resonator.allpass`

IIR filter

Type:
```
(?id : string?, frequency : float, ?q : float,
 source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `frequency` (of type `float`): Corner frequency
- `q` (of type `float`, which defaults to `60.`): Quality factor
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `filter.iir.resonator.bandpass`

IIR filter

Type:
```
(?id : string?, frequency : float, ?q : float,
 source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `frequency` (of type `float`): Corner frequency
- `q` (of type `float`, which defaults to `60.`): Quality factor
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `filter.iir.resonator.bandstop`

IIR filter

Type:
```
(?id : string?, frequency : float, ?q : float,
 source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `frequency` (of type `float`): Corner frequency
- `q` (of type `float`, which defaults to `60.`): Quality factor
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `filter.rc`

First-order filter (RC filter).

Type:
```
(?id : string?, frequency : {float}, mode : string,
 ?wetness : {float}, source(audio=pcm('a), video='b,
 midi='c)) -> source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `frequency` (of type `{float}`): Cutoff frequency.
- `mode` (of type `string`): Available modes are 'low' (for low-pass filter), 'high' (for high-pass filter).
- `wetness` (of type `{float}`, which defaults to `1.`): How much of the original signal should be added (1. means only filtered and 0. means only original signal).
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `flanger`

Flanger effect.

Type:
```
(?id : string?, ?delay : float, ?feedback : {float},
 ?freq : {float}, ?phase : {float}, source(audio=pcm('a),
 video='b, midi='c)) -> source(audio=pcm('a), video='b,
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `delay` (of type `float`, which defaults to `0.001`): Delay in seconds.
- `feedback` (of type `{float}`, which defaults to `0.`): Feedback coefficient in dB.
- `freq` (of type `{float}`, which defaults to `0.5`): Frequency in Hz.
- `phase` (of type `{float}`, which defaults to `1.`): Phase difference between channels in radians.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `gate`

Reduce the volume when the stream is silent (typically in order to avoid low intensity noise).

Type:
```
(?id : string?, ?attack : {float}, ?hold : {float},
 ?range : {float}, ?release : {float},
 ?threshold : {float}, ?window : {float},
 source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `attack` (of type `{float}`, which defaults to `10.`): Time to fully open the gate (ms).
- `hold` (of type `{float}`, which defaults to `1000.`): Minimum amount of time the gate stays open (ms).
- `range` (of type `{float}`, which defaults to `-30.`): Difference between closed and open level (dB).
- `release` (of type `{float}`, which defaults to `2000.`): Time to fully close the gate (ms).
- `threshold` (of type `{float}`, which defaults to `-30.`): Threshold at which the gate will open (dB).
- `window` (of type `{float}`, which defaults to `1.`): Duration for computing peak (ms).
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `gate` (of type `() -> float`): Position of the gate (0. means closed, 1. means open).
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `normalize.old`

Normalize the signal. Dynamic normalization of the signal is sometimes the only option, and can make a listening experience much nicer. However, its dynamic aspect implies some limitations which can go as far as creating saturation in some extreme cases. If possible, consider using some track-based normalization techniques such as those based on replay gain. See the documentation for more details. This is the implementation provided in Liquidsoap < 2.0. A new, better and more customizable one is now given in `normalize`.

Type:
```
(?id : string?, ?gain_max : {float}, ?gain_min : {float},
 ?k_down : {float}, ?k_up : {float}, ?target : {float},
 ?threshold : {float}, ?track_sensitive : bool,
 ?window : float, source(audio=pcm('a), video='b,
 midi='c)) -> source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `gain_max` (of type `{float}`, which defaults to `6.`): Maximal gain value (dB).
- `gain_min` (of type `{float}`, which defaults to `-6.`): Minimal gain value (dB).
- `k_down` (of type `{float}`, which defaults to `0.1`): Coefficient when the power must go down (between 0 and 1, slowest to fastest).
- `k_up` (of type `{float}`, which defaults to `0.005`): Coefficient when the power must go up (between 0 and 1, slowest to fastest).
- `target` (of type `{float}`, which defaults to `-13.`): Desired RMS (dB).
- `threshold` (of type `{float}`, which defaults to `-40.`): Minimal RMS for activaing gain control (dB).
- `track_sensitive` (of type `bool`, which defaults to `true`): Reset values on every track.
- `window` (of type `float`, which defaults to `0.1`): Duration of the window used to compute the current RMS power (second).
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `gain` (of type `() -> float`): Current amplification coefficient.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `rms` (of type `() -> float`): Current RMS.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `peak`

Get current peak volume of the source. Returns the source with a method `peak` to compute the current peak volume of the source, with `0.0 <= peak volume <= 1.0`.

Type:
```
(?id : string?, ?duration : {float},
 source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `duration` (of type `{float}`, which defaults to `0.5`): Duration of the window (in seconds). A value <= 0, means that computation should not be performed.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `peak` (of type `() -> float`): Current value for the peak volume.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `peak.stereo`

Get current peak volume of the source. Returns the source with a method `peak` to compute the current peak volume of the source, with `0.0 <= peak volume <= 1.0`.

Type:
```
(?id : string?, ?duration : {float},
 source(audio=pcm(stereo), video='a, midi='b)) ->
source(audio=pcm(stereo), video='a, midi='b)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `duration` (of type `{float}`, which defaults to `0.5`): Duration of the window (in seconds). A value <= 0, means that computation should not be performed.
- `(unlabeled)` (of type `source(audio=pcm(stereo), video='a, midi='b)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `peak` (of type `() -> float * float`): Current value for the peak volume.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `pipe`

Process audio signal through a given process stdin/stdout.

Type:
```
(?id : string?, ?buffer : float, ?data_length : int?,
 ?log_overfull : bool, ?max : float, process : string,
 ?replay_delay : float?, ?restart : bool,
 ?restart_on_error : bool, source(audio=pcm('a),
 video='b, midi='c)) -> source(audio=pcm('a), video='b,
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `buffer` (of type `float`, which defaults to `1.`): Duration of the pre-buffered data.
- `data_length` (of type `int?`, which defaults to `null`): Length passed in the WAV data chunk. Data is streamed so no the consuming program should process it as it comes. Some program operate better when this value is set to `0`, some other when it is set to the maximum length allowed by the WAV specs. Use any negative value to set to maximum length.
- `log_overfull` (of type `bool`, which defaults to `true`): Log when the source's buffer is overfull.
- `max` (of type `float`, which defaults to `10.`): Maximum duration of the buffered data.
- `process` (of type `string`): Process used to pipe data to.
- `replay_delay` (of type `float?`, which defaults to `null`): Replay track marks and metadata from the input source on the output after a given delay. If `null` (default) close and flush the process on each track and metadata to get an exact timing. This parameter is typically used when integrating with `stereotool`.
- `restart` (of type `bool`, which defaults to `true`): Restart process when exited.
- `restart_on_error` (of type `bool`, which defaults to `true`): Restart process when exited with error.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `rms`

Get current RMS volume of the source. Returns the source with a method `rms` to compute the current RMS volume of the source, with `0.0 <= RMS volume <= 1.0`.

Type:
```
(?id : string?, ?duration : {float},
 source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `duration` (of type `{float}`, which defaults to `0.5`): Duration of the window (in seconds). A value <= 0, means that computation should not be performed.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `rms` (of type `() -> float`): Current value for the RMS volume.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `rms.stereo`

Get current RMS volume of the source. Returns the source with a method `rms` to compute the current RMS volume of the source, with `0.0 <= RMS volume <= 1.0`.

Type:
```
(?id : string?, ?duration : {float},
 source(audio=pcm(stereo), video='a, midi='b)) ->
source(audio=pcm(stereo), video='a, midi='b)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `duration` (of type `{float}`, which defaults to `0.5`): Duration of the window (in seconds). A value <= 0, means that computation should not be performed.
- `(unlabeled)` (of type `source(audio=pcm(stereo), video='a, midi='b)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `rms` (of type `() -> float * float`): Current value for the RMS volume.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `sine.detect`

Detect DTMF tones.

Type:
```
(?id : string?, ?bands : int, ?debug : {bool},
 ?duration : {float}, ?smoothing : {float},
 ?threshold : {float}, [float], source(audio=pcm('a),
 video='b, midi='c), ((float) -> unit)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `bands` (of type `int`, which defaults to `1024`): Number of frequency bands.
- `debug` (of type `{bool}`, which defaults to `false`): Show internal values on standard output in order to fine-tune parameters: band number, band frequency, detected intensity and smoothed intensity.
- `duration` (of type `{float}`, which defaults to `0.5`): Duration for detecting a tone.
- `smoothing` (of type `{float}`, which defaults to `0.01`): Smoothing time (in seconds) for band indensity (the higher, the less sensitive we are to local variations, but the more time we take to detect a band).
- `threshold` (of type `{float}`, which defaults to `50.`): Threshold for detecting a band.
- `(unlabeled)` (of type `[float]`): List of frequencies to detect.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`): Source on which sines should be detected.
- `(unlabeled)` (of type `(float) -> unit`): Function called with detected frequency as argument.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `soundtouch`

Change the rate, the tempo or the pitch of the sound.

Type:
```
(?id : string?, ?pitch : {float}, ?rate : {float},
 ?tempo : {float}, source(audio=pcm('a), video='b,
 midi='c)) -> source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `pitch` (of type `{float}`, which defaults to `1.`)
- `rate` (of type `{float}`, which defaults to `1.`)
- `tempo` (of type `{float}`, which defaults to `1.`)
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

This function is experimental.

### `stereo.ms.decode`

Decode mid+side stereo (M/S) to left+right stereo.

Type:
```
(?id : string?, ?width : float, source(audio=pcm(stereo),
 video='a, midi='b)) -> source(audio=pcm(stereo),
video='a, midi='b)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `width` (of type `float`, which defaults to `1.`): Width of the stereo field.
- `(unlabeled)` (of type `source(audio=pcm(stereo), video='a, midi='b)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `stereo.ms.encode`

Encode left+right stereo to mid+side stereo (M/S).

Type:
```
(?id : string?, source(audio=pcm(stereo), video='a,
 midi='b)) -> source(audio=pcm(stereo), video='a,
midi='b)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio=pcm(stereo), video='a, midi='b)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `stereo.pan`

Pan a stereo sound.

Type:
```
(?id : string?, ?field : {float}, ?pan : {float},
 source(audio=pcm(stereo), video='a, midi='b)) ->
source(audio=pcm(stereo), video='a, midi='b)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `field` (of type `{float}`, which defaults to `90.`): Field width in degrees (between 0 and 90).
- `pan` (of type `{float}`, which defaults to `0.`): Pan ranges between -1 and 1.
- `(unlabeled)` (of type `source(audio=pcm(stereo), video='a, midi='b)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `stereo.width`

Spacializer which allows controlling the width of the signal.

Type:
```
(?id : string?, ?{float}, source(audio=pcm(stereo),
 video='a, midi='b)) -> source(audio=pcm(stereo),
video='a, midi='b)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `{float}`, which defaults to `0.`): Width of the signal (-1: mono, 0.: original, 1.: wide stereo).
- `(unlabeled)` (of type `source(audio=pcm(stereo), video='a, midi='b)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `stretch`

Slow down or accelerate an audio stream by stretching (sounds lower) or squeezing it (sounds higher).

Type:
```
(?id : string?, ratio : {float}, source(audio=pcm('a),
 video='b, midi='c)) -> source(audio=pcm('a), video='b,
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `ratio` (of type `{float}`): A value higher than 1 means slowing down.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

## Source / Conversion

### `audio_to_stereo`

Convert any pcm audio source into a stereo source.

Type:
```
(?id : string?, source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm(stereo), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `drop_audio`

Drop all audio content of a stream.

Type:
```
(?id : string?, source(audio='a, video='b, midi='c)) ->
source(audio=none, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `drop_midi`

Drop all midi content of a stream.

Type:
```
(?id : string?, source(audio='a, video='b, midi='c)) ->
source(audio='a, video='b, midi=none)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `drop_video`

Drop all video content of a stream.

Type:
```
(?id : string?, source(audio='a, video='b, midi='c)) ->
source(audio='a, video=none, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `ffmpeg.decode.audio`

Convert a source's content

Type:
```
(?id : string?, source(audio=ffmpeg.audio.copy('a),
 video=none, midi=none)) -> source(audio=pcm('b),
video=none, midi=none)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio=ffmpeg.audio.copy('a), video=none,
midi=none)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `ffmpeg.decode.audio_video`

Convert a source's content

Type:
```
(?id : string?, source(audio=ffmpeg.audio.copy('a),
 video=ffmpeg.video.copy('b), midi=none)) ->
source(audio=pcm('c), video=yuva420p('d), midi=none)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio=ffmpeg.audio.copy('a),
video=ffmpeg.video.copy('b), midi=none)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `ffmpeg.decode.video`

Convert a source's content

Type:
```
(?id : string?, source(audio=none,
 video=ffmpeg.video.copy('a), midi=none)) ->
source(audio=none, video=yuva420p('b), midi=none)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio=none, video=ffmpeg.video.copy('a),
midi=none)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `ffmpeg.encode.audio`

Convert a source's content

Type:
```
(?id : string?, format(audio=pcm('a), video=none,
 midi=none), source(audio=pcm('a), video=none,
 midi=none)) -> source(audio=ffmpeg.audio.copy('c),
video=none, midi=none)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `format(audio=pcm('a), video=none, midi=none)`): Encoding format.
- `(unlabeled)` (of type `source(audio=pcm('a), video=none, midi=none)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `ffmpeg.encode.audio_video`

Convert a source's content

Type:
```
(?id : string?, format(audio=pcm('a), video=yuva420p('b),
 midi=none), source(audio=pcm('a), video=yuva420p('b),
 midi=none)) -> source(audio=ffmpeg.audio.copy('e),
video=ffmpeg.video.copy('f), midi=none)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `format(audio=pcm('a), video=yuva420p('b), midi=none)`): Encoding format.
- `(unlabeled)` (of type `source(audio=pcm('a), video=yuva420p('b), midi=none)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `ffmpeg.encode.video`

Convert a source's content

Type:
```
(?id : string?, format(audio=none, video=yuva420p('a),
 midi=none), source(audio=none, video=yuva420p('a),
 midi=none)) -> source(audio=none,
video=ffmpeg.video.copy('c), midi=none)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `format(audio=none, video=yuva420p('a), midi=none)`): Encoding format.
- `(unlabeled)` (of type `source(audio=none, video=yuva420p('a), midi=none)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `ffmpeg.raw.decode.audio`

Convert a source's content

Type:
```
(?id : string?, source(audio=ffmpeg.audio.raw('a),
 video=none, midi=none)) -> source(audio=pcm('b),
video=none, midi=none)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio=ffmpeg.audio.raw('a), video=none, midi=none)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `ffmpeg.raw.decode.audio_video`

Convert a source's content

Type:
```
(?id : string?, source(audio=ffmpeg.audio.raw('a),
 video=ffmpeg.video.raw('b), midi=none)) ->
source(audio=pcm('c), video=yuva420p('d), midi=none)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio=ffmpeg.audio.raw('a),
video=ffmpeg.video.raw('b), midi=none)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `ffmpeg.raw.decode.video`

Convert a source's content

Type:
```
(?id : string?, source(audio=none,
 video=ffmpeg.video.raw('a), midi=none)) ->
source(audio=none, video=yuva420p('b), midi=none)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio=none, video=ffmpeg.video.raw('a), midi=none)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `ffmpeg.raw.encode.audio`

Convert a source's content

Type:
```
(?id : string?, format(audio=ffmpeg.audio.raw('a),
 video=none, midi=none), source(audio=pcm('b),
 video=none, midi=none)) ->
source(audio=ffmpeg.audio.raw('a), video=none, midi=none)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `format(audio=ffmpeg.audio.raw('a), video=none, midi=none)`): Encoding format.
- `(unlabeled)` (of type `source(audio=pcm('b), video=none, midi=none)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `ffmpeg.raw.encode.audio_video`

Convert a source's content

Type:
```
(?id : string?, format(audio=ffmpeg.audio.raw('a),
 video=ffmpeg.video.raw('b), midi=none),
 source(audio=pcm('c), video=yuva420p('d), midi=none)) ->
source(audio=ffmpeg.audio.raw('a),
video=ffmpeg.video.raw('b), midi=none)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `format(audio=ffmpeg.audio.raw('a),
video=ffmpeg.video.raw('b), midi=none)`): Encoding format.
- `(unlabeled)` (of type `source(audio=pcm('c), video=yuva420p('d), midi=none)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `ffmpeg.raw.encode.video`

Convert a source's content

Type:
```
(?id : string?, format(audio=none,
 video=ffmpeg.video.raw('a), midi=none),
 source(audio=none, video=yuva420p('b), midi=none)) ->
source(audio=none, video=ffmpeg.video.raw('a), midi=none)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `format(audio=none, video=ffmpeg.video.raw('a), midi=none)`): Encoding format.
- `(unlabeled)` (of type `source(audio=none, video=yuva420p('b), midi=none)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `mean`

Produce mono audio by taking the mean of all audio channels.

Type:
```
(?id : string?, ?normalize : bool, source(audio=pcm('a),
 video='b, midi='c)) -> source(audio=pcm(mono), video='b,
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `normalize` (of type `bool`, which defaults to `true`): Divide the output volume by the number of channels.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`): Source whose mean should be computed.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `mux_audio`

Mux an audio stream into an audio-free stream. Track marks and metadata are taken from both sources.

Type:
```
(?id : string?, audio : source(audio='a, video=none,
 midi=none), source(audio=none, video='b, midi='c)) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `audio` (of type `source(audio='a, video=none, midi=none)`)
- `(unlabeled)` (of type `source(audio=none, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `mux_video`

Add video channels to a stream. Track marks and metadata are taken from both sources.

Type:
```
(?id : string?, video : source(audio=none, video='a,
 midi=none), source(audio='b, video=none, midi='c)) ->
source(audio='b, video='a, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `video` (of type `source(audio=none, video='a, midi=none)`)
- `(unlabeled)` (of type `source(audio='b, video=none, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `swap`

Swap two channels of a stereo source.

Type:
```
(?id : string?, source(audio=pcm(stereo), video='a,
 midi='b)) -> source(audio=pcm(stereo), video='a,
midi='b)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio=pcm(stereo), video='a, midi='b)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

## Source / Conversions

### `stereo.left`

Extract the left channel of a stereo source

Type:
```
(source(audio=pcm(stereo), video='a, midi='b)) ->
source(audio=pcm(mono), video='a, midi='b)
```

Arguments:

- `(unlabeled)` (of type `source(audio=pcm(stereo), video='a, midi='b)`): Source to extract from

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `stereo.right`

Extract the right channel of a stereo source

Type:
```
(source(audio=pcm(stereo), video='a, midi='b)) ->
source(audio=pcm(mono), video='a, midi='b)
```

Arguments:

- `(unlabeled)` (of type `source(audio=pcm(stereo), video='a, midi='b)`): Source to extract from

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

## Source / Input

### `blank`

Produce silence and blank images.

Type:
```
(?id : string?, ?duration : float) ->
source(audio=internal('a), video=internal('b),
midi=internal('c))
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `duration` (of type `float`, which defaults to `-1.`): Duration of blank tracks in seconds, Negative value means forever.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `input.alsa`

Stream from an ALSA input device.

Type:
```
(?id : string?, ?bufferize : bool, ?clock_safe : bool,
 ?device : string, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?start : bool) -> source(audio=pcm('a), video='b,
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `bufferize` (of type `bool`, which defaults to `true`): Bufferize input
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of a dedicated clock
- `device` (of type `string`, which defaults to `"default"`): Alsa device to use
- `fallible` (of type `bool`, which defaults to `false`): Allow the source to fail. If set to `false`, `start` must be `true` and `stop` method raises an error.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `input.external.avi`

Stream data from an external application.

Type:
```
(?id : string?, ?buffer : float, ?log_overfull : bool,
 ?max : float, ?restart : bool, ?restart_on_error : bool,
 string) -> source(audio=pcm('a), video=yuva420p('b),
midi=none)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `buffer` (of type `float`, which defaults to `1.`): Duration of the pre-buffered data.
- `log_overfull` (of type `bool`, which defaults to `true`): Log when the source's buffer is overfull.
- `max` (of type `float`, which defaults to `10.`): Maximum duration of the buffered data.
- `restart` (of type `bool`, which defaults to `true`): Restart process when exited.
- `restart_on_error` (of type `bool`, which defaults to `false`): Restart process when exited with error.
- `(unlabeled)` (of type `string`): Command to execute.

Methods:

- `buffer_length` (of type `() -> float * float * float`): Length of the buffer (in seconds).
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

This function is experimental.

### `input.external.rawaudio`

Stream raw PCM data (interleaved signed 16 bits little endian integers) from an external application.

Type:
```
(?id : string?, ?buffer : float, ?channels : int,
 ?log_overfull : bool, ?max : float, ?restart : bool,
 ?restart_on_error : bool, ?samplerate : int, string) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `buffer` (of type `float`, which defaults to `2.`): Duration of the pre-buffered data.
- `channels` (of type `int`, which defaults to `2`): Number of channels.
- `log_overfull` (of type `bool`, which defaults to `true`): Log when the source's buffer is overfull.
- `max` (of type `float`, which defaults to `10.`): Maximum duration of the buffered data.
- `restart` (of type `bool`, which defaults to `true`): Restart process when exited.
- `restart_on_error` (of type `bool`, which defaults to `false`): Restart process when exited with error.
- `samplerate` (of type `int`, which defaults to `44100`): Samplerate.
- `(unlabeled)` (of type `string`): Command to execute.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `input.external.rawvideo`

Stream data from an external application.

Type:
```
(?id : string?, ?buffer : float, ?log_overfull : bool,
 ?max : float, ?restart : bool, ?restart_on_error : bool,
 string) -> source(audio='a, video=yuva420p('b), midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `buffer` (of type `float`, which defaults to `1.`): Duration of the pre-buffered data.
- `log_overfull` (of type `bool`, which defaults to `true`): Log when the source's buffer is overfull.
- `max` (of type `float`, which defaults to `10.`): Maximum duration of the buffered data.
- `restart` (of type `bool`, which defaults to `true`): Restart process when exited.
- `restart_on_error` (of type `bool`, which defaults to `false`): Restart process when exited with error.
- `(unlabeled)` (of type `string`): Command to execute.

Methods:

- `buffer_length` (of type `() -> float * float * float`): Length of the buffer (in seconds).
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

This function is experimental.

### `input.external.wav`

Stream WAV data from an external application.

Type:
```
(?id : string?, ?buffer : float, ?log_overfull : bool,
 ?max : float, ?restart : bool, ?restart_on_error : bool,
 string) -> source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `buffer` (of type `float`, which defaults to `2.`): Duration of the pre-buffered data.
- `log_overfull` (of type `bool`, which defaults to `true`): Log when the source's buffer is overfull.
- `max` (of type `float`, which defaults to `10.`): Maximum duration of the buffered data.
- `restart` (of type `bool`, which defaults to `true`): Restart process when exited.
- `restart_on_error` (of type `bool`, which defaults to `false`): Restart process when exited with error.
- `(unlabeled)` (of type `string`): Command to execute.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `input.ffmpeg`

Create a stream using ffmpeg

Type:
```
(?id : string?, ?clock_safe : bool, ?debug : bool,
 ?float_args : [string * float], ?format : string?,
 ?int_args : [string * int], ?log_overfull : bool,
 ?max_buffer : float, ?new_track_on_metadata : bool,
 ?on_connect : (() -> unit),
 ?on_disconnect : (() -> unit), ?on_start : (() -> unit),
 ?on_stop : (() -> unit), ?poll_delay : float,
 ?self_sync : bool, ?start : bool,
 ?string_args : [string * string], {string}) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `clock_safe` (of type `bool`, which defaults to `false`): Force the use of a dedicated clock
- `debug` (of type `bool`, which defaults to `false`): Run in debugging mode, not catching some exceptions.
- `float_args` (of type `[string * float]`, which defaults to `[]`)
- `format` (of type `string?`, which defaults to `null`): Force a specific input format. Autodetected when passed a null argument
- `int_args` (of type `[string * int]`, which defaults to `[]`)
- `log_overfull` (of type `bool`, which defaults to `true`): Log when the source's buffer is overfull.
- `max_buffer` (of type `float`, which defaults to `5.`): Maximum uration of buffered data
- `new_track_on_metadata` (of type `bool`, which defaults to `true`): Treat new metadata as new track.
- `on_connect` (of type `() -> unit`, which defaults to `<fun>`): Function to execute when a source is connected.
- `on_disconnect` (of type `() -> unit`, which defaults to `<fun>`): Function to excecute when a source is disconnected
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `poll_delay` (of type `float`, which defaults to `2.`): Polling delay when trying to connect to the stream.
- `self_sync` (of type `bool`, which defaults to `false`): Should the source control its own timing? Set to `true` if you are having synchronization issues. Should be `false` for most typical cases.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `string_args` (of type `[string * string]`, which defaults to `[]`)
- `(unlabeled)` (of type `{string}`): URL to decode.

Methods:

- `buffer_length` (of type `() -> float`): Get the buffer's length in seconds.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `set_url` (of type `({string}) -> unit`): Set the source's url.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `status` (of type `() -> string`): Return the current status of the source, either "stopped" (the source isn't trying to relay the HTTP stream), "polling" (attempting to connect to the HTTP stream) or "connected <url>" (connected to <url>, buffering or playing back the stream).
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.
- `url` (of type `() -> string`): Return the source's current url.

### `input.gstreamer.audio`

Stream audio from a GStreamer pipeline.

Type:
```
(?id : string?, ?log_overfull : bool, ?max : float,
 ?on_error : ((string) -> float), ?pipeline : {string},
 ?restart : bool) -> source(audio=pcm('a), video='b,
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `log_overfull` (of type `bool`, which defaults to `true`): Log when the source's buffer is overfull.
- `max` (of type `float`, which defaults to `10.`): Maximum duration of the buffered data.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens. The callback receives a string representation of the error that occurred and returns a float. If returned value is positive, connection will be tried again after this amount of time (in seconds).
- `pipeline` (of type `{string}`, which defaults to `"audiotestsrc"`): GStreamer pipeline to input from.
- `restart` (of type `bool`, which defaults to `true`): Restart input on end of stream event.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `input.gstreamer.audio_video`

Stream audio+video from a GStreamer pipeline.

Type:
```
(?id : string?, ?audio_pipeline : {string},
 ?log_overfull : bool, ?max : float,
 ?on_error : ((string) -> float), ?pipeline : {string},
 ?restart : bool, ?video_pipeline : {string}) ->
source(audio=pcm(stereo), video=yuva420p('a), midi=none)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `audio_pipeline` (of type `{string}`, which defaults to `"audiotestsrc"`): Audio pipeline to input from.
- `log_overfull` (of type `bool`, which defaults to `true`): Log when the source's buffer is overfull.
- `max` (of type `float`, which defaults to `10.`): Maximum duration of the buffered data.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens. The callback receives a string representation of the error that occurred and returns a float. If returned value is positive, connection will be tried again after this amount of time (in seconds).
- `pipeline` (of type `{string}`, which defaults to `""`): Main GStreamer pipeline.
- `restart` (of type `bool`, which defaults to `true`): Restart input on end of stream event.
- `video_pipeline` (of type `{string}`, which defaults to `"videotestsrc"`): Video pipeline to input from.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `pause` (of type `() -> unit`): Pause input.
- `play` (of type `() -> unit`): Play input.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `restart` (of type `() -> unit`): Restart input.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `input.gstreamer.video`

Stream video from a GStreamer pipeline.

Type:
```
(?id : string?, ?log_overfull : bool, ?max : float,
 ?on_error : ((string) -> float), ?pipeline : {string},
 ?restart : bool) -> source(audio='a, video=yuva420p('b),
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `log_overfull` (of type `bool`, which defaults to `true`): Log when the source's buffer is overfull.
- `max` (of type `float`, which defaults to `10.`): Maximum duration of the buffered data.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens. The callback receives a string representation of the error that occurred and returns a float. If returned value is positive, connection will be tried again after this amount of time (in seconds).
- `pipeline` (of type `{string}`, which defaults to `"videotestsrc"`): GStreamer pipeline to input from.
- `restart` (of type `bool`, which defaults to `true`): Restart input on end of stream event.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `input.harbor`

Create a source that receives a http/icecast stream and forwards it as a stream.

Type:
```
(?id : string?,
 ?auth : ((
           {
             password : string,
             user : string,
             address : string
           }) -> bool)?,
 ?buffer : float, ?debug : bool, ?dumpfile : string?,
 ?icy : bool, ?icy_metadata_charset : string?,
 ?log_overfull : bool, ?logfile : string?, ?max : float,
 ?metadata_charset : string?,
 ?on_connect : (([string * string]) -> unit),
 ?on_disconnect : (() -> unit), ?password : string,
 ?port : int, ?replay_metadata : bool, ?timeout : float,
 ?user : string, string) -> source('a)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `auth` (of type `(({password : string, user : string, address : string}) ->
 bool)?`, which defaults to `null`): Authentication function. Receives a record with: `user`, `password` and `address` (client network address) and returns `true` if the user should be granted access for this login. Override any other method if used.
- `buffer` (of type `float`, which defaults to `2.`): Duration of the pre-buffered data.
- `debug` (of type `bool`, which defaults to `false`): Run in debugging mode by not catching some exceptions.
- `dumpfile` (of type `string?`, which defaults to `null`): Dump stream to file, for debugging purpose. Disabled if null.
- `icy` (of type `bool`, which defaults to `false`): Enable ICY (shoutcast) protocol.
- `icy_metadata_charset` (of type `string?`, which defaults to `null`): ICY (shoutcast) metadata charset. Guessed if null. Default for shoutcast is ISO-8859-1. Set to that value if all your clients send metadata using this charset and automatic detection is not working for you.
- `log_overfull` (of type `bool`, which defaults to `true`): Log when the source's buffer is overfull.
- `logfile` (of type `string?`, which defaults to `null`): Log buffer status to file, for debugging purpose. Disabled if null.
- `max` (of type `float`, which defaults to `10.`): Maximum duration of the buffered data.
- `metadata_charset` (of type `string?`, which defaults to `null`): Metadata charset for non-ICY (shoutcast) source protocols. Guessed if null.
- `on_connect` (of type `([string * string]) -> unit`, which defaults to `<fun>`): Function to execute when a source is connected. Its receives the list of headers, of the form: (<label>,<value>). All labels are lowercase.
- `on_disconnect` (of type `() -> unit`, which defaults to `<fun>`): Functions to execute when a source is disconnected
- `password` (of type `string`, which defaults to `"hackme"`): Source password.
- `port` (of type `int`, which defaults to `8005`): Port used to connect to the source.
- `replay_metadata` (of type `bool`, which defaults to `false`): Replay last known metadata when switching back to this source. This helps when source has dropped due to temporary connection issues.
- `timeout` (of type `float`, which defaults to `30.`): Timeout for source connectionn.
- `user` (of type `string`, which defaults to `"source"`): Source user.
- `(unlabeled)` (of type `string`): Mountpoint to look for.

Methods:

- `buffer_length` (of type `() -> float`): Length of the buffer (in seconds).
- `connected_client` (of type `() -> string?`): Returns the address of the client currently connected, if there is one.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `status` (of type `() -> string`): Current status of the input.
- `stop` (of type `() -> unit`): Stop the input.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `input.harbor.ssl`

Retrieves the given https stream from the harbor.

Type:
```
(?id : string?,
 ?auth : ((
           {
             password : string,
             user : string,
             address : string
           }) -> bool)?,
 ?buffer : float, ?debug : bool, ?dumpfile : string?,
 ?icy : bool, ?icy_metadata_charset : string?,
 ?log_overfull : bool, ?logfile : string?, ?max : float,
 ?metadata_charset : string?,
 ?on_connect : (([string * string]) -> unit),
 ?on_disconnect : (() -> unit), ?password : string,
 ?port : int, ?replay_metadata : bool, ?timeout : float,
 ?user : string, string) -> source('a)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `auth` (of type `(({password : string, user : string, address : string}) ->
 bool)?`, which defaults to `null`): Authentication function. Receives a record with: `user`, `password` and `address` (client network address) and returns `true` if the user should be granted access for this login. Override any other method if used.
- `buffer` (of type `float`, which defaults to `2.`): Duration of the pre-buffered data.
- `debug` (of type `bool`, which defaults to `false`): Run in debugging mode by not catching some exceptions.
- `dumpfile` (of type `string?`, which defaults to `null`): Dump stream to file, for debugging purpose. Disabled if null.
- `icy` (of type `bool`, which defaults to `false`): Enable ICY (shoutcast) protocol.
- `icy_metadata_charset` (of type `string?`, which defaults to `null`): ICY (shoutcast) metadata charset. Guessed if null. Default for shoutcast is ISO-8859-1. Set to that value if all your clients send metadata using this charset and automatic detection is not working for you.
- `log_overfull` (of type `bool`, which defaults to `true`): Log when the source's buffer is overfull.
- `logfile` (of type `string?`, which defaults to `null`): Log buffer status to file, for debugging purpose. Disabled if null.
- `max` (of type `float`, which defaults to `10.`): Maximum duration of the buffered data.
- `metadata_charset` (of type `string?`, which defaults to `null`): Metadata charset for non-ICY (shoutcast) source protocols. Guessed if null.
- `on_connect` (of type `([string * string]) -> unit`, which defaults to `<fun>`): Function to execute when a source is connected. Its receives the list of headers, of the form: (<label>,<value>). All labels are lowercase.
- `on_disconnect` (of type `() -> unit`, which defaults to `<fun>`): Functions to execute when a source is disconnected
- `password` (of type `string`, which defaults to `"hackme"`): Source password.
- `port` (of type `int`, which defaults to `8005`): Port used to connect to the source.
- `replay_metadata` (of type `bool`, which defaults to `false`): Replay last known metadata when switching back to this source. This helps when source has dropped due to temporary connection issues.
- `timeout` (of type `float`, which defaults to `30.`): Timeout for source connectionn.
- `user` (of type `string`, which defaults to `"source"`): Source user.
- `(unlabeled)` (of type `string`): Mountpoint to look for.

Methods:

- `buffer_length` (of type `() -> float`): Length of the buffer (in seconds).
- `connected_client` (of type `() -> string?`): Returns the address of the client currently connected, if there is one.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `status` (of type `() -> string`): Current status of the input.
- `stop` (of type `() -> unit`): Stop the input.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `input.hls`

Play an HLS stream.

Type:
```
(?id : string?, {string}) -> source(audio=?A, video=?B,
midi=?C)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `{string}`): Playlist URI.

Methods:

- `buffer_length` (of type `() -> float`): Get the buffer's length in seconds.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `set_url` (of type `({string}) -> unit`): Set the source's url.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `status` (of type `() -> string`): Return the current status of the source, either "stopped" (the source isn't trying to relay the HTTP stream), "polling" (attempting to connect to the HTTP stream) or "connected <url>" (connected to <url>, buffering or playing back the stream).
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.
- `url` (of type `() -> string`): Return the source's current url.

### `input.hls.native`

Play an HLS stream.

Type:
```
(?id : string?, ?reload : float, string) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `reload` (of type `float`, which defaults to `10.`): How often (in seconds) the playlist should be reloaded.
- `(unlabeled)` (of type `string`): Playlist URI.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

This function is experimental.

### `input.http`

Create a http stream using ffmpeg

Type:
```
(?id : string?, ?clock_safe : bool, ?debug : bool,
 ?float_args : [string * float], ?format : string?,
 ?int_args : [string * int], ?log_overfull : bool,
 ?max_buffer : float, ?new_track_on_metadata : bool,
 ?on_connect : (([string * string]) -> unit),
 ?on_disconnect : (() -> unit), ?on_start : (() -> unit),
 ?on_stop : (() -> unit), ?poll_delay : float,
 ?self_sync : bool, ?start : bool,
 ?string_args : [string * string], ?timeout : float,
 ?user_agent : string, {string}) -> source(audio='a,
video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `clock_safe` (of type `bool`, which defaults to `false`): Force the use of a dedicated clock
- `debug` (of type `bool`, which defaults to `false`): Run in debugging mode, not catching some exceptions.
- `float_args` (of type `[string * float]`, which defaults to `[]`)
- `format` (of type `string?`, which defaults to `null`): Force a specific input format. Autodetected when passed a null argument
- `int_args` (of type `[string * int]`, which defaults to `[]`)
- `log_overfull` (of type `bool`, which defaults to `true`): Log when the source's buffer is overfull.
- `max_buffer` (of type `float`, which defaults to `5.`): Maximum uration of buffered data
- `new_track_on_metadata` (of type `bool`, which defaults to `true`): Treat new metadata as new track.
- `on_connect` (of type `([string * string]) -> unit`, which defaults to `<fun>`): Function to execute when a source is connected. Its receives the list of ICY-specific headers, if available.
- `on_disconnect` (of type `() -> unit`, which defaults to `<fun>`): Function to excecute when a source is disconnected
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `poll_delay` (of type `float`, which defaults to `2.`): Polling delay when trying to connect to the stream.
- `self_sync` (of type `bool`, which defaults to `false`): Should the source control its own timing? Set to `true` if you are having synchronization issues. Should be `false` for most typical cases.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `string_args` (of type `[string * string]`, which defaults to `[]`)
- `timeout` (of type `float`, which defaults to `10.`): Timeout for source connection.
- `user_agent` (of type `string`, which defaults to `"Liquidsoap/2.0.0 (Unix; OCaml 4.12.0)"`): User agent.
- `(unlabeled)` (of type `{string}`): URL to decode.

Methods:

- `buffer_length` (of type `() -> float`): Get the buffer's length in seconds.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `set_url` (of type `({string}) -> unit`): Set the source's url.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `status` (of type `() -> string`): Return the current status of the source, either "stopped" (the source isn't trying to relay the HTTP stream), "polling" (attempting to connect to the HTTP stream) or "connected <url>" (connected to <url>, buffering or playing back the stream).
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.
- `url` (of type `() -> string`): Return the source's current url.

### `input.jack`

Get stream from jack.

Type:
```
(?id : string?, ?buffer_size : int, ?clock_safe : bool,
 ?fallible : bool, ?on_start : (() -> unit),
 ?on_stop : (() -> unit), ?server : string,
 ?start : bool) -> source(audio=pcm('a), video='b,
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `buffer_size` (of type `int`, which defaults to `2`): Set buffer size, in frames. Must be >= 1.
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of a dedicated clock
- `fallible` (of type `bool`, which defaults to `false`): Allow the source to fail. If set to `false`, `start` must be `true` and `stop` method raises an error.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `server` (of type `string`, which defaults to `""`): Jack server to connect to.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `input.keyboard.sdl`

Play notes from the keyboard.

Type:
```
(?id : string?, ?velocity : float) -> source(audio='a,
video='b, midi=midi('c))
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `velocity` (of type `float`, which defaults to `0.8`): Velocity of notes.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

This function is experimental.

### `input.oss`

Stream from an OSS input device.

Type:
```
(?id : string?, ?clock_safe : bool, ?device : string,
 ?fallible : bool, ?on_start : (() -> unit),
 ?on_stop : (() -> unit), ?start : bool) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of a dedicated clock
- `device` (of type `string`, which defaults to `"/dev/dsp"`): OSS device to use.
- `fallible` (of type `bool`, which defaults to `false`): Allow the source to fail. If set to `false`, `start` must be `true` and `stop` method raises an error.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `input.portaudio`

Stream from a portaudio input device.

Type:
```
(?id : string?, ?buflen : int, ?clock_safe : bool,
 ?fallible : bool, ?on_start : (() -> unit),
 ?on_stop : (() -> unit), ?start : bool) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `buflen` (of type `int`, which defaults to `256`): Length of a buffer in samples.
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of a dedicated clock
- `fallible` (of type `bool`, which defaults to `false`): Allow the source to fail. If set to `false`, `start` must be `true` and `stop` method raises an error.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `input.pulseaudio`

Stream from a portaudio input device.

Type:
```
(?id : string?, ?client : string, ?clock_safe : bool,
 ?clock_safe : bool, ?device : string, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?start : bool) -> source(audio=pcm('a), video='b,
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `client` (of type `string`, which defaults to `"liquidsoap"`)
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of a dedicated clock
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of the dedicated Pulseaudio clock.
- `device` (of type `string`, which defaults to `""`): Device to use. Uses default if set to "".
- `fallible` (of type `bool`, which defaults to `false`): Allow the source to fail. If set to `false`, `start` must be `true` and `stop` method raises an error.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `input.rtmp`

Read an RTMP stream.

Type:
```
(?max_buffer : float, ?timeout : float, {string}) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `max_buffer` (of type `float`, which defaults to `5.`): Maximum data buffer in seconds
- `timeout` (of type `float`, which defaults to `10.`): Timeout for source connection
- `(unlabeled)` (of type `{string}`): URL to read RTMP from, in the form `rtmp://IP:PORT/ENDPOINT`

Methods:

- `buffer_length` (of type `() -> float`): Get the buffer's length in seconds.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `set_url` (of type `({string}) -> unit`): Set the source's url.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `status` (of type `() -> string`): Return the current status of the source, either "stopped" (the source isn't trying to relay the HTTP stream), "polling" (attempting to connect to the HTTP stream) or "connected <url>" (connected to <url>, buffering or playing back the stream).
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.
- `url` (of type `() -> string`): Return the source's current url.

### `input.srt`

Receive a SRT stream from a distant agent.

Type:
```
(?id : string?, ?bind_address : string,
 ?clock_safe : bool, ?content_type : string,
 ?dump : string, ?host : string, ?log_overfull : bool,
 ?max : float, ?messageapi : bool, ?mode : string,
 ?on_connect : ((unit) -> unit),
 ?on_disconnect : (() -> unit), ?on_start : (() -> unit),
 ?on_stop : (() -> unit), ?payload_size : int,
 ?port : int, ?start : bool, ?stats_interval : int,
 ?stats_interval : int?) -> source(audio='a, video='b,
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `bind_address` (of type `string`, which defaults to `"0.0.0.0"`): Address to bind on the local machine. Used only in listener mode
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of a dedicated clock
- `content_type` (of type `string`, which defaults to `"application/ffmpeg"`): Content-Type (mime type) used to find a decoder for the input stream.
- `dump` (of type `string`, which defaults to `""`): Dump received data to the given file for debugging. Unused is empty.
- `host` (of type `string`, which defaults to `"localhost"`): Address to connect to. Used only in caller mode.
- `log_overfull` (of type `bool`, which defaults to `true`): Log when the source's buffer is overfull.
- `max` (of type `float`, which defaults to `10.`): Maximum duration of the buffered data.
- `messageapi` (of type `bool`, which defaults to `true`): Use message api
- `mode` (of type `string`, which defaults to `"listener"`): Mode to operate on. One of: `"listener"` (waits for connection to come in) or `"caller"` (initiate connection to a remote server)
- `on_connect` (of type `(unit) -> unit`, which defaults to `<fun>`): Function to execute when connected.
- `on_disconnect` (of type `() -> unit`, which defaults to `<fun>`): Function to execute when disconnected
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `payload_size` (of type `int`, which defaults to `1316`): Payload size.
- `port` (of type `int`, which defaults to `8000`): Port to bind on the local machine (listener mode) or to connect to (caller mode). The term `port` as used in SRT is occasionally identical to the term `UDP port`. However SRT offers more flexibility than UDP because it manages ports as its own resources. For example, one port may be shared between various services.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `stats_interval` (of type `int`, which defaults to `100`): Interval used to collect statistics
- `stats_interval` (of type `int?`, which defaults to `null`): Interval used to collect internal stats in milliseconds

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `stats` (of type `() -> 
{
  pktRcvFilterLoss : int,
  pktRcvFilterSupply : int,
  pktRcvFilterExtra : int,
  pktSndFilterExtra : int,
  pktRcvFilterLossTotal : int,
  pktRcvFilterSupplyTotal : int,
  pktRcvFilterExtraTotal : int,
  pktSndFilterExtraTotal : int,
  msRcvTsbPdDelay : int,
  msRcvBuf : int,
  byteRcvBuf : int,
  pktRcvBuf : int,
  msSndTsbPdDelay : int,
  msSndBuf : int,
  byteSndBuf : int,
  pktSndBuf : int,
  byteMSS : int,
  mbpsMaxBW : float,
  byteAvailRcvBuf : int,
  byteAvailSndBuf : int,
  mbpsBandwidth : float,
  msRTT : float,
  pktFlightSize : int,
  pktCongestionWindow : int,
  pktFlowWindow : int,
  usPktSndPeriod : float,
  byteRcvUndecrypt : int,
  byteRcvDrop : int,
  byteSndDrop : int,
  byteRetrans : int,
  byteRecv : int,
  byteSent : int,
  pktRcvUndecrypt : int,
  pktRcvDrop : int,
  pktSndDrop : int,
  pktRcvBelated : int,
  pktRcvAvgBelatedTime : float,
  pktReorderDistance : int,
  usSndDuration : int,
  mbpsRecvRate : float,
  mbpsSendRate : float,
  pktRecvNAK : int,
  pktSentNAK : int,
  pktRecvACK : int,
  pktSentACK : int,
  pktRcvRetrans : int,
  pktRetrans : int,
  pktRcvLoss : int,
  pktSndLoss : int,
  pktRecv : int,
  pktSent : int,
  byteRcvUndecryptTotal : int,
  byteRcvDropTotal : int,
  byteSndDropTotal : int,
  byteRetransTotal : int,
  byteRecvTotal : int,
  byteSentTotal : int,
  pktRcvUndecryptTotal : int,
  pktRcvDropTotal : int,
  pktSndDropTotal : int,
  usSndDurationTotal : int,
  pktRecvNAKTotal : int,
  pktSentNAKTotal : int,
  pktRecvACKTotal : int,
  pktSentACKTotal : int,
  pktRetransTotal : int,
  pktRcvLossTotal : int,
  pktSndLossTotal : int,
  pktRecvTotal : int,
  pktSentTotal : int,
  msTimeStamp : int}`): Statistics.
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `input.v4l2`

Stream from a video4linux2 input device, such as a webcam.

Type:
```
(?id : string?, ?max_buffer : float, ?device : string) ->
source(audio=none, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `max_buffer` (of type `float`, which defaults to `0.5`): Maximum data buffer in seconds
- `device` (of type `string`, which defaults to `"/dev/video0"`): V4L2 device to use.

### `native.request.dynamic`

Play request dynamically created by a given function.

Type:
```
(?id : string?, ?available : {bool}, ?prefetch : int,
 ?retry_delay : {float}, ?timeout : float,
 (() -> request?)) -> source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `available` (of type `{bool}`, which defaults to `true`): Whether some new requests are available (when set to false, it stops after current playing request).
- `prefetch` (of type `int`, which defaults to `1`): How many requests should be queued in advance.
- `retry_delay` (of type `{float}`, which defaults to `0.1`): Retry after a given time (in seconds) when callback returns an empty list.
- `timeout` (of type `float`, which defaults to `20.`): Timeout (in sec.) for a single download.
- `(unlabeled)` (of type `() -> request?`)

Methods:

- `add` (of type `(request) -> bool`)
- `current` (of type `() -> request?`)
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `fetch` (of type `() -> bool`)
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `queue` (of type `() -> [request]`)
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `set` (of type `(source(audio=?A, video=?B, midi=?C)) -> unit`): Set the source.
- `set_queue` (of type `([request]) -> unit`)
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `native.request.dynamic.list`

Play request dynamically created by a given function.

Type:
```
(?id : string?, ?available : {bool}, ?prefetch : int,
 ?retry_delay : {float}, ?timeout : float,
 (() -> [request])) -> source(audio='a, video='b,
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `available` (of type `{bool}`, which defaults to `true`): Whether some new requests are available (when set to false, it stops after current playing request).
- `prefetch` (of type `int`, which defaults to `1`): How many requests should be queued in advance.
- `retry_delay` (of type `{float}`, which defaults to `0.1`): Retry after a given time (in seconds) when callback returns an empty list.
- `timeout` (of type `float`, which defaults to `20.`): Timeout (in sec.) for a single download.
- `(unlabeled)` (of type `() -> [request]`)

Methods:

- `add` (of type `(request) -> bool`)
- `current` (of type `() -> request?`)
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `fetch` (of type `() -> bool`)
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `queue` (of type `() -> [request]`)
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `set` (of type `(source(audio=?A, video=?B, midi=?C)) -> unit`): Set the source.
- `set_queue` (of type `([request]) -> unit`)
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `noise`

Generate audio white noise.

Type:
```
(?id : string?, ?duration : float?) ->
source(audio=internal('a), video=internal('b),
midi=internal('c))
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `duration` (of type `float?`, which defaults to `null`): Duration in seconds (`null` means infinite).

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `playlist`

Read a playlist or a directory and play all files.

Type:
```
(?id : string?, ?check_next : ((request) -> bool)?,
 ?prefetch : int, ?loop : bool, ?mime_type : string?,
 ?mode : string, ?native : bool,
 ?on_reload : ((string) -> unit), ?prefix : string,
 ?reload : int, ?reload_mode : string, ?timeout : float,
 string) -> source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `check_next` (of type `((request) -> bool)?`, which defaults to `null`): Function used to filter next tracks. A candidate track is only validated if the function returns true on it. The function is called before resolution, hence metadata will only be available for requests corresponding to local files. This is typically used to avoid repetitions, but be careful: if the function rejects all attempts, the playlist will enter into a consuming loop and stop playing anything.
- `prefetch` (of type `int`, which defaults to `1`): How many requests should be queued in advance.
- `loop` (of type `bool`, which defaults to `true`): Loop on the playlist.
- `mime_type` (of type `string?`, which defaults to `null`): Default MIME type for the playlist. `null` means automatic detection.
- `mode` (of type `string`, which defaults to `"randomize"`): Play the files in the playlist either in the order ("normal" mode), or shuffle the playlist each time it is loaded, and play it in this order for a whole round ("randomize" mode), or pick a random file in the playlist each time ("random" mode).
- `native` (of type `bool`, which defaults to `false`): Use native implementation.
- `on_reload` (of type `(string) -> unit`, which defaults to `<fun>`): Callback called after playlist has reloaded.
- `prefix` (of type `string`, which defaults to `""`): Add a constant prefix to all requests. Useful for passing extra information using annotate, or for resolution through a particular protocol, such as replaygain.
- `reload` (of type `int`, which defaults to `0`): Amount of time (in seconds or rounds), when applicable, before which the playlist is reloaded; 0 means never.
- `reload_mode` (of type `string`, which defaults to `"seconds"`): Unit of the reload parameter, either "never" (never reload the playlist), "rounds", "seconds" or "watch" (reload the file whenever it is changed).
- `timeout` (of type `float`, which defaults to `20.`): Timeout (in sec.) for a single download.
- `(unlabeled)` (of type `string`): Playlist URI.

Methods:

- `add` (of type `(request) -> bool`): Add a request ot the queue. Requests are resolved before being added. Returns `true` if the request was successfully added.
- `current` (of type `() -> request?`): Get the request currently being played.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `fetch` (of type `() -> bool`): Try feeding the queue with a new request. Returns `true` if successful. This method can take long to return and should usually be run in a separate thread.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `length` (of type `() -> int`): Length of the of the playlist (the number of songs it contains).
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `queue` (of type `() -> [request]`): Get the requests currently in the queue.
- `reload` (of type `(?uri : string?) -> unit`): Reload the playlist.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `set_queue` (of type `([request]) -> unit`): Set the queue of requests. Requests are resolved before being added to the queue. You are responsible for destroying the requests currently in the queue.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `playlist.list`

Play a list of files.

Type:
```
(?id : string?, ?check_next : ((request) -> bool)?,
 ?prefetch : int, ?loop : bool, ?mode : string,
 ?native : bool, ?on_done : (() -> unit),
 ?max_fail : int, ?on_fail : (() -> [string])?,
 ?timeout : float, [string]) -> source(audio='a,
video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `check_next` (of type `((request) -> bool)?`, which defaults to `null`): Function used to filter next tracks. A candidate track is only validated if the function returns true on it. The function is called before resolution, hence metadata will only be available for requests corresponding to local files. This is typically used to avoid repetitions, but be careful: if the function rejects all attempts, the playlist will enter into a consuming loop and stop playing anything.
- `prefetch` (of type `int`, which defaults to `1`): How many requests should be queued in advance.
- `loop` (of type `bool`, which defaults to `true`): Loop on the playlist.
- `mode` (of type `string`, which defaults to `"normal"`): Play the files in the playlist either in the order ("normal" mode), or shuffle the playlist each time it is loaded, and play it in this order for a whole round ("randomize" mode), or pick a random file in the playlist each time ("random" mode).
- `native` (of type `bool`, which defaults to `false`): Use native implementation.
- `on_done` (of type `() -> unit`, which defaults to `<fun>`): Function executed when the playlist is finished.
- `max_fail` (of type `int`, which defaults to `10`): When this number of requests fail to resolve, the whole playlists is considered as failed and `on_fail` is called.
- `on_fail` (of type `(() -> [string])?`, which defaults to `null`): Function executed when too many requests failed and returning the contents of a fixed playlist.
- `timeout` (of type `float`, which defaults to `20.`): Timeout (in sec.) for a single download.
- `(unlabeled)` (of type `[string]`): Playlist.

Methods:

- `add` (of type `(request) -> bool`): Add a request ot the queue. Requests are resolved before being added. Returns `true` if the request was successfully added.
- `current` (of type `() -> request?`): Get the request currently being played.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `fetch` (of type `() -> bool`): Try feeding the queue with a new request. Returns `true` if successful. This method can take long to return and should usually be run in a separate thread.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `queue` (of type `() -> [request]`): Get the requests currently in the queue.
- `reload` (of type `([string]) -> unit`): Reload the playlist with given list of songs.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `set_queue` (of type `([request]) -> unit`): Set the queue of requests. Requests are resolved before being added to the queue. You are responsible for destroying the requests currently in the queue.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `playlist.reloadable`

Read a playlist or a directory, play all files and stop. It returns a pair `(reload,source)` where `reload` is a function of type `(?uri:string)->unit` that can be used to reload the source and `source` is the actual source. The reload function can optionally be called with a new playlist URI, otherwise, it reloads the previous URI.

Type:
```
(?id : string?, ?check_next : ((request) -> bool)?,
 ?prefetch : int, ?loop : bool, ?mime_type : string?,
 ?mode : string, ?native : bool, ?on_done : (() -> unit),
 ?on_reload : ((string) -> unit), ?prefix : string,
 ?timeout : float, string) -> source(audio='a, video='b,
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `check_next` (of type `((request) -> bool)?`, which defaults to `null`): Function used to filter next tracks. A candidate track is only validated if the function returns true on it. The function is called before resolution, hence metadata will only be available for requests corresponding to local files. This is typically used to avoid repetitions, but be careful: if the function rejects all attempts, the playlist will enter into a consuming loop and stop playing anything.
- `prefetch` (of type `int`, which defaults to `1`): How many requests should be queued in advance.
- `loop` (of type `bool`, which defaults to `true`): Loop on the playlist.
- `mime_type` (of type `string?`, which defaults to `null`): Default MIME type for the playlist. `null` means automatic detection.
- `mode` (of type `string`, which defaults to `"randomize"`): Play the files in the playlist either in the order ("normal" mode), or shuffle the playlist each time it is loaded, and play it in this order for a whole round ("randomize" mode), or pick a random file in the playlist each time ("random" mode).
- `native` (of type `bool`, which defaults to `false`): Use native implementation.
- `on_done` (of type `() -> unit`, which defaults to `<fun>`): Function executed when the playlist is finished.
- `on_reload` (of type `(string) -> unit`, which defaults to `<fun>`): Callback called after playlist has reloaded.
- `prefix` (of type `string`, which defaults to `""`): Add a constant prefix to all requests. Useful for passing extra information using annotate, or for resolution through a particular protocol, such as replaygain.
- `timeout` (of type `float`, which defaults to `20.`): Timeout (in sec.) for a single download.
- `(unlabeled)` (of type `string`): Playlist URI.

Methods:

- `add` (of type `(request) -> bool`): Add a request ot the queue. Requests are resolved before being added. Returns `true` if the request was successfully added.
- `current` (of type `() -> request?`): Get the request currently being played.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `fetch` (of type `() -> bool`): Try feeding the queue with a new request. Returns `true` if successful. This method can take long to return and should usually be run in a separate thread.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `length` (of type `() -> int`): Length of the of the playlist (the number of songs it contains).
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `queue` (of type `() -> [request]`): Get the requests currently in the queue.
- `reload` (of type `(?uri : string?) -> unit`): Reload the playlist.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `set_queue` (of type `([request]) -> unit`): Set the queue of requests. Requests are resolved before being added to the queue. You are responsible for destroying the requests currently in the queue.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `request.dynamic`

Play request dynamically created by a given function.

Type:
```
(?id : string?, ?available : {bool}, ?prefetch : int,
 ?retry_delay : {float}, ?timeout : float,
 ?native : bool, (() -> request?)) -> source(audio='a,
video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `available` (of type `{bool}`, which defaults to `true`): Whether some new requests are available (when set to false, it stops after current playing request).
- `prefetch` (of type `int`, which defaults to `1`): How many requests should be queued in advance.
- `retry_delay` (of type `{float}`, which defaults to `0.1`): Retry after a given time (in seconds) when callback returns an empty list.
- `timeout` (of type `float`, which defaults to `20.`): Timeout (in sec.) for a single download.
- `native` (of type `bool`, which defaults to `false`): Use native implementation.
- `(unlabeled)` (of type `() -> request?`)

Methods:

- `add` (of type `(request) -> bool`): Add a request ot the queue. Requests are resolved before being added. Returns `true` if the request was successfully added.
- `current` (of type `() -> request?`): Get the request currently being played.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `fetch` (of type `() -> bool`): Try feeding the queue with a new request. Returns `true` if successful. This method can take long to return and should usually be run in a separate thread.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `queue` (of type `() -> [request]`): Get the requests currently in the queue.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `set_queue` (of type `([request]) -> unit`): Set the queue of requests. Requests are resolved before being added to the queue. You are responsible for destroying the requests currently in the queue.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `request.dynamic.list`

Play request dynamically created by a given function.

Type:
```
(?id : string?, ?available : {bool}, ?prefetch : int,
 ?retry_delay : {float}, ?timeout : float,
 (() -> [request])) -> source(audio='a, video='b,
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `available` (of type `{bool}`, which defaults to `true`): Whether some new requests are available (when set to false, it stops after current playing request).
- `prefetch` (of type `int`, which defaults to `1`): How many requests should be queued in advance.
- `retry_delay` (of type `{float}`, which defaults to `0.1`): Retry after a given time (in seconds) when callback returns an empty list.
- `timeout` (of type `float`, which defaults to `20.`): Timeout (in sec.) for a single download.
- `(unlabeled)` (of type `() -> [request]`)

Methods:

- `add` (of type `(request) -> bool`): Add a request ot the queue. Requests are resolved before being added. Returns `true` if the request was successfully added.
- `current` (of type `() -> request?`): Get the request currently being played.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `fetch` (of type `() -> bool`): Try feeding the queue with a new request. Returns `true` if successful. This method can take long to return and should usually be run in a separate thread.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `queue` (of type `() -> [request]`): Get the requests currently in the queue.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `set_queue` (of type `([request]) -> unit`): Set the queue of requests. Requests are resolved before being added to the queue. You are responsible for destroying the requests currently in the queue.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `request.once`

Play a request once and become unavailable.

Type:
```
(?id : string?, ?timeout : float, request) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `timeout` (of type `float`, which defaults to `20.`): Timeout in seconds for resolving the request.
- `(unlabeled)` (of type `request`): Request to play.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `request` (of type `request`): Get the request played by this source
- `resolve` (of type `() -> bool`): Resolve the request (this is useful to make sure that the source will be available in advance). This function returns `true` if we were able to successfully perform resolution. You should use this method instead of `request.resolve` to make sure that the proper content type is decoded from the request.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `saw`

Generate a saw wave.

Type:
```
(?id : string?, ?amplitude : {float}, ?duration : float?,
 ?{float}) -> source(audio=internal('a),
video=internal('b), midi=internal('c))
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `amplitude` (of type `{float}`, which defaults to `1.`): Maximal value of the waveform.
- `duration` (of type `float?`, which defaults to `null`): Duration in seconds (`null` means infinite).
- `(unlabeled)` (of type `{float}`, which defaults to `440.`): Frequency of the saw.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `sine`

Generate a sine wave.

Type:
```
(?id : string?, ?amplitude : {float}, ?duration : float?,
 ?{float}) -> source(audio=internal('a),
video=internal('b), midi=internal('c))
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `amplitude` (of type `{float}`, which defaults to `1.`): Maximal value of the waveform.
- `duration` (of type `float?`, which defaults to `null`): Duration in seconds (`null` means infinite).
- `(unlabeled)` (of type `{float}`, which defaults to `440.`): Frequency of the sine.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `single`

Loop on a request. It never fails if the request is static, meaning that it can be fetched once. Typically, http, ftp, say requests are static, and time is not.

Type:
```
(?id : string?, ?fallible : bool, ?prefetch : int,
 ?timeout : float, string) -> source(audio='a, video='b,
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `fallible` (of type `bool`, which defaults to `false`): Enforce fallibility of the request.
- `prefetch` (of type `int`, which defaults to `1`): How many requests should be queued in advance.
- `timeout` (of type `float`, which defaults to `20.`): Timeout (in sec.) for a single download.
- `(unlabeled)` (of type `string`): URI where to find the file

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `source.fail`

A source that does not produce anything. No silence, no track at all.

Type:
```
(?id : string?) -> source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `source.fail.init`

A source that errors during its initialization phase, used for testing and debugging.

Type:
```
(?id : string?) -> source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

This function is experimental.

### `square`

Generate a square wave.

Type:
```
(?id : string?, ?amplitude : {float}, ?duration : float?,
 ?{float}) -> source(audio=internal('a),
video=internal('b), midi=internal('c))
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `amplitude` (of type `{float}`, which defaults to `1.`): Maximal value of the waveform.
- `duration` (of type `float?`, which defaults to `null`): Duration in seconds (`null` means infinite).
- `(unlabeled)` (of type `{float}`, which defaults to `440.`): Frequency of the square.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

## Source / Liquidsoap

### `buffer`

Create a buffer between two different clocks.

Type:
```
(?id : string?, ?buffer : float, ?fallible : bool,
 ?max : float, ?on_start : (() -> unit),
 ?on_stop : (() -> unit), ?start : bool, source(audio='a,
 video='b, midi='c)) -> source(audio='a, video='b,
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `buffer` (of type `float`, which defaults to `1.`): Amount of data to pre-buffer, in seconds.
- `fallible` (of type `bool`, which defaults to `true`): Allow the child source to fail.
- `max` (of type `float`, which defaults to `10.`): Maximum amount of buffered data, in seconds.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `buffer.adaptative`

Create a buffer between two different clocks. The speed of the output is adapted so that no buffer underrun or overrun occurs. This wonderful behavior has a cost: the pitch of the sound might be changed a little.

Type:
```
(?id : string?, ?averaging : float, ?buffer : float,
 ?fallible : bool, ?limit : float, ?max : float,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?reset : bool, ?start : bool, source(audio=pcm('a),
 video='b, midi='c)) -> source(audio=pcm('a), video='b,
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `averaging` (of type `float`, which defaults to `30.`): Half-life for the averaging of the buffer size, in seconds.
- `buffer` (of type `float`, which defaults to `1.`): Amount of data to pre-buffer, in seconds.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be stopped until the source is available again.
- `limit` (of type `float`, which defaults to `1.25`): Maximum acceleration or deceleration factor.
- `max` (of type `float`, which defaults to `10.`): Maximum amount of buffered data, in seconds.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `reset` (of type `bool`, which defaults to `false`): Reset speed estimation to 1. when the source becomes available again.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

This function is experimental.

## Source / MIDI Processing

### `midi.chord`

Generate a chord.

Type:
```
(?id : string?, ?metadata : string, source(audio='a,
 video='b, midi='c)) -> source(audio='d, video='e,
midi=midi(channels=1))
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `metadata` (of type `string`, which defaults to `"chord"`): Name of the metadata containing the chords.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `midi.merge_all`

Merge all MIDI tracks in one.

Type:
```
(?id : string?, ?track_out : int, source(audio='a,
 video='b, midi=midi('c))) -> source(audio='a, video='b,
midi=midi('c))
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `track_out` (of type `int`, which defaults to `0`): Destination track.
- `(unlabeled)` (of type `source(audio='a, video='b, midi=midi('c))`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `midi.remove`

Remove MIDI tracks.

Type:
```
(?id : string?, [int], source(audio='a, video='b,
 midi=midi('c))) -> source(audio='a, video='b,
midi=midi('c))
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `[int]`): Tracks to remove.
- `(unlabeled)` (of type `source(audio='a, video='b, midi=midi('c))`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

## Source / Output

### `ffmpeg.filter.audio_video.output`

Return a source with audio and video from a filter's output.

Type:
```
(?id : string?, ?buffer : float, ?fps : int?,
 ffmpeg.filter.graph, ffmpeg.filter.audio,
 ffmpeg.filter.video) ->
source(audio=ffmpeg.audio.raw('a),
video=ffmpeg.video.raw('b), midi=none)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `buffer` (of type `float`, which defaults to `0.1`)
- `fps` (of type `int?`, which defaults to `null`)
- `(unlabeled)` (of type `ffmpeg.filter.graph`): Force the value of the source ID.
- `(unlabeled)` (of type `ffmpeg.filter.audio`): Duration of the pre-buffered data.
- `(unlabeled)` (of type `ffmpeg.filter.video`): Output frame per seconds. Defaults to global value.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `output.alsa`

Output the source's stream to an ALSA output device.

Type:
```
(?id : string?, ?bufferize : bool, ?clock_safe : bool,
 ?device : string, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?start : bool, source(audio=pcm('a), video='b, midi='c)) ->
unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `bufferize` (of type `bool`, which defaults to `true`): Bufferize output
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of the dedicated ALSA clock
- `device` (of type `string`, which defaults to `"default"`): Alsa device to use
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be stopped until the source is available again.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `output.ao`

Output stream to local sound card using libao.

Type:
```
(?id : string?, ?buffer_size : int,
 ?channels_matrix : string, ?clock_safe : bool,
 ?driver : string, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?options : [string * string], ?start : bool,
 source(audio=pcm('a), video='b, midi='c)) -> unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `buffer_size` (of type `int`, which defaults to `2`): Set buffer size, in frames.
- `channels_matrix` (of type `string`, which defaults to `""`): Output channels matrix, "" for AO's default.
- `clock_safe` (of type `bool`, which defaults to `true`): Use the dedicated AO clock.
- `driver` (of type `string`, which defaults to `""`): Driver to be used, "" for AO's default.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be stopped until the source is available again.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `options` (of type `[string * string]`, which defaults to `[]`): List of parameters, depends on the driver.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `output.dummy`

Dummy output for debugging purposes.

Type:
```
(?id : string?, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?start : bool, source(audio='a, video='b, midi='c)) ->
unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be stopped until the source is available again.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `output.external`

Send the stream to a process' standard input.

Type:
```
(?id : string?, ?fallible : bool, ?flush : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?reopen_delay : float, ?reopen_on_error : bool,
 ?reopen_on_metadata : bool, ?reopen_when : (() -> bool),
 ?self_sync : bool, ?start : bool, format('a), {string},
 source('a)) -> unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be stopped until the source is available again.
- `flush` (of type `bool`, which defaults to `false`): Perform a flush after each write.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `reopen_delay` (of type `float`, which defaults to `120.`): Prevent re-opening within that delay, in seconds.
- `reopen_on_error` (of type `bool`, which defaults to `false`): Re-open if some error occurs.
- `reopen_on_metadata` (of type `bool`, which defaults to `false`): Re-open on every new metadata information.
- `reopen_when` (of type `() -> bool`, which defaults to `{false}`): When should the output be re-opened.
- `self_sync` (of type `bool`, which defaults to `false`): Set to `true` if the process is expected to control the output's latency. Typical example: `ffmpeg` with the `-re` command-line option.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `(unlabeled)` (of type `format('a)`)
- `(unlabeled)` (of type `{string}`): Process to pipe data to. Some strftime conversion specifiers are available: `%SMHdmY`. You can also use `$(..)` interpolation notation for metadata.
- `(unlabeled)` (of type `source('a)`): Encoding format.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `reopen` (of type `() -> unit`): Reopen the pipe.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `output.file`

Output the source stream to a file.

Type:
```
(?id : string?, ?append : bool, ?dir_perm : int,
 ?fallible : bool, ?flush : bool,
 ?on_close : ((string) -> unit),
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?perm : int, ?reopen_delay : float,
 ?reopen_on_error : bool, ?reopen_on_metadata : bool,
 ?reopen_when : (() -> bool), ?start : bool, format('a),
 {string}, source('a)) -> unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `append` (of type `bool`, which defaults to `false`): Do not truncate but append in the file if it exists.
- `dir_perm` (of type `int`, which defaults to `511`): Permission of the directories if some have to be created, up to umask. Although you can enter values in octal notation (0oXXX) they will be displayed in decimal (for instance, 0o777 = 7*8^2 + 7*8 + 7 = 511).
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be stopped until the source is available again.
- `flush` (of type `bool`, which defaults to `false`): Perform a flush after each write.
- `on_close` (of type `(string) -> unit`, which defaults to `<fun>`): This function will be called for each file, after that it is finished and closed. The filename will be passed as argument.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `perm` (of type `int`, which defaults to `438`): Permission of the file if it has to be created, up to umask. You can and should write this number in octal notation: 0oXXX. The default value is however displayed in decimal (0o666 = 6*8^2 + 6*8 + 6 = 438).
- `reopen_delay` (of type `float`, which defaults to `120.`): Prevent re-opening within that delay, in seconds.
- `reopen_on_error` (of type `bool`, which defaults to `false`): Re-open if some error occurs.
- `reopen_on_metadata` (of type `bool`, which defaults to `false`): Re-open on every new metadata information.
- `reopen_when` (of type `() -> bool`, which defaults to `{false}`): When should the output be re-opened.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `(unlabeled)` (of type `format('a)`): Encoding format.
- `(unlabeled)` (of type `{string}`): Filename where to output the stream. Some strftime conversion specifiers are available: `%SMHdmY`. You can also use `$(..)` interpolation notation for metadata.
- `(unlabeled)` (of type `source('a)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `output.file.hls`

Output the source stream to an HTTP live stream served from a local directory.

Type:
```
(?id : string?, ?encode_metadata : bool,
 ?fallible : bool,
 ?on_file_change : ((state : string, string) -> unit),
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?perm : int, ?persist_at : string?, ?playlist : string,
 ?prefix : string, ?segment_duration : float,
 ?segment_name : ((position : int, extname : string,
                   string) -> string),
 ?segments : int, ?segments_overhead : int,
 ?start : bool,
 ?streams_info : [string *
                  (int * string * string * (int * int)?)],
 ?strict_persist : bool, string, [string * format('a)],
 source('a)) -> unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `encode_metadata` (of type `bool`, which defaults to `false`): Insert metadata into encoded stream. Note: Some HLS players (in particular android native HLS player) expect a single mpegts stream. Encoding metadata will break that assumption.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be stopped until the source is available again.
- `on_file_change` (of type `(state : string, string) -> unit`, which defaults to `<fun>`): Callback executed when a file changes. `state` is one of: `"opened"`, `"closed"` or `"deleted"`, second argument is file path. Typical use: upload files to a CDN when done writing (`"close"` state and remove when `"deleted"`.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `perm` (of type `int`, which defaults to `420`): Permission of the created files, up to umask. You can and should write this number in octal notation: 0oXXX. The default value is however displayed in decimal (0o666 = 6*8^2 + 4*8 + 4 = 412).
- `persist_at` (of type `string?`, which defaults to `null`): Location of the configuration file used to restart the output. Relative paths are assumed to be with regard to the directory for generated file.
- `playlist` (of type `string`, which defaults to `"stream.m3u8"`): Playlist name (m3u8 extension is recommended).
- `prefix` (of type `string`, which defaults to `""`): Prefix for each files in playlists.
- `segment_duration` (of type `float`, which defaults to `10.`): Segment duration (in seconds).
- `segment_name` (of type `(position : int, extname : string, string) -> string`, which defaults to `<fun>`): Segment name. Default: `fun (~position,~extname,stream_name) -> "#{stream_name}_#{position}.#{extname}"`
- `segments` (of type `int`, which defaults to `10`): Number of segments per playlist.
- `segments_overhead` (of type `int`, which defaults to `5`): Number of segments to keep after they have been featured in the live playlist.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `streams_info` (of type `[string * (int * string * string * (int * int)?)]`, which defaults to `[]`): Additional information about the streams. Should be a list of the form: `[(stream_name, (bandwidth, codecs, extname, (width, height)?)]`. See RFC 6381 for info about codecs. Stream info are required when they cannot be inferred from the encoder.
- `strict_persist` (of type `bool`, which defaults to `false`): Fail if an invalid saved state exists.
- `(unlabeled)` (of type `string`): Directory for generated files.
- `(unlabeled)` (of type `[string * format('a)]`): List of specifications for each stream: (name, format).
- `(unlabeled)` (of type `source('a)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `output.gstreamer.audio`

Output stream to a GStreamer pipeline.

Type:
```
(?id : string?, ?clock_safe : bool, ?fallible : bool,
 ?on_error : ((string) -> float),
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?pipeline : string, ?start : bool, source(audio=pcm('a),
 video='b, midi='c)) -> unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `clock_safe` (of type `bool`, which defaults to `true`): Use the dedicated GStreamer clock.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be stopped until the source is available again.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens. The callback receives a string representation of the error that occurred and returns a float. If returned value is positive, connection will be tried again after this amount of time (in seconds).
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `pipeline` (of type `string`, which defaults to `"autoaudiosink"`): GStreamer pipeline for sink.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `output.gstreamer.audio_video`

Output stream to a GStreamer pipeline.

Type:
```
(?id : string?, ?audio_pipeline : string,
 ?blocking : bool, ?clock_safe : bool, ?fallible : bool,
 ?on_error : ((string) -> float),
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?pipeline : string, ?start : bool,
 ?video_pipeline : string, source(audio=pcm('a),
 video=yuva420p('b), midi='c)) -> unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `audio_pipeline` (of type `string`, which defaults to `"autoaudiosink"`): GStreamer pipeline for audio sink.
- `blocking` (of type `bool`, which defaults to `true`): Pushing buffers is blocking.
- `clock_safe` (of type `bool`, which defaults to `true`): Use the dedicated GStreamer clock.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be stopped until the source is available again.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens. The callback receives a string representation of the error that occurred and returns a float. If returned value is positive, connection will be tried again after this amount of time (in seconds).
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `pipeline` (of type `string`, which defaults to `""`): GStreamer pipeline for sink.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `video_pipeline` (of type `string`, which defaults to `"videoconvert ! autovideosink"`): GStreamer pipeline for video sink.
- `(unlabeled)` (of type `source(audio=pcm('a), video=yuva420p('b), midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `output.gstreamer.video`

Output stream to a GStreamer pipeline.

Type:
```
(?id : string?, ?clock_safe : bool, ?fallible : bool,
 ?on_error : ((string) -> float),
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?pipeline : string, ?start : bool, source(audio=pcm('a),
 video='b, midi='c)) -> unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `clock_safe` (of type `bool`, which defaults to `true`): Use the dedicated GStreamer clock.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be stopped until the source is available again.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens. The callback receives a string representation of the error that occurred and returns a float. If returned value is positive, connection will be tried again after this amount of time (in seconds).
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `pipeline` (of type `string`, which defaults to `"videoconvert ! autovideosink"`): GStreamer pipeline for sink.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `output.harbor`

Encode and output the stream using the harbor server.

Type:
```
(?id : string?,
 ?auth : ((address : string, string, string) -> bool)?,
 ?buffer : int, ?burst : int, ?chunk : int,
 ?dumpfile : string?, ?encoding : string,
 ?fallible : bool, ?format : string,
 ?headers : [string * string], ?metaint : int,
 mount : string,
 ?on_connect : ((headers : [string * string],
                 uri : string, protocol : string, string) ->
                unit),
 ?on_disconnect : ((string) -> unit),
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?password : string?, ?port : int, ?start : bool,
 ?timeout : float, ?url : string?, ?user : string?,
 format(audio='a, video='b, midi='c), source(audio='a,
 video='b, midi='c)) -> unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `auth` (of type `((address : string, string, string) -> bool)?`, which defaults to `null`): Authentication function. `f(~address,login,password)` returns `true` if the user should be granted access for this login. When defined, `user` and `password` arguments are not taken in account.
- `buffer` (of type `int`, which defaults to `327675`): Maximum buffer per-client.
- `burst` (of type `int`, which defaults to `65534`): Initial burst of data sent to the client.
- `chunk` (of type `int`, which defaults to `4096`): Send data to clients using chunks of at least this length.
- `dumpfile` (of type `string?`, which defaults to `null`): Dump stream to file, for debugging purpose. Disabled if null.
- `encoding` (of type `string`, which defaults to `""`): Encoding used to send metadata. If empty, defaults to "ISO-8859-1" for non-ogg formats and "UTF-8" otherwise.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be stopped until the source is available again.
- `format` (of type `string`, which defaults to `""`): Format, e.g. "audio/ogg". When empty, the encoder is used to guess.
- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `metaint` (of type `int`, which defaults to `8192`): Interval used to send ICY metadata
- `mount` (of type `string`)
- `on_connect` (of type `(headers : [string * string], uri : string,
 protocol : string, string) -> unit`, which defaults to `<fun>`): Callback executed when connection is established (takes headers, connection uri, protocol and client's IP as arguments).
- `on_disconnect` (of type `(string) -> unit`, which defaults to `<fun>`): Callback executed when connection stops (takes client's IP as argument).
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `password` (of type `string?`, which defaults to `null`): Password for client connection. A `user` must also be set. We check for this password is checked unless an `auth` function is defined, which is used in this case.
- `port` (of type `int`, which defaults to `8000`)
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `timeout` (of type `float`, which defaults to `30.`): Timeout for network operations (in seconds).
- `url` (of type `string?`, which defaults to `null`)
- `user` (of type `string?`, which defaults to `null`): User for client connection. You also need to setup a `password`.
- `(unlabeled)` (of type `format(audio='a, video='b, midi='c)`): Encoding format.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `output.harbor.hls`

Output the source stream to an HTTP live stream served from the harbor HTTP server.

Type:
```
(?id : string?, ?encode_metadata : bool,
 ?fallible : bool,
 ?on_file_change : ((state : string, string) -> unit),
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?perm : int, ?persist_at : string?, ?playlist : string,
 ?prefix : string, ?segment_duration : float,
 ?segments : int, ?segments_overhead : int,
 ?start : bool,
 ?streams_info : [string *
                  (int * string * string * (int * int)?)],
 ?strict_persist : bool,
 ?segment_name : ((position : int, extname : string,
                   string) -> string),
 ?headers : [string * string], ?port : int,
 ?path : string, ?tmpdir : string?,
 [string * format('a)], source('a)) -> unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `encode_metadata` (of type `bool`, which defaults to `false`): Insert metadata into encoded stream. Note: Some HLS players (in particular android native HLS player) expect a single mpegts stream. Encoding metadata will break that assumption.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be stopped until the source is available again.
- `on_file_change` (of type `(state : string, string) -> unit`, which defaults to `<fun>`): Callback executed when a file changes. `state` is one of: `"opened"`, `"closed"` or `"deleted"`, second argument is file path. Typical use: upload files to a CDN when done writing (`"close"` state and remove when `"deleted"`.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `perm` (of type `int`, which defaults to `420`): Permission of the created files, up to umask. You can and should write this number in octal notation: 0oXXX. The default value is however displayed in decimal (0o666 = 6*8^2 + 4*8 + 4 = 412).
- `persist_at` (of type `string?`, which defaults to `null`): Location of the configuration file used to restart the output. Relative paths are assumed to be with regard to the directory for generated file.
- `playlist` (of type `string`, which defaults to `"stream.m3u8"`): Playlist name (m3u8 extension is recommended).
- `prefix` (of type `string`, which defaults to `""`): Prefix for each files in playlists.
- `segment_duration` (of type `float`, which defaults to `10.`): Segment duration (in seconds).
- `segments` (of type `int`, which defaults to `10`): Number of segments per playlist.
- `segments_overhead` (of type `int`, which defaults to `5`): Number of segments to keep after they have been featured in the live playlist.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `streams_info` (of type `[string * (int * string * string * (int * int)?)]`, which defaults to `[]`): Additional information about the streams. Should be a list of the form: `[(stream_name, (bandwidth, codecs, extname, (width, height)?)]`. See RFC 6381 for info about codecs. Stream info are required when they cannot be inferred from the encoder.
- `strict_persist` (of type `bool`, which defaults to `false`): Fail if an invalid saved state exists.
- `segment_name` (of type `(position : int, extname : string, string) -> string`, which defaults to `<fun>`): Segment name. Default: `fun (~position,~extname,stream_name) -> "#{stream_name}_#{position}.#{extname}"`
- `headers` (of type `[string * string]`, which defaults to `[("Access-Control-Allow-Origin", "*")]`): Default response headers.
- `port` (of type `int`, which defaults to `8000`): Port for incoming harbor (http) connections.
- `path` (of type `string`, which defaults to `"/"`): Base path for hls URIs.
- `tmpdir` (of type `string?`, which defaults to `null`): Directory for generated files.
- `(unlabeled)` (of type `[string * format('a)]`): List of specifications for each stream: (name, format).
- `(unlabeled)` (of type `source('a)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `output.harbor.ssl`

Encode and output the stream using the SSL harbor server.

Type:
```
(?id : string?,
 ?auth : ((address : string, string, string) -> bool)?,
 ?buffer : int, ?burst : int, ?chunk : int,
 ?dumpfile : string?, ?encoding : string,
 ?fallible : bool, ?format : string,
 ?headers : [string * string], ?metaint : int,
 mount : string,
 ?on_connect : ((headers : [string * string],
                 uri : string, protocol : string, string) ->
                unit),
 ?on_disconnect : ((string) -> unit),
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?password : string?, ?port : int, ?start : bool,
 ?timeout : float, ?url : string?, ?user : string?,
 format(audio='a, video='b, midi='c), source(audio='a,
 video='b, midi='c)) -> unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `auth` (of type `((address : string, string, string) -> bool)?`, which defaults to `null`): Authentication function. `f(~address,login,password)` returns `true` if the user should be granted access for this login. When defined, `user` and `password` arguments are not taken in account.
- `buffer` (of type `int`, which defaults to `327675`): Maximum buffer per-client.
- `burst` (of type `int`, which defaults to `65534`): Initial burst of data sent to the client.
- `chunk` (of type `int`, which defaults to `4096`): Send data to clients using chunks of at least this length.
- `dumpfile` (of type `string?`, which defaults to `null`): Dump stream to file, for debugging purpose. Disabled if null.
- `encoding` (of type `string`, which defaults to `""`): Encoding used to send metadata. If empty, defaults to "ISO-8859-1" for non-ogg formats and "UTF-8" otherwise.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be stopped until the source is available again.
- `format` (of type `string`, which defaults to `""`): Format, e.g. "audio/ogg". When empty, the encoder is used to guess.
- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `metaint` (of type `int`, which defaults to `8192`): Interval used to send ICY metadata
- `mount` (of type `string`)
- `on_connect` (of type `(headers : [string * string], uri : string,
 protocol : string, string) -> unit`, which defaults to `<fun>`): Callback executed when connection is established (takes headers, connection uri, protocol and client's IP as arguments).
- `on_disconnect` (of type `(string) -> unit`, which defaults to `<fun>`): Callback executed when connection stops (takes client's IP as argument).
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `password` (of type `string?`, which defaults to `null`): Password for client connection. A `user` must also be set. We check for this password is checked unless an `auth` function is defined, which is used in this case.
- `port` (of type `int`, which defaults to `8000`)
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `timeout` (of type `float`, which defaults to `30.`): Timeout for network operations (in seconds).
- `url` (of type `string?`, which defaults to `null`)
- `user` (of type `string?`, which defaults to `null`): User for client connection. You also need to setup a `password`.
- `(unlabeled)` (of type `format(audio='a, video='b, midi='c)`): Encoding format.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `output.icecast`

Encode and output the stream to an icecast2 or shoutcast server.

Type:
```
(?id : string?, ?chunked : bool,
 ?connection_timeout : float, ?description : string,
 ?dumpfile : string?, ?encoding : string,
 ?fallible : bool, ?format : string, ?genre : string,
 ?headers : [string * string], ?host : string,
 ?icy_id : int, ?icy_metadata : string, ?method : string,
 ?mount : string, ?name : string,
 ?on_connect : (() -> unit),
 ?on_disconnect : (() -> unit),
 ?on_error : ((string) -> float),
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?password : string, ?port : int, ?protocol : string,
 ?public : bool, ?start : bool, ?timeout : float,
 ?url : string, ?user : string, format('a), source('a)) ->
unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `chunked` (of type `bool`, which defaults to `false`): Used chunked transfer with the 'http(s)' protocol.
- `connection_timeout` (of type `float`, which defaults to `5.`): Timeout for establishing network connections (disabled is negative).
- `description` (of type `string`, which defaults to `""`)
- `dumpfile` (of type `string?`, which defaults to `null`): Dump stream to file, for debugging purpose. Disabled if null.
- `encoding` (of type `string`, which defaults to `""`): Encoding used to send metadata and stream info (name, genre and description). If empty, defaults to "UTF-8" for "http(s)" protocol and "ISO-8859-1" for "icy" protocol.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be stopped until the source is available again.
- `format` (of type `string`, which defaults to `""`): Format, e.g. "audio/ogg". When empty, the encoder is used to guess.
- `genre` (of type `string`, which defaults to `""`)
- `headers` (of type `[string * string]`, which defaults to `[("User-Agent", "Liquidsoap/2.0.0 (Unix; OCaml 4.12.0)")]`): Additional headers.
- `host` (of type `string`, which defaults to `"localhost"`)
- `icy_id` (of type `int`, which defaults to `1`): Shoutcast source ID. Only supported by Shoutcast v2.
- `icy_metadata` (of type `string`, which defaults to `"guess"`): Send new metadata using the ICY protocol. One of: "guess", "true", "false"
- `method` (of type `string`, which defaults to `"source"`): method to use with the 'http(s)' protocol. One of: 'source', 'put' or 'post'.
- `mount` (of type `string`, which defaults to `"Use [name]"`): Source mount point. Mandatory when streaming to icecast.
- `name` (of type `string`, which defaults to `"Use [mount]"`)
- `on_connect` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when connection is established.
- `on_disconnect` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when connection stops.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens. The callback receives a string representation of the error that occurred and returns a float. If returned value is positive, connection will be tried again after this amount of time (in seconds).
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `password` (of type `string`, which defaults to `"hackme"`)
- `port` (of type `int`, which defaults to `8000`)
- `protocol` (of type `string`, which defaults to `"http"`): Protocol of the streaming server: 'http' or 'https' for Icecast, 'icy' for shoutcast.
- `public` (of type `bool`, which defaults to `true`)
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `timeout` (of type `float`, which defaults to `30.`): Timeout for network read and write.
- `url` (of type `string`, which defaults to `""`)
- `user` (of type `string`, which defaults to `""`): User for shout source connection. Defaults to "source" for icecast connections. Useful only in special cases, like with per-mountpoint users.
- `(unlabeled)` (of type `format('a)`): Encoding format.
- `(unlabeled)` (of type `source('a)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `output.jack`

Output stream to jack.

Type:
```
(?id : string?, ?buffer_size : int, ?clock_safe : bool,
 ?fallible : bool, ?on_start : (() -> unit),
 ?on_stop : (() -> unit), ?server : string,
 ?start : bool, source(audio=pcm('a), video='b, midi='c)) ->
unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `buffer_size` (of type `int`, which defaults to `2`): Set buffer size, in frames.
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of the dedicated bjack clock.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be stopped until the source is available again.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `server` (of type `string`, which defaults to `""`): Jack server to connect to.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `output.oss`

Output the source's stream to an OSS output device.

Type:
```
(?id : string?, ?clock_safe : bool, ?device : string,
 ?fallible : bool, ?on_start : (() -> unit),
 ?on_stop : (() -> unit), ?start : bool,
 source(audio=pcm('a), video='b, midi='c)) -> unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of the dedicated OSS clock.
- `device` (of type `string`, which defaults to `"/dev/dsp"`): OSS device to use.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be stopped until the source is available again.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `output.portaudio`

Output the source's stream to a portaudio output device.

Type:
```
(?id : string?, ?buflen : int, ?clock_safe : bool,
 ?fallible : bool, ?on_start : (() -> unit),
 ?on_stop : (() -> unit), ?start : bool,
 source(audio=pcm('a), video='b, midi='c)) -> unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `buflen` (of type `int`, which defaults to `256`): Length of a buffer in samples.
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of the dedicated Portaudio clock.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be stopped until the source is available again.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `output.pulseaudio`

Output the source's stream to a portaudio output device.

Type:
```
(?id : string?, ?client : string, ?clock_safe : bool,
 ?device : string, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?start : bool, source(audio=pcm('a), video='b, midi='c)) ->
unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `client` (of type `string`, which defaults to `"liquidsoap"`)
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of the dedicated Pulseaudio clock.
- `device` (of type `string`, which defaults to `""`): Device to use. Uses default if set to "".
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be stopped until the source is available again.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `output.sdl`

Display a video using SDL.

Type:
```
(?id : string?, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?start : bool, source(audio='a, video=yuva420p('b),
 midi='c)) -> unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be stopped until the source is available again.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `(unlabeled)` (of type `source(audio='a, video=yuva420p('b), midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `output.sdl.has_video`

Check whether video output is available with SDL.

Type:
```
() -> bool
```

Arguments:


### `output.shoutcast`

Output to shoutcast.

Type:
```
(?id : string?, ?chunked : bool,
 ?connection_timeout : float, ?dumpfile : string?,
 ?encoding : string, ?fallible : bool, ?format : string,
 ?genre : string, ?host : string, ?icy_id : int,
 ?icy_metadata : string, ?method : string,
 ?mount : string, ?name : string,
 ?on_connect : (() -> unit),
 ?on_disconnect : (() -> unit),
 ?on_error : ((string) -> float),
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?password : string, ?port : int, ?public : bool,
 ?start : bool, ?timeout : float, ?url : string,
 ?user : string, ?icy_reset : bool, ?icy_id : int,
 ?dj : (() -> string), ?aim : string, ?icq : string,
 ?irc : string, format(audio='a, video='b, midi='c),
 source(audio='a, video='b, midi='c)) -> unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `chunked` (of type `bool`, which defaults to `false`): Used chunked transfer with the 'http(s)' protocol.
- `connection_timeout` (of type `float`, which defaults to `5.`): Timeout for establishing network connections (disabled is negative).
- `dumpfile` (of type `string?`, which defaults to `null`): Dump stream to file, for debugging purpose. Disabled if null.
- `encoding` (of type `string`, which defaults to `""`): Encoding used to send metadata and stream info (name, genre and description). If empty, defaults to "UTF-8" for "http(s)" protocol and "ISO-8859-1" for "icy" protocol.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be stopped until the source is available again.
- `format` (of type `string`, which defaults to `""`): Format, e.g. "audio/ogg". When empty, the encoder is used to guess.
- `genre` (of type `string`, which defaults to `""`)
- `host` (of type `string`, which defaults to `"localhost"`)
- `icy_id` (of type `int`, which defaults to `1`): Shoutcast source ID. Only supported by Shoutcast v2.
- `icy_metadata` (of type `string`, which defaults to `"guess"`): Send new metadata using the ICY protocol. One of: "guess", "true", "false"
- `method` (of type `string`, which defaults to `"source"`): method to use with the 'http(s)' protocol. One of: 'source', 'put' or 'post'.
- `mount` (of type `string`, which defaults to `"Use [name]"`): Source mount point. Mandatory when streaming to icecast.
- `name` (of type `string`, which defaults to `"Use [mount]"`)
- `on_connect` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when connection is established.
- `on_disconnect` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when connection stops.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens. The callback receives a string representation of the error that occurred and returns a float. If returned value is positive, connection will be tried again after this amount of time (in seconds).
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `password` (of type `string`, which defaults to `"hackme"`)
- `port` (of type `int`, which defaults to `8000`)
- `public` (of type `bool`, which defaults to `true`)
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `timeout` (of type `float`, which defaults to `30.`): Timeout for network read and write.
- `url` (of type `string`, which defaults to `""`)
- `user` (of type `string`, which defaults to `""`): User for shout source connection. Defaults to "source" for icecast connections. Useful only in special cases, like with per-mountpoint users.
- `icy_reset` (of type `bool`, which defaults to `true`): Reset shoutcast source buffer upon connecting (necessary for NSV).
- `icy_id` (of type `int`, which defaults to `1`): Shoutcast source ID. Only supported by Shoutcast v2.
- `dj` (of type `() -> string`, which defaults to `{""}`): Callback to set dj name.
- `aim` (of type `string`, which defaults to `""`)
- `icq` (of type `string`, which defaults to `""`)
- `irc` (of type `string`, which defaults to `""`)
- `(unlabeled)` (of type `format(audio='a, video='b, midi='c)`): Encoding format. For shoutcast, should be mp3 or AAC(+).
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`): The source to output

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `output.srt`

Send a SRT stream to a distant agent.

Type:
```
(?id : string?, ?bind_address : string, ?fallible : bool,
 ?host : string, ?messageapi : bool, ?mode : string,
 ?on_connect : ((unit) -> unit),
 ?on_disconnect : (() -> unit), ?on_start : (() -> unit),
 ?on_stop : (() -> unit), ?payload_size : int,
 ?port : int, ?start : bool, ?stats_interval : int,
 format(audio='a, video='b, midi='c), source(audio='a,
 video='b, midi='c)) -> unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `bind_address` (of type `string`, which defaults to `"0.0.0.0"`): Address to bind on the local machine. Used only in listener mode
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be stopped until the source is available again.
- `host` (of type `string`, which defaults to `"localhost"`): Address to connect to. Used only in caller mode.
- `messageapi` (of type `bool`, which defaults to `true`): Use message api
- `mode` (of type `string`, which defaults to `"caller"`): Mode to operate on. One of: `"listener"` (waits for connection to come in) or `"caller"` (initiate connection to a remote server)
- `on_connect` (of type `(unit) -> unit`, which defaults to `<fun>`): Function to execute when connected.
- `on_disconnect` (of type `() -> unit`, which defaults to `<fun>`): Function to execute when disconnected
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `payload_size` (of type `int`, which defaults to `1316`): Payload size.
- `port` (of type `int`, which defaults to `8000`): Port to bind on the local machine (listener mode) or to connect to (caller mode). The term `port` as used in SRT is occasionally identical to the term `UDP port`. However SRT offers more flexibility than UDP because it manages ports as its own resources. For example, one port may be shared between various services.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `stats_interval` (of type `int`, which defaults to `100`): Interval used to collect statistics
- `(unlabeled)` (of type `format(audio='a, video='b, midi='c)`): Encoding format.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `stats` (of type `() -> 
{
  pktRcvFilterLoss : int,
  pktRcvFilterSupply : int,
  pktRcvFilterExtra : int,
  pktSndFilterExtra : int,
  pktRcvFilterLossTotal : int,
  pktRcvFilterSupplyTotal : int,
  pktRcvFilterExtraTotal : int,
  pktSndFilterExtraTotal : int,
  msRcvTsbPdDelay : int,
  msRcvBuf : int,
  byteRcvBuf : int,
  pktRcvBuf : int,
  msSndTsbPdDelay : int,
  msSndBuf : int,
  byteSndBuf : int,
  pktSndBuf : int,
  byteMSS : int,
  mbpsMaxBW : float,
  byteAvailRcvBuf : int,
  byteAvailSndBuf : int,
  mbpsBandwidth : float,
  msRTT : float,
  pktFlightSize : int,
  pktCongestionWindow : int,
  pktFlowWindow : int,
  usPktSndPeriod : float,
  byteRcvUndecrypt : int,
  byteRcvDrop : int,
  byteSndDrop : int,
  byteRetrans : int,
  byteRecv : int,
  byteSent : int,
  pktRcvUndecrypt : int,
  pktRcvDrop : int,
  pktSndDrop : int,
  pktRcvBelated : int,
  pktRcvAvgBelatedTime : float,
  pktReorderDistance : int,
  usSndDuration : int,
  mbpsRecvRate : float,
  mbpsSendRate : float,
  pktRecvNAK : int,
  pktSentNAK : int,
  pktRecvACK : int,
  pktSentACK : int,
  pktRcvRetrans : int,
  pktRetrans : int,
  pktRcvLoss : int,
  pktSndLoss : int,
  pktRecv : int,
  pktSent : int,
  byteRcvUndecryptTotal : int,
  byteRcvDropTotal : int,
  byteSndDropTotal : int,
  byteRetransTotal : int,
  byteRecvTotal : int,
  byteSentTotal : int,
  pktRcvUndecryptTotal : int,
  pktRcvDropTotal : int,
  pktSndDropTotal : int,
  usSndDurationTotal : int,
  pktRecvNAKTotal : int,
  pktSentNAKTotal : int,
  pktRecvACKTotal : int,
  pktSentACKTotal : int,
  pktRetransTotal : int,
  pktRcvLossTotal : int,
  pktSndLossTotal : int,
  pktRecvTotal : int,
  pktSentTotal : int,
  msTimeStamp : int}`): Statistics.
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `output.url`

Encode and let encoder handle data output. Useful with encoder with no expected output or to encode to files that need full control from the encoder, e.g. `%ffmpeg` with `rtmp` output.

Type:
```
(?id : string?, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?restart_on_error : bool, ?self_sync : bool,
 ?start : bool, url : string, format('a), source('a)) ->
unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be stopped until the source is available again.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `restart_on_error` (of type `bool`, which defaults to `true`): Restart output on errors
- `self_sync` (of type `bool`, which defaults to `false`): Should the source control its own synchronization? Set to `true` for output to e.g. `rtmp` output using `%ffmpeg` and etc.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is available.
- `url` (of type `string`): Url to output to.
- `(unlabeled)` (of type `format('a)`): Encoding format.
- `(unlabeled)` (of type `source('a)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

## Source / Sound Processing

### `bass_boost`

Add some bass to the sound.

Type:
```
(?frequency : {float}, ?gain : {float},
 source(audio=pcm('a), video=internal('b),
 midi=internal('c))) -> source(audio=pcm('a),
video=internal('b), midi=internal('c))
```

Arguments:

- `frequency` (of type `{float}`, which defaults to `200.`): Frequency below which sound is considered as bass.
- `gain` (of type `{float}`, which defaults to `10.`): Amount of boosting (dB).
- `(unlabeled)` (of type `source(audio=pcm('a), video=internal('b),
midi=internal('c))`): Source whose bass should be boosted

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `compress.multiband`

Multiband compression. The list in argument specifies
- the `frequency` below which we should apply compression (it is above previous band)
- the `attack` time (ms)
- the `release` time (ms)
- the compression `ratio`
- the `threshold` for compression
- the `gain` for the band

Type:
```
(?limit : bool, ?wet : {float}, source(audio=pcm('a),
 video=internal('b), midi=internal('c)),
 ['d
  .{
    gain : {float},
    ratio : {float},
    threshold : {float},
    release : {float},
    attack : {float},
    frequency : {float}
  }]) -> source(audio=pcm('a), video=internal('b),
midi=internal('c))
```

Arguments:

- `limit` (of type `bool`, which defaults to `true`): Also apply limiting to bands.
- `wet` (of type `{float}`, which defaults to `1.`)
- `(unlabeled)` (of type `source(audio=pcm('a), video=internal('b),
midi=internal('c))`): Parameters for compression bands.
- `(unlabeled)` (of type `['d
 .{
   gain : {float},
   ratio : {float},
   threshold : {float},
   release : {float},
   attack : {float},
   frequency : {float}
 }]`): Source on which multiband compression should be applied.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `gain` (of type `() -> float`): Gain (dB).
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `rms` (of type `() -> float`): RMS or peak power (linear).
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `dry_wet`

Mix between dry and wet sources. Useful for testing effects. Typically:
```
c = interactive.float("wetness", min=0., max=1., 1.)
s = dry_wet(c, s, effect(s))
```
and vary `c` to hear the difference between the source without and with the effect.

Type:
```
(?power : bool, {float}, source(audio=internal('a),
 video=internal('b), midi=internal('c)),
 source(audio=internal('a), video=internal('b),
 midi=internal('c))) -> source(audio=internal('a),
video=internal('b), midi=internal('c))
```

Arguments:

- `power` (of type `bool`, which defaults to `false`): If `true` use constant power mixing.
- `(unlabeled)` (of type `{float}`): Wetness coefficient, from 0 (fully dry) to  1 (fully wet).
- `(unlabeled)` (of type `source(audio=internal('a), video=internal('b),
midi=internal('c))`): Dry source.
- `(unlabeled)` (of type `source(audio=internal('a), video=internal('b),
midi=internal('c))`): Wet source.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `fade.in`

Fade the beginning of tracks.

Type:
```
(?id : string, ?duration : float,
 ?override_duration : string, ?override_type : string,
 ?track_sensitive : bool, ?type : string,
 source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string`, which defaults to `"fade.in"`): Force the value of the source ID.
- `duration` (of type `float`, which defaults to `3.`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
- `override_duration` (of type `string`, which defaults to `"liq_fade_in"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
- `override_type` (of type `string`, which defaults to `"liq_fade_type"`): Metadata field which, if present and correct, overrides the 'type' parameter for current track.
- `track_sensitive` (of type `bool`, which defaults to `true`): Be track sensitive (if `false` we only fade in once at the beginning of the track).
- `type` (of type `string`, which defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `fade.out`

Fade the end of tracks.

Type:
```
(?id : string, ?duration : float,
 ?override_duration : string, ?override_type : string,
 ?track_sensitive : bool, ?type : string,
 source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string`, which defaults to `"fade.out"`): Force the value of the source ID.
- `duration` (of type `float`, which defaults to `3.`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
- `override_duration` (of type `string`, which defaults to `"liq_fade_out"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
- `override_type` (of type `string`, which defaults to `"liq_fade_type"`): Metadata field which, if present and correct, overrides the 'type' parameter for current track.
- `track_sensitive` (of type `bool`, which defaults to `true`): Be track sensitive (if `false` we only fade ou once at the beginning of the track).
- `type` (of type `string`, which defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `fade.skip`

Fade when the metadata trigger is received and then skip.

Type:
```
(?id : string, ?duration : float,
 ?override_duration : string, ?override_type : string,
 ?override_skip : string, ?type : string,
 source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string`, which defaults to `"fade.skip"`): Force the value of the source ID.
- `duration` (of type `float`, which defaults to `5.`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
- `override_duration` (of type `string`, which defaults to `"liq_fade_skip"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
- `override_type` (of type `string`, which defaults to `"liq_fade_skip"`): Metadata field which, if present and correct, overrides the 'type' parameter for current track.
- `override_skip` (of type `string`, which defaults to `"liq_skip_meta"`): Metadata field which, when present and set to "true", will trigger the fade
- `type` (of type `string`, which defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `filter.iir.eq.low_high`

A bandpass filter obtained by chaining a low-pass and a high-pass filter.

Type:
```
(?id : string?, low : {float}, high : {float},
 ?q : float, source(audio='a, video='b, midi='c)) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `low` (of type `{float}`): Lower frequency of the bandpass filter.
- `high` (of type `{float}`): Higher frequency of the bandpass filter.
- `q` (of type `float`, which defaults to `1.`): Q factor.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`): Force the value of the source ID.

### `limit`

A limiter. This is a `compress` with tweaked parameters.

Type:
```
(?attack : {float}, ?release : {float}, ?ratio : {float},
 ?threshold : {float}, ?pre_gain : {float},
 ?gain : {float}, source(audio=pcm('a), video='b,
 midi='c)) -> source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `attack` (of type `{float}`, which defaults to `50.`)
- `release` (of type `{float}`, which defaults to `200.`)
- `ratio` (of type `{float}`, which defaults to `20.`)
- `threshold` (of type `{float}`, which defaults to `-2.`)
- `pre_gain` (of type `{float}`, which defaults to `0.`)
- `gain` (of type `{float}`, which defaults to `0.`)
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `gain` (of type `() -> float`): Gain (dB).
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `rms` (of type `() -> float`): RMS or peak power (linear).
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `mic_filter`

Remove low frequencies often produced by microphones.

Type:
```
(?frequency : float, source(audio=pcm('a), video='b,
 midi='c)) -> source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `frequency` (of type `float`, which defaults to `200.`): Frequency under which sound should be lowered.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`): The input source.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `normalize`

Normalization the volume of a stream (this is also called _automatic gain control_). Dynamic normalization of the signal is sometimes the only option (for instance, for live sources), and can make a listening experience much nicer. However, its dynamic aspect implies some limitations which can go as far as creating saturation in some extreme cases. If possible, consider using some track-based normalization techniques such as those based on ReplayGain. The implementation of Liquidsoap < 2.0 was renamed to `normalize.old`.

Type:
```
(?id : string?, ?target : {float}, ?up : {float},
 ?down : {float}, ?gain_min : float, ?gain_max : float,
 ?lufs : bool, ?lookahead : {float}, ?window : {float},
 ?threshold : {float}, ?track_sensitive : bool,
 ?debug : float??, source(audio=pcm('a), video='b,
 midi='c)) -> source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `target` (of type `{float}`, which defaults to `-13.`): Desired RMS (dB).
- `up` (of type `{float}`, which defaults to `10.`): Characteristic time to go up.
- `down` (of type `{float}`, which defaults to `0.1`): Characteristic time to go down.
- `gain_min` (of type `float`, which defaults to `-12.`): Minimal gain value (dB).
- `gain_max` (of type `float`, which defaults to `12.`): Maximal gain value (dB).
- `lufs` (of type `bool`, which defaults to `false`): Use LUFS instead of RMS to compute intensity.
- `lookahead` (of type `{float}`, which defaults to `0.`): How much time to look ahead of the signal (second). Setting a positive value delays the output by the corresponding amount of time.
- `window` (of type `{float}`, which defaults to `0.5`): Duration of the window used to compute the current RMS power (second).
- `threshold` (of type `{float}`, which defaults to `-40.`): Minimal RMS for activaing gain control (dB).
- `track_sensitive` (of type `bool`, which defaults to `true`)
- `debug` (of type `float??`, which defaults to `null`): How often to print debug messages, in seconds, useful to finetune the parameters. You should set `set("log.level", 5)` to see them.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`): Source to normalize.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `gain` (of type `() -> float`): Current amplification coefficient (in linear scale).
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `rms` (of type `() -> float`): Current rms (in linear scale).
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `target_gain` (of type `() -> float`): Current target amplification coefficient (in linear scale).
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `replaygain`

Amplify source tracks according to replaygain metadata. This operator does not compute itself the replaygain: you can use either `enable_replaygain_metadata` or the `replaygain:` protocol for this.

Type:
```
(source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`): Source to be amplified.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

## Source / Sound Synthesis

### `dssi.register`

Register a DSSI plugin.

Type:
```
(string) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`): Path of the DSSI plugin file.

### `dtmf`

Generate DTMF tones.

Type:
```
(?duration : float, ?delay : float, string) ->
source(audio=internal('a), video=internal('b),
midi=internal('c))
```

Arguments:

- `duration` (of type `float`, which defaults to `0.1`): Duration of a tone (in seconds).
- `delay` (of type `float`, which defaults to `0.05`): Dealy between two successive tones (in seconds).
- `(unlabeled)` (of type `string`): String describing DTMF tones to generates: it should contains characters 0 to 9, A to D, or * or #.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `synth.all.saw`

Saw synthesizer. It creates one synthesizer for each channel.

Type:
```
(?id : string?, ?attack : float, ?decay : float,
 ?envelope : bool, ?release : float, ?sustain : float,
 source(audio=pcm(mono), video='a,
 midi=midi(channels=16))) -> source(audio=pcm(mono),
video='a, midi=midi(channels=16))
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `attack` (of type `float`, which defaults to `0.02`): Envelope attack (in seconds).
- `decay` (of type `float`, which defaults to `0.01`): Envelope decay (in seconds).
- `envelope` (of type `bool`, which defaults to `true`): Use envelope.
- `release` (of type `float`, which defaults to `0.01`): Envelope release (in seconds).
- `sustain` (of type `float`, which defaults to `0.9`): Envelope sustain level.
- `(unlabeled)` (of type `source(audio=pcm(mono), video='a, midi=midi(channels=16))`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `synth.all.sine`

Sine synthesizer. It creates one synthesizer for each channel.

Type:
```
(?id : string?, ?attack : float, ?decay : float,
 ?envelope : bool, ?release : float, ?sustain : float,
 source(audio=pcm(mono), video='a,
 midi=midi(channels=16))) -> source(audio=pcm(mono),
video='a, midi=midi(channels=16))
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `attack` (of type `float`, which defaults to `0.02`): Envelope attack (in seconds).
- `decay` (of type `float`, which defaults to `0.01`): Envelope decay (in seconds).
- `envelope` (of type `bool`, which defaults to `true`): Use envelope.
- `release` (of type `float`, which defaults to `0.01`): Envelope release (in seconds).
- `sustain` (of type `float`, which defaults to `0.9`): Envelope sustain level.
- `(unlabeled)` (of type `source(audio=pcm(mono), video='a, midi=midi(channels=16))`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `synth.all.square`

Square synthesizer. It creates one synthesizer for each channel.

Type:
```
(?id : string?, ?attack : float, ?decay : float,
 ?envelope : bool, ?release : float, ?sustain : float,
 source(audio=pcm(mono), video='a,
 midi=midi(channels=16))) -> source(audio=pcm(mono),
video='a, midi=midi(channels=16))
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `attack` (of type `float`, which defaults to `0.02`): Envelope attack (in seconds).
- `decay` (of type `float`, which defaults to `0.01`): Envelope decay (in seconds).
- `envelope` (of type `bool`, which defaults to `true`): Use envelope.
- `release` (of type `float`, which defaults to `0.01`): Envelope release (in seconds).
- `sustain` (of type `float`, which defaults to `0.9`): Envelope sustain level.
- `(unlabeled)` (of type `source(audio=pcm(mono), video='a, midi=midi(channels=16))`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `synth.saw`

Saw synthesizer.

Type:
```
(?id : string?, ?attack : float, ?channel : int,
 ?decay : float, ?envelope : bool, ?release : float,
 ?sustain : float, ?volume : float,
 source(audio=pcm(mono), video='a,
 midi=midi(channels=1))) -> source(audio=pcm(mono),
video='a, midi=midi(channels=1))
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `attack` (of type `float`, which defaults to `0.02`): Envelope attack (in seconds).
- `channel` (of type `int`, which defaults to `0`): MIDI channel to handle.
- `decay` (of type `float`, which defaults to `0.01`): Envelope decay (in seconds).
- `envelope` (of type `bool`, which defaults to `true`): Use envelope.
- `release` (of type `float`, which defaults to `0.05`): Envelope release (in seconds).
- `sustain` (of type `float`, which defaults to `0.9`): Envelope sustain level.
- `volume` (of type `float`, which defaults to `0.3`): Initial volume.
- `(unlabeled)` (of type `source(audio=pcm(mono), video='a, midi=midi(channels=1))`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `synth.sine`

Sine synthesizer.

Type:
```
(?id : string?, ?attack : float, ?channel : int,
 ?decay : float, ?envelope : bool, ?release : float,
 ?sustain : float, ?volume : float,
 source(audio=pcm(mono), video='a,
 midi=midi(channels=1))) -> source(audio=pcm(mono),
video='a, midi=midi(channels=1))
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `attack` (of type `float`, which defaults to `0.02`): Envelope attack (in seconds).
- `channel` (of type `int`, which defaults to `0`): MIDI channel to handle.
- `decay` (of type `float`, which defaults to `0.01`): Envelope decay (in seconds).
- `envelope` (of type `bool`, which defaults to `true`): Use envelope.
- `release` (of type `float`, which defaults to `0.05`): Envelope release (in seconds).
- `sustain` (of type `float`, which defaults to `0.9`): Envelope sustain level.
- `volume` (of type `float`, which defaults to `0.3`): Initial volume.
- `(unlabeled)` (of type `source(audio=pcm(mono), video='a, midi=midi(channels=1))`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `synth.square`

Square synthesizer.

Type:
```
(?id : string?, ?attack : float, ?channel : int,
 ?decay : float, ?envelope : bool, ?release : float,
 ?sustain : float, ?volume : float,
 source(audio=pcm(mono), video='a,
 midi=midi(channels=1))) -> source(audio=pcm(mono),
video='a, midi=midi(channels=1))
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `attack` (of type `float`, which defaults to `0.02`): Envelope attack (in seconds).
- `channel` (of type `int`, which defaults to `0`): MIDI channel to handle.
- `decay` (of type `float`, which defaults to `0.01`): Envelope decay (in seconds).
- `envelope` (of type `bool`, which defaults to `true`): Use envelope.
- `release` (of type `float`, which defaults to `0.05`): Envelope release (in seconds).
- `sustain` (of type `float`, which defaults to `0.9`): Envelope sustain level.
- `volume` (of type `float`, which defaults to `0.3`): Initial volume.
- `(unlabeled)` (of type `source(audio=pcm(mono), video='a, midi=midi(channels=1))`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

## Source / Track Processing

### `append`

Append an extra track to every track. Set the metadata 'liq_append' to 'false' to inhibit appending on one track.

Type:
```
(?id : string?, ?insert_missing : bool, ?merge : bool,
 source(audio='a, video='b, midi='c),
 (([string * string]) -> source(audio='a, video='b,
  midi='c))) -> source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `insert_missing` (of type `bool`, which defaults to `true`): Treat track beginnings without metadata as having empty one.
- `merge` (of type `bool`, which defaults to `false`): Merge the track with its appended track.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)
- `(unlabeled)` (of type `([string * string]) -> source(audio='a, video='b,
midi='c)`): Given the metadata, build the source producing the track to append. This source is allowed to fail (produce nothing) if no relevant track is to be appended.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `blank.detect`

Calls a given handler when detecting a blank.

Type:
```
(?id : string?, ?max_blank : float, ?min_noise : float,
 ?on_noise : (() -> unit), ?start_blank : bool,
 ?threshold : float, ?track_sensitive : bool,
 (() -> unit), source(audio='a, video='b, midi='c)) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `max_blank` (of type `float`, which defaults to `20.`): Maximum duration of silence allowed, in seconds.
- `min_noise` (of type `float`, which defaults to `0.`): Minimum duration of noise required to end silence, in seconds.
- `on_noise` (of type `() -> unit`, which defaults to `<fun>`): Handler called when noise is detected.
- `start_blank` (of type `bool`, which defaults to `false`): Start assuming we have blank.
- `threshold` (of type `float`, which defaults to `-40.`): Power in decibels under which the stream is considered silent.
- `track_sensitive` (of type `bool`, which defaults to `true`): Reset blank counter at each track.
- `(unlabeled)` (of type `() -> unit`): Handler called when blank is detected.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_blank` (of type `() -> bool`): Indicate whether blank was detected.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `blank.eat`

Eat blanks, i.e., drop the contents of the stream until it is not blank anymore.

Type:
```
(?id : string?, ?at_beginning : bool, ?max_blank : float,
 ?min_noise : float, ?start_blank : bool,
 ?threshold : float, ?track_sensitive : bool,
 source(audio='a, video='b, midi='c)) -> source(audio='a,
video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `at_beginning` (of type `bool`, which defaults to `false`): Only eat at the beginning of a track.
- `max_blank` (of type `float`, which defaults to `20.`): Maximum duration of silence allowed, in seconds.
- `min_noise` (of type `float`, which defaults to `0.`): Minimum duration of noise required to end silence, in seconds.
- `start_blank` (of type `bool`, which defaults to `false`): Start assuming we have blank.
- `threshold` (of type `float`, which defaults to `-40.`): Power in decibels under which the stream is considered silent.
- `track_sensitive` (of type `bool`, which defaults to `true`): Reset blank counter at each track.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_blank` (of type `() -> bool`): Indicate whether blank was detected.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `blank.skip`

Skip track when detecting a blank.

Type:
```
(?id : string?, ?threshold : float, ?max_blank : float,
 ?min_noise : float, ?track_sensitive : bool,
 source(audio='a, video='b, midi='c).{skip : (() -> unit)
 }) -> source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `threshold` (of type `float`, which defaults to `-40.`): Power in decibels under which the stream is considered silent.
- `max_blank` (of type `float`, which defaults to `20.`): Maximum silence length allowed, in seconds.
- `min_noise` (of type `float`, which defaults to `0.`): Minimum duration of noise required to end silence, in seconds.
- `track_sensitive` (of type `bool`, which defaults to `true`): Reset blank counter at each track.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c).{skip : (() -> unit)}`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_blank` (of type `() -> bool`): Indicate whether blank was detected.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `blank.strip`

Make the source unavailable when it is streaming blank.

Type:
```
(?id : string?, ?max_blank : float, ?min_noise : float,
 ?start_blank : bool, ?threshold : float,
 ?track_sensitive : bool, source(audio='a, video='b,
 midi='c)) -> source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `max_blank` (of type `float`, which defaults to `20.`): Maximum duration of silence allowed, in seconds.
- `min_noise` (of type `float`, which defaults to `0.`): Minimum duration of noise required to end silence, in seconds.
- `start_blank` (of type `bool`, which defaults to `false`): Start assuming we have blank.
- `threshold` (of type `float`, which defaults to `-40.`): Power in decibels under which the stream is considered silent.
- `track_sensitive` (of type `bool`, which defaults to `true`): Reset blank counter at each track.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_blank` (of type `() -> bool`): Indicate whether blank was detected.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `chop`

Regularly insert track boundaries in a stream (useful for testing tracks).

Type:
```
(?every : {float}, ?metadata : {[string * string]},
 source(audio='a, video='b, midi='c)) -> source(audio='a,
video='b, midi='c)
```

Arguments:

- `every` (of type `{float}`, which defaults to `3.`): Duration of a track (in seconds).
- `metadata` (of type `{[string * string]}`, which defaults to `[]`): Metadata for tracks.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`): The stream.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `cross.simple`

Simple transition for crossfade

Type:
```
(?fade_in : float, ?fade_out : float,
 source(audio=pcm('a), video=internal('b),
 midi=internal('c)), source(audio=pcm('a),
 video=internal('b), midi=internal('c))) ->
source(audio=pcm('a), video=internal('b),
midi=internal('c))
```

Arguments:

- `fade_in` (of type `float`, which defaults to `3.`): Fade-in duration, if any.
- `fade_out` (of type `float`, which defaults to `3.`): Fade-out duration, if any.
- `(unlabeled)` (of type `source(audio=pcm('a), video=internal('b),
midi=internal('c))`): Ending track
- `(unlabeled)` (of type `source(audio=pcm('a), video=internal('b),
midi=internal('c))`): Starting track

### `cross.smart`

Smart transition for crossfade

Type:
```
(?log : ((?level : int, string) -> unit),
 ?fade_in : float, ?fade_out : float,
 ?default : ((source(audio=pcm('a), video=internal('b),
              midi=internal('c)), source(audio=pcm('a),
              video=internal('b), midi=internal('c))) ->
             source(audio=pcm('a), video=internal('b),
             midi=internal('c))),
 ?high : float, ?medium : float, ?margin : float, 'm
 .{
   source : source(audio=pcm('a),
   video=internal('b),
   midi=internal('c)),
   db_level : float,
   metadata : [string * string]
 }, 'q
 .{
   source : source(audio=pcm('a),
   video=internal('b),
   midi=internal('c)),
   db_level : float,
   metadata : [string * string]
 }) -> source(audio=pcm('a), video=internal('b),
midi=internal('c))
```

Arguments:

- `log` (of type `(?level : int, string) -> unit`, which defaults to `<fun>`): Default logger
- `fade_in` (of type `float`, which defaults to `3.`): Fade-in duration, if any.
- `fade_out` (of type `float`, which defaults to `3.`): Fade-out duration, if any.
- `default` (of type `(source(audio=pcm('a), video=internal('b),
 midi=internal('c)), source(audio=pcm('a),
 video=internal('b), midi=internal('c))) ->
source(audio=pcm('a), video=internal('b),
midi=internal('c))`, which defaults to `<fun>`): Smart crossfade: transition used when no rule applies (default: sequence).
- `high` (of type `float`, which defaults to `-15.`): Value, in dB, for loud sound level.
- `medium` (of type `float`, which defaults to `-32.`): Value, in dB, for medium sound level.
- `margin` (of type `float`, which defaults to `4.`): Margin to detect sources that have too different sound level for crossing.
- `(unlabeled)` (of type `'m
.{
  source : source(audio=pcm('a),
  video=internal('b),
  midi=internal('c)),
  db_level : float,
  metadata : [string * string]
}`): Ending track
- `(unlabeled)` (of type `'q
.{
  source : source(audio=pcm('a),
  video=internal('b),
  midi=internal('c)),
  db_level : float,
  metadata : [string * string]
}`): Starting track

### `crossfade`

Crossfade between tracks, taking the respective volume levels into account in the choice of the transition.

Type:
```
(?id : string?, ?duration : float,
 ?override_duration : string, ?fade_in : float,
 ?fade_out : float, ?smart : bool,
 ?default : ((source(audio=pcm('a), video=internal('b),
              midi=internal('c)), source(audio=pcm('a),
              video=internal('b), midi=internal('c))) ->
             source(audio=pcm('a), video=internal('b),
             midi=internal('c))),
 ?high : float, ?medium : float, ?margin : float,
 ?minimum : float, ?width : float, ?conservative : bool,
 source(audio=pcm('a), video=internal('b),
 midi=internal('c))) -> source(audio=pcm('a),
video=internal('b), midi=internal('c))
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `duration` (of type `float`, which defaults to `5.`): Duration (in seconds) of buffered data from each track that is used to compute the transition between tracks.
- `override_duration` (of type `string`, which defaults to `"liq_cross_duration"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track. 
- `fade_in` (of type `float`, which defaults to `3.`): Fade-in duration, if any.
- `fade_out` (of type `float`, which defaults to `3.`): Fade-out duration, if any.
- `smart` (of type `bool`, which defaults to `false`): Enable smart crossfading
- `default` (of type `(source(audio=pcm('a), video=internal('b),
 midi=internal('c)), source(audio=pcm('a),
 video=internal('b), midi=internal('c))) ->
source(audio=pcm('a), video=internal('b),
midi=internal('c))`, which defaults to `<fun>`): Smart crossfade: transition used when no rule applies (default: sequence).
- `high` (of type `float`, which defaults to `-15.`): Smart crossfade: value, in dB, for loud sound level.
- `medium` (of type `float`, which defaults to `-32.`): Smart crossfade: value, in dB, for medium sound level.
- `margin` (of type `float`, which defaults to `4.`): Smart crossfade: margin to detect sources that have too different sound level for crossing.
- `minimum` (of type `float`, which defaults to `-1.`): Minimum duration (in sec.) for a cross: If the track ends without any warning (e.g. in case of skip) there may not be enough data for a decent composition. Set to 0. to avoid having transitions after skips, or more to avoid transitions on short tracks. With a negative default, transitions always occur.    
- `width` (of type `float`, which defaults to `2.`): Width of the volume analysis window.
- `conservative` (of type `bool`, which defaults to `true`): Always prepare for a premature end-of-track.
- `(unlabeled)` (of type `source(audio=pcm('a), video=internal('b),
midi=internal('c))`): The input source.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `cue_cut`

Start track after a cue in point and stop it at cue out point. The cue points are given as metadata, in seconds from the beginning of tracks.

Type:
```
(?id : string?, ?cue_in_metadata : string,
 ?cue_out_metadata : string, ?on_cue_in : (() -> unit),
 ?on_cue_out : (() -> unit), source(audio='a, video='b,
 midi='c)) -> source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `cue_in_metadata` (of type `string`, which defaults to `"liq_cue_in"`): Metadata for cue in points.
- `cue_out_metadata` (of type `string`, which defaults to `"liq_cue_out"`): Metadata for cue out points.
- `on_cue_in` (of type `() -> unit`, which defaults to `<fun>`): Callback to execute on cue in
- `on_cue_out` (of type `() -> unit`, which defaults to `<fun>`): Callback to execute on cue out
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `delay`

Make the source unavailable for a given time between tracks.

Type:
```
(?id : string?, ?initial : bool, {float},
 source(audio='a, video='b, midi='c)) -> source(audio='a,
video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `initial` (of type `bool`, which defaults to `false`): Start in unavailable state, as if a track had just finished.
- `(unlabeled)` (of type `{float}`): The source won't be ready less than this amount of seconds after any end of track
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `drop_metadata`

Removes all metadata coming from a source.

Type:
```
(source(audio='a, video='b, midi='c)) -> source(audio='a,
video='b, midi='c)
```

Arguments:

- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `fallback`

At the beginning of each track, select the first ready child.

Type:
```
(?id : string?, ?override : string,
 ?replay_metadata : bool, ?track_sensitive : bool,
 ?transition_length : float,
 ?transitions : [(source(audio='a, video='b, midi='c),
                  source(audio='a, video='b, midi='c)) ->
                 source(audio='a, video='b, midi='c)],
 [source(audio='a, video='b, midi='c)]) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `override` (of type `string`, which defaults to `"liq_transition_length"`): Metadata field which, if present and containing a float, overrides the `transition_length` parameter.
- `replay_metadata` (of type `bool`, which defaults to `true`): Replay the last metadata of a child when switching to it in the middle of a track.
- `track_sensitive` (of type `bool`, which defaults to `true`): Re-select only on end of tracks.
- `transition_length` (of type `float`, which defaults to `5.`): Maximum transition duration.
- `transitions` (of type `[(source(audio='a, video='b, midi='c), source(audio='a,
  video='b, midi='c)) -> source(audio='a, video='b,
 midi='c)]`, which defaults to `[]`): Transition functions, padded with `fun (x,y) -> y` functions.
- `(unlabeled)` (of type `[source(audio='a, video='b, midi='c)]`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `selected` (of type `() -> source(audio=?A, video=?B, midi=?C)?`): Currently selected source.
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `insert_metadata`

Dynamically insert metadata in a stream. Returns the source decorated with a method `insert_metadata` which is a function of type `(?new_track,metadata)->unit`, used to insert metadata in the source. This function also inserts a new track with the given metadata if passed `new_track=true`.

Type:
```
(?id : string?, source(audio='a, video='b, midi='c)) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `insert_metadata` (of type `(?new_track : bool, [string * string]) -> unit`): Insert metadata in the source. The `new_track` parameter indicates whether a track boundary should also be inserted (by default, no track is inserted).
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `map_first_track`

Apply a function to the first track of a source

Type:
```
(?id : string?,
 ((source(audio='a, video='b, midi='c)) ->
  source(audio='a, video='b, midi='c)),
 source(audio='a, video='b, midi='c)) -> source(audio='a,
video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `(source(audio='a, video='b, midi='c)) -> source(audio='a,
video='b, midi='c)`): The applied function.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`): The input source.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `selected` (of type `() -> source(audio=?A, video=?B, midi=?C)?`): Currently selected source.
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `map_metadata`

Rewrite metadata on the fly using a function.

Type:
```
(?id : string?, ?insert_missing : bool, ?strip : bool,
 ?update : bool,
 (([string * string]) -> [string * string]),
 source(audio='a, video='b, midi='c)) -> source(audio='a,
video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `insert_missing` (of type `bool`, which defaults to `true`): Treat track beginnings without metadata as having empty ones. The operational order is: create empty if needed, map and strip if enabled.
- `strip` (of type `bool`, which defaults to `false`): Completely remove empty metadata. Operates on both empty values and empty metadata chunk.
- `update` (of type `bool`, which defaults to `true`): Update metadata. If false, existing metadata are cleared and only returned values are set as new metadata.
- `(unlabeled)` (of type `([string * string]) -> [string * string]`): A function that returns new metadata.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `max_duration`

Limit source duration

Type:
```
(?id : string?, ?override : string, float,
 source(audio='a, video='b, midi='c)) -> source(audio='a,
video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `override` (of type `string`, which defaults to `"liq_remaining"`): Metadata field which, if present and containing a float, overrides the remaining play time.
- `(unlabeled)` (of type `float`): Maximum duration
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `merge_tracks`

Merge consecutive tracks from the input source. They will be considered as one big track, so `on_track()` will not trigger for example.

Type:
```
(?id : string?, source(audio='a, video='b, midi='c)) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `metadata.artist`

Extract artist from metadata.

Type:
```
([string * string]) -> string
```

Arguments:

- `(unlabeled)` (of type `[string * string]`)

### `metadata.comment`

Extract comment from metadata.

Type:
```
([string * string]) -> string
```

Arguments:

- `(unlabeled)` (of type `[string * string]`)

### `metadata.cover`

Extract cover from metadata. This function implements cover extraction for the following formats: coverart (ogg) and apic (flac, mp3). 

Type:
```
(?coverart_mime : string?, [string * string]) -> string
.{mime : string}?
```

Arguments:

- `coverart_mime` (of type `string?`, which defaults to `null`): Mime type to use for `"coverart"` metadata. Support disasbled if `null`.
- `(unlabeled)` (of type `[string * string]`): Metadata from which the cover should be extracted.

### `metadata.cover.remove`

Remove cover metadata. This is mostly useful in order not to flood logs with coverart when logging metadata.

Type:
```
([string * 'a]) -> [string * 'a]
```

Arguments:

- `(unlabeled)` (of type `[string * 'a]`)

### `metadata.export`

Cleanup metadata for export. This is used to remove Liquidsoap's internal metadata entries before sending them. List of exported metadata is set using `settings.encoder.metadata.export.set`.

Type:
```
([string * string]) -> [string * string]
```

Arguments:

- `(unlabeled)` (of type `[string * string]`)

### `metadata.filename`

Extract filename from metadata.

Type:
```
([string * string]) -> string
```

Arguments:

- `(unlabeled)` (of type `[string * string]`)

### `metadata.title`

Extract title from metadata.

Type:
```
([string * string]) -> string
```

Arguments:

- `(unlabeled)` (of type `[string * string]`)

### `mksafe`

Turn a source into an infaillible source by adding blank when the source is not available.

Type:
```
(?id : string, source(audio=internal('a),
 video=internal('b), midi=internal('c))) ->
source(audio=internal('a), video=internal('b),
midi=internal('c))
```

Arguments:

- `id` (of type `string`, which defaults to `"mksafe"`)
- `(unlabeled)` (of type `source(audio=internal('a), video=internal('b),
midi=internal('c))`): the source to turn infaillible

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `selected` (of type `() -> source(audio=?A, video=?B, midi=?C)?`): Currently selected source.
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `on_offset`

Call a given handler when position in track is equal or more than a given amount of time.

Type:
```
(?id : string?, ?force : bool, ?offset : float,
 ?override : string,
 ((float, [string * string]) -> unit), source(audio='a,
 video='b, midi='c)) -> source(audio='a, video='b,
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `force` (of type `bool`, which defaults to `false`): Force execution of callback if track ends before 'offset' position has been reached.
- `offset` (of type `float`, which defaults to `-1.`): Execute handler when position in track is equal or more than to this value.
- `override` (of type `string`, which defaults to `"liq_on_offset"`): Metadata field which, if present and containing a float, overrides the 'offset' parameter.
- `(unlabeled)` (of type `(float, [string * string]) -> unit`): Function to execute. First argument is the actual position within the current track, second is the latest metadata. That function should be fast because it is executed in the main streaming thread.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `once`

Creates a source that plays only one track of the input source.

Type:
```
(source(audio='a, video='b, midi='c)) -> source(audio='a,
video='b, midi='c)
```

Arguments:

- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`): The input source.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `overlap_sources`

Rotate between overlapping sources. Next track starts according to 'liq_start_next' offset metadata.

Type:
```
(?id : string?, ?normalize : bool, ?start_next : string,
 ?weights : [{float}],
 [source(audio=internal('a), video=internal('b),
  midi=internal('c))]) -> source(audio=internal('a),
video=internal('b), midi=internal('c))
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `normalize` (of type `bool`, which defaults to `false`)
- `start_next` (of type `string`, which defaults to `"liq_start_next"`): Metadata field indicating when the next track should start, relative to current track's time.
- `weights` (of type `[{float}]`, which defaults to `[]`): Relative weight of the sources in the sum. The empty list stands for the homogeneous distribution.
- `(unlabeled)` (of type `[source(audio=internal('a), video=internal('b),
 midi=internal('c))]`): Sources to toggle from

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `insert_metadata` (of type `(?new_track : bool, [string * string]) -> unit`): Insert metadata in the source. The `new_track` parameter indicates whether a track boundary should also be inserted (by default, no track is inserted).
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `playlog`

Keep a record of played files. This is primarily useful to know when a song was last played and avoid repetitions.

Type:
```
(?duration : float, ?persistency : string?,
 ?hash : (([string * string]) -> string)) -> unit
```

Arguments:

- `duration` (of type `float`, which defaults to `inf`): Duration (in seconds) after which songs are forgotten. By default, songs are not forgotten which means that the playlog will contain all the songs ever played.
- `persistency` (of type `string?`, which defaults to `null`): Set a file name where the values are stored and loaded in case the script is restarted.
- `hash` (of type `([string * string]) -> string`, which defaults to `<fun>`): Function to extract an identifier from the metadata. By default, the filename is used but we could return the artist to know when a song from a given artist was last played for instance.

Methods:

- `add` (of type `([string * string]) -> unit`): Record that file with given metadata has been played.
- `last` (of type `([string * string]) -> float`): How long ago a file was played (in seconds), `infinity` is returned if the song has never been played.

### `prepend`

Prepend an extra track before every track. Set the metadata 'liq_prepend' to 'false' to inhibit prepending on one track.

Type:
```
(?id : string?, ?merge : bool, source(audio='a, video='b,
 midi='c),
 (([string * string]) -> source(audio='a, video='b,
  midi='c))) -> source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `merge` (of type `bool`, which defaults to `false`): Merge the track with its appended track.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)
- `(unlabeled)` (of type `([string * string]) -> source(audio='a, video='b,
midi='c)`): Given the metadata, build the source producing the track to prepend. This source is allowed to fail (produce nothing) if no relevant track is to be appended. However, success must be immediate or it will not be taken into account.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `random`

At the beginning of every track, select a random ready child.

Type:
```
(?id : string?, ?override : string,
 ?replay_metadata : bool, ?transition_length : float,
 ?transitions : [(source(audio='a, video='b, midi='c),
                  source(audio='a, video='b, midi='c)) ->
                 source(audio='a, video='b, midi='c)],
 ?weights : [{int}],
 [source(audio='a, video='b, midi='c)]) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `override` (of type `string`, which defaults to `"liq_transition_length"`): Metadata field which, if present and containing a float, overrides the `transition_length` parameter.
- `replay_metadata` (of type `bool`, which defaults to `true`): Replay the last metadata of a child when switching to it in the middle of a track.
- `transition_length` (of type `float`, which defaults to `5.`): Maximum transition duration.
- `transitions` (of type `[(source(audio='a, video='b, midi='c), source(audio='a,
  video='b, midi='c)) -> source(audio='a, video='b,
 midi='c)]`, which defaults to `[]`): Transition functions, padded with `fun (x,y) -> y` functions.
- `weights` (of type `[{int}]`, which defaults to `[]`): Weights of the children (padded with 1), defining for each child the probability that it is selected.
- `(unlabeled)` (of type `[source(audio='a, video='b, midi='c)]`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `selected` (of type `() -> source(audio=?A, video=?B, midi=?C)?`): Currently selected source.
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `request.player`

Create a source on which plays immediately requests given with the `play` method.

Type:
```
(?simultaneous : bool) -> source(audio=internal('a),
video=internal('b), midi=internal('c))
```

Arguments:

- `simultaneous` (of type `bool`, which defaults to `true`): Allow multiple requests to play simultaneously. If `false` a new request replaces the previous one.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `length` (of type `() -> int`): Number of currently playing requests.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `play` (of type `(request) -> unit`): Play a request.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `set` (of type `(source(audio=?internal(?A), video=?internal(?B),
 midi=?internal(?C))) -> unit`): Set the source.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `request.queue`

Play a queue of uris. Returns a function to push new uris in the queue as well as the resulting source.

Type:
```
(?id : string?, ?interactive : bool, ?prefetch : int,
 ?native : bool, ?queue : [request], ?timeout : float) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `interactive` (of type `bool`, which defaults to `true`): Should the queue be controllable via telnet?
- `prefetch` (of type `int`, which defaults to `1`): How many requests should be queued in advance.
- `native` (of type `bool`, which defaults to `false`): Use native implementation.
- `queue` (of type `[request]`, which defaults to `[]`): Initial queue of requests.
- `timeout` (of type `float`, which defaults to `20.`): Timeout (in sec.) for a single download.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `length` (of type `() -> int`): Length of the queue.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `push` (of type `((request) -> unit).{uri : ((string) -> unit)}`): Push a request on the request queue.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `rotate`

Rotate between sources.

Type:
```
(?id : string?, ?override : string,
 ?replay_metadata : bool, ?transition_length : float,
 ?transitions : [(source(audio='a, video='b, midi='c),
                  source(audio='a, video='b, midi='c)) ->
                 source(audio='a, video='b, midi='c)],
 ?weights : [{int}],
 [source(audio='a, video='b, midi='c)]) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `override` (of type `string`, which defaults to `"liq_transition_length"`): Metadata field which, if present and containing a float, overrides the `transition_length` parameter.
- `replay_metadata` (of type `bool`, which defaults to `true`): Replay the last metadata of a child when switching to it in the middle of a track.
- `transition_length` (of type `float`, which defaults to `5.`): Maximum transition duration.
- `transitions` (of type `[(source(audio='a, video='b, midi='c), source(audio='a,
  video='b, midi='c)) -> source(audio='a, video='b,
 midi='c)]`, which defaults to `[]`): Transition functions, padded with `fun (x,y) -> y` functions.
- `weights` (of type `[{int}]`, which defaults to `[]`): Weights of the children (padded with 1), defining for each child how many tracks are played from it per round, if that many are actually available.
- `(unlabeled)` (of type `[source(audio='a, video='b, midi='c)]`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `selected` (of type `() -> source(audio=?A, video=?B, midi=?C)?`): Currently selected source.
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `rotate.merge`

Same operator as rotate but merges tracks from each sources. For instance, `rotate.merge([intro,main,outro])` creates a source that plays a sequence `[intro,main,outro]` as single track and loops back.

Type:
```
(?id : string?,
 ?transitions : [(source(audio=internal('a),
                  video=internal('b), midi=internal('c)),
                  source(audio=internal('a),
                  video=internal('b), midi=internal('c))) ->
                 source(audio=internal('a),
                 video=internal('b), midi=internal('c))],
 ?weights : [{int}],
 [source(audio=internal('a), video=internal('b),
  midi=internal('c))]) -> source(audio=internal('a),
video=internal('b), midi=internal('c))
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `transitions` (of type `[(source(audio=internal('a), video=internal('b),
  midi=internal('c)), source(audio=internal('a),
  video=internal('b), midi=internal('c))) ->
 source(audio=internal('a), video=internal('b),
 midi=internal('c))]`, which defaults to `[]`): Transition functions, padded with `fun (x,y) -> y` functions.
- `weights` (of type `[{int}]`, which defaults to `[]`): Weights of the children (padded with 1), defining for each child how many tracks are played from it per round, if that many are actually available.
- `(unlabeled)` (of type `[source(audio=internal('a), video=internal('b),
 midi=internal('c))]`): Sequence of sources to be merged

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `selected` (of type `() -> source(audio=?A, video=?B, midi=?C)?`): Currently selected source.
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `sequence`

Play only one track of every successive source, except for the last one which is played as much as available.

Type:
```
(?id : string?, ?merge : bool,
 [source(audio='a, video='b, midi='c)]) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `merge` (of type `bool`, which defaults to `false`): Merge tracks when advancing from one source to the next one. This will NOT merge consecutive tracks from the last source; see merge_tracks() if you need that too.
- `(unlabeled)` (of type `[source(audio='a, video='b, midi='c)]`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `server.insert_metadata`

Register a server/telnet command to update a source's metadata. Returns a new source, which will receive the updated metadata. The command has the following format: insert key1="val1",key2="val2",...

Type:
```
(?id : string?, source(audio='a, video='b, midi='c)) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `insert_metadata` (of type `(?new_track : bool, [string * string]) -> unit`): Insert metadata in the source. The `new_track` parameter indicates whether a track boundary should also be inserted (by default, no track is inserted).
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `source.available`

Change the availability of a source depending on a predicate.

Type:
```
(?id : string?, ?override : bool,
 ?track_sensitive : {bool}, source(audio='a, video='b,
 midi='c), {bool}) -> source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `override` (of type `bool`, which defaults to `false`): Don't take availability of original source in account (this can be dangerous and should be avoided).
- `track_sensitive` (of type `{bool}`, which defaults to `false`): Change availability only on end of tracks.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`): Source of which the availability should be changed.
- `(unlabeled)` (of type `{bool}`): Predicate indicating whether the source should be available or not.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `source.dynamic`

Dynamically change the underlying source: it can either be changed by the function given as argument, which returns the source to be played, or by calling the `set` method.

Type:
```
(?id : string?, ?infallible : bool,
 ?init : source(audio='a, video='b, midi='c)?,
 ?resurection_time : float?, ?track_sensitive : bool,
 ?(() -> source(audio='a, video='b, midi='c)?)) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `infallible` (of type `bool`, which defaults to `false`): Whether the source is infallible or not (be careful when setting this, it will not be checked by the typing system).
- `init` (of type `source(audio='a, video='b, midi='c)?`, which defaults to `null`): Initial value for the source
- `resurection_time` (of type `float?`, which defaults to `1.`): When track sensitive and the source is unavailable, how long we should wait before trying to update source again (`null` means never).
- `track_sensitive` (of type `bool`, which defaults to `false`): Whether the source should only be updated on track change.
- `(unlabeled)` (of type `() -> source(audio='a, video='b, midi='c)?`, which defaults to `<fun>`): Function returning the source to be used, `null` means keep current source.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `set` (of type `(source(audio=?A, video=?B, midi=?C)) -> unit`): Set the source.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

This function is experimental.

### `source.frame.duration`

Compute the duration of the last frame.

Type:
```
(?id : string?, source(audio='a, video='b, midi='c)) ->
source(audio='a, video='b, midi='c
.{frame_duration : float})
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `frame_duration` (of type `float`): Compute the duration of the last frame.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `source.frame.rms`

Compute the rms of the last frame.

Type:
```
(?id : string?, source(audio='a, video='b, midi='c)) ->
source(audio='a, video='b, midi='c.{frame_rms : float})
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `frame_rms` (of type `float`): Compute the rms of the last frame.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `source.on_end`

Call a given handler when there is less than a given amount of time remaining before then end of track.

Type:
```
(?id : string?, ?delay : {float}, source(audio='a,
 video='b, midi='c),
 ((float, [string * string]) -> unit)) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `delay` (of type `{float}`, which defaults to `5.`): Execute handler when remaining time is less or equal to this value.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)
- `(unlabeled)` (of type `(float, [string * string]) -> unit`): Function to execute. First argument is the remaining time, second is the latest metadata. That function should be fast because it is executed in the main streaming thread.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `source.on_frame`

Call a given handler on every frame.

Type:
```
(?id : string?, source(audio='a, video='b, midi='c),
 (() -> unit)) -> source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)
- `(unlabeled)` (of type `() -> unit`): Function called on every frame. It should be fast because it is executed in the main streaming thread.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `source.run`

Run a function regularly. This is similar to `thread.run` but based on a source internal time instead of the world's time.

Type:
```
(source(audio='a, video='b, midi='c), ?delay : float,
 ?every : float?, (() -> unit)) -> source(audio='a,
video='b, midi='c)
```

Arguments:

- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`): Source whose time is taken as reference.
- `delay` (of type `float`, which defaults to `0.`): Time to wait before the first run (in seconds).
- `every` (of type `float?`, which defaults to `null`): How often to run the function (in seconds). The function is run once if `null`.
- `(unlabeled)` (of type `() -> unit`): Function to run.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `source.say_metadata`

Append speech-synthesized tracks reading the metadata.

Type:
```
(?id : string?,
 ?pattern : (([string * string]) -> string),
 source(audio=?A, video=?B, midi=?C)) -> source(audio=?A,
video=?B, midi=?C)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `pattern` (of type `([string * string]) -> string`, which defaults to `<fun>`): Pattern to use
- `(unlabeled)` (of type `source(audio=?A, video=?B, midi=?C)`): The source to use

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `switch`

At the beginning of a track, select the first source whose predicate is true.

Type:
```
(?id : string?, ?all_predicates : bool,
 ?override : string, ?replay_metadata : bool,
 ?single : [bool], ?track_sensitive : {bool},
 ?transition_length : float,
 ?transitions : [(source(audio='a, video='b, midi='c),
                  source(audio='a, video='b, midi='c)) ->
                 source(audio='a, video='b, midi='c)],
 [(() -> bool) * source(audio='a, video='b, midi='c)]) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `all_predicates` (of type `bool`, which defaults to `false`): Always evaluate all predicates when re-selecting.
- `override` (of type `string`, which defaults to `"liq_transition_length"`): Metadata field which, if present and containing a float, overrides the `transition_length` parameter.
- `replay_metadata` (of type `bool`, which defaults to `true`): Replay the last metadata of a child when switching to it in the middle of a track.
- `single` (of type `[bool]`, which defaults to `[]`): Forbid the selection of a branch for two tracks in a row. The empty list stands for `[false,...,false]`.
- `track_sensitive` (of type `{bool}`, which defaults to `true`): Re-select only on end of tracks.
- `transition_length` (of type `float`, which defaults to `5.`): Maximum transition duration.
- `transitions` (of type `[(source(audio='a, video='b, midi='c), source(audio='a,
  video='b, midi='c)) -> source(audio='a, video='b,
 midi='c)]`, which defaults to `[]`): Transition functions, padded with `fun (x,y) -> y` functions.
- `(unlabeled)` (of type `[(() -> bool) * source(audio='a, video='b, midi='c)]`): Sources with the predicate telling when they can be played.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `selected` (of type `() -> source(audio=?A, video=?B, midi=?C)?`): Currently selected source.
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

## Source / Video Processing

### `ffmpeg.filter.video.output`

Return a video source from a filter's output

Type:
```
(?id : string?, ?buffer : float, ?fps : int?,
 ?pass_metadata : bool, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> source(audio=none,
video=ffmpeg.video.raw('a), midi=none)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `buffer` (of type `float`, which defaults to `0.1`): Duration of the pre-buffered data.
- `fps` (of type `int?`, which defaults to `null`): Output frame per seconds. Defaults to global value
- `pass_metadata` (of type `bool`, which defaults to `false`): Pass ffmpeg stream metadata to liquidsoap
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `image`

Generate a source from a static image.

Type:
```
(?id : string?, ?fallible : bool, ?string) ->
source(audio=internal('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `fallible` (of type `bool`, which defaults to `false`): Whether we are allowed to fail (in case the file is non-existent or invalid).
- `(unlabeled)` (of type `string`, which defaults to `""`): Path to the image.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `set` (of type `(string) -> unit`): Change the image.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `video.add_image`

Add a static image on the first video channel.

Type:
```
(?id : string?, ?width : {int?}, ?height : {int?},
 ?x : {int}, ?y : {int}, file : string,
 source(audio=internal('a), video=internal('b),
 midi=internal('c))) -> source(audio=internal('a),
video=internal('b), midi=internal('c))
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `width` (of type `{int?}`, which defaults to `null`): Scale to width
- `height` (of type `{int?}`, which defaults to `null`): Scale to height
- `x` (of type `{int}`, which defaults to `0`): x position.
- `y` (of type `{int}`, which defaults to `0`): y position.
- `file` (of type `string`): Path to the image file.
- `(unlabeled)` (of type `source(audio=internal('a), video=internal('b),
midi=internal('c))`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `video.add_text`

Display a text using the first available operator in: SDL, GStreamer, gd or native.

Type:
```
(?id : string?, ?color : int, ?cycle : bool,
 ?font : string, ?metadata : string, ?size : int,
 ?speed : int, ?x : {int}, ?y : {int}, {string},
 source(audio=?A, video=yuva420p(?B), midi=?C)) ->
source(audio=?A, video=yuva420p(?B), midi=?C)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `color` (of type `int`, which defaults to `16777215`): Text color (in 0xRRGGBB format).
- `cycle` (of type `bool`, which defaults to `true`): Cycle text when it reaches left boundary.
- `font` (of type `string`, which defaults to `""`): Path to ttf font file.
- `metadata` (of type `string`, which defaults to `""`): Change text on a particular metadata (empty string means disabled).
- `size` (of type `int`, which defaults to `18`): Font size.
- `speed` (of type `int`, which defaults to `70`): Horizontal speed in pixels per second (0 means no scrolling and update according to x and y in case they are variable).
- `x` (of type `{int}`, which defaults to `10`): x offset.
- `y` (of type `{int}`, which defaults to `10`): y offset.
- `(unlabeled)` (of type `{string}`): d Text to display.
- `(unlabeled)` (of type `source(audio=?A, video=yuva420p(?B), midi=?C)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `video.add_text.ffmpeg`

Display a text.

Type:
```
(?color : int, ?font : string, ?size : int, ?x : int,
 ?y : int, string?, source(audio=none,
 video=ffmpeg.video.raw('a), midi=none)) ->
source(audio=none, video=ffmpeg.video.raw('b), midi=none)
```

Arguments:

- `color` (of type `int`, which defaults to `16777215`): Color of the text.
- `font` (of type `string`, which defaults to `""`): Font to use.
- `size` (of type `int`, which defaults to `18`): Size of the text.
- `x` (of type `int`, which defaults to `10`): x offset.
- `y` (of type `int`, which defaults to `10`): y offset.
- `(unlabeled)` (of type `string?`): Text to display.
- `(unlabeled)` (of type `source(audio=none, video=ffmpeg.video.raw('a), midi=none)`): Source on which the text should be added.

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `video.add_text.gd`

Display a text.

Type:
```
(?id : string?, ?color : int, ?cycle : bool,
 ?font : string, ?metadata : string, ?size : int,
 ?speed : int, ?x : {int}, ?y : {int}, {string},
 source(audio='a, video=yuva420p('b), midi='c)) ->
source(audio='a, video=yuva420p('b), midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `color` (of type `int`, which defaults to `16777215`): Text color (in 0xRRGGBB format).
- `cycle` (of type `bool`, which defaults to `true`): Cycle text when it reaches left boundary.
- `font` (of type `string`, which defaults to `"/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"`): Path to ttf font file.
- `metadata` (of type `string`, which defaults to `""`): Change text on a particular metadata (empty string means disabled).
- `size` (of type `int`, which defaults to `18`): Font size.
- `speed` (of type `int`, which defaults to `70`): Horizontal speed in pixels per second (0 means no scrolling and update according to x and y in case they are variable).
- `x` (of type `{int}`, which defaults to `10`): x offset.
- `y` (of type `{int}`, which defaults to `10`): y offset.
- `(unlabeled)` (of type `{string}`): Text to display.
- `(unlabeled)` (of type `source(audio='a, video=yuva420p('b), midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `video.add_text.gstreamer`

Display a text.

Type:
```
(?id : string?, ?color : int, ?cycle : bool,
 ?font : string, ?metadata : string, ?size : int,
 ?speed : int, ?x : {int}, ?y : {int}, {string},
 source(audio='a, video=yuva420p('b), midi='c)) ->
source(audio='a, video=yuva420p('b), midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `color` (of type `int`, which defaults to `16777215`): Text color (in 0xRRGGBB format).
- `cycle` (of type `bool`, which defaults to `true`): Cycle text when it reaches left boundary.
- `font` (of type `string`, which defaults to `"/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"`): Path to ttf font file.
- `metadata` (of type `string`, which defaults to `""`): Change text on a particular metadata (empty string means disabled).
- `size` (of type `int`, which defaults to `18`): Font size.
- `speed` (of type `int`, which defaults to `70`): Horizontal speed in pixels per second (0 means no scrolling and update according to x and y in case they are variable).
- `x` (of type `{int}`, which defaults to `10`): x offset.
- `y` (of type `{int}`, which defaults to `10`): y offset.
- `(unlabeled)` (of type `{string}`): Text to display.
- `(unlabeled)` (of type `source(audio='a, video=yuva420p('b), midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `video.add_text.native`

Display a text.

Type:
```
(?id : string?, ?color : int, ?cycle : bool,
 ?font : string, ?metadata : string, ?size : int,
 ?speed : int, ?x : {int}, ?y : {int}, {string},
 source(audio='a, video=yuva420p('b), midi='c)) ->
source(audio='a, video=yuva420p('b), midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `color` (of type `int`, which defaults to `16777215`): Text color (in 0xRRGGBB format).
- `cycle` (of type `bool`, which defaults to `true`): Cycle text when it reaches left boundary.
- `font` (of type `string`, which defaults to `"/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"`): Path to ttf font file.
- `metadata` (of type `string`, which defaults to `""`): Change text on a particular metadata (empty string means disabled).
- `size` (of type `int`, which defaults to `18`): Font size.
- `speed` (of type `int`, which defaults to `70`): Horizontal speed in pixels per second (0 means no scrolling and update according to x and y in case they are variable).
- `x` (of type `{int}`, which defaults to `10`): x offset.
- `y` (of type `{int}`, which defaults to `10`): y offset.
- `(unlabeled)` (of type `{string}`): Text to display.
- `(unlabeled)` (of type `source(audio='a, video=yuva420p('b), midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `video.add_text.sdl`

Display a text.

Type:
```
(?id : string?, ?color : int, ?cycle : bool,
 ?font : string, ?metadata : string, ?size : int,
 ?speed : int, ?x : {int}, ?y : {int}, {string},
 source(audio='a, video=yuva420p('b), midi='c)) ->
source(audio='a, video=yuva420p('b), midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `color` (of type `int`, which defaults to `16777215`): Text color (in 0xRRGGBB format).
- `cycle` (of type `bool`, which defaults to `true`): Cycle text when it reaches left boundary.
- `font` (of type `string`, which defaults to `"/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"`): Path to ttf font file.
- `metadata` (of type `string`, which defaults to `""`): Change text on a particular metadata (empty string means disabled).
- `size` (of type `int`, which defaults to `18`): Font size.
- `speed` (of type `int`, which defaults to `70`): Horizontal speed in pixels per second (0 means no scrolling and update according to x and y in case they are variable).
- `x` (of type `{int}`, which defaults to `10`): x offset.
- `y` (of type `{int}`, which defaults to `10`): y offset.
- `(unlabeled)` (of type `{string}`): Text to display.
- `(unlabeled)` (of type `source(audio='a, video=yuva420p('b), midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `video.cover`

Generate a video source containing cover-art for current track of input audio source.

Type:
```
('b.{on_track : (((([string * string]) -> unit)) -> 'a)}) ->
source(audio=none, video='d, midi='e)
```

Arguments:

- `(unlabeled)` (of type `'b.{on_track : (((([string * string]) -> unit)) -> 'a)}`): Audio source whose metadata contain cover-art.

### `video.fade.in`

Fade the beginning of tracks. Metadata 'liq_video_fade_in' can be used to set the duration for a specific track (float in seconds).

Type:
```
(?id : string?, ?duration : float, ?override : string,
 ?transition : string, ?type : string, source(audio='a,
 video=yuva420p('b), midi='c)) -> source(audio='a,
video=yuva420p('b), midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `duration` (of type `float`, which defaults to `3.`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
- `override` (of type `string`, which defaults to `"liq_video_fade_in"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
- `transition` (of type `string`, which defaults to `"fade"`): Kind of transition (fade|slide_left|slide_right|slide_up|slide_down|grow|disc|random).
- `type` (of type `string`, which defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
- `(unlabeled)` (of type `source(audio='a, video=yuva420p('b), midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `video.fade.out`

Fade the end of tracks. Metadata 'liq_video_fade_out' can be used to set the duration for a specific track (float in seconds).

Type:
```
(?id : string?, ?duration : float, ?override : string,
 ?transition : string, ?type : string, source(audio='a,
 video=yuva420p('b), midi='c)) -> source(audio='a,
video=yuva420p('b), midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `duration` (of type `float`, which defaults to `3.`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
- `override` (of type `string`, which defaults to `"liq_video_fade_out"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
- `transition` (of type `string`, which defaults to `"fade"`): Kind of transition (fade|slide_left|slide_right|slide_up|slide_down|grow|disc|random).
- `type` (of type `string`, which defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
- `(unlabeled)` (of type `source(audio='a, video=yuva420p('b), midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `video.fill`

Fill frame with a color.

Type:
```
(?id : string?, ?color : {int}, source(audio='a,
 video='b, midi='c)) -> source(audio='a, video='b,
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `color` (of type `{int}`, which defaults to `0`): Color to fill the image with (0xRRGGBB).
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `video.frame.height`

Height for all video frames.

Type:
```
() -> int
```

Arguments:


### `video.frame.rate`

Framerate for all video frames.

Type:
```
() -> int
```

Arguments:


### `video.frame.width`

Width for all video frames.

Type:
```
() -> int
```

Arguments:


### `video.greyscale`

Convert video to greyscale.

Type:
```
(?id : string?, source(audio='a, video='b, midi='c)) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `video.invert`

Invert video.

Type:
```
(?id : string?, source(audio='a, video='b, midi='c)) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `video.opacity`

Scale opacity of video.

Type:
```
(?id : string?, {float}, source(audio='a, video='b,
 midi='c)) -> source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `{float}`): Coefficient to scale opacity with.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `video.opacity.box`

Set alpha value on a given box inside the image.

Type:
```
(?id : string?, alpha : {float}, height : {int},
 width : {int}, ?x : {int}, ?y : {int}, source(audio='a,
 video='b, midi='c)) -> source(audio='a, video='b,
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `alpha` (of type `{float}`): alpha value.
- `height` (of type `{int}`): Box height.
- `width` (of type `{int}`): Box width.
- `x` (of type `{int}`, which defaults to `0`): x offset.
- `y` (of type `{int}`, which defaults to `0`): y offset.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `video.resize`

Resize and translate video.

Type:
```
(?id : string?, ?height : {int}?, ?width : {int}?,
 ?x : {int}, ?y : {int}, source(audio='a, video='b,
 midi='c)) -> source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `height` (of type `{int}?`, which defaults to `null`): Target height (`null` means original height).
- `width` (of type `{int}?`, which defaults to `null`): Target width (`null` means original width).
- `x` (of type `{int}`, which defaults to `0`): x offset.
- `y` (of type `{int}`, which defaults to `0`): y offset.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `video.scale`

Scale and translate video.

Type:
```
(?id : string?, ?scale : {float}, ?x : {int},
 ?xscale : {float}, ?y : {int}, ?yscale : {float},
 source(audio='a, video='b, midi='c)) -> source(audio='a,
video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `scale` (of type `{float}`, which defaults to `1.`): Scaling coefficient in both directions.
- `x` (of type `{int}`, which defaults to `0`): x offset.
- `xscale` (of type `{float}`, which defaults to `1.`): x scaling.
- `y` (of type `{int}`, which defaults to `0`): y offset.
- `yscale` (of type `{float}`, which defaults to `1.`): y scaling.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `video.sepia`

Convert video to sepia.

Type:
```
(?id : string?, source(audio='a, video='b, midi='c)) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `video.still_frame`

Take still frames from a video source by calling the `save` method. For now only bitmap output is supported.

Type:
```
(?id : string?, source(audio='a, video=yuva420p('b),
 midi='c)) -> source(audio='a, video=yuva420p('b),
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='a, video=yuva420p('b), midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `save` (of type `(string) -> unit`): Save current image, argument is the file name to save to.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `video.testsrc`

A test video source, which generates various patterns.

Type:
```
(?id : string?, ?pattern : string, ?max_buffer : float,
 ?duration : 'a?) -> source(audio=none, video='c,
midi='d)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `pattern` (of type `string`, which defaults to `"testsrc"`): Pattern drawn in the video: `"testsrc"`, `"testsrc2"`, `"smptebars"` or `"rgbtestsrc"`.
- `max_buffer` (of type `float`, which defaults to `0.5`): Maximum data buffer in seconds
- `duration` (of type `'a?`, which defaults to `null`): Duration of the source.

### `video.tile`

Tile sources (same as add but produces tiles of videos).

Type:
```
(?id : string?, ?normalize : {bool}, ?power : {bool},
 ?proportional : bool, ?weights : [{float}],
 [source(audio='a, video=yuva420p('b), midi='c)]) ->
source(audio='a, video=yuva420p('b), midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `normalize` (of type `{bool}`, which defaults to `true`)
- `power` (of type `{bool}`, which defaults to `false`): Perform constant-power normalization.
- `proportional` (of type `bool`, which defaults to `true`): Scale preserving the proportions.
- `weights` (of type `[{float}]`, which defaults to `[]`): Relative weight of the sources in the sum. The empty list stands for the homogeneous distribution.
- `(unlabeled)` (of type `[source(audio='a, video=yuva420p('b), midi='c)]`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

## Source / Visualization

### `bpm`

Detect the BPM (number of beats per minute). The returned source has a method `bpm`, which can be called to compute it.

Type:
```
(?id : string?, source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `bpm` (of type `() -> float`): Compute the current BPM.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `lufs`

Compute current LUFS of the source according to the EBU R128 standard. It returns the source with a method to compute the current value.

Type:
```
(?id : string?, ?window : {float}, source(audio=pcm('a),
 video='b, midi='c)) -> source(audio=pcm('a), video='b,
midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `window` (of type `{float}`, which defaults to `3.`): Duration of the window (in seconds) used to compute the LUFS.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `lufs` (of type `() -> float`): Current value for the LUFS (short-term value computed over the duration specified by the `window` parameter).
- `lufs_momentary` (of type `() -> float`): Momentary LUFS (over a 400ms window).
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `midi.inspect`

Display midi events on standard output.

Type:
```
(?id : string?, source(audio='a, video='b, midi='c)) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `rms.smooth`

Compute the current RMS for the source, this varies more smoothly that `rms` and is updated more frequently. Returns the source with a method `rms`.

Type:
```
(?id : string?, ?duration : {float},
 source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `duration` (of type `{float}`, which defaults to `0.5`): Duration of the window in seconds (more precisely, this is the time constant of the low-pass filter).
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `rms` (of type `() -> float`): Current value for the RMS.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `server.rms`

Register a command that outputs the RMS of the returned source.

Type:
```
(?id : string?, source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `rms` (of type `() -> float`): Current value for the RMS volume.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `video.volume`

Graphical visualization of the sound.

Type:
```
(?id : string?, source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`)

Methods:

- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `log` (of type `{level : (() -> int?).{set : ((int) -> unit)}}`): Get or set the source's log level, from `1` to `5`.
- `on_leave` (of type `((() -> unit)) -> unit`): Register a function to be called when source is not used anymore by another source.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controling its own real-time loop.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

## String

### `%`

`pattern % [...,(k,v),...]` changes in the pattern occurrences of:

- `$(k)` into `v`
- `$(if $(k2),"a","b") into "a" if k2 is found in the list, "b" otherwise.

Type:
```
(string, [string * string]) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)
- `(unlabeled)` (of type `[string * string]`)

### `^`

Concatenate strings.

Type:
```
(string, string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)
- `(unlabeled)` (of type `string`)

### `bool_of_string`

Convert a string to a bool.

Type:
```
(?default : bool, string) -> bool
```

Arguments:

- `default` (of type `bool`, which defaults to `false`)
- `(unlabeled)` (of type `string`)

### `file.metadata.flac.cover.decode`

Decode a flac-encoded cover metadata string

Type:
```
(string) -> string
.{
  picture_type : int,
  mime : string,
  description : string,
  width : int,
  height : int,
  color_depth : int,
  number_of_colors : int?}?
```

Arguments:

- `(unlabeled)` (of type `string`)

### `file.metadata.flac.cover.encode`

Encode cover metadata for embedding with  flac files

Type:
```
(picture_type : int, mime : string,
 ?description : string, width : int, height : int,
 color_depth : int, ?number_of_colors : int?, string) ->
string
```

Arguments:

- `picture_type` (of type `int`)
- `mime` (of type `string`)
- `description` (of type `string`, which defaults to `""`)
- `width` (of type `int`)
- `height` (of type `int`)
- `color_depth` (of type `int`)
- `number_of_colors` (of type `int?`, which defaults to `null`)
- `(unlabeled)` (of type `string`)

### `float_of_string`

Convert a string to a float.

Type:
```
(?default : float, string) -> float
```

Arguments:

- `default` (of type `float`, which defaults to `0.`)
- `(unlabeled)` (of type `string`)

### `int_of_string`

Convert a string to a int.

Type:
```
(?default : int, string) -> int
```

Arguments:

- `default` (of type `int`, which defaults to `0`)
- `(unlabeled)` (of type `string`)

### `json`

Create a generic json object

Type:
```
() -> json
```

Arguments:


Methods:

- `add` (of type `(string, 'a) -> unit`): Add or replace a new `key`/`value` pair to the object.
- `remove` (of type `(string) -> unit`): Remove a key from the object. Does not nothing if the key does not exist.

### `json.parse`

Parse a json string into a liquidsoap value. The value provided in the `default` parameter is quite important: only the part of the JSON data which has the same type as the `default` parameter will be kept (heterogeneous data cannot be represented in Liquidsoap because of typing). For instance, if the JSON `j` is
```
{
 "a": "test",
 "b": 5
}
```
the value returned by `json.parse(default=[("",0)], j)` will be `[("b",5)]`: the pair `("a","test")` is not kept because it is not of type `string * int`.

Type:
```
(default : 'a, string) -> 'a
```

Arguments:

- `default` (of type `'a`): Default value if string cannot be parsed.
- `(unlabeled)` (of type `string`)

### `json.stringify`

Convert a value to a json string.

Type:
```
(?compact : bool, ?json5 : bool, 'a) -> string
```

Arguments:

- `compact` (of type `bool`, which defaults to `false`): Output compact text.
- `json5` (of type `bool`, which defaults to `false`): Use json5 extended spec.
- `(unlabeled)` (of type `'a`)

### `metadata.json.parse`

Parse metadata from JSON object

Type:
```
(string) -> [string * string]
```

Arguments:

- `(unlabeled)` (of type `string`)

### `string`

Ensure that we have a string (useful for removing fields from strings).

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `string.annotate.parse`

Parse a string of the form `<key>=<value>,...:<uri>` as given by the `annotate:` protocol

Type:
```
(string) -> [string * string] * string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `string.base64.decode`

Decode a Base64 encoded string.

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `string.base64.encode`

Encode a string in Base64.

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `string.binary.of_int`

Encode a positive (unsigned) integer using native memory representation.

Type:
```
(?pad : int, ?little_endian : bool, int) -> string
```

Arguments:

- `pad` (of type `int`, which defaults to `0`): Minimum length in digits (pad on the left with zeros in order to reach it)
- `little_endian` (of type `bool`, which defaults to `true`): Whether the memory representation is little endian.
- `(unlabeled)` (of type `int`): String containing the binary representation.

### `string.binary.to_int`

Value of a positive (unsigned) integer encoded using native memory representation.

Type:
```
(?little_endian : bool, string) -> int
```

Arguments:

- `little_endian` (of type `bool`, which defaults to `true`): Whether the memory representation is little endian.
- `(unlabeled)` (of type `string`): String containing the binary representation.

### `string.capitalize`

Return a string with the first character set to upper case (capitalize), or to lower case (uncapitalize).

Type:
```
(?capitalize : bool, ?space_sensitive : bool, string) ->
string
```

Arguments:

- `capitalize` (of type `bool`, which defaults to `true`): Capitalize if true, uncapitalize otherwise
- `space_sensitive` (of type `bool`, which defaults to `true`): Capitalize each space separated sub-string.
- `(unlabeled)` (of type `string`)

### `string.case`

Convert a string to lower or upper case.

Type:
```
(?lower : bool, string) -> string
```

Arguments:

- `lower` (of type `bool`, which defaults to `true`): Convert to lower case if true and uppercase otherwise.
- `(unlabeled)` (of type `string`)

### `string.concat`

Concatenate strings.

Type:
```
(?separator : string, [string]) -> string
```

Arguments:

- `separator` (of type `string`, which defaults to `""`)
- `(unlabeled)` (of type `[string]`)

### `string.contains`

Test whether a string contains a given prefix, substring or suffix.

Type:
```
(?prefix : string, ?substring : string, ?suffix : string,
 string) -> bool
```

Arguments:

- `prefix` (of type `string`, which defaults to `""`): Prefix to look for.
- `substring` (of type `string`, which defaults to `""`): Substring to look for.
- `suffix` (of type `string`, which defaults to `""`): Suffix to look for.
- `(unlabeled)` (of type `string`): The string to look into.

### `string.data_uri.decode`

Decode a string using the data uri format, i.e. `"data:<mime>[;base64]:<data>"`.

Type:
```
(string) -> string.{mime : string}?
```

Arguments:

- `(unlabeled)` (of type `string`)

### `string.data_uri.encode`

Encode a string using the data uri format, i.e. `"data:<mime>[;base64]:<data>"`.

Type:
```
(?base64 : bool, mime : string, string) -> string
```

Arguments:

- `base64` (of type `bool`, which defaults to `true`): Encode data using the base64 format
- `mime` (of type `string`): Data mime type
- `(unlabeled)` (of type `string`)

### `string.escape`

Escape special characters in an string. By default, the string is assumed to be `"utf8"` encoded and is escaped following JSON and javascript specification.

Type:
```
(?special_char : ((string) -> bool)?,
 ?escape_char : ((string) -> string)?,
 ?encoding : string, string) -> string
```

Arguments:

- `special_char` (of type `((string) -> bool)?`, which defaults to `null`): Return `true` if the given character (passed as a string) should be escaped. Defaults to control charaters for `"utf8"` and control characters and any character above `\x7E` (non-printable characters) for `"ascii"`.
- `escape_char` (of type `((string) -> string)?`, which defaults to `null`): Function used to escape a character. Defaults to `\xxx` octal notation for `"ascii"` and `\uxxxx` hexadecimal notation for `"utf8"`.
- `encoding` (of type `string`, which defaults to `"utf8"`): One of: `"ascii"` or `"utf8"`.
- `(unlabeled)` (of type `string`)

### `string.escape.all`

Escape each character in the given string using a specific escape sequence

Type:
```
(?format : string, string) -> string
```

Arguments:

- `format` (of type `string`, which defaults to `"utf8"`): Escape format. One of: `"octal"`, `"hex"` or `"utf8"`.
- `(unlabeled)` (of type `string`)

### `string.escape.special_char`

Default function to detect characters to escape. See `string.escape` for more details.

Type:
```
(?encoding : string, string) -> bool
```

Arguments:

- `encoding` (of type `string`, which defaults to `"utf8"`): One of: `"ascii"` or `"utf8"`.
- `(unlabeled)` (of type `string`)

### `string.extract`

Extract substrings from a string. Perl compatible regular expressions are recognized. Hence, special characters should be escaped. Returns a list of (index,value). If the list does not have a pair associated to some index, it means that the corresponding pattern was not found.

Type:
```
(pattern : string, string) -> [int * string]
```

Arguments:

- `pattern` (of type `string`)
- `(unlabeled)` (of type `string`)

### `string.hex_of_int`

Hexadecimal representation of an integer.

Type:
```
(?pad : int, int) -> string
```

Arguments:

- `pad` (of type `int`, which defaults to `0`): Minimum length in digits (pad on the left with zeros in order to reach it).
- `(unlabeled)` (of type `int`)

### `string.id`

Generate an identifier with given operator name.

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`): Operator name.

### `string.id.default`

Generate an identifier if no identifier was provided.

Type:
```
(default : string, string?) -> string
```

Arguments:

- `default` (of type `string`): Name from which identifier is generated if not present.
- `(unlabeled)` (of type `string?`): Proposed identifier.

### `string.is_int`

Test whether a string is a valid integer.

Type:
```
(string) -> bool
```

Arguments:

- `(unlabeled)` (of type `string`)

### `string.length`

Get the length of a string.

Type:
```
(string) -> int
```

Arguments:

- `(unlabeled)` (of type `string`)

### `string.make`

Create a string of a given length using the given character.

Type:
```
(?char_code : int, int) -> string
```

Arguments:

- `char_code` (of type `int`, which defaults to `32`): Character code.
- `(unlabeled)` (of type `int`): String length.

### `string.match`

Match a string with an expression. Perl compatible regular expressions are recognized. Hence, special characters should be escaped.

Type:
```
(pattern : string, string) -> bool
```

Arguments:

- `pattern` (of type `string`)
- `(unlabeled)` (of type `string`)

### `string.nth`

Retrieve a character in a string. Raises `error.not_found` if character does not exist.

Type:
```
(string, int) -> int
```

Arguments:

- `(unlabeled)` (of type `string`): String to look into.
- `(unlabeled)` (of type `int`): Index of the character.

### `string.null_terminated`

Add a null character at the end of a string.

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`): String.

### `string.quote`

Return a quoted copy of the given string. By default, the string is assumed to be `"utf8"` encoded and is escaped following JSON and javascript specification.

Type:
```
(?encoding : string, string) -> string
```

Arguments:

- `encoding` (of type `string`, which defaults to `"utf8"`): One of: `"ascii"` or `"utf8"`.
- `(unlabeled)` (of type `string`)

### `string.recode`

Convert a string. Effective only if Camomile is enabled.

Type:
```
(?in_enc : string?, ?out_enc : string, string) -> string
```

Arguments:

- `in_enc` (of type `string?`, which defaults to `null`): Input encoding. Autodetected if null.
- `out_enc` (of type `string`, which defaults to `"UTF-8"`): Output encoding.
- `(unlabeled)` (of type `string`)

### `string.replace`

Replace all substrings matched by a pattern by another string returned by a function.

Type:
```
(pattern : string, ((string) -> string), string) ->
string
```

Arguments:

- `pattern` (of type `string`): Pattern (regular expression) of substrings which should be replaced.
- `(unlabeled)` (of type `(string) -> string`): Function getting a matched substring an returning the string to replace it with.
- `(unlabeled)` (of type `string`): String whose substrings should be replaced.

### `string.split`

Split a string at 'separator'. Perl compatible regular expressions are recognized. Hence, special characters should be escaped.

Type:
```
(separator : string, string) -> [string]
```

Arguments:

- `separator` (of type `string`)
- `(unlabeled)` (of type `string`)

### `string.sub`

Get a substring of a string. Returns "" if no such substring exists.

Type:
```
(string, start : int, length : int) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)
- `start` (of type `int`): Return a sub string starting at this position. First position is 0.
- `length` (of type `int`): Return a sub string of `length` characters.

### `string.trim`

Return a string without leading and trailing whitespace.

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `string.unescape`

This function is the inverse of `string.escape`.

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `string_of`

Return the representation of a value.

Type:
```
(?fields : bool, 'a) -> string
```

Arguments:

- `fields` (of type `bool`, which defaults to `false`): Show toplevel fields around the value.
- `(unlabeled)` (of type `'a`)

### `string_of_float`

String representation of a float

Type:
```
(?decimal_places : int?, float) -> string
```

Arguments:

- `decimal_places` (of type `int?`, which defaults to `null`): Number of decimal places.
- `(unlabeled)` (of type `float`)

### `string_of_metadata`

Standard function for displaying metadata. Shows artist and title, using "Unknown" when a field is empty.

Type:
```
([string * string]) -> string
```

Arguments:

- `(unlabeled)` (of type `[string * string]`): Metadata packet to be displayed.

### `url.decode`

Decode an encoded url (e.g. "%20" becomes " ").

Type:
```
(?plus : bool, string) -> string
```

Arguments:

- `plus` (of type `bool`, which defaults to `true`)
- `(unlabeled)` (of type `string`)

### `url.encode`

Encode an url (e.g. " " becomes "%20").

Type:
```
(?plus : bool, string) -> string
```

Arguments:

- `plus` (of type `bool`, which defaults to `true`)
- `(unlabeled)` (of type `string`)

### `url.split`

Split an url of the form `foo?arg=bar&arg2=bar2` into `("foo",[("arg","bar"),("arg2","bar2")])`. The returned strings are decoded (see `url.decode`).

Type:
```
(string) -> string * [string * string]
```

Arguments:

- `(unlabeled)` (of type `string`): Url to split.

### `url.split_args`

Split the arguments of an url of the form `arg=bar&arg2=bar2` into `[("arg","bar"),("arg2","bar2")]`. The returned strings are decoded (see `url.decode`).

Type:
```
(string) -> [string * string]
```

Arguments:

- `(unlabeled)` (of type `string`): Argument string to split.

## String 

### `metadata.json.stringify`

Export metadata as JSON object. Cover art, if found, is extracted using `metadata.cover` and exported with key `"cover"` and exported using `string.data_uri.encode`.

Type:
```
(?coverart_mime : string?, ?base64 : bool,
 ?compact : bool, ?json5 : bool, [string * string]) ->
string
```

Arguments:

- `coverart_mime` (of type `string?`, which defaults to `null`): Mime type to use for `"coverart"` metadata. Support disasbled if `null`.
- `base64` (of type `bool`, which defaults to `true`): Encode cover data as `base64`
- `compact` (of type `bool`, which defaults to `false`): Output compact text.
- `json5` (of type `bool`, which defaults to `false`): Use json5 extended spec.
- `(unlabeled)` (of type `[string * string]`)

## System

### `argv`

Get command-line parameters. The parameters are numbered starting from 1, the zeroth parameter being the script name.

Type:
```
(?default : string, int) -> string
```

Arguments:

- `default` (of type `string`, which defaults to `""`)
- `(unlabeled)` (of type `int`)

### `environment`

Return the process environment.

Type:
```
() -> [string * string]
```

Arguments:


### `exe_ext`

Executable file extension.

Type:
```
string
```

Arguments:


### `exit`

Immediately stop the application. This should only be used in extreme cases or to specify an exit value. The recommended way of stopping Liquidsoap is to use shutdown.

Type:
```
(int) -> unit
```

Arguments:

- `(unlabeled)` (of type `int`): Exit value.

### `file.contents`

Read the whole contents of a file.

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `file.cover`

Obtain cover-art for a file. An empty string is returned in case there is no such information.

Type:
```
(string) -> string.{mime : string}?
```

Arguments:

- `(unlabeled)` (of type `string`): File from which the cover should be obtained

### `file.getter`

Getter to the contents of a file.

Type:
```
(string) -> () -> string
```

Arguments:

- `(unlabeled)` (of type `string`): Name of the file from which the contents should be taken.

### `file.getter.float`

Float getter from a file.

Type:
```
(?default : float, string) -> {float}
```

Arguments:

- `default` (of type `float`, which defaults to `0.`): Default value when the file contains invalid data.
- `(unlabeled)` (of type `string`): Name of the file from which the contents should be taken.

### `file.iterator`

Iterate over the contents of a file.

Type:
```
(string) -> () -> string?
```

Arguments:

- `(unlabeled)` (of type `string`)

### `file.lines`

Get the list of lines of a file.

Type:
```
(string) -> [string]
```

Arguments:

- `(unlabeled)` (of type `string`)

### `file.lines.iterator`

Iterate over the lines of a file.

Type:
```
(string) -> () -> string?
```

Arguments:

- `(unlabeled)` (of type `string`)

### `file.mime_default`

Alias of file.mime (because it is available)

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `get_mime`

Generic mime test. First try to use file.mime if it exist.  Otherwise try to get the value using the file binary. Returns "" (empty string) if no value can be found.

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`): The file to test

### `getenv`

Get the value associated to a variable in the process environment. Returns "" if the variable is not set.

Type:
```
(?default : string, string) -> string
```

Arguments:

- `default` (of type `string`, which defaults to `""`)
- `(unlabeled)` (of type `string`)

### `getopt`

Parse command line options:
`getopt("-o")` returns "1" if "-o" was passed without any parameter, "0" otherwise.
`getopt(default="X","-o")` returns "Y" if "-o Y" was passed, "X" otherwise.
The result is removed from the list of arguments, affecting subsequent
calls to `argv()` and `getopt()`.

Type:
```
(?default : string, string) -> string
```

Arguments:

- `default` (of type `string`, which defaults to `""`)
- `(unlabeled)` (of type `string`)

### `getpid`

Get the process' pid.

Type:
```
() -> int
```

Arguments:


### `on_shutdown`

Register a function to be called when Liquidsoap shuts down.

Type:
```
((() -> unit)) -> unit
```

Arguments:

- `(unlabeled)` (of type `() -> unit`)

### `on_start`

Register a function to be called when Liquidsoap starts.

Type:
```
((() -> unit)) -> unit
```

Arguments:

- `(unlabeled)` (of type `() -> unit`)

### `os.type`

Type of OS running liquidsoap.

Type:
```
string
```

Arguments:


### `process.quote`

Return a quoted copy of the given string, suitable for use as one argument in a command line, escaping all meta-characters. Warning: under Windows, the output is only suitable for use with programs that follow the standard Windows quoting conventions.

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`): File name

### `process.read`

Perform a shell call and return its output.

Type:
```
(?timeout : float, ?env : [string * string],
 ?inherit_env : bool, string) -> string
```

Arguments:

- `timeout` (of type `float`, which defaults to `-1.`): Cancel process after `timeout` has elapsed. Ignored if negative.
- `env` (of type `[string * string]`, which defaults to `[]`): Process environment
- `inherit_env` (of type `bool`, which defaults to `true`): Inherit calling process's environment when `env` parameter is empty.
- `(unlabeled)` (of type `string`): Command to run

### `process.read.lines`

Perform a shell call and return the list of its output lines.

Type:
```
(?timeout : float, ?env : [string * string],
 ?inherit_env : bool, string) -> [string]
```

Arguments:

- `timeout` (of type `float`, which defaults to `-1.`): Cancel process after `timeout` has elapsed. Ignored if negative.
- `env` (of type `[string * string]`, which defaults to `[]`): Process environment
- `inherit_env` (of type `bool`, which defaults to `true`): Inherit calling process's environment when `env` parameter is empty.
- `(unlabeled)` (of type `string`): Command to run

### `process.run`

Run a process in a shell environment. Returns the standard output, as well as standard error and status as methods. The status can be "exit" (the status code is set), "killed" or "stopped" (the status code is the signal), or "exception" (the description is set) or "timeout" (the description is the run time).

Type:
```
(?env : [string * string], ?inherit_env : bool,
 ?rwdirs : [string], ?rodirs : [string],
 ?network : bool?, ?timeout : float?, string) -> unit
```

Arguments:

- `env` (of type `[string * string]`, which defaults to `[]`): Process environment
- `inherit_env` (of type `bool`, which defaults to `true`): Inherit calling process's environment when `env` parameter is empty.
- `rwdirs` (of type `[string]`, which defaults to `["default"]`): Read/write directories for sandboxing. `"default"` expands to sandbox default.
- `rodirs` (of type `[string]`, which defaults to `["default"]`): Read-only directories for sandboxing `"default"` expands to sandbox default.
- `network` (of type `bool?`, which defaults to `null`): Enable or disable network inside sandboxed environment (sandbox default if not specified).
- `timeout` (of type `float?`, which defaults to `null`): Cancel process after `timeout` has elapsed. Ignored if negative.
- `(unlabeled)` (of type `string`): Command to run

Methods:

- `status` (of type `string.{description : string, code : int}`): Status when process ended, can be one of `"exit"` (the program exited, the `status` code is then relevant), `"killed"` (the program was killed by signal given in `status` code), `"stopped"` (the program was stopped by signal given in `status` code) or `"exception"` (the program raised and exception detailed in the `description`).
- `stderr` (of type `string`): Messages written by process on standard error stream.
- `stdout` (of type `string`): Messages written by process on standard output stream.

### `process.test`

Return true if process exited with 0 code.

Type:
```
(?timeout : float, ?env : [string * string],
 ?inherit_env : bool, string) -> bool
```

Arguments:

- `timeout` (of type `float`, which defaults to `-1.`): Cancel process after `timeout` has elapsed. Ignored if negative.
- `env` (of type `[string * string]`, which defaults to `[]`): Process environment
- `inherit_env` (of type `bool`, which defaults to `true`): Inherit calling process's environment when `env` parameter is empty.
- `(unlabeled)` (of type `string`): Command to test

### `read`

Read some value from standard input (console).

Type:
```
(?hide : bool) -> string
```

Arguments:

- `hide` (of type `bool`, which defaults to `false`): Hide typed characters (for passwords).

### `reopen.stderr`

Reopen standard error on the given file

Type:
```
(string) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`)

### `reopen.stdin`

Reopen standard input on the given file

Type:
```
(string) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`)

### `reopen.stdout`

Reopen standard output on the given file

Type:
```
(string) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`)

### `restart`

Restart the application.

Type:
```
() -> unit
```

Arguments:


### `setenv`

Set the value associated to a variable in the process environment.

Type:
```
(string, string) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`): Variable to be set.
- `(unlabeled)` (of type `string`): Value to set.

### `shutdown`

Shutdown the application.

Type:
```
(?code : int) -> unit
```

Arguments:

- `code` (of type `int`, which defaults to `0`): Exit code. Default: `0`

### `sleep`

Sleep for a given amount of seconds (beware that it freezes the thread executing it).

Type:
```
(float) -> unit
```

Arguments:

- `(unlabeled)` (of type `float`): Number of seconds of sleep.

### `source.is_up`

Check whether a source is up.

Type:
```
(source('a)) -> bool
```

Arguments:

- `(unlabeled)` (of type `source('a)`)

### `source.on_leave`

Register a function to be called when source is not used anymore by another source.

Type:
```
(source('a), (() -> unit)) -> unit
```

Arguments:

- `(unlabeled)` (of type `source('a)`)
- `(unlabeled)` (of type `() -> unit`)

### `source.on_shutdown`

Register a function to be called when source shuts down.

Type:
```
(source('a), (() -> unit)) -> unit
```

Arguments:

- `(unlabeled)` (of type `source('a)`)
- `(unlabeled)` (of type `() -> unit`)

### `thread.when`

Execute a given action when a predicate is true.

Type:
```
(?fast : bool, ?every : float, ?once : bool,
 ?changed : bool, (() -> bool), (() -> unit)) -> unit
```

Arguments:

- `fast` (of type `bool`, which defaults to `true`)
- `every` (of type `float`, which defaults to `1.`): How often (in sec.) to check for the predicate.
- `once` (of type `bool`, which defaults to `false`): Execute the function only once.
- `changed` (of type `bool`, which defaults to `true`): Execute the function only if the predicate was false when last checked.
- `(unlabeled)` (of type `() -> bool`): Predicate indicating when to execute the function, typically a time interval such as `{10h-10h30}`.
- `(unlabeled)` (of type `() -> unit`): Function to execute when the predicate is true.

### `time`

Return the current time since 00:00:00 GMT, Jan. 1, 1970, in seconds.

Type:
```
() -> float
```

Arguments:


### `time.local`

Convert a time in seconds into a date in the local time zone (current time is used if no argument is provided). Fields meaning same as POSIX's `tm struct`. In particular, "year" is: year - 1900, i.e. 117 for 2017!

Type:
```
(?float?) -> unit
```

Arguments:

- `(unlabeled)` (of type `float?`, which defaults to `null`)

Methods:

- `hour` (of type `int`): Hours.
- `isdst` (of type `bool`): Daylight time savings in effect.
- `mday` (of type `int`): Day of month (between 1 and 31).
- `min` (of type `int`): Minutes.
- `mon` (of type `int`): Month of year (between 0 and 11).
- `sec` (of type `int`): Seconds.
- `wday` (of type `int`): Day of week (Sunday is 0).
- `yday` (of type `int`): Day of year (between 0 and 365).
- `year` (of type `int`): Year - 1900.

### `time.up`

Current time, in seconds, since the script has started.

Type:
```
() -> float
```

Arguments:


### `time.utc`

Convert a time in seconds into a date in the UTC time zone (current time is used if no argument is provided). Fields meaning same as POSIX's `tm struct`. In particular, "year" is: year - 1900, i.e. 117 for 2017!

Type:
```
(?float?) -> unit
```

Arguments:

- `(unlabeled)` (of type `float?`, which defaults to `null`)

Methods:

- `hour` (of type `int`): Hours.
- `isdst` (of type `bool`): Daylight time savings in effect.
- `mday` (of type `int`): Day of month (between 1 and 31).
- `min` (of type `int`): Minutes.
- `mon` (of type `int`): Month of year (between 0 and 11).
- `sec` (of type `int`): Seconds.
- `wday` (of type `int`): Day of week (Sunday is 0).
- `yday` (of type `int`): Day of year (between 0 and 365).
- `year` (of type `int`): Year - 1900.

## Visualization

