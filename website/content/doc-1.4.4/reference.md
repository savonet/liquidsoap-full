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
(bool, bool) -> bool
```

Arguments:

- `(unlabeled)` (of type `bool`)
- `(unlabeled)` (of type `bool`)

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
(bool, bool) -> bool
```

Arguments:

- `(unlabeled)` (of type `bool`)
- `(unlabeled)` (of type `bool`)

### `random.bool`

Generate a random value.

Type:
```
() -> bool
```

Arguments:


## Control

### `add_timeout`

Call a function in N seconds. If the result of the function is positive or null, the task will be scheduled again after this amount of time (in seconds).

Type:
```
(?fast : bool, float, (() -> float)) -> unit
```

Arguments:

- `fast` (of type `bool`, which defaults to `true`): Set to `false` if the execution of the code can take long in order to lower its priority below that of request resolutions and fast timeouts. This is only effective if you set a dedicated queue for fast tasks, see the "scheduler" settings for more details.
- `(unlabeled)` (of type `float`)
- `(unlabeled)` (of type `() -> float`)

### `ignore`

Convert anything to unit, preventing warnings.

Type:
```
('a) -> unit
```

Arguments:

- `(unlabeled)` (of type `'a`)

## Interaction

### `add_skip_command`

Add a skip function to a source when it does not have one by default.

Type:
```
(source('a)) -> unit
```

Arguments:

- `(unlabeled)` (of type `source('a)`): The source to attach the command to.

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

- `source` (of type `string`, which defaults to `"broadcast"`): Source for tracks. Should be one of: "broadcast", "user", "recommendation" or "unknown". Since liquidsoap is intented for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
- `user` (of type `string`)
- `password` (of type `string`)
- `host` (of type `string`, which defaults to `"post.audioscrobbler.com"`): Host for audioscrobbling submissions.
- `port` (of type `int`, which defaults to `80`): Port for audioscrobbling submissions.
- `length` (of type `bool`, which defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the "user" source type.
- `(unlabeled)` (of type `[string * string]`)

### `audioscrobbler.submit.full`

Submit songs using audioscrobbler, respecting the full protocol: First signal song as now playing when starting, and then submit song when it ends.

Type:
```
(user : string, password : string, ?host : string,
 ?port : int, ?source : string, ?length : bool,
 ?delay : float, ?force : bool, source('a)) -> source('a)
```

Arguments:

- `user` (of type `string`)
- `password` (of type `string`)
- `host` (of type `string`, which defaults to `"post.audioscrobbler.com"`)
- `port` (of type `int`, which defaults to `80`)
- `source` (of type `string`, which defaults to `"broadcast"`): Source for tracks. Should be one of: "broadcast", "user", "recommendation" or "unknown". Since liquidsoap is intented for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
- `length` (of type `bool`, which defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the "user" source type.
- `delay` (of type `float`, which defaults to `10.0`): Submit song when there is only this delay left, in seconds. 
- `force` (of type `bool`, which defaults to `false`): If remaining time is null, the song will be assumed to be skipped or cuted, and not submitted. Set to zero to disable this behaviour.
- `(unlabeled)` (of type `source('a)`)

### `harbor.http.static`

Serve a static path

Type:
```
(?port : int, ?path : string,
 ?content_type : ((string) -> string),
 ?headers : [string * string], string) -> unit
```

Arguments:

- `port` (of type `int`, which defaults to `8000`): Port for incoming harbor (http) connections.
- `path` (of type `string`, which defaults to `"/"`): Base path
- `content_type` (of type `(string) -> string`, which defaults to `<fun>`): Callback to specify Content-Type on a per file basis. Default: file.mime if compiled or file CLI if present.
- `headers` (of type `[string * string]`, which defaults to `[("Access-Control-Allow-Origin", "*")]`): Default response headers.
- `(unlabeled)` (of type `string`): Local path to be served

### `harbor.https.static`

Serve a static path

Type:
```
(?port : int, ?path : string,
 ?content_type : ((string) -> string),
 ?headers : [string * string], string) -> unit
```

Arguments:

- `port` (of type `int`, which defaults to `8000`): Port for incoming harbor (https) connections.
- `path` (of type `string`, which defaults to `"/"`): Base path
- `content_type` (of type `(string) -> string`, which defaults to `<fun>`): Callback to specify Content-Type on a per file basis. Default: file.mime if compiled or file CLI if present.
- `headers` (of type `[string * string]`, which defaults to `[("Access-Control-Allow-Origin", "*")]`): Default response headers.
- `(unlabeled)` (of type `string`): Local path to be served

### `http.delete`

Perform a full Http DELETE request and return `(status,headers,data)`.

Type:
```
(?headers : [string * string], ?http_version : string,
 ?timeout : float, string) ->
(string * int * string) * [string * string] * string
```

Arguments:

- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `http_version` (of type `string`, which defaults to `"1.0"`): Http request version.
- `timeout` (of type `float`, which defaults to `10.0`): Timeout for network operations.
- `(unlabeled)` (of type `string`): Requested URL, e.g. "http://www.google.com:80/index.html".

### `http.get`

Perform a full Http GET request and return `(status,headers,data)`.

Type:
```
(?headers : [string * string], ?http_version : string,
 ?timeout : float, string) ->
(string * int * string) * [string * string] * string
```

Arguments:

- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `http_version` (of type `string`, which defaults to `"1.0"`): Http request version.
- `timeout` (of type `float`, which defaults to `10.0`): Timeout for network operations.
- `(unlabeled)` (of type `string`): Requested URL, e.g. "http://www.google.com:80/index.html".

### `http.head`

Perform a full Http HEAD request and return `(status,headers,data)`.

Type:
```
(?headers : [string * string], ?http_version : string,
 ?timeout : float, string) ->
(string * int * string) * [string * string] * string
```

Arguments:

- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `http_version` (of type `string`, which defaults to `"1.0"`): Http request version.
- `timeout` (of type `float`, which defaults to `10.0`): Timeout for network operations.
- `(unlabeled)` (of type `string`): Requested URL, e.g. "http://www.google.com:80/index.html".

### `http.post`

Perform a full Http POST request and return `(status,headers,data)`.

Type:
```
(?data : string, ?headers : [string * string],
 ?http_version : string, ?timeout : float, string) ->
(string * int * string) * [string * string] * string
```

Arguments:

- `data` (of type `string`, which defaults to `""`): POST data.
- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `http_version` (of type `string`, which defaults to `"1.0"`): Http request version.
- `timeout` (of type `float`, which defaults to `10.0`): Timeout for network operations.
- `(unlabeled)` (of type `string`): Requested URL, e.g. "http://www.google.com:80/index.html".

### `http.put`

Perform a full Http PUT request and return `(status,headers,data)`.

Type:
```
(?data : string, ?headers : [string * string],
 ?http_version : string, ?timeout : float, string) ->
(string * int * string) * [string * string] * string
```

Arguments:

- `data` (of type `string`, which defaults to `""`): POST data.
- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `http_version` (of type `string`, which defaults to `"1.0"`): Http request version.
- `timeout` (of type `float`, which defaults to `10.0`): Timeout for network operations.
- `(unlabeled)` (of type `string`): Requested URL, e.g. "http://www.google.com:80/index.html".

### `http_codes`

List of HTTP response codes and statuses.

Type:
```
[string * string]
```

Arguments:


### `http_response`

Create a HTTP response string

Type:
```
(?protocol : string, ?code : int,
 ?headers : [string * string], ?data : string) ->
() -> string
```

Arguments:

- `protocol` (of type `string`, which defaults to `"HTTP/1.1"`): HTTP protocol used.
- `code` (of type `int`, which defaults to `200`): Response code.
- `headers` (of type `[string * string]`, which defaults to `[]`): Response headers.
- `data` (of type `string`, which defaults to `""`): Response data

### `http_response_stream`

Create a streamed HTTP response

Type:
```
(?protocol : string, ?code : int,
 ?headers : [string * string], data_len : 'a,
 data : (() -> string)) -> () -> string
```

Arguments:

- `protocol` (of type `string`, which defaults to `"HTTP/1.1"`): HTTP protocol used.
- `code` (of type `int`, which defaults to `200`): Response code.
- `headers` (of type `[string * string]`, which defaults to `[]`): Response headers.
- `data_len` (of type `'a`): Response length in bytes
- `data` (of type `() -> string`): Response data

### `https.delete`

Perform a full https DELETE request and return (status,headers),data.

Type:
```
(?headers : [string * string], ?http_version : string,
 ?timeout : float, string) ->
(string * int * string) * [string * string] * string
```

Arguments:

- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `http_version` (of type `string`, which defaults to `"1.0"`): Http request version.
- `timeout` (of type `float`, which defaults to `10.0`): Timeout for network operations.
- `(unlabeled)` (of type `string`): Requested URL, e.g. "http://www.google.com:80/index.html".

### `https.get`

Perform a full https GET request and return (status,headers),data.

Type:
```
(?headers : [string * string], ?http_version : string,
 ?timeout : float, string) ->
(string * int * string) * [string * string] * string
```

Arguments:

- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `http_version` (of type `string`, which defaults to `"1.0"`): Http request version.
- `timeout` (of type `float`, which defaults to `10.0`): Timeout for network operations.
- `(unlabeled)` (of type `string`): Requested URL, e.g. "http://www.google.com:80/index.html".

### `https.head`

Perform a full https HEAD request and return (status,headers),data.

Type:
```
(?headers : [string * string], ?http_version : string,
 ?timeout : float, string) ->
(string * int * string) * [string * string] * string
```

Arguments:

- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `http_version` (of type `string`, which defaults to `"1.0"`): Http request version.
- `timeout` (of type `float`, which defaults to `10.0`): Timeout for network operations.
- `(unlabeled)` (of type `string`): Requested URL, e.g. "http://www.google.com:80/index.html".

### `https.post`

Perform a full https POST request and return (status,headers),data.

Type:
```
(?data : string, ?headers : [string * string],
 ?http_version : string, ?timeout : float, string) ->
(string * int * string) * [string * string] * string
```

Arguments:

- `data` (of type `string`, which defaults to `""`): POST data.
- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `http_version` (of type `string`, which defaults to `"1.0"`): Http request version.
- `timeout` (of type `float`, which defaults to `10.0`): Timeout for network operations.
- `(unlabeled)` (of type `string`): Requested URL, e.g. "http://www.google.com:80/index.html".

### `https.put`

Perform a full https PUT request and return (status,headers),data.

Type:
```
(?data : string, ?headers : [string * string],
 ?http_version : string, ?timeout : float, string) ->
(string * int * string) * [string * string] * string
```

Arguments:

- `data` (of type `string`, which defaults to `""`): POST data.
- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `http_version` (of type `string`, which defaults to `"1.0"`): Http request version.
- `timeout` (of type `float`, which defaults to `10.0`): Timeout for network operations.
- `(unlabeled)` (of type `string`): Requested URL, e.g. "http://www.google.com:80/index.html".

### `icy.update_metadata`

Update metata on an icecast mountpoint using the ICY protocol.

Type:
```
(?host : string, ?port : int, ?user : string,
 ?password : string, ?mount : string, ?icy_id : int,
 ?protocol : string, ?encoding : string,
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
- `encoding` (of type `string`, which defaults to `""`): Encoding used to send metadata, default (UTF-8) if empty.
- `headers` (of type `[string * string]`, which defaults to `[("User-Agent", "Liquidsoap/1.4.4 (Unix; OCaml 4.10.0)")]`): Additional headers.
- `(unlabeled)` (of type `[string * string]`)

### `interactive.bool`

Read a boolean from an interactive input.

Type:
```
(string, bool) -> () -> bool
```

Arguments:

- `(unlabeled)` (of type `string`)
- `(unlabeled)` (of type `bool`)

### `interactive.float`

Read a float from an interactive input.

Type:
```
(string, float) -> () -> float
```

Arguments:

- `(unlabeled)` (of type `string`)
- `(unlabeled)` (of type `float`)

### `interactive.string`

Read a string from an interactive input.

Type:
```
(string, string) -> () -> string
```

Arguments:

- `(unlabeled)` (of type `string`)
- `(unlabeled)` (of type `string`)

### `lastfm.nowplaying`

Submit metadata to lastfm.fm using the audioscrobbler protocol (nowplaying mode).

Type:
```
(user : string, password : string, ?length : bool,
 [string * string]) -> unit
```

Arguments:

- `user` (of type `string`)
- `password` (of type `string`)
- `length` (of type `bool`, which defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the "user" source type.
- `(unlabeled)` (of type `[string * string]`)

### `lastfm.submit`

Submit metadata to lastfm.fm using the audioscrobbler protocol.

Type:
```
(user : string, password : string, ?source : string,
 ?length : bool, [string * string]) -> unit
```

Arguments:

- `user` (of type `string`)
- `password` (of type `string`)
- `source` (of type `string`, which defaults to `"broadcast"`): Source for tracks. Should be one of: "broadcast", "user", "recommendation" or "unknown". Since liquidsoap is intented for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
- `length` (of type `bool`, which defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the "user" source type.
- `(unlabeled)` (of type `[string * string]`)

### `lastfm.submit.full`

Submit songs to lastfm using audioscrobbler, respecting the full protocol: First signal song as now playing when starting, and then submit song when it ends.

Type:
```
(user : string, password : string, ?source : string,
 ?length : bool, ?delay : float, ?force : bool,
 source('a)) -> source('a)
```

Arguments:

- `user` (of type `string`)
- `password` (of type `string`)
- `source` (of type `string`, which defaults to `"broadcast"`): Source for tracks. Should be one of: "broadcast", "user", "recommendation" or "unknown". Since liquidsoap is intented for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
- `length` (of type `bool`, which defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the "user" source type.
- `delay` (of type `float`, which defaults to `10.0`): Submit song when there is only this delay left, in seconds. If remaining time is less than this value, the song will be assumed to be skipped or cuted, and not submitted. Set to zero to disable this behaviour.
- `force` (of type `bool`, which defaults to `false`): If remaining time is null, the song will be assumed to be skipped or cuted, and not submitted. Set to zero to disable this behaviour.
- `(unlabeled)` (of type `source('a)`)

### `librefm.nowplaying`

Submit metadata to libre.fm using the audioscrobbler protocol (nowplaying mode).

Type:
```
(user : string, password : string, ?length : bool,
 [string * string]) -> unit
```

Arguments:

- `user` (of type `string`)
- `password` (of type `string`)
- `length` (of type `bool`, which defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the "user" source type.
- `(unlabeled)` (of type `[string * string]`)

### `librefm.submit`

Submit metadata to libre.fm using the audioscrobbler protocol.

Type:
```
(user : string, password : string, ?source : string,
 ?length : bool, [string * string]) -> unit
```

Arguments:

- `user` (of type `string`)
- `password` (of type `string`)
- `source` (of type `string`, which defaults to `"broadcast"`): Source for tracks. Should be one of: "broadcast", "user", "recommendation" or "unknown". Since liquidsoap is intented for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
- `length` (of type `bool`, which defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the "user" source type.
- `(unlabeled)` (of type `[string * string]`)

### `librefm.submit.full`

Submit songs to librefm using audioscrobbler, respecting the full protocol: First signal song as now playing when starting, and then submit song when it ends.

Type:
```
(user : string, password : string, ?source : string,
 ?length : bool, ?delay : float, ?force : bool,
 source('a)) -> source('a)
```

Arguments:

- `user` (of type `string`)
- `password` (of type `string`)
- `source` (of type `string`, which defaults to `"broadcast"`): Source for tracks. Should be one of: "broadcast", "user", "recommendation" or "unknown". Since liquidsoap is intented for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
- `length` (of type `bool`, which defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the "user" source type.
- `delay` (of type `float`, which defaults to `10.0`): Submit song when there is only this delay left, in seconds. If remaining time is less than this value, the song will be assumed to be skipped or cuted, and not submitted. Set to zero to disable this behaviour.
- `force` (of type `bool`, which defaults to `false`): If remaining time is null, the song will be assumed to be skipped or cuted, and not submitted. Set to zero to disable this behaviour.
- `(unlabeled)` (of type `source('a)`)

### `metadata.float_getter`

Create a float getter from a metadata: this is a float, whose value can be changed with a metadata.

Type:
```
(float, string, source('a)) -> source('a) * (() -> float)
```

Arguments:

- `(unlabeled)` (of type `float`): Initial value.
- `(unlabeled)` (of type `string`): Metadata on which the value should be updated.
- `(unlabeled)` (of type `source('a)`): Source containing the metadata.

### `metadata.string_getter`

Create a string getter from a metadata: this is a string, whose value can be changed with a metadata.

Type:
```
(string, string, source('a)) ->
source('a) * (() -> string)
```

Arguments:

- `(unlabeled)` (of type `string`): Initial value.
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

### `server.broadcast`

Restart all server clients waiting on the given condition

Type:
```
(('a * ('b * (() -> 'c)))) -> 'c
```

Arguments:

- `(unlabeled)` (of type `'a * ('b * (() -> 'c))`): condition

### `server.condition`

Create a pair of functions `(wait,(signal,broadcast))` used to suspend and resume server command execution. Used to write interactive server commands through `server.wait`, `server.signal`, `server.broadcast` and `server.write`.

Type:
```
() ->
(((() -> string)) -> string) *
((() -> unit) * (() -> unit))
```

Arguments:


### `server.read`

Read a string from the client up-to a marker. Marker can be any string of regular expression. Should be used via the syntactic sugar: `server.read <marker> : <varname> then <after> end`

Type:
```
(((string) -> string), string) -> string
```

Arguments:

- `(unlabeled)` (of type `(string) -> string`): function to run after write
- `(unlabeled)` (of type `string`): Read marker

### `server.readchars`

Read a string of fixed length from the client up-to a marker. Should be used via the syntactic sugar: `server.readchars <len> : <varname> then <after> end`

Type:
```
(((string) -> string), int) -> string
```

Arguments:

- `(unlabeled)` (of type `(string) -> string`): function to run after write
- `(unlabeled)` (of type `int`): Number of characters to read

### `server.readline`

Read a line from the client. Should be used via the syntactic sugar: `server.readline <varname> then <after> end`

Type:
```
(((string) -> string)) -> string
```

Arguments:

- `(unlabeled)` (of type `(string) -> string`): function to run after write

### `server.register`

Register a command. You can then execute this function through the server, either telnet or socket.

Type:
```
(?namespace : string, ?description : string,
 ?usage : string, string, ((string) -> string)) -> unit
```

Arguments:

- `namespace` (of type `string`, which defaults to `""`)
- `description` (of type `string`, which defaults to `"No documentation available."`): A description of your command.
- `usage` (of type `string`, which defaults to `""`)
- `(unlabeled)` (of type `string`)
- `(unlabeled)` (of type `(string) -> string`)

### `server.signal`

Restart one server client waiting on the given condition

Type:
```
(('a * ((() -> 'b) * 'c))) -> 'b
```

Arguments:

- `(unlabeled)` (of type `'a * ((() -> 'b) * 'c)`): condition

### `server.wait`

Wait on a server condition. Used to write interactive server command. Should be used via the syntactic sugar: `server.wait <condition> then <after> end`

Type:
```
(((((() -> string)) -> string) * 'a), (() -> string)) ->
string
```

Arguments:

- `(unlabeled)` (of type `(((() -> string)) -> string) * 'a`): condition
- `(unlabeled)` (of type `() -> string`): code to execute when resuming

### `server.write`

Execute a partial write while executing a server command. Should be used via the syntactic sugar: `server.write <string> then <after> end`

Type:
```
((() -> string), string) -> string
```

Arguments:

- `(unlabeled)` (of type `() -> string`): function to run after write
- `(unlabeled)` (of type `string`): string to write

## Liquidsoap

### `add_decoder`

Register an external decoder. The encoder should output in WAV format to his standard output (stdout) and read data from its standard input (stdin).

Type:
```
(name : string, description : string, ?mimes : [string],
 test : ((string) -> int), string) -> unit
```

Arguments:

- `name` (of type `string`): Format/decoder's name.
- `description` (of type `string`): Description of the decoder.
- `mimes` (of type `[string]`, which defaults to `[]`): List of mime types supported by this decoder for decoding streams.
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
 test : ((string) -> int), ?buffer : float,
 ((string) -> string)) -> unit
```

Arguments:

- `name` (of type `string`): Format/decoder's name.
- `description` (of type `string`): Description of the decoder.
- `test` (of type `(string) -> int`): Function used to determine if a file should be decoded by the decoder. Returned values are: 0: no decodable audio, -1: decodable audio but number of audio channels unknown, x: fixed number of decodable audio channels.
- `buffer` (of type `float`, which defaults to `5.0`)
- `(unlabeled)` (of type `(string) -> string`): Process to start. The function takes the filename as argument and returns the process to start.

### `add_playlist_parser`

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


### `bool_getter`

Identity function over bool getters. This is useful to make types explicit.

Type:
```
({bool}) -> {bool}
```

Arguments:

- `(unlabeled)` (of type `{bool}`)

### `clock`

Assign a new clock to the given source (and to other time-dependent sources) and return the source. It is a conveniency wrapper around clock.assign_new(), allowing more concise scripts in some cases.

Type:
```
(?sync : bool, ?id : string, source('a)) -> source('a)
```

Arguments:

- `sync` (of type `bool`, which defaults to `true`): When `false`, do not synchronize the clock on regular wallclock time, but try to run as fast as possible (CPU burning mode).
- `id` (of type `string`, which defaults to `""`)
- `(unlabeled)` (of type `source('a)`)

### `clock.assign_new`

Create a new clock and assign it to a list of sources.

Type:
```
(?id : string, ?sync : bool, [source('a)]) -> unit
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Identifier for the new clock. The default empty string means that the identifier of the first source will be used.
- `sync` (of type `bool`, which defaults to `true`): Do not synchronize the clock on regular wallclock time, but try to run as fast as possible (CPU burning mode).
- `(unlabeled)` (of type `[source('a)]`): List of sources to which the new clock will be assigned

### `clock.log`

Create a log of clock times for all the clocks initially present. The log is in a simple format which you can directly use with gnuplot.

Type:
```
(?delay : float, ?interval : float, string) -> unit
```

Arguments:

- `delay` (of type `float`, which defaults to `0.0`): Delay before setting up the clock logger. This should be used to ensure that the logger starts only after the clocks are created.
- `interval` (of type `float`, which defaults to `1.0`): Polling interval.
- `(unlabeled)` (of type `string`): Path of the log file.

### `clock.status`

Get the current time for all allocated clocks.

Type:
```
() -> [string * int]
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

Enable replay gain metadata resolver. This resolver will process any file decoded by liquidsoap and add a replay_gain metadata when this value could be computed. For a finer-grained replay gain processing, use the replay_gain protocol.

Type:
```
(?delay : float, ?extract_replaygain : string) -> unit
```

Arguments:

- `delay` (of type `float`, which defaults to `-1.0`): Maximum delay for extracting metadata
- `extract_replaygain` (of type `string`, which defaults to `"/usr/local/share/liquidsoap/1.4.4/bin/extract-replaygain"`): The extraction program

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

### `file.mime`

Get the MIME type of a file, according to libmagic.

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `float_getter`

Identity function over float getters. This is useful to make types explicit.

Type:
```
({float}) -> {float}
```

Arguments:

- `(unlabeled)` (of type `{float}`)

### `for`

A "for" loop: call multiple times a function with increasing integers as arguments, between specified bounds. For instance, `for(5, 8, f)` is equivalent to `f(5); f(6); f(7); f(8)`.

Type:
```
(int, int, ((int) -> unit)) -> unit
```

Arguments:

- `(unlabeled)` (of type `int`, which defaults to `???`): First number
- `(unlabeled)` (of type `int`, which defaults to `???`): Last number
- `(unlabeled)` (of type `(int) -> unit`, which defaults to `???`): Function to be called

### `garbage_collect`

Trigger full major garbage collection.

Type:
```
() -> unit
```

Arguments:


### `get`

Get a setting's value.

Type:
```
(default : 'a, string) -> 'a
where 'a is unit, bool, int, float, string or [string]
```

Arguments:

- `default` (of type `anything that is unit, bool, int, float, string or [string]`)
- `(unlabeled)` (of type `string`)

### `harbor.http.register`

Register a HTTP handler on the harbor. The given function receives as argument the full requested uri (e.g. "foo?var=bar"), http protocol version, possible input data and the list of HTTP headers and returns the answer sent to the client, including HTTP headers. Registered uri can be regular expressions (e.g. ".+\.php") and can override default metadata handlers. Response is a string getter, i.e. either of type `string` or type `()->string`. In the later case, getter function will be called until it returns an empty string.

Type:
```
(port : int, method : string, string,
 ((protocol : string, data : string,
   headers : [string * string], string) -> {string})) ->
unit
```

Arguments:

- `port` (of type `int`): Port to server.
- `method` (of type `string`): Accepted method
- `(unlabeled)` (of type `string`): URI to serve.
- `(unlabeled)` (of type `(protocol : string, data : string,
 headers : [string * string], string) -> {string}`): Function to execute. method argument is "PUT" or "GET", protocol argument is "HTTP/1.1" or "HTTP/1.0" etc., data argument contains data passed in case of a PUT request, and "" otherwise. headers argument contains the HTTP headers. Unlabeled argument contains the requested URI.

### `harbor.http.remove`

Remove a registered HTTP handler on the harbor.

Type:
```
(method : string, port : int, string) -> unit
```

Arguments:

- `method` (of type `string`): Method served.
- `port` (of type `int`): Port to server.
- `(unlabeled)` (of type `string`): URI served.

### `harbor.https.register`

Register a HTTPS handler on the harbor. The given function receives as argument the full requested uri (e.g. "foo?var=bar"), http protocol version, possible input data and the list of HTTP headers and returns the answer sent to the client, including HTTP headers. Registered uri can be regular expressions (e.g. ".+\.php") and can override default metadata handlers. Response is a string getter, i.e. either of type `string` or type `()->string`. In the later case, getter function will be called until it returns an empty string.

Type:
```
(port : int, method : string, string,
 ((protocol : string, data : string,
   headers : [string * string], string) -> {string})) ->
unit
```

Arguments:

- `port` (of type `int`): Port to server.
- `method` (of type `string`): Accepted method
- `(unlabeled)` (of type `string`): URI to serve.
- `(unlabeled)` (of type `(protocol : string, data : string,
 headers : [string * string], string) -> {string}`): Function to execute. method argument is "PUT" or "GET", protocol argument is "HTTP/1.1" or "HTTP/1.0" etc., data argument contains data passed in case of a PUT request, and "" otherwise. headers argument contains the HTTP headers. Unlabeled argument contains the requested URI.

### `harbor.https.remove`

Remove a registered HTTPS handler on the harbor.

Type:
```
(method : string, port : int, string) -> unit
```

Arguments:

- `method` (of type `string`): Method served.
- `port` (of type `int`): Port to server.
- `(unlabeled)` (of type `string`): URI served.

### `int_getter`

Identity function over int getters. This is useful to make types explicit.

Type:
```
({int}) -> {int}
```

Arguments:

- `(unlabeled)` (of type `{int}`)

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

### `log.severe`

Log a severe message

Type:
```
(?label : string, string) -> unit
```

Arguments:

- `label` (of type `string`, which defaults to `"lang"`)
- `(unlabeled)` (of type `string`)

### `metadata.export`

Filter-out internal metadata.

Type:
```
([string * string]) -> [string * string]
```

Arguments:

- `(unlabeled)` (of type `[string * string]`)

### `mutexify`

Protect functions with a mutex to avoid concurrent calls, return original value otherwise.

Type:
```
('a) -> 'a
```

Arguments:

- `(unlabeled)` (of type `'a`)

### `playlist.parse`

Try to parse a local playlist. Return a list of (metadata,URI) items, where metadata is a list of (key,value) bindings.

Type:
```
(?path : string, ?mime : string, string) ->
[[string * string] * string]
```

Arguments:

- `path` (of type `string`, which defaults to `""`): Default path for files.
- `mime` (of type `string`, which defaults to `""`): Mime type for the playlist
- `(unlabeled)` (of type `string`)

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

### `ref.get`

Obtain the value stored in a reference. This is an alias to `!`.

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

### `ref.set`

Change the value stored in a reference. This is an alias to `:=`.

Type:
```
(ref('a), 'a) -> unit
```

Arguments:

- `(unlabeled)` (of type `ref('a)`)
- `(unlabeled)` (of type `'a`)

### `register`

Register a new setting.

Type:
```
(name : string, ?descr : string,
 ?on_change : (('a) -> unit), string, 'a) -> unit
where 'a is unit, bool, int, float, string or [string]
```

Arguments:

- `name` (of type `string`): Settings name
- `descr` (of type `string`, which defaults to `""`): Settings description
- `on_change` (of type `('a) -> unit
where 'a is unit, bool, int, float, string or [string]`, which defaults to `<fun>`): Callback executed when the setting is changed.
- `(unlabeled)` (of type `string`): Setting key
- `(unlabeled)` (of type `anything that is unit, bool, int, float, string or [string]`): Setting initial value

### `register_flow`

Register a radio on Liquidsoap Flows.

Type:
```
(?server : string, ?user : string, ?password : string,
 ?email : string, radio : string, website : string,
 description : string, genre : string,
 streams : [string * string], source('a)) -> source('a)
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
- `(unlabeled)` (of type `source('a)`)

### `request.create`

Create a request. Creation may fail if there is no available RID, which cannot be detected currently: in that case one will obtain a request that will fail to be resolved.

Type:
```
(?indicators : [string], ?persistent : bool, string) ->
request('a)
```

Arguments:

- `indicators` (of type `[string]`, which defaults to `[]`)
- `persistent` (of type `bool`, which defaults to `false`)
- `(unlabeled)` (of type `string`)

### `request.create.raw`

Create a raw request, i.e. for files that should not be decoded for streaming. Creation may fail if there is no available RID, which cannot be detected currently: in that case one will obtain a request that will fail to be resolved.

Type:
```
(?indicators : [string], ?persistent : bool, string) ->
request(audio=0, video=0, midi=0)
```

Arguments:

- `indicators` (of type `[string]`, which defaults to `[]`)
- `persistent` (of type `bool`, which defaults to `false`)
- `(unlabeled)` (of type `string`)

### `request.destroy`

Destroying a request causes any temporary associated file to be deleted, and releases its RID. Persistent requests resist to destroying, unless forced.

Type:
```
(?force : bool, request('a)) -> unit
```

Arguments:

- `force` (of type `bool`, which defaults to `false`): Destroy the request even if it is persistent.
- `(unlabeled)` (of type `request('a)`)

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
(request('a)) -> string
```

Arguments:

- `(unlabeled)` (of type `request('a)`)

### `request.log`

Get log data associated to a request.

Type:
```
(request('a)) -> string
```

Arguments:

- `(unlabeled)` (of type `request('a)`)

### `request.metadata`

Get the metadata associated to a request.

Type:
```
(request('a)) -> [string * string]
```

Arguments:

- `(unlabeled)` (of type `request('a)`)

### `request.ready`

Check if a request is ready, i.e. is associated to a valid local file. Unless the initial URI was such a file, a request has to be resolved before being ready.

Type:
```
(request('a)) -> bool
```

Arguments:

- `(unlabeled)` (of type `request('a)`)

### `request.resolve`

Resolve a request, i.e. attempt to get a valid local file. The operation can take some time. Return true if the resolving was successful, false otherwise (timeout or invalid URI).

Type:
```
(?timeout : float, request('a)) -> bool
```

Arguments:

- `timeout` (of type `float`, which defaults to `30.0`): Limit in seconds to the duration of the resolving.
- `(unlabeled)` (of type `request('a)`)

### `request.uri`

Initial URI of a reuqest.

Type:
```
(request('a)) -> string
```

Arguments:

- `(unlabeled)` (of type `request('a)`)

### `server.execute`

Execute a liquidsoap server command.

Type:
```
(string, ?string) -> [string]
```

Arguments:

- `(unlabeled)` (of type `string`)
- `(unlabeled)` (of type `string`, which defaults to `""`)

### `set`

Change some setting. Use `liquidsoap --conf-descr` and `liquidsoap --conf-descr-key KEY` on the command-line to get some information about available settings.

Type:
```
(string, 'a) -> unit
where 'a is unit, bool, int, float, string or [string]
```

Arguments:

- `(unlabeled)` (of type `string`)
- `(unlabeled)` (of type `anything that is unit, bool, int, float, string or [string]`)

### `source.fallible`

Indicate if a source may fail, i.e. may not be ready to stream.

Type:
```
(source('a)) -> bool
```

Arguments:

- `(unlabeled)` (of type `source('a)`)

### `source.id`

Get one source's identifier.

Type:
```
(source('a)) -> string
```

Arguments:

- `(unlabeled)` (of type `source('a)`)

### `source.init`

Simultaneously initialize sources, return the sublist of sources that failed to initialized.

Type:
```
([source(audio=*, video=*, midi=*)]) ->
[source(audio=*, video=*, midi=*)]
```

Arguments:

- `(unlabeled)` (of type `[source(audio=*, video=*, midi=*)]`)

### `source.is_ready`

Indicate if a source is ready to stream, or currently streaming.

Type:
```
(source('a)) -> bool
```

Arguments:

- `(unlabeled)` (of type `source('a)`)

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

### `source.shutdown`

Desactivate a source.

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

### `string_getter`

Identity function over string getters. This is useful to make types explicit.

Type:
```
({string}) -> {string}
```

Arguments:

- `(unlabeled)` (of type `{string}`)

### `to_bool_getter`

Return a function from a bool getter

Type:
```
({bool}) -> () -> bool
```

Arguments:

- `(unlabeled)` (of type `{bool}`)

### `to_float_getter`

Return a function from a float getter

Type:
```
({float}) -> () -> float
```

Arguments:

- `(unlabeled)` (of type `{float}`)

### `to_int_getter`

Return a function from a int getter

Type:
```
({int}) -> () -> int
```

Arguments:

- `(unlabeled)` (of type `{int}`)

### `to_string_getter`

Return a function from a string getter

Type:
```
({string}) -> () -> string
```

Arguments:

- `(unlabeled)` (of type `{string}`)

## Liquidsoap 

### `ref.make`

Create a reference, i.e. a value that can be modified. This is an alias to `ref`.

Type:
```
('a) -> ref('a)
```

Arguments:

- `(unlabeled)` (of type `'a`)

## List

### `_[_]`

l[k] returns the first v such that (k,v) is in the list l (or "" if no such v exists).

Type:
```
(string, [string * string]) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)
- `(unlabeled)` (of type `[string * string]`)

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

Catenate two lists.

Type:
```
(['a], ['a]) -> ['a]
```

Arguments:

- `(unlabeled)` (of type `['a]`)
- `(unlabeled)` (of type `['a]`)

### `list.assoc`

Generalized l[k] with default value.

Type:
```
(default : 'a, 'b, ['b * 'a]) -> 'a
where 'b is an orderable type
```

Arguments:

- `default` (of type `'a`): Default value if key does not exist
- `(unlabeled)` (of type `anything that is an orderable type`)
- `(unlabeled)` (of type `['b * 'a] where 'b is an orderable type`)

### `list.case`

Define a function by case analysis, depending on whether a list is empty or not.

Type:
```
('a, (('b, ['b]) -> 'a), ['b]) -> 'a
```

Arguments:

- `(unlabeled)` (of type `'a`): Result when the list is empty.
- `(unlabeled)` (of type `('b, ['b]) -> 'a`): Result when the list it non-empty.
- `(unlabeled)` (of type `['b]`): List to perform case analysis on.

### `list.filter`

Filter a list according to a filtering function.

Type:
```
((('a) -> bool), ['a]) -> ['a]
```

Arguments:

- `(unlabeled)` (of type `('a) -> bool`)
- `(unlabeled)` (of type `['a]`)

### `list.filter_assoc`

list.filter_assoc(key,l) returns all the elements of the form (key, value) from l.

Type:
```
('a, ['a * 'b]) -> ['a * 'b]
where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `anything that is an orderable type`): Key to look for
- `(unlabeled)` (of type `['a * 'b] where 'a is an orderable type`): List of pairs (key,value)

### `list.fold`

Fold a function on every element of a list: list.fold(f,x1,[e1,..,en]) is f(...f(f(x1,e1),e2)...,en).

Type:
```
((('a, 'b) -> 'a), 'a, ['b]) -> 'a
```

Arguments:

- `(unlabeled)` (of type `('a, 'b) -> 'a`): Function f for which f(x,e) which will be called on every element e with the current value of x, returning the new value of x.
- `(unlabeled)` (of type `'a`): Initial value x1, to be updated by successive calls of f(x,e).
- `(unlabeled)` (of type `['b]`)

### `list.hd`

Return the head (first element) of a list, or 'default' if the list is empty.

Type:
```
(default : 'a, ['a]) -> 'a
```

Arguments:

- `default` (of type `'a`): Default value if key does not exist
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

### `list.length`

Get the length of a list, i.e. its number of elements.

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

Check if an element belongs to a list.

Type:
```
('a, ['a]) -> bool where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `anything that is an orderable type`)
- `(unlabeled)` (of type `['a] where 'a is an orderable type`)

### `list.mem_assoc`

list.mem_assoc(key,l) returns true if l contains a pair (key,value)

Type:
```
('a, ['a * 'b]) -> bool where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `anything that is an orderable type`): Key to look for
- `(unlabeled)` (of type `['a * 'b] where 'a is an orderable type`): List of pairs (key,value)

### `list.nth`

Get the n-th element of a list (the first element is at position 0), or'default' if element does not exist.

Type:
```
(default : 'a, ['a], int) -> 'a
```

Arguments:

- `default` (of type `'a`): Default value if key does not exist
- `(unlabeled)` (of type `['a]`)
- `(unlabeled)` (of type `int`)

### `list.randomize`

Shuffle the content of a list.

Type:
```
(['a]) -> ['a]
```

Arguments:

- `(unlabeled)` (of type `['a]`)

### `list.remove`

Remove a the first occurence of a value from a list.

Type:
```
('a, ['a]) -> ['a]
```

Arguments:

- `(unlabeled)` (of type `'a`)
- `(unlabeled)` (of type `['a]`)

### `list.remove_assoc`

Remove the first pair from an associative list.

Type:
```
('a, ['a * 'c]) -> ['a * 'c]
where 'a is an orderable type
```

Arguments:

- `(unlabeled)` (of type `anything that is an orderable type`): Key of pair to be removed
- `(unlabeled)` (of type `['a * 'c] where 'a is an orderable type`): List of pairs (key,value)

### `list.rev`

Revert list order.

Type:
```
(['a]) -> ['a]
```

Arguments:

- `(unlabeled)` (of type `['a]`)

### `list.sort`

Sort a list according to a comparison function.

Type:
```
((('a, 'a) -> int), ['a]) -> ['a]
```

Arguments:

- `(unlabeled)` (of type `('a, 'a) -> int`)
- `(unlabeled)` (of type `['a]`)

### `list.tl`

Return the list without its first element.

Type:
```
(['a]) -> ['a]
```

Arguments:

- `(unlabeled)` (of type `['a]`)

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

Substraction  of numbers.

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

### `float_of_int`

Convert an int to a float.

Type:
```
(int) -> float
```

Arguments:

- `(unlabeled)` (of type `int`)

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

### `log_10`

Base 10 logarithm.

Type:
```
(float) -> float
```

Arguments:

- `(unlabeled)` (of type `float`)

### `log_e`

Natural logarithm.

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
- `start` (of type `float`, which defaults to `0.0`): Start value.
- `stop` (of type `float`, which defaults to `1.0`): Stop value.
- `duration` (of type `float`, which defaults to `3.0`): Duration in seconds.
- `on_done` (of type `() -> unit`, which defaults to `<fun>`): Function to execute when the fade is finished
- `(unlabeled)` (of type `source('a)`)

### `mod`

Integer remainder. If y is not zero, x == (x / y) * y + x mod y, and abs(x mod y) <= abs(y)-1.

Type:
```
(int, int) -> int
```

Arguments:

- `(unlabeled)` (of type `int`)
- `(unlabeled)` (of type `int`)

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

Generate a random value.

Type:
```
(?min : float, ?max : float) -> float
```

Arguments:

- `min` (of type `float`, which defaults to `-1000000.0`)
- `max` (of type `float`, which defaults to `1000000.0`)

### `random.int`

Generate a random value.

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

## Other

## Output

### `output.external.ffmpeg`

Output to ffmpeg.

Type:
```
(?id : string, ?show_command : bool, ?flush : bool,
 ?fallible : bool, ?on_start : (() -> unit),
 ?on_stop : (() -> unit), ?reopen_delay : float,
 ?reopen_on_metadata : bool, ?reopen_when : (() -> bool),
 ?start : bool, string, source(audio=2, video=1, midi=0)) ->
active_source(audio=2, video=1, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `show_command` (of type `bool`, which defaults to `false`)
- `flush` (of type `bool`, which defaults to `false`): Perform a flush after each write.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `reopen_delay` (of type `float`, which defaults to `120.0`): Prevent re-opening within that delay, in seconds.
- `reopen_on_metadata` (of type `bool`, which defaults to `false`): Re-open on every new metadata information.
- `reopen_when` (of type `() -> bool`, which defaults to `{false}`): When should the output be re-opened.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `(unlabeled)` (of type `string`)
- `(unlabeled)` (of type `source(audio=2, video=1, midi=0)`)

### `output.file.hls.ffmpeg`

Output a HLS playlist using ffmpeg

Type:
```
(?id : string, ?flush : bool, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?reopen_delay : float, ?reopen_on_metadata : bool,
 ?reopen_when : (() -> bool), ?start : bool,
 ?playlist : string, directory : string, source(audio=2,
 video=1, midi=0)) -> active_source(audio=2, video=1,
midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `flush` (of type `bool`, which defaults to `false`): Perform a flush after each write.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `reopen_delay` (of type `float`, which defaults to `120.0`): Prevent re-opening within that delay, in seconds.
- `reopen_on_metadata` (of type `bool`, which defaults to `false`): Re-open on every new metadata information.
- `reopen_when` (of type `() -> bool`, which defaults to `{false}`): When should the output be re-opened.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `playlist` (of type `string`, which defaults to `"stream.m3u8"`): Playlist name
- `directory` (of type `string`): Directory to write to
- `(unlabeled)` (of type `source(audio=2, video=1, midi=0)`)

### `output.youtube.live.ffmpeg`

Stream to youtube.

Type:
```
(?id : string, ?flush : bool, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?reopen_delay : float, ?reopen_on_metadata : bool,
 ?reopen_when : (() -> bool), ?start : bool,
 ?url : string, ?bitrate : string, ?quality : string,
 key : string, source(audio=2, video=1, midi=0)) ->
active_source(audio=2, video=1, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `flush` (of type `bool`, which defaults to `false`): Perform a flush after each write.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `reopen_delay` (of type `float`, which defaults to `120.0`): Prevent re-opening within that delay, in seconds.
- `reopen_on_metadata` (of type `bool`, which defaults to `false`): Re-open on every new metadata information.
- `reopen_when` (of type `() -> bool`, which defaults to `{false}`): When should the output be re-opened.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `url` (of type `string`, which defaults to `"rtmp://a.rtmp.youtube.com/live2"`): URL to stream to
- `bitrate` (of type `string`, which defaults to `"2500"`): Bitrate of the video (in kbps)
- `quality` (of type `string`, which defaults to `"medium"`): Quality of the video (low / medium / high)
- `key` (of type `string`): Your secret youtube key
- `(unlabeled)` (of type `source(audio=2, video=1, midi=0)`)

## Pair

### `fst`

Get the first component of a pair.

Type:
```
(('a * 'b)) -> 'a
```

Arguments:

- `(unlabeled)` (of type `'a * 'b`)

### `snd`

Get the second component of a pair.

Type:
```
(('a * 'b)) -> 'b
```

Arguments:

- `(unlabeled)` (of type `'a * 'b`)

## Source / Conversions

### `audio_to_stereo`

Convert any kind of audio source into a stereo source.

Type:
```
(?id : string, source(audio=*+1, video=0, midi=0)) ->
source(audio=2, video=0, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio=*+1, video=0, midi=0)`)

### `drop_audio`

Drop all audio channels of a stream.

Type:
```
(?id : string, source(audio='#a, video='#b, midi='#c)) ->
source(audio=0, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `drop_midi`

Drop all midi channels of a stream.

Type:
```
(?id : string, source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `drop_video`

Drop all video channels of a stream.

Type:
```
(?id : string, source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video=0, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `id`

Does not do anything, simply forwards its input stream.

Type:
```
(?id : string, source('a)) -> source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `source('a)`)

### `mean`

Produce mono audio by taking the mean of all audio channels.

Type:
```
(?id : string, source(audio='#a, video='#b, midi='#c)) ->
source(audio=1, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `mux_audio`

Mux an audio stream into an audio-free stream.

Type:
```
(?id : string, audio : source(audio='#a, video=0,
 midi=0), ?mode : string, source(audio=0, video='#b,
 midi='#c)) -> source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `audio` (of type `source(audio='#a, video=0, midi=0)`)
- `mode` (of type `string`, which defaults to `"master"`): Track mode, specifying where the tracks are taken from (none|master|auxiliary|both). Modes other than `"none"` might induce a slight desynchronization between sources.
- `(unlabeled)` (of type `source(audio=0, video='#b, midi='#c)`)

### `mux_mono`

Mux a mono audio stream into another stream.

Type:
```
(?id : string, ?mode : string, mono : source(audio=1,
 video=0, midi=0), source(audio='#a, video='#b,
 midi='#c)) -> source(audio='#a+1, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `mode` (of type `string`, which defaults to `"master"`): Track mode, specifying where the tracks are taken from (none|master|auxiliary|both). Modes other than `"none"` might induce a slight desynchronization between sources.
- `mono` (of type `source(audio=1, video=0, midi=0)`)
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `mux_stereo`

Mux a stereo audio stream into another stream.

Type:
```
(?id : string, ?mode : string, stereo : source(audio=2,
 video=0, midi=0), source(audio='#a, video='#b,
 midi='#c)) -> source(audio='#a+2, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `mode` (of type `string`, which defaults to `"master"`): Track mode, specifying where the tracks are taken from (none|master|auxiliary|both). Modes other than `"none"` might induce a slight desynchronization between sources.
- `stereo` (of type `source(audio=2, video=0, midi=0)`)
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `mux_video`

Add video channnels to a stream.

Type:
```
(?id : string, ?mode : string, video : source(audio=0,
 video='#a, midi=0), source(audio='#b, video=0,
 midi='#c)) -> source(audio='#b, video='#a, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `mode` (of type `string`, which defaults to `"master"`): Track mode, specifying where the tracks are taken from (none|master|auxiliary|both). Modes other than `"none"` might induce a slight desynchronization between sources.
- `video` (of type `source(audio=0, video='#a, midi=0)`)
- `(unlabeled)` (of type `source(audio='#b, video=0, midi='#c)`)

### `stereo.left`

Extract the left channel of a stereo source

Type:
```
(source(audio=2, video=0, midi=0)) -> source(audio=1,
video=0, midi=0)
```

Arguments:

- `(unlabeled)` (of type `source(audio=2, video=0, midi=0)`): Source to extract from

### `stereo.right`

Extract the right channel of a stereo source

Type:
```
(source(audio=2, video=0, midi=0)) -> source(audio=1,
video=0, midi=0)
```

Arguments:

- `(unlabeled)` (of type `source(audio=2, video=0, midi=0)`): Source to extract from

### `swap`

Swap two channels of a stereo source.

Type:
```
(?id : string, source(audio=2, video=0, midi=0)) ->
source(audio=2, video=0, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio=2, video=0, midi=0)`)

## Source / Input

### `blank`

Produce silence and blank images.

Type:
```
(?id : string, ?duration : float) -> source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `duration` (of type `float`, which defaults to `0.0`): Duration of blank tracks in seconds, default means forever.

### `empty`

A source that does not produce anything. No silence, no track at all.

Type:
```
(?id : string) -> source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.

### `fail`

Creates a source that fails to produce anything.

Type:
```
(?id : string) -> source('b)
```

Arguments:

- `id` (of type `string`, which defaults to `""`)

### `gstreamer.single.audio`

Play a single audio file using GStreamer.

Type:
```
(?id : string, ?on_error : (('a) -> float), {string}) ->
source(audio='#c+1, video=0, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `on_error` (of type `('a) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens.
- `(unlabeled)` (of type `{string}`): URI of the file to be played.

### `in`

Create a source from the first available input driver in pulseaudio, portaudio, oss, alsa, blank.

Type:
```
(?id : string, ?start : bool, ?on_start : (() -> unit),
 ?on_stop : (() -> unit), ?fallible : bool) ->
active_source(audio='#a+1, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`)
- `start` (of type `bool`, which defaults to `true`)
- `on_start` (of type `() -> unit`, which defaults to `<fun>`)
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`)
- `fallible` (of type `bool`, which defaults to `false`)

### `input.alsa`

Stream from an ALSA input device.

Type:
```
(?id : string, ?bufferize : bool, ?clock_safe : bool,
 ?device : string, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?start : bool) -> active_source(audio='#a+1, video=0,
midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `bufferize` (of type `bool`, which defaults to `true`): Bufferize input
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of the dedicated ALSA clock
- `device` (of type `string`, which defaults to `"default"`): Alsa device to use
- `fallible` (of type `bool`, which defaults to `false`): Allow the input to stop. When false, the source will be infallible but the stop command won't have any effect.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is created. Disabling it is only taken into account for a fallible input.

### `input.external.avi`

Stream data from an external application.

Type:
```
(?id : string, ?buffer : float, ?max : float,
 ?restart : bool, ?restart_on_error : bool, string) ->
source(audio='#a, video='#b, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `buffer` (of type `float`, which defaults to `1.0`): Duration of the pre-buffered data.
- `max` (of type `float`, which defaults to `10.0`): Maximum duration of the buffered data.
- `restart` (of type `bool`, which defaults to `true`): Restart process when exited.
- `restart_on_error` (of type `bool`, which defaults to `false`): Restart process when exited with error.
- `(unlabeled)` (of type `string`): Command to execute.

This function is experimental.

### `input.external.rawaudio`

Stream raw PCM data from an external application.

Type:
```
(?id : string, ?buffer : float, ?channels : int,
 ?max : float, ?restart : bool, ?restart_on_error : bool,
 ?samplerate : int, string) -> source(audio='#a+1,
video=0, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `buffer` (of type `float`, which defaults to `2.0`): Duration of the pre-buffered data.
- `channels` (of type `int`, which defaults to `2`): Number of channels.
- `max` (of type `float`, which defaults to `10.0`): Maximum duration of the buffered data.
- `restart` (of type `bool`, which defaults to `true`): Restart process when exited.
- `restart_on_error` (of type `bool`, which defaults to `false`): Restart process when exited with error.
- `samplerate` (of type `int`, which defaults to `44100`): Samplerate.
- `(unlabeled)` (of type `string`): Command to execute.

### `input.external.rawvideo`

Stream data from an external application.

Type:
```
(?id : string, ?buffer : float, ?max : float,
 ?restart : bool, ?restart_on_error : bool, string) ->
source(audio=0, video=1, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `buffer` (of type `float`, which defaults to `1.0`): Duration of the pre-buffered data.
- `max` (of type `float`, which defaults to `10.0`): Maximum duration of the buffered data.
- `restart` (of type `bool`, which defaults to `true`): Restart process when exited.
- `restart_on_error` (of type `bool`, which defaults to `false`): Restart process when exited with error.
- `(unlabeled)` (of type `string`): Command to execute.

This function is experimental.

### `input.external.wav`

Stream WAV data from an external application.

Type:
```
(?id : string, ?buffer : float, ?max : float,
 ?restart : bool, ?restart_on_error : bool, string) ->
source(audio='#a+1, video=0, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `buffer` (of type `float`, which defaults to `2.0`): Duration of the pre-buffered data.
- `max` (of type `float`, which defaults to `10.0`): Maximum duration of the buffered data.
- `restart` (of type `bool`, which defaults to `true`): Restart process when exited.
- `restart_on_error` (of type `bool`, which defaults to `false`): Restart process when exited with error.
- `(unlabeled)` (of type `string`): Command to execute.

### `input.gstreamer.audio`

Stream audio from a GStreamer pipeline.

Type:
```
(?id : string, ?max : float,
 ?on_error : ((string) -> float), ?pipeline : {string},
 ?restart : bool) -> source(audio='#b+1, video=0, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `max` (of type `float`, which defaults to `10.0`): Maximum duration of the buffered data.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens. The callback receives a string representation of the error that occured and returns a float. If returned value is positive, connection will be tried again after this amount of time (in seconds).
- `pipeline` (of type `{string}`, which defaults to `"audiotestsrc"`): GStreamer pipeline to input from.
- `restart` (of type `bool`, which defaults to `true`): Restart input on end of stream event.

### `input.gstreamer.audio_video`

Stream audio+video from a GStreamer pipeline.

Type:
```
(?id : string, ?audio_pipeline : {string}, ?max : float,
 ?on_error : ((string) -> float), ?pipeline : {string},
 ?restart : bool, ?video_pipeline : {string}) ->
source(audio=2, video=1, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `audio_pipeline` (of type `{string}`, which defaults to `"audiotestsrc"`): Audio pipeline to input from.
- `max` (of type `float`, which defaults to `10.0`): Maximum duration of the buffered data.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens. The callback receives a string representation of the error that occured and returns a float. If returned value is positive, connection will be tried again after this amount of time (in seconds).
- `pipeline` (of type `{string}`, which defaults to `""`): Main GStreamer pipeline.
- `restart` (of type `bool`, which defaults to `true`): Restart input on end of stream event.
- `video_pipeline` (of type `{string}`, which defaults to `"videotestsrc"`): Video pipeline to input from.

### `input.gstreamer.video`

Stream video from a GStreamer pipeline.

Type:
```
(?id : string, ?max : float,
 ?on_error : ((string) -> float), ?pipeline : {string},
 ?restart : bool) -> source(audio=0, video=1, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `max` (of type `float`, which defaults to `10.0`): Maximum duration of the buffered data.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens. The callback receives a string representation of the error that occured and returns a float. If returned value is positive, connection will be tried again after this amount of time (in seconds).
- `pipeline` (of type `{string}`, which defaults to `"videotestsrc"`): GStreamer pipeline to input from.
- `restart` (of type `bool`, which defaults to `true`): Restart input on end of stream event.

### `input.harbor`

Create a source that receives a http/icecast stream and forwards it as a stream.

Type:
```
(?id : string, ?auth : ((string, string) -> bool),
 ?buffer : float, ?debug : bool, ?dumpfile : string,
 ?icy : bool, ?icy_metadata_charset : string,
 ?logfile : string, ?max : float,
 ?metadata_charset : string,
 ?on_connect : (([string * string]) -> unit),
 ?on_disconnect : (() -> unit), ?password : string,
 ?port : int, ?replay_metadata : bool, ?timeout : float,
 ?user : string, string) -> source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `auth` (of type `(string, string) -> bool`, which defaults to `fun (_,_) -> false`): Authentication function. `f(login,password)` returns `true` if the user should be granted access for this login. Override any other method if used.
- `buffer` (of type `float`, which defaults to `2.0`): Duration of the pre-buffered data.
- `debug` (of type `bool`, which defaults to `false`): Run in debugging mode by not catching some exceptions.
- `dumpfile` (of type `string`, which defaults to `""`): Dump stream to file, for debugging purpose. Disabled if empty.
- `icy` (of type `bool`, which defaults to `false`): Enable ICY (shoutcast) protocol.
- `icy_metadata_charset` (of type `string`, which defaults to `""`): ICY (shoutcast) metadata charset. Guessed if empty. Default for shoutcast is ISO-8859-1. Set to that value if all your clients send metadata using this charset and automatic detection is not working for you.
- `logfile` (of type `string`, which defaults to `""`): Log buffer status to file, for debugging purpose. Disabled if empty.
- `max` (of type `float`, which defaults to `10.0`): Maximum duration of the buffered data.
- `metadata_charset` (of type `string`, which defaults to `""`): Metadata charset for non-ICY (shoutcast) source protocols. Guessed if empty.
- `on_connect` (of type `([string * string]) -> unit`, which defaults to `<fun>`): Function to execute when a source is connected. Its receives the list of headers, of the form: (<label>,<value>). All labels are lowercase.
- `on_disconnect` (of type `() -> unit`, which defaults to `<fun>`): Functions to excecute when a source is disconnected
- `password` (of type `string`, which defaults to `"hackme"`): Source password.
- `port` (of type `int`, which defaults to `8005`): Port used to connect to the source.
- `replay_metadata` (of type `bool`, which defaults to `false`): Replay last known metadata when switching back to this source. This helps when source has dropped due to temporary connection issues.
- `timeout` (of type `float`, which defaults to `30.0`): Timeout for source connectionn.
- `user` (of type `string`, which defaults to `"source"`): Source user.
- `(unlabeled)` (of type `string`): Mountpoint to look for.

### `input.harbor.ssl`

Retrieves the given https stream from the harbor.

Type:
```
(?id : string, ?auth : ((string, string) -> bool),
 ?buffer : float, ?debug : bool, ?dumpfile : string,
 ?icy : bool, ?icy_metadata_charset : string,
 ?logfile : string, ?max : float,
 ?metadata_charset : string,
 ?on_connect : (([string * string]) -> unit),
 ?on_disconnect : (() -> unit), ?password : string,
 ?port : int, ?replay_metadata : bool, ?timeout : float,
 ?user : string, string) -> source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `auth` (of type `(string, string) -> bool`, which defaults to `fun (_,_) -> false`): Authentication function. `f(login,password)` returns `true` if the user should be granted access for this login. Override any other method if used.
- `buffer` (of type `float`, which defaults to `2.0`): Duration of the pre-buffered data.
- `debug` (of type `bool`, which defaults to `false`): Run in debugging mode by not catching some exceptions.
- `dumpfile` (of type `string`, which defaults to `""`): Dump stream to file, for debugging purpose. Disabled if empty.
- `icy` (of type `bool`, which defaults to `false`): Enable ICY (shoutcast) protocol.
- `icy_metadata_charset` (of type `string`, which defaults to `""`): ICY (shoutcast) metadata charset. Guessed if empty. Default for shoutcast is ISO-8859-1. Set to that value if all your clients send metadata using this charset and automatic detection is not working for you.
- `logfile` (of type `string`, which defaults to `""`): Log buffer status to file, for debugging purpose. Disabled if empty.
- `max` (of type `float`, which defaults to `10.0`): Maximum duration of the buffered data.
- `metadata_charset` (of type `string`, which defaults to `""`): Metadata charset for non-ICY (shoutcast) source protocols. Guessed if empty.
- `on_connect` (of type `([string * string]) -> unit`, which defaults to `<fun>`): Function to execute when a source is connected. Its receives the list of headers, of the form: (<label>,<value>). All labels are lowercase.
- `on_disconnect` (of type `() -> unit`, which defaults to `<fun>`): Functions to excecute when a source is disconnected
- `password` (of type `string`, which defaults to `"hackme"`): Source password.
- `port` (of type `int`, which defaults to `8005`): Port used to connect to the source.
- `replay_metadata` (of type `bool`, which defaults to `false`): Replay last known metadata when switching back to this source. This helps when source has dropped due to temporary connection issues.
- `timeout` (of type `float`, which defaults to `30.0`): Timeout for source connectionn.
- `user` (of type `string`, which defaults to `"source"`): Source user.
- `(unlabeled)` (of type `string`): Mountpoint to look for.

### `input.hls`

Play an HLS stream.

Type:
```
(?id : string, ?reload : float, string) -> source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `reload` (of type `float`, which defaults to `10.0`): How often (in seconds) the playlist should be reloaded.
- `(unlabeled)` (of type `string`): Playlist URI

This function is experimental.

### `input.http`

Create a source that fetches a http stream.

Type:
```
(?id : string, ?autostart : bool, ?bind_address : string,
 ?buffer : float, ?debug : bool, ?force_mime : string,
 ?logfile : string, ?max : float,
 ?new_track_on_metadata : bool,
 ?on_connect : (([string * string]) -> unit),
 ?on_disconnect : (() -> unit), ?playlist_mode : string,
 ?poll_delay : float, ?timeout : float,
 ?user_agent : string, string) -> source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `autostart` (of type `bool`, which defaults to `true`): Initially start relaying or not.
- `bind_address` (of type `string`, which defaults to `""`): Address to bind on the local machine. This option can be useful if your machine is bound to multiple IPs. Empty means no bind address.
- `buffer` (of type `float`, which defaults to `2.0`): Duration of the pre-buffered data.
- `debug` (of type `bool`, which defaults to `false`): Run in debugging mode, not catching some exceptions.
- `force_mime` (of type `string`, which defaults to `""`): Force mime data type. Not used if empty.
- `logfile` (of type `string`, which defaults to `""`): Log buffer status to file, for debugging purpose. Disabled if empty.
- `max` (of type `float`, which defaults to `10.0`): Maximum duration of the buffered data.
- `new_track_on_metadata` (of type `bool`, which defaults to `true`): Treat new metadata as new track.
- `on_connect` (of type `([string * string]) -> unit`, which defaults to `<fun>`): Function to execute when a source is connected. Its receives the list of headers, of the form: (<label>,<value>). All labels are lowercase.
- `on_disconnect` (of type `() -> unit`, which defaults to `<fun>`): Function to excecute when a source is disconnected
- `playlist_mode` (of type `string`, which defaults to `"normal"`): Valid modes are "normal", "random", "randomize" and "first". The first ones have the same meaning as for the mode parameter of the playlist operator. The last one discards all entries but the first one.
- `poll_delay` (of type `float`, which defaults to `2.0`): Polling delay when trying to connect to the stream.
- `timeout` (of type `float`, which defaults to `30.0`): Timeout for source connectionn.
- `user_agent` (of type `string`, which defaults to `"Liquidsoap/1.4.4 (Unix; OCaml 4.10.0)"`): User agent.
- `(unlabeled)` (of type `string`): URL of an http stream (default port is 80).

### `input.https`

Create a source that fetches a https stream.

Type:
```
(?id : string, ?autostart : bool, ?bind_address : string,
 ?buffer : float, ?debug : bool, ?force_mime : string,
 ?logfile : string, ?max : float,
 ?new_track_on_metadata : bool,
 ?on_connect : (([string * string]) -> unit),
 ?on_disconnect : (() -> unit), ?playlist_mode : string,
 ?poll_delay : float, ?timeout : float,
 ?user_agent : string, string) -> source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `autostart` (of type `bool`, which defaults to `true`): Initially start relaying or not.
- `bind_address` (of type `string`, which defaults to `""`): Address to bind on the local machine. This option can be useful if your machine is bound to multiple IPs. Empty means no bind address.
- `buffer` (of type `float`, which defaults to `2.0`): Duration of the pre-buffered data.
- `debug` (of type `bool`, which defaults to `false`): Run in debugging mode, not catching some exceptions.
- `force_mime` (of type `string`, which defaults to `""`): Force mime data type. Not used if empty.
- `logfile` (of type `string`, which defaults to `""`): Log buffer status to file, for debugging purpose. Disabled if empty.
- `max` (of type `float`, which defaults to `10.0`): Maximum duration of the buffered data.
- `new_track_on_metadata` (of type `bool`, which defaults to `true`): Treat new metadata as new track.
- `on_connect` (of type `([string * string]) -> unit`, which defaults to `<fun>`): Function to execute when a source is connected. Its receives the list of headers, of the form: (<label>,<value>). All labels are lowercase.
- `on_disconnect` (of type `() -> unit`, which defaults to `<fun>`): Function to excecute when a source is disconnected
- `playlist_mode` (of type `string`, which defaults to `"normal"`): Valid modes are "normal", "random", "randomize" and "first". The first ones have the same meaning as for the mode parameter of the playlist operator. The last one discards all entries but the first one.
- `poll_delay` (of type `float`, which defaults to `2.0`): Polling delay when trying to connect to the stream.
- `timeout` (of type `float`, which defaults to `30.0`): Timeout for source connectionn.
- `user_agent` (of type `string`, which defaults to `"Liquidsoap/1.4.4 (Unix; OCaml 4.10.0)"`): User agent.
- `(unlabeled)` (of type `string`): URL of an https stream (default port is 443).

### `input.jack`

Get stream from jack.

Type:
```
(?id : string, ?buffer_size : int, ?clock_safe : bool,
 ?server : string) -> source(audio='#a+1, video=0,
midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `buffer_size` (of type `int`, which defaults to `2`): Set buffer size, in frames. Must be >= 1.
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of the dedicated bjack clock.
- `server` (of type `string`, which defaults to `""`): Jack server to connect to.

### `input.mplayer`

Stream data from mplayer

Type:
```
(?id : string, ?restart : bool, ?restart_on_error : bool,
 ?buffer : float, ?max : float, string) ->
source(audio='#a+1, video=0, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `"input.mplayer"`)
- `restart` (of type `bool`, which defaults to `true`): restart on exit.
- `restart_on_error` (of type `bool`, which defaults to `false`): restart on exit with error.
- `buffer` (of type `float`, which defaults to `0.2`): Duration of the pre-buffered data.
- `max` (of type `float`, which defaults to `10.0`): Maximum duration of the buffered data.
- `(unlabeled)` (of type `string`): data URI.

### `input.oss`

Stream from an OSS input device.

Type:
```
(?id : string, ?clock_safe : bool, ?device : string,
 ?fallible : bool, ?on_start : (() -> unit),
 ?on_stop : (() -> unit), ?start : bool) ->
active_source(audio='#a+1, video=0, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of the dedicated OSS clock.
- `device` (of type `string`, which defaults to `"/dev/dsp"`): OSS device to use.
- `fallible` (of type `bool`, which defaults to `false`): Allow the input to stop. When false, the source will be infallible but the stop command won't have any effect.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is created. Disabling it is only taken into account for a fallible input.

### `input.portaudio`

Stream from a portaudio input device.

Type:
```
(?id : string, ?buflen : int, ?clock_safe : bool,
 ?fallible : bool, ?on_start : (() -> unit),
 ?on_stop : (() -> unit), ?start : bool) ->
source(audio='#a+1, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `buflen` (of type `int`, which defaults to `256`): Length of a buffer in samples.
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of the dedicated Portaudio clock.
- `fallible` (of type `bool`, which defaults to `false`): Allow the input to stop. When false, the source will be infallible but the stop command won't have any effect.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is created. Disabling it is only taken into account for a fallible input.

### `input.pulseaudio`

Stream from a portaudio input device.

Type:
```
(?id : string, ?client : string, ?clock_safe : bool,
 ?device : string, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?start : bool) -> active_source(audio='#a+1, video='#b,
midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `client` (of type `string`, which defaults to `"liquidsoap"`)
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of the dedicated Pulseaudio clock.
- `device` (of type `string`, which defaults to `""`): Device to use. Uses default if set to "".
- `fallible` (of type `bool`, which defaults to `false`): Allow the input to stop. When false, the source will be infallible but the stop command won't have any effect.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when input stops.
- `start` (of type `bool`, which defaults to `true`): Start input as soon as it is created. Disabling it is only taken into account for a fallible input.

### `input.srt`

Start a SRT agent in listener mode to receive and decode a stream.

Type:
```
(?id : string, ?bind_address : string,
 ?clock_safe : bool, ?content_type : string,
 ?max : float, ?messageapi : bool,
 ?on_connect : ((unit) -> unit),
 ?on_disconnect : (() -> unit), ?payload_size : int,
 ?port : int) -> source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `bind_address` (of type `string`, which defaults to `"0.0.0.0"`): Address to bind on the local machine.
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of a decicated clock.
- `content_type` (of type `string`, which defaults to `"application/ffmpeg"`): Content-Type (mime type) used to find a decoder for the input stream.
- `max` (of type `float`, which defaults to `10.0`): Maximum duration of the buffered data.
- `messageapi` (of type `bool`, which defaults to `true`): Use message api
- `on_connect` (of type `(unit) -> unit`, which defaults to `<fun>`): Function to execute when a source is connected.
- `on_disconnect` (of type `() -> unit`, which defaults to `<fun>`): Function to excecute when a stream is disconnected
- `payload_size` (of type `int`, which defaults to `1316`): Payload size.
- `port` (of type `int`, which defaults to `8000`): Port to bind on the local machine. The term `port` as used in SRT is occasionally identical to the term `UDP port`. However SRT offers more flexibility than UDP because it manages ports as its own resources. For example, one port may be shared between various services.

### `input.udp`

Input encoded data from UDP, without any control whatsoever.

Type:
```
(?id : string, ?buffer : float, host : string,
 port : int, string) -> active_source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `buffer` (of type `float`, which defaults to `1.0`): Duration of buffered data before starting playout.
- `host` (of type `string`)
- `port` (of type `int`)
- `(unlabeled)` (of type `string`): Mime type.

This function is experimental.

### `input.v4l2`

Stream from a video4linux 2 input device, such as a webcam.

Type:
```
(?id : string, ?device : string,
 ?on_error : ((string) -> float)) -> source(audio=0,
video=1, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `device` (of type `string`, which defaults to `"/dev/video0"`): V4L2 device to use.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens.

### `input.v4l2_with_audio`

Stream from a video4linux 2 input device, such as a webcam.

Type:
```
(?id : string, ?device : string,
 ?on_error : ((string) -> float)) -> source(audio=2,
video=1, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `device` (of type `string`, which defaults to `"/dev/video0"`): V4L2 device to use.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens.

### `noise`

Generate (audio and/or video) white noise.

Type:
```
(?id : string, ?duration : float) -> source(audio='a,
video='b, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `duration` (of type `float`, which defaults to `0.0`)

### `output.file.hls.gstreamer`

Play an http live stream.

Type:
```
(?id : string, ?on_error : ((string) -> float), {string}) ->
source(audio=2, video=1, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens.
- `(unlabeled)` (of type `{string}`): URI of the HLS stream index.

### `output.file.hls.gstreamer.audio`

Play an audio-only http live stream.

Type:
```
(?id : string, ?on_error : ((string) -> float), {string}) ->
source(audio='#b+1, video=0, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens.
- `(unlabeled)` (of type `{string}`): URI of the HLS stream index.

### `playlist`

Loop on a playlist of URIs.

Type:
```
(?id : string, ?check_next : ((request('a)) -> bool),
 ?conservative : bool, ?default_duration : float,
 ?length : float, ?mime_type : string, ?mode : string,
 ?on_track : ((last : bool, int) -> bool),
 ?prefix : string, ?reload : int, ?reload_mode : string,
 ?timeout : float, string) -> source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `check_next` (of type `(request('a)) -> bool`, which defaults to `<fun>`): Function used to filter next tracks. A candidate track is only validated if the function returns true on it. The function is called before resolution, hence metadata will only be available for requests corresponding to local files. This is typically used to avoid repetitions, but be careful: if the function rejects all attempts, the playlist will enter into a consuming loop and stop playing anything.
- `conservative` (of type `bool`, which defaults to `false`): If true, estimated remaining time on the current track is not considered when computing queue length.
- `default_duration` (of type `float`, which defaults to `30.0`): When unknown, assume this duration (in sec.) for files.
- `length` (of type `float`, which defaults to `40.0`): How much audio (in sec.) should be queued in advance.
- `mime_type` (of type `string`, which defaults to `""`): Default MIME type for the playlist. Empty string means automatic detection.
- `mode` (of type `string`, which defaults to `"randomize"`): Play the files in the playlist either in the order ("normal" mode), or shuffle the playlist each time it is loaded, and play it in this order for a whole round ("randomize" mode), or pick a random file in the playlist each time ("random" mode).
- `on_track` (of type `(last : bool, int) -> bool`, which defaults to `fun (_,~last=_) -> false`): Function to execute when playlist is about to play its next track. Receives track position in the playlist and wether this is the last track. Force a reload by returning `true` in this function. 
- `prefix` (of type `string`, which defaults to `""`): Add a constant prefix to all requests. Useful for passing extra information using annotate, or for resolution through a particular protocol, such as replaygain.
- `reload` (of type `int`, which defaults to `0`): Amount of time (in seconds or rounds), when applicable, before which the playlist is reloaded; 0 means never.
- `reload_mode` (of type `string`, which defaults to `"seconds"`): Unit of the reload parameter, either 'rounds', 'seconds' or 'watch' (reload the file whenever it is changed).
- `timeout` (of type `float`, which defaults to `20.0`): Timeout (in sec.) for a single download.
- `(unlabeled)` (of type `string`): URI where to find the playlist.

### `playlist.once`

Custom playlist source written using the script language. It will read directory or playlist, play all files and stop.

Type:
```
(?id : string, ?random : bool, ?on_done : (() -> unit),
 ?reload_mode : string, ?default_duration : float,
 ?length : float, ?conservative : bool,
 ?filter : (([string * string]) -> bool), string) ->
source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `random` (of type `bool`, which defaults to `false`): Randomize playlist content
- `on_done` (of type `() -> unit`, which defaults to `<fun>`): Function to execute when the playlist is finished
- `reload_mode` (of type `string`, which defaults to `""`): If set to "watch", will be reloaded when the playlist is changed
- `default_duration` (of type `float`, which defaults to `30.0`): When unknown, assume this duration (in sec.) for files.
- `length` (of type `float`, which defaults to `10.0`): How much audio (in sec.) should be queued in advance.
- `conservative` (of type `bool`, which defaults to `false`): If true, estimated remaining time on the current track is not considered when computing queue length.
- `filter` (of type `([string * string]) -> bool`, which defaults to `fun (_) -> true`): Filter out some files depending on metadata
- `(unlabeled)` (of type `string`): Playlist URI

### `playlist.reloadable`

Custom playlist source written using the script language.  Will read directory or playlist, play all files and stop.  Returns a pair `(reload,source)` where `reload` is a function of type `(?uri:string)->unit` used to reload the source and `source` is the actual source. The reload function can optionally be called with a new playlist URI. Otherwise, it reloads the previous URI.

Type:
```
(?id : string, ?random : bool, ?on_done : (() -> unit),
 ?default_duration : float, ?length : float,
 ?conservative : bool,
 ?filter : (([string * string]) -> bool), string) ->
((?uri : string) -> unit) * source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `random` (of type `bool`, which defaults to `false`): Randomize playlist content
- `on_done` (of type `() -> unit`, which defaults to `<fun>`): Function to execute when the playlist is finished
- `default_duration` (of type `float`, which defaults to `30.0`): When unknown, assume this duration (in sec.) for files.
- `length` (of type `float`, which defaults to `10.0`): How much audio (in sec.) should be queued in advance.
- `conservative` (of type `bool`, which defaults to `false`): If true, estimated remaining time on the current track is not considered when computing queue length.
- `filter` (of type `([string * string]) -> bool`, which defaults to `fun (_) -> true`): Filter out some files depending on metadata
- `(unlabeled)` (of type `string`): Playlist URI

### `playlist.safe`

Loop on a playlist of local files, and never fail. In order to do so, it has to check every file at the loading, so the streamer startup may take a few seconds. To avoid this, use a standard playlist, and put only a few local files in a default safe_playlist in order to ensure the liveness of the streamer.

Type:
```
(?id : string, ?mime_type : string, ?mode : string,
 ?on_track : ((last : bool, int) -> bool),
 ?prefix : string, ?reload : int, ?reload_mode : string,
 string) -> source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `mime_type` (of type `string`, which defaults to `""`): Default MIME type for the playlist. Empty string means automatic detection.
- `mode` (of type `string`, which defaults to `"randomize"`): Play the files in the playlist either in the order ("normal" mode), or shuffle the playlist each time it is loaded, and play it in this order for a whole round ("randomize" mode), or pick a random file in the playlist each time ("random" mode).
- `on_track` (of type `(last : bool, int) -> bool`, which defaults to `fun (_,~last=_) -> false`): Function to execute when playlist is about to play its next track. Receives track position in the playlist and wether this is the last track. Force a reload by returning `true` in this function. 
- `prefix` (of type `string`, which defaults to `""`): Add a constant prefix to all requests. Useful for passing extra information using annotate, or for resolution through a particular protocol, such as replaygain.
- `reload` (of type `int`, which defaults to `0`): Amount of time (in seconds or rounds), when applicable, before which the playlist is reloaded; 0 means never.
- `reload_mode` (of type `string`, which defaults to `"seconds"`): Unit of the reload parameter, either 'rounds', 'seconds' or 'watch' (reload the file whenever it is changed).
- `(unlabeled)` (of type `string`): URI where to find the playlist.

### `request.dynamic.list`

Play request dynamically created by a given function.

Type:
```
(?id : string, ?conservative : bool,
 ?default_duration : float, ?length : float,
 ?retry_delay : {float}, ?timeout : float,
 (() -> [request('b)])) -> source('b)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `conservative` (of type `bool`, which defaults to `false`): If true, estimated remaining time on the current track is not considered when computing queue length.
- `default_duration` (of type `float`, which defaults to `30.0`): When unknown, assume this duration (in sec.) for files.
- `length` (of type `float`, which defaults to `40.0`): How much audio (in sec.) should be queued in advance.
- `retry_delay` (of type `{float}`, which defaults to `0.1`): Retry after a given time (in seconds) when callback returns an empty list.
- `timeout` (of type `float`, which defaults to `20.0`): Timeout (in sec.) for a single download.
- `(unlabeled)` (of type `() -> [request('b)]`)

### `request.equeue`

Receive URIs from users, and play them. Insertion and deletion possible at any position.

Type:
```
(?id : string, ?conservative : bool,
 ?default_duration : float, ?length : float,
 ?timeout : float) -> source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `conservative` (of type `bool`, which defaults to `false`): If true, estimated remaining time on the current track is not considered when computing queue length.
- `default_duration` (of type `float`, which defaults to `30.0`): When unknown, assume this duration (in sec.) for files.
- `length` (of type `float`, which defaults to `40.0`): How much audio (in sec.) should be queued in advance.
- `timeout` (of type `float`, which defaults to `20.0`): Timeout (in sec.) for a single download.

### `request.queue`

Receive URIs from users, and play them.

Type:
```
(?id : string, ?conservative : bool,
 ?default_duration : float, ?interactive : bool,
 ?length : float, ?queue : [request('a)],
 ?timeout : float) -> source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `conservative` (of type `bool`, which defaults to `false`): If true, estimated remaining time on the current track is not considered when computing queue length.
- `default_duration` (of type `float`, which defaults to `30.0`): When unknown, assume this duration (in sec.) for files.
- `interactive` (of type `bool`, which defaults to `true`): Should the queue be controllable via telnet?
- `length` (of type `float`, which defaults to `40.0`): How much audio (in sec.) should be queued in advance.
- `queue` (of type `[request('a)]`, which defaults to `[]`): Initial queue of requests.
- `timeout` (of type `float`, which defaults to `20.0`): Timeout (in sec.) for a single download.

### `saw`

Generate a saw wave.

Type:
```
(?id : string, ?amplitude : float, ?duration : float,
 ?float) -> source(audio='#a+1, video=0, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `amplitude` (of type `float`, which defaults to `1.0`): Maximal value of the waveform.
- `duration` (of type `float`, which defaults to `0.0`): Duration in seconds (0. means infinite).
- `(unlabeled)` (of type `float`, which defaults to `440.0`): Frequency of the saw.

### `sine`

Generate a sine wave.

Type:
```
(?id : string, ?amplitude : float, ?duration : float,
 ?float) -> source(audio='#a+1, video=0, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `amplitude` (of type `float`, which defaults to `1.0`): Maximal value of the waveform.
- `duration` (of type `float`, which defaults to `0.0`): Duration in seconds (0. means infinite).
- `(unlabeled)` (of type `float`, which defaults to `440.0`): Frequency of the sine.

### `single`

Loop on a request. It never fails if the request is static, meaning that it can be fetched once. Typically, http, ftp, say requests are static, and time is not.

Type:
```
(?id : string, ?conservative : bool,
 ?default_duration : float, ?length : float,
 ?timeout : float, string) -> source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `conservative` (of type `bool`, which defaults to `false`): If true, estimated remaining time on the current track is not considered when computing queue length.
- `default_duration` (of type `float`, which defaults to `30.0`): When unknown, assume this duration (in sec.) for files.
- `length` (of type `float`, which defaults to `40.0`): How much audio (in sec.) should be queued in advance.
- `timeout` (of type `float`, which defaults to `20.0`): Timeout (in sec.) for a single download.
- `(unlabeled)` (of type `string`): URI where to find the file

### `square`

Generate a square wave.

Type:
```
(?id : string, ?amplitude : float, ?duration : float,
 ?float) -> source(audio='#a+1, video=0, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `amplitude` (of type `float`, which defaults to `1.0`): Maximal value of the waveform.
- `duration` (of type `float`, which defaults to `0.0`): Duration in seconds (0. means infinite).
- `(unlabeled)` (of type `float`, which defaults to `440.0`): Frequency of the square.

## Source / Liquidsoap

### `buffer`

Create a buffer between two different clocks.

Type:
```
(?id : string, ?buffer : float, ?fallible : bool,
 ?max : float, ?on_start : (() -> unit),
 ?on_stop : (() -> unit), ?start : bool, source('a)) ->
source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `buffer` (of type `float`, which defaults to `1.0`): Amount of data to pre-buffer, in seconds.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `max` (of type `float`, which defaults to `10.0`): Maximum amount of buffered data, in seconds.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `(unlabeled)` (of type `source('a)`)

### `buffer.adaptative`

Create a buffer between two different clocks. The speed of the output is adapted so that no buffer underrun or overrun occurs. This wonderful behavior has a cost: the pitch of the sound might be changed a little.

Type:
```
(?id : string, ?averaging : float, ?buffer : float,
 ?fallible : bool, ?limit : float, ?max : float,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?reset : bool, ?start : bool, source(audio='#a+1,
 video=0, midi=0)) -> source(audio='#a+1, video=0,
midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `averaging` (of type `float`, which defaults to `30.0`): Half-life for the averaging of the buffer size, in seconds.
- `buffer` (of type `float`, which defaults to `1.0`): Amount of data to pre-buffer, in seconds.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `limit` (of type `float`, which defaults to `1.25`): Maximum acceleration or deceleration factor.
- `max` (of type `float`, which defaults to `10.0`): Maximum amount of buffered data, in seconds.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `reset` (of type `bool`, which defaults to `false`): Reset speed estimation to 1. when the source becomes available again.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `(unlabeled)` (of type `source(audio='#a+1, video=0, midi=0)`)

This function is experimental.

## Source / MIDI Processing

### `midi.chord`

Generate a chord.

Type:
```
(?id : string, ?metadata : string, source(audio='#a,
 video='#b, midi='#c)) -> source(audio='#a, video='#b,
midi='#c+1)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `metadata` (of type `string`, which defaults to `"chord"`): Name of the metadata containing the chords.
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `midi.merge_all`

Merge all MIDI tracks in one.

Type:
```
(?id : string, ?track_out : int, source(audio='#a,
 video='#b, midi='#c+1)) -> source(audio='#a, video='#b,
midi='#c+1)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `track_out` (of type `int`, which defaults to `0`): Destination track.
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c+1)`)

### `midi.remove`

Remove MIDI tracks.

Type:
```
(?id : string, [int], source(audio='#a, video='#b,
 midi='#c+1)) -> source(audio='#a, video='#b, midi='#c+1)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `[int]`): Tracks to remove.
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c+1)`)

## Source / Output

### `gstreamer.encode_jpeg_avi`

Encode jpeg video file using gstreamer

Type:
```
('a, source(audio='#b, video='#c+1, midi='#d)) ->
active_source(audio='#b, video='#c+1, midi='#d)
```

Arguments:

- `(unlabeled)` (of type `'a`): Encoded file name
- `(unlabeled)` (of type `source(audio='#b, video='#c+1, midi='#d)`): Source

### `gstreamer.encode_mp3`

Encode a mp3 file using gstreamer

Type:
```
('a, source(audio='#b+1, video='#c, midi='#d)) ->
active_source(audio='#b+1, video='#c, midi='#d)
```

Arguments:

- `(unlabeled)` (of type `'a`): Encoded file name
- `(unlabeled)` (of type `source(audio='#b+1, video='#c, midi='#d)`): Source

### `gstreamer.encode_x264_avi`

Encode an x264 video file using gstreamer

Type:
```
('a, source(audio='#b, video='#c+1, midi='#d)) ->
active_source(audio='#b, video='#c+1, midi='#d)
```

Arguments:

- `(unlabeled)` (of type `'a`): Encoded file name
- `(unlabeled)` (of type `source(audio='#b, video='#c+1, midi='#d)`): Source

### `gstreamer.rtp.mpeg4`

Broadcast a video in RTP. In order to play it, save the following in `xxx.sdp` and use `vlc xxx.sdp`:
```
v=0
m=video 5000 RTP/AVP 96
c=IN IP4 127.0.0.1
a=rtpmap:96 MP4V-ES/90000
```


Type:
```
(?host : string, ?port : int, source(audio='#a,
 video='#b+1, midi='#c)) -> active_source(audio='#a,
video='#b+1, midi='#c)
```

Arguments:

- `host` (of type `string`, which defaults to `"127.0.0.1"`)
- `port` (of type `int`, which defaults to `5000`)
- `(unlabeled)` (of type `source(audio='#a, video='#b+1, midi='#c)`)

### `out`

Output a stream using the `output.prefered` operator. The input source does not need to be infallible, blank will just be played during failures.

Type:
```
(source(audio='#a+1, video='#b, midi='#c)) ->
active_source(audio='#a+1, video='#b, midi='#c)
```

Arguments:

- `(unlabeled)` (of type `source(audio='#a+1, video='#b, midi='#c)`): the source to output

### `output.alsa`

Output the source's stream to an ALSA output device.

Type:
```
(?id : string, ?bufferize : bool, ?clock_safe : bool,
 ?device : string, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?start : bool, source(audio='#a+1, video='#b, midi='#c)) ->
active_source(audio='#a+1, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `bufferize` (of type `bool`, which defaults to `true`): Bufferize output
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of the dedicated ALSA clock
- `device` (of type `string`, which defaults to `"default"`): Alsa device to use
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `(unlabeled)` (of type `source(audio='#a+1, video='#b, midi='#c)`)

### `output.ao`

Output stream to local sound card using libao.

Type:
```
(?id : string, ?buffer_size : int,
 ?channels_matrix : string, ?clock_safe : bool,
 ?driver : string, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?options : [string * string], ?start : bool,
 source(audio='#a+1, video='#b, midi='#c)) ->
active_source(audio='#a+1, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `buffer_size` (of type `int`, which defaults to `2`): Set buffer size, in frames.
- `channels_matrix` (of type `string`, which defaults to `""`): Output channels matrix, "" for AO's default.
- `clock_safe` (of type `bool`, which defaults to `true`): Use the dedicated AO clock.
- `driver` (of type `string`, which defaults to `""`): Driver to be used, "" for AO's default.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `options` (of type `[string * string]`, which defaults to `[]`): List of parameters, depends on the driver.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `(unlabeled)` (of type `source(audio='#a+1, video='#b, midi='#c)`)

### `output.dummy`

Dummy output for debugging purposes.

Type:
```
(?id : string, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?start : bool, source('a)) -> active_source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `(unlabeled)` (of type `source('a)`)

### `output.external`

Send the stream to a process' standard input.

Type:
```
(?id : string, ?fallible : bool, ?flush : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?reopen_delay : float, ?reopen_on_metadata : bool,
 ?reopen_when : (() -> bool), ?start : bool, format('a),
 {string}, source('a)) -> active_source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `flush` (of type `bool`, which defaults to `false`): Perform a flush after each write.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `reopen_delay` (of type `float`, which defaults to `120.0`): Prevent re-opening within that delay, in seconds.
- `reopen_on_metadata` (of type `bool`, which defaults to `false`): Re-open on every new metadata information.
- `reopen_when` (of type `() -> bool`, which defaults to `{false}`): When should the output be re-opened.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `(unlabeled)` (of type `format('a)`): Encoding format.
- `(unlabeled)` (of type `{string}`): Process to pipe data to. Some strftime conversion specifiers are available: `%SMHdmY`. You can also use `$(..)` interpolation notation for metadata.
- `(unlabeled)` (of type `source('a)`)

### `output.file`

Output the source stream to a file.

Type:
```
(?id : string, ?append : bool, ?dir_perm : int,
 ?fallible : bool, ?flush : bool,
 ?on_close : ((string) -> unit),
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?perm : int, ?reopen_delay : float,
 ?reopen_on_metadata : bool, ?reopen_when : (() -> bool),
 ?start : bool, format('a), {string}, source('a)) ->
active_source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `append` (of type `bool`, which defaults to `false`): Do not truncate but append in the file if it exists.
- `dir_perm` (of type `int`, which defaults to `511`): Permission of the directories if some have to be created, up to umask. Although you can enter values in octal notation (0oXXX) they will be displayed in decimal (for instance, 0o777 = 7*8^2 + 7*8 + 7 = 511).
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `flush` (of type `bool`, which defaults to `false`): Perform a flush after each write.
- `on_close` (of type `(string) -> unit`, which defaults to `<fun>`): This function will be called for each file, after that it is finished and closed. The filename will be passed as argument.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `perm` (of type `int`, which defaults to `438`): Permission of the file if it has to be created, up to umask. You can and should write this number in octal notation: 0oXXX. The default value is however displayed in decimal (0o666 = 6*8^2 + 6*8 + 6 = 438).
- `reopen_delay` (of type `float`, which defaults to `120.0`): Prevent re-opening within that delay, in seconds.
- `reopen_on_metadata` (of type `bool`, which defaults to `false`): Re-open on every new metadata information.
- `reopen_when` (of type `() -> bool`, which defaults to `{false}`): When should the output be re-opened.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `(unlabeled)` (of type `format('a)`): Encoding format.
- `(unlabeled)` (of type `{string}`): Filename where to output the stream. Some strftime conversion specifiers are available: `%SMHdmY`. You can also use `$(..)` interpolation notation for metadata.
- `(unlabeled)` (of type `source('a)`)

### `output.file.hls`

Output the source stream to an HTTP live stream served from a local directory.

Type:
```
(?id : string, ?encode_metadata : bool, ?fallible : bool,
 ?on_file_change : ((state : string, string) -> unit),
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?perm : int, ?persist : bool, ?persist_at : string,
 ?playlist : string, ?segment_duration : float,
 ?segment_name : ((position : int, extname : string,
                   string) -> string),
 ?segments : int, ?segments_overhead : int,
 ?start : bool,
 ?streams_info : [string * (int * string * string)],
 string, [string * format('a)], source('a)) ->
active_source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `encode_metadata` (of type `bool`, which defaults to `false`): Insert metadata into encoded stream. Note: Some HLS players (in particular android native HLS player) expect a single mpegts stream. Encoding metadata will break that assumption.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `on_file_change` (of type `(state : string, string) -> unit`, which defaults to `<fun>`): Callback executed when a file changes. `state` is one of: `"opened"`, `"closed"` or `"deleted"`, second argument is file path. Typical use: upload files to a CDN when done writting (`"close"` state and remove when `"deleted"`.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `perm` (of type `int`, which defaults to `420`): Permission of the created files, up to umask. You can and should write this number in octal notation: 0oXXX. The default value is however displayed in decimal (0o666 = 6*8^2 + 4*8 + 4 = 412).
- `persist` (of type `bool`, which defaults to `false`): Persist output accross restart. If enabled, generated files (segments and playlists) are kept on shutdown and the output state at the location given by `persist_at` and used on restart.
- `persist_at` (of type `string`, which defaults to `"state.config"`): Location of the configuration file used to restart the output when `persist=true`. Relative paths are assumed to be with regard to the directory for generated file.
- `playlist` (of type `string`, which defaults to `"stream.m3u8"`): Playlist name (m3u8 extension is recommended).
- `segment_duration` (of type `float`, which defaults to `10.0`): Segment duration (in seconds).
- `segment_name` (of type `(position : int, extname : string, string) -> string`, which defaults to `<fun>`): Segment name. Default: `fun (~position,~extname,stream_name) -> "#{stream_name}_#{position}.#{extname}"`
- `segments` (of type `int`, which defaults to `10`): Number of segments per playlist.
- `segments_overhead` (of type `int`, which defaults to `5`): Number of segments to keep after they have been featured in the live playlist.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `streams_info` (of type `[string * (int * string * string)]`, which defaults to `[]`): Additional information about the streams. Should be a list of the form: `[(stream_name, (bandwidth, codec, extname)]`. See RFC 6381 for info about codec. Stream info are required when they cannot be inferred from the encoder.
- `(unlabeled)` (of type `string`): Directory for generated files.
- `(unlabeled)` (of type `[string * format('a)]`): List of specifications for each stream: (name, format).
- `(unlabeled)` (of type `source('a)`)

### `output.gstreamer.audio`

Output stream to a GStreamer pipeline.

Type:
```
(?id : string, ?clock_safe : bool, ?fallible : bool,
 ?on_error : ((string) -> float),
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?pipeline : string, ?start : bool, source(audio='#a+1,
 video='#b, midi='#c)) -> active_source(audio='#a+1,
video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `clock_safe` (of type `bool`, which defaults to `true`): Use the dedicated GStreamer clock.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens. The callback receives a string representation of the error that occured and returns a float. If returned value is positive, connection will be tried again after this amount of time (in seconds).
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `pipeline` (of type `string`, which defaults to `"autoaudiosink"`): GStreamer pipeline for sink.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `(unlabeled)` (of type `source(audio='#a+1, video='#b, midi='#c)`)

### `output.gstreamer.audio_video`

Output stream to a GStreamer pipeline.

Type:
```
(?id : string, ?audio_pipeline : string,
 ?blocking : bool, ?clock_safe : bool, ?fallible : bool,
 ?on_error : ((string) -> float),
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?pipeline : string, ?start : bool,
 ?video_pipeline : string, source(audio='#a+1,
 video='#b+1, midi='#c)) -> active_source(audio='#a+1,
video='#b+1, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `audio_pipeline` (of type `string`, which defaults to `"autoaudiosink"`): GStreamer pipeline for audio sink.
- `blocking` (of type `bool`, which defaults to `true`): Pushing buffers is blocking.
- `clock_safe` (of type `bool`, which defaults to `true`): Use the dedicated GStreamer clock.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens. The callback receives a string representation of the error that occured and returns a float. If returned value is positive, connection will be tried again after this amount of time (in seconds).
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `pipeline` (of type `string`, which defaults to `""`): GStreamer pipeline for sink.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `video_pipeline` (of type `string`, which defaults to `"videoconvert ! autovideosink"`): GStreamer pipeline for video sink.
- `(unlabeled)` (of type `source(audio='#a+1, video='#b+1, midi='#c)`)

### `output.gstreamer.video`

Output stream to a GStreamer pipeline.

Type:
```
(?id : string, ?clock_safe : bool, ?fallible : bool,
 ?on_error : ((string) -> float),
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?pipeline : string, ?start : bool, source(audio='#a,
 video='#b+1, midi='#c)) -> active_source(audio='#a,
video='#b+1, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `clock_safe` (of type `bool`, which defaults to `true`): Use the dedicated GStreamer clock.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens. The callback receives a string representation of the error that occured and returns a float. If returned value is positive, connection will be tried again after this amount of time (in seconds).
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `pipeline` (of type `string`, which defaults to `"videoconvert ! autovideosink"`): GStreamer pipeline for sink.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `(unlabeled)` (of type `source(audio='#a, video='#b+1, midi='#c)`)

### `output.harbor`

Encode and output the stream using the harbor server.

Type:
```
(?id : string, ?auth : ((string, string) -> bool),
 ?buffer : int, ?burst : int, ?chunk : int,
 ?dumpfile : string, ?encoding : string,
 ?fallible : bool, ?format : string,
 ?headers : [string * string], ?metaint : int,
 mount : string,
 ?on_connect : ((headers : [string * string],
                 uri : string, protocol : string, string) ->
                unit),
 ?on_disconnect : ((string) -> unit),
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?password : string, ?port : int, ?start : bool,
 ?timeout : float, ?url : string, ?user : string,
 format('a), source('a)) -> active_source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `auth` (of type `(string, string) -> bool`, which defaults to `fun (_,_) -> false`): Authentication function. `f(login,password)` returns `true` if the user should be granted access for this login. Override any other method if used.
- `buffer` (of type `int`, which defaults to `327675`): Maximun buffer per-client.
- `burst` (of type `int`, which defaults to `65534`): Initial burst of data sent to the client.
- `chunk` (of type `int`, which defaults to `1024`): Send data to clients using chunks of at least this length.
- `dumpfile` (of type `string`, which defaults to `""`): Dump stream to file, for debugging purpose. Disabled if empty.
- `encoding` (of type `string`, which defaults to `""`): Encoding used to send metadata. If empty, defaults to "ISO-8859-1" for non-ogg formats and "UTF-8" otherwise.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `format` (of type `string`, which defaults to `""`): Format, e.g. "audio/ogg". When empty, the encoder is used to guess.
- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `metaint` (of type `int`, which defaults to `16000`): Interval used to send ICY metadata
- `mount` (of type `string`)
- `on_connect` (of type `(headers : [string * string], uri : string,
 protocol : string, string) -> unit`, which defaults to `<fun>`): Callback executed when connection is established.
- `on_disconnect` (of type `(string) -> unit`, which defaults to `<fun>`): Callback executed when connection stops.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `password` (of type `string`, which defaults to `"hackme"`)
- `port` (of type `int`, which defaults to `8000`)
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `timeout` (of type `float`, which defaults to `30.0`): Timeout for network operations.
- `url` (of type `string`, which defaults to `""`)
- `user` (of type `string`, which defaults to `""`): User for client connection, disabled if empty.
- `(unlabeled)` (of type `format('a)`): Encoding format.
- `(unlabeled)` (of type `source('a)`)

### `output.harbor.hls`

Output the source stream to an HTTP live stream served from the harbor HTTP server.

Type:
```
(?id : string, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?encode_metadata : bool, ?segment_duration : float,
 ?segments : int, ?segments_overhead : int,
 ?streams_info : [string * (int * string * string)],
 ?tmpdir : string,
 ?segment_name : ((position : int, extname : string,
                   string) -> string),
 ?start : bool, ?playlist : string, ?port : int,
 ?path : string,
 ?on_file_change : ((state : string, string) -> unit),
 ?headers : [string * string], ?persist : bool,
 ?persist_at : string, [string * format('a)], source('a)) ->
active_source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `encode_metadata` (of type `bool`, which defaults to `false`): Insert metadata into encoded stream. Note: Some HLS players (in particular android native HLS player) expect a single mpegts stream. Encoding metadata will break that assumption.
- `segment_duration` (of type `float`, which defaults to `10.0`): Segment duration (in seconds).
- `segments` (of type `int`, which defaults to `15`): Number of segments per playlist.
- `segments_overhead` (of type `int`, which defaults to `10`): Number of segments to keep after they have been featured in the live playlist.
- `streams_info` (of type `[string * (int * string * string)]`, which defaults to `[]`): Additional information about the streams. Should be a list of the form: `[(stream_name, (bandwidth, codec, extname)]`. See RFC 6381 for info about codec. Stream info are required when they cannot be inferred from the encoder.
- `tmpdir` (of type `string`, which defaults to `""`): Directory for generated files.
- `segment_name` (of type `(position : int, extname : string, string) -> string`, which defaults to `<fun>`): Segment name. Default: `fun (~position,~extname,stream_name) -> "#{stream_name}_#{position}.#{extname}"`
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `playlist` (of type `string`, which defaults to `"stream.m3u8"`): Playlist name (m3u8 extension is recommended).
- `port` (of type `int`, which defaults to `8000`): Port for incoming harbor (http) connections.
- `path` (of type `string`, which defaults to `"/"`): Base path for hls URIs.
- `on_file_change` (of type `(state : string, string) -> unit`, which defaults to `<fun>`): Callback executed when a file changes. `state` is one of: `"opened"`, `"closed"` or `"deleted"`, second argument is file path. Typical use: upload files to a CDN when done writting (`"close"` state and remove when `"deleted"`.
- `headers` (of type `[string * string]`, which defaults to `[("Access-Control-Allow-Origin", "*")]`): Default response headers.
- `persist` (of type `bool`, which defaults to `false`): Persist output accross restart. If enabled, generated files (segments and playlists) are kept on shutdown and the output state at the location given by `persist_at` and used on restart.
- `persist_at` (of type `string`, which defaults to `"state.config"`): Location of the configuration file used to restart the output when `persist=true`. Relative paths are assumed to be with regard to the directory for generated file.
- `(unlabeled)` (of type `[string * format('a)]`): List of specifications for each stream: (name, format).
- `(unlabeled)` (of type `source('a)`)

### `output.harbor.ssl`

Encode and output the stream using the SSL harbor server.

Type:
```
(?id : string, ?auth : ((string, string) -> bool),
 ?buffer : int, ?burst : int, ?chunk : int,
 ?dumpfile : string, ?encoding : string,
 ?fallible : bool, ?format : string,
 ?headers : [string * string], ?metaint : int,
 mount : string,
 ?on_connect : ((headers : [string * string],
                 uri : string, protocol : string, string) ->
                unit),
 ?on_disconnect : ((string) -> unit),
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?password : string, ?port : int, ?start : bool,
 ?timeout : float, ?url : string, ?user : string,
 format('a), source('a)) -> active_source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `auth` (of type `(string, string) -> bool`, which defaults to `fun (_,_) -> false`): Authentication function. `f(login,password)` returns `true` if the user should be granted access for this login. Override any other method if used.
- `buffer` (of type `int`, which defaults to `327675`): Maximun buffer per-client.
- `burst` (of type `int`, which defaults to `65534`): Initial burst of data sent to the client.
- `chunk` (of type `int`, which defaults to `1024`): Send data to clients using chunks of at least this length.
- `dumpfile` (of type `string`, which defaults to `""`): Dump stream to file, for debugging purpose. Disabled if empty.
- `encoding` (of type `string`, which defaults to `""`): Encoding used to send metadata. If empty, defaults to "ISO-8859-1" for non-ogg formats and "UTF-8" otherwise.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `format` (of type `string`, which defaults to `""`): Format, e.g. "audio/ogg". When empty, the encoder is used to guess.
- `headers` (of type `[string * string]`, which defaults to `[]`): Additional headers.
- `metaint` (of type `int`, which defaults to `16000`): Interval used to send ICY metadata
- `mount` (of type `string`)
- `on_connect` (of type `(headers : [string * string], uri : string,
 protocol : string, string) -> unit`, which defaults to `<fun>`): Callback executed when connection is established.
- `on_disconnect` (of type `(string) -> unit`, which defaults to `<fun>`): Callback executed when connection stops.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `password` (of type `string`, which defaults to `"hackme"`)
- `port` (of type `int`, which defaults to `8000`)
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `timeout` (of type `float`, which defaults to `30.0`): Timeout for network operations.
- `url` (of type `string`, which defaults to `""`)
- `user` (of type `string`, which defaults to `""`): User for client connection, disabled if empty.
- `(unlabeled)` (of type `format('a)`): Encoding format.
- `(unlabeled)` (of type `source('a)`)

### `output.icecast`

Encode and output the stream to an icecast2 or shoutcast server.

Type:
```
(?id : string, ?chunked : bool,
 ?connection_timeout : float, ?description : string,
 ?dumpfile : string, ?encoding : string,
 ?fallible : bool, ?format : string, ?genre : string,
 ?headers : [string * string], ?host : string,
 ?icy_id : int, ?icy_metadata : string, ?mount : string,
 ?name : string, ?on_connect : (() -> unit),
 ?on_disconnect : (() -> unit),
 ?on_error : ((string) -> float),
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?password : string, ?port : int, ?protocol : string,
 ?public : bool, ?start : bool, ?timeout : float,
 ?url : string, ?user : string, ?verb : string,
 format('a), source('a)) -> active_source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `chunked` (of type `bool`, which defaults to `false`): Used cunked transfer with the 'http(s)' protocol.
- `connection_timeout` (of type `float`, which defaults to `5.0`): Timeout for establishing network connections (disabled is negative).
- `description` (of type `string`, which defaults to `""`)
- `dumpfile` (of type `string`, which defaults to `""`): Dump stream to file, for debugging purpose. Disabled if empty.
- `encoding` (of type `string`, which defaults to `""`): Encoding used to send metadata and stream info (name, genre and description). If empty, defaults to "UTF-8" for "http(s)" protocol and "ISO-8859-1" for "icy" protocol.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `format` (of type `string`, which defaults to `""`): Format, e.g. "audio/ogg". When empty, the encoder is used to guess.
- `genre` (of type `string`, which defaults to `""`)
- `headers` (of type `[string * string]`, which defaults to `[("User-Agent", "Liquidsoap/1.4.4 (Unix; OCaml 4.10.0)")]`): Additional headers.
- `host` (of type `string`, which defaults to `"localhost"`)
- `icy_id` (of type `int`, which defaults to `1`): Shoutcast source ID. Only supported by Shoutcast v2.
- `icy_metadata` (of type `string`, which defaults to `"guess"`): Send new metadata using the ICY protocol. One of: "guess", "true", "false"
- `mount` (of type `string`, which defaults to `"Use [name]"`): Source mount point. Mandatory when streaming to icecast.
- `name` (of type `string`, which defaults to `"Use [mount]"`)
- `on_connect` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when connection is established.
- `on_disconnect` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when connection stops.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens. The callback receives a string representation of the error that occured and returns a float. If returned value is positive, connection will be tried again after this amount of time (in seconds).
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `password` (of type `string`, which defaults to `"hackme"`)
- `port` (of type `int`, which defaults to `8000`)
- `protocol` (of type `string`, which defaults to `"http"`): Protocol of the streaming server: 'http' or 'https' for Icecast, 'icy' for shoutcast.
- `public` (of type `bool`, which defaults to `true`)
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `timeout` (of type `float`, which defaults to `30.0`): Timeout for network read and write.
- `url` (of type `string`, which defaults to `""`)
- `user` (of type `string`, which defaults to `""`): User for shout source connection. Defaults to "source" for icecast connections. Useful only in special cases, like with per-mountpoint users.
- `verb` (of type `string`, which defaults to `"source"`): Verb to use with the 'http(s)' protocol. One of: 'source', 'put' or 'post'.
- `(unlabeled)` (of type `format('a)`): Encoding format.
- `(unlabeled)` (of type `source('a)`)

### `output.jack`

Output stream to jack.

Type:
```
(?id : string, ?buffer_size : int, ?clock_safe : bool,
 ?fallible : bool, ?on_start : (() -> unit),
 ?on_stop : (() -> unit), ?server : string,
 ?start : bool, source(audio='#a+1, video=0, midi=0)) ->
active_source(audio='#a+1, video=0, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `buffer_size` (of type `int`, which defaults to `2`): Set buffer size, in frames.
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of the dedicated bjack clock.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `server` (of type `string`, which defaults to `""`): Jack server to connect to.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `(unlabeled)` (of type `source(audio='#a+1, video=0, midi=0)`)

### `output.oss`

Output the source's stream to an OSS output device.

Type:
```
(?id : string, ?clock_safe : bool, ?device : string,
 ?fallible : bool, ?on_start : (() -> unit),
 ?on_stop : (() -> unit), ?start : bool,
 source(audio='#a+1, video='#b, midi='#c)) ->
active_source(audio='#a+1, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of the dedicated OSS clock.
- `device` (of type `string`, which defaults to `"/dev/dsp"`): OSS device to use.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `(unlabeled)` (of type `source(audio='#a+1, video='#b, midi='#c)`)

### `output.portaudio`

Output the source's stream to a portaudio output device.

Type:
```
(?id : string, ?buflen : int, ?clock_safe : bool,
 ?fallible : bool, ?on_start : (() -> unit),
 ?on_stop : (() -> unit), ?start : bool,
 source(audio='#a+1, video='#b, midi='#c)) ->
active_source(audio='#a+1, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `buflen` (of type `int`, which defaults to `256`): Length of a buffer in samples.
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of the dedicated Portaudio clock.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `(unlabeled)` (of type `source(audio='#a+1, video='#b, midi='#c)`)

### `output.prefered`

Output to local audio card using the first available driver in pulseaudio, portaudio, oss, alsa, ao, dummy.

Type:
```
(?id : string, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?start : bool, source(audio='#a+1, video='#b, midi='#c)) ->
active_source(audio='#a+1, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`)
- `fallible` (of type `bool`, which defaults to `false`)
- `on_start` (of type `() -> unit`, which defaults to `<fun>`)
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`)
- `start` (of type `bool`, which defaults to `true`)
- `(unlabeled)` (of type `source(audio='#a+1, video='#b, midi='#c)`)

### `output.pulseaudio`

Output the source's stream to a portaudio output device.

Type:
```
(?id : string, ?client : string, ?clock_safe : bool,
 ?device : string, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?start : bool, source(audio='#a+1, video='#b, midi='#c)) ->
active_source(audio='#a+1, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `client` (of type `string`, which defaults to `"liquidsoap"`)
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of the dedicated Pulseaudio clock.
- `device` (of type `string`, which defaults to `""`): Device to use. Uses default if set to "".
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `(unlabeled)` (of type `source(audio='#a+1, video='#b, midi='#c)`)

### `output.shoutcast`

Output to shoutcast.

Type:
```
(?id : string, ?start : bool, ?host : string,
 ?port : int, ?user : string, ?password : string,
 ?genre : string, ?url : string, ?name : string,
 ?encoding : string, ?public : bool, ?icy_id : int,
 ?format : string, ?dj : (() -> string),
 ?dumpfile : string, ?icy_metadata : string,
 ?on_connect : (() -> unit),
 ?on_disconnect : (() -> unit), ?aim : string,
 ?icq : string, ?irc : string, ?icy_reset : bool,
 ?fallible : bool, ?on_start : (() -> unit),
 ?on_stop : (() -> unit),
 ?on_error : ((string) -> float), format('a), source('a)) ->
active_source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `"output.shoutcast"`): Output's ID
- `start` (of type `bool`, which defaults to `true`): Start output threads on operator initialization.
- `host` (of type `string`, which defaults to `"localhost"`)
- `port` (of type `int`, which defaults to `8000`)
- `user` (of type `string`, which defaults to `""`): User for shout source connection. Useful only in special cases, like with per-mountpoint users.
- `password` (of type `string`, which defaults to `"hackme"`)
- `genre` (of type `string`, which defaults to `""`)
- `url` (of type `string`, which defaults to `""`)
- `name` (of type `string`, which defaults to `""`)
- `encoding` (of type `string`, which defaults to `"ISO-8859-1"`): Encoding used to send metadata and stream info.
- `public` (of type `bool`, which defaults to `true`)
- `icy_id` (of type `int`, which defaults to `1`): Shoutcast source ID. Only supported by Shoutcast v2.
- `format` (of type `string`, which defaults to `""`): Format, e.g. "audio/ogg". When empty, the encoder is used to guess.
- `dj` (of type `() -> string`, which defaults to `{""}`): Callback to set dj name.
- `dumpfile` (of type `string`, which defaults to `""`): Dump stream to file, for debugging purpose. Disabled if empty.
- `icy_metadata` (of type `string`, which defaults to `"guess"`): Send new metadata using the ICY protocol. One of: "guess", "true", "false"
- `on_connect` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when connection starts.
- `on_disconnect` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when connection stops.
- `aim` (of type `string`, which defaults to `""`)
- `icq` (of type `string`, which defaults to `""`)
- `irc` (of type `string`, which defaults to `""`)
- `icy_reset` (of type `bool`, which defaults to `true`): Reset shoutcast source buffer upon connecting (necessary for NSV).
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens. If returned value is positive, connection wll be tried again after this amount of time (in seconds).
- `(unlabeled)` (of type `format('a)`): Encoding format. For shoutcast, should be mp3 or AAC(+).
- `(unlabeled)` (of type `source('a)`): The source to output

### `output.srt`

Send a SRT stream to a distant host.

Type:
```
(?id : string, ?clock_safe : bool, ?fallible : bool,
 ?host : string, ?messageapi : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?payload_size : int, ?port : int, ?start : bool,
 format('a), source('a)) -> active_source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `clock_safe` (of type `bool`, which defaults to `true`): Force the use of a decicated clock.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `host` (of type `string`, which defaults to `"localhost"`): Address to connect to.
- `messageapi` (of type `bool`, which defaults to `true`): Use message api
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `payload_size` (of type `int`, which defaults to `1316`): Payload size.
- `port` (of type `int`, which defaults to `8000`): Port to bind on the local machine. The term `port` as used in SRT is occasionally identical to the term `UDP port`. However SRT offers more flexibility than UDP because it manages ports as its own resources. For example, one port may be shared between various services.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `(unlabeled)` (of type `format('a)`): Encoding format.
- `(unlabeled)` (of type `source('a)`)

### `output.udp`

Output encoded data to UDP, without any control whatsoever.

Type:
```
(?id : string, ?fallible : bool, host : string,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 port : int, ?start : bool, format('a), source('a)) ->
active_source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `host` (of type `string`)
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `port` (of type `int`)
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `(unlabeled)` (of type `format('a)`): Encoding format.
- `(unlabeled)` (of type `source('a)`)

This function is experimental.

### `output.youtube.live`

Stream live on youtube. You need the following Gstreamer plugins: flvmux, rtmpsink, x264enc and a suitable AAC encoder (see `audio_encoder` params).

Type:
```
(?id : string, ?video_bitrate : int,
 ?audio_encoder : string, ?audio_bitrate : int,
 ?url : string, key : string, source(audio='#a+1,
 video='#b+1, midi='#c)) -> active_source(audio='#a+1,
video='#b+1, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Source ID
- `video_bitrate` (of type `int`, which defaults to `2000`): Video bitrate
- `audio_encoder` (of type `string`, which defaults to `"fdkaacenc"`): Audio encoder. Can be one of: "fdkaacenc", "voaacenc"
- `audio_bitrate` (of type `int`, which defaults to `128000`): Audio bitrate
- `url` (of type `string`, which defaults to `"rtmp://a.rtmp.youtube.com/live2"`): Server URL
- `key` (of type `string`): Secret key
- `(unlabeled)` (of type `source(audio='#a+1, video='#b+1, midi='#c)`): Source to stream

## Source / Sound Processing

### `add`

Mix sources, with optional normalization. Only relay metadata from the first source that is effectively summed.

Type:
```
(?id : string, ?normalize : bool, ?weights : [int],
 [source(audio='#a, video='#b, midi=0)]) ->
source(audio='#a, video='#b, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `normalize` (of type `bool`, which defaults to `true`)
- `weights` (of type `[int]`, which defaults to `[]`): Relative weight of the sources in the sum. The empty list stands for the homogeneous distribution.
- `(unlabeled)` (of type `[source(audio='#a, video='#b, midi=0)]`)

### `amplify`

Multiply the amplitude of the signal.

Type:
```
(?id : string, ?override : string, {float},
 source(audio='#b, video='#c, midi='#d)) ->
source(audio='#b, video='#c, midi='#d)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `override` (of type `string`, which defaults to `"liq_amplify"`): Specify the name of a metadata field that, when present and well-formed, overrides the amplification factor for the current track. Well-formed values are floats in decimal notation (e.g. `0.7`) which are taken as normal/linear multiplicative factors; values can be passed in decibels with the suffix `dB` (e.g. `-8.2 dB`, but the spaces do not matter). Set to empty string `""` to disable.
- `(unlabeled)` (of type `{float}`): Multiplicative factor.
- `(unlabeled)` (of type `source(audio='#b, video='#c, midi='#d)`)

### `bpm`

Detect the BPM.

Type:
```
(?id : string, ?every : float, ((float) -> unit),
 source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `every` (of type `float`, which defaults to `1.0`): Interval at which BPM is computed (in second).
- `(unlabeled)` (of type `(float) -> unit`): Callback function.
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `clip`

Clip samples, i.e. ensure that all values are between -1 and 1: values lower than -1 become -1 and values higher than 1 become 1.

Type:
```
(?id : string, source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `comb`

Comb filter.

Type:
```
(?id : string, ?delay : float, ?feedback : {float},
 source(audio='#b, video='#c, midi='#d)) ->
source(audio='#b, video='#c, midi='#d)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `delay` (of type `float`, which defaults to `0.001`): Delay in seconds.
- `feedback` (of type `{float}`, which defaults to `-6.0`): Feedback coefficient in dB.
- `(unlabeled)` (of type `source(audio='#b, video='#c, midi='#d)`)

### `compand`

Compand the signal

Type:
```
(?id : string, ?mu : float, source(audio='#a, video='#b,
 midi='#c)) -> source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `mu` (of type `float`, which defaults to `1.0`)
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `compress`

Compress the signal.

Type:
```
(?id : string, ?attack : {float}, ?gain : {float},
 ?knee : {float}, ?ratio : {float}, ?release : {float},
 ?threshold : {float}, ?window : float, source(audio='#g,
 video='#h, midi='#i)) -> source(audio='#g, video='#h,
midi='#i)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `attack` (of type `{float}`, which defaults to `100.0`): Attack time (ms).
- `gain` (of type `{float}`, which defaults to `0.0`): Additional gain (dB).
- `knee` (of type `{float}`, which defaults to `1.0`): Knee radius (dB).
- `ratio` (of type `{float}`, which defaults to `2.0`): Gain reduction ratio (n:1).
- `release` (of type `{float}`, which defaults to `400.0`): Release time (ms).
- `threshold` (of type `{float}`, which defaults to `-10.0`): Threshold level (dB).
- `window` (of type `float`, which defaults to `0.1`): Window for computing RMS (in sec).
- `(unlabeled)` (of type `source(audio='#g, video='#h, midi='#i)`)

### `compress.exponential`

Exponential compressor.

Type:
```
(?id : string, ?mu : float, source(audio='#a, video='#b,
 midi='#c)) -> source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `mu` (of type `float`, which defaults to `2.0`): Exponential compression factor, typically greater than 1.
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `cross`

Cross operator, allowing the composition of the N last seconds of a track with the beginning of the next track, using a transition function depending on the relative power of the signal before and after the end of track.

Type:
```
(?id : string, ?active : bool, ?conservative : bool,
 ?duration : float, ?minimum : float,
 ?override_duration : string, ?width : float,
 ((float, float, [string * string], [string * string],
   source(audio='#a+1, video=0, midi=0),
   source(audio='#a+1, video=0, midi=0)) ->
  source(audio='#a+1, video=0, midi=0)),
 source(audio='#a+1, video=0, midi=0)) ->
source(audio='#a+1, video=0, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `active` (of type `bool`, which defaults to `false`): The active behavior is to keep ticking the child's clock when the operator is not streaming. Otherwise the child's clock is strictly based on what is streamed off the child source, which results in time-dependent active sources to be frozen when that source is stopped.
- `conservative` (of type `bool`, which defaults to `true`): Do not trust remaining time estimations, always buffering data in advance. This avoids being tricked by skips, either manual or caused by skip_blank().
- `duration` (of type `float`, which defaults to `5.0`): Duration (in seconds) of buffered data from each track that is used to compute the transision between tracks.
- `minimum` (of type `float`, which defaults to `-1.0`): Minimum duration (in sec.) for a cross: If the track ends without any warning (e.g. in case of skip) there may not be enough data for a decent composition. Set to 0. to avoid having transitions after skips, or more to avoid transitions on short tracks. With a negative default, transitions always occur.
- `override_duration` (of type `string`, which defaults to `"liq_cross_duration"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
- `width` (of type `float`, which defaults to `2.0`): Width of the power computation window.
- `(unlabeled)` (of type `(float, float, [string * string], [string * string],
 source(audio='#a+1, video=0, midi=0),
 source(audio='#a+1, video=0, midi=0)) ->
source(audio='#a+1, video=0, midi=0)`): Transition function, composing from the end of a track and the next track. It also takes the power of the signal before and after the transition, and the metadata.
- `(unlabeled)` (of type `source(audio='#a+1, video=0, midi=0)`)

### `echo`

Add echo.

Type:
```
(?id : string, ?delay : {float}, ?feedback : {float},
 ?ping_pong : bool, source(audio='#c, video='#d,
 midi='#e)) -> source(audio='#c, video='#d, midi='#e)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `delay` (of type `{float}`, which defaults to `0.5`): Delay in seconds.
- `feedback` (of type `{float}`, which defaults to `-6.0`): Feedback coefficient in dB (negative).
- `ping_pong` (of type `bool`, which defaults to `false`): Use ping-pong delay.
- `(unlabeled)` (of type `source(audio='#c, video='#d, midi='#e)`)

### `fade.final`

Fade a stream to silence.

Type:
```
(?id : string, ?duration : float, ?type : string,
 source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `"fade.final"`): Force the value of the source ID.
- `duration` (of type `float`, which defaults to `3.0`): Duration of the fading.
- `type` (of type `string`, which defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `fade.in`

Fade the beginning of tracks.

Type:
```
(?id : string, ?duration : float,
 ?override_duration : string, ?override_type : string,
 ?type : string, source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `"fade.in"`): Force the value of the source ID.
- `duration` (of type `float`, which defaults to `3.0`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
- `override_duration` (of type `string`, which defaults to `"liq_fade_in"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
- `override_type` (of type `string`, which defaults to `"liq_fade_type"`): Metadata field which, if present and correct, overrides the 'type' parameter for current track.
- `type` (of type `string`, which defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `fade.initial`

Fade the beginning of a stream.

Type:
```
(?id : string, ?duration : float, ?type : string,
 source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `"fade.initial"`): Force the value of the source ID.
- `duration` (of type `float`, which defaults to `3.0`): Duration of the fading.
- `type` (of type `string`, which defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `fade.out`

Fade the end of tracks.

Type:
```
(?id : string, ?duration : float,
 ?override_duration : string, ?override_type : string,
 ?type : string, source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `"fade.out"`): Force the value of the source ID.
- `duration` (of type `float`, which defaults to `3.0`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
- `override_duration` (of type `string`, which defaults to `"liq_fade_out"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
- `override_type` (of type `string`, which defaults to `"liq_fade_type"`): Metadata field which, if present and correct, overrides the 'type' parameter for current track.
- `type` (of type `string`, which defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `fade.skip`

Fade when the metadata trigger is received and then skip.

Type:
```
(?id : string, ?duration : float,
 ?override_duration : string, ?override_type : string,
 ?override_skip : string, ?type : string,
 source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `"fade.skip"`): Force the value of the source ID.
- `duration` (of type `float`, which defaults to `5.0`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
- `override_duration` (of type `string`, which defaults to `"liq_fade_skip"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
- `override_type` (of type `string`, which defaults to `"liq_fade_skip"`): Metadata field which, if present and correct, overrides the 'type' parameter for current track.
- `override_skip` (of type `string`, which defaults to `"liq_skip_meta"`)
- `type` (of type `string`, which defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `filter`

Perform several kinds of filtering on the signal

Type:
```
(?id : string, freq : {float}, mode : string,
 ?q : {float}, ?wetness : {float}, source(audio='#d,
 video='#e, midi='#f)) -> source(audio='#d, video='#e,
midi='#f)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `freq` (of type `{float}`)
- `mode` (of type `string`): Available modes are 'low' (for low-pass filter), 'high' (for high-pass filter), 'band' (for band-pass filter) and 'notch' (for notch / band-stop / band-rejection filter).
- `q` (of type `{float}`, which defaults to `1.0`)
- `wetness` (of type `{float}`, which defaults to `1.0`): How much of the original signal should be added (1. means only filtered and 0. means only original signal).
- `(unlabeled)` (of type `source(audio='#d, video='#e, midi='#f)`)

### `filter.fir`

Low-pass FIR filter.

Type:
```
(?id : string, beta : float, ?coeffs : int,
 frequency : float, source(audio='#a, video='#b,
 midi='#c)) -> source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `beta` (of type `float`): Beta should range between 0 and 1.
- `coeffs` (of type `int`, which defaults to `255`): Number of coefficients
- `frequency` (of type `float`): Corner frequency in Hz (frequency at which the response is 0.5, that is -6 dB).
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `filter.iir.butterworth.bandpass`

IIR filter

Type:
```
(?id : string, frequency1 : float, frequency2 : float,
 ?order : int, source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `frequency1` (of type `float`): First corner frequency
- `frequency2` (of type `float`): Second corner frequency
- `order` (of type `int`, which defaults to `4`): Filter order
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `filter.iir.butterworth.bandstop`

IIR filter

Type:
```
(?id : string, frequency1 : float, frequency2 : float,
 ?order : int, source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `frequency1` (of type `float`): First corner frequency
- `frequency2` (of type `float`): Second corner frequency
- `order` (of type `int`, which defaults to `4`): Filter order
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `filter.iir.butterworth.high`

IIR filter

Type:
```
(?id : string, frequency : float, ?order : int,
 source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `frequency` (of type `float`): Corner frequency
- `order` (of type `int`, which defaults to `4`): Filter order
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `filter.iir.butterworth.low`

IIR filter

Type:
```
(?id : string, frequency : float, ?order : int,
 source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `frequency` (of type `float`): Corner frequency
- `order` (of type `int`, which defaults to `4`): Filter order
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `filter.iir.eq.allpass`

All pass biquad filter.

Type:
```
(?id : string, ?bandwidth : float, frequency : float,
 source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `bandwidth` (of type `float`, which defaults to `0.333333333333`): Bandwidth (in octaves)
- `frequency` (of type `float`): Center frequency
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `filter.iir.eq.bandpass`

Band pass biquad filter.

Type:
```
(?id : string, frequency : float, ?q : float,
 source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `frequency` (of type `float`): Center frequency
- `q` (of type `float`, which defaults to `1.0`): Q
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `filter.iir.eq.high`

High pass biquad filter.

Type:
```
(?id : string, frequency : float, ?q : float,
 source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `frequency` (of type `float`): Corner frequency
- `q` (of type `float`, which defaults to `1.0`): Q
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `filter.iir.eq.highshelf`

High shelf biquad filter.

Type:
```
(?id : string, frequency : float, ?slope : float,
 source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `frequency` (of type `float`): Center frequency
- `slope` (of type `float`, which defaults to `1.0`): Shelf slope (in dB/octave)
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `filter.iir.eq.low`

Low pass biquad filter.

Type:
```
(?id : string, frequency : float, ?q : float,
 source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `frequency` (of type `float`): Corner frequency
- `q` (of type `float`, which defaults to `1.0`): Q
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `filter.iir.eq.lowshelf`

Low shelf biquad filter.

Type:
```
(?id : string, frequency : float, ?slope : float,
 source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `frequency` (of type `float`): Corner frequency
- `slope` (of type `float`, which defaults to `1.0`): Shelf slope (dB/octave)
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `filter.iir.eq.notch`

Band pass biquad filter.

Type:
```
(?id : string, frequency : float, ?q : float,
 source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `frequency` (of type `float`): Center frequency
- `q` (of type `float`, which defaults to `1.0`): Q
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `filter.iir.eq.peak`

Peak EQ biquad filter.

Type:
```
(?id : string, frequency : float, ?gain : float,
 ?q : float, source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `frequency` (of type `float`): Center frequency
- `gain` (of type `float`, which defaults to `1.0`): Gain (in dB)
- `q` (of type `float`, which defaults to `1.0`): Q
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `filter.iir.resonator.allpass`

IIR filter

Type:
```
(?id : string, frequency : float, ?q : float,
 source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `frequency` (of type `float`): Corner frequency
- `q` (of type `float`, which defaults to `60.0`): Quality factor
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `filter.iir.resonator.bandpass`

IIR filter

Type:
```
(?id : string, frequency : float, ?q : float,
 source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `frequency` (of type `float`): Corner frequency
- `q` (of type `float`, which defaults to `60.0`): Quality factor
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `filter.iir.resonator.bandstop`

IIR filter

Type:
```
(?id : string, frequency : float, ?q : float,
 source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `frequency` (of type `float`): Corner frequency
- `q` (of type `float`, which defaults to `60.0`): Quality factor
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `filter.rc`

First-order filter (RC filter).

Type:
```
(?id : string, mode : string, rc : {float},
 ?wetness : {float}, source(audio='#c, video='#d,
 midi='#e)) -> source(audio='#c, video='#d, midi='#e)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `mode` (of type `string`): Available modes are 'low' (for low-pass filter), 'high' (for high-pass filter).
- `rc` (of type `{float}`): Time constant (in seconds).
- `wetness` (of type `{float}`, which defaults to `1.0`): How much of the original signal should be added (1. means only filtered and 0. means only original signal).
- `(unlabeled)` (of type `source(audio='#c, video='#d, midi='#e)`)

### `flanger`

Flanger effect.

Type:
```
(?id : string, ?delay : float, ?feedback : {float},
 ?freq : {float}, ?phase : {float}, source(audio='#d,
 video='#e, midi='#f)) -> source(audio='#d, video='#e,
midi='#f)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `delay` (of type `float`, which defaults to `0.001`): Delay in seconds.
- `feedback` (of type `{float}`, which defaults to `0.0`): Feedback coefficient in dB.
- `freq` (of type `{float}`, which defaults to `0.5`): Frequency in Hz.
- `phase` (of type `{float}`, which defaults to `1.0`): Phase difference between channels in radians.
- `(unlabeled)` (of type `source(audio='#d, video='#e, midi='#f)`)

### `helium`

Increases the pitch, making voices sound like on helium.

Type:
```
(source(audio='#a+1, video=0, midi=0)) ->
source(audio='#a+1, video=0, midi=0)
```

Arguments:

- `(unlabeled)` (of type `source(audio='#a+1, video=0, midi=0)`): The input source.

### `ladspa.amp_mono`

Mono Amplifier by Richard Furse (LADSPA example plugins).

Type:
```
(?id : string, ?gain : {float}, source(audio='#b,
 video='#c, midi='#d)) -> source(audio='#b, video='#c,
midi='#d)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `gain` (of type `{float}`, which defaults to `1.0`): Gain (0 <= `gain`).
- `(unlabeled)` (of type `source(audio='#b, video='#c, midi='#d)`)

### `ladspa.amp_stereo`

Stereo Amplifier by Richard Furse (LADSPA example plugins).

Type:
```
(?id : string, ?gain : {float}, source(audio=2, video=0,
 midi=0)) -> source(audio=2, video=0, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `gain` (of type `{float}`, which defaults to `1.0`): Gain (0 <= `gain`).
- `(unlabeled)` (of type `source(audio=2, video=0, midi=0)`)

### `ladspa.delay_5s`

Simple Delay Line by Richard Furse (LADSPA example plugins).

Type:
```
(?id : string, ?delay : {float},
 ?dry_wet_balance : {float}, source(audio='#c, video='#d,
 midi='#e)) -> source(audio='#c, video='#d, midi='#e)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `delay` (of type `{float}`, which defaults to `1.0`): Delay (Seconds) (0 <= `delay` <= 5).
- `dry_wet_balance` (of type `{float}`, which defaults to `0.5`): Dry/Wet Balance (0 <= `dry_wet_balance` <= 1).
- `(unlabeled)` (of type `source(audio='#c, video='#d, midi='#e)`)

### `ladspa.hpf`

Simple High Pass Filter by Richard Furse (LADSPA example plugins).

Type:
```
(?id : string, ?cutoff_frequency : {float},
 source(audio='#b, video='#c, midi='#d)) ->
source(audio='#b, video='#c, midi='#d)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `cutoff_frequency` (of type `{float}`, which defaults to `440.0`): Cutoff Frequency (Hz) (0 <= `cutoff_frequency` <= 22050).
- `(unlabeled)` (of type `source(audio='#b, video='#c, midi='#d)`)

### `ladspa.lpf`

Simple Low Pass Filter by Richard Furse (LADSPA example plugins).

Type:
```
(?id : string, ?cutoff_frequency : {float},
 source(audio='#b, video='#c, midi='#d)) ->
source(audio='#b, video='#c, midi='#d)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `cutoff_frequency` (of type `{float}`, which defaults to `440.0`): Cutoff Frequency (Hz) (0 <= `cutoff_frequency` <= 22050).
- `(unlabeled)` (of type `source(audio='#b, video='#c, midi='#d)`)

### `ladspa.noise_white`

White Noise Source by Richard Furse (LADSPA example plugins).

Type:
```
(?id : string, ?amplitude : {float}) -> source(audio=1,
video=0, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `amplitude` (of type `{float}`, which defaults to `1.0`): Amplitude (0 <= `amplitude`).

### `ladspa.sine_faaa`

Sine Oscillator (Freq:audio, Amp:audio) by Richard Furse (LADSPA example plugins).

Type:
```
(?id : string, source(audio=2, video=0, midi=0)) ->
source(audio=1, video=0, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio=2, video=0, midi=0)`)

### `ladspa.sine_faac`

Sine Oscillator (Freq:audio, Amp:control) by Richard Furse (LADSPA example plugins).

Type:
```
(?id : string, ?amplitude : {float}, source(audio='#b,
 video='#c, midi='#d)) -> source(audio='#b, video='#c,
midi='#d)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `amplitude` (of type `{float}`, which defaults to `1.0`): Amplitude (0 <= `amplitude`).
- `(unlabeled)` (of type `source(audio='#b, video='#c, midi='#d)`)

### `ladspa.sine_fcaa`

Sine Oscillator (Freq:control, Amp:audio) by Richard Furse (LADSPA example plugins).

Type:
```
(?id : string, ?frequency : {float}, source(audio='#b,
 video='#c, midi='#d)) -> source(audio='#b, video='#c,
midi='#d)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `frequency` (of type `{float}`, which defaults to `440.0`): Frequency (Hz) (0 <= `frequency` <= 22050).
- `(unlabeled)` (of type `source(audio='#b, video='#c, midi='#d)`)

### `ladspa.sine_fcac`

Sine Oscillator (Freq:control, Amp:control) by Richard Furse (LADSPA example plugins).

Type:
```
(?id : string, ?amplitude : {float},
 ?frequency : {float}) -> source(audio=1, video=0,
midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `amplitude` (of type `{float}`, which defaults to `1.0`): Amplitude (0 <= `amplitude`).
- `frequency` (of type `{float}`, which defaults to `440.0`): Frequency (Hz) (0 <= `frequency` <= 22050).

### `limit`

Limit the signal.

Type:
```
(?id : string, ?attack : {float}, ?gain : {float},
 ?knee : {float}, ?ratio : {float}, ?release : {float},
 ?threshold : {float}, ?window : float, source(audio='#g,
 video='#h, midi='#i)) -> source(audio='#g, video='#h,
midi='#i)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `attack` (of type `{float}`, which defaults to `100.0`): Attack time (ms).
- `gain` (of type `{float}`, which defaults to `0.0`): Additional gain (dB).
- `knee` (of type `{float}`, which defaults to `1.0`): Knee radius (dB).
- `ratio` (of type `{float}`, which defaults to `20.0`): Gain reduction ratio (n:1).
- `release` (of type `{float}`, which defaults to `400.0`): Release time (ms).
- `threshold` (of type `{float}`, which defaults to `-10.0`): Threshold level (dB).
- `window` (of type `float`, which defaults to `0.1`): Window for computing RMS (in sec).
- `(unlabeled)` (of type `source(audio='#g, video='#h, midi='#i)`)

### `mic_filter`

Remove low frequencies often produced by microphones.

Type:
```
(source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`): The input source.

### `mix`

Mixing table controllable via the telnet interface.

Type:
```
(?id : string, [source(audio='#a, video='#b, midi='#c)]) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `[source(audio='#a, video='#b, midi='#c)]`)

### `normalize`

Normalize the signal. Dynamic normalization of the signal is sometimes the only option, and can make a listening experience much nicer. However, its dynamic aspect implies some limitations which can go as far as creating saturation in some extreme cases. If possible, consider using some track-based normalization techniques such as those based on replay gain. See the documentation for more details.

Type:
```
(?id : string, ?gain_max : {float}, ?gain_min : {float},
 ?k_down : {float}, ?k_up : {float}, ?target : {float},
 ?threshold : {float}, ?window : float, source(audio='#g,
 video='#h, midi='#i)) -> source(audio='#g, video='#h,
midi='#i)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `gain_max` (of type `{float}`, which defaults to `6.0`): Maximal gain value (dB).
- `gain_min` (of type `{float}`, which defaults to `-6.0`): Minimal gain value (dB).
- `k_down` (of type `{float}`, which defaults to `0.1`): Coefficient when the power must go down (between 0 and 1, slowest to fastest).
- `k_up` (of type `{float}`, which defaults to `0.005`): Coefficient when the power must go up (between 0 and 1, slowest to fastest).
- `target` (of type `{float}`, which defaults to `-13.0`): Desired RMS (dB).
- `threshold` (of type `{float}`, which defaults to `-40.0`): Minimal RMS for activaing gain control (dB).
- `window` (of type `float`, which defaults to `0.1`): Duration of the window used to compute the current RMS power (second).
- `(unlabeled)` (of type `source(audio='#g, video='#h, midi='#i)`)

### `nrj`

Compress and normalize, producing a more uniform and "full" sound.

Type:
```
(source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`): The input source.

### `pipe`

Process audio signal through a given process stdin/stdout.

Type:
```
(?id : string, ?buffer : float, ?data_length : int,
 ?max : float, process : string, ?replay_delay : float,
 ?restart : bool, ?restart_on_error : bool,
 source(audio='#a+1, video=0, midi=0)) ->
source(audio='#b+1, video=0, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `buffer` (of type `float`, which defaults to `1.0`): Duration of the pre-buffered data.
- `data_length` (of type `int`, which defaults to `-1`): Length passed in the WAV data chunk. Data is streamed so no the consuming program should process it as it comes. Some program operate better when this value is set to `0`, some other when it is set to the maximum length allowed by the WAV specs. Use any negative value to set to maximum length.
- `max` (of type `float`, which defaults to `10.0`): Maximum duration of the buffered data.
- `process` (of type `string`): Process used to pipe data to.
- `replay_delay` (of type `float`, which defaults to `-1.0`): Replay track marks and metadata from the input source on the output after a given delay. If negative (default) close and flush the process on each track and metadata to get an exact timing.
- `restart` (of type `bool`, which defaults to `true`): Restart process when exited.
- `restart_on_error` (of type `bool`, which defaults to `true`): Restart process when exited with error.
- `(unlabeled)` (of type `source(audio='#a+1, video=0, midi=0)`)

### `sky`

Multiband-compression.

Type:
```
(source(audio='#a, video='#b, midi=0)) ->
source(audio='#a, video='#b, midi=0)
```

Arguments:

- `(unlabeled)` (of type `source(audio='#a, video='#b, midi=0)`): The input source.

### `soundtouch`

Change the rate, the tempo or the pitch of the sound.

Type:
```
(?id : string, ?pitch : {float}, ?rate : {float},
 ?tempo : {float}, source(audio='#d+1, video=0, midi=0)) ->
source(audio='#d+1, video=0, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `pitch` (of type `{float}`, which defaults to `1.0`)
- `rate` (of type `{float}`, which defaults to `1.0`)
- `tempo` (of type `{float}`, which defaults to `1.0`)
- `(unlabeled)` (of type `source(audio='#d+1, video=0, midi=0)`)

This function is experimental.

### `stereo.ms.decode`

Decode mid+side stereo (M/S) to left+right stereo.

Type:
```
(?id : string, ?width : float, source(audio=2, video=0,
 midi=0)) -> source(audio=2, video=0, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `width` (of type `float`, which defaults to `1.0`): Width of the stereo field.
- `(unlabeled)` (of type `source(audio=2, video=0, midi=0)`)

### `stereo.ms.encode`

Encode left+right stereo to mid+side stereo (M/S).

Type:
```
(?id : string, source(audio=2, video=0, midi=0)) ->
source(audio=2, video=0, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio=2, video=0, midi=0)`)

### `stereo.pan`

Pan a stereo sound.

Type:
```
(?id : string, ?field : {float}, ?pan : {float},
 source(audio=2, video=0, midi=0)) -> source(audio=2,
video=0, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `field` (of type `{float}`, which defaults to `90.0`): Field width in degrees (between 0 and 90).
- `pan` (of type `{float}`, which defaults to `0.0`): Pan ranges between -1 and 1.
- `(unlabeled)` (of type `source(audio=2, video=0, midi=0)`)

### `stretch`

Slow down or accelerate an audio stream by stretching (sounds lower) or squeezing it (sounds higher).

Type:
```
(?id : string, ?active : bool, ratio : {float},
 source(audio='#b+1, video=0, midi=0)) ->
source(audio='#c+1, video=0, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `active` (of type `bool`, which defaults to `true`): The active behavior is to keep ticking the child's clock when the operator is not streaming. Otherwise the child's clock is strictly based on what is streamed off the child source, which results in time-dependent active sources to be frozen when that source is stopped.
- `ratio` (of type `{float}`): A value higher than 1 means slowing down.
- `(unlabeled)` (of type `source(audio='#b+1, video=0, midi=0)`)

## Source / Sound Synthesis

### `dssi.register`

Resgister a DSSI plugin.

Type:
```
(string) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`): Path of the DSSI plugin file.

### `synth.all.saw`

Saw synthesizer. It creates one synthesizer for each channel.

Type:
```
(?id : string, ?attack : float, ?decay : float,
 ?envelope : bool, ?release : float, ?sustain : float,
 source(audio='#a+1, video='#b, midi='#c+16)) ->
source(audio='#a+1, video='#b, midi='#c+16)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `attack` (of type `float`, which defaults to `0.02`): Envelope attack (in seconds).
- `decay` (of type `float`, which defaults to `0.01`): Envelope decay (in seconds).
- `envelope` (of type `bool`, which defaults to `true`): Use envelope.
- `release` (of type `float`, which defaults to `0.01`): Envelope release (in seconds).
- `sustain` (of type `float`, which defaults to `0.9`): Envelope sustain level.
- `(unlabeled)` (of type `source(audio='#a+1, video='#b, midi='#c+16)`)

### `synth.all.sine`

Sine synthesizer. It creates one synthesizer for each channel.

Type:
```
(?id : string, ?attack : float, ?decay : float,
 ?envelope : bool, ?release : float, ?sustain : float,
 source(audio='#a+1, video='#b, midi='#c+16)) ->
source(audio='#a+1, video='#b, midi='#c+16)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `attack` (of type `float`, which defaults to `0.02`): Envelope attack (in seconds).
- `decay` (of type `float`, which defaults to `0.01`): Envelope decay (in seconds).
- `envelope` (of type `bool`, which defaults to `true`): Use envelope.
- `release` (of type `float`, which defaults to `0.01`): Envelope release (in seconds).
- `sustain` (of type `float`, which defaults to `0.9`): Envelope sustain level.
- `(unlabeled)` (of type `source(audio='#a+1, video='#b, midi='#c+16)`)

### `synth.all.square`

Square synthesizer. It creates one synthesizer for each channel.

Type:
```
(?id : string, ?attack : float, ?decay : float,
 ?envelope : bool, ?release : float, ?sustain : float,
 source(audio='#a+1, video='#b, midi='#c+16)) ->
source(audio='#a+1, video='#b, midi='#c+16)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `attack` (of type `float`, which defaults to `0.02`): Envelope attack (in seconds).
- `decay` (of type `float`, which defaults to `0.01`): Envelope decay (in seconds).
- `envelope` (of type `bool`, which defaults to `true`): Use envelope.
- `release` (of type `float`, which defaults to `0.01`): Envelope release (in seconds).
- `sustain` (of type `float`, which defaults to `0.9`): Envelope sustain level.
- `(unlabeled)` (of type `source(audio='#a+1, video='#b, midi='#c+16)`)

### `synth.saw`

Saw synthesizer.

Type:
```
(?id : string, ?attack : float, ?channel : int,
 ?decay : float, ?envelope : bool, ?release : float,
 ?sustain : float, ?volume : float, source(audio='#a+1,
 video='#b, midi='#c+1)) -> source(audio='#a+1,
video='#b, midi='#c+1)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `attack` (of type `float`, which defaults to `0.02`): Envelope attack (in seconds).
- `channel` (of type `int`, which defaults to `0`): MIDI channel to handle.
- `decay` (of type `float`, which defaults to `0.01`): Envelope decay (in seconds).
- `envelope` (of type `bool`, which defaults to `true`): Use envelope.
- `release` (of type `float`, which defaults to `0.05`): Envelope release (in seconds).
- `sustain` (of type `float`, which defaults to `0.9`): Envelope sustain level.
- `volume` (of type `float`, which defaults to `0.3`): Initial volume.
- `(unlabeled)` (of type `source(audio='#a+1, video='#b, midi='#c+1)`)

### `synth.sine`

Sine synthesizer.

Type:
```
(?id : string, ?attack : float, ?channel : int,
 ?decay : float, ?envelope : bool, ?release : float,
 ?sustain : float, ?volume : float, source(audio='#a+1,
 video='#b, midi='#c+1)) -> source(audio='#a+1,
video='#b, midi='#c+1)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `attack` (of type `float`, which defaults to `0.02`): Envelope attack (in seconds).
- `channel` (of type `int`, which defaults to `0`): MIDI channel to handle.
- `decay` (of type `float`, which defaults to `0.01`): Envelope decay (in seconds).
- `envelope` (of type `bool`, which defaults to `true`): Use envelope.
- `release` (of type `float`, which defaults to `0.05`): Envelope release (in seconds).
- `sustain` (of type `float`, which defaults to `0.9`): Envelope sustain level.
- `volume` (of type `float`, which defaults to `0.3`): Initial volume.
- `(unlabeled)` (of type `source(audio='#a+1, video='#b, midi='#c+1)`)

### `synth.square`

Square synthesizer.

Type:
```
(?id : string, ?attack : float, ?channel : int,
 ?decay : float, ?envelope : bool, ?release : float,
 ?sustain : float, ?volume : float, source(audio='#a+1,
 video='#b, midi='#c+1)) -> source(audio='#a+1,
video='#b, midi='#c+1)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `attack` (of type `float`, which defaults to `0.02`): Envelope attack (in seconds).
- `channel` (of type `int`, which defaults to `0`): MIDI channel to handle.
- `decay` (of type `float`, which defaults to `0.01`): Envelope decay (in seconds).
- `envelope` (of type `bool`, which defaults to `true`): Use envelope.
- `release` (of type `float`, which defaults to `0.05`): Envelope release (in seconds).
- `sustain` (of type `float`, which defaults to `0.9`): Envelope sustain level.
- `volume` (of type `float`, which defaults to `0.3`): Initial volume.
- `(unlabeled)` (of type `source(audio='#a+1, video='#b, midi='#c+1)`)

## Source / Track Processing

### `append`

Append an extra track to every track. Set the metadata 'liq_append' to 'false' to inhibit appending on one track.

Type:
```
(?id : string, ?insert_missing : bool, ?merge : bool,
 source('a), (([string * string]) -> source('a))) ->
source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `insert_missing` (of type `bool`, which defaults to `true`): Treat track beginnings without metadata as having empty one.
- `merge` (of type `bool`, which defaults to `false`): Merge the track with its appended track.
- `(unlabeled)` (of type `source('a)`)
- `(unlabeled)` (of type `([string * string]) -> source('a)`): Given the metadata, build the source producing the track to append. This source is allowed to fail (produce nothing) if no relevant track is to be appended.

### `at`

Restrict a source to play only when a predicate is true.

Type:
```
((() -> bool), source('a)) -> source('a)
```

Arguments:

- `(unlabeled)` (of type `() -> bool`): The predicate, typically a time interval such as `{10h-10h30}`.
- `(unlabeled)` (of type `source('a)`)

### `chop`

Regularly insert track boundaries in a stream (useful for testing tracks).

Type:
```
(?duration : float, ?metadata : [string * string],
 source('a)) -> source('a)
```

Arguments:

- `duration` (of type `float`, which defaults to `3.0`): Duration of a track (in seconds).
- `metadata` (of type `[string * string]`, which defaults to `[]`): Metadata for tracks.
- `(unlabeled)` (of type `source('a)`): The stream.

### `crossfade`

Crossfade between tracks, taking the respective volume levels into account in the choice of the transition.

Type:
```
(?duration : float, ?override_duration : string,
 ?fade_in : float, ?fade_out : float, ?smart : bool,
 ?default : ((source(audio='#a+1, video=0, midi=0),
              source(audio='#a+1, video=0, midi=0)) ->
             source(audio='#a+1, video=0, midi=0)),
 ?high : float, ?medium : float, ?margin : float,
 ?minimum : float, ?width : float, ?conservative : bool,
 source(audio='#a+1, video=0, midi=0)) ->
source(audio='#a+1, video=0, midi=0)
```

Arguments:

- `duration` (of type `float`, which defaults to `5.0`): Duration (in seconds) of buffered data from each track that is used to compute the transision between tracks.
- `override_duration` (of type `string`, which defaults to `"liq_cross_duration"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track. 
- `fade_in` (of type `float`, which defaults to `3.0`): Fade-in duration, if any.
- `fade_out` (of type `float`, which defaults to `3.0`): Fade-out duration, if any.
- `smart` (of type `bool`, which defaults to `false`): Enable smart crossfading
- `default` (of type `(source(audio='#a+1, video=0, midi=0),
 source(audio='#a+1, video=0, midi=0)) ->
source(audio='#a+1, video=0, midi=0)`, which defaults to `<fun>`): Smart crossfade: transition used when no rule applies (default: sequence).
- `high` (of type `float`, which defaults to `-15.0`): Smart crossfade: value, in dB, for loud sound level.
- `medium` (of type `float`, which defaults to `-32.0`): Smart crossfade: value, in dB, for medium sound level.
- `margin` (of type `float`, which defaults to `4.0`): Smart crossfade: margin to detect sources that have too different sound level for crossing.
- `minimum` (of type `float`, which defaults to `-1.0`): Minimum duration (in sec.) for a cross: If the track ends without any warning (e.g. in case of skip) there may not be enough data for a decent composition. Set to 0. to avoid having transitions after skips, or more to avoid transitions on short tracks. With a negative default, transitions always occur.    
- `width` (of type `float`, which defaults to `2.0`): Width of the volume analysis window.
- `conservative` (of type `bool`, which defaults to `true`): Always prepare for a premature end-of-track.
- `(unlabeled)` (of type `source(audio='#a+1, video=0, midi=0)`): The input source.

### `cue_cut`

Start track after a cue in point and stop it at cue out point. The cue points are given as metadata, in seconds from the begining of tracks.

Type:
```
(?id : string, ?cue_in_metadata : string,
 ?cue_out_metadata : string, ?on_cue_in : (() -> unit),
 ?on_cue_out : (() -> unit), source(audio='#a, video='#b,
 midi='#c)) -> source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `cue_in_metadata` (of type `string`, which defaults to `"liq_cue_in"`): Metadata for cue in points.
- `cue_out_metadata` (of type `string`, which defaults to `"liq_cue_out"`): Metadata for cue out points.
- `on_cue_in` (of type `() -> unit`, which defaults to `<fun>`): Callback to execute on cue in
- `on_cue_out` (of type `() -> unit`, which defaults to `<fun>`): Callback to execute on cue out
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `delay`

Prevents the child from being ready again too fast after a end of track

Type:
```
(?id : string, ?initial : bool, float, source('a)) ->
source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `initial` (of type `bool`, which defaults to `false`): Start in unavailable state, as if a track had just finished.
- `(unlabeled)` (of type `float`): The source won't be ready less than this amount of seconds after any end of track
- `(unlabeled)` (of type `source('a)`)

### `drop_metadata`

Removes all metadata coming from a source.

Type:
```
(source('a)) -> source('a)
```

Arguments:

- `(unlabeled)` (of type `source('a)`)

### `eat_blank`

Eat blanks, i.e., drop the contents of the stream until it is not blank anymore.

Type:
```
(?id : string, ?at_beginning : bool, ?max_blank : float,
 ?min_noise : float, ?start_blank : bool,
 ?threshold : float, ?track_sensitive : bool,
 source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `at_beginning` (of type `bool`, which defaults to `false`): Only eat at the beginning of a track.
- `max_blank` (of type `float`, which defaults to `20.0`): Maximum duration of silence allowed, in seconds.
- `min_noise` (of type `float`, which defaults to `0.0`): Minimum duration of noise required to end silence, in seconds.
- `start_blank` (of type `bool`, which defaults to `false`): Start assuming we have blank.
- `threshold` (of type `float`, which defaults to `-40.0`): Power in decibels under which the stream is considered silent.
- `track_sensitive` (of type `bool`, which defaults to `true`): Reset blank counter at each track.
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `fallback`

At the beginning of each track, select the first ready child.

Type:
```
(?id : string, ?override : string,
 ?replay_metadata : bool, ?track_sensitive : {bool},
 ?transition_length : float,
 ?transitions : [(source('b), source('b)) -> source('b)],
 [source('b)]) -> source('b)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `override` (of type `string`, which defaults to `"liq_transition_length"`): Metadata field which, if present and containing a float, overrides the `transition_length` parameter.
- `replay_metadata` (of type `bool`, which defaults to `true`): Replay the last metadata of a child when switching to it in the middle of a track.
- `track_sensitive` (of type `{bool}`, which defaults to `true`): Re-select only on end of tracks.
- `transition_length` (of type `float`, which defaults to `5.0`): Maximun transition duration.
- `transitions` (of type `[(source('b), source('b)) -> source('b)]`, which defaults to `[]`): Transition functions, padded with `fun (x,y) -> y` functions.
- `(unlabeled)` (of type `[source('b)]`): Select the first ready source in this list.

### `fallback.skip`

Special track insensitive fallback that always skips current song before switching.

Type:
```
(input : source('a), source('a)) -> source('a)
```

Arguments:

- `input` (of type `source('a)`): The input source
- `(unlabeled)` (of type `source('a)`): The fallback source

### `insert_metadata`

Dynamically insert metadata in a stream. Returns a pair `(f,s)` where s is a new source and `f` is a function of type `(?new_track,metadata)->unit`, used to insert metadata in `s`. `f` also inserts a new track with the given metadata if passed `new_track=true`.

Type:
```
(?id : string, source('a)) ->
((?new_track : bool, [string * string]) -> unit) *
source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `source('a)`)

### `map_first_track`

Apply a function to the first track of a source

Type:
```
(?id : string, ((source('a)) -> source('a)), source('a)) ->
source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `(source('a)) -> source('a)`): The applied function.
- `(unlabeled)` (of type `source('a)`): The input source.

### `map_metadata`

Rewrite metadata on the fly using a function.

Type:
```
(?id : string, ?insert_missing : bool, ?strip : bool,
 ?update : bool,
 (([string * string]) -> [string * string]), source('a)) ->
source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `insert_missing` (of type `bool`, which defaults to `true`): Treat track beginnings without metadata as having empty ones. The operational order is: create empty if needed, map and strip if enabled.
- `strip` (of type `bool`, which defaults to `false`): Completely remove empty metadata. Operates on both empty values and empty metadata chunk.
- `update` (of type `bool`, which defaults to `true`): Update metadata. If false, existing metadata are cleared and only returned values are set as new metadata.
- `(unlabeled)` (of type `([string * string]) -> [string * string]`): A function that returns new metadata.
- `(unlabeled)` (of type `source('a)`)

### `max_duration`

Limit source duration

Type:
```
(?id : string, ?override : string, float, source('a)) ->
source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `override` (of type `string`, which defaults to `"liq_remaining"`): Metadata field which, if present and containing a float, overrides the remaining play time.
- `(unlabeled)` (of type `float`): Maximum duration
- `(unlabeled)` (of type `source('a)`)

### `merge_tracks`

Merge consecutive tracks from the input source. They will be considered as one big track, so `on_track()` will not trigger for example.

Type:
```
(?id : string, source('a)) -> source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `source('a)`)

### `mkavailable`

Make a source available or not depending on a boolean.

Type:
```
(?id : string, ?track_sensitive : bool, ?active : bool,
 ?available : bool, source('a)) -> source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `"mkavailable"`): The source ID
- `track_sensitive` (of type `bool`, which defaults to `true`): Re-select only on end of tracks.
- `active` (of type `bool`, which defaults to `false`): Whether the source should be pulled when not available
- `available` (of type `bool`, which defaults to `true`): Whether the source is available (`true`) or not (`false`).
- `(unlabeled)` (of type `source('a)`): The stream.

### `mksafe`

Turn a source into an infaillible source by adding blank when the source is not available.

Type:
```
(?id : string, source('a)) -> source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `"mksafe"`)
- `(unlabeled)` (of type `source('a)`): the source to turn infaillible

### `notify_metadata`

Use notify to display metadata info.

Type:
```
(?urgency : string, ?icon : string, ?time : int,
 ?display : (([string * string]) -> string),
 ?title : string, source('a)) -> source('a)
```

Arguments:

- `urgency` (of type `string`, which defaults to `"low"`): Urgency (low|normal|critical).
- `icon` (of type `string`, which defaults to `"stock_smiley-22"`): Icon filename or stock icon to display.
- `time` (of type `int`, which defaults to `3000`): Timeout in milliseconds.
- `display` (of type `([string * string]) -> string`, which defaults to `<fun>`): Function used to display a metadata packet.
- `title` (of type `string`, which defaults to `"Liquidsoap: new track"`): Title of the notification message.
- `(unlabeled)` (of type `source('a)`)

### `on_blank`

Calls a given handler when detecting a blank.

Type:
```
(?id : string, ?max_blank : float, ?min_noise : float,
 ?on_noise : (() -> unit), ?start_blank : bool,
 ?threshold : float, ?track_sensitive : bool,
 (() -> unit), source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `max_blank` (of type `float`, which defaults to `20.0`): Maximum duration of silence allowed, in seconds.
- `min_noise` (of type `float`, which defaults to `0.0`): Minimum duration of noise required to end silence, in seconds.
- `on_noise` (of type `() -> unit`, which defaults to `<fun>`): Handler called when noise is detected.
- `start_blank` (of type `bool`, which defaults to `false`): Start assuming we have blank.
- `threshold` (of type `float`, which defaults to `-40.0`): Power in decibels under which the stream is considered silent.
- `track_sensitive` (of type `bool`, which defaults to `true`): Reset blank counter at each track.
- `(unlabeled)` (of type `() -> unit`): Handler called when blank is detected.
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `on_end`

Call a given handler when there is less than a given amount of time remaining before then end of track.

Type:
```
(?id : string, ?delay : {float},
 ((float, [string * string]) -> unit), source('b)) ->
source('b)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `delay` (of type `{float}`, which defaults to `5.0`): Execute handler when remaining time is less or equal to this value.
- `(unlabeled)` (of type `(float, [string * string]) -> unit`): Function to execute. First argument is the remaining time, second is the latest metadata. That function should be fast because it is executed in the main streaming thread.
- `(unlabeled)` (of type `source('b)`)

### `on_metadata`

Call a given handler on metadata packets.

Type:
```
(?id : string, (([string * string]) -> unit), source('a)) ->
source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `([string * string]) -> unit`): Function called on every metadata packet in the stream. It should be fast because it is executed in the main streaming thread.
- `(unlabeled)` (of type `source('a)`)

### `on_offset`

Call a given handler when position in track is equal or more than a given amount of time.

Type:
```
(?id : string, ?force : bool, ?offset : float,
 ?override : string,
 ((float, [string * string]) -> unit), source('a)) ->
source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `force` (of type `bool`, which defaults to `false`): Force execution of callback if track ends before 'offset' position has been reached.
- `offset` (of type `float`, which defaults to `-1.0`): Execute handler when position in track is equal or more than to this value.
- `override` (of type `string`, which defaults to `"liq_on_offset"`): Metadata field which, if present and containing a float, overrides the 'offset' parameter.
- `(unlabeled)` (of type `(float, [string * string]) -> unit`): Function to execute. First argument is the actual position within the current track, second is the latest metadata. That function should be fast because it is executed in the main streaming thread.
- `(unlabeled)` (of type `source('a)`)

### `on_track`

Call a given handler on new tracks.

Type:
```
(?id : string, (([string * string]) -> unit), source('a)) ->
source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `([string * string]) -> unit`): Function called on every beginning of track in the stream, with the corresponding metadata as argument. If there is no metadata at the beginning of track, the empty list is passed. That function should be fast because it is executed in the main streaming thread.
- `(unlabeled)` (of type `source('a)`)

### `once`

Creates a source that plays only one track of the input source.

Type:
```
(source('a)) -> source('a)
```

Arguments:

- `(unlabeled)` (of type `source('a)`): The input source.

### `osd_metadata`

Use X On Screen Display to display metadata info.

Type:
```
(?color : string, ?position : string, ?font : string,
 ?display : (([string * string]) -> string), source('a)) ->
source('a)
```

Arguments:

- `color` (of type `string`, which defaults to `"green"`): Color of the text.
- `position` (of type `string`, which defaults to `"top"`): Position of the text (top|middle|bottom).
- `font` (of type `string`, which defaults to `"-*-courier-*-r-*-*-*-240-*-*-*-*-*-*"`): Font used (xfontsel is your friend...)
- `display` (of type `([string * string]) -> string`, which defaults to `<fun>`): Function used to display a metadata packet.
- `(unlabeled)` (of type `source('a)`)

### `overlap_sources`

Rotate between overlapping sources. Next track starts according to 'liq_start_next' offset metadata.

Type:
```
(?id : string, ?normalize : bool, ?start_next : string,
 ?weights : [int],
 [source(audio='#a, video='#b, midi=0)]) ->
source(audio='#a, video='#b, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `normalize` (of type `bool`, which defaults to `false`)
- `start_next` (of type `string`, which defaults to `"liq_start_next"`): Metadata field indicating when the next track should start, relative to current track's time.
- `weights` (of type `[int]`, which defaults to `[]`): Relative weight of the sources in the sum. The empty list stands for the homogeneous distribution.
- `(unlabeled)` (of type `[source(audio='#a, video='#b, midi=0)]`): Sources to toggle from

### `playlist.merge`

Play the whole playlist as one track.

Type:
```
(?id : string, ?random : bool, ?default_duration : float,
 ?length : float, ?conservative : bool, string) ->
source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `random` (of type `bool`, which defaults to `false`): Randomize playlist content
- `default_duration` (of type `float`, which defaults to `30.0`): When unknown, assume this duration (in sec.) for files.
- `length` (of type `float`, which defaults to `10.0`): How much audio (in sec.) should be queued in advance.
- `conservative` (of type `bool`, which defaults to `false`): If true, estimated remaining time on the current track is not considered when computing queue length.
- `(unlabeled)` (of type `string`): Playlist URI.

### `prepend`

Prepend an extra track before every track. Set the metadata 'liq_prepend' to 'false' to inhibit prepending on one track.

Type:
```
(?id : string, ?merge : bool, source(audio='#a,
 video='#b, midi='#c),
 (([string * string]) -> source(audio='#a, video='#b,
  midi='#c))) -> source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `merge` (of type `bool`, which defaults to `false`): Merge the track with its appended track.
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)
- `(unlabeled)` (of type `([string * string]) -> source(audio='#a, video='#b,
midi='#c)`): Given the metadata, build the source producing the track to prepend. This source is allowed to fail (produce nothing) if no relevant track is to be appended. However, success must be immediate or it will not be taken into account.

### `random`

At the beginning of every track, select a random ready child.

Type:
```
(?id : string, ?override : string,
 ?replay_metadata : bool, ?track_sensitive : {bool},
 ?transition_length : float,
 ?transitions : [(source('b), source('b)) -> source('b)],
 ?weights : [{int}], [source('b)]) -> source('b)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `override` (of type `string`, which defaults to `"liq_transition_length"`): Metadata field which, if present and containing a float, overrides the `transition_length` parameter.
- `replay_metadata` (of type `bool`, which defaults to `true`): Replay the last metadata of a child when switching to it in the middle of a track.
- `track_sensitive` (of type `{bool}`, which defaults to `true`): Re-select only on end of tracks.
- `transition_length` (of type `float`, which defaults to `5.0`): Maximun transition duration.
- `transitions` (of type `[(source('b), source('b)) -> source('b)]`, which defaults to `[]`): Transition functions, padded with `fun (x,y) -> y` functions.
- `weights` (of type `[{int}]`, which defaults to `[]`): Weights of the children (padded with 1), defining for each child the probability that it is selected.
- `(unlabeled)` (of type `[source('b)]`)

### `rotate`

Rotate between the sources.

Type:
```
(?id : string, ?override : string,
 ?replay_metadata : bool, ?track_sensitive : {bool},
 ?transition_length : float,
 ?transitions : [(source('b), source('b)) -> source('b)],
 ?weights : [{int}], [source('b)]) -> source('b)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `override` (of type `string`, which defaults to `"liq_transition_length"`): Metadata field which, if present and containing a float, overrides the `transition_length` parameter.
- `replay_metadata` (of type `bool`, which defaults to `true`): Replay the last metadata of a child when switching to it in the middle of a track.
- `track_sensitive` (of type `{bool}`, which defaults to `true`): Re-select only on end of tracks.
- `transition_length` (of type `float`, which defaults to `5.0`): Maximun transition duration.
- `transitions` (of type `[(source('b), source('b)) -> source('b)]`, which defaults to `[]`): Transition functions, padded with `fun (x,y) -> y` functions.
- `weights` (of type `[{int}]`, which defaults to `[]`): Weights of the children (padded with 1), defining for each child how many tracks are played from it per round, if that many are actually available.
- `(unlabeled)` (of type `[source('b)]`)

### `rotate.merge`

Same operator as rotate but merges tracks from each sources. For instance, `rotate.merge([intro,main,outro])` creates a source that plays a sequence `[intro,main,outro]` as single track and loops back.

Type:
```
(?id : string, ?track_sensitive : bool,
 ?transitions : [(source('a), source('a)) -> source('a)],
 ?weights : [{int}], [source('a)]) -> source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `track_sensitive` (of type `bool`, which defaults to `true`): Re-select only on end of tracks.
- `transitions` (of type `[(source('a), source('a)) -> source('a)]`, which defaults to `[]`): Transition functions, padded with `fun (x,y) -> y` functions.
- `weights` (of type `[{int}]`, which defaults to `[]`): Weights of the children (padded with 1), defining for each child how many tracks are played from it per round, if that many are actually available.
- `(unlabeled)` (of type `[source('a)]`): Sequence of sources to be merged

### `say_metadata`

Append speech-synthesized tracks reading the metadata.

Type:
```
(source(?A), ?pattern : string) -> source(?A)
```

Arguments:

- `(unlabeled)` (of type `source(?A)`): The source to use
- `pattern` (of type `string`, which defaults to `"say:$(if $(artist),\"It was $(artist)$(if $(title),\\\", $(title)\\\").\")"`): Pattern to use

### `sequence`

Play only one track of every successive source, except for the last one which is played as much as available.

Type:
```
(?id : string, ?merge : bool, [source('a)]) -> source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `merge` (of type `bool`, which defaults to `false`): Merge tracks when advancing from one source to the next one. This will NOT merge consecutive tracks from the last source; see merge_tracks() if you need that too.
- `(unlabeled)` (of type `[source('a)]`)

### `server.insert_metadata`

Register a server/telnet command to update a source's metadata. Returns a new source, which will receive the updated metadata. The command has the following format: insert key1="val1",key2="val2",...

Type:
```
(?id : string, source('a)) -> source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `source('a)`)

### `skip_blank`

Skip track when detecting a blank.

Type:
```
(?id : string, ?threshold : float, ?max_blank : float,
 ?min_noise : float, ?track_sensitive : bool,
 source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `threshold` (of type `float`, which defaults to `-40.0`): Power in decibels under which the stream is considered silent.
- `max_blank` (of type `float`, which defaults to `20.0`): Maximum silence length allowed, in seconds.
- `min_noise` (of type `float`, which defaults to `0.0`): Minimum duration of noise required to end silence, in seconds.
- `track_sensitive` (of type `bool`, which defaults to `true`): Reset blank counter at each track.
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `smooth_add`

Mixes two streams, with faded transitions between the state when only the normal stream is available and when the special stream gets added on top of it.

Type:
```
(?delay : float, ?p : float, normal : source(audio='#a,
 video='#b, midi=0), special : source(audio='#a,
 video='#b, midi=0)) -> source(audio='#a, video='#b,
midi=0)
```

Arguments:

- `delay` (of type `float`, which defaults to `0.5`): Delay before starting the special source.
- `p` (of type `float`, which defaults to `0.2`): Portion of amplitude of the normal source in the mix.
- `normal` (of type `source(audio='#a, video='#b, midi=0)`): The normal source, which could be called the carrier too.
- `special` (of type `source(audio='#a, video='#b, midi=0)`): The special source.

### `source.dynamic`

Dynamically change the underlying source.

Type:
```
(?id : string, (() -> [source('a)])) -> source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `() -> [source('a)]`)

This function is experimental.

### `store_metadata`

Keep track of the last N metadata packets in the stream, and make the history available via a server command.

Type:
```
(?id : string, ?size : int, source('a)) -> source('a)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `size` (of type `int`, which defaults to `10`): Size of the history
- `(unlabeled)` (of type `source('a)`)

### `strip_blank`

Make the source unavailable when it is streaming blank.

Type:
```
(?id : string, ?max_blank : float, ?min_noise : float,
 ?start_blank : bool, ?threshold : float,
 ?track_sensitive : bool, source(audio='#a, video='#b,
 midi='#c)) -> active_source(audio='#a, video='#b,
midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `max_blank` (of type `float`, which defaults to `20.0`): Maximum duration of silence allowed, in seconds.
- `min_noise` (of type `float`, which defaults to `0.0`): Minimum duration of noise required to end silence, in seconds.
- `start_blank` (of type `bool`, which defaults to `false`): Start assuming we have blank.
- `threshold` (of type `float`, which defaults to `-40.0`): Power in decibels under which the stream is considered silent.
- `track_sensitive` (of type `bool`, which defaults to `true`): Reset blank counter at each track.
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `switch`

At the beginning of a track, select the first source whose predicate is true.

Type:
```
(?id : string, ?override : string,
 ?replay_metadata : bool, ?single : [bool],
 ?track_sensitive : {bool}, ?transition_length : float,
 ?transitions : [(source('b), source('b)) -> source('b)],
 [(() -> bool) * source('b)]) -> source('b)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `override` (of type `string`, which defaults to `"liq_transition_length"`): Metadata field which, if present and containing a float, overrides the `transition_length` parameter.
- `replay_metadata` (of type `bool`, which defaults to `true`): Replay the last metadata of a child when switching to it in the middle of a track.
- `single` (of type `[bool]`, which defaults to `[]`): Forbid the selection of a branch for two tracks in a row. The empty list stands for `[false,...,false]`.
- `track_sensitive` (of type `{bool}`, which defaults to `true`): Re-select only on end of tracks.
- `transition_length` (of type `float`, which defaults to `5.0`): Maximun transition duration.
- `transitions` (of type `[(source('b), source('b)) -> source('b)]`, which defaults to `[]`): Transition functions, padded with `fun (x,y) -> y` functions.
- `(unlabeled)` (of type `[(() -> bool) * source('b)]`): Sources with the predicate telling when they can be played.

## Source / Video Processing

### `input.external.ffmpeg`

Input from ffmpeg.

Type:
```
(?id : string, ?show_command : bool, ?restart : bool,
 ?restart_on_error : bool, ?buffer : float, ?max : float,
 string) -> source(audio=2, video=1, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`)
- `show_command` (of type `bool`, which defaults to `false`)
- `restart` (of type `bool`, which defaults to `true`): restart on exit.
- `restart_on_error` (of type `bool`, which defaults to `false`): restart on exit with error.
- `buffer` (of type `float`, which defaults to `0.2`): Duration of the pre-buffered data.
- `max` (of type `float`, which defaults to `10.0`): Maximum duration of the buffered data.
- `(unlabeled)` (of type `string`): ffmpeg options specifying the input

### `video.add_image`

Add a static image on the first video channel.

Type:
```
(?id : string, ?width : int, ?height : int, ?x : int,
 ?y : int, file : 'a, source(audio='#b, video='#c,
 midi=0)) -> source(audio='#b, video='#c, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `width` (of type `int`, which defaults to `0`): Scale to width (zero means frame width, negative means original width).
- `height` (of type `int`, which defaults to `0`): Scale to height (zero means frame height, negative means original height).
- `x` (of type `int`, which defaults to `4611686018427387903`): x position.
- `y` (of type `int`, which defaults to `4611686018427387903`): y position.
- `file` (of type `'a`): Path to the image file.
- `(unlabeled)` (of type `source(audio='#b, video='#c, midi=0)`)

### `video.add_text.gd`

Display a text.

Type:
```
(?id : string, ?color : int, ?cycle : bool,
 ?font : string, ?metadata : string, ?size : int,
 ?speed : int, ?x : {int}, ?y : {int}, {string},
 source(audio='#d, video='#e+1, midi='#f)) ->
source(audio='#d, video='#e+1, midi='#f)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `color` (of type `int`, which defaults to `16777215`): Text color (in 0xRRGGBB format).
- `cycle` (of type `bool`, which defaults to `true`): Cycle text when it reaches left boundary.
- `font` (of type `string`, which defaults to `"/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"`): Path to ttf font file.
- `metadata` (of type `string`, which defaults to `""`): Change text on a particular metadata (empty string means disabled).
- `size` (of type `int`, which defaults to `18`): Font size.
- `speed` (of type `int`, which defaults to `70`): Horizontal speed in pixels per second (0 means no scrolling and update according to x and y in case they are variable).
- `x` (of type `{int}`, which defaults to `10`): x offset.
- `y` (of type `{int}`, which defaults to `10`): y offset.
- `(unlabeled)` (of type `{string}`): Text to display.
- `(unlabeled)` (of type `source(audio='#d, video='#e+1, midi='#f)`)

### `video.add_text.gstreamer`

Display a text.

Type:
```
(?id : string, ?color : int, ?cycle : bool,
 ?font : string, ?metadata : string, ?size : int,
 ?speed : int, ?x : {int}, ?y : {int}, {string},
 source(audio='#d, video='#e+1, midi='#f)) ->
source(audio='#d, video='#e+1, midi='#f)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `color` (of type `int`, which defaults to `16777215`): Text color (in 0xRRGGBB format).
- `cycle` (of type `bool`, which defaults to `true`): Cycle text when it reaches left boundary.
- `font` (of type `string`, which defaults to `"/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"`): Path to ttf font file.
- `metadata` (of type `string`, which defaults to `""`): Change text on a particular metadata (empty string means disabled).
- `size` (of type `int`, which defaults to `18`): Font size.
- `speed` (of type `int`, which defaults to `70`): Horizontal speed in pixels per second (0 means no scrolling and update according to x and y in case they are variable).
- `x` (of type `{int}`, which defaults to `10`): x offset.
- `y` (of type `{int}`, which defaults to `10`): y offset.
- `(unlabeled)` (of type `{string}`): Text to display.
- `(unlabeled)` (of type `source(audio='#d, video='#e+1, midi='#f)`)

### `video.add_text.native`

Display a text.

Type:
```
(?id : string, ?color : int, ?cycle : bool,
 ?font : string, ?metadata : string, ?size : int,
 ?speed : int, ?x : {int}, ?y : {int}, {string},
 source(audio='#d, video='#e+1, midi='#f)) ->
source(audio='#d, video='#e+1, midi='#f)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `color` (of type `int`, which defaults to `16777215`): Text color (in 0xRRGGBB format).
- `cycle` (of type `bool`, which defaults to `true`): Cycle text when it reaches left boundary.
- `font` (of type `string`, which defaults to `"/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"`): Path to ttf font file.
- `metadata` (of type `string`, which defaults to `""`): Change text on a particular metadata (empty string means disabled).
- `size` (of type `int`, which defaults to `18`): Font size.
- `speed` (of type `int`, which defaults to `70`): Horizontal speed in pixels per second (0 means no scrolling and update according to x and y in case they are variable).
- `x` (of type `{int}`, which defaults to `10`): x offset.
- `y` (of type `{int}`, which defaults to `10`): y offset.
- `(unlabeled)` (of type `{string}`): Text to display.
- `(unlabeled)` (of type `source(audio='#d, video='#e+1, midi='#f)`)

### `video.external.testsrc`

ffmpeg's test source video (useful for testing and debugging).

Type:
```
(?id : string, ?restart : bool, ?restart_on_error : bool,
 ?buffer : float, ?max : float) -> source(audio=2,
video=1, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`)
- `restart` (of type `bool`, which defaults to `true`): restart on exit.
- `restart_on_error` (of type `bool`, which defaults to `false`): restart on exit with error.
- `buffer` (of type `float`, which defaults to `0.2`): Duration of the pre-buffered data.
- `max` (of type `float`, which defaults to `10.0`): Maximum duration of the buffered data.

### `video.fade.in`

Fade the beginning of tracks. Metadata 'liq_video_fade_in' can be used to set the duration for a specific track (float in seconds).

Type:
```
(?id : string, ?duration : float, ?override : string,
 ?transition : string, ?type : string, source(audio='#a,
 video='#b+1, midi='#c)) -> source(audio='#a,
video='#b+1, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `duration` (of type `float`, which defaults to `3.0`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
- `override` (of type `string`, which defaults to `"liq_video_fade_in"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
- `transition` (of type `string`, which defaults to `"fade"`): Kind of transition (fade|slide_left|slide_right|slide_up|slide_down|grow|disc|random).
- `type` (of type `string`, which defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
- `(unlabeled)` (of type `source(audio='#a, video='#b+1, midi='#c)`)

### `video.fade.out`

Fade the end of tracks. Metadata 'liq_video_fade_out' can be used to set the duration for a specific track (float in seconds).

Type:
```
(?id : string, ?duration : float, ?override : string,
 ?transition : string, ?type : string, source(audio='#a,
 video='#b+1, midi='#c)) -> source(audio='#a,
video='#b+1, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `duration` (of type `float`, which defaults to `3.0`): Duration of the fading. This value can be set on a per-file basis using the metadata field passed as override.
- `override` (of type `string`, which defaults to `"liq_video_fade_out"`): Metadata field which, if present and containing a float, overrides the 'duration' parameter for current track.
- `transition` (of type `string`, which defaults to `"fade"`): Kind of transition (fade|slide_left|slide_right|slide_up|slide_down|grow|disc|random).
- `type` (of type `string`, which defaults to `"lin"`): Fader shape (lin|sin|log|exp): linear, sinusoidal, logarithmic or exponential.
- `(unlabeled)` (of type `source(audio='#a, video='#b+1, midi='#c)`)

### `video.fill`

Fill frame with a color.

Type:
```
(?id : string, ?color : int, source(audio='#a,
 video='#b+1, midi='#c)) -> source(audio='#a,
video='#b+1, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `color` (of type `int`, which defaults to `0`): Color to fill the image with.
- `(unlabeled)` (of type `source(audio='#a, video='#b+1, midi='#c)`)

### `video.frame.height`

Height for all video frames.

Type:
```
() -> int
```

Arguments:


### `video.frame.rate`

Rate for all video frames.

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
(?id : string, source(audio='#a, video='#b+1, midi='#c)) ->
source(audio='#a, video='#b+1, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='#a, video='#b+1, midi='#c)`)

### `video.invert`

Invert video.

Type:
```
(?id : string, source(audio='#a, video='#b+1, midi='#c)) ->
source(audio='#a, video='#b+1, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='#a, video='#b+1, midi='#c)`)

### `video.lomo`

Emulate the "Lomo effect".

Type:
```
(?id : string, source(audio='#a, video='#b+1, midi='#c)) ->
source(audio='#a, video='#b+1, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='#a, video='#b+1, midi='#c)`)

### `video.opacity`

Scale opacity of video.

Type:
```
(?id : string, float, source(audio='#a, video='#b+1,
 midi='#c)) -> source(audio='#a, video='#b+1, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `float`): Coefficient to scale opacity with.
- `(unlabeled)` (of type `source(audio='#a, video='#b+1, midi='#c)`)

### `video.opacity.blur`

Blur opacity of video.

Type:
```
(?id : string, source(audio='#a, video='#b+1, midi='#c)) ->
source(audio='#a, video='#b+1, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='#a, video='#b+1, midi='#c)`)

### `video.rotate`

Rotate video.

Type:
```
(?id : string, ?angle : {float}, ?speed : {float},
 source(audio='#c, video='#d+1, midi='#e)) ->
source(audio='#c, video='#d+1, midi='#e)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `angle` (of type `{float}`, which defaults to `0.0`): Initial angle in radians.
- `speed` (of type `{float}`, which defaults to `3.14159265359`): Rotation speed in radians per sec.
- `(unlabeled)` (of type `source(audio='#c, video='#d+1, midi='#e)`)

### `video.scale`

Scale and translate video.

Type:
```
(?id : string, ?scale : float, ?x : int, ?xscale : float,
 ?y : int, ?yscale : float, source(audio='#a,
 video='#b+1, midi='#c)) -> source(audio='#a,
video='#b+1, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `scale` (of type `float`, which defaults to `1.0`): Scaling coefficient in both directions.
- `x` (of type `int`, which defaults to `0`): x offset.
- `xscale` (of type `float`, which defaults to `1.0`): x scaling.
- `y` (of type `int`, which defaults to `0`): y offset.
- `yscale` (of type `float`, which defaults to `1.0`): y scaling.
- `(unlabeled)` (of type `source(audio='#a, video='#b+1, midi='#c)`)

### `video.sepia`

Convert video to sepia.

Type:
```
(?id : string, source(audio='#a, video='#b+1, midi='#c)) ->
source(audio='#a, video='#b+1, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='#a, video='#b+1, midi='#c)`)

### `video.tile`

Tile sources (same as add but produces tiles of videos).

Type:
```
(?id : string, ?normalize : bool, ?proportional : bool,
 ?weights : [int],
 [source(audio='#a, video='#b+1, midi='#c)]) ->
source(audio='#a, video='#b+1, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `normalize` (of type `bool`, which defaults to `true`)
- `proportional` (of type `bool`, which defaults to `true`): Scale preserving the proportions.
- `weights` (of type `[int]`, which defaults to `[]`): Relative weight of the sources in the sum. The empty list stands for the homogeneous distribution.
- `(unlabeled)` (of type `[source(audio='#a, video='#b+1, midi='#c)]`)

### `video.transparent`

Set a color to be transparent.

Type:
```
(?id : string, ?color : int, ?precision : float,
 source(audio='#a, video='#b+1, midi='#c)) ->
source(audio='#a, video='#b+1, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `color` (of type `int`, which defaults to `0`): Color which should be transparent (in 0xRRGGBB format).
- `precision` (of type `float`, which defaults to `0.0`): Precision in color matching (0. means match precisely the color and 1. means match every color).
- `(unlabeled)` (of type `source(audio='#a, video='#b+1, midi='#c)`)

## Source / Visualization

### `peak`

Get current peak volume of the source. Returns a pair `(f,s)` where s is a new source and `f` is a function of type `() -> float` and returns the current peak volume of the source, with `0.0 <= peak volume <= 1.0`. Some operators like `amplify` and `compress` can produce amplitudes greater than 1.0 if misconfigured, inducing clipping in the output.

Type:
```
(?id : string, ?duration : {float}, source(audio='#b,
 video='#c, midi='#d)) ->
(() -> float) * source(audio='#b, video='#c, midi='#d)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `duration` (of type `{float}`, which defaults to `0.5`): Duration of the window (in seconds). A value <= 0, means that computation should not be performed.
- `(unlabeled)` (of type `source(audio='#b, video='#c, midi='#d)`)

### `peak.stereo`

Get current peak volume of the source. Returns a pair `(f,s)` where s is a new source and `f` is a function of type `() -> float` and returns the current peak volume of the source, with `0.0 <= peak volume <= 1.0`. Some operators like `amplify` and `compress` can produce amplitudes greater than 1.0 if misconfigured, inducing clipping in the output.

Type:
```
(?id : string, ?duration : {float}, source(audio='#b+2,
 video='#c, midi='#d)) ->
(() -> float * float) * source(audio='#b+2, video='#c,
midi='#d)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `duration` (of type `{float}`, which defaults to `0.5`): Duration of the window (in seconds). A value <= 0, means that computation should not be performed.
- `(unlabeled)` (of type `source(audio='#b+2, video='#c, midi='#d)`)

### `rms`

Get current RMS volume of the source. Returns a pair `(f,s)` where s is a new source and `f` is a function of type `() -> float` and returns the current RMS volume of the source, with `0.0 <= RMS volume <= 1.0`. Some operators like `amplify` and `compress` can produce amplitudes greater than 1.0 if misconfigured, inducing clipping in the output.

Type:
```
(?id : string, ?duration : {float}, source(audio='#b,
 video='#c, midi='#d)) ->
(() -> float) * source(audio='#b, video='#c, midi='#d)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `duration` (of type `{float}`, which defaults to `0.5`): Duration of the window (in seconds). A value <= 0, means that computation should not be performed.
- `(unlabeled)` (of type `source(audio='#b, video='#c, midi='#d)`)

### `rms.stereo`

Get current RMS volume of the source. Returns a pair `(f,s)` where s is a new source and `f` is a function of type `() -> float` and returns the current RMS volume of the source, with `0.0 <= RMS volume <= 1.0`. Some operators like `amplify` and `compress` can produce amplitudes greater than 1.0 if misconfigured, inducing clipping in the output.

Type:
```
(?id : string, ?duration : {float}, source(audio='#b+2,
 video='#c, midi='#d)) ->
(() -> float * float) * source(audio='#b+2, video='#c,
midi='#d)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `duration` (of type `{float}`, which defaults to `0.5`): Duration of the window (in seconds). A value <= 0, means that computation should not be performed.
- `(unlabeled)` (of type `source(audio='#b+2, video='#c, midi='#d)`)

### `server.rms`

Register a command that outputs the RMS of the returned source.

Type:
```
(?id : string, source(audio='#a, video='#b, midi='#c)) ->
source(audio='#a, video='#b, midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='#a, video='#b, midi='#c)`)

### `video.volume`

Graphical visualization of the sound.

Type:
```
(?id : string, source(audio='#a+1, video=0, midi=0)) ->
source(audio='#a+1, video=1, midi=0)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `(unlabeled)` (of type `source(audio='#a+1, video=0, midi=0)`)

### `vumeter`

VU meter (display the audio volume).

Type:
```
(?id : string, ?scroll : bool, source(audio='#a+1,
 video='#b, midi='#c)) -> source(audio='#a+1, video='#b,
midi='#c)
```

Arguments:

- `id` (of type `string`, which defaults to `""`): Force the value of the source ID.
- `scroll` (of type `bool`, which defaults to `false`): Scroll.
- `(unlabeled)` (of type `source(audio='#a+1, video='#b, midi='#c)`)

## String

### `%`

`pattern % [...,(k,v),...]` changes in the pattern occurences of:

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

### `base64.decode`

Decode a Base64 encoded string.

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `base64.encode`

Encode a string in Base64.

Type:
```
(string) -> string
```

Arguments:

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

### `float_of_string`

Convert a string to a float.

Type:
```
(?default : float, string) -> float
```

Arguments:

- `default` (of type `float`, which defaults to `0.0`)
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

### `json_of`

Convert a value to a json string.

Type:
```
(?compact : bool, 'a) -> string
```

Arguments:

- `compact` (of type `bool`, which defaults to `false`): Output compact text.
- `(unlabeled)` (of type `'a`)

### `of_json`

Parse a json string into a liquidsoap value. The value provided in the `default` parameter is quite important: only the part of the JSON data which has the same type as the `default` parameter will be kept (heterogeneous data cannot be represented in Liquidsoap because of typing). For instance, if the JSON `j` is
```
{
 "a": "test",
 "b": 5
}
```
the value returned by `of_json(default=[("",0)], j)` will be `[("b",5)]`: the pair `("a","test")` is not kept because it is not of type `string * int`.

Type:
```
(default : 'a, string) -> 'a
```

Arguments:

- `default` (of type `'a`): Default value if string cannot be parsed.
- `(unlabeled)` (of type `string`)

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

### `string.escape`

Escape special characters in a string. String is parsed char by char. See `string.utf8.escape` for an UTF8-aware parsing function.

Type:
```
(?special_chars : [string],
 ?escape_char : ((string) -> string), string) -> string
```

Arguments:

- `special_chars` (of type `[string]`, which defaults to `["\127", "\\", "\"", "\000", "\001", "\002", "\003", "\004", "\005", "\006", "\007", "\b", "\t", "\n", "\011", "\012", "\r", "\014", "\015", "\016", "\017", "\018", "\019", "\020", "\021", "\022", "\023", "\024", "\025", "\026", "\027", "\028", "\029", "\030", "\031"]`): List of characters that should be escaped. The first character of each element in the list is considered.
- `escape_char` (of type `(string) -> string`, which defaults to `<fun>`): Function used to escape a character.
- `(unlabeled)` (of type `string`)

### `string.extract`

Extract substrings from a string. 
Perl compatible regular expressions are recognized. Hence, special characters should be escaped. 
Returns a list of (index,value).
If the list does not have a pair associated to some index, it means that the corresponding pattern was not found.

Type:
```
(pattern : string, string) -> [string * string]
```

Arguments:

- `pattern` (of type `string`)
- `(unlabeled)` (of type `string`)

### `string.length`

Get the length of a string.

Type:
```
(string) -> int
```

Arguments:

- `(unlabeled)` (of type `string`)

### `string.match`

Match a string with an expression. Perl compatible regular expressions are recognized. Hence, special characters should be escaped.

Type:
```
(pattern : string, string) -> bool
```

Arguments:

- `pattern` (of type `string`)
- `(unlabeled)` (of type `string`)

### `string.quote`

Escape shell metacharacters.

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `string.recode`

Convert a string. Effective only if Camomile is enabled.

Type:
```
(?in_enc : string, ?out_enc : string, string) -> string
```

Arguments:

- `in_enc` (of type `string`, which defaults to `""`): Input encoding. Autodetected if empty.
- `out_enc` (of type `string`, which defaults to `"UTF-8"`): Output encoding.
- `(unlabeled)` (of type `string`)

### `string.replace`

Replace substrings in a string. 
Will replace all substrings matched in the pattern by the string returned by the replace function.

Type:
```
(pattern : string, ((string) -> string), string) ->
string
```

Arguments:

- `pattern` (of type `string`)
- `(unlabeled)` (of type `(string) -> string`)
- `(unlabeled)` (of type `string`)

### `string.split`

Split a string at 'separator'. 
Perl compatible regular expressions are recognized. Hence, special characters should be escaped.

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

### `string.utf8.escape`

Escape special charaters in an UTF8 string.

Type:
```
(?special_chars : [string],
 ?escape_char : ((string) -> string), string) -> string
```

Arguments:

- `special_chars` (of type `[string]`, which defaults to `["\127", "\\", "\"", "\000", "\001", "\002", "\003", "\004", "\005", "\006", "\007", "\b", "\t", "\n", "\011", "\012", "\r", "\014", "\015", "\016", "\017", "\018", "\019", "\020", "\021", "\022", "\023", "\024", "\025", "\026", "\027", "\028", "\029", "\030", "\031"]`): List of characters that should be escaped. The first character of each element in the list is considered.
- `escape_char` (of type `(string) -> string`, which defaults to `<fun>`): Function used to escape a character.
- `(unlabeled)` (of type `string`)

### `string_of`

Return the representation of a value.

Type:
```
('a) -> string
```

Arguments:

- `(unlabeled)` (of type `'a`)

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

Split an url of the form foo?arg=bar&arg2=bar2 into ("foo",[("arg","bar"),("arg2","bar2")]).

Type:
```
(string) -> string * [string * string]
```

Arguments:

- `(unlabeled)` (of type `string`): Url to split

### `url.split_args`

Split the arguments of an url of the form arg=bar&arg2=bar2 into [("arg","bar"),("arg2","bar2")].

Type:
```
(string) -> [string * string]
```

Arguments:

- `(unlabeled)` (of type `string`): Agument string to split

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


### `exec_at`

Execute a given action when a predicate is true. This will be run in background.

Type:
```
(?freq : float, pred : (() -> bool), (() -> unit)) ->
unit
```

Arguments:

- `freq` (of type `float`, which defaults to `1.0`): Frequency for checking the predicate, in seconds.
- `pred` (of type `() -> bool`): Predicate indicating when to execute the function, typically a time interval such as `{10h-10h30}`.
- `(unlabeled)` (of type `() -> unit`): Function to execute when the predicate is true.

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

### `file.mime_default`

Alias of file.mime (because it is available)

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

### `file.read`

Read the content of a file. Returns a function of type `()->string`. File is done reading when function returns the empty string `""`.

Type:
```
(string) -> () -> string
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

### `file.unlink`

Remove a file.

Type:
```
(string) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`)

### `file.watch`

Call a function when a file is modified. Returns unwatch function.

Type:
```
(string, (() -> unit)) -> () -> unit
```

Arguments:

- `(unlabeled)` (of type `string`): File to watch.
- `(unlabeled)` (of type `() -> unit`): Handler function.

### `file.write`

Write data to a file. Returns `true` if successful.

Type:
```
(data : string, ?append : bool, ?perms : int, string) ->
bool
```

Arguments:

- `data` (of type `string`): Data to write
- `append` (of type `bool`, which defaults to `false`): Append data if file exists.
- `perms` (of type `int`, which defaults to `420`): Default file rights if created
- `(unlabeled)` (of type `string`): Path to write to

### `get_mime`

Generic mime test. First try to use file.mime if it exist.  Otherwise try to get the value using the file binary. Returns "" (empty string) if no value can be found.

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`): The file to test

### `get_process_lines`

Perform a shell call and return the list of its output lines.

Type:
```
(?timeout : float, ?env : [string * string],
 ?inherit_env : bool, string) -> [string]
```

Arguments:

- `timeout` (of type `float`, which defaults to `-1.0`): Cancel process after `timeout` has elapsed. Ignored if negative.
- `env` (of type `[string * string]`, which defaults to `[]`): Process environment
- `inherit_env` (of type `bool`, which defaults to `true`): Inherit calling process's environment when `env` parameter is empty.
- `(unlabeled)` (of type `string`): Command to run

### `get_process_output`

Perform a shell call and return its output.

Type:
```
(?timeout : float, ?env : [string * string],
 ?inherit_env : bool, string) -> string
```

Arguments:

- `timeout` (of type `float`, which defaults to `-1.0`): Cancel process after `timeout` has elapsed. Ignored if negative.
- `env` (of type `[string * string]`, which defaults to `[]`): Process environment
- `inherit_env` (of type `bool`, which defaults to `true`): Inherit calling process's environment when `env` parameter is empty.
- `(unlabeled)` (of type `string`): Command to run

### `getenv`

Get the value associated to a variable in the process environment. Return "" if variable is not set.

Type:
```
(string) -> string
```

Arguments:

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


### `gettimeofday`

Return the current time since 00:00:00 GMT, Jan. 1, 1970, in seconds.

Type:
```
() -> float
```

Arguments:


### `gmtime`

Convert a time in seconds into a date in the UTC time zone and execute passed callback with the result. Fields meaning same as POSIX's `tm struct`. Warning: "year" is: year - 1900, i.e. 117 for 2017!

Type:
```
(float,
 ((sec : int, min : int, hour : int, mday : int,
   mon : int, year : int, wday : int, yday : int,
   isdst : bool) -> 'a)) -> 'a
```

Arguments:

- `(unlabeled)` (of type `float`)
- `(unlabeled)` (of type `(sec : int, min : int, hour : int, mday : int, mon : int,
 year : int, wday : int, yday : int, isdst : bool) -> 'a`)

### `localtime`

Convert a time in seconds into a date in the local time zone and execute passed callback with the result. Fields meaning same as POSIX's `tm struct`. Warning: "year" is: year - 1900, i.e. 117 for 2017!

Type:
```
(float,
 ((sec : int, min : int, hour : int, mday : int,
   mon : int, year : int, wday : int, yday : int,
   isdst : bool) -> 'a)) -> 'a
```

Arguments:

- `(unlabeled)` (of type `float`)
- `(unlabeled)` (of type `(sec : int, min : int, hour : int, mday : int, mon : int,
 year : int, wday : int, yday : int, isdst : bool) -> 'a`)

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

### `process.quote`

Return a quoted copy of the given string, suitable for use as one argument in a command line, escaping all meta-characters. Warning: under Windows, the output is only suitable for use with programs that follow the standard Windows quoting conventions.

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

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


### `run_process`

Run a process in a shell environment. Returns: `((stdout,stderr,status)` where status is one of: `("exit","")`, `("killed","<signal number>")`, `("stopped","<signal number>")`, `("exception","<exception description>")`, `("timeout","<run time>")`.

Type:
```
(?env : [string * string], ?inherit_env : bool,
 ?rwdirs : [string], ?rodirs : [string],
 ?network : string, ?timeout : float, string) ->
string * string * (string * string)
```

Arguments:

- `env` (of type `[string * string]`, which defaults to `[]`): Process environment
- `inherit_env` (of type `bool`, which defaults to `true`): Inherit calling process's environment when `env` parameter is empty.
- `rwdirs` (of type `[string]`, which defaults to `["default"]`): Read/write directories for sandboxing. `"default"` expands to sandbox default.
- `rodirs` (of type `[string]`, which defaults to `["default"]`): Read-only directories for sandboxing. `"default"` expands to sandbox default.
- `network` (of type `string`, which defaults to `"default"`): Enable or disable network inside sandboxed environment. One of: `"default"`, `"true"` or `"false"`. `"default"` is sandbox default.
- `timeout` (of type `float`, which defaults to `-1.0`): Cancel process after `timeout` has elapsed. Ignored if negative.
- `(unlabeled)` (of type `string`): Command to run

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
() -> unit
```

Arguments:


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

### `source.on_shutdown`

Register a function to be called when source shuts down.

Type:
```
(source('a), (() -> unit)) -> unit
```

Arguments:

- `(unlabeled)` (of type `source('a)`)
- `(unlabeled)` (of type `() -> unit`)

### `system`

Shell command call.

Type:
```
(string) -> unit
```

Arguments:

- `(unlabeled)` (of type `string`)

### `test_process`

Return true if process exited with 0 code.

Type:
```
(?timeout : float, ?env : [string * string],
 ?inherit_env : bool, string) -> bool
```

Arguments:

- `timeout` (of type `float`, which defaults to `-1.0`): Cancel process after `timeout` has elapsed. Ignored if negative.
- `env` (of type `[string * string]`, which defaults to `[]`): Process environment
- `inherit_env` (of type `bool`, which defaults to `true`): Inherit calling process's environment when `env` parameter is empty.
- `(unlabeled)` (of type `string`): Command to test

### `time`

Return the current time since 00:00:00 GMT, Jan. 1, 1970, in seconds.

Type:
```
() -> float
```

Arguments:


### `which`

which("progname") searches for an executable named "progname" using directories from the PATH environment variable and returns "" if it could not find one.

Type:
```
(string) -> string
```

Arguments:

- `(unlabeled)` (of type `string`)

