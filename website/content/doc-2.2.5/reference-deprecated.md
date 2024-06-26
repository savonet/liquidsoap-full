- [Liquidsoap](#liquidsoap)
- [Uncategorized](#uncategorized)

## Liquidsoap

### `deprecated`

Mark a function as deprecated.

Type:

```
('a, string) -> unit
```

Arguments:

- `(unlabeled)` (of type `'a`): Old function name.
- `(unlabeled)` (of type `string`): New function name.

### `register_flow`

Deprecated: flow is no longer maintained Register a radio on Liquidsoap Flows.

Type:

```
(?server : string, ?user : string, ?password : string, ?email : string,
 radio : string, website : string, description : string, genre : string,
 streams : [string * string], 'b
 .{on_metadata : ((([string * string]) -> unit)) -> 'a}) -> 'a
```

Arguments:

- `server` (of type `string`, which defaults to `""`)
- `user` (of type `string`, which defaults to `"default"`)
- `password` (of type `string`, which defaults to `"default"`)
- `email` (of type `string`, which defaults to `""`)
- `radio` (of type `string`): Name of the radio.
- `website` (of type `string`): URL of the website of the radio.
- `description` (of type `string`): Description of the radio.
- `genre` (of type `string`): Genre of the radio (rock or rap or etc.).
- `streams` (of type `[string * string]`): List of streams for the radio described by a pair of strings consisting of the format of the stream and the url of the stream. The format should be of the form "ogg/128k" consisting of the codec and the bitrate, separated by "/".
- `(unlabeled)` (of type `'b.{on_metadata : ((([string * string]) -> unit)) -> 'a}`)

## Uncategorized

### `add_decoder`

Deprecated: use `decoder.add`.

Type:

```
(name : string, description : string, ?mimes : [string],
 ?file_extensions : [string], ?priority : int, test : ((string) -> int),
 string) -> unit
```

Arguments:

- `name` (of type `string`)
- `description` (of type `string`)
- `mimes` (of type `[string]`, which defaults to `[]`)
- `file_extensions` (of type `[string]`, which defaults to `[]`)
- `priority` (of type `int`, which defaults to `1`)
- `test` (of type `(string) -> int`)
- `(unlabeled)` (of type `string`)

### `add_metadata_resolver`

Deprecated: use `decoder.metadata.add`.

Type:

```
(string, ((metadata : [string * string], string) -> [string * string])) ->
unit
```

Arguments:

- `(unlabeled)` (of type `string`)
- `(unlabeled)` (of type `(metadata : [string * string], string) -> [string * string]`)

### `add_oblivious_decoder`

Deprecated: use `decoder.oblivious.add`.

Type:

```
(name : string, description : string, test : ((string) -> int),
 ?priority : int, ?mimes : [string], ?file_extensions : [string],
 ?buffer : float, ((string) -> string)) -> unit
```

Arguments:

- `name` (of type `string`)
- `description` (of type `string`)
- `test` (of type `(string) -> int`)
- `priority` (of type `int`, which defaults to `1`)
- `mimes` (of type `[string]`, which defaults to `[]`)
- `file_extensions` (of type `[string]`, which defaults to `[]`)
- `buffer` (of type `float`, which defaults to `5.`)
- `(unlabeled)` (of type `(string) -> string`)

### `add_playlist_parser`

Deprecated: use `playlist.parse.register` instead

Type:

```
(format : string, strict : bool,
 ((?pwd : string, string) -> [[string * string] * string])) -> unit
```

Arguments:

- `format` (of type `string`)
- `strict` (of type `bool`)
- `(unlabeled)` (of type `(?pwd : string, string) -> [[string * string] * string]`)

### `add_protocol`

Deprecated: use `protocol.add`.

Type:

```
(?temporary : bool, ?static : bool, ?syntax : string, ?doc : string, string,
 ((rlog : ((string) -> unit), maxtime : float, string) -> [string])) -> unit
```

Arguments:

- `temporary` (of type `bool`, which defaults to `false`)
- `static` (of type `bool`, which defaults to `false`)
- `syntax` (of type `string`, which defaults to `"Undocumented"`)
- `doc` (of type `string`, which defaults to `"Undocumented"`)
- `(unlabeled)` (of type `string`)
- `(unlabeled)` (of type `(rlog : ((string) -> unit), maxtime : float, string) -> [string]`)

### `add_timeout`

Deprecated: this function has been replaced by `thread.run.recurrent`.

Type:

```
(?fast : bool, float, (() -> float)) -> unit
```

Arguments:

- `fast` (of type `bool`, which defaults to `true`)
- `(unlabeled)` (of type `float`)
- `(unlabeled)` (of type `() -> float`)

### `at`

Deprecated: use `at` instead.

Type:

```
({bool}, source('a)) -> source('a)
```

Arguments:

- `(unlabeled)` (of type `{bool}`)
- `(unlabeled)` (of type `source('a)`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `audio_to_stereo`

Deprecated: use `source.stereo`

Type:

```
(?id : string?, source(audio=pcm('a), 'b)) -> source(audio=pcm(stereo), 'b)
where 'b is a set of tracks to be muxed into a source
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `(unlabeled)` (of type `source(audio=pcm('a), 'b)
where 'b is a set of tracks to be muxed into a source`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `base64.decode`

Deprecated: this function has been replaced by `string.base64.decode`.

Type:

```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `base64.encode`

Deprecated: this function has been replaced by `string.base64.encode`.

Type:

```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `compress.old`

Deprecated: use `compress`

Type:

```
(?id : string?, source(audio=pcm('a), 'b)) -> source(audio=pcm('a)
.{gain? : never, rms? : never}, 'b)
where 'b is a set of tracks to be muxed into a source
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `(unlabeled)` (of type `source(audio=pcm('a), 'b)
where 'b is a set of tracks to be muxed into a source`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `gain` (of type `() -> float`): 
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `rms` (of type `() -> float`): 
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `cue_cut`

Deprecated: integrated into requests resolution.

Type:

```
(?id : string?, ?cue_in_metadata : string, ?cue_out_metadata : string,
 ?on_cue_in : (() -> unit), ?on_cue_out : (() -> unit), 'a) -> 'a
```

Arguments:

- `id` (of type `string?`, which defaults to `""`)
- `cue_in_metadata` (of type `string`, which defaults to `""`)
- `cue_out_metadata` (of type `string`, which defaults to `""`)
- `on_cue_in` (of type `() -> unit`, which defaults to `{()}`)
- `on_cue_out` (of type `() -> unit`, which defaults to `{()}`)
- `(unlabeled)` (of type `'a`)

### `drop_audio`

Deprecated: use `source.drop.audio`

Type:

```
(?id : string?, source(audio='a, 'b)) -> source('b)
where 'b is a set of tracks to be muxed into a source
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `(unlabeled)` (of type `source(audio='a, 'b) where 'b is a set of tracks to be muxed into a source`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `drop_metadata`

Deprecated: use `source.drop.metadata`

Type:

```
(?id : string?, source('a)) -> source('a)
where 'a is a set of tracks to be muxed into a source
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `(unlabeled)` (of type `source('a) where 'a is a set of tracks to be muxed into a source`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `drop_midi`

Deprecated: use `source.drop.midi`

Type:

```
(?id : string?, source(midi='a, 'b)) -> source('b)
where 'b is a set of tracks to be muxed into a source
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `(unlabeled)` (of type `source(midi='a, 'b) where 'b is a set of tracks to be muxed into a source`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `drop_video`

Deprecated: use `source.drop.video`

Type:

```
(?id : string?, source(video='a, 'b)) -> source('b)
where 'b is a set of tracks to be muxed into a source
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `(unlabeled)` (of type `source(video='a, 'b) where 'b is a set of tracks to be muxed into a source`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `eat_blank`

Deprecated: use `blank.eat` instead

Type:

```
(?id : string?, ?at_beginning : bool, ?max_blank : {float},
 ?min_noise : {float}, ?start_blank : bool, ?threshold : {float},
 ?track_sensitive : {bool}, source(audio=pcm('a), 'b)) ->
source(audio=pcm('a), 'b)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `at_beginning` (of type `bool`, which defaults to `false`)
- `max_blank` (of type `{float}`, which defaults to `20.`)
- `min_noise` (of type `{float}`, which defaults to `0.`)
- `start_blank` (of type `bool`, which defaults to `false`)
- `threshold` (of type `{float}`, which defaults to `-40.`)
- `track_sensitive` (of type `{bool}`, which defaults to `true`)
- `(unlabeled)` (of type `source(audio=pcm('a), 'b)`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `dB_levels` (of type `() -> [float]?`): Return the detected dB level for each channel.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_blank` (of type `() -> bool`): Indicate whether blank was detected.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `empty`

Deprecated: this function has been replaced by `source.fail`.

Type:

```
(?id : string?) -> source('a)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `error.kind`

Deprecated: use error method instead

Type:

```
('b.{kind : 'a}) -> 'a
```

Arguments:

- `(unlabeled)` (of type `'b.{kind : 'a}`)

### `error.message`

Deprecated: use error method instead

Type:

```
('b.{message : 'a}) -> 'a
```

Arguments:

- `(unlabeled)` (of type `'b.{message : 'a}`)

### `exec_at`

Deprecated: this function has been replaced by `thread.when`.

Type:

```
(?freq : float, pred : (() -> bool), (() -> 'a)) -> unit
```

Arguments:

- `freq` (of type `float`, which defaults to `1.`)
- `pred` (of type `() -> bool`)
- `(unlabeled)` (of type `() -> 'a`)

### `fade.final`

Deprecated: was designed for transitions only and is not needed anymore. Use `file.out` instead.

Type:

```
(?id : string, ?duration : float, ?type : string, source(audio=pcm('a), 'b)) ->
source(audio=pcm('a), 'b)
where 'b is a set of tracks to be muxed into a source
```

Arguments:

- `id` (of type `string`, which defaults to `"fade.final"`)
- `duration` (of type `float`, which defaults to `3.`)
- `type` (of type `string`, which defaults to `"lin"`)
- `(unlabeled)` (of type `source(audio=pcm('a), 'b)
where 'b is a set of tracks to be muxed into a source`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `selected` (of type `() -> source(audio=pcm('B), 'A)?
where 'A is a set of tracks to be muxed into a source`): Currently selected source.
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `fade.initial`

Deprecated: was designed for transitions only and is not needed anymore. Use `fade.in` instead.

Type:

```
(?id : string, ?duration : float, ?type : string, source(audio=pcm('a), 'b)) ->
source(audio=pcm('a), 'b)
where 'b is a set of tracks to be muxed into a source
```

Arguments:

- `id` (of type `string`, which defaults to `"fade.initial"`)
- `duration` (of type `float`, which defaults to `3.`)
- `type` (of type `string`, which defaults to `"lin"`)
- `(unlabeled)` (of type `source(audio=pcm('a), 'b)
where 'b is a set of tracks to be muxed into a source`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `file.unlink`

Deprecated: use `file.remove` instead.

Type:

```
(string) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`)

### `garbage_collect`

Deprecated: use `runtime.gc.full_major` instead

Type:

```
() -> unit
```

### `get_mime`

Deprecated: use `file.mime`

Type:

```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `get_process_lines`

Deprecated: use `process.read.lines` instead.

Type:

```
(?timeout : float, ?env : [string * string], ?inherit_env : bool,
 ?log_errors : bool, string) -> [string]
```

Arguments:

- `timeout` (of type `float`, which defaults to `-1.`)
- `env` (of type `[string * string]`, which defaults to `[]`)
- `inherit_env` (of type `bool`, which defaults to `true`)
- `log_errors` (of type `bool`, which defaults to `true`)
- `(unlabeled)` (of type `string`)

### `get_process_output`

Deprecated: use `process.read` instead.

Type:

```
(?timeout : float, ?env : [string * string], ?inherit_env : bool,
 ?log_errors : bool, string) -> string
```

Arguments:

- `timeout` (of type `float`, which defaults to `-1.`)
- `env` (of type `[string * string]`, which defaults to `[]`)
- `inherit_env` (of type `bool`, which defaults to `true`)
- `log_errors` (of type `bool`, which defaults to `true`)
- `(unlabeled)` (of type `string`)

### `getenv`

Deprecated: use `environment.get`

Type:

```
(?string, string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`, which defaults to `""`)
- `(unlabeled)` (of type `string`)

### `getpid`

Deprecated: use `getpid`

Type:

```
() -> int
```

### `gettimeofday`

Deprecated: use `time` instead

Type:

```
() -> float
```

### `gmtime`

Deprecated: use `time.utc` instead

Type:

```
(float?) -> unit
```

Arguments:

- `(unlabeled)` (of type `float?`)

Methods:

- `day` (of type `int`): Day of month.
- `dst` (of type `bool`): Daylight time savings in effect.
- `hour` (of type `int`): Hours.
- `min` (of type `int`): Minutes.
- `month` (of type `int`): Month of year.
- `sec` (of type `int`): Seconds.
- `week_day` (of type `int`): Day of week (Sunday is 0 or 7, Saturday is 6).
- `year` (of type `int`): Year.
- `year_day` (of type `int`): Day of year, between `1` and `366`.

### `https.delete`

Deprecated: use `http.delete` instead.

Type:

```
(?headers : [string * string], ?http_version : string?, ?redirect : bool,
 ?timeout : float?, ?normalize_url : bool, string) -> unit
```

Arguments:

- `headers` (of type `[string * string]`, which defaults to `[]`)
- `http_version` (of type `string?`, which defaults to `null`)
- `redirect` (of type `bool`, which defaults to `true`)
- `timeout` (of type `float?`, which defaults to `10.`)
- `normalize_url` (of type `bool`, which defaults to `true`)
- `(unlabeled)` (of type `string`)

Methods:

- `headers` (of type `[string * string]`): HTTP headers.
- `http_version` (of type `string`): Version of the HTTP protocol.
- `status_code` (of type `int`): Status code.
- `status_message` (of type `string`): Status message.

### `https.get`

Deprecated: use `http.get` instead.

Type:

```
(?headers : [string * string], ?http_version : string?, ?redirect : bool,
 ?timeout : float?, ?normalize_url : bool, string) -> string
```

Arguments:

- `headers` (of type `[string * string]`, which defaults to `[]`)
- `http_version` (of type `string?`, which defaults to `null`)
- `redirect` (of type `bool`, which defaults to `true`)
- `timeout` (of type `float?`, which defaults to `10.`)
- `normalize_url` (of type `bool`, which defaults to `true`)
- `(unlabeled)` (of type `string`)

Methods:

- `headers` (of type `[string * string]`): HTTP headers.
- `http_version` (of type `string`): Version of the HTTP protocol.
- `status_code` (of type `int`): Status code.
- `status_message` (of type `string`): Status message.

### `https.head`

Deprecated: use `http.head` instead.

Type:

```
(?headers : [string * string], ?http_version : string?, ?redirect : bool,
 ?timeout : float?, ?normalize_url : bool, string) -> unit
```

Arguments:

- `headers` (of type `[string * string]`, which defaults to `[]`)
- `http_version` (of type `string?`, which defaults to `null`)
- `redirect` (of type `bool`, which defaults to `true`)
- `timeout` (of type `float?`, which defaults to `10.`)
- `normalize_url` (of type `bool`, which defaults to `true`)
- `(unlabeled)` (of type `string`)

Methods:

- `headers` (of type `[string * string]`): HTTP headers.
- `http_version` (of type `string`): Version of the HTTP protocol.
- `status_code` (of type `int`): Status code.
- `status_message` (of type `string`): Status message.

### `https.post`

Deprecated: use `http.post` instead.

Type:

```
(?data : {string}, ?headers : [string * string], ?http_version : string?,
 ?redirect : bool, ?timeout : float?, ?normalize_url : bool, string) ->
string
```

Arguments:

- `data` (of type `{string}`, which defaults to `""`)
- `headers` (of type `[string * string]`, which defaults to `[]`)
- `http_version` (of type `string?`, which defaults to `null`)
- `redirect` (of type `bool`, which defaults to `true`)
- `timeout` (of type `float?`, which defaults to `10.`)
- `normalize_url` (of type `bool`, which defaults to `true`)
- `(unlabeled)` (of type `string`)

Methods:

- `headers` (of type `[string * string]`): HTTP headers.
- `http_version` (of type `string`): Version of the HTTP protocol.
- `status_code` (of type `int`): Status code.
- `status_message` (of type `string`): Status message.

### `https.put`

Deprecated: use `http.put` instead.

Type:

```
(?data : {string}, ?headers : [string * string], ?http_version : string?,
 ?redirect : bool, ?timeout : float?, ?normalize_url : bool, string) ->
string
```

Arguments:

- `data` (of type `{string}`, which defaults to `""`)
- `headers` (of type `[string * string]`, which defaults to `[]`)
- `http_version` (of type `string?`, which defaults to `null`)
- `redirect` (of type `bool`, which defaults to `true`)
- `timeout` (of type `float?`, which defaults to `10.`)
- `normalize_url` (of type `bool`, which defaults to `true`)
- `(unlabeled)` (of type `string`)

Methods:

- `headers` (of type `[string * string]`): HTTP headers.
- `http_version` (of type `string`): Version of the HTTP protocol.
- `status_code` (of type `int`): Status code.
- `status_message` (of type `string`): Status message.

### `id`

Deprecated: this function will be removed in a future release

Type:

```
(?id : 'a?, 'b) -> 'b
```

Arguments:

- `id` (of type `'a?`, which defaults to `null`)
- `(unlabeled)` (of type `'b`)

### `in`

Deprecated: use `input` instead.

Type:

```
(?id : string?, ?start : bool, ?on_start : (() -> unit),
 ?on_stop : (() -> unit), ?fallible : bool) -> source(audio=pcm('A))
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `start` (of type `bool`, which defaults to `true`)
- `on_start` (of type `() -> unit`, which defaults to `{()}`)
- `on_stop` (of type `() -> unit`, which defaults to `{()}`)
- `fallible` (of type `bool`, which defaults to `false`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `shutdown` (of type `() -> unit`): Shutdown the output or source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `input.external`

Deprecated: this function has been replaced by `input.external.rawaudio`.

Type:

```
(?id : string?, ?buffer : float, ?channels : int, ?max : float,
 ?restart : bool, ?restart_on_error : bool, ?samplerate : int, {string}) ->
source(audio=pcm('a))
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `buffer` (of type `float`, which defaults to `2.`)
- `channels` (of type `int`, which defaults to `2`)
- `max` (of type `float`, which defaults to `10.`)
- `restart` (of type `bool`, which defaults to `true`)
- `restart_on_error` (of type `bool`, which defaults to `false`)
- `samplerate` (of type `int`, which defaults to `44100`)
- `(unlabeled)` (of type `{string}`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `input.https`

Deprecated: use `input.http` instead

Type:

```
(?id : string?, ?clock_safe : bool, ?debug : bool,
 ?deduplicate_metadata : bool, ?float_args : [string * float],
 ?format : string?, ?int_args : [string * int], ?max_buffer : float,
 ?metadata_filter : (([string * string]) -> [string * string])?,
 ?new_track_on_metadata : bool, ?on_connect : (([string * string]) -> unit),
 ?on_disconnect : (() -> unit),
 ?on_error : ((error
               .{
                 kind : string,
                 message : string,
                 trace : [
                          {
                            position_end : 
                            {
                              character_offset : int,
                              filename : string,
                              line_number : int
                            },
                            position_start : 
                            {
                              character_offset : int,
                              filename : string,
                              line_number : int
                            },
                            to_string : (?prefix : string) -> string
                          }]
               }) -> unit),
 ?on_start : (() -> unit), ?on_stop : (() -> unit), ?poll_delay : float,
 ?self_sync : {bool?}, ?start : bool, ?string_args : [string * string],
 ?timeout : float, ?trim_url : bool, ?user_agent : string, {string}) ->
source('a)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `clock_safe` (of type `bool`, which defaults to `false`)
- `debug` (of type `bool`, which defaults to `false`)
- `deduplicate_metadata` (of type `bool`, which defaults to `true`)
- `float_args` (of type `[string * float]`, which defaults to `[]`)
- `format` (of type `string?`, which defaults to `null`)
- `int_args` (of type `[string * int]`, which defaults to `[]`)
- `max_buffer` (of type `float`, which defaults to `5.`)
- `metadata_filter` (of type `(([string * string]) -> [string * string])?`, which defaults to `null`)
- `new_track_on_metadata` (of type `bool`, which defaults to `true`)
- `on_connect` (of type `([string * string]) -> unit`, which defaults to `fun (_) -> ()`)
- `on_disconnect` (of type `() -> unit`, which defaults to `{()}`)
- `on_error` (of type `(error
 .{
   kind : string,
   message : string,
   trace : [
            {
              position_end : 
              {character_offset : int, filename : string, line_number : int
              },
              position_start : 
              {character_offset : int, filename : string, line_number : int
              },
              to_string : (?prefix : string) -> string
            }]
 }) -> unit`, which defaults to `fun (_) -> ()`)
- `on_start` (of type `() -> unit`, which defaults to `{()}`)
- `on_stop` (of type `() -> unit`, which defaults to `{()}`)
- `poll_delay` (of type `float`, which defaults to `2.`)
- `self_sync` (of type `{bool?}`, which defaults to `null`)
- `start` (of type `bool`, which defaults to `true`)
- `string_args` (of type `[string * string]`, which defaults to `[]`)
- `timeout` (of type `float`, which defaults to `10.`)
- `trim_url` (of type `bool`, which defaults to `true`)
- `user_agent` (of type `string`, which defaults to `"Liquidsoap/2.2.5 (Unix; OCaml 4.14.1)"`)
- `(unlabeled)` (of type `{string}`)

Methods:

- `buffer_length` (of type `() -> float`): Get the buffer's length in seconds.
- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `set_url` (of type `({string}) -> unit`): Set the source's url.
- `shutdown` (of type `() -> unit`): Shutdown the output or source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `status` (of type `() -> string`): Return the current status of the source, either "stopped" (the source isn't trying to relay the HTTP stream), "starting" (polling task is about to begin) "polling" (attempting to connect to the HTTP stream), "connected <url>" (connected to <url>, buffering or playing back the stream) or "stopping" (source is stopping).
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.
- `url` (of type `() -> string`): Return the source's current url.

### `json_of`

Deprecated: use `json.stringify` instead

Type:

```
(?compact : bool, ?json5 : bool, 'a) -> string
```

Arguments:

- `compact` (of type `bool`, which defaults to `false`): Output compact text.
- `json5` (of type `bool`, which defaults to `false`): Use json5 extended spec.
- `(unlabeled)` (of type `'a`)

### `list.mem_assoc`

Deprecated: use `list.assoc.mem` instead

Type:

```
('a, ['a * 'b]) -> bool where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `anything that is an orderable type`)
- `(unlabeled)` (of type `['a * 'b] where 'a is an orderable type`)

### `localtime`

Deprecated: use `time.local` instead

Type:

```
(float?) -> unit
```

Arguments:

- `(unlabeled)` (of type `float?`)

Methods:

- `day` (of type `int`): Day of month.
- `dst` (of type `bool`): Daylight time savings in effect.
- `hour` (of type `int`): Hours.
- `min` (of type `int`): Minutes.
- `month` (of type `int`): Month of year.
- `sec` (of type `int`): Seconds.
- `week_day` (of type `int`): Day of week (Sunday is 0 or 7, Saturday is 6).
- `year` (of type `int`): Year.
- `year_day` (of type `int`): Day of year, between `1` and `366`.

### `map_metadata`

Deprecated: use metadata.map

Type:

```
(?id : string?, ?update : bool, ?strip : bool, ?insert_missing : bool,
 (([string * string]) -> [string * string]), source('a)) -> source('a)
where 'a is a set of tracks to be muxed into a source
```

Arguments:

- `id` (of type `string?`, which defaults to `"metadata.map"`)
- `update` (of type `bool`, which defaults to `true`)
- `strip` (of type `bool`, which defaults to `false`)
- `insert_missing` (of type `bool`, which defaults to `true`)
- `(unlabeled)` (of type `([string * string]) -> [string * string]`)
- `(unlabeled)` (of type `source('a) where 'a is a set of tracks to be muxed into a source`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `merge_tracks`

Deprecated: use `source.tracks` and `source`

Type:

```
(?id : string?, source('a)) -> source('a)
where 'a is a set of tracks to be muxed into a source
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `(unlabeled)` (of type `source('a) where 'a is a set of tracks to be muxed into a source`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `mkavailable`

Deprecated: use `source.available` instead.

Type:

```
(?id : string, ?track_sensitive : {bool}, ?active : {bool},
 ?available : {bool}, source('a)) -> source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `"mkavailable"`)
- `track_sensitive` (of type `{bool}`, which defaults to `true`)
- `active` (of type `{bool}`, which defaults to `false`)
- `available` (of type `{bool}`, which defaults to `true`)
- `(unlabeled)` (of type `source('a)`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `selected` (of type `() -> source('A)?`): Currently selected source.
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `mux_audio`

Deprecated: use `source.mux.audio`.

Type:

```
(?id : string?, audio : source(audio='A, 'B), source('a)) -> source(audio='A,
'a) where 'a is a set of tracks to be muxed into a source, 'A is a track
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `audio` (of type `source(audio='B, 'A) where 'B is a track`)
- `(unlabeled)` (of type `source('a) where 'a is a set of tracks to be muxed into a source`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `mux_midi`

Deprecated: use `source.mux.midi`

Type:

```
(?id : string?, midi : source(midi='A, 'B), source('a)) -> source(midi='A,
'a) where 'a is a set of tracks to be muxed into a source, 'A is a track
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `midi` (of type `source(midi='B, 'A) where 'B is a track`)
- `(unlabeled)` (of type `source('a) where 'a is a set of tracks to be muxed into a source`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `mux_video`

Deprecated: use `source.mux.video`.

Type:

```
(?id : string?, video : source(video='A, 'B), source('a)) -> source(video='A,
'a) where 'a is a set of tracks to be muxed into a source, 'A is a track
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `video` (of type `source(video='B, 'A) where 'B is a track`)
- `(unlabeled)` (of type `source('a) where 'a is a set of tracks to be muxed into a source`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `of_json`

Deprecated: use `json.parse` instead

Type:

```
(default : 'a, string) -> 'a
```

Arguments:

- `default` (of type `'a`): Default value if string cannot be parsed.
- `(unlabeled)` (of type `string`)

### `on_blank`

Deprecated: use `blank.detect` instead

Type:

```
(?id : string?, ?max_blank : {float}, ?min_noise : {float},
 ?on_noise : (() -> unit), ?start_blank : bool, ?threshold : {float},
 ?track_sensitive : {bool}, (() -> unit), source(audio=pcm('a), 'b)) ->
source(audio=pcm('a), 'b)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `max_blank` (of type `{float}`, which defaults to `20.`)
- `min_noise` (of type `{float}`, which defaults to `0.`)
- `on_noise` (of type `() -> unit`, which defaults to `{()}`)
- `start_blank` (of type `bool`, which defaults to `false`)
- `threshold` (of type `{float}`, which defaults to `-40.`)
- `track_sensitive` (of type `{bool}`, which defaults to `true`)
- `(unlabeled)` (of type `() -> unit`)
- `(unlabeled)` (of type `source(audio=pcm('a), 'b)`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `dB_levels` (of type `() -> [float]?`): Return the detected dB level for each channel.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_blank` (of type `() -> bool`): Indicate whether blank was detected.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `on_end`

Deprecated: use `source.on_end` instead.

Type:

```
(?id : string?, ?delay : {float}, source('a),
 ((float, [string * string]) -> unit)) -> source('a)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `delay` (of type `{float}`, which defaults to `5.`)
- `(unlabeled)` (of type `source('a)`)
- `(unlabeled)` (of type `(float, [string * string]) -> unit`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `out`

Deprecated: use `output` instead.

Type:

```
(source(audio=pcm('A))) -> unit
```

Arguments:

- `(unlabeled)` (of type `source(audio=pcm('A))`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `shutdown` (of type `() -> unit`): Shutdown the output or source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `output.preferred`



Type:

```
(?id : string?, ?fallible : bool, ?on_start : (() -> unit),
 ?on_stop : (() -> unit), ?start : bool, source(audio=pcm('A))) -> unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `fallible` (of type `bool`, which defaults to `false`)
- `on_start` (of type `() -> unit`, which defaults to `{()}`)
- `on_stop` (of type `() -> unit`, which defaults to `{()}`)
- `start` (of type `bool`, which defaults to `true`)
- `(unlabeled)` (of type `source(audio=pcm('A))`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_started` (of type `() -> bool`): `true` if the output or source is started.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `shutdown` (of type `() -> unit`): Shutdown the output or source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `start` (of type `() -> unit`): Ask the source or output to start.
- `stop` (of type `() -> unit`): Ask the source or output to stop.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `playlist.once`

Deprecated: this function has been replaced with `playlist`, setting `reload_mode` argument to `"never"` and `loop` to `false`.

Type:

```
(?id : string?, ?random : bool, ?reload_mode : string, ?prefetch : int?,
 ?filter : ((request) -> bool), string) -> source('a)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `random` (of type `bool`, which defaults to `false`)
- `reload_mode` (of type `string`, which defaults to `""`)
- `prefetch` (of type `int?`, which defaults to `null`)
- `filter` (of type `(request) -> bool`, which defaults to `fun (_) -> true`)
- `(unlabeled)` (of type `string`)

Methods:

- `add` (of type `(request) -> bool`): Add a request to the queue. Requests are resolved before being added. Returns `true` if the request was successfully added.
- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `current` (of type `() -> request?`): Get the request currently being played.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `fetch` (of type `() -> bool`): Try feeding the queue with a new request. Returns `true` if successful. This method can take long to return and should usually be run in a separate thread.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `length` (of type `() -> int`): 
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `queue` (of type `() -> [request]`): Get the requests currently in the queue.
- `reload` (of type `(?empty_queue : bool, ?uri : string?) -> unit`): 
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `remaining_files` (of type `() -> [string]`): 
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `set_queue` (of type `([request]) -> unit`): Set the queue of requests. Requests are resolved before being added to the queue. You are responsible for destroying the requests currently in the queue.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `playlist.reloadable`

Deprecated: use `playlist` instead

Type:

```
(?id : string?, ?mime_type : string, ?mode : string,
 ?on_track : (() -> unit), ?prefix : string, ?reload : int,
 ?reload_mode : string, string) -> source('a)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `mime_type` (of type `string`, which defaults to `""`)
- `mode` (of type `string`, which defaults to `"randomize"`)
- `on_track` (of type `() -> unit`, which defaults to `{()}`)
- `prefix` (of type `string`, which defaults to `""`)
- `reload` (of type `int`, which defaults to `0`)
- `reload_mode` (of type `string`, which defaults to `"seconds"`)
- `(unlabeled)` (of type `string`)

Methods:

- `add` (of type `(request) -> bool`): Add a request to the queue. Requests are resolved before being added. Returns `true` if the request was successfully added.
- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `current` (of type `() -> request?`): Get the request currently being played.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `fetch` (of type `() -> bool`): Try feeding the queue with a new request. Returns `true` if successful. This method can take long to return and should usually be run in a separate thread.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `length` (of type `() -> int`): 
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `queue` (of type `() -> [request]`): Get the requests currently in the queue.
- `reload` (of type `(?empty_queue : bool, ?uri : string?) -> unit`): 
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `remaining_files` (of type `() -> [string]`): 
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `set_queue` (of type `([request]) -> unit`): Set the queue of requests. Requests are resolved before being added to the queue. You are responsible for destroying the requests currently in the queue.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `playlist.safe`

Deprecated: use mksafe and playlist instead.

Type:

```
(?id : string?, ?mime_type : string, ?mode : string,
 ?on_track : (() -> unit), ?prefix : string, ?reload : int,
 ?reload_mode : string, string) -> source('a)
where 'a is a set of internal tracks
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `mime_type` (of type `string`, which defaults to `""`)
- `mode` (of type `string`, which defaults to `"randomize"`)
- `on_track` (of type `() -> unit`, which defaults to `{()}`)
- `prefix` (of type `string`, which defaults to `""`)
- `reload` (of type `int`, which defaults to `0`)
- `reload_mode` (of type `string`, which defaults to `"seconds"`)
- `(unlabeled)` (of type `string`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `selected` (of type `() -> source('A)? where 'A is a set of internal tracks`): Currently selected source.
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `quote`

Deprecated: this function has been replaced by `string.quote`.

Type:

```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `request.create.raw`

Deprecated: use `request.create` instead.

Type:

```
(?indicators : [string], ?cue_in_metadata : string?,
 ?cue_out_metadata : string?, ?persistent : bool, ?resolve_metadata : bool,
 ?excluded_metadata_resolvers : [string], ?temporary : bool, string) ->
request
```

Arguments:

- `indicators` (of type `[string]`, which defaults to `[]`)
- `cue_in_metadata` (of type `string?`, which defaults to `"liq_cue_in"`)
- `cue_out_metadata` (of type `string?`, which defaults to `"liq_cue_out"`)
- `persistent` (of type `bool`, which defaults to `false`)
- `resolve_metadata` (of type `bool`, which defaults to `true`)
- `excluded_metadata_resolvers` (of type `[string]`, which defaults to `[]`)
- `temporary` (of type `bool`, which defaults to `false`)
- `(unlabeled)` (of type `string`)

### `request.dynamic.list`

Deprecated: use `request.dynamic` instead

Type:

```
(?id : string?, ?available : {bool}, ?prefetch : int?,
 ?retry_delay : {float}, ?timeout : float, (() -> [request])) -> source('a)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `available` (of type `{bool}`, which defaults to `true`)
- `prefetch` (of type `int?`, which defaults to `null`)
- `retry_delay` (of type `{float}`, which defaults to `0.1`)
- `timeout` (of type `float`, which defaults to `20.`)
- `(unlabeled)` (of type `() -> [request]`)

Methods:

- `add` (of type `(request) -> bool`): Add a request to the queue. Requests are resolved before being added. Returns `true` if the request was successfully added.
- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `current` (of type `() -> request?`): Get the request currently being played.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `fetch` (of type `() -> bool`): Try feeding the queue with a new request. Returns `true` if successful. This method can take long to return and should usually be run in a separate thread.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `queue` (of type `() -> [request]`): Get the requests currently in the queue.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `set_queue` (of type `([request]) -> unit`): Set the queue of requests. Requests are resolved before being added to the queue. You are responsible for destroying the requests currently in the queue.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `request.ready`

Deprecated: use `request.resolved`

Type:

```
(request) -> bool
```

Arguments:

- `(unlabeled)` (of type `request`)

### `rewrite_metadata`

Deprecated: this function has been replaced by `metadata.map`.

Type:

```
([string * string], ?insert_missing : bool, ?update : bool, ?strip : bool,
 source('a)) -> source('a)
where 'a is a set of tracks to be muxed into a source
```

Arguments:

- `(unlabeled)` (of type `[string * string]`)
- `insert_missing` (of type `bool`, which defaults to `true`)
- `update` (of type `bool`, which defaults to `true`)
- `strip` (of type `bool`, which defaults to `false`)
- `(unlabeled)` (of type `source('a) where 'a is a set of tracks to be muxed into a source`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `run_process`

Deprecated: use `process.run` instead

Type:

```
(?env : [string * string], ?inherit_env : bool, ?rwdirs : [string],
 ?rodirs : [string], ?network : bool?, ?timeout : float?, string) ->
string * string * (string * string)
```

Arguments:

- `env` (of type `[string * string]`, which defaults to `[]`)
- `inherit_env` (of type `bool`, which defaults to `true`)
- `rwdirs` (of type `[string]`, which defaults to `["default"]`)
- `rodirs` (of type `[string]`, which defaults to `["default"]`)
- `network` (of type `bool?`, which defaults to `null`)
- `timeout` (of type `float?`, which defaults to `null`)
- `(unlabeled)` (of type `string`)

### `say_metadata`

Deprecated: use `source.say_metadata` instead

Type:

```
(source('a), pattern : string) -> source('a)
```

Arguments:

- `(unlabeled)` (of type `source('a)`)
- `pattern` (of type `string`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `cancel_pending` (of type `() -> unit`): Cancel any pending appended source.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `(?cancel_pending : bool) -> unit`): Skip the current track. Pending appended source are cancelled by default. Pass `cancel_pending=false` to keep it.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `setenv`

Deprecated: use `environment.set`

Type:

```
(string, string) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`)
- `(unlabeled)` (of type `string`)

### `skip_blank`

Deprecated: use `blank.skip` instead

Type:

```
(?id : string?, ?threshold : float, ?max_blank : float, ?min_noise : float,
 ?track_sensitive : bool, source(audio=pcm('a), 'b).{skip : () -> unit}) ->
source(audio=pcm('a), 'b)
```

Arguments:

- `id` (of type `string?`, which defaults to `"blank.skip"`)
- `threshold` (of type `float`, which defaults to `-40.`)
- `max_blank` (of type `float`, which defaults to `20.`)
- `min_noise` (of type `float`, which defaults to `0.`)
- `track_sensitive` (of type `bool`, which defaults to `true`)
- `(unlabeled)` (of type `source(audio=pcm('a), 'b).{skip : () -> unit}`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `dB_levels` (of type `() -> [float]?`): Return the detected dB level for each channel.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_blank` (of type `() -> bool`): Indicate whether blank was detected.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `sleep`

Deprecated: use `thread.pause`

Type:

```
(float) -> unit
```

Arguments:

- `(unlabeled)` (of type `float`)

### `string.utf8.escape`

Deprecated: this function has been replaced by `string.escape`.

Type:

```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `string_of`

Deprecated: use `string`.

Type:

```
('a) -> string
```

Arguments:

- `(unlabeled)` (of type `'a`)

### `string_of_float`

Deprecated: use `string.float`.

Type:

```
(float) -> string
```

Arguments:

- `(unlabeled)` (of type `float`)

### `strip_blank`

Deprecated: use `blank.strip` instead

Type:

```
(?id : string?, ?max_blank : {float}, ?min_noise : {float},
 ?start_blank : bool, ?threshold : {float}, ?track_sensitive : {bool},
 source(audio=pcm('a), 'b)) -> source(audio=pcm('a), 'b)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `max_blank` (of type `{float}`, which defaults to `20.`)
- `min_noise` (of type `{float}`, which defaults to `0.`)
- `start_blank` (of type `bool`, which defaults to `false`)
- `threshold` (of type `{float}`, which defaults to `-40.`)
- `track_sensitive` (of type `{bool}`, which defaults to `true`)
- `(unlabeled)` (of type `source(audio=pcm('a), 'b)`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `dB_levels` (of type `() -> [float]?`): Return the detected dB level for each channel.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_blank` (of type `() -> bool`): Indicate whether blank was detected.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `system`

Deprecated: use `process.run` instead.

Type:

```
(string) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`)

Methods:

- `status` (of type `string.{code : int, description : string}`): Status when process ended, can be one of `"exit"` (the program exited, the `status` code is then relevant), `"killed"` (the program was killed by signal given in `status` code), `"stopped"` (the program was stopped by signal given in `status` code) or `"exception"` (the program raised and exception detailed in the `description`).
- `stderr` (of type `string`): Messages written by process on standard error stream.
- `stdout` (of type `string`): Messages written by process on standard output stream.

### `test_process`

Deprecated: use `process.test` instead.

Type:

```
(?timeout : float, ?env : [string * string], ?inherit_env : bool, string) ->
bool
```

Arguments:

- `timeout` (of type `float`, which defaults to `-1.`)
- `env` (of type `[string * string]`, which defaults to `[]`)
- `inherit_env` (of type `bool`, which defaults to `true`)
- `(unlabeled)` (of type `string`)

### `video.line`

Deprecated: use `video.add_line`.

Type:

```
(?id : string?, ?alpha : {float}, ?color : {int}, {int * int}, {int * int},
 source(video=canvas('a), 'b)) -> source(video=canvas('a), 'b)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `alpha` (of type `{float}`, which defaults to `1.`)
- `color` (of type `{int}`, which defaults to `0`)
- `(unlabeled)` (of type `{int * int}`)
- `(unlabeled)` (of type `{int * int}`)
- `(unlabeled)` (of type `source(video=canvas('a), 'b)`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `video.rectangle`

Deprecated: use `video.add_rectangle`.

Type:

```
(?id : string?, ?alpha : {float}, ?color : {int}, height : {int},
 width : {int}, ?x : {int}, ?y : {int}, source(video=canvas('a), 'b)) ->
source(video=canvas('a), 'b)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `alpha` (of type `{float}`, which defaults to `1.`)
- `color` (of type `{int}`, which defaults to `0`)
- `height` (of type `{int}`)
- `width` (of type `{int}`)
- `x` (of type `{int}`, which defaults to `0`)
- `y` (of type `{int}`, which defaults to `0`)
- `(unlabeled)` (of type `source(video=canvas('a), 'b)`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `video.transparent`

Deprecated: use `video.alpha.of_color`

Type:

```
(?id : string?, ?color : int, ?precision : float, source(video=canvas('a),
 'b)) -> source(video=canvas('a), 'b)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)
- `color` (of type `int`, which defaults to `0`)
- `precision` (of type `float`, which defaults to `0.2`)
- `(unlabeled)` (of type `source(video=canvas('a), 'b)`)

Methods:

- `buffered` (of type `() -> [string * float]`): Length of buffered data.
- `duration` (of type `() -> float`): Estimation of the duration of the current track.
- `elapsed` (of type `() -> float`): Elapsed time in the current track.
- `fallible` (of type `bool`): Indicate if a source may fail, i.e. may not be ready to stream.
- `id` (of type `() -> string`): Identifier of the source.
- `is_active` (of type `() -> bool`): `true` if the source is active, i.e. it is continuously animated by its own clock whenever it is ready. Typically, `true` for outputs and sources such as `input.http`.
- `is_ready` (of type `() -> bool`): Indicate if a source is ready to stream. This does not mean that the source is currently streaming, just that its resources are all properly initialized.
- `is_up` (of type `() -> bool`): Indicate that the source can be asked to produce some data at any time. This is `true` when the source is currently being used or if it could be used at any time, typically inside a `switch` or `fallback`.
- `last_metadata` (of type `() -> [string * string]?`): Return the last metadata from the source.
- `log` (of type `{level : (() -> int?).{set : (int) -> unit}}`): Get or set the source's log level, from `1` to `5`.
- `on_metadata` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on metadata packets.
- `on_shutdown` (of type `((() -> unit)) -> unit`): Register a function to be called when source shuts down.
- `on_track` (of type `((([string * string]) -> unit)) -> unit`): Call a given handler on new tracks.
- `on_wake_up` (of type `((() -> unit)) -> unit`): Register a function to be called after the source is asked to get ready. This is when, for instance, the source's final ID is set.
- `remaining` (of type `() -> float`): Estimation of remaining time in the current track.
- `seek` (of type `(float) -> float`): Seek forward, in seconds (returns the amount of time effectively seeked).
- `self_sync` (of type `() -> bool`): Is the source currently controlling its own real-time loop.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `which`

Deprecated: this function has been replaced by `file.which`.

Type:

```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

