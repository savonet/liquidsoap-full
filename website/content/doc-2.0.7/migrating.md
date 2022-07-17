Migrating to a new Liquidsoap version
=====================================

In this page, we list the most common catches when migrating to a new version of
Liquidsoap.

From 1.4.x to 2.0.0
-------------------

### `audio_to_stereo`

`audio_to_stereo` should not be required in most situations anymore. `liquidsoap` can handle channels conversions transparently now! 

### `auth` function in `input.harbor`

The type of the `auth` function in `input.harbor` has changed. Where before, you would do:

```liquidsoap
def auth(user, password) =
  ...
end
```

You would now do:
```liquidsoap
def auth(params)
  user     = params.user
  password = params.password
  ...
end
```

### Type errors with lists of sources

Now that sources have their own methods, the actual list of methods attached to each source can vary from one to the next. For instance,
`playlist` has a `reload` method but `input.http` does not. This currently confuses the type checker and leads to errors that look like this:

```liquidsoap
At script.liq, line xxx, char yyy-zzz:
Error 5: this value has type
  _ * source(audio=?A, video=?B, midi=?C)
  .{
    time : () -> float,
    shutdown : () -> unit,
    fallible : bool,
    skip : () -> unit,
    seek : (float) -> float,
    is_active : () -> bool,
    is_up : () -> bool,
    log :
    {level : (() -> int?).{set : ((int) -> unit)}
    },
    self_sync : () -> bool,
    duration : () -> float,
    elapsed : () -> float,
    remaining : () -> float,
    on_track : ((([string * string]) -> unit)) -> unit,
    on_leave : ((() -> unit)) -> unit,
    on_shutdown : ((() -> unit)) -> unit,
    on_metadata : ((([string * string]) -> unit)) -> unit,
    is_ready : () -> bool,
    id : () -> string,
    selected : (() -> source(audio=?D, video=?E, midi=?F)?)
  }
but it should be a subtype of the type of the value at radio.liq, line 122, char 2-21
  _ * _.{reload : _}
```

In such cases, we recommend to give a little nudge to the typechecker by using the `(s:source)` type annotation where a list of source is causing the issue. For instance:

```liquidsoap
s = fallback([
  (s1:source),
  (s2:source),
  (s3:source)
])
```
This tells the type checker not to worry about the source methods and just focus on what matters, that they are actually sources.. 🙂

### Http input and operators

In order to provide as much compatibility as possible with the different HTTP procotols and implementation, we have decided
to delegate HTTP support to external libraries which have large scale support and implementation. This means that,
if you have installed `liquidsoap` using `opam`:

* You need to install the `ocurl` package to enable all HTTP request operators, `http.get`, `http.post`, `http.put`, `http.delete` and `http.head`
* You need to install the `ffmpeg` package (version `1.0.0` or above) to enable `input.http`
* You do not need to install the `ssl` package anymore to enable their `https` counter-part. These operators have been deprecated.

### Crossfade

The parameters for `cross` transitions was changed to take advantage of the new module system. Instead of passing multiple arguments
related to the ending and starting track, those are regrouped into a single record. So, if you had a transition like this:

```liquidsoap
def transition(
  ending_dB_level, starting_dB_level,
  ending_metadata, starting_metadata,
  ending_source,   starting_source) =
...
end
```

You would now do:

```liquidsoap
def transition(ending, starting) =
  # Now you can use:
  #  - ending.db_level, ending.metadata, ending.source
  #  - starting.db_level, starting.metadata, starting.source
...
end
```

### Settings

Settings are now exported as records. Where you would before write:

```liquidsoap
set("decoder.decoders", ["MAD", "FFMPEG"])
```

You can now write:

```liquidsoap
settings.decoder.decoders.set(["MAD", "FFMPEG"])
```

Likewise, to get a setting's value you can now do:

```liquidsoap
current_decoders = settings.decoder.decoders()
```

This provides many good features, in particular type-safety. 

For convenience, we have added shorter versions of the most used settings. These are all shortcuts to their respective `settings` values:

```liquidsoap
log.level.set(4)
log.file.set(true)
log.stdout.set(true)
init.daemon.set(true)
audio.samplerate.set(48000)
audio.channels.set(2)
video.frame.width.set(720)
video.frame.height.set(1280)
```

The `register` operator could not be adapted to this new API and had to be removed, however, backward-compatible
`set` and `get` operators are provided. Make sure to replace them as they should be removed in a future version.

### Metadata insertion

The function `insert_metadata` does not return a pair anymore, but a source with
a method named `insert_metadata`. This means that you should change the code

```liquidsoap
fs = insert_metadata(s)
# The function to insert metadata
f = fst(ms)
# The source with inserted metadata
s = snd(ms)
...
# Using the function
f([("artist", "Bob")])
...
# Using the source
output.pulseaudio(s)
```

to

```liquidsoap
s = insert_metadata(s)
...
# Using the function
s.insert_metadata([("artist", "Bob")])
...
# Using the source
output.pulseaudio(s)
```

### Request-based queueing

Queueing for request-based sources has been simplified. The `default_duration` and `length` have been removed in favor of
a simpler implementation. You can now pass a `prefetch` parameter which tells the source how many requests should be queued
in advance.

Should you need more advanced queueing strategy, `request.dynamic.list` and `request.dynamic` now export functions to retrieve 
and set their own queue of requests.

### JSON import/export

`json_of` has been renamed `json.stringify` and `of_json` has been renamed `json.parse`.

JSON export has been enhanced with a new generic json object export. Associative lists of type `(string, 'a)` are now
exported as lists. See our [JSON documentation page](json.html) for more details.

Convenience functions have been added to convert metadata to and from JSON object format: `metadata.json.stringify` and
`metadata.json.parse`.

### Deprecated operators

Some operators have been deprecated. For most of them, we provide a backward-compatible support 
but it is good practice to update your script. You should see logs in your script when running
deprecated operatords. Here's a list of the most important ones:

* `playlist.safe` is replaced by: `playlist(mksafe(..))`
* `playlist.once` is replaced by: `playlist`, setting `reload_mode` argument to `"never"` and `loop` to `false`
* `rewrite_metadata` should be rewritten using `metadata.map`
* `fade.inital` and `fade.final` are not needed anymore
* `get_process_output` is replaced by: `process.read`
* `get_process_lines` is replaced by: `process.read.lines`
* `test_process` is replaced by: `process.test`
* `system` is replaced by: `process.run`
* `add_timeout` is replaced by: `thread.run.recurrent`
* `on_blank` is replaced by: `blank.detect`
* `skip_blank` is replaced by: `blank.skip`
* `eat_blank` is replaced by: `blank.eat`
* `strip_blank` is replaced by: `blank.strip`
* `which` is replaced by: `file.which`
* `register_flow`: flow is no longer maintained
* `empty` is replaced by: `source.fail`
* `file.unlink` is replaced by: `file.remove`
* `string.utf8.escape` is replaced by: `string.escape`   
* `metadata.map` is replaced by: `metadata.map`
* `list.mem_assoc` is replaced by: `list.assoc.mem`

### Windows build

The windows binary is statically built and, for this reason, we cannot enable both the `%ffmpeg` encoder and any encoder that
uses the same underlying libraries, for instance `libmp3lame` for `mp3` encoding. The technical reason is that both libraries
import the same C symbols, which makes compilation fail.

The `%ffmpeg` encoder provides all the functionalities of the internal encoders that conflict with it along with many more format
we do not support otherwise. For this reason, it was decided to enable the `%ffmpeg` encoder and disable all other encoders.

This means that, if you were previously using a different encoder than `%ffmpeg`, you will need to adapt your script to
use it. For instance, for mp3 encoding with variable bitrate:

```liquidsoap
%ffmpeg(format="mp3", %audio(codec="libmp3lame", q=7))
```
