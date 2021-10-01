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

## Control

## File

## Filter

### `ffmpeg.filter.abench`

Ffmpeg filter: Benchmark part of a filtergraph.

Type:
```
(?action : int?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `action` (of type `int?`, which defaults to `null`): set action. (default: 0, possible values: 0 (start), 1 (stop))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.abitscope`

Ffmpeg filter: Convert input audio to audio bit scope video output.

Type:
```
(?rate : string?, ?r : string?, ?size : string?,
 ?s : string?, ?colors : string?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.video
```

Arguments:

- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `size` (of type `string?`, which defaults to `null`): set video size. (default: 1024x256)
- `s` (of type `string?`, which defaults to `null`): set video size. (default: 1024x256)
- `colors` (of type `string?`, which defaults to `null`): set channels colors. (default: red|green|blue|yellow|orange|lime|pink|magenta|brown)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.acompressor`

Ffmpeg filter: Audio compressor.

Type:
```
(?level_in : float?, ?mode : int?, ?threshold : float?,
 ?ratio : float?, ?attack : float?, ?release : float?,
 ?makeup : float?, ?knee : float?, ?link : int?,
 ?detection : int?, ?level_sc : float?, ?mix : float?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `level_in` (of type `float?`, which defaults to `null`): set input gain. (default: 1.)
- `mode` (of type `int?`, which defaults to `null`): set mode. (default: 0, possible values: 0 (downward), 1 (upward))
- `threshold` (of type `float?`, which defaults to `null`): set threshold. (default: 0.125)
- `ratio` (of type `float?`, which defaults to `null`): set ratio. (default: 2.)
- `attack` (of type `float?`, which defaults to `null`): set attack. (default: 20.)
- `release` (of type `float?`, which defaults to `null`): set release. (default: 250.)
- `makeup` (of type `float?`, which defaults to `null`): set make up gain. (default: 1.)
- `knee` (of type `float?`, which defaults to `null`): set knee. (default: 2.82843)
- `link` (of type `int?`, which defaults to `null`): set link type. (default: 0, possible values: 0 (average), 1 (maximum))
- `detection` (of type `int?`, which defaults to `null`): set detection. (default: 1, possible values: 0 (peak), 1 (rms))
- `level_sc` (of type `float?`, which defaults to `null`): set sidechain gain. (default: 1.)
- `mix` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.acontrast`

Ffmpeg filter: Simple audio dynamic range compression/expansion filter.

Type:
```
(?contrast : float?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `contrast` (of type `float?`, which defaults to `null`): set contrast. (default: 33.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.acopy`

Ffmpeg filter: Copy the input audio unchanged to the output.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.acrossfade`

Ffmpeg filter: Cross fade two input audio streams.

Type:
```
(?nb_samples : int?, ?ns : int?, ?duration : int?,
 ?d : int?, ?overlap : bool?, ?o : bool?, ?curve1 : int?,
 ?c1 : int?, ?curve2 : int?, ?c2 : int?,
 ffmpeg.filter.graph, ffmpeg.filter.audio,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `nb_samples` (of type `int?`, which defaults to `null`): set number of samples for cross fade duration. (default: 44100)
- `ns` (of type `int?`, which defaults to `null`): set number of samples for cross fade duration. (default: 44100)
- `duration` (of type `int?`, which defaults to `null`): set cross fade duration. (default: 0)
- `d` (of type `int?`, which defaults to `null`): set cross fade duration. (default: 0)
- `overlap` (of type `bool?`, which defaults to `null`): overlap 1st stream end with 2nd stream start. (default: true)
- `o` (of type `bool?`, which defaults to `null`): overlap 1st stream end with 2nd stream start. (default: true)
- `curve1` (of type `int?`, which defaults to `null`): set fade curve type for 1st stream. (default: 0, possible values: 0 (tri), 1 (qsin), 2 (esin), 3 (hsin), 4 (log), 5 (ipar), 6 (qua), 7 (cub), 8 (squ), 9 (cbr), 10 (par), 11 (exp), 12 (iqsin), 13 (ihsin), 14 (dese), 15 (desi), 16 (losi), 17 (nofade))
- `c1` (of type `int?`, which defaults to `null`): set fade curve type for 1st stream. (default: 0, possible values: 0 (tri), 1 (qsin), 2 (esin), 3 (hsin), 4 (log), 5 (ipar), 6 (qua), 7 (cub), 8 (squ), 9 (cbr), 10 (par), 11 (exp), 12 (iqsin), 13 (ihsin), 14 (dese), 15 (desi), 16 (losi), 17 (nofade))
- `curve2` (of type `int?`, which defaults to `null`): set fade curve type for 2nd stream. (default: 0, possible values: 0 (tri), 1 (qsin), 2 (esin), 3 (hsin), 4 (log), 5 (ipar), 6 (qua), 7 (cub), 8 (squ), 9 (cbr), 10 (par), 11 (exp), 12 (iqsin), 13 (ihsin), 14 (dese), 15 (desi), 16 (losi), 17 (nofade))
- `c2` (of type `int?`, which defaults to `null`): set fade curve type for 2nd stream. (default: 0, possible values: 0 (tri), 1 (qsin), 2 (esin), 3 (hsin), 4 (log), 5 (ipar), 6 (qua), 7 (cub), 8 (squ), 9 (cbr), 10 (par), 11 (exp), 12 (iqsin), 13 (ihsin), 14 (dese), 15 (desi), 16 (losi), 17 (nofade))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.acrossover`

Ffmpeg filter: Split audio into per-bands streams. This filter has dynamic outputs: returned value is a tuple of audio and video outputs. Total number of outputs is determined at runtime.

Type:
```
(?split : string?, ?order : int?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) ->
[ffmpeg.filter.audio] * [ffmpeg.filter.video]
```

Arguments:

- `split` (of type `string?`, which defaults to `null`): set split frequencies. (default: 500)
- `order` (of type `int?`, which defaults to `null`): set order. (default: 1, possible values: 0 (2nd), 1 (4th), 2 (8th))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.acrusher`

Ffmpeg filter: Reduce audio bit resolution.

Type:
```
(?level_in : float?, ?level_out : float?, ?bits : float?,
 ?mix : float?, ?mode : int?, ?dc : float?, ?aa : float?,
 ?samples : float?, ?lfo : bool?, ?lforange : float?,
 ?lforate : float?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `level_in` (of type `float?`, which defaults to `null`): set level in. (default: 1.)
- `level_out` (of type `float?`, which defaults to `null`): set level out. (default: 1.)
- `bits` (of type `float?`, which defaults to `null`): set bit reduction. (default: 8.)
- `mix` (of type `float?`, which defaults to `null`): set mix. (default: 0.5)
- `mode` (of type `int?`, which defaults to `null`): set mode. (default: 0, possible values: 0 (lin), 1 (log))
- `dc` (of type `float?`, which defaults to `null`): set DC. (default: 1.)
- `aa` (of type `float?`, which defaults to `null`): set anti-aliasing. (default: 0.5)
- `samples` (of type `float?`, which defaults to `null`): set sample reduction. (default: 1.)
- `lfo` (of type `bool?`, which defaults to `null`): enable LFO. (default: false)
- `lforange` (of type `float?`, which defaults to `null`): set LFO depth. (default: 20.)
- `lforate` (of type `float?`, which defaults to `null`): set LFO rate. (default: 0.3)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.acue`

Ffmpeg filter: Delay filtering to match a cue.

Type:
```
(?cue : int?, ?preroll : int?, ?buffer : int?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `cue` (of type `int?`, which defaults to `null`): cue unix timestamp in microseconds. (default: 0)
- `preroll` (of type `int?`, which defaults to `null`): preroll duration in seconds. (default: 0)
- `buffer` (of type `int?`, which defaults to `null`): buffer duration in seconds. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.addroi`

Ffmpeg filter: Add region of interest to frame.

Type:
```
(?x : string?, ?y : string?, ?w : string?, ?h : string?,
 ?qoffset : string?, ?clear : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `x` (of type `string?`, which defaults to `null`): Region distance from left edge of frame.. (default: 0)
- `y` (of type `string?`, which defaults to `null`): Region distance from top edge of frame.. (default: 0)
- `w` (of type `string?`, which defaults to `null`): Region width.. (default: 0)
- `h` (of type `string?`, which defaults to `null`): Region height.. (default: 0)
- `qoffset` (of type `string?`, which defaults to `null`): Quantisation offset to apply in the region.. (default: -1/10)
- `clear` (of type `bool?`, which defaults to `null`): Remove any existing regions of interest before adding the new one.. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.adeclick`

Ffmpeg filter: Remove impulsive noise from input audio.

Type:
```
(?w : float?, ?o : float?, ?a : float?, ?t : float?,
 ?b : float?, ?m : int?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `w` (of type `float?`, which defaults to `null`): set window size. (default: 55.)
- `o` (of type `float?`, which defaults to `null`): set window overlap. (default: 75.)
- `a` (of type `float?`, which defaults to `null`): set autoregression order. (default: 2.)
- `t` (of type `float?`, which defaults to `null`): set threshold. (default: 2.)
- `b` (of type `float?`, which defaults to `null`): set burst fusion. (default: 2.)
- `m` (of type `int?`, which defaults to `null`): set overlap method. (default: 0, possible values: 0 (a), 1 (s))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.adeclip`

Ffmpeg filter: Remove clipping from input audio.

Type:
```
(?w : float?, ?o : float?, ?a : float?, ?t : float?,
 ?n : int?, ?m : int?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `w` (of type `float?`, which defaults to `null`): set window size. (default: 55.)
- `o` (of type `float?`, which defaults to `null`): set window overlap. (default: 75.)
- `a` (of type `float?`, which defaults to `null`): set autoregression order. (default: 8.)
- `t` (of type `float?`, which defaults to `null`): set threshold. (default: 10.)
- `n` (of type `int?`, which defaults to `null`): set histogram size. (default: 1000)
- `m` (of type `int?`, which defaults to `null`): set overlap method. (default: 0, possible values: 0 (a), 1 (s))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.adelay`

Ffmpeg filter: Delay one or more audio channels.

Type:
```
(?delays : string?, ?all : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `delays` (of type `string?`, which defaults to `null`): set list of delays for each channel
- `all` (of type `bool?`, which defaults to `null`): use last available delay for remained channels. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.aderivative`

Ffmpeg filter: Compute derivative of input audio.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.adrawgraph`

Ffmpeg filter: Draw a graph using input audio metadata.

Type:
```
(?m1 : string?, ?fg1 : string?, ?m2 : string?,
 ?fg2 : string?, ?m3 : string?, ?fg3 : string?,
 ?m4 : string?, ?fg4 : string?, ?bg : string?,
 ?min : float?, ?max : float?, ?mode : int?,
 ?slide : int?, ?size : string?, ?s : string?,
 ?rate : string?, ?r : string?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.video
```

Arguments:

- `m1` (of type `string?`, which defaults to `null`): set 1st metadata key. (default: )
- `fg1` (of type `string?`, which defaults to `null`): set 1st foreground color expression. (default: 0xffff0000)
- `m2` (of type `string?`, which defaults to `null`): set 2nd metadata key. (default: )
- `fg2` (of type `string?`, which defaults to `null`): set 2nd foreground color expression. (default: 0xff00ff00)
- `m3` (of type `string?`, which defaults to `null`): set 3rd metadata key. (default: )
- `fg3` (of type `string?`, which defaults to `null`): set 3rd foreground color expression. (default: 0xffff00ff)
- `m4` (of type `string?`, which defaults to `null`): set 4th metadata key. (default: )
- `fg4` (of type `string?`, which defaults to `null`): set 4th foreground color expression. (default: 0xffffff00)
- `bg` (of type `string?`, which defaults to `null`): set background color. (default: white)
- `min` (of type `float?`, which defaults to `null`): set minimal value. (default: -1.)
- `max` (of type `float?`, which defaults to `null`): set maximal value. (default: 1.)
- `mode` (of type `int?`, which defaults to `null`): set graph mode. (default: 2, possible values: 0 (bar), 1 (dot), 2 (line))
- `slide` (of type `int?`, which defaults to `null`): set slide mode. (default: 0, possible values: 0 (frame), 1 (replace), 2 (scroll), 3 (rscroll), 4 (picture))
- `size` (of type `string?`, which defaults to `null`): set graph size. (default: 900x256)
- `s` (of type `string?`, which defaults to `null`): set graph size. (default: 900x256)
- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.aecho`

Ffmpeg filter: Add echoing to the audio.

Type:
```
(?in_gain : float?, ?out_gain : float?,
 ?delays : string?, ?decays : string?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `in_gain` (of type `float?`, which defaults to `null`): set signal input gain. (default: 0.6)
- `out_gain` (of type `float?`, which defaults to `null`): set signal output gain. (default: 0.3)
- `delays` (of type `string?`, which defaults to `null`): set list of signal delays. (default: 1000)
- `decays` (of type `string?`, which defaults to `null`): set list of signal decays. (default: 0.5)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.aemphasis`

Ffmpeg filter: Audio emphasis.

Type:
```
(?level_in : float?, ?level_out : float?, ?mode : int?,
 ?type : int?, ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `level_in` (of type `float?`, which defaults to `null`): set input gain. (default: 1.)
- `level_out` (of type `float?`, which defaults to `null`): set output gain. (default: 1.)
- `mode` (of type `int?`, which defaults to `null`): set filter mode. (default: 0, possible values: 0 (reproduction), 1 (production))
- `type` (of type `int?`, which defaults to `null`): set filter type. (default: 4, possible values: 0 (col), 1 (emi), 2 (bsi), 3 (riaa), 4 (cd), 5 (50fm), 6 (75fm), 7 (50kf), 8 (75kf))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.aeval`

Ffmpeg filter: Filter audio signal according to a specified expression.

Type:
```
(?exprs : string?, ?channel_layout : string?,
 ?c : string?, ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `exprs` (of type `string?`, which defaults to `null`): set the '|'-separated list of channels expressions
- `channel_layout` (of type `string?`, which defaults to `null`): set channel layout
- `c` (of type `string?`, which defaults to `null`): set channel layout
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.aevalsrc`

Ffmpeg filter: Generate an audio signal generated by an expression.

Type:
```
(?exprs : string?, ?nb_samples : int?, ?n : int?,
 ?sample_rate : string?, ?s : string?, ?duration : int?,
 ?d : int?, ?channel_layout : string?, ?c : string?,
 ffmpeg.filter.graph) -> ffmpeg.filter.audio
```

Arguments:

- `exprs` (of type `string?`, which defaults to `null`): set the '|'-separated list of channels expressions
- `nb_samples` (of type `int?`, which defaults to `null`): set the number of samples per requested frame. (default: 1024)
- `n` (of type `int?`, which defaults to `null`): set the number of samples per requested frame. (default: 1024)
- `sample_rate` (of type `string?`, which defaults to `null`): set the sample rate. (default: 44100)
- `s` (of type `string?`, which defaults to `null`): set the sample rate. (default: 44100)
- `duration` (of type `int?`, which defaults to `null`): set audio duration. (default: -1)
- `d` (of type `int?`, which defaults to `null`): set audio duration. (default: -1)
- `channel_layout` (of type `string?`, which defaults to `null`): set channel layout
- `c` (of type `string?`, which defaults to `null`): set channel layout
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.afade`

Ffmpeg filter: Fade in/out input audio.

Type:
```
(?type : int?, ?t : int?, ?start_sample : int?,
 ?ss : int?, ?nb_samples : int?, ?ns : int?,
 ?start_time : int?, ?st : int?, ?duration : int?,
 ?d : int?, ?curve : int?, ?c : int?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `type` (of type `int?`, which defaults to `null`): set the fade direction. (default: 0, possible values: 0 (in), 1 (out))
- `t` (of type `int?`, which defaults to `null`): set the fade direction. (default: 0, possible values: 0 (in), 1 (out))
- `start_sample` (of type `int?`, which defaults to `null`): set number of first sample to start fading. (default: 0)
- `ss` (of type `int?`, which defaults to `null`): set number of first sample to start fading. (default: 0)
- `nb_samples` (of type `int?`, which defaults to `null`): set number of samples for fade duration. (default: 44100)
- `ns` (of type `int?`, which defaults to `null`): set number of samples for fade duration. (default: 44100)
- `start_time` (of type `int?`, which defaults to `null`): set time to start fading. (default: 0)
- `st` (of type `int?`, which defaults to `null`): set time to start fading. (default: 0)
- `duration` (of type `int?`, which defaults to `null`): set fade duration. (default: 0)
- `d` (of type `int?`, which defaults to `null`): set fade duration. (default: 0)
- `curve` (of type `int?`, which defaults to `null`): set fade curve type. (default: 0, possible values: 0 (tri), 1 (qsin), 2 (esin), 3 (hsin), 4 (log), 5 (ipar), 6 (qua), 7 (cub), 8 (squ), 9 (cbr), 10 (par), 11 (exp), 12 (iqsin), 13 (ihsin), 14 (dese), 15 (desi), 16 (losi), 17 (nofade))
- `c` (of type `int?`, which defaults to `null`): set fade curve type. (default: 0, possible values: 0 (tri), 1 (qsin), 2 (esin), 3 (hsin), 4 (log), 5 (ipar), 6 (qua), 7 (cub), 8 (squ), 9 (cbr), 10 (par), 11 (exp), 12 (iqsin), 13 (ihsin), 14 (dese), 15 (desi), 16 (losi), 17 (nofade))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.afftdn`

Ffmpeg filter: Denoise audio samples using FFT.

Type:
```
(?nr : float?, ?nf : float?, ?nt : int?, ?bn : string?,
 ?rf : float?, ?tn : bool?, ?tr : bool?, ?om : int?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `nr` (of type `float?`, which defaults to `null`): set the noise reduction. (default: 12.)
- `nf` (of type `float?`, which defaults to `null`): set the noise floor. (default: -50.)
- `nt` (of type `int?`, which defaults to `null`): set the noise type. (default: 0, possible values: 0 (w), 1 (v), 2 (s), 3 (c))
- `bn` (of type `string?`, which defaults to `null`): set the custom bands noise
- `rf` (of type `float?`, which defaults to `null`): set the residual floor. (default: -38.)
- `tn` (of type `bool?`, which defaults to `null`): track noise. (default: false)
- `tr` (of type `bool?`, which defaults to `null`): track residual. (default: false)
- `om` (of type `int?`, which defaults to `null`): set output mode. (default: 1, possible values: 0 (i), 1 (o), 2 (n))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.afftfilt`

Ffmpeg filter: Apply arbitrary expressions to samples in frequency domain.

Type:
```
(?real : string?, ?imag : string?, ?win_size : int?,
 ?win_func : int?, ?overlap : float?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `real` (of type `string?`, which defaults to `null`): set channels real expressions. (default: re)
- `imag` (of type `string?`, which defaults to `null`): set channels imaginary expressions. (default: im)
- `win_size` (of type `int?`, which defaults to `null`): set window size. (default: 4096)
- `win_func` (of type `int?`, which defaults to `null`): set window function. (default: 1, possible values: 0 (rect), 4 (bartlett), 1 (hann), 1 (hanning), 2 (hamming), 3 (blackman), 5 (welch), 6 (flattop), 7 (bharris), 8 (bnuttall), 11 (bhann), 9 (sine), 10 (nuttall), 12 (lanczos), 13 (gauss), 14 (tukey), 15 (dolph), 16 (cauchy), 17 (parzen), 18 (poisson), 19 (bohman))
- `overlap` (of type `float?`, which defaults to `null`): set window overlap. (default: 0.75)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.afifo`

Ffmpeg filter: Buffer input frames and send them when they are requested.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.afir`

Ffmpeg filter: Apply Finite Impulse Response filter with supplied coefficients in additional stream(s). This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime. This filter has dynamic outputs: returned value is a tuple of audio and video outputs. Total number of outputs is determined at runtime.

Type:
```
(?dry : float?, ?wet : float?, ?length : float?,
 ?gtype : int?, ?irgain : float?, ?irfmt : int?,
 ?maxir : float?, ?response : bool?, ?channel : int?,
 ?size : string?, ?rate : string?, ?minp : int?,
 ?maxp : int?, ?nbirs : int?, ?ir : int?,
 ffmpeg.filter.graph, [ffmpeg.filter.audio],
 [ffmpeg.filter.video]) ->
[ffmpeg.filter.audio] * [ffmpeg.filter.video]
```

Arguments:

- `dry` (of type `float?`, which defaults to `null`): set dry gain. (default: 1.)
- `wet` (of type `float?`, which defaults to `null`): set wet gain. (default: 1.)
- `length` (of type `float?`, which defaults to `null`): set IR length. (default: 1.)
- `gtype` (of type `int?`, which defaults to `null`): set IR auto gain type. (default: 0, possible values: -1 (none), 0 (peak), 1 (dc), 2 (gn))
- `irgain` (of type `float?`, which defaults to `null`): set IR gain. (default: 1.)
- `irfmt` (of type `int?`, which defaults to `null`): set IR format. (default: 1, possible values: 0 (mono), 1 (input))
- `maxir` (of type `float?`, which defaults to `null`): set max IR length. (default: 30.)
- `response` (of type `bool?`, which defaults to `null`): show IR frequency response. (default: false)
- `channel` (of type `int?`, which defaults to `null`): set IR channel to display frequency response. (default: 0)
- `size` (of type `string?`, which defaults to `null`): set video size. (default: hd720)
- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `minp` (of type `int?`, which defaults to `null`): set min partition size. (default: 8192)
- `maxp` (of type `int?`, which defaults to `null`): set max partition size. (default: 8192)
- `nbirs` (of type `int?`, which defaults to `null`): set number of input IRs. (default: 1)
- `ir` (of type `int?`, which defaults to `null`): select IR. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.afirsrc`

Ffmpeg filter: Generate a FIR coefficients audio stream.

Type:
```
(?taps : int?, ?t : int?, ?frequency : string?,
 ?f : string?, ?magnitude : string?, ?m : string?,
 ?phase : string?, ?p : string?, ?sample_rate : int?,
 ?r : int?, ?nb_samples : int?, ?n : int?,
 ?win_func : int?, ?w : int?, ffmpeg.filter.graph) ->
ffmpeg.filter.audio
```

Arguments:

- `taps` (of type `int?`, which defaults to `null`): set number of taps. (default: 1025)
- `t` (of type `int?`, which defaults to `null`): set number of taps. (default: 1025)
- `frequency` (of type `string?`, which defaults to `null`): set frequency points. (default: 0 1)
- `f` (of type `string?`, which defaults to `null`): set frequency points. (default: 0 1)
- `magnitude` (of type `string?`, which defaults to `null`): set magnitude values. (default: 1 1)
- `m` (of type `string?`, which defaults to `null`): set magnitude values. (default: 1 1)
- `phase` (of type `string?`, which defaults to `null`): set phase values. (default: 0 0)
- `p` (of type `string?`, which defaults to `null`): set phase values. (default: 0 0)
- `sample_rate` (of type `int?`, which defaults to `null`): set sample rate. (default: 44100)
- `r` (of type `int?`, which defaults to `null`): set sample rate. (default: 44100)
- `nb_samples` (of type `int?`, which defaults to `null`): set the number of samples per requested frame. (default: 1024)
- `n` (of type `int?`, which defaults to `null`): set the number of samples per requested frame. (default: 1024)
- `win_func` (of type `int?`, which defaults to `null`): set window function. (default: 3, possible values: 0 (rect), 4 (bartlett), 1 (hanning), 2 (hamming), 3 (blackman), 5 (welch), 6 (flattop), 7 (bharris), 8 (bnuttall), 11 (bhann), 9 (sine), 10 (nuttall), 12 (lanczos), 13 (gauss), 14 (tukey), 15 (dolph), 16 (cauchy), 17 (parzen), 18 (poisson), 19 (bohman))
- `w` (of type `int?`, which defaults to `null`): set window function. (default: 3, possible values: 0 (rect), 4 (bartlett), 1 (hanning), 2 (hamming), 3 (blackman), 5 (welch), 6 (flattop), 7 (bharris), 8 (bnuttall), 11 (bhann), 9 (sine), 10 (nuttall), 12 (lanczos), 13 (gauss), 14 (tukey), 15 (dolph), 16 (cauchy), 17 (parzen), 18 (poisson), 19 (bohman))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.aformat`

Ffmpeg filter: Convert the input audio to one of the specified formats.

Type:
```
(?sample_fmts : string?, ?f : string?,
 ?sample_rates : string?, ?r : string?,
 ?channel_layouts : string?, ?cl : string?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `sample_fmts` (of type `string?`, which defaults to `null`): A '|'-separated list of sample formats.
- `f` (of type `string?`, which defaults to `null`): A '|'-separated list of sample formats.
- `sample_rates` (of type `string?`, which defaults to `null`): A '|'-separated list of sample rates.
- `r` (of type `string?`, which defaults to `null`): A '|'-separated list of sample rates.
- `channel_layouts` (of type `string?`, which defaults to `null`): A '|'-separated list of channel layouts.
- `cl` (of type `string?`, which defaults to `null`): A '|'-separated list of channel layouts.
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.agate`

Ffmpeg filter: Audio gate.

Type:
```
(?level_in : float?, ?mode : int?, ?range : float?,
 ?threshold : float?, ?ratio : float?, ?attack : float?,
 ?release : float?, ?makeup : float?, ?knee : float?,
 ?detection : int?, ?link : int?, ?level_sc : float?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `level_in` (of type `float?`, which defaults to `null`): set input level. (default: 1.)
- `mode` (of type `int?`, which defaults to `null`): set mode. (default: 0, possible values: 0 (downward), 1 (upward))
- `range` (of type `float?`, which defaults to `null`): set max gain reduction. (default: 0.06125)
- `threshold` (of type `float?`, which defaults to `null`): set threshold. (default: 0.125)
- `ratio` (of type `float?`, which defaults to `null`): set ratio. (default: 2.)
- `attack` (of type `float?`, which defaults to `null`): set attack. (default: 20.)
- `release` (of type `float?`, which defaults to `null`): set release. (default: 250.)
- `makeup` (of type `float?`, which defaults to `null`): set makeup gain. (default: 1.)
- `knee` (of type `float?`, which defaults to `null`): set knee. (default: 2.828427125)
- `detection` (of type `int?`, which defaults to `null`): set detection. (default: 1, possible values: 0 (peak), 1 (rms))
- `link` (of type `int?`, which defaults to `null`): set link. (default: 0, possible values: 0 (average), 1 (maximum))
- `level_sc` (of type `float?`, which defaults to `null`): set sidechain gain. (default: 1.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.agraphmonitor`

Ffmpeg filter: Show various filtergraph stats.

Type:
```
(?size : string?, ?s : string?, ?opacity : float?,
 ?o : float?, ?mode : int?, ?m : int?, ?flags : int?,
 ?f : int?, ?rate : string?, ?r : string?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.video
```

Arguments:

- `size` (of type `string?`, which defaults to `null`): set monitor size. (default: hd720)
- `s` (of type `string?`, which defaults to `null`): set monitor size. (default: hd720)
- `opacity` (of type `float?`, which defaults to `null`): set video opacity. (default: 0.9)
- `o` (of type `float?`, which defaults to `null`): set video opacity. (default: 0.9)
- `mode` (of type `int?`, which defaults to `null`): set mode. (default: 0, possible values: 0 (full), 1 (compact))
- `m` (of type `int?`, which defaults to `null`): set mode. (default: 0, possible values: 0 (full), 1 (compact))
- `flags` (of type `int?`, which defaults to `null`): set flags. (default: 1, possible values: 1 (queue), 4 (frame_count_in), 2 (frame_count_out), 8 (pts), 16 (time), 32 (timebase), 64 (format), 128 (size), 256 (rate))
- `f` (of type `int?`, which defaults to `null`): set flags. (default: 1, possible values: 1 (queue), 4 (frame_count_in), 2 (frame_count_out), 8 (pts), 16 (time), 32 (timebase), 64 (format), 128 (size), 256 (rate))
- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.ahistogram`

Ffmpeg filter: Convert input audio to histogram video output.

Type:
```
(?dmode : int?, ?rate : string?, ?r : string?,
 ?size : string?, ?s : string?, ?scale : int?,
 ?ascale : int?, ?acount : int?, ?rheight : float?,
 ?slide : int?, ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.video
```

Arguments:

- `dmode` (of type `int?`, which defaults to `null`): set method to display channels. (default: 0, possible values: 0 (single), 1 (separate))
- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `size` (of type `string?`, which defaults to `null`): set video size. (default: hd720)
- `s` (of type `string?`, which defaults to `null`): set video size. (default: hd720)
- `scale` (of type `int?`, which defaults to `null`): set display scale. (default: 3, possible values: 3 (log), 1 (sqrt), 2 (cbrt), 0 (lin), 4 (rlog))
- `ascale` (of type `int?`, which defaults to `null`): set amplitude scale. (default: 1, possible values: 1 (log), 0 (lin))
- `acount` (of type `int?`, which defaults to `null`): how much frames to accumulate. (default: 1)
- `rheight` (of type `float?`, which defaults to `null`): set histogram ratio of window height. (default: 0.1)
- `slide` (of type `int?`, which defaults to `null`): set sonogram sliding. (default: 0, possible values: 0 (replace), 1 (scroll))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.aiir`

Ffmpeg filter: Apply Infinite Impulse Response filter with supplied coefficients. This filter has dynamic outputs: returned value is a tuple of audio and video outputs. Total number of outputs is determined at runtime.

Type:
```
(?zeros : string?, ?z : string?, ?poles : string?,
 ?p : string?, ?gains : string?, ?k : string?,
 ?dry : float?, ?wet : float?, ?format : int?, ?f : int?,
 ?process : int?, ?r : int?, ?precision : int?,
 ?e : int?, ?normalize : bool?, ?n : bool?,
 ?mix : float?, ?response : bool?, ?channel : int?,
 ?size : string?, ?rate : string?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) ->
[ffmpeg.filter.audio] * [ffmpeg.filter.video]
```

Arguments:

- `zeros` (of type `string?`, which defaults to `null`): set B/numerator/zeros coefficients. (default: 1+0i 1-0i)
- `z` (of type `string?`, which defaults to `null`): set B/numerator/zeros coefficients. (default: 1+0i 1-0i)
- `poles` (of type `string?`, which defaults to `null`): set A/denominator/poles coefficients. (default: 1+0i 1-0i)
- `p` (of type `string?`, which defaults to `null`): set A/denominator/poles coefficients. (default: 1+0i 1-0i)
- `gains` (of type `string?`, which defaults to `null`): set channels gains. (default: 1|1)
- `k` (of type `string?`, which defaults to `null`): set channels gains. (default: 1|1)
- `dry` (of type `float?`, which defaults to `null`): set dry gain. (default: 1.)
- `wet` (of type `float?`, which defaults to `null`): set wet gain. (default: 1.)
- `format` (of type `int?`, which defaults to `null`): set coefficients format. (default: 1, possible values: 0 (tf), 1 (zp), 2 (pr), 3 (pd), 4 (sp))
- `f` (of type `int?`, which defaults to `null`): set coefficients format. (default: 1, possible values: 0 (tf), 1 (zp), 2 (pr), 3 (pd), 4 (sp))
- `process` (of type `int?`, which defaults to `null`): set kind of processing. (default: 1, possible values: 0 (d), 1 (s))
- `r` (of type `int?`, which defaults to `null`): set kind of processing. (default: 1, possible values: 0 (d), 1 (s))
- `precision` (of type `int?`, which defaults to `null`): set filtering precision. (default: 0, possible values: 0 (dbl), 1 (flt), 2 (i32), 3 (i16))
- `e` (of type `int?`, which defaults to `null`): set precision. (default: 0, possible values: 0 (dbl), 1 (flt), 2 (i32), 3 (i16))
- `normalize` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: true)
- `n` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: true)
- `mix` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `response` (of type `bool?`, which defaults to `null`): show IR frequency response. (default: false)
- `channel` (of type `int?`, which defaults to `null`): set IR channel to display frequency response. (default: 0)
- `size` (of type `string?`, which defaults to `null`): set video size. (default: hd720)
- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.aintegral`

Ffmpeg filter: Compute integral of input audio.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.ainterleave`

Ffmpeg filter: Temporally interleave audio inputs. This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime.

Type:
```
(?nb_inputs : int?, ?n : int?, ?duration : int?,
 ffmpeg.filter.graph, [ffmpeg.filter.audio],
 [ffmpeg.filter.video]) -> ffmpeg.filter.audio
```

Arguments:

- `nb_inputs` (of type `int?`, which defaults to `null`): set number of inputs. (default: 2)
- `n` (of type `int?`, which defaults to `null`): set number of inputs. (default: 2)
- `duration` (of type `int?`, which defaults to `null`): how to determine the end-of-stream. (default: 0, possible values: 0 (longest), 1 (shortest), 2 (first))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.alimiter`

Ffmpeg filter: Audio lookahead limiter.

Type:
```
(?level_in : float?, ?level_out : float?,
 ?limit : float?, ?attack : float?, ?release : float?,
 ?asc : bool?, ?asc_level : float?, ?level : bool?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `level_in` (of type `float?`, which defaults to `null`): set input level. (default: 1.)
- `level_out` (of type `float?`, which defaults to `null`): set output level. (default: 1.)
- `limit` (of type `float?`, which defaults to `null`): set limit. (default: 1.)
- `attack` (of type `float?`, which defaults to `null`): set attack. (default: 5.)
- `release` (of type `float?`, which defaults to `null`): set release. (default: 50.)
- `asc` (of type `bool?`, which defaults to `null`): enable asc. (default: false)
- `asc_level` (of type `float?`, which defaults to `null`): set asc level. (default: 0.5)
- `level` (of type `bool?`, which defaults to `null`): auto level. (default: true)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.allpass`

Ffmpeg filter: Apply a two-pole all-pass filter.

Type:
```
(?frequency : float?, ?f : float?, ?width_type : int?,
 ?t : int?, ?width : float?, ?w : float?, ?mix : float?,
 ?m : float?, ?channels : string?, ?c : string?,
 ?normalize : bool?, ?n : bool?, ?order : int?,
 ?o : int?, ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `frequency` (of type `float?`, which defaults to `null`): set central frequency. (default: 3000.)
- `f` (of type `float?`, which defaults to `null`): set central frequency. (default: 3000.)
- `width_type` (of type `int?`, which defaults to `null`): set filter-width type. (default: 1, possible values: 1 (h), 3 (q), 2 (o), 4 (s), 5 (k))
- `t` (of type `int?`, which defaults to `null`): set filter-width type. (default: 1, possible values: 1 (h), 3 (q), 2 (o), 4 (s), 5 (k))
- `width` (of type `float?`, which defaults to `null`): set filter-width. (default: 707.1)
- `w` (of type `float?`, which defaults to `null`): set filter-width. (default: 707.1)
- `mix` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `m` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `channels` (of type `string?`, which defaults to `null`): set channels to filter
- `c` (of type `string?`, which defaults to `null`): set channels to filter
- `normalize` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: false)
- `n` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: false)
- `order` (of type `int?`, which defaults to `null`): set filter order. (default: 2)
- `o` (of type `int?`, which defaults to `null`): set filter order. (default: 2)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.allrgb`

Ffmpeg filter: Generate all RGB colors.

Type:
```
(?rate : string?, ?r : string?, ?duration : int?,
 ?d : int?, ?sar : string?, ffmpeg.filter.graph) ->
ffmpeg.filter.video
```

Arguments:

- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `duration` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `d` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `sar` (of type `string?`, which defaults to `null`): set video sample aspect ratio. (default: 1/1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.allyuv`

Ffmpeg filter: Generate all yuv colors.

Type:
```
(?rate : string?, ?r : string?, ?duration : int?,
 ?d : int?, ?sar : string?, ffmpeg.filter.graph) ->
ffmpeg.filter.video
```

Arguments:

- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `duration` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `d` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `sar` (of type `string?`, which defaults to `null`): set video sample aspect ratio. (default: 1/1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.aloop`

Ffmpeg filter: Loop audio samples.

Type:
```
(?loop : int?, ?size : int?, ?start : int?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `loop` (of type `int?`, which defaults to `null`): number of loops. (default: 0)
- `size` (of type `int?`, which defaults to `null`): max number of samples to loop. (default: 0)
- `start` (of type `int?`, which defaults to `null`): set the loop start sample. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.alphaextract`

Ffmpeg filter: Extract an alpha channel as a grayscale image component. This filter has dynamic outputs: returned value is a tuple of audio and video outputs. Total number of outputs is determined at runtime.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.video) ->
[ffmpeg.filter.audio] * [ffmpeg.filter.video]
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.alphamerge`

Ffmpeg filter: Copy the luma value of the second input into the alpha channel of the first input.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.video,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.amerge`

Ffmpeg filter: Merge two or more audio streams into a single multi-channel stream. This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime.

Type:
```
(?inputs : int?, ffmpeg.filter.graph,
 [ffmpeg.filter.audio], [ffmpeg.filter.video]) ->
ffmpeg.filter.audio
```

Arguments:

- `inputs` (of type `int?`, which defaults to `null`): specify the number of inputs. (default: 2)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.ametadata`

Ffmpeg filter: Manipulate audio frame metadata.

Type:
```
(?mode : int?, ?key : string?, ?value : string?,
 ?function : int?, ?expr : string?, ?file : string?,
 ?direct : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `mode` (of type `int?`, which defaults to `null`): set a mode of operation. (default: 0, possible values: 0 (select), 1 (add), 2 (modify), 3 (delete), 4 (print))
- `key` (of type `string?`, which defaults to `null`): set metadata key
- `value` (of type `string?`, which defaults to `null`): set metadata value
- `function` (of type `int?`, which defaults to `null`): function for comparing values. (default: 0, possible values: 0 (same_str), 1 (starts_with), 2 (less), 3 (equal), 4 (greater), 5 (expr), 6 (ends_with))
- `expr` (of type `string?`, which defaults to `null`): set expression for expr function
- `file` (of type `string?`, which defaults to `null`): set file where to print metadata information
- `direct` (of type `bool?`, which defaults to `null`): reduce buffering when printing to user-set file or pipe. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.amix`

Ffmpeg filter: Audio mixing. This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime.

Type:
```
(?inputs : int?, ?duration : int?,
 ?dropout_transition : float?, ?weights : string?,
 ffmpeg.filter.graph, [ffmpeg.filter.audio],
 [ffmpeg.filter.video]) -> ffmpeg.filter.audio
```

Arguments:

- `inputs` (of type `int?`, which defaults to `null`): Number of inputs.. (default: 2)
- `duration` (of type `int?`, which defaults to `null`): How to determine the end-of-stream.. (default: 0, possible values: 0 (longest), 1 (shortest), 2 (first))
- `dropout_transition` (of type `float?`, which defaults to `null`): Transition time, in seconds, for volume renormalization when an input stream ends.. (default: 2.)
- `weights` (of type `string?`, which defaults to `null`): Set weight for each input.. (default: 1 1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.amovie`

Ffmpeg filter: Read audio from a movie source. This filter has dynamic outputs: returned value is a tuple of audio and video outputs. Total number of outputs is determined at runtime.

Type:
```
(?filename : string?, ?format_name : string?,
 ?f : string?, ?stream_index : int?, ?si : int?,
 ?seek_point : float?, ?sp : float?, ?streams : string?,
 ?s : string?, ?loop : int?, ?discontinuity : int?,
 ffmpeg.filter.graph) ->
[ffmpeg.filter.audio] * [ffmpeg.filter.video]
```

Arguments:

- `filename` (of type `string?`, which defaults to `null`)
- `format_name` (of type `string?`, which defaults to `null`): set format name
- `f` (of type `string?`, which defaults to `null`): set format name
- `stream_index` (of type `int?`, which defaults to `null`): set stream index. (default: -1)
- `si` (of type `int?`, which defaults to `null`): set stream index. (default: -1)
- `seek_point` (of type `float?`, which defaults to `null`): set seekpoint (seconds). (default: 0.)
- `sp` (of type `float?`, which defaults to `null`): set seekpoint (seconds). (default: 0.)
- `streams` (of type `string?`, which defaults to `null`): set streams
- `s` (of type `string?`, which defaults to `null`): set streams
- `loop` (of type `int?`, which defaults to `null`): set loop count. (default: 1)
- `discontinuity` (of type `int?`, which defaults to `null`): set discontinuity threshold. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.amplify`

Ffmpeg filter: Amplify changes between successive video frames.

Type:
```
(?radius : int?, ?factor : float?, ?threshold : float?,
 ?tolerance : float?, ?low : int?, ?high : int?,
 ?planes : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `radius` (of type `int?`, which defaults to `null`): set radius. (default: 2)
- `factor` (of type `float?`, which defaults to `null`): set factor. (default: 2.)
- `threshold` (of type `float?`, which defaults to `null`): set threshold. (default: 10.)
- `tolerance` (of type `float?`, which defaults to `null`): set tolerance. (default: 0.)
- `low` (of type `int?`, which defaults to `null`): set low limit for amplification. (default: 65535)
- `high` (of type `int?`, which defaults to `null`): set high limit for amplification. (default: 65535)
- `planes` (of type `int?`, which defaults to `null`): set what planes to filter. (default: 7)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.amultiply`

Ffmpeg filter: Multiply two audio streams.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.audio,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.anequalizer`

Ffmpeg filter: Apply high-order audio parametric multi band equalizer. This filter has dynamic outputs: returned value is a tuple of audio and video outputs. Total number of outputs is determined at runtime.

Type:
```
(?params : string?, ?curves : bool?, ?size : string?,
 ?mgain : float?, ?fscale : int?, ?colors : string?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
[ffmpeg.filter.audio] * [ffmpeg.filter.video]
```

Arguments:

- `params` (of type `string?`, which defaults to `null`): Default: 
- `curves` (of type `bool?`, which defaults to `null`): draw frequency response curves. (default: false)
- `size` (of type `string?`, which defaults to `null`): set video size. (default: hd720)
- `mgain` (of type `float?`, which defaults to `null`): set max gain. (default: 60.)
- `fscale` (of type `int?`, which defaults to `null`): set frequency scale. (default: 1, possible values: 0 (lin), 1 (log))
- `colors` (of type `string?`, which defaults to `null`): set channels curves colors. (default: red|green|blue|yellow|orange|lime|pink|magenta|brown)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.anlmdn`

Ffmpeg filter: Reduce broadband noise from stream using Non-Local Means.

Type:
```
(?s : float?, ?p : int?, ?r : int?, ?o : int?,
 ?m : float?, ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `s` (of type `float?`, which defaults to `null`): set denoising strength. (default: 1e-05)
- `p` (of type `int?`, which defaults to `null`): set patch duration. (default: 2000)
- `r` (of type `int?`, which defaults to `null`): set research duration. (default: 6000)
- `o` (of type `int?`, which defaults to `null`): set output mode. (default: 1, possible values: 0 (i), 1 (o), 2 (n))
- `m` (of type `float?`, which defaults to `null`): set smooth factor. (default: 11.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.anlms`

Ffmpeg filter: Apply Normalized Least-Mean-Squares algorithm to first audio stream.

Type:
```
(?order : int?, ?mu : float?, ?eps : float?,
 ?leakage : float?, ?out_mode : int?,
 ffmpeg.filter.graph, ffmpeg.filter.audio,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `order` (of type `int?`, which defaults to `null`): set the filter order. (default: 256)
- `mu` (of type `float?`, which defaults to `null`): set the filter mu. (default: 0.75)
- `eps` (of type `float?`, which defaults to `null`): set the filter eps. (default: 1.)
- `leakage` (of type `float?`, which defaults to `null`): set the filter leakage. (default: 0.)
- `out_mode` (of type `int?`, which defaults to `null`): set output mode. (default: 2, possible values: 0 (i), 1 (d), 2 (o), 3 (n))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.anoisesrc`

Ffmpeg filter: Generate a noise audio signal.

Type:
```
(?sample_rate : int?, ?r : int?, ?amplitude : float?,
 ?a : float?, ?duration : int?, ?d : int?, ?color : int?,
 ?colour : int?, ?c : int?, ?seed : int?, ?s : int?,
 ?nb_samples : int?, ?n : int?, ffmpeg.filter.graph) ->
ffmpeg.filter.audio
```

Arguments:

- `sample_rate` (of type `int?`, which defaults to `null`): set sample rate. (default: 48000)
- `r` (of type `int?`, which defaults to `null`): set sample rate. (default: 48000)
- `amplitude` (of type `float?`, which defaults to `null`): set amplitude. (default: 1.)
- `a` (of type `float?`, which defaults to `null`): set amplitude. (default: 1.)
- `duration` (of type `int?`, which defaults to `null`): set duration. (default: 0)
- `d` (of type `int?`, which defaults to `null`): set duration. (default: 0)
- `color` (of type `int?`, which defaults to `null`): set noise color. (default: 0, possible values: 0 (white), 1 (pink), 2 (brown), 3 (blue), 4 (violet), 5 (velvet))
- `colour` (of type `int?`, which defaults to `null`): set noise color. (default: 0, possible values: 0 (white), 1 (pink), 2 (brown), 3 (blue), 4 (violet), 5 (velvet))
- `c` (of type `int?`, which defaults to `null`): set noise color. (default: 0, possible values: 0 (white), 1 (pink), 2 (brown), 3 (blue), 4 (violet), 5 (velvet))
- `seed` (of type `int?`, which defaults to `null`): set random seed. (default: -1)
- `s` (of type `int?`, which defaults to `null`): set random seed. (default: -1)
- `nb_samples` (of type `int?`, which defaults to `null`): set the number of samples per requested frame. (default: 1024)
- `n` (of type `int?`, which defaults to `null`): set the number of samples per requested frame. (default: 1024)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.anull`

Ffmpeg filter: Pass the source unchanged to the output.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.anullsink`

Ffmpeg filter: Do absolutely nothing with the input audio.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.audio) -> unit
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.anullsrc`

Ffmpeg filter: Null audio source, return empty audio frames.

Type:
```
(?channel_layout : string?, ?cl : string?,
 ?sample_rate : string?, ?r : string?,
 ?nb_samples : int?, ?n : int?, ffmpeg.filter.graph) ->
ffmpeg.filter.audio
```

Arguments:

- `channel_layout` (of type `string?`, which defaults to `null`): set channel_layout. (default: stereo)
- `cl` (of type `string?`, which defaults to `null`): set channel_layout. (default: stereo)
- `sample_rate` (of type `string?`, which defaults to `null`): set sample rate. (default: 44100)
- `r` (of type `string?`, which defaults to `null`): set sample rate. (default: 44100)
- `nb_samples` (of type `int?`, which defaults to `null`): set the number of samples per requested frame. (default: 1024)
- `n` (of type `int?`, which defaults to `null`): set the number of samples per requested frame. (default: 1024)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.apad`

Ffmpeg filter: Pad audio with silence.

Type:
```
(?packet_size : int?, ?pad_len : int?, ?whole_len : int?,
 ?pad_dur : int?, ?whole_dur : int?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `packet_size` (of type `int?`, which defaults to `null`): set silence packet size. (default: 4096)
- `pad_len` (of type `int?`, which defaults to `null`): set number of samples of silence to add. (default: -1)
- `whole_len` (of type `int?`, which defaults to `null`): set minimum target number of samples in the audio stream. (default: -1)
- `pad_dur` (of type `int?`, which defaults to `null`): set duration of silence to add. (default: 0)
- `whole_dur` (of type `int?`, which defaults to `null`): set minimum target duration in the audio stream. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.aperms`

Ffmpeg filter: Set permissions for the output audio frame.

Type:
```
(?mode : int?, ?seed : int?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `mode` (of type `int?`, which defaults to `null`): select permissions mode. (default: 0, possible values: 0 (none), 1 (ro), 2 (rw), 3 (toggle), 4 (random))
- `seed` (of type `int?`, which defaults to `null`): set the seed for the random mode. (default: -1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.aphasemeter`

Ffmpeg filter: Convert input audio to phase meter video output. This filter has dynamic outputs: returned value is a tuple of audio and video outputs. Total number of outputs is determined at runtime.

Type:
```
(?rate : string?, ?r : string?, ?size : string?,
 ?s : string?, ?rc : int?, ?gc : int?, ?bc : int?,
 ?mpc : string?, ?video : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) ->
[ffmpeg.filter.audio] * [ffmpeg.filter.video]
```

Arguments:

- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `size` (of type `string?`, which defaults to `null`): set video size. (default: 800x400)
- `s` (of type `string?`, which defaults to `null`): set video size. (default: 800x400)
- `rc` (of type `int?`, which defaults to `null`): set red contrast. (default: 2)
- `gc` (of type `int?`, which defaults to `null`): set green contrast. (default: 7)
- `bc` (of type `int?`, which defaults to `null`): set blue contrast. (default: 1)
- `mpc` (of type `string?`, which defaults to `null`): set median phase color. (default: none)
- `video` (of type `bool?`, which defaults to `null`): set video output. (default: true)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.aphaser`

Ffmpeg filter: Add a phasing effect to the audio.

Type:
```
(?in_gain : float?, ?out_gain : float?, ?delay : float?,
 ?decay : float?, ?speed : float?, ?type : int?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `in_gain` (of type `float?`, which defaults to `null`): set input gain. (default: 0.4)
- `out_gain` (of type `float?`, which defaults to `null`): set output gain. (default: 0.74)
- `delay` (of type `float?`, which defaults to `null`): set delay in milliseconds. (default: 3.)
- `decay` (of type `float?`, which defaults to `null`): set decay. (default: 0.4)
- `speed` (of type `float?`, which defaults to `null`): set modulation speed. (default: 0.5)
- `type` (of type `int?`, which defaults to `null`): set modulation type. (default: 1, possible values: 1 (triangular), 1 (t), 0 (sinusoidal), 0 (s))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.apulsator`

Ffmpeg filter: Audio pulsator.

Type:
```
(?level_in : float?, ?level_out : float?, ?mode : int?,
 ?amount : float?, ?offset_l : float?,
 ?offset_r : float?, ?width : float?, ?timing : int?,
 ?bpm : float?, ?ms : int?, ?hz : float?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `level_in` (of type `float?`, which defaults to `null`): set input gain. (default: 1.)
- `level_out` (of type `float?`, which defaults to `null`): set output gain. (default: 1.)
- `mode` (of type `int?`, which defaults to `null`): set mode. (default: 0, possible values: 0 (sine), 1 (triangle), 2 (square), 3 (sawup), 4 (sawdown))
- `amount` (of type `float?`, which defaults to `null`): set modulation. (default: 1.)
- `offset_l` (of type `float?`, which defaults to `null`): set offset L. (default: 0.)
- `offset_r` (of type `float?`, which defaults to `null`): set offset R. (default: 0.5)
- `width` (of type `float?`, which defaults to `null`): set pulse width. (default: 1.)
- `timing` (of type `int?`, which defaults to `null`): set timing. (default: 2, possible values: 0 (bpm), 1 (ms), 2 (hz))
- `bpm` (of type `float?`, which defaults to `null`): set BPM. (default: 120.)
- `ms` (of type `int?`, which defaults to `null`): set ms. (default: 500)
- `hz` (of type `float?`, which defaults to `null`): set frequency. (default: 2.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.arealtime`

Ffmpeg filter: Slow down filtering to match realtime.

Type:
```
(?limit : int?, ?speed : float?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `limit` (of type `int?`, which defaults to `null`): sleep time limit. (default: 2000000)
- `speed` (of type `float?`, which defaults to `null`): speed factor. (default: 1.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.aresample`

Ffmpeg filter: Resample audio data.

Type:
```
(?sample_rate : int?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `sample_rate` (of type `int?`, which defaults to `null`): Default: 0
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.areverse`

Ffmpeg filter: Reverse an audio clip.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.arnndn`

Ffmpeg filter: Reduce noise from speech using Recurrent Neural Networks.

Type:
```
(?model : string?, ?m : string?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `model` (of type `string?`, which defaults to `null`): set model name
- `m` (of type `string?`, which defaults to `null`): set model name
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.aselect`

Ffmpeg filter: Select audio frames to pass in output. This filter has dynamic outputs: returned value is a tuple of audio and video outputs. Total number of outputs is determined at runtime.

Type:
```
(?expr : string?, ?e : string?, ?outputs : int?,
 ?n : int?, ffmpeg.filter.graph, ffmpeg.filter.audio) ->
[ffmpeg.filter.audio] * [ffmpeg.filter.video]
```

Arguments:

- `expr` (of type `string?`, which defaults to `null`): set an expression to use for selecting frames. (default: 1)
- `e` (of type `string?`, which defaults to `null`): set an expression to use for selecting frames. (default: 1)
- `outputs` (of type `int?`, which defaults to `null`): set the number of outputs. (default: 1)
- `n` (of type `int?`, which defaults to `null`): set the number of outputs. (default: 1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.asendcmd`

Ffmpeg filter: Send commands to filters.

Type:
```
(?commands : string?, ?c : string?, ?filename : string?,
 ?f : string?, ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `commands` (of type `string?`, which defaults to `null`): set commands
- `c` (of type `string?`, which defaults to `null`): set commands
- `filename` (of type `string?`, which defaults to `null`): set commands file
- `f` (of type `string?`, which defaults to `null`): set commands file
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.asetnsamples`

Ffmpeg filter: Set the number of samples for each output audio frames.

Type:
```
(?nb_out_samples : int?, ?n : int?, ?pad : bool?,
 ?p : bool?, ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `nb_out_samples` (of type `int?`, which defaults to `null`): set the number of per-frame output samples. (default: 1024)
- `n` (of type `int?`, which defaults to `null`): set the number of per-frame output samples. (default: 1024)
- `pad` (of type `bool?`, which defaults to `null`): pad last frame with zeros. (default: true)
- `p` (of type `bool?`, which defaults to `null`): pad last frame with zeros. (default: true)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.asetpts`

Ffmpeg filter: Set PTS for the output audio frame.

Type:
```
(?expr : string?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `expr` (of type `string?`, which defaults to `null`): Expression determining the frame timestamp. (default: PTS)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.asetrate`

Ffmpeg filter: Change the sample rate without altering the data.

Type:
```
(?sample_rate : int?, ?r : int?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `sample_rate` (of type `int?`, which defaults to `null`): set the sample rate. (default: 44100)
- `r` (of type `int?`, which defaults to `null`): set the sample rate. (default: 44100)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.asettb`

Ffmpeg filter: Set timebase for the audio output link.

Type:
```
(?expr : string?, ?tb : string?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `expr` (of type `string?`, which defaults to `null`): set expression determining the output timebase. (default: intb)
- `tb` (of type `string?`, which defaults to `null`): set expression determining the output timebase. (default: intb)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.ashowinfo`

Ffmpeg filter: Show textual information for each audio frame.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.asidedata`

Ffmpeg filter: Manipulate audio frame side data.

Type:
```
(?mode : int?, ?type : int?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `mode` (of type `int?`, which defaults to `null`): set a mode of operation. (default: 0, possible values: 0 (select), 1 (delete))
- `type` (of type `int?`, which defaults to `null`): set side data type. (default: -1, possible values: 0 (PANSCAN), 1 (A53_CC), 2 (STEREO3D), 3 (MATRIXENCODING), 4 (DOWNMIX_INFO), 5 (REPLAYGAIN), 6 (DISPLAYMATRIX), 7 (AFD), 8 (MOTION_VECTORS), 9 (SKIP_SAMPLES), 10 (AUDIO_SERVICE_TYPE), 11 (MASTERING_DISPLAY_METADATA), 12 (GOP_TIMECODE), 13 (SPHERICAL), 14 (CONTENT_LIGHT_LEVEL), 15 (ICC_PROFILE), 16 (QP_TABLE_PROPERTIES), 17 (QP_TABLE_DATA), 18 (S12M_TIMECOD), 19 (DYNAMIC_HDR_PLUS), 20 (REGIONS_OF_INTEREST))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.asoftclip`

Ffmpeg filter: Audio Soft Clipper.

Type:
```
(?type : int?, ?param : float?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `type` (of type `int?`, which defaults to `null`): set softclip type. (default: 0, possible values: 0 (tanh), 1 (atan), 2 (cubic), 3 (exp), 4 (alg), 5 (quintic), 6 (sin))
- `param` (of type `float?`, which defaults to `null`): set softclip parameter. (default: 1.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.asplit`

Ffmpeg filter: Pass on the audio input to N audio outputs. This filter has dynamic outputs: returned value is a tuple of audio and video outputs. Total number of outputs is determined at runtime.

Type:
```
(?outputs : int?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) ->
[ffmpeg.filter.audio] * [ffmpeg.filter.video]
```

Arguments:

- `outputs` (of type `int?`, which defaults to `null`): set number of outputs. (default: 2)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.asr`

Ffmpeg filter: Automatic Speech Recognition.

Type:
```
(?rate : int?, ?hmm : string?, ?dict : string?,
 ?lm : string?, ?lmctl : string?, ?lmname : string?,
 ?logfn : string?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `rate` (of type `int?`, which defaults to `null`): set sampling rate. (default: 16000)
- `hmm` (of type `string?`, which defaults to `null`): set directory containing acoustic model files
- `dict` (of type `string?`, which defaults to `null`): set pronunciation dictionary
- `lm` (of type `string?`, which defaults to `null`): set language model file
- `lmctl` (of type `string?`, which defaults to `null`): set language model set
- `lmname` (of type `string?`, which defaults to `null`): set which language model to use
- `logfn` (of type `string?`, which defaults to `null`): set output for log messages. (default: /dev/null)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.ass`

Ffmpeg filter: Render ASS subtitles onto input video using the libass library.

Type:
```
(?filename : string?, ?f : string?,
 ?original_size : string?, ?fontsdir : string?,
 ?alpha : bool?, ?shaping : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `filename` (of type `string?`, which defaults to `null`): set the filename of file to read
- `f` (of type `string?`, which defaults to `null`): set the filename of file to read
- `original_size` (of type `string?`, which defaults to `null`): set the size of the original video (used to scale fonts)
- `fontsdir` (of type `string?`, which defaults to `null`): set the directory containing the fonts to read
- `alpha` (of type `bool?`, which defaults to `null`): enable processing of alpha channel. (default: false)
- `shaping` (of type `int?`, which defaults to `null`): set shaping engine. (default: -1, possible values: -1 (auto), 0 (simple), 1 (complex))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.astats`

Ffmpeg filter: Show time domain statistics about audio frames.

Type:
```
(?length : float?, ?metadata : bool?, ?reset : int?,
 ?measure_perchannel : int?, ?measure_overall : int?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `length` (of type `float?`, which defaults to `null`): set the window length. (default: 0.05)
- `metadata` (of type `bool?`, which defaults to `null`): inject metadata in the filtergraph. (default: false)
- `reset` (of type `int?`, which defaults to `null`): recalculate stats after this many frames. (default: 0)
- `measure_perchannel` (of type `int?`, which defaults to `null`): only measure_perchannel these per-channel statistics. (default: 4294967295, possible values: 0 (none), 4294967295 (all), 1 (DC_offset), 2 (Min_level), 4 (Max_level), 8 (Min_difference), 16 (Max_difference), 32 (Mean_difference), 64 (RMS_difference), 128 (Peak_level), 256 (RMS_level), 512 (RMS_peak), 1024 (RMS_trough), 2048 (Crest_factor), 4096 (Flat_factor), 8192 (Peak_count), 16384 (Bit_depth), 32768 (Dynamic_range), 65536 (Zero_crossings), 131072 (Zero_crossings_rate), 4194304 (Noise_floor), 8388608 (Noise_floor_count), 262144 (Number_of_samples), 524288 (Number_of_NaNs), 1048576 (Number_of_Infs), 2097152 (Number_of_denormals))
- `measure_overall` (of type `int?`, which defaults to `null`): only measure_perchannel these overall statistics. (default: 4294967295, possible values: 0 (none), 4294967295 (all), 1 (DC_offset), 2 (Min_level), 4 (Max_level), 8 (Min_difference), 16 (Max_difference), 32 (Mean_difference), 64 (RMS_difference), 128 (Peak_level), 256 (RMS_level), 512 (RMS_peak), 1024 (RMS_trough), 2048 (Crest_factor), 4096 (Flat_factor), 8192 (Peak_count), 16384 (Bit_depth), 32768 (Dynamic_range), 65536 (Zero_crossings), 131072 (Zero_crossings_rate), 4194304 (Noise_floor), 8388608 (Noise_floor_count), 262144 (Number_of_samples), 524288 (Number_of_NaNs), 1048576 (Number_of_Infs), 2097152 (Number_of_denormals))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.astreamselect`

Ffmpeg filter: Select audio streams This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime. This filter has dynamic outputs: returned value is a tuple of audio and video outputs. Total number of outputs is determined at runtime.

Type:
```
(?inputs : int?, ?map : string?, ffmpeg.filter.graph,
 [ffmpeg.filter.audio], [ffmpeg.filter.video]) ->
[ffmpeg.filter.audio] * [ffmpeg.filter.video]
```

Arguments:

- `inputs` (of type `int?`, which defaults to `null`): number of input streams. (default: 2)
- `map` (of type `string?`, which defaults to `null`): input indexes to remap to outputs
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.asubboost`

Ffmpeg filter: Boost subwoofer frequencies.

Type:
```
(?dry : float?, ?wet : float?, ?decay : float?,
 ?feedback : float?, ?cutoff : float?, ?slope : float?,
 ?delay : float?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `dry` (of type `float?`, which defaults to `null`): set dry gain. (default: 0.5)
- `wet` (of type `float?`, which defaults to `null`): set wet gain. (default: 0.8)
- `decay` (of type `float?`, which defaults to `null`): set decay. (default: 0.7)
- `feedback` (of type `float?`, which defaults to `null`): set feedback. (default: 0.5)
- `cutoff` (of type `float?`, which defaults to `null`): set cutoff. (default: 100.)
- `slope` (of type `float?`, which defaults to `null`): set slope. (default: 0.5)
- `delay` (of type `float?`, which defaults to `null`): set delay. (default: 20.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.atadenoise`

Ffmpeg filter: Apply an Adaptive Temporal Averaging Denoiser.

Type:
```
(?0a : float?, ?0b : float?, ?1a : float?, ?1b : float?,
 ?2a : float?, ?2b : float?, ?s : int?, ?p : int?,
 ?a : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `0a` (of type `float?`, which defaults to `null`): set threshold A for 1st plane. (default: 0.02)
- `0b` (of type `float?`, which defaults to `null`): set threshold B for 1st plane. (default: 0.04)
- `1a` (of type `float?`, which defaults to `null`): set threshold A for 2nd plane. (default: 0.02)
- `1b` (of type `float?`, which defaults to `null`): set threshold B for 2nd plane. (default: 0.04)
- `2a` (of type `float?`, which defaults to `null`): set threshold A for 3rd plane. (default: 0.02)
- `2b` (of type `float?`, which defaults to `null`): set threshold B for 3rd plane. (default: 0.04)
- `s` (of type `int?`, which defaults to `null`): set how many frames to use. (default: 9)
- `p` (of type `int?`, which defaults to `null`): set what planes to filter. (default: 7)
- `a` (of type `int?`, which defaults to `null`): set variant of algorithm. (default: 0, possible values: 0 (p), 1 (s))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.atempo`

Ffmpeg filter: Adjust audio tempo.

Type:
```
(?tempo : float?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `tempo` (of type `float?`, which defaults to `null`): set tempo scale factor. (default: 1.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.atrim`

Ffmpeg filter: Pick one continuous section from the input, drop the rest.

Type:
```
(?start : int?, ?starti : int?, ?end : int?,
 ?endi : int?, ?start_pts : int?, ?end_pts : int?,
 ?duration : int?, ?durationi : int?,
 ?start_sample : int?, ?end_sample : int?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `start` (of type `int?`, which defaults to `null`): Timestamp of the first frame that should be passed. (default: 9223372036854775807)
- `starti` (of type `int?`, which defaults to `null`): Timestamp of the first frame that should be passed. (default: 9223372036854775807)
- `end` (of type `int?`, which defaults to `null`): Timestamp of the first frame that should be dropped again. (default: 9223372036854775807)
- `endi` (of type `int?`, which defaults to `null`): Timestamp of the first frame that should be dropped again. (default: 9223372036854775807)
- `start_pts` (of type `int?`, which defaults to `null`): Timestamp of the first frame that should be  passed. (default: -9223372036854775808)
- `end_pts` (of type `int?`, which defaults to `null`): Timestamp of the first frame that should be dropped again. (default: -9223372036854775808)
- `duration` (of type `int?`, which defaults to `null`): Maximum duration of the output. (default: 0)
- `durationi` (of type `int?`, which defaults to `null`): Maximum duration of the output. (default: 0)
- `start_sample` (of type `int?`, which defaults to `null`): Number of the first audio sample that should be passed to the output. (default: -1)
- `end_sample` (of type `int?`, which defaults to `null`): Number of the first audio sample that should be dropped again. (default: 9223372036854775807)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.avectorscope`

Ffmpeg filter: Convert input audio to vectorscope video output.

Type:
```
(?mode : int?, ?m : int?, ?rate : string?, ?r : string?,
 ?size : string?, ?s : string?, ?rc : int?, ?gc : int?,
 ?bc : int?, ?ac : int?, ?rf : int?, ?gf : int?,
 ?bf : int?, ?af : int?, ?zoom : float?, ?draw : int?,
 ?scale : int?, ?swap : bool?, ?mirror : int?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.video
```

Arguments:

- `mode` (of type `int?`, which defaults to `null`): set mode. (default: 0, possible values: 0 (lissajous), 1 (lissajous_xy), 2 (polar))
- `m` (of type `int?`, which defaults to `null`): set mode. (default: 0, possible values: 0 (lissajous), 1 (lissajous_xy), 2 (polar))
- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `size` (of type `string?`, which defaults to `null`): set video size. (default: 400x400)
- `s` (of type `string?`, which defaults to `null`): set video size. (default: 400x400)
- `rc` (of type `int?`, which defaults to `null`): set red contrast. (default: 40)
- `gc` (of type `int?`, which defaults to `null`): set green contrast. (default: 160)
- `bc` (of type `int?`, which defaults to `null`): set blue contrast. (default: 80)
- `ac` (of type `int?`, which defaults to `null`): set alpha contrast. (default: 255)
- `rf` (of type `int?`, which defaults to `null`): set red fade. (default: 15)
- `gf` (of type `int?`, which defaults to `null`): set green fade. (default: 10)
- `bf` (of type `int?`, which defaults to `null`): set blue fade. (default: 5)
- `af` (of type `int?`, which defaults to `null`): set alpha fade. (default: 5)
- `zoom` (of type `float?`, which defaults to `null`): set zoom factor. (default: 1.)
- `draw` (of type `int?`, which defaults to `null`): set draw mode. (default: 0, possible values: 0 (dot), 1 (line))
- `scale` (of type `int?`, which defaults to `null`): set amplitude scale mode. (default: 0, possible values: 0 (lin), 1 (sqrt), 2 (cbrt), 3 (log))
- `swap` (of type `bool?`, which defaults to `null`): swap x axis with y axis. (default: true)
- `mirror` (of type `int?`, which defaults to `null`): mirror axis. (default: 0, possible values: 0 (none), 1 (x), 2 (y), 3 (xy))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.avgblur`

Ffmpeg filter: Apply Average Blur filter.

Type:
```
(?sizeX : int?, ?planes : int?, ?sizeY : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `sizeX` (of type `int?`, which defaults to `null`): set horizontal size. (default: 1)
- `planes` (of type `int?`, which defaults to `null`): set planes to filter. (default: 15)
- `sizeY` (of type `int?`, which defaults to `null`): set vertical size. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.avgblur_opencl`

Ffmpeg filter: Apply average blur filter

Type:
```
(?sizeX : int?, ?planes : int?, ?sizeY : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `sizeX` (of type `int?`, which defaults to `null`): set horizontal size. (default: 1)
- `planes` (of type `int?`, which defaults to `null`): set planes to filter. (default: 15)
- `sizeY` (of type `int?`, which defaults to `null`): set vertical size. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.axcorrelate`

Ffmpeg filter: Cross-correlate two audio streams.

Type:
```
(?size : int?, ?algo : int?, ffmpeg.filter.graph,
 ffmpeg.filter.audio, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `size` (of type `int?`, which defaults to `null`): set segment size. (default: 256)
- `algo` (of type `int?`, which defaults to `null`): set alghorithm. (default: 0, possible values: 0 (slow), 1 (fast))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.azmq`

Ffmpeg filter: Receive commands through ZMQ and broker them to filters.

Type:
```
(?bind_address : string?, ?b : string?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `bind_address` (of type `string?`, which defaults to `null`): set bind address. (default: tcp://*:5555)
- `b` (of type `string?`, which defaults to `null`): set bind address. (default: tcp://*:5555)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.bandpass`

Ffmpeg filter: Apply a two-pole Butterworth band-pass filter.

Type:
```
(?frequency : float?, ?f : float?, ?width_type : int?,
 ?t : int?, ?width : float?, ?w : float?, ?csg : bool?,
 ?mix : float?, ?m : float?, ?channels : string?,
 ?c : string?, ?normalize : bool?, ?n : bool?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `frequency` (of type `float?`, which defaults to `null`): set central frequency. (default: 3000.)
- `f` (of type `float?`, which defaults to `null`): set central frequency. (default: 3000.)
- `width_type` (of type `int?`, which defaults to `null`): set filter-width type. (default: 3, possible values: 1 (h), 3 (q), 2 (o), 4 (s), 5 (k))
- `t` (of type `int?`, which defaults to `null`): set filter-width type. (default: 3, possible values: 1 (h), 3 (q), 2 (o), 4 (s), 5 (k))
- `width` (of type `float?`, which defaults to `null`): set band-width. (default: 0.5)
- `w` (of type `float?`, which defaults to `null`): set band-width. (default: 0.5)
- `csg` (of type `bool?`, which defaults to `null`): use constant skirt gain. (default: false)
- `mix` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `m` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `channels` (of type `string?`, which defaults to `null`): set channels to filter
- `c` (of type `string?`, which defaults to `null`): set channels to filter
- `normalize` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: false)
- `n` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.bandreject`

Ffmpeg filter: Apply a two-pole Butterworth band-reject filter.

Type:
```
(?frequency : float?, ?f : float?, ?width_type : int?,
 ?t : int?, ?width : float?, ?w : float?, ?mix : float?,
 ?m : float?, ?channels : string?, ?c : string?,
 ?normalize : bool?, ?n : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `frequency` (of type `float?`, which defaults to `null`): set central frequency. (default: 3000.)
- `f` (of type `float?`, which defaults to `null`): set central frequency. (default: 3000.)
- `width_type` (of type `int?`, which defaults to `null`): set filter-width type. (default: 3, possible values: 1 (h), 3 (q), 2 (o), 4 (s), 5 (k))
- `t` (of type `int?`, which defaults to `null`): set filter-width type. (default: 3, possible values: 1 (h), 3 (q), 2 (o), 4 (s), 5 (k))
- `width` (of type `float?`, which defaults to `null`): set band-width. (default: 0.5)
- `w` (of type `float?`, which defaults to `null`): set band-width. (default: 0.5)
- `mix` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `m` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `channels` (of type `string?`, which defaults to `null`): set channels to filter
- `c` (of type `string?`, which defaults to `null`): set channels to filter
- `normalize` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: false)
- `n` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.bass`

Ffmpeg filter: Boost or cut lower frequencies.

Type:
```
(?frequency : float?, ?f : float?, ?width_type : int?,
 ?t : int?, ?width : float?, ?w : float?, ?gain : float?,
 ?g : float?, ?mix : float?, ?m : float?,
 ?channels : string?, ?c : string?, ?normalize : bool?,
 ?n : bool?, ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `frequency` (of type `float?`, which defaults to `null`): set central frequency. (default: 100.)
- `f` (of type `float?`, which defaults to `null`): set central frequency. (default: 100.)
- `width_type` (of type `int?`, which defaults to `null`): set filter-width type. (default: 3, possible values: 1 (h), 3 (q), 2 (o), 4 (s), 5 (k))
- `t` (of type `int?`, which defaults to `null`): set filter-width type. (default: 3, possible values: 1 (h), 3 (q), 2 (o), 4 (s), 5 (k))
- `width` (of type `float?`, which defaults to `null`): set shelf transition steep. (default: 0.5)
- `w` (of type `float?`, which defaults to `null`): set shelf transition steep. (default: 0.5)
- `gain` (of type `float?`, which defaults to `null`): set gain. (default: 0.)
- `g` (of type `float?`, which defaults to `null`): set gain. (default: 0.)
- `mix` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `m` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `channels` (of type `string?`, which defaults to `null`): set channels to filter
- `c` (of type `string?`, which defaults to `null`): set channels to filter
- `normalize` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: false)
- `n` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.bbox`

Ffmpeg filter: Compute bounding box for each frame.

Type:
```
(?min_val : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `min_val` (of type `int?`, which defaults to `null`): set minimum luminance value for bounding box. (default: 16)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.bench`

Ffmpeg filter: Benchmark part of a filtergraph.

Type:
```
(?action : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `action` (of type `int?`, which defaults to `null`): set action. (default: 0, possible values: 0 (start), 1 (stop))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.bilateral`

Ffmpeg filter: Apply Bilateral filter.

Type:
```
(?sigmaS : float?, ?sigmaR : float?, ?planes : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `sigmaS` (of type `float?`, which defaults to `null`): set spatial sigma. (default: 0.1)
- `sigmaR` (of type `float?`, which defaults to `null`): set range sigma. (default: 0.1)
- `planes` (of type `int?`, which defaults to `null`): set planes to filter. (default: 1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.biquad`

Ffmpeg filter: Apply a biquad IIR filter with the given coefficients.

Type:
```
(?a0 : float?, ?a1 : float?, ?a2 : float?, ?b0 : float?,
 ?b1 : float?, ?b2 : float?, ?mix : float?, ?m : float?,
 ?channels : string?, ?c : string?, ?normalize : bool?,
 ?n : bool?, ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `a0` (of type `float?`, which defaults to `null`): Default: 1.
- `a1` (of type `float?`, which defaults to `null`): Default: 0.
- `a2` (of type `float?`, which defaults to `null`): Default: 0.
- `b0` (of type `float?`, which defaults to `null`): Default: 0.
- `b1` (of type `float?`, which defaults to `null`): Default: 0.
- `b2` (of type `float?`, which defaults to `null`): Default: 0.
- `mix` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `m` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `channels` (of type `string?`, which defaults to `null`): set channels to filter
- `c` (of type `string?`, which defaults to `null`): set channels to filter
- `normalize` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: false)
- `n` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.bitplanenoise`

Ffmpeg filter: Measure bit plane noise.

Type:
```
(?bitplane : int?, ?filter : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `bitplane` (of type `int?`, which defaults to `null`): set bit plane to use for measuring noise. (default: 1)
- `filter` (of type `bool?`, which defaults to `null`): show noisy pixels. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.blackdetect`

Ffmpeg filter: Detect video intervals that are (almost) black.

Type:
```
(?d : float?, ?black_min_duration : float?,
 ?picture_black_ratio_th : float?, ?pic_th : float?,
 ?pixel_black_th : float?, ?pix_th : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `d` (of type `float?`, which defaults to `null`): set minimum detected black duration in seconds. (default: 2.)
- `black_min_duration` (of type `float?`, which defaults to `null`): set minimum detected black duration in seconds. (default: 2.)
- `picture_black_ratio_th` (of type `float?`, which defaults to `null`): set the picture black ratio threshold. (default: 0.98)
- `pic_th` (of type `float?`, which defaults to `null`): set the picture black ratio threshold. (default: 0.98)
- `pixel_black_th` (of type `float?`, which defaults to `null`): set the pixel black threshold. (default: 0.1)
- `pix_th` (of type `float?`, which defaults to `null`): set the pixel black threshold. (default: 0.1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.blackframe`

Ffmpeg filter: Detect frames that are (almost) black.

Type:
```
(?amount : int?, ?threshold : int?, ?thresh : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `amount` (of type `int?`, which defaults to `null`): percentage of the pixels that have to be below the threshold for the frame to be considered black. (default: 98)
- `threshold` (of type `int?`, which defaults to `null`): threshold below which a pixel value is considered black. (default: 32)
- `thresh` (of type `int?`, which defaults to `null`): threshold below which a pixel value is considered black. (default: 32)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.blend`

Ffmpeg filter: Blend two video frames into each other.

Type:
```
(?c0_mode : int?, ?c1_mode : int?, ?c2_mode : int?,
 ?c3_mode : int?, ?all_mode : int?, ?c0_expr : string?,
 ?c1_expr : string?, ?c2_expr : string?,
 ?c3_expr : string?, ?all_expr : string?,
 ?c0_opacity : float?, ?c1_opacity : float?,
 ?c2_opacity : float?, ?c3_opacity : float?,
 ?all_opacity : float?, ffmpeg.filter.graph,
 ffmpeg.filter.video, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `c0_mode` (of type `int?`, which defaults to `null`): set component #0 blend mode. (default: 0, possible values: 1 (addition), 28 (addition128), 28 (grainmerge), 2 (and), 3 (average), 4 (burn), 5 (darken), 6 (difference), 7 (difference128), 7 (grainextract), 8 (divide), 9 (dodge), 10 (exclusion), 32 (extremity), 31 (freeze), 27 (glow), 11 (hardlight), 25 (hardmix), 30 (heat), 12 (lighten), 26 (linearlight), 13 (multiply), 29 (multiply128), 14 (negation), 0 (normal), 15 (or), 16 (overlay), 17 (phoenix), 18 (pinlight), 19 (reflect), 20 (screen), 21 (softlight), 22 (subtract), 23 (vividlight), 24 (xor))
- `c1_mode` (of type `int?`, which defaults to `null`): set component #1 blend mode. (default: 0, possible values: 1 (addition), 28 (addition128), 28 (grainmerge), 2 (and), 3 (average), 4 (burn), 5 (darken), 6 (difference), 7 (difference128), 7 (grainextract), 8 (divide), 9 (dodge), 10 (exclusion), 32 (extremity), 31 (freeze), 27 (glow), 11 (hardlight), 25 (hardmix), 30 (heat), 12 (lighten), 26 (linearlight), 13 (multiply), 29 (multiply128), 14 (negation), 0 (normal), 15 (or), 16 (overlay), 17 (phoenix), 18 (pinlight), 19 (reflect), 20 (screen), 21 (softlight), 22 (subtract), 23 (vividlight), 24 (xor))
- `c2_mode` (of type `int?`, which defaults to `null`): set component #2 blend mode. (default: 0, possible values: 1 (addition), 28 (addition128), 28 (grainmerge), 2 (and), 3 (average), 4 (burn), 5 (darken), 6 (difference), 7 (difference128), 7 (grainextract), 8 (divide), 9 (dodge), 10 (exclusion), 32 (extremity), 31 (freeze), 27 (glow), 11 (hardlight), 25 (hardmix), 30 (heat), 12 (lighten), 26 (linearlight), 13 (multiply), 29 (multiply128), 14 (negation), 0 (normal), 15 (or), 16 (overlay), 17 (phoenix), 18 (pinlight), 19 (reflect), 20 (screen), 21 (softlight), 22 (subtract), 23 (vividlight), 24 (xor))
- `c3_mode` (of type `int?`, which defaults to `null`): set component #3 blend mode. (default: 0, possible values: 1 (addition), 28 (addition128), 28 (grainmerge), 2 (and), 3 (average), 4 (burn), 5 (darken), 6 (difference), 7 (difference128), 7 (grainextract), 8 (divide), 9 (dodge), 10 (exclusion), 32 (extremity), 31 (freeze), 27 (glow), 11 (hardlight), 25 (hardmix), 30 (heat), 12 (lighten), 26 (linearlight), 13 (multiply), 29 (multiply128), 14 (negation), 0 (normal), 15 (or), 16 (overlay), 17 (phoenix), 18 (pinlight), 19 (reflect), 20 (screen), 21 (softlight), 22 (subtract), 23 (vividlight), 24 (xor))
- `all_mode` (of type `int?`, which defaults to `null`): set blend mode for all components. (default: -1, possible values: 1 (addition), 28 (addition128), 28 (grainmerge), 2 (and), 3 (average), 4 (burn), 5 (darken), 6 (difference), 7 (difference128), 7 (grainextract), 8 (divide), 9 (dodge), 10 (exclusion), 32 (extremity), 31 (freeze), 27 (glow), 11 (hardlight), 25 (hardmix), 30 (heat), 12 (lighten), 26 (linearlight), 13 (multiply), 29 (multiply128), 14 (negation), 0 (normal), 15 (or), 16 (overlay), 17 (phoenix), 18 (pinlight), 19 (reflect), 20 (screen), 21 (softlight), 22 (subtract), 23 (vividlight), 24 (xor))
- `c0_expr` (of type `string?`, which defaults to `null`): set color component #0 expression
- `c1_expr` (of type `string?`, which defaults to `null`): set color component #1 expression
- `c2_expr` (of type `string?`, which defaults to `null`): set color component #2 expression
- `c3_expr` (of type `string?`, which defaults to `null`): set color component #3 expression
- `all_expr` (of type `string?`, which defaults to `null`): set expression for all color components
- `c0_opacity` (of type `float?`, which defaults to `null`): set color component #0 opacity. (default: 1.)
- `c1_opacity` (of type `float?`, which defaults to `null`): set color component #1 opacity. (default: 1.)
- `c2_opacity` (of type `float?`, which defaults to `null`): set color component #2 opacity. (default: 1.)
- `c3_opacity` (of type `float?`, which defaults to `null`): set color component #3 opacity. (default: 1.)
- `all_opacity` (of type `float?`, which defaults to `null`): set opacity for all color components. (default: 1.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.bm3d`

Ffmpeg filter: Block-Matching 3D denoiser. This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime.

Type:
```
(?sigma : float?, ?block : int?, ?bstep : int?,
 ?group : int?, ?range : int?, ?mstep : int?,
 ?thmse : float?, ?hdthr : float?, ?estim : int?,
 ?ref : bool?, ?planes : int?, ffmpeg.filter.graph,
 [ffmpeg.filter.audio], [ffmpeg.filter.video]) ->
ffmpeg.filter.video
```

Arguments:

- `sigma` (of type `float?`, which defaults to `null`): set denoising strength. (default: 1.)
- `block` (of type `int?`, which defaults to `null`): set log2(size) of local patch. (default: 4)
- `bstep` (of type `int?`, which defaults to `null`): set sliding step for processing blocks. (default: 4)
- `group` (of type `int?`, which defaults to `null`): set maximal number of similar blocks. (default: 1)
- `range` (of type `int?`, which defaults to `null`): set block matching range. (default: 9)
- `mstep` (of type `int?`, which defaults to `null`): set step for block matching. (default: 1)
- `thmse` (of type `float?`, which defaults to `null`): set threshold of mean square error for block matching. (default: 0.)
- `hdthr` (of type `float?`, which defaults to `null`): set hard threshold for 3D transfer domain. (default: 2.7)
- `estim` (of type `int?`, which defaults to `null`): set filtering estimation mode. (default: 0, possible values: 0 (basic), 1 (final))
- `ref` (of type `bool?`, which defaults to `null`): have reference stream. (default: false)
- `planes` (of type `int?`, which defaults to `null`): set planes to filter. (default: 7)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.boxblur`

Ffmpeg filter: Blur the input.

Type:
```
(?luma_radius : string?, ?lr : string?,
 ?luma_power : int?, ?lp : int?,
 ?chroma_radius : string?, ?cr : string?,
 ?chroma_power : int?, ?cp : int?,
 ?alpha_radius : string?, ?ar : string?,
 ?alpha_power : int?, ?ap : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `luma_radius` (of type `string?`, which defaults to `null`): Radius of the luma blurring box. (default: 2)
- `lr` (of type `string?`, which defaults to `null`): Radius of the luma blurring box. (default: 2)
- `luma_power` (of type `int?`, which defaults to `null`): How many times should the boxblur be applied to luma. (default: 2)
- `lp` (of type `int?`, which defaults to `null`): How many times should the boxblur be applied to luma. (default: 2)
- `chroma_radius` (of type `string?`, which defaults to `null`): Radius of the chroma blurring box
- `cr` (of type `string?`, which defaults to `null`): Radius of the chroma blurring box
- `chroma_power` (of type `int?`, which defaults to `null`): How many times should the boxblur be applied to chroma. (default: -1)
- `cp` (of type `int?`, which defaults to `null`): How many times should the boxblur be applied to chroma. (default: -1)
- `alpha_radius` (of type `string?`, which defaults to `null`): Radius of the alpha blurring box
- `ar` (of type `string?`, which defaults to `null`): Radius of the alpha blurring box
- `alpha_power` (of type `int?`, which defaults to `null`): How many times should the boxblur be applied to alpha. (default: -1)
- `ap` (of type `int?`, which defaults to `null`): How many times should the boxblur be applied to alpha. (default: -1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.boxblur_opencl`

Ffmpeg filter: Apply boxblur filter to input video

Type:
```
(?luma_radius : string?, ?lr : string?,
 ?luma_power : int?, ?lp : int?,
 ?chroma_radius : string?, ?cr : string?,
 ?chroma_power : int?, ?cp : int?,
 ?alpha_radius : string?, ?ar : string?,
 ?alpha_power : int?, ?ap : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `luma_radius` (of type `string?`, which defaults to `null`): Radius of the luma blurring box. (default: 2)
- `lr` (of type `string?`, which defaults to `null`): Radius of the luma blurring box. (default: 2)
- `luma_power` (of type `int?`, which defaults to `null`): How many times should the boxblur be applied to luma. (default: 2)
- `lp` (of type `int?`, which defaults to `null`): How many times should the boxblur be applied to luma. (default: 2)
- `chroma_radius` (of type `string?`, which defaults to `null`): Radius of the chroma blurring box
- `cr` (of type `string?`, which defaults to `null`): Radius of the chroma blurring box
- `chroma_power` (of type `int?`, which defaults to `null`): How many times should the boxblur be applied to chroma. (default: -1)
- `cp` (of type `int?`, which defaults to `null`): How many times should the boxblur be applied to chroma. (default: -1)
- `alpha_radius` (of type `string?`, which defaults to `null`): Radius of the alpha blurring box
- `ar` (of type `string?`, which defaults to `null`): Radius of the alpha blurring box
- `alpha_power` (of type `int?`, which defaults to `null`): How many times should the boxblur be applied to alpha. (default: -1)
- `ap` (of type `int?`, which defaults to `null`): How many times should the boxblur be applied to alpha. (default: -1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.bs2b`

Ffmpeg filter: Bauer stereo-to-binaural filter.

Type:
```
(?profile : int?, ?fcut : int?, ?feed : int?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `profile` (of type `int?`, which defaults to `null`): Apply a pre-defined crossfeed level. (default: 2949820, possible values: 2949820 (default), 3932860 (cmoy), 6226570 (jmeier))
- `fcut` (of type `int?`, which defaults to `null`): Set cut frequency (in Hz). (default: 0)
- `feed` (of type `int?`, which defaults to `null`): Set feed level (in Hz). (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.bwdif`

Ffmpeg filter: Deinterlace the input image.

Type:
```
(?mode : int?, ?parity : int?, ?deint : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `mode` (of type `int?`, which defaults to `null`): specify the interlacing mode. (default: 1, possible values: 0 (send_frame), 1 (send_field))
- `parity` (of type `int?`, which defaults to `null`): specify the assumed picture field parity. (default: -1, possible values: 0 (tff), 1 (bff), -1 (auto))
- `deint` (of type `int?`, which defaults to `null`): specify which frames to deinterlace. (default: 0, possible values: 0 (all), 1 (interlaced))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.cas`

Ffmpeg filter: Contrast Adaptive Sharpen.

Type:
```
(?strength : float?, ?planes : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `strength` (of type `float?`, which defaults to `null`): set the sharpening strength. (default: 0.)
- `planes` (of type `int?`, which defaults to `null`): set what planes to filter. (default: 7)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.cellauto`

Ffmpeg filter: Create pattern generated by an elementary cellular automaton.

Type:
```
(?filename : string?, ?f : string?, ?pattern : string?,
 ?p : string?, ?rate : string?, ?r : string?,
 ?size : string?, ?s : string?, ?rule : int?,
 ?random_fill_ratio : float?, ?ratio : float?,
 ?random_seed : int?, ?seed : int?, ?scroll : bool?,
 ?start_full : bool?, ?full : bool?, ?stitch : bool?,
 ffmpeg.filter.graph) -> ffmpeg.filter.video
```

Arguments:

- `filename` (of type `string?`, which defaults to `null`): read initial pattern from file
- `f` (of type `string?`, which defaults to `null`): read initial pattern from file
- `pattern` (of type `string?`, which defaults to `null`): set initial pattern
- `p` (of type `string?`, which defaults to `null`): set initial pattern
- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `size` (of type `string?`, which defaults to `null`): set video size
- `s` (of type `string?`, which defaults to `null`): set video size
- `rule` (of type `int?`, which defaults to `null`): set rule. (default: 110)
- `random_fill_ratio` (of type `float?`, which defaults to `null`): set fill ratio for filling initial grid randomly. (default: 0.61803398875)
- `ratio` (of type `float?`, which defaults to `null`): set fill ratio for filling initial grid randomly. (default: 0.61803398875)
- `random_seed` (of type `int?`, which defaults to `null`): set the seed for filling the initial grid randomly. (default: -1)
- `seed` (of type `int?`, which defaults to `null`): set the seed for filling the initial grid randomly. (default: -1)
- `scroll` (of type `bool?`, which defaults to `null`): scroll pattern downward. (default: true)
- `start_full` (of type `bool?`, which defaults to `null`): start filling the whole video. (default: false)
- `full` (of type `bool?`, which defaults to `null`): start filling the whole video. (default: true)
- `stitch` (of type `bool?`, which defaults to `null`): stitch boundaries. (default: true)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.channelmap`

Ffmpeg filter: Remap audio channels.

Type:
```
(?map : string?, ?channel_layout : string?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `map` (of type `string?`, which defaults to `null`): A comma-separated list of input channel numbers in output order.
- `channel_layout` (of type `string?`, which defaults to `null`): Output channel layout.
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.channelsplit`

Ffmpeg filter: Split audio into per-channel streams. This filter has dynamic outputs: returned value is a tuple of audio and video outputs. Total number of outputs is determined at runtime.

Type:
```
(?channel_layout : string?, ?channels : string?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
[ffmpeg.filter.audio] * [ffmpeg.filter.video]
```

Arguments:

- `channel_layout` (of type `string?`, which defaults to `null`): Input channel layout.. (default: stereo)
- `channels` (of type `string?`, which defaults to `null`): Channels to extract.. (default: all)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.chorus`

Ffmpeg filter: Add a chorus effect to the audio.

Type:
```
(?in_gain : float?, ?out_gain : float?,
 ?delays : string?, ?decays : string?, ?speeds : string?,
 ?depths : string?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `in_gain` (of type `float?`, which defaults to `null`): set input gain. (default: 0.4)
- `out_gain` (of type `float?`, which defaults to `null`): set output gain. (default: 0.4)
- `delays` (of type `string?`, which defaults to `null`): set delays
- `decays` (of type `string?`, which defaults to `null`): set decays
- `speeds` (of type `string?`, which defaults to `null`): set speeds
- `depths` (of type `string?`, which defaults to `null`): set depths
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.chromahold`

Ffmpeg filter: Turns a certain color range into gray.

Type:
```
(?color : string?, ?similarity : float?, ?blend : float?,
 ?yuv : bool?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `color` (of type `string?`, which defaults to `null`): set the chromahold key color. (default: black)
- `similarity` (of type `float?`, which defaults to `null`): set the chromahold similarity value. (default: 0.01)
- `blend` (of type `float?`, which defaults to `null`): set the chromahold blend value. (default: 0.)
- `yuv` (of type `bool?`, which defaults to `null`): color parameter is in yuv instead of rgb. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.chromakey`

Ffmpeg filter: Turns a certain color into transparency. Operates on YUV colors.

Type:
```
(?color : string?, ?similarity : float?, ?blend : float?,
 ?yuv : bool?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `color` (of type `string?`, which defaults to `null`): set the chromakey key color. (default: black)
- `similarity` (of type `float?`, which defaults to `null`): set the chromakey similarity value. (default: 0.01)
- `blend` (of type `float?`, which defaults to `null`): set the chromakey key blend value. (default: 0.)
- `yuv` (of type `bool?`, which defaults to `null`): color parameter is in yuv instead of rgb. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.chromashift`

Ffmpeg filter: Shift chroma.

Type:
```
(?cbh : int?, ?cbv : int?, ?crh : int?, ?crv : int?,
 ?edge : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `cbh` (of type `int?`, which defaults to `null`): shift chroma-blue horizontally. (default: 0)
- `cbv` (of type `int?`, which defaults to `null`): shift chroma-blue vertically. (default: 0)
- `crh` (of type `int?`, which defaults to `null`): shift chroma-red horizontally. (default: 0)
- `crv` (of type `int?`, which defaults to `null`): shift chroma-red vertically. (default: 0)
- `edge` (of type `int?`, which defaults to `null`): set edge operation. (default: 0, possible values: 0 (smear), 1 (wrap))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.ciescope`

Ffmpeg filter: Video CIE scope.

Type:
```
(?system : int?, ?cie : int?, ?gamuts : int?,
 ?size : int?, ?s : int?, ?intensity : float?,
 ?i : float?, ?contrast : float?, ?corrgamma : bool?,
 ?showwhite : bool?, ?gamma : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `system` (of type `int?`, which defaults to `null`): set color system. (default: 7, possible values: 0 (ntsc), 0 (470m), 1 (ebu), 1 (470bg), 2 (smpte), 3 (240m), 4 (apple), 5 (widergb), 6 (cie1931), 7 (hdtv), 7 (rec709), 8 (uhdtv), 8 (rec2020), 9 (dcip3))
- `cie` (of type `int?`, which defaults to `null`): set cie system. (default: 0, possible values: 0 (xyy), 1 (ucs), 2 (luv))
- `gamuts` (of type `int?`, which defaults to `null`): set what gamuts to draw. (default: 0, possible values: 1 (ntsc), 1 (470m), 2 (ebu), 2 (470bg), 4 (smpte), 8 (240m), 16 (apple), 32 (widergb), 64 (cie1931), 128 (hdtv), 128 (rec709), 256 (uhdtv), 256 (rec2020), 512 (dcip3))
- `size` (of type `int?`, which defaults to `null`): set ciescope size. (default: 512)
- `s` (of type `int?`, which defaults to `null`): set ciescope size. (default: 512)
- `intensity` (of type `float?`, which defaults to `null`): set ciescope intensity. (default: 0.001)
- `i` (of type `float?`, which defaults to `null`): set ciescope intensity. (default: 0.001)
- `contrast` (of type `float?`, which defaults to `null`): Default: 0.75
- `corrgamma` (of type `bool?`, which defaults to `null`): Default: true
- `showwhite` (of type `bool?`, which defaults to `null`): Default: false
- `gamma` (of type `float?`, which defaults to `null`): Default: 2.6
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.codecview`

Ffmpeg filter: Visualize information about some codecs.

Type:
```
(?mv : int?, ?qp : bool?, ?mv_type : int?, ?mvt : int?,
 ?frame_type : int?, ?ft : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `mv` (of type `int?`, which defaults to `null`): set motion vectors to visualize. (default: 0, possible values: 1 (pf), 2 (bf), 4 (bb))
- `qp` (of type `bool?`, which defaults to `null`): Default: false
- `mv_type` (of type `int?`, which defaults to `null`): set motion vectors type. (default: 0, possible values: 1 (fp), 2 (bp))
- `mvt` (of type `int?`, which defaults to `null`): set motion vectors type. (default: 0, possible values: 1 (fp), 2 (bp))
- `frame_type` (of type `int?`, which defaults to `null`): set frame types to visualize motion vectors of. (default: 0, possible values: 1 (if), 2 (pf), 4 (bf))
- `ft` (of type `int?`, which defaults to `null`): set frame types to visualize motion vectors of. (default: 0, possible values: 1 (if), 2 (pf), 4 (bf))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.color`

Ffmpeg filter: Provide an uniformly colored input.

Type:
```
(?color : string?, ?c : string?, ?size : string?,
 ?s : string?, ?rate : string?, ?r : string?,
 ?duration : int?, ?d : int?, ?sar : string?,
 ffmpeg.filter.graph) -> ffmpeg.filter.video
```

Arguments:

- `color` (of type `string?`, which defaults to `null`): set color. (default: black)
- `c` (of type `string?`, which defaults to `null`): set color. (default: black)
- `size` (of type `string?`, which defaults to `null`): set video size. (default: 320x240)
- `s` (of type `string?`, which defaults to `null`): set video size. (default: 320x240)
- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `duration` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `d` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `sar` (of type `string?`, which defaults to `null`): set video sample aspect ratio. (default: 1/1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.colorbalance`

Ffmpeg filter: Adjust the color balance.

Type:
```
(?rs : float?, ?gs : float?, ?bs : float?, ?rm : float?,
 ?gm : float?, ?bm : float?, ?rh : float?, ?gh : float?,
 ?bh : float?, ?pl : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `rs` (of type `float?`, which defaults to `null`): set red shadows. (default: 0.)
- `gs` (of type `float?`, which defaults to `null`): set green shadows. (default: 0.)
- `bs` (of type `float?`, which defaults to `null`): set blue shadows. (default: 0.)
- `rm` (of type `float?`, which defaults to `null`): set red midtones. (default: 0.)
- `gm` (of type `float?`, which defaults to `null`): set green midtones. (default: 0.)
- `bm` (of type `float?`, which defaults to `null`): set blue midtones. (default: 0.)
- `rh` (of type `float?`, which defaults to `null`): set red highlights. (default: 0.)
- `gh` (of type `float?`, which defaults to `null`): set green highlights. (default: 0.)
- `bh` (of type `float?`, which defaults to `null`): set blue highlights. (default: 0.)
- `pl` (of type `bool?`, which defaults to `null`): preserve lightness. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.colorchannelmixer`

Ffmpeg filter: Adjust colors by mixing color channels.

Type:
```
(?rr : float?, ?rg : float?, ?rb : float?, ?ra : float?,
 ?gr : float?, ?gg : float?, ?gb : float?, ?ga : float?,
 ?br : float?, ?bg : float?, ?bb : float?, ?ba : float?,
 ?ar : float?, ?ag : float?, ?ab : float?, ?aa : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `rr` (of type `float?`, which defaults to `null`): set the red gain for the red channel. (default: 1.)
- `rg` (of type `float?`, which defaults to `null`): set the green gain for the red channel. (default: 0.)
- `rb` (of type `float?`, which defaults to `null`): set the blue gain for the red channel. (default: 0.)
- `ra` (of type `float?`, which defaults to `null`): set the alpha gain for the red channel. (default: 0.)
- `gr` (of type `float?`, which defaults to `null`): set the red gain for the green channel. (default: 0.)
- `gg` (of type `float?`, which defaults to `null`): set the green gain for the green channel. (default: 1.)
- `gb` (of type `float?`, which defaults to `null`): set the blue gain for the green channel. (default: 0.)
- `ga` (of type `float?`, which defaults to `null`): set the alpha gain for the green channel. (default: 0.)
- `br` (of type `float?`, which defaults to `null`): set the red gain for the blue channel. (default: 0.)
- `bg` (of type `float?`, which defaults to `null`): set the green gain for the blue channel. (default: 0.)
- `bb` (of type `float?`, which defaults to `null`): set the blue gain for the blue channel. (default: 1.)
- `ba` (of type `float?`, which defaults to `null`): set the alpha gain for the blue channel. (default: 0.)
- `ar` (of type `float?`, which defaults to `null`): set the red gain for the alpha channel. (default: 0.)
- `ag` (of type `float?`, which defaults to `null`): set the green gain for the alpha channel. (default: 0.)
- `ab` (of type `float?`, which defaults to `null`): set the blue gain for the alpha channel. (default: 0.)
- `aa` (of type `float?`, which defaults to `null`): set the alpha gain for the alpha channel. (default: 1.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.colorhold`

Ffmpeg filter: Turns a certain color range into gray. Operates on RGB colors.

Type:
```
(?color : string?, ?similarity : float?, ?blend : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `color` (of type `string?`, which defaults to `null`): set the colorhold key color. (default: black)
- `similarity` (of type `float?`, which defaults to `null`): set the colorhold similarity value. (default: 0.01)
- `blend` (of type `float?`, which defaults to `null`): set the colorhold blend value. (default: 0.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.colorkey`

Ffmpeg filter: Turns a certain color into transparency. Operates on RGB colors.

Type:
```
(?color : string?, ?similarity : float?, ?blend : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `color` (of type `string?`, which defaults to `null`): set the colorkey key color. (default: black)
- `similarity` (of type `float?`, which defaults to `null`): set the colorkey similarity value. (default: 0.01)
- `blend` (of type `float?`, which defaults to `null`): set the colorkey key blend value. (default: 0.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.colorkey_opencl`

Ffmpeg filter: Turns a certain color into transparency. Operates on RGB colors.

Type:
```
(?color : string?, ?similarity : float?, ?blend : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `color` (of type `string?`, which defaults to `null`): set the colorkey key color. (default: black)
- `similarity` (of type `float?`, which defaults to `null`): set the colorkey similarity value. (default: 0.01)
- `blend` (of type `float?`, which defaults to `null`): set the colorkey key blend value. (default: 0.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.colorlevels`

Ffmpeg filter: Adjust the color levels.

Type:
```
(?rimin : float?, ?gimin : float?, ?bimin : float?,
 ?aimin : float?, ?rimax : float?, ?gimax : float?,
 ?bimax : float?, ?aimax : float?, ?romin : float?,
 ?gomin : float?, ?bomin : float?, ?aomin : float?,
 ?romax : float?, ?gomax : float?, ?bomax : float?,
 ?aomax : float?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `rimin` (of type `float?`, which defaults to `null`): set input red black point. (default: 0.)
- `gimin` (of type `float?`, which defaults to `null`): set input green black point. (default: 0.)
- `bimin` (of type `float?`, which defaults to `null`): set input blue black point. (default: 0.)
- `aimin` (of type `float?`, which defaults to `null`): set input alpha black point. (default: 0.)
- `rimax` (of type `float?`, which defaults to `null`): set input red white point. (default: 1.)
- `gimax` (of type `float?`, which defaults to `null`): set input green white point. (default: 1.)
- `bimax` (of type `float?`, which defaults to `null`): set input blue white point. (default: 1.)
- `aimax` (of type `float?`, which defaults to `null`): set input alpha white point. (default: 1.)
- `romin` (of type `float?`, which defaults to `null`): set output red black point. (default: 0.)
- `gomin` (of type `float?`, which defaults to `null`): set output green black point. (default: 0.)
- `bomin` (of type `float?`, which defaults to `null`): set output blue black point. (default: 0.)
- `aomin` (of type `float?`, which defaults to `null`): set output alpha black point. (default: 0.)
- `romax` (of type `float?`, which defaults to `null`): set output red white point. (default: 1.)
- `gomax` (of type `float?`, which defaults to `null`): set output green white point. (default: 1.)
- `bomax` (of type `float?`, which defaults to `null`): set output blue white point. (default: 1.)
- `aomax` (of type `float?`, which defaults to `null`): set output alpha white point. (default: 1.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.colormatrix`

Ffmpeg filter: Convert color matrix.

Type:
```
(?src : int?, ?dst : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `src` (of type `int?`, which defaults to `null`): set source color matrix. (default: -1, possible values: 0 (bt709), 1 (fcc), 2 (bt601), 2 (bt470), 2 (bt470bg), 2 (smpte170m), 3 (smpte240m), 4 (bt2020))
- `dst` (of type `int?`, which defaults to `null`): set destination color matrix. (default: -1, possible values: 0 (bt709), 1 (fcc), 2 (bt601), 2 (bt470), 2 (bt470bg), 2 (smpte170m), 3 (smpte240m), 4 (bt2020))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.colorspace`

Ffmpeg filter: Convert between colorspaces.

Type:
```
(?all : int?, ?space : int?, ?range : int?,
 ?primaries : int?, ?trc : int?, ?format : int?,
 ?fast : bool?, ?dither : int?, ?wpadapt : int?,
 ?iall : int?, ?ispace : int?, ?irange : int?,
 ?iprimaries : int?, ?itrc : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `all` (of type `int?`, which defaults to `null`): Set all color properties together. (default: 0, possible values: 1 (bt470m), 2 (bt470bg), 3 (bt601-6-525), 4 (bt601-6-625), 5 (bt709), 6 (smpte170m), 7 (smpte240m), 8 (bt2020))
- `space` (of type `int?`, which defaults to `null`): Output colorspace. (default: 2, possible values: 1 (bt709), 4 (fcc), 5 (bt470bg), 6 (smpte170m), 7 (smpte240m), 8 (ycgco), 0 (gbr), 9 (bt2020nc), 9 (bt2020ncl))
- `range` (of type `int?`, which defaults to `null`): Output color range. (default: 0, possible values: 1 (tv), 1 (mpeg), 2 (pc), 2 (jpeg))
- `primaries` (of type `int?`, which defaults to `null`): Output color primaries. (default: 2, possible values: 1 (bt709), 4 (bt470m), 5 (bt470bg), 6 (smpte170m), 7 (smpte240m), 10 (smpte428), 8 (film), 11 (smpte431), 12 (smpte432), 9 (bt2020), 22 (jedec-p22), 22 (ebu3213))
- `trc` (of type `int?`, which defaults to `null`): Output transfer characteristics. (default: 2, possible values: 1 (bt709), 4 (bt470m), 4 (gamma22), 5 (bt470bg), 5 (gamma28), 6 (smpte170m), 7 (smpte240m), 13 (srgb), 13 (iec61966-2-1), 11 (xvycc), 11 (iec61966-2-4), 14 (bt2020-10), 15 (bt2020-12))
- `format` (of type `int?`, which defaults to `null`): Output pixel format. (default: -1, possible values: 0 (yuv420p), 64 (yuv420p10), 125 (yuv420p12), 4 (yuv422p), 66 (yuv422p10), 129 (yuv422p12), 5 (yuv444p), 70 (yuv444p10), 133 (yuv444p12))
- `fast` (of type `bool?`, which defaults to `null`): Ignore primary chromaticity and gamma correction. (default: false)
- `dither` (of type `int?`, which defaults to `null`): Dithering mode. (default: 0, possible values: 0 (none), 1 (fsb))
- `wpadapt` (of type `int?`, which defaults to `null`): Whitepoint adaptation method. (default: 0, possible values: 0 (bradford), 1 (vonkries), 2 (identity))
- `iall` (of type `int?`, which defaults to `null`): Set all input color properties together. (default: 0, possible values: 1 (bt470m), 2 (bt470bg), 3 (bt601-6-525), 4 (bt601-6-625), 5 (bt709), 6 (smpte170m), 7 (smpte240m), 8 (bt2020))
- `ispace` (of type `int?`, which defaults to `null`): Input colorspace. (default: 2, possible values: 1 (bt709), 4 (fcc), 5 (bt470bg), 6 (smpte170m), 7 (smpte240m), 8 (ycgco), 0 (gbr), 9 (bt2020nc), 9 (bt2020ncl))
- `irange` (of type `int?`, which defaults to `null`): Input color range. (default: 0, possible values: 1 (tv), 1 (mpeg), 2 (pc), 2 (jpeg))
- `iprimaries` (of type `int?`, which defaults to `null`): Input color primaries. (default: 2, possible values: 1 (bt709), 4 (bt470m), 5 (bt470bg), 6 (smpte170m), 7 (smpte240m), 10 (smpte428), 8 (film), 11 (smpte431), 12 (smpte432), 9 (bt2020), 22 (jedec-p22), 22 (ebu3213))
- `itrc` (of type `int?`, which defaults to `null`): Input transfer characteristics. (default: 2, possible values: 1 (bt709), 4 (bt470m), 4 (gamma22), 5 (bt470bg), 5 (gamma28), 6 (smpte170m), 7 (smpte240m), 13 (srgb), 13 (iec61966-2-1), 11 (xvycc), 11 (iec61966-2-4), 14 (bt2020-10), 15 (bt2020-12))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.compand`

Ffmpeg filter: Compress or expand audio dynamic range.

Type:
```
(?attacks : string?, ?decays : string?,
 ?points : string?, ?soft-knee : float?, ?gain : float?,
 ?volume : float?, ?delay : float?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `attacks` (of type `string?`, which defaults to `null`): set time over which increase of volume is determined. (default: 0)
- `decays` (of type `string?`, which defaults to `null`): set time over which decrease of volume is determined. (default: 0.8)
- `points` (of type `string?`, which defaults to `null`): set points of transfer function. (default: -70/-70|-60/-20|1/0)
- `soft-knee` (of type `float?`, which defaults to `null`): set soft-knee. (default: 0.01)
- `gain` (of type `float?`, which defaults to `null`): set output gain. (default: 0.)
- `volume` (of type `float?`, which defaults to `null`): set initial volume. (default: 0.)
- `delay` (of type `float?`, which defaults to `null`): set delay for samples before sending them to volume adjuster. (default: 0.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.compensationdelay`

Ffmpeg filter: Audio Compensation Delay Line.

Type:
```
(?mm : int?, ?cm : int?, ?m : int?, ?dry : float?,
 ?wet : float?, ?temp : int?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `mm` (of type `int?`, which defaults to `null`): set mm distance. (default: 0)
- `cm` (of type `int?`, which defaults to `null`): set cm distance. (default: 0)
- `m` (of type `int?`, which defaults to `null`): set meter distance. (default: 0)
- `dry` (of type `float?`, which defaults to `null`): set dry amount. (default: 0.)
- `wet` (of type `float?`, which defaults to `null`): set wet amount. (default: 1.)
- `temp` (of type `int?`, which defaults to `null`): set temperature °C. (default: 20)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.concat`

Ffmpeg filter: Concatenate audio and video streams. This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime. This filter has dynamic outputs: returned value is a tuple of audio and video outputs. Total number of outputs is determined at runtime.

Type:
```
(?n : int?, ?v : int?, ?a : int?, ?unsafe : bool?,
 ffmpeg.filter.graph, [ffmpeg.filter.audio],
 [ffmpeg.filter.video]) ->
[ffmpeg.filter.audio] * [ffmpeg.filter.video]
```

Arguments:

- `n` (of type `int?`, which defaults to `null`): specify the number of segments. (default: 2)
- `v` (of type `int?`, which defaults to `null`): specify the number of video streams. (default: 1)
- `a` (of type `int?`, which defaults to `null`): specify the number of audio streams. (default: 0)
- `unsafe` (of type `bool?`, which defaults to `null`): enable unsafe mode. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.convolution`

Ffmpeg filter: Apply convolution filter.

Type:
```
(?0m : string?, ?1m : string?, ?2m : string?,
 ?3m : string?, ?0rdiv : float?, ?1rdiv : float?,
 ?2rdiv : float?, ?3rdiv : float?, ?0bias : float?,
 ?1bias : float?, ?2bias : float?, ?3bias : float?,
 ?0mode : int?, ?1mode : int?, ?2mode : int?,
 ?3mode : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `0m` (of type `string?`, which defaults to `null`): set matrix for 1st plane. (default: 0 0 0 0 1 0 0 0 0)
- `1m` (of type `string?`, which defaults to `null`): set matrix for 2nd plane. (default: 0 0 0 0 1 0 0 0 0)
- `2m` (of type `string?`, which defaults to `null`): set matrix for 3rd plane. (default: 0 0 0 0 1 0 0 0 0)
- `3m` (of type `string?`, which defaults to `null`): set matrix for 4th plane. (default: 0 0 0 0 1 0 0 0 0)
- `0rdiv` (of type `float?`, which defaults to `null`): set rdiv for 1st plane. (default: 0.)
- `1rdiv` (of type `float?`, which defaults to `null`): set rdiv for 2nd plane. (default: 0.)
- `2rdiv` (of type `float?`, which defaults to `null`): set rdiv for 3rd plane. (default: 0.)
- `3rdiv` (of type `float?`, which defaults to `null`): set rdiv for 4th plane. (default: 0.)
- `0bias` (of type `float?`, which defaults to `null`): set bias for 1st plane. (default: 0.)
- `1bias` (of type `float?`, which defaults to `null`): set bias for 2nd plane. (default: 0.)
- `2bias` (of type `float?`, which defaults to `null`): set bias for 3rd plane. (default: 0.)
- `3bias` (of type `float?`, which defaults to `null`): set bias for 4th plane. (default: 0.)
- `0mode` (of type `int?`, which defaults to `null`): set matrix mode for 1st plane. (default: 0, possible values: 0 (square), 1 (row), 2 (column))
- `1mode` (of type `int?`, which defaults to `null`): set matrix mode for 2nd plane. (default: 0, possible values: 0 (square), 1 (row), 2 (column))
- `2mode` (of type `int?`, which defaults to `null`): set matrix mode for 3rd plane. (default: 0, possible values: 0 (square), 1 (row), 2 (column))
- `3mode` (of type `int?`, which defaults to `null`): set matrix mode for 4th plane. (default: 0, possible values: 0 (square), 1 (row), 2 (column))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.convolution_opencl`

Ffmpeg filter: Apply convolution mask to input video

Type:
```
(?0m : string?, ?1m : string?, ?2m : string?,
 ?3m : string?, ?0rdiv : float?, ?1rdiv : float?,
 ?2rdiv : float?, ?3rdiv : float?, ?0bias : float?,
 ?1bias : float?, ?2bias : float?, ?3bias : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `0m` (of type `string?`, which defaults to `null`): set matrix for 2nd plane. (default: 0 0 0 0 1 0 0 0 0)
- `1m` (of type `string?`, which defaults to `null`): set matrix for 2nd plane. (default: 0 0 0 0 1 0 0 0 0)
- `2m` (of type `string?`, which defaults to `null`): set matrix for 3rd plane. (default: 0 0 0 0 1 0 0 0 0)
- `3m` (of type `string?`, which defaults to `null`): set matrix for 4th plane. (default: 0 0 0 0 1 0 0 0 0)
- `0rdiv` (of type `float?`, which defaults to `null`): set rdiv for 1nd plane. (default: 1.)
- `1rdiv` (of type `float?`, which defaults to `null`): set rdiv for 2nd plane. (default: 1.)
- `2rdiv` (of type `float?`, which defaults to `null`): set rdiv for 3rd plane. (default: 1.)
- `3rdiv` (of type `float?`, which defaults to `null`): set rdiv for 4th plane. (default: 1.)
- `0bias` (of type `float?`, which defaults to `null`): set bias for 1st plane. (default: 0.)
- `1bias` (of type `float?`, which defaults to `null`): set bias for 2nd plane. (default: 0.)
- `2bias` (of type `float?`, which defaults to `null`): set bias for 3rd plane. (default: 0.)
- `3bias` (of type `float?`, which defaults to `null`): set bias for 4th plane. (default: 0.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.convolve`

Ffmpeg filter: Convolve first video stream with second video stream.

Type:
```
(?planes : int?, ?impulse : int?, ?noise : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `planes` (of type `int?`, which defaults to `null`): set planes to convolve. (default: 7)
- `impulse` (of type `int?`, which defaults to `null`): when to process impulses. (default: 1, possible values: 0 (first), 1 (all))
- `noise` (of type `float?`, which defaults to `null`): set noise. (default: 1e-07)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.copy`

Ffmpeg filter: Copy the input video unchanged to the output.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.cover_rect`

Ffmpeg filter: Find and cover a user specified object.

Type:
```
(?cover : string?, ?mode : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `cover` (of type `string?`, which defaults to `null`): cover bitmap filename
- `mode` (of type `int?`, which defaults to `null`): set removal mode. (default: 1, possible values: 0 (cover), 1 (blur))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.crop`

Ffmpeg filter: Crop the input video.

Type:
```
(?out_w : string?, ?w : string?, ?out_h : string?,
 ?h : string?, ?x : string?, ?y : string?,
 ?keep_aspect : bool?, ?exact : bool?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `out_w` (of type `string?`, which defaults to `null`): set the width crop area expression. (default: iw)
- `w` (of type `string?`, which defaults to `null`): set the width crop area expression. (default: iw)
- `out_h` (of type `string?`, which defaults to `null`): set the height crop area expression. (default: ih)
- `h` (of type `string?`, which defaults to `null`): set the height crop area expression. (default: ih)
- `x` (of type `string?`, which defaults to `null`): set the x crop area expression. (default: (in_w-out_w)/2)
- `y` (of type `string?`, which defaults to `null`): set the y crop area expression. (default: (in_h-out_h)/2)
- `keep_aspect` (of type `bool?`, which defaults to `null`): keep aspect ratio. (default: false)
- `exact` (of type `bool?`, which defaults to `null`): do exact cropping. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.cropdetect`

Ffmpeg filter: Auto-detect crop size.

Type:
```
(?limit : float?, ?round : int?, ?reset : int?,
 ?reset_count : int?, ?max_outliers : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `limit` (of type `float?`, which defaults to `null`): Threshold below which the pixel is considered black. (default: 0.0941176470588)
- `round` (of type `int?`, which defaults to `null`): Value by which the width/height should be divisible. (default: 16)
- `reset` (of type `int?`, which defaults to `null`): Recalculate the crop area after this many frames. (default: 0)
- `reset_count` (of type `int?`, which defaults to `null`): Recalculate the crop area after this many frames. (default: 0)
- `max_outliers` (of type `int?`, which defaults to `null`): Threshold count of outliers. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.crossfeed`

Ffmpeg filter: Apply headphone crossfeed filter.

Type:
```
(?strength : float?, ?range : float?, ?slope : float?,
 ?level_in : float?, ?level_out : float?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `strength` (of type `float?`, which defaults to `null`): set crossfeed strength. (default: 0.2)
- `range` (of type `float?`, which defaults to `null`): set soundstage wideness. (default: 0.5)
- `slope` (of type `float?`, which defaults to `null`): set curve slope. (default: 0.5)
- `level_in` (of type `float?`, which defaults to `null`): set level in. (default: 0.9)
- `level_out` (of type `float?`, which defaults to `null`): set level out. (default: 1.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.crystalizer`

Ffmpeg filter: Simple expand audio dynamic range filter.

Type:
```
(?i : float?, ?c : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `i` (of type `float?`, which defaults to `null`): set intensity. (default: 2.)
- `c` (of type `bool?`, which defaults to `null`): enable clipping. (default: true)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.cue`

Ffmpeg filter: Delay filtering to match a cue.

Type:
```
(?cue : int?, ?preroll : int?, ?buffer : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `cue` (of type `int?`, which defaults to `null`): cue unix timestamp in microseconds. (default: 0)
- `preroll` (of type `int?`, which defaults to `null`): preroll duration in seconds. (default: 0)
- `buffer` (of type `int?`, which defaults to `null`): buffer duration in seconds. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.curves`

Ffmpeg filter: Adjust components curves.

Type:
```
(?preset : int?, ?master : string?, ?m : string?,
 ?red : string?, ?r : string?, ?green : string?,
 ?g : string?, ?blue : string?, ?b : string?,
 ?all : string?, ?psfile : string?, ?plot : string?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `preset` (of type `int?`, which defaults to `null`): select a color curves preset. (default: 0, possible values: 0 (none), 1 (color_negative), 2 (cross_process), 3 (darker), 4 (increase_contrast), 5 (lighter), 6 (linear_contrast), 7 (medium_contrast), 8 (negative), 9 (strong_contrast), 10 (vintage))
- `master` (of type `string?`, which defaults to `null`): set master points coordinates
- `m` (of type `string?`, which defaults to `null`): set master points coordinates
- `red` (of type `string?`, which defaults to `null`): set red points coordinates
- `r` (of type `string?`, which defaults to `null`): set red points coordinates
- `green` (of type `string?`, which defaults to `null`): set green points coordinates
- `g` (of type `string?`, which defaults to `null`): set green points coordinates
- `blue` (of type `string?`, which defaults to `null`): set blue points coordinates
- `b` (of type `string?`, which defaults to `null`): set blue points coordinates
- `all` (of type `string?`, which defaults to `null`): set points coordinates for all components
- `psfile` (of type `string?`, which defaults to `null`): set Photoshop curves file name
- `plot` (of type `string?`, which defaults to `null`): save Gnuplot script of the curves in specified file
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.datascope`

Ffmpeg filter: Video data analysis.

Type:
```
(?size : string?, ?s : string?, ?x : int?, ?y : int?,
 ?mode : int?, ?axis : bool?, ?opacity : float?,
 ?format : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `size` (of type `string?`, which defaults to `null`): set output size. (default: hd720)
- `s` (of type `string?`, which defaults to `null`): set output size. (default: hd720)
- `x` (of type `int?`, which defaults to `null`): set x offset. (default: 0)
- `y` (of type `int?`, which defaults to `null`): set y offset. (default: 0)
- `mode` (of type `int?`, which defaults to `null`): set scope mode. (default: 0, possible values: 0 (mono), 1 (color), 2 (color2))
- `axis` (of type `bool?`, which defaults to `null`): draw column/row numbers. (default: false)
- `opacity` (of type `float?`, which defaults to `null`): set background opacity. (default: 0.75)
- `format` (of type `int?`, which defaults to `null`): set display number format. (default: 0, possible values: 0 (hex), 1 (dec))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.dblur`

Ffmpeg filter: Apply Directional Blur filter.

Type:
```
(?angle : float?, ?radius : float?, ?planes : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `angle` (of type `float?`, which defaults to `null`): set angle. (default: 45.)
- `radius` (of type `float?`, which defaults to `null`): set radius. (default: 5.)
- `planes` (of type `int?`, which defaults to `null`): set planes to filter. (default: 15)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.dcshift`

Ffmpeg filter: Apply a DC shift to the audio.

Type:
```
(?shift : float?, ?limitergain : float?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `shift` (of type `float?`, which defaults to `null`): set DC shift. (default: 0.)
- `limitergain` (of type `float?`, which defaults to `null`): set limiter gain. (default: 0.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.dctdnoiz`

Ffmpeg filter: Denoise frames using 2D DCT.

Type:
```
(?sigma : float?, ?s : float?, ?overlap : int?,
 ?expr : string?, ?e : string?, ?n : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `sigma` (of type `float?`, which defaults to `null`): set noise sigma constant. (default: 0.)
- `s` (of type `float?`, which defaults to `null`): set noise sigma constant. (default: 0.)
- `overlap` (of type `int?`, which defaults to `null`): set number of block overlapping pixels. (default: -1)
- `expr` (of type `string?`, which defaults to `null`): set coefficient factor expression
- `e` (of type `string?`, which defaults to `null`): set coefficient factor expression
- `n` (of type `int?`, which defaults to `null`): set the block size, expressed in bits. (default: 3)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.deband`

Ffmpeg filter: Debands video.

Type:
```
(?1thr : float?, ?2thr : float?, ?3thr : float?,
 ?4thr : float?, ?range : int?, ?r : int?,
 ?direction : float?, ?d : float?, ?blur : bool?,
 ?b : bool?, ?coupling : bool?, ?c : bool?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `1thr` (of type `float?`, which defaults to `null`): set 1st plane threshold. (default: 0.02)
- `2thr` (of type `float?`, which defaults to `null`): set 2nd plane threshold. (default: 0.02)
- `3thr` (of type `float?`, which defaults to `null`): set 3rd plane threshold. (default: 0.02)
- `4thr` (of type `float?`, which defaults to `null`): set 4th plane threshold. (default: 0.02)
- `range` (of type `int?`, which defaults to `null`): set range. (default: 16)
- `r` (of type `int?`, which defaults to `null`): set range. (default: 16)
- `direction` (of type `float?`, which defaults to `null`): set direction. (default: 6.28318530718)
- `d` (of type `float?`, which defaults to `null`): set direction. (default: 6.28318530718)
- `blur` (of type `bool?`, which defaults to `null`): set blur. (default: true)
- `b` (of type `bool?`, which defaults to `null`): set blur. (default: true)
- `coupling` (of type `bool?`, which defaults to `null`): set plane coupling. (default: false)
- `c` (of type `bool?`, which defaults to `null`): set plane coupling. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.deblock`

Ffmpeg filter: Deblock video.

Type:
```
(?filter : int?, ?block : int?, ?alpha : float?,
 ?beta : float?, ?gamma : float?, ?delta : float?,
 ?planes : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `filter` (of type `int?`, which defaults to `null`): set type of filter. (default: 1, possible values: 0 (weak), 1 (strong))
- `block` (of type `int?`, which defaults to `null`): set size of block. (default: 8)
- `alpha` (of type `float?`, which defaults to `null`): set 1st detection threshold. (default: 0.098)
- `beta` (of type `float?`, which defaults to `null`): set 2nd detection threshold. (default: 0.05)
- `gamma` (of type `float?`, which defaults to `null`): set 3rd detection threshold. (default: 0.05)
- `delta` (of type `float?`, which defaults to `null`): set 4th detection threshold. (default: 0.05)
- `planes` (of type `int?`, which defaults to `null`): set planes to filter. (default: 15)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.decimate`

Ffmpeg filter: Decimate frames (post field matching filter). This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime.

Type:
```
(?cycle : int?, ?dupthresh : float?, ?scthresh : float?,
 ?blockx : int?, ?blocky : int?, ?ppsrc : bool?,
 ?chroma : bool?, ffmpeg.filter.graph,
 [ffmpeg.filter.audio], [ffmpeg.filter.video]) ->
ffmpeg.filter.video
```

Arguments:

- `cycle` (of type `int?`, which defaults to `null`): set the number of frame from which one will be dropped. (default: 5)
- `dupthresh` (of type `float?`, which defaults to `null`): set duplicate threshold. (default: 1.1)
- `scthresh` (of type `float?`, which defaults to `null`): set scene change threshold. (default: 15.)
- `blockx` (of type `int?`, which defaults to `null`): set the size of the x-axis blocks used during metric calculations. (default: 32)
- `blocky` (of type `int?`, which defaults to `null`): set the size of the y-axis blocks used during metric calculations. (default: 32)
- `ppsrc` (of type `bool?`, which defaults to `null`): mark main input as a pre-processed input and activate clean source input stream. (default: false)
- `chroma` (of type `bool?`, which defaults to `null`): set whether or not chroma is considered in the metric calculations. (default: true)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.deconvolve`

Ffmpeg filter: Deconvolve first video stream with second video stream.

Type:
```
(?planes : int?, ?impulse : int?, ?noise : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `planes` (of type `int?`, which defaults to `null`): set planes to deconvolve. (default: 7)
- `impulse` (of type `int?`, which defaults to `null`): when to process impulses. (default: 1, possible values: 0 (first), 1 (all))
- `noise` (of type `float?`, which defaults to `null`): set noise. (default: 1e-07)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.dedot`

Ffmpeg filter: Reduce cross-luminance and cross-color.

Type:
```
(?m : int?, ?lt : float?, ?tl : float?, ?tc : float?,
 ?ct : float?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `m` (of type `int?`, which defaults to `null`): set filtering mode. (default: 3, possible values: 1 (dotcrawl), 2 (rainbows))
- `lt` (of type `float?`, which defaults to `null`): set spatial luma threshold. (default: 0.079)
- `tl` (of type `float?`, which defaults to `null`): set tolerance for temporal luma. (default: 0.079)
- `tc` (of type `float?`, which defaults to `null`): set tolerance for chroma temporal variation. (default: 0.058)
- `ct` (of type `float?`, which defaults to `null`): set temporal chroma threshold. (default: 0.019)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.deesser`

Ffmpeg filter: Apply de-essing to the audio.

Type:
```
(?i : float?, ?m : float?, ?f : float?, ?s : int?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `i` (of type `float?`, which defaults to `null`): set intensity. (default: 0.)
- `m` (of type `float?`, which defaults to `null`): set max deessing. (default: 0.5)
- `f` (of type `float?`, which defaults to `null`): set frequency. (default: 0.5)
- `s` (of type `int?`, which defaults to `null`): set output mode. (default: 1, possible values: 0 (i), 1 (o), 2 (e))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.deflate`

Ffmpeg filter: Apply deflate effect.

Type:
```
(?threshold0 : int?, ?threshold1 : int?,
 ?threshold2 : int?, ?threshold3 : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `threshold0` (of type `int?`, which defaults to `null`): set threshold for 1st plane. (default: 65535)
- `threshold1` (of type `int?`, which defaults to `null`): set threshold for 2nd plane. (default: 65535)
- `threshold2` (of type `int?`, which defaults to `null`): set threshold for 3rd plane. (default: 65535)
- `threshold3` (of type `int?`, which defaults to `null`): set threshold for 4th plane. (default: 65535)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.deflicker`

Ffmpeg filter: Remove temporal frame luminance variations.

Type:
```
(?size : int?, ?s : int?, ?mode : int?, ?m : int?,
 ?bypass : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `size` (of type `int?`, which defaults to `null`): set how many frames to use. (default: 5)
- `s` (of type `int?`, which defaults to `null`): set how many frames to use. (default: 5)
- `mode` (of type `int?`, which defaults to `null`): set how to smooth luminance. (default: 0, possible values: 0 (am), 1 (gm), 2 (hm), 3 (qm), 4 (cm), 5 (pm), 6 (median))
- `m` (of type `int?`, which defaults to `null`): set how to smooth luminance. (default: 0, possible values: 0 (am), 1 (gm), 2 (hm), 3 (qm), 4 (cm), 5 (pm), 6 (median))
- `bypass` (of type `bool?`, which defaults to `null`): leave frames unchanged. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.deinterlace_qsv`

Ffmpeg filter: QuickSync video deinterlacing

Type:
```
(?mode : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `mode` (of type `int?`, which defaults to `null`): set deinterlace mode. (default: 2, possible values: 1 (bob), 2 (advanced))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.deinterlace_vaapi`

Ffmpeg filter: Deinterlacing of VAAPI surfaces

Type:
```
(?mode : int?, ?rate : int?, ?auto : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `mode` (of type `int?`, which defaults to `null`): Deinterlacing mode. (default: 0, possible values: 0 (default), 1 (bob), 2 (weave), 3 (motion_adaptive), 4 (motion_compensated))
- `rate` (of type `int?`, which defaults to `null`): Generate output at frame rate or field rate. (default: 1, possible values: 1 (frame), 2 (field))
- `auto` (of type `int?`, which defaults to `null`): Only deinterlace fields, passing frames through unchanged. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.dejudder`

Ffmpeg filter: Remove judder produced by pullup.

Type:
```
(?cycle : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `cycle` (of type `int?`, which defaults to `null`): set the length of the cycle to use for dejuddering. (default: 4)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.delogo`

Ffmpeg filter: Remove logo from input video.

Type:
```
(?x : string?, ?y : string?, ?w : string?, ?h : string?,
 ?show : bool?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `x` (of type `string?`, which defaults to `null`): set logo x position. (default: -1)
- `y` (of type `string?`, which defaults to `null`): set logo y position. (default: -1)
- `w` (of type `string?`, which defaults to `null`): set logo width. (default: -1)
- `h` (of type `string?`, which defaults to `null`): set logo height. (default: -1)
- `show` (of type `bool?`, which defaults to `null`): show delogo area. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.denoise_vaapi`

Ffmpeg filter: VAAPI VPP for de-noise

Type:
```
(?denoise : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `denoise` (of type `int?`, which defaults to `null`): denoise level. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.derain`

Ffmpeg filter: Apply derain filter to the input.

Type:
```
(?filter_type : int?, ?dnn_backend : int?,
 ?model : string?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `filter_type` (of type `int?`, which defaults to `null`): filter type(derain/dehaze). (default: 0, possible values: 0 (derain), 1 (dehaze))
- `dnn_backend` (of type `int?`, which defaults to `null`): DNN backend. (default: 0, possible values: 0 (native))
- `model` (of type `string?`, which defaults to `null`): path to model file
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.deshake`

Ffmpeg filter: Stabilize shaky video.

Type:
```
(?x : int?, ?y : int?, ?w : int?, ?h : int?, ?rx : int?,
 ?ry : int?, ?edge : int?, ?blocksize : int?,
 ?contrast : int?, ?search : int?, ?filename : string?,
 ?opencl : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `x` (of type `int?`, which defaults to `null`): set x for the rectangular search area. (default: -1)
- `y` (of type `int?`, which defaults to `null`): set y for the rectangular search area. (default: -1)
- `w` (of type `int?`, which defaults to `null`): set width for the rectangular search area. (default: -1)
- `h` (of type `int?`, which defaults to `null`): set height for the rectangular search area. (default: -1)
- `rx` (of type `int?`, which defaults to `null`): set x for the rectangular search area. (default: 16)
- `ry` (of type `int?`, which defaults to `null`): set y for the rectangular search area. (default: 16)
- `edge` (of type `int?`, which defaults to `null`): set edge mode. (default: 3, possible values: 0 (blank), 1 (original), 2 (clamp), 3 (mirror))
- `blocksize` (of type `int?`, which defaults to `null`): set motion search blocksize. (default: 8)
- `contrast` (of type `int?`, which defaults to `null`): set contrast threshold for blocks. (default: 125)
- `search` (of type `int?`, which defaults to `null`): set search strategy. (default: 0, possible values: 0 (exhaustive), 1 (less))
- `filename` (of type `string?`, which defaults to `null`): set motion search detailed log file name
- `opencl` (of type `bool?`, which defaults to `null`): ignored. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.deshake_opencl`

Ffmpeg filter: Feature-point based video stabilization filter

Type:
```
(?tripod : bool?, ?debug : bool?, ?adaptive_crop : bool?,
 ?refine_features : bool?, ?smooth_strength : float?,
 ?smooth_window_multiplier : float?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `tripod` (of type `bool?`, which defaults to `null`): simulates a tripod by preventing any camera movement whatsoever from the original frame. (default: false)
- `debug` (of type `bool?`, which defaults to `null`): turn on additional debugging information. (default: false)
- `adaptive_crop` (of type `bool?`, which defaults to `null`): attempt to subtly crop borders to reduce mirrored content. (default: true)
- `refine_features` (of type `bool?`, which defaults to `null`): refine feature point locations at a sub-pixel level. (default: true)
- `smooth_strength` (of type `float?`, which defaults to `null`): smoothing strength (0 attempts to adaptively determine optimal strength). (default: 0.)
- `smooth_window_multiplier` (of type `float?`, which defaults to `null`): multiplier for number of frames to buffer for motion data. (default: 2.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.despill`

Ffmpeg filter: Despill video.

Type:
```
(?type : int?, ?mix : float?, ?expand : float?,
 ?red : float?, ?green : float?, ?blue : float?,
 ?brightness : float?, ?alpha : bool?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `type` (of type `int?`, which defaults to `null`): set the screen type. (default: 0, possible values: 0 (green), 1 (blue))
- `mix` (of type `float?`, which defaults to `null`): set the spillmap mix. (default: 0.5)
- `expand` (of type `float?`, which defaults to `null`): set the spillmap expand. (default: 0.)
- `red` (of type `float?`, which defaults to `null`): set red scale. (default: 0.)
- `green` (of type `float?`, which defaults to `null`): set green scale. (default: -1.)
- `blue` (of type `float?`, which defaults to `null`): set blue scale. (default: 0.)
- `brightness` (of type `float?`, which defaults to `null`): set brightness. (default: 0.)
- `alpha` (of type `bool?`, which defaults to `null`): change alpha component. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.detelecine`

Ffmpeg filter: Apply an inverse telecine pattern.

Type:
```
(?first_field : int?, ?pattern : string?,
 ?start_frame : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `first_field` (of type `int?`, which defaults to `null`): select first field. (default: 0, possible values: 0 (top), 0 (t), 1 (bottom), 1 (b))
- `pattern` (of type `string?`, which defaults to `null`): pattern that describe for how many fields a frame is to be displayed. (default: 23)
- `start_frame` (of type `int?`, which defaults to `null`): position of first frame with respect to the pattern if stream is cut. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.dilation`

Ffmpeg filter: Apply dilation effect.

Type:
```
(?threshold0 : int?, ?threshold1 : int?,
 ?threshold2 : int?, ?threshold3 : int?,
 ?coordinates : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `threshold0` (of type `int?`, which defaults to `null`): set threshold for 1st plane. (default: 65535)
- `threshold1` (of type `int?`, which defaults to `null`): set threshold for 2nd plane. (default: 65535)
- `threshold2` (of type `int?`, which defaults to `null`): set threshold for 3rd plane. (default: 65535)
- `threshold3` (of type `int?`, which defaults to `null`): set threshold for 4th plane. (default: 65535)
- `coordinates` (of type `int?`, which defaults to `null`): set coordinates. (default: 255)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.dilation_opencl`

Ffmpeg filter: Apply dilation effect

Type:
```
(?threshold0 : float?, ?threshold1 : float?,
 ?threshold2 : float?, ?threshold3 : float?,
 ?coordinates : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `threshold0` (of type `float?`, which defaults to `null`): set threshold for 1st plane. (default: 65535.)
- `threshold1` (of type `float?`, which defaults to `null`): set threshold for 2nd plane. (default: 65535.)
- `threshold2` (of type `float?`, which defaults to `null`): set threshold for 3rd plane. (default: 65535.)
- `threshold3` (of type `float?`, which defaults to `null`): set threshold for 4th plane. (default: 65535.)
- `coordinates` (of type `int?`, which defaults to `null`): set coordinates. (default: 255)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.displace`

Ffmpeg filter: Displace pixels.

Type:
```
(?edge : int?, ffmpeg.filter.graph, ffmpeg.filter.video,
 ffmpeg.filter.video, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `edge` (of type `int?`, which defaults to `null`): set edge mode. (default: 1, possible values: 0 (blank), 1 (smear), 2 (wrap), 3 (mirror))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.dnn_processing`

Ffmpeg filter: Apply DNN processing filter to the input.

Type:
```
(?dnn_backend : int?, ?model : string?, ?input : string?,
 ?output : string?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `dnn_backend` (of type `int?`, which defaults to `null`): DNN backend. (default: 0, possible values: 0 (native))
- `model` (of type `string?`, which defaults to `null`): path to model file
- `input` (of type `string?`, which defaults to `null`): input name of the model
- `output` (of type `string?`, which defaults to `null`): output name of the model
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.doubleweave`

Ffmpeg filter: Weave input video fields into double number of frames.

Type:
```
(?first_field : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `first_field` (of type `int?`, which defaults to `null`): set first field. (default: 0, possible values: 0 (top), 0 (t), 1 (bottom), 1 (b))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.drawbox`

Ffmpeg filter: Draw a colored box on the input video.

Type:
```
(?x : string?, ?y : string?, ?width : string?,
 ?w : string?, ?height : string?, ?h : string?,
 ?color : string?, ?c : string?, ?thickness : string?,
 ?t : string?, ?replace : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `x` (of type `string?`, which defaults to `null`): set horizontal position of the left box edge. (default: 0)
- `y` (of type `string?`, which defaults to `null`): set vertical position of the top box edge. (default: 0)
- `width` (of type `string?`, which defaults to `null`): set width of the box. (default: 0)
- `w` (of type `string?`, which defaults to `null`): set width of the box. (default: 0)
- `height` (of type `string?`, which defaults to `null`): set height of the box. (default: 0)
- `h` (of type `string?`, which defaults to `null`): set height of the box. (default: 0)
- `color` (of type `string?`, which defaults to `null`): set color of the box. (default: black)
- `c` (of type `string?`, which defaults to `null`): set color of the box. (default: black)
- `thickness` (of type `string?`, which defaults to `null`): set the box thickness. (default: 3)
- `t` (of type `string?`, which defaults to `null`): set the box thickness. (default: 3)
- `replace` (of type `bool?`, which defaults to `null`): replace color & alpha. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.drawgraph`

Ffmpeg filter: Draw a graph using input video metadata.

Type:
```
(?m1 : string?, ?fg1 : string?, ?m2 : string?,
 ?fg2 : string?, ?m3 : string?, ?fg3 : string?,
 ?m4 : string?, ?fg4 : string?, ?bg : string?,
 ?min : float?, ?max : float?, ?mode : int?,
 ?slide : int?, ?size : string?, ?s : string?,
 ?rate : string?, ?r : string?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `m1` (of type `string?`, which defaults to `null`): set 1st metadata key. (default: )
- `fg1` (of type `string?`, which defaults to `null`): set 1st foreground color expression. (default: 0xffff0000)
- `m2` (of type `string?`, which defaults to `null`): set 2nd metadata key. (default: )
- `fg2` (of type `string?`, which defaults to `null`): set 2nd foreground color expression. (default: 0xff00ff00)
- `m3` (of type `string?`, which defaults to `null`): set 3rd metadata key. (default: )
- `fg3` (of type `string?`, which defaults to `null`): set 3rd foreground color expression. (default: 0xffff00ff)
- `m4` (of type `string?`, which defaults to `null`): set 4th metadata key. (default: )
- `fg4` (of type `string?`, which defaults to `null`): set 4th foreground color expression. (default: 0xffffff00)
- `bg` (of type `string?`, which defaults to `null`): set background color. (default: white)
- `min` (of type `float?`, which defaults to `null`): set minimal value. (default: -1.)
- `max` (of type `float?`, which defaults to `null`): set maximal value. (default: 1.)
- `mode` (of type `int?`, which defaults to `null`): set graph mode. (default: 2, possible values: 0 (bar), 1 (dot), 2 (line))
- `slide` (of type `int?`, which defaults to `null`): set slide mode. (default: 0, possible values: 0 (frame), 1 (replace), 2 (scroll), 3 (rscroll), 4 (picture))
- `size` (of type `string?`, which defaults to `null`): set graph size. (default: 900x256)
- `s` (of type `string?`, which defaults to `null`): set graph size. (default: 900x256)
- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.drawgrid`

Ffmpeg filter: Draw a colored grid on the input video.

Type:
```
(?x : string?, ?y : string?, ?width : string?,
 ?w : string?, ?height : string?, ?h : string?,
 ?color : string?, ?c : string?, ?thickness : string?,
 ?t : string?, ?replace : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `x` (of type `string?`, which defaults to `null`): set horizontal offset. (default: 0)
- `y` (of type `string?`, which defaults to `null`): set vertical offset. (default: 0)
- `width` (of type `string?`, which defaults to `null`): set width of grid cell. (default: 0)
- `w` (of type `string?`, which defaults to `null`): set width of grid cell. (default: 0)
- `height` (of type `string?`, which defaults to `null`): set height of grid cell. (default: 0)
- `h` (of type `string?`, which defaults to `null`): set height of grid cell. (default: 0)
- `color` (of type `string?`, which defaults to `null`): set color of the grid. (default: black)
- `c` (of type `string?`, which defaults to `null`): set color of the grid. (default: black)
- `thickness` (of type `string?`, which defaults to `null`): set grid line thickness. (default: 1)
- `t` (of type `string?`, which defaults to `null`): set grid line thickness. (default: 1)
- `replace` (of type `bool?`, which defaults to `null`): replace color & alpha. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.drawtext`

Ffmpeg filter: Draw text on top of video frames using libfreetype library.

Type:
```
(?fontfile : string?, ?text : string?,
 ?textfile : string?, ?fontcolor : string?,
 ?fontcolor_expr : string?, ?boxcolor : string?,
 ?bordercolor : string?, ?shadowcolor : string?,
 ?box : bool?, ?boxborderw : int?, ?line_spacing : int?,
 ?fontsize : string?, ?x : string?, ?y : string?,
 ?shadowx : int?, ?shadowy : int?, ?borderw : int?,
 ?tabsize : int?, ?basetime : int?, ?font : string?,
 ?expansion : int?, ?timecode : string?,
 ?tc24hmax : bool?, ?timecode_rate : string?,
 ?r : string?, ?rate : string?, ?reload : bool?,
 ?alpha : string?, ?fix_bounds : bool?,
 ?start_number : int?, ?text_shaping : bool?,
 ?ft_load_flags : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `fontfile` (of type `string?`, which defaults to `null`): set font file
- `text` (of type `string?`, which defaults to `null`): set text
- `textfile` (of type `string?`, which defaults to `null`): set text file
- `fontcolor` (of type `string?`, which defaults to `null`): set foreground color. (default: black)
- `fontcolor_expr` (of type `string?`, which defaults to `null`): set foreground color expression. (default: )
- `boxcolor` (of type `string?`, which defaults to `null`): set box color. (default: white)
- `bordercolor` (of type `string?`, which defaults to `null`): set border color. (default: black)
- `shadowcolor` (of type `string?`, which defaults to `null`): set shadow color. (default: black)
- `box` (of type `bool?`, which defaults to `null`): set box. (default: false)
- `boxborderw` (of type `int?`, which defaults to `null`): set box border width. (default: 0)
- `line_spacing` (of type `int?`, which defaults to `null`): set line spacing in pixels. (default: 0)
- `fontsize` (of type `string?`, which defaults to `null`): set font size
- `x` (of type `string?`, which defaults to `null`): set x expression. (default: 0)
- `y` (of type `string?`, which defaults to `null`): set y expression. (default: 0)
- `shadowx` (of type `int?`, which defaults to `null`): set shadow x offset. (default: 0)
- `shadowy` (of type `int?`, which defaults to `null`): set shadow y offset. (default: 0)
- `borderw` (of type `int?`, which defaults to `null`): set border width. (default: 0)
- `tabsize` (of type `int?`, which defaults to `null`): set tab size. (default: 4)
- `basetime` (of type `int?`, which defaults to `null`): set base time. (default: -9223372036854775808)
- `font` (of type `string?`, which defaults to `null`): Font name. (default: Sans)
- `expansion` (of type `int?`, which defaults to `null`): set the expansion mode. (default: 1, possible values: 0 (none), 1 (normal), 2 (strftime))
- `timecode` (of type `string?`, which defaults to `null`): set initial timecode
- `tc24hmax` (of type `bool?`, which defaults to `null`): set 24 hours max (timecode only). (default: false)
- `timecode_rate` (of type `string?`, which defaults to `null`): set rate (timecode only). (default: 0/1)
- `r` (of type `string?`, which defaults to `null`): set rate (timecode only). (default: 0/1)
- `rate` (of type `string?`, which defaults to `null`): set rate (timecode only). (default: 0/1)
- `reload` (of type `bool?`, which defaults to `null`): reload text file for each frame. (default: false)
- `alpha` (of type `string?`, which defaults to `null`): apply alpha while rendering. (default: 1)
- `fix_bounds` (of type `bool?`, which defaults to `null`): check and fix text coords to avoid clipping. (default: false)
- `start_number` (of type `int?`, which defaults to `null`): start frame number for n/frame_num variable. (default: 0)
- `text_shaping` (of type `bool?`, which defaults to `null`): attempt to shape text before drawing. (default: true)
- `ft_load_flags` (of type `int?`, which defaults to `null`): set font loading flags for libfreetype. (default: 0, possible values: 0 (default), 1 (no_scale), 2 (no_hinting), 4 (render), 8 (no_bitmap), 16 (vertical_layout), 32 (force_autohint), 64 (crop_bitmap), 128 (pedantic), 512 (ignore_global_advance_width), 1024 (no_recurse), 2048 (ignore_transform), 4096 (monochrome), 8192 (linear_design), 32768 (no_autohint))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.drmeter`

Ffmpeg filter: Measure audio dynamic range.

Type:
```
(?length : float?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `length` (of type `float?`, which defaults to `null`): set the window length. (default: 3.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.dynaudnorm`

Ffmpeg filter: Dynamic Audio Normalizer.

Type:
```
(?framelen : int?, ?f : int?, ?gausssize : int?,
 ?g : int?, ?peak : float?, ?p : float?,
 ?maxgain : float?, ?m : float?, ?targetrms : float?,
 ?r : float?, ?coupling : bool?, ?n : bool?,
 ?correctdc : bool?, ?c : bool?, ?altboundary : bool?,
 ?b : bool?, ?compress : float?, ?s : float?,
 ?threshold : float?, ?t : float?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `framelen` (of type `int?`, which defaults to `null`): set the frame length in msec. (default: 500)
- `f` (of type `int?`, which defaults to `null`): set the frame length in msec. (default: 500)
- `gausssize` (of type `int?`, which defaults to `null`): set the filter size. (default: 31)
- `g` (of type `int?`, which defaults to `null`): set the filter size. (default: 31)
- `peak` (of type `float?`, which defaults to `null`): set the peak value. (default: 0.95)
- `p` (of type `float?`, which defaults to `null`): set the peak value. (default: 0.95)
- `maxgain` (of type `float?`, which defaults to `null`): set the max amplification. (default: 10.)
- `m` (of type `float?`, which defaults to `null`): set the max amplification. (default: 10.)
- `targetrms` (of type `float?`, which defaults to `null`): set the target RMS. (default: 0.)
- `r` (of type `float?`, which defaults to `null`): set the target RMS. (default: 0.)
- `coupling` (of type `bool?`, which defaults to `null`): set channel coupling. (default: true)
- `n` (of type `bool?`, which defaults to `null`): set channel coupling. (default: true)
- `correctdc` (of type `bool?`, which defaults to `null`): set DC correction. (default: false)
- `c` (of type `bool?`, which defaults to `null`): set DC correction. (default: false)
- `altboundary` (of type `bool?`, which defaults to `null`): set alternative boundary mode. (default: false)
- `b` (of type `bool?`, which defaults to `null`): set alternative boundary mode. (default: false)
- `compress` (of type `float?`, which defaults to `null`): set the compress factor. (default: 0.)
- `s` (of type `float?`, which defaults to `null`): set the compress factor. (default: 0.)
- `threshold` (of type `float?`, which defaults to `null`): set the threshold value. (default: 0.)
- `t` (of type `float?`, which defaults to `null`): set the threshold value. (default: 0.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.earwax`

Ffmpeg filter: Widen the stereo image.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.ebur128`

Ffmpeg filter: EBU R128 scanner. This filter has dynamic outputs: returned value is a tuple of audio and video outputs. Total number of outputs is determined at runtime.

Type:
```
(?video : bool?, ?size : string?, ?meter : int?,
 ?framelog : int?, ?metadata : bool?, ?peak : int?,
 ?dualmono : bool?, ?panlaw : float?, ?target : int?,
 ?gauge : int?, ?scale : int?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) ->
[ffmpeg.filter.audio] * [ffmpeg.filter.video]
```

Arguments:

- `video` (of type `bool?`, which defaults to `null`): set video output. (default: false)
- `size` (of type `string?`, which defaults to `null`): set video size. (default: 640x480)
- `meter` (of type `int?`, which defaults to `null`): set scale meter (+9 to +18). (default: 9)
- `framelog` (of type `int?`, which defaults to `null`): force frame logging level. (default: -1, possible values: 32 (info), 40 (verbose))
- `metadata` (of type `bool?`, which defaults to `null`): inject metadata in the filtergraph. (default: false)
- `peak` (of type `int?`, which defaults to `null`): set peak mode. (default: 0, possible values: 0 (none), 2 (sample), 4 (true))
- `dualmono` (of type `bool?`, which defaults to `null`): treat mono input files as dual-mono. (default: false)
- `panlaw` (of type `float?`, which defaults to `null`): set a specific pan law for dual-mono files. (default: -3.01029995664)
- `target` (of type `int?`, which defaults to `null`): set a specific target level in LUFS (-23 to 0). (default: -23)
- `gauge` (of type `int?`, which defaults to `null`): set gauge display type. (default: 0, possible values: 0 (momentary), 0 (m), 1 (shortterm), 1 (s))
- `scale` (of type `int?`, which defaults to `null`): sets display method for the stats. (default: 0, possible values: 0 (absolute), 0 (LUFS), 1 (relative), 1 (LU))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.edgedetect`

Ffmpeg filter: Detect and draw edge.

Type:
```
(?high : float?, ?low : float?, ?mode : int?,
 ?planes : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `high` (of type `float?`, which defaults to `null`): set high threshold. (default: 0.196078431373)
- `low` (of type `float?`, which defaults to `null`): set low threshold. (default: 0.078431372549)
- `mode` (of type `int?`, which defaults to `null`): set mode. (default: 0, possible values: 0 (wires), 1 (colormix), 2 (canny))
- `planes` (of type `int?`, which defaults to `null`): set planes to filter. (default: 7, possible values: 1 (y), 2 (u), 4 (v), 4 (r), 1 (g), 2 (b))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.elbg`

Ffmpeg filter: Apply posterize effect, using the ELBG algorithm.

Type:
```
(?codebook_length : int?, ?l : int?, ?nb_steps : int?,
 ?n : int?, ?seed : int?, ?s : int?, ?pal8 : bool?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `codebook_length` (of type `int?`, which defaults to `null`): set codebook length. (default: 256)
- `l` (of type `int?`, which defaults to `null`): set codebook length. (default: 256)
- `nb_steps` (of type `int?`, which defaults to `null`): set max number of steps used to compute the mapping. (default: 1)
- `n` (of type `int?`, which defaults to `null`): set max number of steps used to compute the mapping. (default: 1)
- `seed` (of type `int?`, which defaults to `null`): set the random seed. (default: -1)
- `s` (of type `int?`, which defaults to `null`): set the random seed. (default: -1)
- `pal8` (of type `bool?`, which defaults to `null`): set the pal8 output. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.entropy`

Ffmpeg filter: Measure video frames entropy.

Type:
```
(?mode : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `mode` (of type `int?`, which defaults to `null`): set kind of histogram entropy measurement. (default: 0, possible values: 0 (normal), 1 (diff))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.eq`

Ffmpeg filter: Adjust brightness, contrast, gamma, and saturation.

Type:
```
(?contrast : string?, ?brightness : string?,
 ?saturation : string?, ?gamma : string?,
 ?gamma_r : string?, ?gamma_g : string?,
 ?gamma_b : string?, ?gamma_weight : string?,
 ?eval : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `contrast` (of type `string?`, which defaults to `null`): set the contrast adjustment, negative values give a negative image. (default: 1.0)
- `brightness` (of type `string?`, which defaults to `null`): set the brightness adjustment. (default: 0.0)
- `saturation` (of type `string?`, which defaults to `null`): set the saturation adjustment. (default: 1.0)
- `gamma` (of type `string?`, which defaults to `null`): set the initial gamma value. (default: 1.0)
- `gamma_r` (of type `string?`, which defaults to `null`): gamma value for red. (default: 1.0)
- `gamma_g` (of type `string?`, which defaults to `null`): gamma value for green. (default: 1.0)
- `gamma_b` (of type `string?`, which defaults to `null`): gamma value for blue. (default: 1.0)
- `gamma_weight` (of type `string?`, which defaults to `null`): set the gamma weight which reduces the effect of gamma on bright areas. (default: 1.0)
- `eval` (of type `int?`, which defaults to `null`): specify when to evaluate expressions. (default: 0, possible values: 0 (init), 1 (frame))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.equalizer`

Ffmpeg filter: Apply two-pole peaking equalization (EQ) filter.

Type:
```
(?frequency : float?, ?f : float?, ?width_type : int?,
 ?t : int?, ?width : float?, ?w : float?, ?gain : float?,
 ?g : float?, ?mix : float?, ?m : float?,
 ?channels : string?, ?c : string?, ?normalize : bool?,
 ?n : bool?, ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `frequency` (of type `float?`, which defaults to `null`): set central frequency. (default: 0.)
- `f` (of type `float?`, which defaults to `null`): set central frequency. (default: 0.)
- `width_type` (of type `int?`, which defaults to `null`): set filter-width type. (default: 3, possible values: 1 (h), 3 (q), 2 (o), 4 (s), 5 (k))
- `t` (of type `int?`, which defaults to `null`): set filter-width type. (default: 3, possible values: 1 (h), 3 (q), 2 (o), 4 (s), 5 (k))
- `width` (of type `float?`, which defaults to `null`): set band-width. (default: 1.)
- `w` (of type `float?`, which defaults to `null`): set band-width. (default: 1.)
- `gain` (of type `float?`, which defaults to `null`): set gain. (default: 0.)
- `g` (of type `float?`, which defaults to `null`): set gain. (default: 0.)
- `mix` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `m` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `channels` (of type `string?`, which defaults to `null`): set channels to filter
- `c` (of type `string?`, which defaults to `null`): set channels to filter
- `normalize` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: false)
- `n` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.erosion`

Ffmpeg filter: Apply erosion effect.

Type:
```
(?threshold0 : int?, ?threshold1 : int?,
 ?threshold2 : int?, ?threshold3 : int?,
 ?coordinates : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `threshold0` (of type `int?`, which defaults to `null`): set threshold for 1st plane. (default: 65535)
- `threshold1` (of type `int?`, which defaults to `null`): set threshold for 2nd plane. (default: 65535)
- `threshold2` (of type `int?`, which defaults to `null`): set threshold for 3rd plane. (default: 65535)
- `threshold3` (of type `int?`, which defaults to `null`): set threshold for 4th plane. (default: 65535)
- `coordinates` (of type `int?`, which defaults to `null`): set coordinates. (default: 255)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.erosion_opencl`

Ffmpeg filter: Apply erosion effect

Type:
```
(?threshold0 : float?, ?threshold1 : float?,
 ?threshold2 : float?, ?threshold3 : float?,
 ?coordinates : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `threshold0` (of type `float?`, which defaults to `null`): set threshold for 1st plane. (default: 65535.)
- `threshold1` (of type `float?`, which defaults to `null`): set threshold for 2nd plane. (default: 65535.)
- `threshold2` (of type `float?`, which defaults to `null`): set threshold for 3rd plane. (default: 65535.)
- `threshold3` (of type `float?`, which defaults to `null`): set threshold for 4th plane. (default: 65535.)
- `coordinates` (of type `int?`, which defaults to `null`): set coordinates. (default: 255)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.extractplanes`

Ffmpeg filter: Extract planes as grayscale frames. This filter has dynamic outputs: returned value is a tuple of audio and video outputs. Total number of outputs is determined at runtime.

Type:
```
(?planes : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) ->
[ffmpeg.filter.audio] * [ffmpeg.filter.video]
```

Arguments:

- `planes` (of type `int?`, which defaults to `null`): set planes. (default: 1, possible values: 16 (y), 32 (u), 64 (v), 1 (r), 2 (g), 4 (b), 8 (a))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.extrastereo`

Ffmpeg filter: Increase difference between stereo audio channels.

Type:
```
(?m : float?, ?c : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `m` (of type `float?`, which defaults to `null`): set the difference coefficient. (default: 2.5)
- `c` (of type `bool?`, which defaults to `null`): enable clipping. (default: true)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.fade`

Ffmpeg filter: Fade in/out input video.

Type:
```
(?type : int?, ?t : int?, ?start_frame : int?, ?s : int?,
 ?nb_frames : int?, ?n : int?, ?alpha : bool?,
 ?start_time : int?, ?st : int?, ?duration : int?,
 ?d : int?, ?color : string?, ?c : string?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `type` (of type `int?`, which defaults to `null`): set the fade direction. (default: 0, possible values: 0 (in), 1 (out))
- `t` (of type `int?`, which defaults to `null`): set the fade direction. (default: 0, possible values: 0 (in), 1 (out))
- `start_frame` (of type `int?`, which defaults to `null`): Number of the first frame to which to apply the effect.. (default: 0)
- `s` (of type `int?`, which defaults to `null`): Number of the first frame to which to apply the effect.. (default: 0)
- `nb_frames` (of type `int?`, which defaults to `null`): Number of frames to which the effect should be applied.. (default: 25)
- `n` (of type `int?`, which defaults to `null`): Number of frames to which the effect should be applied.. (default: 25)
- `alpha` (of type `bool?`, which defaults to `null`): fade alpha if it is available on the input. (default: false)
- `start_time` (of type `int?`, which defaults to `null`): Number of seconds of the beginning of the effect.. (default: 0)
- `st` (of type `int?`, which defaults to `null`): Number of seconds of the beginning of the effect.. (default: 0)
- `duration` (of type `int?`, which defaults to `null`): Duration of the effect in seconds.. (default: 0)
- `d` (of type `int?`, which defaults to `null`): Duration of the effect in seconds.. (default: 0)
- `color` (of type `string?`, which defaults to `null`): set color. (default: black)
- `c` (of type `string?`, which defaults to `null`): set color. (default: black)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.fftdnoiz`

Ffmpeg filter: Denoise frames using 3D FFT.

Type:
```
(?sigma : float?, ?amount : float?, ?block : int?,
 ?overlap : float?, ?prev : int?, ?next : int?,
 ?planes : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `sigma` (of type `float?`, which defaults to `null`): set denoise strength. (default: 1.)
- `amount` (of type `float?`, which defaults to `null`): set amount of denoising. (default: 1.)
- `block` (of type `int?`, which defaults to `null`): set block log2(size). (default: 4)
- `overlap` (of type `float?`, which defaults to `null`): set block overlap. (default: 0.5)
- `prev` (of type `int?`, which defaults to `null`): set number of previous frames for temporal denoising. (default: 0)
- `next` (of type `int?`, which defaults to `null`): set number of next frames for temporal denoising. (default: 0)
- `planes` (of type `int?`, which defaults to `null`): set planes to filter. (default: 7)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.fftfilt`

Ffmpeg filter: Apply arbitrary expressions to pixels in frequency domain.

Type:
```
(?dc_Y : int?, ?dc_U : int?, ?dc_V : int?,
 ?weight_Y : string?, ?weight_U : string?,
 ?weight_V : string?, ?eval : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `dc_Y` (of type `int?`, which defaults to `null`): adjust gain in Y plane. (default: 0)
- `dc_U` (of type `int?`, which defaults to `null`): adjust gain in U plane. (default: 0)
- `dc_V` (of type `int?`, which defaults to `null`): adjust gain in V plane. (default: 0)
- `weight_Y` (of type `string?`, which defaults to `null`): set luminance expression in Y plane. (default: 1)
- `weight_U` (of type `string?`, which defaults to `null`): set chrominance expression in U plane
- `weight_V` (of type `string?`, which defaults to `null`): set chrominance expression in V plane
- `eval` (of type `int?`, which defaults to `null`): specify when to evaluate expressions. (default: 0, possible values: 0 (init), 1 (frame))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.field`

Ffmpeg filter: Extract a field from the input video.

Type:
```
(?type : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `type` (of type `int?`, which defaults to `null`): set field type (top or bottom). (default: 0, possible values: 0 (top), 1 (bottom))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.fieldhint`

Ffmpeg filter: Field matching using hints.

Type:
```
(?hint : string?, ?mode : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `hint` (of type `string?`, which defaults to `null`): set hint file
- `mode` (of type `int?`, which defaults to `null`): set hint mode. (default: 0, possible values: 0 (absolute), 1 (relative))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.fieldmatch`

Ffmpeg filter: Field matching for inverse telecine. This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime.

Type:
```
(?order : int?, ?mode : int?, ?ppsrc : bool?,
 ?field : int?, ?mchroma : bool?, ?y0 : int?, ?y1 : int?,
 ?scthresh : float?, ?combmatch : int?, ?combdbg : int?,
 ?cthresh : int?, ?chroma : bool?, ?blockx : int?,
 ?blocky : int?, ?combpel : int?, ffmpeg.filter.graph,
 [ffmpeg.filter.audio], [ffmpeg.filter.video]) ->
ffmpeg.filter.video
```

Arguments:

- `order` (of type `int?`, which defaults to `null`): specify the assumed field order. (default: -1, possible values: -1 (auto), 0 (bff), 1 (tff))
- `mode` (of type `int?`, which defaults to `null`): set the matching mode or strategy to use. (default: 1, possible values: 0 (pc), 1 (pc_n), 2 (pc_u), 3 (pc_n_ub), 4 (pcn), 5 (pcn_ub))
- `ppsrc` (of type `bool?`, which defaults to `null`): mark main input as a pre-processed input and activate clean source input stream. (default: false)
- `field` (of type `int?`, which defaults to `null`): set the field to match from. (default: -1, possible values: -1 (auto), 0 (bottom), 1 (top))
- `mchroma` (of type `bool?`, which defaults to `null`): set whether or not chroma is included during the match comparisons. (default: true)
- `y0` (of type `int?`, which defaults to `null`): define an exclusion band which excludes the lines between y0 and y1 from the field matching decision. (default: 0)
- `y1` (of type `int?`, which defaults to `null`): define an exclusion band which excludes the lines between y0 and y1 from the field matching decision. (default: 0)
- `scthresh` (of type `float?`, which defaults to `null`): set scene change detection threshold. (default: 12.)
- `combmatch` (of type `int?`, which defaults to `null`): set combmatching mode. (default: 1, possible values: 0 (none), 1 (sc), 2 (full))
- `combdbg` (of type `int?`, which defaults to `null`): enable comb debug. (default: 0, possible values: 0 (none), 1 (pcn), 2 (pcnub))
- `cthresh` (of type `int?`, which defaults to `null`): set the area combing threshold used for combed frame detection. (default: 9)
- `chroma` (of type `bool?`, which defaults to `null`): set whether or not chroma is considered in the combed frame decision. (default: false)
- `blockx` (of type `int?`, which defaults to `null`): set the x-axis size of the window used during combed frame detection. (default: 16)
- `blocky` (of type `int?`, which defaults to `null`): set the y-axis size of the window used during combed frame detection. (default: 16)
- `combpel` (of type `int?`, which defaults to `null`): set the number of combed pixels inside any of the blocky by blockx size blocks on the frame for the frame to be detected as combed. (default: 80)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.fieldorder`

Ffmpeg filter: Set the field order.

Type:
```
(?order : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `order` (of type `int?`, which defaults to `null`): output field order. (default: 1, possible values: 0 (bff), 1 (tff))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.fifo`

Ffmpeg filter: Buffer input images and send them when they are requested.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.fillborders`

Ffmpeg filter: Fill borders of the input video.

Type:
```
(?left : int?, ?right : int?, ?top : int?,
 ?bottom : int?, ?mode : int?, ?color : string?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `left` (of type `int?`, which defaults to `null`): set the left fill border. (default: 0)
- `right` (of type `int?`, which defaults to `null`): set the right fill border. (default: 0)
- `top` (of type `int?`, which defaults to `null`): set the top fill border. (default: 0)
- `bottom` (of type `int?`, which defaults to `null`): set the bottom fill border. (default: 0)
- `mode` (of type `int?`, which defaults to `null`): set the fill borders mode. (default: 0, possible values: 0 (smear), 1 (mirror), 2 (fixed))
- `color` (of type `string?`, which defaults to `null`): set the color for the fixed mode. (default: black)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.find_rect`

Ffmpeg filter: Find a user specified object.

Type:
```
(?object : string?, ?threshold : float?, ?mipmaps : int?,
 ?xmin : int?, ?ymin : int?, ?xmax : int?, ?ymax : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `object` (of type `string?`, which defaults to `null`): object bitmap filename
- `threshold` (of type `float?`, which defaults to `null`): set threshold. (default: 0.5)
- `mipmaps` (of type `int?`, which defaults to `null`): set mipmaps. (default: 3)
- `xmin` (of type `int?`, which defaults to `null`): Default: 0
- `ymin` (of type `int?`, which defaults to `null`): Default: 0
- `xmax` (of type `int?`, which defaults to `null`): Default: 0
- `ymax` (of type `int?`, which defaults to `null`): Default: 0
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.firequalizer`

Ffmpeg filter: Finite Impulse Response Equalizer.

Type:
```
(?gain : string?, ?gain_entry : string?, ?delay : float?,
 ?accuracy : float?, ?wfunc : int?, ?fixed : bool?,
 ?multi : bool?, ?zero_phase : bool?, ?scale : int?,
 ?dumpfile : string?, ?dumpscale : int?, ?fft2 : bool?,
 ?min_phase : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `gain` (of type `string?`, which defaults to `null`): set gain curve. (default: gain_interpolate(f))
- `gain_entry` (of type `string?`, which defaults to `null`): set gain entry
- `delay` (of type `float?`, which defaults to `null`): set delay. (default: 0.01)
- `accuracy` (of type `float?`, which defaults to `null`): set accuracy. (default: 5.)
- `wfunc` (of type `int?`, which defaults to `null`): set window function. (default: 1, possible values: 0 (rectangular), 1 (hann), 2 (hamming), 3 (blackman), 4 (nuttall3), 5 (mnuttall3), 6 (nuttall), 7 (bnuttall), 8 (bharris), 9 (tukey))
- `fixed` (of type `bool?`, which defaults to `null`): set fixed frame samples. (default: false)
- `multi` (of type `bool?`, which defaults to `null`): set multi channels mode. (default: false)
- `zero_phase` (of type `bool?`, which defaults to `null`): set zero phase mode. (default: false)
- `scale` (of type `int?`, which defaults to `null`): set gain scale. (default: 1, possible values: 0 (linlin), 1 (linlog), 2 (loglin), 3 (loglog))
- `dumpfile` (of type `string?`, which defaults to `null`): set dump file
- `dumpscale` (of type `int?`, which defaults to `null`): set dump scale. (default: 1, possible values: 0 (linlin), 1 (linlog), 2 (loglin), 3 (loglog))
- `fft2` (of type `bool?`, which defaults to `null`): set 2-channels fft. (default: false)
- `min_phase` (of type `bool?`, which defaults to `null`): set minimum phase mode. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.flanger`

Ffmpeg filter: Apply a flanging effect to the audio.

Type:
```
(?delay : float?, ?depth : float?, ?regen : float?,
 ?width : float?, ?speed : float?, ?shape : int?,
 ?phase : float?, ?interp : int?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `delay` (of type `float?`, which defaults to `null`): base delay in milliseconds. (default: 0.)
- `depth` (of type `float?`, which defaults to `null`): added swept delay in milliseconds. (default: 2.)
- `regen` (of type `float?`, which defaults to `null`): percentage regeneration (delayed signal feedback). (default: 0.)
- `width` (of type `float?`, which defaults to `null`): percentage of delayed signal mixed with original. (default: 71.)
- `speed` (of type `float?`, which defaults to `null`): sweeps per second (Hz). (default: 0.5)
- `shape` (of type `int?`, which defaults to `null`): swept wave shape. (default: 0, possible values: 1 (triangular), 1 (t), 0 (sinusoidal), 0 (s))
- `phase` (of type `float?`, which defaults to `null`): swept wave percentage phase-shift for multi-channel. (default: 25.)
- `interp` (of type `int?`, which defaults to `null`): delay-line interpolation. (default: 0, possible values: 0 (linear), 1 (quadratic))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.flite`

Ffmpeg filter: Synthesize voice from text using libflite.

Type:
```
(?list_voices : bool?, ?nb_samples : int?, ?n : int?,
 ?text : string?, ?textfile : string?, ?v : string?,
 ?voice : string?, ffmpeg.filter.graph) ->
ffmpeg.filter.audio
```

Arguments:

- `list_voices` (of type `bool?`, which defaults to `null`): list voices and exit. (default: false)
- `nb_samples` (of type `int?`, which defaults to `null`): set number of samples per frame. (default: 512)
- `n` (of type `int?`, which defaults to `null`): set number of samples per frame. (default: 512)
- `text` (of type `string?`, which defaults to `null`): set text to speak
- `textfile` (of type `string?`, which defaults to `null`): set filename of the text to speak
- `v` (of type `string?`, which defaults to `null`): set voice. (default: kal)
- `voice` (of type `string?`, which defaults to `null`): set voice. (default: kal)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.floodfill`

Ffmpeg filter: Fill area with same color with another color.

Type:
```
(?x : int?, ?y : int?, ?s0 : int?, ?s1 : int?,
 ?s2 : int?, ?s3 : int?, ?d0 : int?, ?d1 : int?,
 ?d2 : int?, ?d3 : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `x` (of type `int?`, which defaults to `null`): set pixel x coordinate. (default: 0)
- `y` (of type `int?`, which defaults to `null`): set pixel y coordinate. (default: 0)
- `s0` (of type `int?`, which defaults to `null`): set source #0 component value. (default: 0)
- `s1` (of type `int?`, which defaults to `null`): set source #1 component value. (default: 0)
- `s2` (of type `int?`, which defaults to `null`): set source #2 component value. (default: 0)
- `s3` (of type `int?`, which defaults to `null`): set source #3 component value. (default: 0)
- `d0` (of type `int?`, which defaults to `null`): set destination #0 component value. (default: 0)
- `d1` (of type `int?`, which defaults to `null`): set destination #1 component value. (default: 0)
- `d2` (of type `int?`, which defaults to `null`): set destination #2 component value. (default: 0)
- `d3` (of type `int?`, which defaults to `null`): set destination #3 component value. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.format`

Ffmpeg filter: Convert the input video to one of the specified pixel formats.

Type:
```
(?pix_fmts : string?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `pix_fmts` (of type `string?`, which defaults to `null`): A '|'-separated list of pixel formats
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.fps`

Ffmpeg filter: Force constant framerate.

Type:
```
(?fps : string?, ?start_time : float?, ?round : int?,
 ?eof_action : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `fps` (of type `string?`, which defaults to `null`): A string describing desired output framerate. (default: 25)
- `start_time` (of type `float?`, which defaults to `null`): Assume the first PTS should be this value.. (default: 1.79769313486e+308)
- `round` (of type `int?`, which defaults to `null`): set rounding method for timestamps. (default: 5, possible values: 0 (zero), 1 (inf), 2 (down), 3 (up), 5 (near))
- `eof_action` (of type `int?`, which defaults to `null`): action performed for last frame. (default: 0, possible values: 0 (round), 1 (pass))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.framepack`

Ffmpeg filter: Generate a frame packed stereoscopic video.

Type:
```
(?format : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `format` (of type `int?`, which defaults to `null`): Frame pack output format. (default: 1, possible values: 1 (sbs), 2 (tab), 3 (frameseq), 6 (lines), 7 (columns))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.framerate`

Ffmpeg filter: Upsamples or downsamples progressive source between specified frame rates.

Type:
```
(?fps : string?, ?interp_start : int?,
 ?interp_end : int?, ?scene : float?, ?flags : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `fps` (of type `string?`, which defaults to `null`): required output frames per second rate. (default: 50)
- `interp_start` (of type `int?`, which defaults to `null`): point to start linear interpolation. (default: 15)
- `interp_end` (of type `int?`, which defaults to `null`): point to end linear interpolation. (default: 240)
- `scene` (of type `float?`, which defaults to `null`): scene change level. (default: 8.2)
- `flags` (of type `int?`, which defaults to `null`): set flags. (default: 1, possible values: 1 (scene_change_detect), 1 (scd))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.framestep`

Ffmpeg filter: Select one frame every N frames.

Type:
```
(?step : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `step` (of type `int?`, which defaults to `null`): set frame step. (default: 1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.freezedetect`

Ffmpeg filter: Detects frozen video input.

Type:
```
(?n : float?, ?noise : float?, ?d : int?,
 ?duration : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `n` (of type `float?`, which defaults to `null`): set noise tolerance. (default: 0.001)
- `noise` (of type `float?`, which defaults to `null`): set noise tolerance. (default: 0.001)
- `d` (of type `int?`, which defaults to `null`): set minimum duration in seconds. (default: 2000000)
- `duration` (of type `int?`, which defaults to `null`): set minimum duration in seconds. (default: 2000000)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.freezeframes`

Ffmpeg filter: Freeze video frames.

Type:
```
(?first : int?, ?last : int?, ?replace : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `first` (of type `int?`, which defaults to `null`): set first frame to freeze. (default: 0)
- `last` (of type `int?`, which defaults to `null`): set last frame to freeze. (default: 0)
- `replace` (of type `int?`, which defaults to `null`): set frame to replace. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.frei0r`

Ffmpeg filter: Apply a frei0r effect.

Type:
```
(?filter_name : string?, ?filter_params : string?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `filter_name` (of type `string?`, which defaults to `null`)
- `filter_params` (of type `string?`, which defaults to `null`)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.frei0r_src`

Ffmpeg filter: Generate a frei0r source.

Type:
```
(?size : string?, ?framerate : string?,
 ?filter_name : string?, ?filter_params : string?,
 ffmpeg.filter.graph) -> ffmpeg.filter.video
```

Arguments:

- `size` (of type `string?`, which defaults to `null`): Dimensions of the generated video.. (default: 320x240)
- `framerate` (of type `string?`, which defaults to `null`): Default: 25
- `filter_name` (of type `string?`, which defaults to `null`)
- `filter_params` (of type `string?`, which defaults to `null`)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.fspp`

Ffmpeg filter: Apply Fast Simple Post-processing filter.

Type:
```
(?quality : int?, ?qp : int?, ?strength : int?,
 ?use_bframe_qp : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `quality` (of type `int?`, which defaults to `null`): set quality. (default: 4)
- `qp` (of type `int?`, which defaults to `null`): force a constant quantizer parameter. (default: 0)
- `strength` (of type `int?`, which defaults to `null`): set filter strength. (default: 0)
- `use_bframe_qp` (of type `bool?`, which defaults to `null`): use B-frames' QP. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.gblur`

Ffmpeg filter: Apply Gaussian Blur filter.

Type:
```
(?sigma : float?, ?steps : int?, ?planes : int?,
 ?sigmaV : float?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `sigma` (of type `float?`, which defaults to `null`): set sigma. (default: 0.5)
- `steps` (of type `int?`, which defaults to `null`): set number of steps. (default: 1)
- `planes` (of type `int?`, which defaults to `null`): set planes to filter. (default: 15)
- `sigmaV` (of type `float?`, which defaults to `null`): set vertical sigma. (default: -1.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.geq`

Ffmpeg filter: Apply generic equation to each pixel.

Type:
```
(?lum_expr : string?, ?lum : string?, ?cb_expr : string?,
 ?cb : string?, ?cr_expr : string?, ?cr : string?,
 ?alpha_expr : string?, ?a : string?,
 ?red_expr : string?, ?r : string?,
 ?green_expr : string?, ?g : string?,
 ?blue_expr : string?, ?b : string?,
 ?interpolation : int?, ?i : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `lum_expr` (of type `string?`, which defaults to `null`): set luminance expression
- `lum` (of type `string?`, which defaults to `null`): set luminance expression
- `cb_expr` (of type `string?`, which defaults to `null`): set chroma blue expression
- `cb` (of type `string?`, which defaults to `null`): set chroma blue expression
- `cr_expr` (of type `string?`, which defaults to `null`): set chroma red expression
- `cr` (of type `string?`, which defaults to `null`): set chroma red expression
- `alpha_expr` (of type `string?`, which defaults to `null`): set alpha expression
- `a` (of type `string?`, which defaults to `null`): set alpha expression
- `red_expr` (of type `string?`, which defaults to `null`): set red expression
- `r` (of type `string?`, which defaults to `null`): set red expression
- `green_expr` (of type `string?`, which defaults to `null`): set green expression
- `g` (of type `string?`, which defaults to `null`): set green expression
- `blue_expr` (of type `string?`, which defaults to `null`): set blue expression
- `b` (of type `string?`, which defaults to `null`): set blue expression
- `interpolation` (of type `int?`, which defaults to `null`): set interpolation method. (default: 1, possible values: 0 (nearest), 0 (n), 1 (bilinear), 1 (b))
- `i` (of type `int?`, which defaults to `null`): set interpolation method. (default: 1, possible values: 0 (nearest), 0 (n), 1 (bilinear), 1 (b))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.gradfun`

Ffmpeg filter: Debands video quickly using gradients.

Type:
```
(?strength : float?, ?radius : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `strength` (of type `float?`, which defaults to `null`): The maximum amount by which the filter will change any one pixel.. (default: 1.2)
- `radius` (of type `int?`, which defaults to `null`): The neighborhood to fit the gradient to.. (default: 16)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.gradients`

Ffmpeg filter: Draw a gradients.

Type:
```
(?size : string?, ?s : string?, ?rate : string?,
 ?r : string?, ?c0 : string?, ?c1 : string?,
 ?c2 : string?, ?c3 : string?, ?c4 : string?,
 ?c5 : string?, ?c6 : string?, ?c7 : string?, ?x0 : int?,
 ?y0 : int?, ?x1 : int?, ?y1 : int?, ?nb_colors : int?,
 ?n : int?, ?seed : int?, ffmpeg.filter.graph) ->
ffmpeg.filter.video
```

Arguments:

- `size` (of type `string?`, which defaults to `null`): set frame size. (default: 640x480)
- `s` (of type `string?`, which defaults to `null`): set frame size. (default: 640x480)
- `rate` (of type `string?`, which defaults to `null`): set frame rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set frame rate. (default: 25)
- `c0` (of type `string?`, which defaults to `null`): set 1st color. (default: random)
- `c1` (of type `string?`, which defaults to `null`): set 2nd color. (default: random)
- `c2` (of type `string?`, which defaults to `null`): set 3rd color. (default: random)
- `c3` (of type `string?`, which defaults to `null`): set 4th color. (default: random)
- `c4` (of type `string?`, which defaults to `null`): set 5th color. (default: random)
- `c5` (of type `string?`, which defaults to `null`): set 6th color. (default: random)
- `c6` (of type `string?`, which defaults to `null`): set 7th color. (default: random)
- `c7` (of type `string?`, which defaults to `null`): set 8th color. (default: random)
- `x0` (of type `int?`, which defaults to `null`): set gradient line source x0. (default: -1)
- `y0` (of type `int?`, which defaults to `null`): set gradient line source y0. (default: -1)
- `x1` (of type `int?`, which defaults to `null`): set gradient line destination x1. (default: -1)
- `y1` (of type `int?`, which defaults to `null`): set gradient line destination y1. (default: -1)
- `nb_colors` (of type `int?`, which defaults to `null`): set the number of colors. (default: 2)
- `n` (of type `int?`, which defaults to `null`): set the number of colors. (default: 2)
- `seed` (of type `int?`, which defaults to `null`): set the seed. (default: -1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.graphmonitor`

Ffmpeg filter: Show various filtergraph stats.

Type:
```
(?size : string?, ?s : string?, ?opacity : float?,
 ?o : float?, ?mode : int?, ?m : int?, ?flags : int?,
 ?f : int?, ?rate : string?, ?r : string?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `size` (of type `string?`, which defaults to `null`): set monitor size. (default: hd720)
- `s` (of type `string?`, which defaults to `null`): set monitor size. (default: hd720)
- `opacity` (of type `float?`, which defaults to `null`): set video opacity. (default: 0.9)
- `o` (of type `float?`, which defaults to `null`): set video opacity. (default: 0.9)
- `mode` (of type `int?`, which defaults to `null`): set mode. (default: 0, possible values: 0 (full), 1 (compact))
- `m` (of type `int?`, which defaults to `null`): set mode. (default: 0, possible values: 0 (full), 1 (compact))
- `flags` (of type `int?`, which defaults to `null`): set flags. (default: 1, possible values: 1 (queue), 4 (frame_count_in), 2 (frame_count_out), 8 (pts), 16 (time), 32 (timebase), 64 (format), 128 (size), 256 (rate))
- `f` (of type `int?`, which defaults to `null`): set flags. (default: 1, possible values: 1 (queue), 4 (frame_count_in), 2 (frame_count_out), 8 (pts), 16 (time), 32 (timebase), 64 (format), 128 (size), 256 (rate))
- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.greyedge`

Ffmpeg filter: Estimates scene illumination by grey edge assumption.

Type:
```
(?difford : int?, ?minknorm : int?, ?sigma : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `difford` (of type `int?`, which defaults to `null`): set differentiation order. (default: 1)
- `minknorm` (of type `int?`, which defaults to `null`): set Minkowski norm. (default: 1)
- `sigma` (of type `float?`, which defaults to `null`): set sigma. (default: 1.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.haas`

Ffmpeg filter: Apply Haas Stereo Enhancer.

Type:
```
(?level_in : float?, ?level_out : float?,
 ?side_gain : float?, ?middle_source : int?,
 ?middle_phase : bool?, ?left_delay : float?,
 ?left_balance : float?, ?left_gain : float?,
 ?left_phase : bool?, ?right_delay : float?,
 ?right_balance : float?, ?right_gain : float?,
 ?right_phase : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `level_in` (of type `float?`, which defaults to `null`): set level in. (default: 1.)
- `level_out` (of type `float?`, which defaults to `null`): set level out. (default: 1.)
- `side_gain` (of type `float?`, which defaults to `null`): set side gain. (default: 1.)
- `middle_source` (of type `int?`, which defaults to `null`): set middle source. (default: 2, possible values: 0 (left), 1 (right), 2 (mid), 3 (side))
- `middle_phase` (of type `bool?`, which defaults to `null`): set middle phase. (default: false)
- `left_delay` (of type `float?`, which defaults to `null`): set left delay. (default: 2.05)
- `left_balance` (of type `float?`, which defaults to `null`): set left balance. (default: -1.)
- `left_gain` (of type `float?`, which defaults to `null`): set left gain. (default: 1.)
- `left_phase` (of type `bool?`, which defaults to `null`): set left phase. (default: false)
- `right_delay` (of type `float?`, which defaults to `null`): set right delay. (default: 2.12)
- `right_balance` (of type `float?`, which defaults to `null`): set right balance. (default: 1.)
- `right_gain` (of type `float?`, which defaults to `null`): set right gain. (default: 1.)
- `right_phase` (of type `bool?`, which defaults to `null`): set right phase. (default: true)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.haldclut`

Ffmpeg filter: Adjust colors using a Hald CLUT.

Type:
```
(?interp : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `interp` (of type `int?`, which defaults to `null`): select interpolation mode. (default: 2, possible values: 0 (nearest), 1 (trilinear), 2 (tetrahedral))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.haldclutsrc`

Ffmpeg filter: Provide an identity Hald CLUT.

Type:
```
(?level : int?, ?rate : string?, ?r : string?,
 ?duration : int?, ?d : int?, ?sar : string?,
 ffmpeg.filter.graph) -> ffmpeg.filter.video
```

Arguments:

- `level` (of type `int?`, which defaults to `null`): set level. (default: 6)
- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `duration` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `d` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `sar` (of type `string?`, which defaults to `null`): set video sample aspect ratio. (default: 1/1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.hdcd`

Ffmpeg filter: Apply High Definition Compatible Digital (HDCD) decoding.

Type:
```
(?disable_autoconvert : bool?, ?process_stereo : bool?,
 ?cdt_ms : int?, ?force_pe : bool?, ?analyze_mode : int?,
 ?bits_per_sample : int?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `disable_autoconvert` (of type `bool?`, which defaults to `null`): Disable any format conversion or resampling in the filter graph.. (default: true)
- `process_stereo` (of type `bool?`, which defaults to `null`): Process stereo channels together. Only apply target_gain when both channels match.. (default: true)
- `cdt_ms` (of type `int?`, which defaults to `null`): Code detect timer period in ms.. (default: 2000)
- `force_pe` (of type `bool?`, which defaults to `null`): Always extend peaks above -3dBFS even when PE is not signaled.. (default: false)
- `analyze_mode` (of type `int?`, which defaults to `null`): Replace audio with solid tone and signal some processing aspect in the amplitude.. (default: 0, possible values: 0 (off), 1 (lle), 2 (pe), 3 (cdt), 4 (tgm))
- `bits_per_sample` (of type `int?`, which defaults to `null`): Valid bits per sample (location of the true LSB).. (default: 16, possible values: 16 (16), 20 (20), 24 (24))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.headphone`

Ffmpeg filter: Apply headphone binaural spatialization with HRTFs in additional streams. This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime.

Type:
```
(?map : string?, ?gain : float?, ?lfe : float?,
 ?type : int?, ?size : int?, ?hrir : int?,
 ffmpeg.filter.graph, [ffmpeg.filter.audio],
 [ffmpeg.filter.video]) -> ffmpeg.filter.audio
```

Arguments:

- `map` (of type `string?`, which defaults to `null`): set channels convolution mappings
- `gain` (of type `float?`, which defaults to `null`): set gain in dB. (default: 0.)
- `lfe` (of type `float?`, which defaults to `null`): set lfe gain in dB. (default: 0.)
- `type` (of type `int?`, which defaults to `null`): set processing. (default: 1, possible values: 0 (time), 1 (freq))
- `size` (of type `int?`, which defaults to `null`): set frame size. (default: 1024)
- `hrir` (of type `int?`, which defaults to `null`): set hrir format. (default: 0, possible values: 0 (stereo), 1 (multich))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.hflip`

Ffmpeg filter: Horizontally flip the input video.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.highpass`

Ffmpeg filter: Apply a high-pass filter with 3dB point frequency.

Type:
```
(?frequency : float?, ?f : float?, ?width_type : int?,
 ?t : int?, ?width : float?, ?w : float?, ?poles : int?,
 ?p : int?, ?mix : float?, ?m : float?,
 ?channels : string?, ?c : string?, ?normalize : bool?,
 ?n : bool?, ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `frequency` (of type `float?`, which defaults to `null`): set frequency. (default: 3000.)
- `f` (of type `float?`, which defaults to `null`): set frequency. (default: 3000.)
- `width_type` (of type `int?`, which defaults to `null`): set filter-width type. (default: 3, possible values: 1 (h), 3 (q), 2 (o), 4 (s), 5 (k))
- `t` (of type `int?`, which defaults to `null`): set filter-width type. (default: 3, possible values: 1 (h), 3 (q), 2 (o), 4 (s), 5 (k))
- `width` (of type `float?`, which defaults to `null`): set width. (default: 0.707)
- `w` (of type `float?`, which defaults to `null`): set width. (default: 0.707)
- `poles` (of type `int?`, which defaults to `null`): set number of poles. (default: 2)
- `p` (of type `int?`, which defaults to `null`): set number of poles. (default: 2)
- `mix` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `m` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `channels` (of type `string?`, which defaults to `null`): set channels to filter
- `c` (of type `string?`, which defaults to `null`): set channels to filter
- `normalize` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: false)
- `n` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.highshelf`

Ffmpeg filter: Apply a high shelf filter.

Type:
```
(?frequency : float?, ?f : float?, ?width_type : int?,
 ?t : int?, ?width : float?, ?w : float?, ?gain : float?,
 ?g : float?, ?mix : float?, ?m : float?,
 ?channels : string?, ?c : string?, ?normalize : bool?,
 ?n : bool?, ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `frequency` (of type `float?`, which defaults to `null`): set central frequency. (default: 3000.)
- `f` (of type `float?`, which defaults to `null`): set central frequency. (default: 3000.)
- `width_type` (of type `int?`, which defaults to `null`): set filter-width type. (default: 3, possible values: 1 (h), 3 (q), 2 (o), 4 (s), 5 (k))
- `t` (of type `int?`, which defaults to `null`): set filter-width type. (default: 3, possible values: 1 (h), 3 (q), 2 (o), 4 (s), 5 (k))
- `width` (of type `float?`, which defaults to `null`): set shelf transition steep. (default: 0.5)
- `w` (of type `float?`, which defaults to `null`): set shelf transition steep. (default: 0.5)
- `gain` (of type `float?`, which defaults to `null`): set gain. (default: 0.)
- `g` (of type `float?`, which defaults to `null`): set gain. (default: 0.)
- `mix` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `m` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `channels` (of type `string?`, which defaults to `null`): set channels to filter
- `c` (of type `string?`, which defaults to `null`): set channels to filter
- `normalize` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: false)
- `n` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.hilbert`

Ffmpeg filter: Generate a Hilbert transform FIR coefficients.

Type:
```
(?sample_rate : int?, ?r : int?, ?taps : int?, ?t : int?,
 ?nb_samples : int?, ?n : int?, ?win_func : int?,
 ?w : int?, ffmpeg.filter.graph) -> ffmpeg.filter.audio
```

Arguments:

- `sample_rate` (of type `int?`, which defaults to `null`): set sample rate. (default: 44100)
- `r` (of type `int?`, which defaults to `null`): set sample rate. (default: 44100)
- `taps` (of type `int?`, which defaults to `null`): set number of taps. (default: 22051)
- `t` (of type `int?`, which defaults to `null`): set number of taps. (default: 22051)
- `nb_samples` (of type `int?`, which defaults to `null`): set the number of samples per requested frame. (default: 1024)
- `n` (of type `int?`, which defaults to `null`): set the number of samples per requested frame. (default: 1024)
- `win_func` (of type `int?`, which defaults to `null`): set window function. (default: 3, possible values: 0 (rect), 4 (bartlett), 1 (hanning), 2 (hamming), 3 (blackman), 5 (welch), 6 (flattop), 7 (bharris), 8 (bnuttall), 11 (bhann), 9 (sine), 10 (nuttall), 12 (lanczos), 13 (gauss), 14 (tukey), 15 (dolph), 16 (cauchy), 17 (parzen), 18 (poisson), 19 (bohman))
- `w` (of type `int?`, which defaults to `null`): set window function. (default: 3, possible values: 0 (rect), 4 (bartlett), 1 (hanning), 2 (hamming), 3 (blackman), 5 (welch), 6 (flattop), 7 (bharris), 8 (bnuttall), 11 (bhann), 9 (sine), 10 (nuttall), 12 (lanczos), 13 (gauss), 14 (tukey), 15 (dolph), 16 (cauchy), 17 (parzen), 18 (poisson), 19 (bohman))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.histeq`

Ffmpeg filter: Apply global color histogram equalization.

Type:
```
(?strength : float?, ?intensity : float?,
 ?antibanding : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `strength` (of type `float?`, which defaults to `null`): set the strength. (default: 0.2)
- `intensity` (of type `float?`, which defaults to `null`): set the intensity. (default: 0.21)
- `antibanding` (of type `int?`, which defaults to `null`): set the antibanding level. (default: 0, possible values: 0 (none), 1 (weak), 2 (strong))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.histogram`

Ffmpeg filter: Compute and draw a histogram.

Type:
```
(?level_height : int?, ?scale_height : int?,
 ?display_mode : int?, ?d : int?, ?levels_mode : int?,
 ?m : int?, ?components : int?, ?c : int?,
 ?fgopacity : float?, ?f : float?, ?bgopacity : float?,
 ?b : float?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `level_height` (of type `int?`, which defaults to `null`): set level height. (default: 200)
- `scale_height` (of type `int?`, which defaults to `null`): set scale height. (default: 12)
- `display_mode` (of type `int?`, which defaults to `null`): set display mode. (default: 2, possible values: 0 (overlay), 1 (parade), 2 (stack))
- `d` (of type `int?`, which defaults to `null`): set display mode. (default: 2, possible values: 0 (overlay), 1 (parade), 2 (stack))
- `levels_mode` (of type `int?`, which defaults to `null`): set levels mode. (default: 0, possible values: 0 (linear), 1 (logarithmic))
- `m` (of type `int?`, which defaults to `null`): set levels mode. (default: 0, possible values: 0 (linear), 1 (logarithmic))
- `components` (of type `int?`, which defaults to `null`): set color components to display. (default: 7)
- `c` (of type `int?`, which defaults to `null`): set color components to display. (default: 7)
- `fgopacity` (of type `float?`, which defaults to `null`): set foreground opacity. (default: 0.7)
- `f` (of type `float?`, which defaults to `null`): set foreground opacity. (default: 0.7)
- `bgopacity` (of type `float?`, which defaults to `null`): set background opacity. (default: 0.5)
- `b` (of type `float?`, which defaults to `null`): set background opacity. (default: 0.5)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.hqdn3d`

Ffmpeg filter: Apply a High Quality 3D Denoiser.

Type:
```
(?luma_spatial : float?, ?chroma_spatial : float?,
 ?luma_tmp : float?, ?chroma_tmp : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `luma_spatial` (of type `float?`, which defaults to `null`): spatial luma strength. (default: 0.)
- `chroma_spatial` (of type `float?`, which defaults to `null`): spatial chroma strength. (default: 0.)
- `luma_tmp` (of type `float?`, which defaults to `null`): temporal luma strength. (default: 0.)
- `chroma_tmp` (of type `float?`, which defaults to `null`): temporal chroma strength. (default: 0.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.hqx`

Ffmpeg filter: Scale the input by 2, 3 or 4 using the hq*x magnification algorithm.

Type:
```
(?n : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `n` (of type `int?`, which defaults to `null`): set scale factor. (default: 3)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.hstack`

Ffmpeg filter: Stack video inputs horizontally. This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime.

Type:
```
(?inputs : int?, ?shortest : bool?, ffmpeg.filter.graph,
 [ffmpeg.filter.audio], [ffmpeg.filter.video]) ->
ffmpeg.filter.video
```

Arguments:

- `inputs` (of type `int?`, which defaults to `null`): set number of inputs. (default: 2)
- `shortest` (of type `bool?`, which defaults to `null`): force termination when the shortest input terminates. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.hue`

Ffmpeg filter: Adjust the hue and saturation of the input video.

Type:
```
(?h : string?, ?s : string?, ?H : string?, ?b : string?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `h` (of type `string?`, which defaults to `null`): set the hue angle degrees expression
- `s` (of type `string?`, which defaults to `null`): set the saturation expression. (default: 1)
- `H` (of type `string?`, which defaults to `null`): set the hue angle radians expression
- `b` (of type `string?`, which defaults to `null`): set the brightness expression. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.hwdownload`

Ffmpeg filter: Download a hardware frame to a normal frame

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.hwmap`

Ffmpeg filter: Map hardware frames

Type:
```
(?mode : int?, ?derive_device : string?, ?reverse : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `mode` (of type `int?`, which defaults to `null`): Frame mapping mode. (default: 3, possible values: 1 (read), 2 (write), 4 (overwrite), 8 (direct))
- `derive_device` (of type `string?`, which defaults to `null`): Derive a new device of this type
- `reverse` (of type `int?`, which defaults to `null`): Map in reverse (create and allocate in the sink). (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.hwupload`

Ffmpeg filter: Upload a normal frame to a hardware frame

Type:
```
(?derive_device : string?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `derive_device` (of type `string?`, which defaults to `null`): Derive a new device of this type
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.hysteresis`

Ffmpeg filter: Grow first stream into second stream by connecting components.

Type:
```
(?planes : int?, ?threshold : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `planes` (of type `int?`, which defaults to `null`): set planes. (default: 15)
- `threshold` (of type `int?`, which defaults to `null`): set threshold. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.idet`

Ffmpeg filter: Interlace detect Filter.

Type:
```
(?intl_thres : float?, ?prog_thres : float?,
 ?rep_thres : float?, ?half_life : float?,
 ?analyze_interlaced_flag : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `intl_thres` (of type `float?`, which defaults to `null`): set interlacing threshold. (default: 1.04)
- `prog_thres` (of type `float?`, which defaults to `null`): set progressive threshold. (default: 1.5)
- `rep_thres` (of type `float?`, which defaults to `null`): set repeat threshold. (default: 3.)
- `half_life` (of type `float?`, which defaults to `null`): half life of cumulative statistics. (default: 0.)
- `analyze_interlaced_flag` (of type `int?`, which defaults to `null`): set number of frames to use to determine if the interlace flag is accurate. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.il`

Ffmpeg filter: Deinterleave or interleave fields.

Type:
```
(?luma_mode : int?, ?l : int?, ?chroma_mode : int?,
 ?c : int?, ?alpha_mode : int?, ?a : int?,
 ?luma_swap : bool?, ?ls : bool?, ?chroma_swap : bool?,
 ?cs : bool?, ?alpha_swap : bool?, ?as : bool?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `luma_mode` (of type `int?`, which defaults to `null`): select luma mode. (default: 0, possible values: 0 (none), 1 (interleave), 1 (i), 2 (deinterleave), 2 (d))
- `l` (of type `int?`, which defaults to `null`): select luma mode. (default: 0, possible values: 0 (none), 1 (interleave), 1 (i), 2 (deinterleave), 2 (d))
- `chroma_mode` (of type `int?`, which defaults to `null`): select chroma mode. (default: 0, possible values: 0 (none), 1 (interleave), 1 (i), 2 (deinterleave), 2 (d))
- `c` (of type `int?`, which defaults to `null`): select chroma mode. (default: 0, possible values: 0 (none), 1 (interleave), 1 (i), 2 (deinterleave), 2 (d))
- `alpha_mode` (of type `int?`, which defaults to `null`): select alpha mode. (default: 0, possible values: 0 (none), 1 (interleave), 1 (i), 2 (deinterleave), 2 (d))
- `a` (of type `int?`, which defaults to `null`): select alpha mode. (default: 0, possible values: 0 (none), 1 (interleave), 1 (i), 2 (deinterleave), 2 (d))
- `luma_swap` (of type `bool?`, which defaults to `null`): swap luma fields. (default: false)
- `ls` (of type `bool?`, which defaults to `null`): swap luma fields. (default: false)
- `chroma_swap` (of type `bool?`, which defaults to `null`): swap chroma fields. (default: false)
- `cs` (of type `bool?`, which defaults to `null`): swap chroma fields. (default: false)
- `alpha_swap` (of type `bool?`, which defaults to `null`): swap alpha fields. (default: false)
- `as` (of type `bool?`, which defaults to `null`): swap alpha fields. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.inflate`

Ffmpeg filter: Apply inflate effect.

Type:
```
(?threshold0 : int?, ?threshold1 : int?,
 ?threshold2 : int?, ?threshold3 : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `threshold0` (of type `int?`, which defaults to `null`): set threshold for 1st plane. (default: 65535)
- `threshold1` (of type `int?`, which defaults to `null`): set threshold for 2nd plane. (default: 65535)
- `threshold2` (of type `int?`, which defaults to `null`): set threshold for 3rd plane. (default: 65535)
- `threshold3` (of type `int?`, which defaults to `null`): set threshold for 4th plane. (default: 65535)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.interlace`

Ffmpeg filter: Convert progressive video into interlaced.

Type:
```
(?scan : int?, ?lowpass : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `scan` (of type `int?`, which defaults to `null`): scanning mode. (default: 0, possible values: 0 (tff), 1 (bff))
- `lowpass` (of type `int?`, which defaults to `null`): set vertical low-pass filter. (default: 1, possible values: 0 (off), 1 (linear), 2 (complex))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.interleave`

Ffmpeg filter: Temporally interleave video inputs. This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime.

Type:
```
(?nb_inputs : int?, ?n : int?, ?duration : int?,
 ffmpeg.filter.graph, [ffmpeg.filter.audio],
 [ffmpeg.filter.video]) -> ffmpeg.filter.video
```

Arguments:

- `nb_inputs` (of type `int?`, which defaults to `null`): set number of inputs. (default: 2)
- `n` (of type `int?`, which defaults to `null`): set number of inputs. (default: 2)
- `duration` (of type `int?`, which defaults to `null`): how to determine the end-of-stream. (default: 0, possible values: 0 (longest), 1 (shortest), 2 (first))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.join`

Ffmpeg filter: Join multiple audio streams into multi-channel output. This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime.

Type:
```
(?inputs : int?, ?channel_layout : string?,
 ?map : string?, ffmpeg.filter.graph,
 [ffmpeg.filter.audio], [ffmpeg.filter.video]) ->
ffmpeg.filter.audio
```

Arguments:

- `inputs` (of type `int?`, which defaults to `null`): Number of input streams.. (default: 2)
- `channel_layout` (of type `string?`, which defaults to `null`): Channel layout of the output stream.. (default: stereo)
- `map` (of type `string?`, which defaults to `null`): A comma-separated list of channels maps in the format 'input_stream.input_channel-output_channel.
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.kerndeint`

Ffmpeg filter: Apply kernel deinterlacing to the input.

Type:
```
(?thresh : int?, ?map : bool?, ?order : bool?,
 ?sharp : bool?, ?twoway : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `thresh` (of type `int?`, which defaults to `null`): set the threshold. (default: 10)
- `map` (of type `bool?`, which defaults to `null`): set the map. (default: false)
- `order` (of type `bool?`, which defaults to `null`): set the order. (default: false)
- `sharp` (of type `bool?`, which defaults to `null`): set sharpening. (default: false)
- `twoway` (of type `bool?`, which defaults to `null`): set twoway. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.ladspa`

Ffmpeg filter: Apply LADSPA effect. This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime.

Type:
```
(?file : string?, ?f : string?, ?plugin : string?,
 ?p : string?, ?controls : string?, ?c : string?,
 ?sample_rate : int?, ?s : int?, ?nb_samples : int?,
 ?n : int?, ?duration : int?, ?d : int?,
 ffmpeg.filter.graph, [ffmpeg.filter.audio],
 [ffmpeg.filter.video]) -> ffmpeg.filter.audio
```

Arguments:

- `file` (of type `string?`, which defaults to `null`): set library name or full path
- `f` (of type `string?`, which defaults to `null`): set library name or full path
- `plugin` (of type `string?`, which defaults to `null`): set plugin name
- `p` (of type `string?`, which defaults to `null`): set plugin name
- `controls` (of type `string?`, which defaults to `null`): set plugin options
- `c` (of type `string?`, which defaults to `null`): set plugin options
- `sample_rate` (of type `int?`, which defaults to `null`): set sample rate. (default: 44100)
- `s` (of type `int?`, which defaults to `null`): set sample rate. (default: 44100)
- `nb_samples` (of type `int?`, which defaults to `null`): set the number of samples per requested frame. (default: 1024)
- `n` (of type `int?`, which defaults to `null`): set the number of samples per requested frame. (default: 1024)
- `duration` (of type `int?`, which defaults to `null`): set audio duration. (default: -1)
- `d` (of type `int?`, which defaults to `null`): set audio duration. (default: -1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.lagfun`

Ffmpeg filter: Slowly update darker pixels.

Type:
```
(?decay : float?, ?planes : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `decay` (of type `float?`, which defaults to `null`): set decay. (default: 0.95)
- `planes` (of type `int?`, which defaults to `null`): set what planes to filter. (default: 15)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.lenscorrection`

Ffmpeg filter: Rectify the image by correcting for lens distortion.

Type:
```
(?cx : float?, ?cy : float?, ?k1 : float?, ?k2 : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `cx` (of type `float?`, which defaults to `null`): set relative center x. (default: 0.5)
- `cy` (of type `float?`, which defaults to `null`): set relative center y. (default: 0.5)
- `k1` (of type `float?`, which defaults to `null`): set quadratic distortion factor. (default: 0.)
- `k2` (of type `float?`, which defaults to `null`): set double quadratic distortion factor. (default: 0.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.life`

Ffmpeg filter: Create life.

Type:
```
(?filename : string?, ?f : string?, ?size : string?,
 ?s : string?, ?rate : string?, ?r : string?,
 ?rule : string?, ?random_fill_ratio : float?,
 ?ratio : float?, ?random_seed : int?, ?seed : int?,
 ?stitch : bool?, ?mold : int?, ?life_color : string?,
 ?death_color : string?, ?mold_color : string?,
 ffmpeg.filter.graph) -> ffmpeg.filter.video
```

Arguments:

- `filename` (of type `string?`, which defaults to `null`): set source file
- `f` (of type `string?`, which defaults to `null`): set source file
- `size` (of type `string?`, which defaults to `null`): set video size
- `s` (of type `string?`, which defaults to `null`): set video size
- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `rule` (of type `string?`, which defaults to `null`): set rule. (default: B3/S23)
- `random_fill_ratio` (of type `float?`, which defaults to `null`): set fill ratio for filling initial grid randomly. (default: 0.61803398875)
- `ratio` (of type `float?`, which defaults to `null`): set fill ratio for filling initial grid randomly. (default: 0.61803398875)
- `random_seed` (of type `int?`, which defaults to `null`): set the seed for filling the initial grid randomly. (default: -1)
- `seed` (of type `int?`, which defaults to `null`): set the seed for filling the initial grid randomly. (default: -1)
- `stitch` (of type `bool?`, which defaults to `null`): stitch boundaries. (default: true)
- `mold` (of type `int?`, which defaults to `null`): set mold speed for dead cells. (default: 0)
- `life_color` (of type `string?`, which defaults to `null`): set life color. (default: white)
- `death_color` (of type `string?`, which defaults to `null`): set death color. (default: black)
- `mold_color` (of type `string?`, which defaults to `null`): set mold color. (default: black)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.limiter`

Ffmpeg filter: Limit pixels components to the specified range.

Type:
```
(?min : int?, ?max : int?, ?planes : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `min` (of type `int?`, which defaults to `null`): set min value. (default: 0)
- `max` (of type `int?`, which defaults to `null`): set max value. (default: 65535)
- `planes` (of type `int?`, which defaults to `null`): set planes. (default: 15)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.loop`

Ffmpeg filter: Loop video frames.

Type:
```
(?loop : int?, ?size : int?, ?start : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `loop` (of type `int?`, which defaults to `null`): number of loops. (default: 0)
- `size` (of type `int?`, which defaults to `null`): max number of frames to loop. (default: 0)
- `start` (of type `int?`, which defaults to `null`): set the loop start frame. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.loudnorm`

Ffmpeg filter: EBU R128 loudness normalization

Type:
```
(?I : float?, ?i : float?, ?LRA : float?, ?lra : float?,
 ?TP : float?, ?tp : float?, ?measured_I : float?,
 ?measured_i : float?, ?measured_LRA : float?,
 ?measured_lra : float?, ?measured_TP : float?,
 ?measured_tp : float?, ?measured_thresh : float?,
 ?offset : float?, ?linear : bool?, ?dual_mono : bool?,
 ?print_format : int?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `I` (of type `float?`, which defaults to `null`): set integrated loudness target. (default: -24.)
- `i` (of type `float?`, which defaults to `null`): set integrated loudness target. (default: -24.)
- `LRA` (of type `float?`, which defaults to `null`): set loudness range target. (default: 7.)
- `lra` (of type `float?`, which defaults to `null`): set loudness range target. (default: 7.)
- `TP` (of type `float?`, which defaults to `null`): set maximum true peak. (default: -2.)
- `tp` (of type `float?`, which defaults to `null`): set maximum true peak. (default: -2.)
- `measured_I` (of type `float?`, which defaults to `null`): measured IL of input file. (default: 0.)
- `measured_i` (of type `float?`, which defaults to `null`): measured IL of input file. (default: 0.)
- `measured_LRA` (of type `float?`, which defaults to `null`): measured LRA of input file. (default: 0.)
- `measured_lra` (of type `float?`, which defaults to `null`): measured LRA of input file. (default: 0.)
- `measured_TP` (of type `float?`, which defaults to `null`): measured true peak of input file. (default: 99.)
- `measured_tp` (of type `float?`, which defaults to `null`): measured true peak of input file. (default: 99.)
- `measured_thresh` (of type `float?`, which defaults to `null`): measured threshold of input file. (default: -70.)
- `offset` (of type `float?`, which defaults to `null`): set offset gain. (default: 0.)
- `linear` (of type `bool?`, which defaults to `null`): normalize linearly if possible. (default: true)
- `dual_mono` (of type `bool?`, which defaults to `null`): treat mono input as dual-mono. (default: false)
- `print_format` (of type `int?`, which defaults to `null`): set print format for stats. (default: 0, possible values: 0 (none), 1 (json), 2 (summary))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.lowpass`

Ffmpeg filter: Apply a low-pass filter with 3dB point frequency.

Type:
```
(?frequency : float?, ?f : float?, ?width_type : int?,
 ?t : int?, ?width : float?, ?w : float?, ?poles : int?,
 ?p : int?, ?mix : float?, ?m : float?,
 ?channels : string?, ?c : string?, ?normalize : bool?,
 ?n : bool?, ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `frequency` (of type `float?`, which defaults to `null`): set frequency. (default: 500.)
- `f` (of type `float?`, which defaults to `null`): set frequency. (default: 500.)
- `width_type` (of type `int?`, which defaults to `null`): set filter-width type. (default: 3, possible values: 1 (h), 3 (q), 2 (o), 4 (s), 5 (k))
- `t` (of type `int?`, which defaults to `null`): set filter-width type. (default: 3, possible values: 1 (h), 3 (q), 2 (o), 4 (s), 5 (k))
- `width` (of type `float?`, which defaults to `null`): set width. (default: 0.707)
- `w` (of type `float?`, which defaults to `null`): set width. (default: 0.707)
- `poles` (of type `int?`, which defaults to `null`): set number of poles. (default: 2)
- `p` (of type `int?`, which defaults to `null`): set number of poles. (default: 2)
- `mix` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `m` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `channels` (of type `string?`, which defaults to `null`): set channels to filter
- `c` (of type `string?`, which defaults to `null`): set channels to filter
- `normalize` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: false)
- `n` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.lowshelf`

Ffmpeg filter: Apply a low shelf filter.

Type:
```
(?frequency : float?, ?f : float?, ?width_type : int?,
 ?t : int?, ?width : float?, ?w : float?, ?gain : float?,
 ?g : float?, ?mix : float?, ?m : float?,
 ?channels : string?, ?c : string?, ?normalize : bool?,
 ?n : bool?, ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `frequency` (of type `float?`, which defaults to `null`): set central frequency. (default: 100.)
- `f` (of type `float?`, which defaults to `null`): set central frequency. (default: 100.)
- `width_type` (of type `int?`, which defaults to `null`): set filter-width type. (default: 3, possible values: 1 (h), 3 (q), 2 (o), 4 (s), 5 (k))
- `t` (of type `int?`, which defaults to `null`): set filter-width type. (default: 3, possible values: 1 (h), 3 (q), 2 (o), 4 (s), 5 (k))
- `width` (of type `float?`, which defaults to `null`): set shelf transition steep. (default: 0.5)
- `w` (of type `float?`, which defaults to `null`): set shelf transition steep. (default: 0.5)
- `gain` (of type `float?`, which defaults to `null`): set gain. (default: 0.)
- `g` (of type `float?`, which defaults to `null`): set gain. (default: 0.)
- `mix` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `m` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `channels` (of type `string?`, which defaults to `null`): set channels to filter
- `c` (of type `string?`, which defaults to `null`): set channels to filter
- `normalize` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: false)
- `n` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.lumakey`

Ffmpeg filter: Turns a certain luma into transparency.

Type:
```
(?threshold : float?, ?tolerance : float?,
 ?softness : float?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `threshold` (of type `float?`, which defaults to `null`): set the threshold value. (default: 0.)
- `tolerance` (of type `float?`, which defaults to `null`): set the tolerance value. (default: 0.01)
- `softness` (of type `float?`, which defaults to `null`): set the softness value. (default: 0.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.lut`

Ffmpeg filter: Compute and apply a lookup table to the RGB/YUV input video.

Type:
```
(?c0 : string?, ?c1 : string?, ?c2 : string?,
 ?c3 : string?, ?y : string?, ?u : string?, ?v : string?,
 ?r : string?, ?g : string?, ?b : string?, ?a : string?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `c0` (of type `string?`, which defaults to `null`): set component #0 expression. (default: clipval)
- `c1` (of type `string?`, which defaults to `null`): set component #1 expression. (default: clipval)
- `c2` (of type `string?`, which defaults to `null`): set component #2 expression. (default: clipval)
- `c3` (of type `string?`, which defaults to `null`): set component #3 expression. (default: clipval)
- `y` (of type `string?`, which defaults to `null`): set Y expression. (default: clipval)
- `u` (of type `string?`, which defaults to `null`): set U expression. (default: clipval)
- `v` (of type `string?`, which defaults to `null`): set V expression. (default: clipval)
- `r` (of type `string?`, which defaults to `null`): set R expression. (default: clipval)
- `g` (of type `string?`, which defaults to `null`): set G expression. (default: clipval)
- `b` (of type `string?`, which defaults to `null`): set B expression. (default: clipval)
- `a` (of type `string?`, which defaults to `null`): set A expression. (default: clipval)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.lut1d`

Ffmpeg filter: Adjust colors using a 1D LUT.

Type:
```
(?file : string?, ?interp : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `file` (of type `string?`, which defaults to `null`): set 1D LUT file name
- `interp` (of type `int?`, which defaults to `null`): select interpolation mode. (default: 1, possible values: 0 (nearest), 1 (linear), 3 (cosine), 2 (cubic), 4 (spline))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.lut2`

Ffmpeg filter: Compute and apply a lookup table from two video inputs.

Type:
```
(?c0 : string?, ?c1 : string?, ?c2 : string?,
 ?c3 : string?, ?d : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `c0` (of type `string?`, which defaults to `null`): set component #0 expression. (default: x)
- `c1` (of type `string?`, which defaults to `null`): set component #1 expression. (default: x)
- `c2` (of type `string?`, which defaults to `null`): set component #2 expression. (default: x)
- `c3` (of type `string?`, which defaults to `null`): set component #3 expression. (default: x)
- `d` (of type `int?`, which defaults to `null`): set output depth. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.lut3d`

Ffmpeg filter: Adjust colors using a 3D LUT.

Type:
```
(?file : string?, ?interp : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `file` (of type `string?`, which defaults to `null`): set 3D LUT file name
- `interp` (of type `int?`, which defaults to `null`): select interpolation mode. (default: 2, possible values: 0 (nearest), 1 (trilinear), 2 (tetrahedral))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.lutrgb`

Ffmpeg filter: Compute and apply a lookup table to the RGB input video.

Type:
```
(?c0 : string?, ?c1 : string?, ?c2 : string?,
 ?c3 : string?, ?y : string?, ?u : string?, ?v : string?,
 ?r : string?, ?g : string?, ?b : string?, ?a : string?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `c0` (of type `string?`, which defaults to `null`): set component #0 expression. (default: clipval)
- `c1` (of type `string?`, which defaults to `null`): set component #1 expression. (default: clipval)
- `c2` (of type `string?`, which defaults to `null`): set component #2 expression. (default: clipval)
- `c3` (of type `string?`, which defaults to `null`): set component #3 expression. (default: clipval)
- `y` (of type `string?`, which defaults to `null`): set Y expression. (default: clipval)
- `u` (of type `string?`, which defaults to `null`): set U expression. (default: clipval)
- `v` (of type `string?`, which defaults to `null`): set V expression. (default: clipval)
- `r` (of type `string?`, which defaults to `null`): set R expression. (default: clipval)
- `g` (of type `string?`, which defaults to `null`): set G expression. (default: clipval)
- `b` (of type `string?`, which defaults to `null`): set B expression. (default: clipval)
- `a` (of type `string?`, which defaults to `null`): set A expression. (default: clipval)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.lutyuv`

Ffmpeg filter: Compute and apply a lookup table to the YUV input video.

Type:
```
(?c0 : string?, ?c1 : string?, ?c2 : string?,
 ?c3 : string?, ?y : string?, ?u : string?, ?v : string?,
 ?r : string?, ?g : string?, ?b : string?, ?a : string?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `c0` (of type `string?`, which defaults to `null`): set component #0 expression. (default: clipval)
- `c1` (of type `string?`, which defaults to `null`): set component #1 expression. (default: clipval)
- `c2` (of type `string?`, which defaults to `null`): set component #2 expression. (default: clipval)
- `c3` (of type `string?`, which defaults to `null`): set component #3 expression. (default: clipval)
- `y` (of type `string?`, which defaults to `null`): set Y expression. (default: clipval)
- `u` (of type `string?`, which defaults to `null`): set U expression. (default: clipval)
- `v` (of type `string?`, which defaults to `null`): set V expression. (default: clipval)
- `r` (of type `string?`, which defaults to `null`): set R expression. (default: clipval)
- `g` (of type `string?`, which defaults to `null`): set G expression. (default: clipval)
- `b` (of type `string?`, which defaults to `null`): set B expression. (default: clipval)
- `a` (of type `string?`, which defaults to `null`): set A expression. (default: clipval)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.lv2`

Ffmpeg filter: Apply LV2 effect. This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime.

Type:
```
(?plugin : string?, ?p : string?, ?controls : string?,
 ?c : string?, ?sample_rate : int?, ?s : int?,
 ?nb_samples : int?, ?n : int?, ?duration : int?,
 ?d : int?, ffmpeg.filter.graph, [ffmpeg.filter.audio],
 [ffmpeg.filter.video]) -> ffmpeg.filter.audio
```

Arguments:

- `plugin` (of type `string?`, which defaults to `null`): set plugin uri
- `p` (of type `string?`, which defaults to `null`): set plugin uri
- `controls` (of type `string?`, which defaults to `null`): set plugin options
- `c` (of type `string?`, which defaults to `null`): set plugin options
- `sample_rate` (of type `int?`, which defaults to `null`): set sample rate. (default: 44100)
- `s` (of type `int?`, which defaults to `null`): set sample rate. (default: 44100)
- `nb_samples` (of type `int?`, which defaults to `null`): set the number of samples per requested frame. (default: 1024)
- `n` (of type `int?`, which defaults to `null`): set the number of samples per requested frame. (default: 1024)
- `duration` (of type `int?`, which defaults to `null`): set audio duration. (default: -1)
- `d` (of type `int?`, which defaults to `null`): set audio duration. (default: -1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.mandelbrot`

Ffmpeg filter: Render a Mandelbrot fractal.

Type:
```
(?size : string?, ?s : string?, ?rate : string?,
 ?r : string?, ?maxiter : int?, ?start_x : float?,
 ?start_y : float?, ?start_scale : float?,
 ?end_scale : float?, ?end_pts : float?,
 ?bailout : float?, ?morphxf : float?, ?morphyf : float?,
 ?morphamp : float?, ?outer : int?, ?inner : int?,
 ffmpeg.filter.graph) -> ffmpeg.filter.video
```

Arguments:

- `size` (of type `string?`, which defaults to `null`): set frame size. (default: 640x480)
- `s` (of type `string?`, which defaults to `null`): set frame size. (default: 640x480)
- `rate` (of type `string?`, which defaults to `null`): set frame rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set frame rate. (default: 25)
- `maxiter` (of type `int?`, which defaults to `null`): set max iterations number. (default: 7189)
- `start_x` (of type `float?`, which defaults to `null`): set the initial x position. (default: -0.743643887037)
- `start_y` (of type `float?`, which defaults to `null`): set the initial y position. (default: -0.131825904205)
- `start_scale` (of type `float?`, which defaults to `null`): set the initial scale value. (default: 3.)
- `end_scale` (of type `float?`, which defaults to `null`): set the terminal scale value. (default: 0.3)
- `end_pts` (of type `float?`, which defaults to `null`): set the terminal pts value. (default: 400.)
- `bailout` (of type `float?`, which defaults to `null`): set the bailout value. (default: 10.)
- `morphxf` (of type `float?`, which defaults to `null`): set morph x frequency. (default: 0.01)
- `morphyf` (of type `float?`, which defaults to `null`): set morph y frequency. (default: 0.0123)
- `morphamp` (of type `float?`, which defaults to `null`): set morph amplitude. (default: 0.)
- `outer` (of type `int?`, which defaults to `null`): set outer coloring mode. (default: 1, possible values: 0 (iteration_count), 1 (normalized_iteration_count), 2 (white), 3 (outz))
- `inner` (of type `int?`, which defaults to `null`): set inner coloring mode. (default: 3, possible values: 0 (black), 1 (period), 2 (convergence), 3 (mincol))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.maskedclamp`

Ffmpeg filter: Clamp first stream with second stream and third stream.

Type:
```
(?undershoot : int?, ?overshoot : int?, ?planes : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video,
 ffmpeg.filter.video, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `undershoot` (of type `int?`, which defaults to `null`): set undershoot. (default: 0)
- `overshoot` (of type `int?`, which defaults to `null`): set overshoot. (default: 0)
- `planes` (of type `int?`, which defaults to `null`): set planes. (default: 15)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.maskedmax`

Ffmpeg filter: Apply filtering with maximum difference of two streams.

Type:
```
(?planes : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video, ffmpeg.filter.video,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `planes` (of type `int?`, which defaults to `null`): set planes. (default: 15)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.maskedmerge`

Ffmpeg filter: Merge first stream with second stream using third stream as mask.

Type:
```
(?planes : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video, ffmpeg.filter.video,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `planes` (of type `int?`, which defaults to `null`): set planes. (default: 15)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.maskedmin`

Ffmpeg filter: Apply filtering with minimum difference of two streams.

Type:
```
(?planes : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video, ffmpeg.filter.video,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `planes` (of type `int?`, which defaults to `null`): set planes. (default: 15)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.maskedthreshold`

Ffmpeg filter: Pick pixels comparing absolute difference of two streams with threshold.

Type:
```
(?threshold : int?, ?planes : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `threshold` (of type `int?`, which defaults to `null`): set threshold. (default: 1)
- `planes` (of type `int?`, which defaults to `null`): set planes. (default: 15)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.maskfun`

Ffmpeg filter: Create Mask.

Type:
```
(?low : int?, ?high : int?, ?planes : int?, ?fill : int?,
 ?sum : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `low` (of type `int?`, which defaults to `null`): set low threshold. (default: 10)
- `high` (of type `int?`, which defaults to `null`): set high threshold. (default: 10)
- `planes` (of type `int?`, which defaults to `null`): set planes. (default: 15)
- `fill` (of type `int?`, which defaults to `null`): set fill value. (default: 0)
- `sum` (of type `int?`, which defaults to `null`): set sum value. (default: 10)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.mcdeint`

Ffmpeg filter: Apply motion compensating deinterlacing.

Type:
```
(?mode : int?, ?parity : int?, ?qp : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `mode` (of type `int?`, which defaults to `null`): set mode. (default: 0, possible values: 0 (fast), 1 (medium), 2 (slow), 3 (extra_slow))
- `parity` (of type `int?`, which defaults to `null`): set the assumed picture field parity. (default: 1, possible values: 0 (tff), 1 (bff))
- `qp` (of type `int?`, which defaults to `null`): set qp. (default: 1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.mcompand`

Ffmpeg filter: Multiband Compress or expand audio dynamic range.

Type:
```
(?args : string?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `args` (of type `string?`, which defaults to `null`): set parameters for each band. (default: 0.005,0.1 6 -47/-40,-34/-34,-17/-33 100 | 0.003,0.05 6 -47/-40,-34/-34,-17/-33 400 | 0.000625,0.0125 6 -47/-40,-34/-34,-15/-33 1600 | 0.0001,0.025 6 -47/-40,-34/-34,-31/-31,-0/-30 6400 | 0,0.025 6 -38/-31,-28/-28,-0/-25 22000)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.median`

Ffmpeg filter: Apply Median filter.

Type:
```
(?radius : int?, ?planes : int?, ?radiusV : int?,
 ?percentile : float?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `radius` (of type `int?`, which defaults to `null`): set median radius. (default: 1)
- `planes` (of type `int?`, which defaults to `null`): set planes to filter. (default: 15)
- `radiusV` (of type `int?`, which defaults to `null`): set median vertical radius. (default: 0)
- `percentile` (of type `float?`, which defaults to `null`): set median percentile. (default: 0.5)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.mergeplanes`

Ffmpeg filter: Merge planes. This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime.

Type:
```
(?mapping : int?, ?format : string?, ffmpeg.filter.graph,
 [ffmpeg.filter.audio], [ffmpeg.filter.video]) ->
ffmpeg.filter.video
```

Arguments:

- `mapping` (of type `int?`, which defaults to `null`): set input to output plane mapping. (default: 0)
- `format` (of type `string?`, which defaults to `null`): set output pixel format. (default: yuva444p)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.mestimate`

Ffmpeg filter: Generate motion vectors.

Type:
```
(?method : int?, ?mb_size : int?, ?search_param : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `method` (of type `int?`, which defaults to `null`): motion estimation method. (default: 1, possible values: 1 (esa), 2 (tss), 3 (tdls), 4 (ntss), 5 (fss), 6 (ds), 7 (hexbs), 8 (epzs), 9 (umh))
- `mb_size` (of type `int?`, which defaults to `null`): macroblock size. (default: 16)
- `search_param` (of type `int?`, which defaults to `null`): search parameter. (default: 7)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.metadata`

Ffmpeg filter: Manipulate video frame metadata.

Type:
```
(?mode : int?, ?key : string?, ?value : string?,
 ?function : int?, ?expr : string?, ?file : string?,
 ?direct : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `mode` (of type `int?`, which defaults to `null`): set a mode of operation. (default: 0, possible values: 0 (select), 1 (add), 2 (modify), 3 (delete), 4 (print))
- `key` (of type `string?`, which defaults to `null`): set metadata key
- `value` (of type `string?`, which defaults to `null`): set metadata value
- `function` (of type `int?`, which defaults to `null`): function for comparing values. (default: 0, possible values: 0 (same_str), 1 (starts_with), 2 (less), 3 (equal), 4 (greater), 5 (expr), 6 (ends_with))
- `expr` (of type `string?`, which defaults to `null`): set expression for expr function
- `file` (of type `string?`, which defaults to `null`): set file where to print metadata information
- `direct` (of type `bool?`, which defaults to `null`): reduce buffering when printing to user-set file or pipe. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.midequalizer`

Ffmpeg filter: Apply Midway Equalization.

Type:
```
(?planes : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `planes` (of type `int?`, which defaults to `null`): set planes. (default: 15)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.minterpolate`

Ffmpeg filter: Frame rate conversion using Motion Interpolation.

Type:
```
(?fps : string?, ?mi_mode : int?, ?mc_mode : int?,
 ?me_mode : int?, ?me : int?, ?mb_size : int?,
 ?search_param : int?, ?vsbmc : int?, ?scd : int?,
 ?scd_threshold : float?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `fps` (of type `string?`, which defaults to `null`): output's frame rate. (default: 60)
- `mi_mode` (of type `int?`, which defaults to `null`): motion interpolation mode. (default: 2, possible values: 0 (dup), 1 (blend), 2 (mci))
- `mc_mode` (of type `int?`, which defaults to `null`): motion compensation mode. (default: 0, possible values: 0 (obmc), 1 (aobmc))
- `me_mode` (of type `int?`, which defaults to `null`): motion estimation mode. (default: 1, possible values: 0 (bidir), 1 (bilat))
- `me` (of type `int?`, which defaults to `null`): motion estimation method. (default: 8, possible values: 1 (esa), 2 (tss), 3 (tdls), 4 (ntss), 5 (fss), 6 (ds), 7 (hexbs), 8 (epzs), 9 (umh))
- `mb_size` (of type `int?`, which defaults to `null`): macroblock size. (default: 16)
- `search_param` (of type `int?`, which defaults to `null`): search parameter. (default: 32)
- `vsbmc` (of type `int?`, which defaults to `null`): variable-size block motion compensation. (default: 0)
- `scd` (of type `int?`, which defaults to `null`): scene change detection method. (default: 1, possible values: 0 (none), 1 (fdiff))
- `scd_threshold` (of type `float?`, which defaults to `null`): scene change threshold. (default: 10.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.mix`

Ffmpeg filter: Mix video inputs. This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime.

Type:
```
(?inputs : int?, ?weights : string?, ?scale : float?,
 ?duration : int?, ffmpeg.filter.graph,
 [ffmpeg.filter.audio], [ffmpeg.filter.video]) ->
ffmpeg.filter.video
```

Arguments:

- `inputs` (of type `int?`, which defaults to `null`): set number of inputs. (default: 2)
- `weights` (of type `string?`, which defaults to `null`): set weight for each input. (default: 1 1)
- `scale` (of type `float?`, which defaults to `null`): set scale. (default: 0.)
- `duration` (of type `int?`, which defaults to `null`): how to determine end of stream. (default: 0, possible values: 0 (longest), 1 (shortest), 2 (first))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.movie`

Ffmpeg filter: Read from a movie source. This filter has dynamic outputs: returned value is a tuple of audio and video outputs. Total number of outputs is determined at runtime.

Type:
```
(?filename : string?, ?format_name : string?,
 ?f : string?, ?stream_index : int?, ?si : int?,
 ?seek_point : float?, ?sp : float?, ?streams : string?,
 ?s : string?, ?loop : int?, ?discontinuity : int?,
 ffmpeg.filter.graph) ->
[ffmpeg.filter.audio] * [ffmpeg.filter.video]
```

Arguments:

- `filename` (of type `string?`, which defaults to `null`)
- `format_name` (of type `string?`, which defaults to `null`): set format name
- `f` (of type `string?`, which defaults to `null`): set format name
- `stream_index` (of type `int?`, which defaults to `null`): set stream index. (default: -1)
- `si` (of type `int?`, which defaults to `null`): set stream index. (default: -1)
- `seek_point` (of type `float?`, which defaults to `null`): set seekpoint (seconds). (default: 0.)
- `sp` (of type `float?`, which defaults to `null`): set seekpoint (seconds). (default: 0.)
- `streams` (of type `string?`, which defaults to `null`): set streams
- `s` (of type `string?`, which defaults to `null`): set streams
- `loop` (of type `int?`, which defaults to `null`): set loop count. (default: 1)
- `discontinuity` (of type `int?`, which defaults to `null`): set discontinuity threshold. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.mpdecimate`

Ffmpeg filter: Remove near-duplicate frames.

Type:
```
(?max : int?, ?hi : int?, ?lo : int?, ?frac : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `max` (of type `int?`, which defaults to `null`): set the maximum number of consecutive dropped frames (positive), or the minimum interval between dropped frames (negative). (default: 0)
- `hi` (of type `int?`, which defaults to `null`): set high dropping threshold. (default: 768)
- `lo` (of type `int?`, which defaults to `null`): set low dropping threshold. (default: 320)
- `frac` (of type `float?`, which defaults to `null`): set fraction dropping threshold. (default: 0.33)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.mptestsrc`

Ffmpeg filter: Generate various test pattern.

Type:
```
(?rate : string?, ?r : string?, ?duration : int?,
 ?d : int?, ?test : int?, ?t : int?, ?max_frames : int?,
 ?m : int?, ffmpeg.filter.graph) -> ffmpeg.filter.video
```

Arguments:

- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `duration` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `d` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `test` (of type `int?`, which defaults to `null`): set test to perform. (default: 10, possible values: 0 (dc_luma), 1 (dc_chroma), 2 (freq_luma), 3 (freq_chroma), 4 (amp_luma), 5 (amp_chroma), 6 (cbp), 7 (mv), 8 (ring1), 9 (ring2), 10 (all))
- `t` (of type `int?`, which defaults to `null`): set test to perform. (default: 10, possible values: 0 (dc_luma), 1 (dc_chroma), 2 (freq_luma), 3 (freq_chroma), 4 (amp_luma), 5 (amp_chroma), 6 (cbp), 7 (mv), 8 (ring1), 9 (ring2), 10 (all))
- `max_frames` (of type `int?`, which defaults to `null`): Set the maximum number of frames generated for each test. (default: 30)
- `m` (of type `int?`, which defaults to `null`): Set the maximum number of frames generated for each test. (default: 30)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.negate`

Ffmpeg filter: Negate input video.

Type:
```
(?negate_alpha : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `negate_alpha` (of type `bool?`, which defaults to `null`): Default: false
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.nlmeans`

Ffmpeg filter: Non-local means denoiser.

Type:
```
(?s : float?, ?p : int?, ?pc : int?, ?r : int?,
 ?rc : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `s` (of type `float?`, which defaults to `null`): denoising strength. (default: 1.)
- `p` (of type `int?`, which defaults to `null`): patch size. (default: 7)
- `pc` (of type `int?`, which defaults to `null`): patch size for chroma planes. (default: 0)
- `r` (of type `int?`, which defaults to `null`): research window. (default: 15)
- `rc` (of type `int?`, which defaults to `null`): research window for chroma planes. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.nlmeans_opencl`

Ffmpeg filter: Non-local means denoiser through OpenCL

Type:
```
(?s : float?, ?p : int?, ?pc : int?, ?r : int?,
 ?rc : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `s` (of type `float?`, which defaults to `null`): denoising strength. (default: 1.)
- `p` (of type `int?`, which defaults to `null`): patch size. (default: 7)
- `pc` (of type `int?`, which defaults to `null`): patch size for chroma planes. (default: 0)
- `r` (of type `int?`, which defaults to `null`): research window. (default: 15)
- `rc` (of type `int?`, which defaults to `null`): research window for chroma planes. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.nnedi`

Ffmpeg filter: Apply neural network edge directed interpolation intra-only deinterlacer.

Type:
```
(?weights : string?, ?deint : int?, ?field : int?,
 ?planes : int?, ?nsize : int?, ?nns : int?,
 ?qual : int?, ?etype : int?, ?pscrn : int?,
 ?fapprox : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `weights` (of type `string?`, which defaults to `null`): set weights file. (default: nnedi3_weights.bin)
- `deint` (of type `int?`, which defaults to `null`): set which frames to deinterlace. (default: 0, possible values: 0 (all), 1 (interlaced))
- `field` (of type `int?`, which defaults to `null`): set mode of operation. (default: -1, possible values: -2 (af), -1 (a), 0 (t), 1 (b), 2 (tf), 3 (bf))
- `planes` (of type `int?`, which defaults to `null`): set which planes to process. (default: 7)
- `nsize` (of type `int?`, which defaults to `null`): set size of local neighborhood around each pixel, used by the predictor neural network. (default: 6, possible values: 0 (s8x6), 1 (s16x6), 2 (s32x6), 3 (s48x6), 4 (s8x4), 5 (s16x4), 6 (s32x4))
- `nns` (of type `int?`, which defaults to `null`): set number of neurons in predictor neural network. (default: 1, possible values: 0 (n16), 1 (n32), 2 (n64), 3 (n128), 4 (n256))
- `qual` (of type `int?`, which defaults to `null`): set quality. (default: 1, possible values: 1 (fast), 2 (slow))
- `etype` (of type `int?`, which defaults to `null`): set which set of weights to use in the predictor. (default: 0, possible values: 0 (a), 1 (s))
- `pscrn` (of type `int?`, which defaults to `null`): set prescreening. (default: 2, possible values: 0 (none), 1 (original), 2 (new))
- `fapprox` (of type `int?`, which defaults to `null`): Default: 0
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.noformat`

Ffmpeg filter: Force libavfilter not to use any of the specified pixel formats for the input to the next filter.

Type:
```
(?pix_fmts : string?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `pix_fmts` (of type `string?`, which defaults to `null`): A '|'-separated list of pixel formats
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.noise`

Ffmpeg filter: Add noise.

Type:
```
(?all_seed : int?, ?all_strength : int?, ?alls : int?,
 ?all_flags : int?, ?allf : int?, ?c0_seed : int?,
 ?c0_strength : int?, ?c0s : int?, ?c0_flags : int?,
 ?c0f : int?, ?c1_seed : int?, ?c1_strength : int?,
 ?c1s : int?, ?c1_flags : int?, ?c1f : int?,
 ?c2_seed : int?, ?c2_strength : int?, ?c2s : int?,
 ?c2_flags : int?, ?c2f : int?, ?c3_seed : int?,
 ?c3_strength : int?, ?c3s : int?, ?c3_flags : int?,
 ?c3f : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `all_seed` (of type `int?`, which defaults to `null`): set component #0 noise seed. (default: -1)
- `all_strength` (of type `int?`, which defaults to `null`): set component #0 strength. (default: 0)
- `alls` (of type `int?`, which defaults to `null`): set component #0 strength. (default: 0)
- `all_flags` (of type `int?`, which defaults to `null`): set component #0 flags. (default: 0, possible values: 8 (a), 16 (p), 2 (t), 1 (u))
- `allf` (of type `int?`, which defaults to `null`): set component #0 flags. (default: 0, possible values: 8 (a), 16 (p), 2 (t), 1 (u))
- `c0_seed` (of type `int?`, which defaults to `null`): set component #0 noise seed. (default: -1)
- `c0_strength` (of type `int?`, which defaults to `null`): set component #0 strength. (default: 0)
- `c0s` (of type `int?`, which defaults to `null`): set component #0 strength. (default: 0)
- `c0_flags` (of type `int?`, which defaults to `null`): set component #0 flags. (default: 0, possible values: 8 (a), 16 (p), 2 (t), 1 (u))
- `c0f` (of type `int?`, which defaults to `null`): set component #0 flags. (default: 0, possible values: 8 (a), 16 (p), 2 (t), 1 (u))
- `c1_seed` (of type `int?`, which defaults to `null`): set component #1 noise seed. (default: -1)
- `c1_strength` (of type `int?`, which defaults to `null`): set component #1 strength. (default: 0)
- `c1s` (of type `int?`, which defaults to `null`): set component #1 strength. (default: 0)
- `c1_flags` (of type `int?`, which defaults to `null`): set component #1 flags. (default: 0, possible values: 8 (a), 16 (p), 2 (t), 1 (u))
- `c1f` (of type `int?`, which defaults to `null`): set component #1 flags. (default: 0, possible values: 8 (a), 16 (p), 2 (t), 1 (u))
- `c2_seed` (of type `int?`, which defaults to `null`): set component #2 noise seed. (default: -1)
- `c2_strength` (of type `int?`, which defaults to `null`): set component #2 strength. (default: 0)
- `c2s` (of type `int?`, which defaults to `null`): set component #2 strength. (default: 0)
- `c2_flags` (of type `int?`, which defaults to `null`): set component #2 flags. (default: 0, possible values: 8 (a), 16 (p), 2 (t), 1 (u))
- `c2f` (of type `int?`, which defaults to `null`): set component #2 flags. (default: 0, possible values: 8 (a), 16 (p), 2 (t), 1 (u))
- `c3_seed` (of type `int?`, which defaults to `null`): set component #3 noise seed. (default: -1)
- `c3_strength` (of type `int?`, which defaults to `null`): set component #3 strength. (default: 0)
- `c3s` (of type `int?`, which defaults to `null`): set component #3 strength. (default: 0)
- `c3_flags` (of type `int?`, which defaults to `null`): set component #3 flags. (default: 0, possible values: 8 (a), 16 (p), 2 (t), 1 (u))
- `c3f` (of type `int?`, which defaults to `null`): set component #3 flags. (default: 0, possible values: 8 (a), 16 (p), 2 (t), 1 (u))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.normalize`

Ffmpeg filter: Normalize RGB video.

Type:
```
(?blackpt : string?, ?whitept : string?,
 ?smoothing : int?, ?independence : float?,
 ?strength : float?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `blackpt` (of type `string?`, which defaults to `null`): output color to which darkest input color is mapped. (default: black)
- `whitept` (of type `string?`, which defaults to `null`): output color to which brightest input color is mapped. (default: white)
- `smoothing` (of type `int?`, which defaults to `null`): amount of temporal smoothing of the input range, to reduce flicker. (default: 0)
- `independence` (of type `float?`, which defaults to `null`): proportion of independent to linked channel normalization. (default: 1.)
- `strength` (of type `float?`, which defaults to `null`): strength of filter, from no effect to full normalization. (default: 1.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.null`

Ffmpeg filter: Pass the source unchanged to the output.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.nullsink`

Ffmpeg filter: Do absolutely nothing with the input video.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.video) -> unit
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.nullsrc`

Ffmpeg filter: Null video source, return unprocessed video frames.

Type:
```
(?size : string?, ?s : string?, ?rate : string?,
 ?r : string?, ?duration : int?, ?d : int?,
 ?sar : string?, ffmpeg.filter.graph) ->
ffmpeg.filter.video
```

Arguments:

- `size` (of type `string?`, which defaults to `null`): set video size. (default: 320x240)
- `s` (of type `string?`, which defaults to `null`): set video size. (default: 320x240)
- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `duration` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `d` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `sar` (of type `string?`, which defaults to `null`): set video sample aspect ratio. (default: 1/1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.openclsrc`

Ffmpeg filter: Generate video using an OpenCL program

Type:
```
(?source : string?, ?kernel : string?, ?size : string?,
 ?s : string?, ?format : string?, ?rate : string?,
 ?r : string?, ffmpeg.filter.graph) ->
ffmpeg.filter.video
```

Arguments:

- `source` (of type `string?`, which defaults to `null`): OpenCL program source file
- `kernel` (of type `string?`, which defaults to `null`): Kernel name in program
- `size` (of type `string?`, which defaults to `null`): Video size
- `s` (of type `string?`, which defaults to `null`): Video size
- `format` (of type `string?`, which defaults to `null`): Video format
- `rate` (of type `string?`, which defaults to `null`): Video frame rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): Video frame rate. (default: 25)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.oscilloscope`

Ffmpeg filter: 2D Video Oscilloscope.

Type:
```
(?x : float?, ?y : float?, ?s : float?, ?t : float?,
 ?o : float?, ?tx : float?, ?ty : float?, ?tw : float?,
 ?th : float?, ?c : int?, ?g : bool?, ?st : bool?,
 ?sc : bool?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `x` (of type `float?`, which defaults to `null`): set scope x position. (default: 0.5)
- `y` (of type `float?`, which defaults to `null`): set scope y position. (default: 0.5)
- `s` (of type `float?`, which defaults to `null`): set scope size. (default: 0.8)
- `t` (of type `float?`, which defaults to `null`): set scope tilt. (default: 0.5)
- `o` (of type `float?`, which defaults to `null`): set trace opacity. (default: 0.8)
- `tx` (of type `float?`, which defaults to `null`): set trace x position. (default: 0.5)
- `ty` (of type `float?`, which defaults to `null`): set trace y position. (default: 0.9)
- `tw` (of type `float?`, which defaults to `null`): set trace width. (default: 0.8)
- `th` (of type `float?`, which defaults to `null`): set trace height. (default: 0.3)
- `c` (of type `int?`, which defaults to `null`): set components to trace. (default: 7)
- `g` (of type `bool?`, which defaults to `null`): draw trace grid. (default: true)
- `st` (of type `bool?`, which defaults to `null`): draw statistics. (default: true)
- `sc` (of type `bool?`, which defaults to `null`): draw scope. (default: true)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.overlay`

Ffmpeg filter: Overlay a video source on top of the input.

Type:
```
(?x : string?, ?y : string?, ?eof_action : int?,
 ?eval : int?, ?shortest : bool?, ?format : int?,
 ?repeatlast : bool?, ?alpha : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `x` (of type `string?`, which defaults to `null`): set the x expression. (default: 0)
- `y` (of type `string?`, which defaults to `null`): set the y expression. (default: 0)
- `eof_action` (of type `int?`, which defaults to `null`): Action to take when encountering EOF from secondary input . (default: 0, possible values: 0 (repeat), 1 (endall), 2 (pass))
- `eval` (of type `int?`, which defaults to `null`): specify when to evaluate expressions. (default: 1, possible values: 0 (init), 1 (frame))
- `shortest` (of type `bool?`, which defaults to `null`): force termination when the shortest input terminates. (default: false)
- `format` (of type `int?`, which defaults to `null`): set output format. (default: 0, possible values: 0 (yuv420), 1 (yuv422), 2 (yuv444), 3 (rgb), 4 (gbrp), 5 (auto))
- `repeatlast` (of type `bool?`, which defaults to `null`): repeat overlay of the last overlay frame. (default: true)
- `alpha` (of type `int?`, which defaults to `null`): alpha format. (default: 0, possible values: 0 (straight), 1 (premultiplied))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.overlay_opencl`

Ffmpeg filter: Overlay one video on top of another

Type:
```
(?x : int?, ?y : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `x` (of type `int?`, which defaults to `null`): Overlay x position. (default: 0)
- `y` (of type `int?`, which defaults to `null`): Overlay y position. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.overlay_qsv`

Ffmpeg filter: Quick Sync Video overlay.

Type:
```
(?x : string?, ?y : string?, ?w : string?, ?h : string?,
 ?alpha : int?, ?eof_action : int?, ?shortest : bool?,
 ?repeatlast : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.video, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `x` (of type `string?`, which defaults to `null`): Overlay x position. (default: 0)
- `y` (of type `string?`, which defaults to `null`): Overlay y position. (default: 0)
- `w` (of type `string?`, which defaults to `null`): Overlay width. (default: overlay_iw)
- `h` (of type `string?`, which defaults to `null`): Overlay height. (default: overlay_ih*w/overlay_iw)
- `alpha` (of type `int?`, which defaults to `null`): Overlay global alpha. (default: 255)
- `eof_action` (of type `int?`, which defaults to `null`): Action to take when encountering EOF from secondary input . (default: 0, possible values: 0 (repeat), 1 (endall), 2 (pass))
- `shortest` (of type `bool?`, which defaults to `null`): force termination when the shortest input terminates. (default: false)
- `repeatlast` (of type `bool?`, which defaults to `null`): repeat overlay of the last overlay frame. (default: true)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.owdenoise`

Ffmpeg filter: Denoise using wavelets.

Type:
```
(?depth : int?, ?luma_strength : float?, ?ls : float?,
 ?chroma_strength : float?, ?cs : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `depth` (of type `int?`, which defaults to `null`): set depth. (default: 8)
- `luma_strength` (of type `float?`, which defaults to `null`): set luma strength. (default: 1.)
- `ls` (of type `float?`, which defaults to `null`): set luma strength. (default: 1.)
- `chroma_strength` (of type `float?`, which defaults to `null`): set chroma strength. (default: 1.)
- `cs` (of type `float?`, which defaults to `null`): set chroma strength. (default: 1.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.pad`

Ffmpeg filter: Pad the input video.

Type:
```
(?width : string?, ?w : string?, ?height : string?,
 ?h : string?, ?x : string?, ?y : string?,
 ?color : string?, ?eval : int?, ?aspect : string?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `width` (of type `string?`, which defaults to `null`): set the pad area width expression. (default: iw)
- `w` (of type `string?`, which defaults to `null`): set the pad area width expression. (default: iw)
- `height` (of type `string?`, which defaults to `null`): set the pad area height expression. (default: ih)
- `h` (of type `string?`, which defaults to `null`): set the pad area height expression. (default: ih)
- `x` (of type `string?`, which defaults to `null`): set the x offset expression for the input image position. (default: 0)
- `y` (of type `string?`, which defaults to `null`): set the y offset expression for the input image position. (default: 0)
- `color` (of type `string?`, which defaults to `null`): set the color of the padded area border. (default: black)
- `eval` (of type `int?`, which defaults to `null`): specify when to evaluate expressions. (default: 0, possible values: 0 (init), 1 (frame))
- `aspect` (of type `string?`, which defaults to `null`): pad to fit an aspect instead of a resolution. (default: 0/1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.pad_opencl`

Ffmpeg filter: Pad the input video.

Type:
```
(?width : string?, ?w : string?, ?height : string?,
 ?h : string?, ?x : string?, ?y : string?,
 ?color : string?, ?aspect : string?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `width` (of type `string?`, which defaults to `null`): set the pad area width. (default: iw)
- `w` (of type `string?`, which defaults to `null`): set the pad area width. (default: iw)
- `height` (of type `string?`, which defaults to `null`): set the pad area height. (default: ih)
- `h` (of type `string?`, which defaults to `null`): set the pad area height. (default: ih)
- `x` (of type `string?`, which defaults to `null`): set the x offset for the input image position. (default: 0)
- `y` (of type `string?`, which defaults to `null`): set the y offset for the input image position. (default: 0)
- `color` (of type `string?`, which defaults to `null`): set the color of the padded area border. (default: black)
- `aspect` (of type `string?`, which defaults to `null`): pad to fit an aspect instead of a resolution. (default: 0/1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.pal100bars`

Ffmpeg filter: Generate PAL 100% color bars.

Type:
```
(?size : string?, ?s : string?, ?rate : string?,
 ?r : string?, ?duration : int?, ?d : int?,
 ?sar : string?, ffmpeg.filter.graph) ->
ffmpeg.filter.video
```

Arguments:

- `size` (of type `string?`, which defaults to `null`): set video size. (default: 320x240)
- `s` (of type `string?`, which defaults to `null`): set video size. (default: 320x240)
- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `duration` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `d` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `sar` (of type `string?`, which defaults to `null`): set video sample aspect ratio. (default: 1/1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.pal75bars`

Ffmpeg filter: Generate PAL 75% color bars.

Type:
```
(?size : string?, ?s : string?, ?rate : string?,
 ?r : string?, ?duration : int?, ?d : int?,
 ?sar : string?, ffmpeg.filter.graph) ->
ffmpeg.filter.video
```

Arguments:

- `size` (of type `string?`, which defaults to `null`): set video size. (default: 320x240)
- `s` (of type `string?`, which defaults to `null`): set video size. (default: 320x240)
- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `duration` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `d` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `sar` (of type `string?`, which defaults to `null`): set video sample aspect ratio. (default: 1/1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.palettegen`

Ffmpeg filter: Find the optimal palette for a given stream.

Type:
```
(?max_colors : int?, ?reserve_transparent : bool?,
 ?transparency_color : string?, ?stats_mode : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `max_colors` (of type `int?`, which defaults to `null`): set the maximum number of colors to use in the palette. (default: 256)
- `reserve_transparent` (of type `bool?`, which defaults to `null`): reserve a palette entry for transparency. (default: true)
- `transparency_color` (of type `string?`, which defaults to `null`): set a background color for transparency. (default: lime)
- `stats_mode` (of type `int?`, which defaults to `null`): set statistics mode. (default: 0, possible values: 0 (full), 1 (diff), 2 (single))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.paletteuse`

Ffmpeg filter: Use a palette to downsample an input video stream.

Type:
```
(?dither : int?, ?bayer_scale : int?, ?diff_mode : int?,
 ?new : bool?, ?alpha_threshold : int?,
 ?debug_kdtree : string?, ?color_search : int?,
 ?mean_err : bool?, ?debug_accuracy : bool?,
 ffmpeg.filter.graph, ffmpeg.filter.video,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `dither` (of type `int?`, which defaults to `null`): select dithering mode. (default: 5, possible values: 1 (bayer), 2 (heckbert), 3 (floyd_steinberg), 4 (sierra2), 5 (sierra2_4a))
- `bayer_scale` (of type `int?`, which defaults to `null`): set scale for bayer dithering. (default: 2)
- `diff_mode` (of type `int?`, which defaults to `null`): set frame difference mode. (default: 0, possible values: 1 (rectangle))
- `new` (of type `bool?`, which defaults to `null`): take new palette for each output frame. (default: false)
- `alpha_threshold` (of type `int?`, which defaults to `null`): set the alpha threshold for transparency. (default: 128)
- `debug_kdtree` (of type `string?`, which defaults to `null`): save Graphviz graph of the kdtree in specified file
- `color_search` (of type `int?`, which defaults to `null`): set reverse colormap color search method. (default: 0, possible values: 0 (nns_iterative), 1 (nns_recursive), 2 (bruteforce))
- `mean_err` (of type `bool?`, which defaults to `null`): compute and print mean error. (default: false)
- `debug_accuracy` (of type `bool?`, which defaults to `null`): test color search accuracy. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.pan`

Ffmpeg filter: Remix channels with coefficients (panning).

Type:
```
(?args : string?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `args` (of type `string?`, which defaults to `null`)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.perms`

Ffmpeg filter: Set permissions for the output video frame.

Type:
```
(?mode : int?, ?seed : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `mode` (of type `int?`, which defaults to `null`): select permissions mode. (default: 0, possible values: 0 (none), 1 (ro), 2 (rw), 3 (toggle), 4 (random))
- `seed` (of type `int?`, which defaults to `null`): set the seed for the random mode. (default: -1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.perspective`

Ffmpeg filter: Correct the perspective of video.

Type:
```
(?x0 : string?, ?y0 : string?, ?x1 : string?,
 ?y1 : string?, ?x2 : string?, ?y2 : string?,
 ?x3 : string?, ?y3 : string?, ?interpolation : int?,
 ?sense : int?, ?eval : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `x0` (of type `string?`, which defaults to `null`): set top left x coordinate. (default: 0)
- `y0` (of type `string?`, which defaults to `null`): set top left y coordinate. (default: 0)
- `x1` (of type `string?`, which defaults to `null`): set top right x coordinate. (default: W)
- `y1` (of type `string?`, which defaults to `null`): set top right y coordinate. (default: 0)
- `x2` (of type `string?`, which defaults to `null`): set bottom left x coordinate. (default: 0)
- `y2` (of type `string?`, which defaults to `null`): set bottom left y coordinate. (default: H)
- `x3` (of type `string?`, which defaults to `null`): set bottom right x coordinate. (default: W)
- `y3` (of type `string?`, which defaults to `null`): set bottom right y coordinate. (default: H)
- `interpolation` (of type `int?`, which defaults to `null`): set interpolation. (default: 0, possible values: 0 (linear), 1 (cubic))
- `sense` (of type `int?`, which defaults to `null`): specify the sense of the coordinates. (default: 0, possible values: 0 (source), 1 (destination))
- `eval` (of type `int?`, which defaults to `null`): specify when to evaluate expressions. (default: 0, possible values: 0 (init), 1 (frame))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.phase`

Ffmpeg filter: Phase shift fields.

Type:
```
(?mode : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `mode` (of type `int?`, which defaults to `null`): set phase mode. (default: 8, possible values: 0 (p), 1 (t), 2 (b), 3 (T), 4 (B), 5 (u), 6 (U), 7 (a), 8 (A))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.photosensitivity`

Ffmpeg filter: Filter out photosensitive epilepsy seizure-inducing flashes.

Type:
```
(?frames : int?, ?f : int?, ?threshold : float?,
 ?t : float?, ?skip : int?, ?bypass : bool?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `frames` (of type `int?`, which defaults to `null`): set how many frames to use. (default: 30)
- `f` (of type `int?`, which defaults to `null`): set how many frames to use. (default: 30)
- `threshold` (of type `float?`, which defaults to `null`): set detection threshold factor (lower is stricter). (default: 1.)
- `t` (of type `float?`, which defaults to `null`): set detection threshold factor (lower is stricter). (default: 1.)
- `skip` (of type `int?`, which defaults to `null`): set pixels to skip when sampling frames. (default: 1)
- `bypass` (of type `bool?`, which defaults to `null`): leave frames unchanged. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.pixdesctest`

Ffmpeg filter: Test pixel format definitions.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.pixscope`

Ffmpeg filter: Pixel data analysis.

Type:
```
(?x : float?, ?y : float?, ?w : int?, ?h : int?,
 ?o : float?, ?wx : float?, ?wy : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `x` (of type `float?`, which defaults to `null`): set scope x offset. (default: 0.5)
- `y` (of type `float?`, which defaults to `null`): set scope y offset. (default: 0.5)
- `w` (of type `int?`, which defaults to `null`): set scope width. (default: 7)
- `h` (of type `int?`, which defaults to `null`): set scope height. (default: 7)
- `o` (of type `float?`, which defaults to `null`): set window opacity. (default: 0.5)
- `wx` (of type `float?`, which defaults to `null`): set window x offset. (default: -1.)
- `wy` (of type `float?`, which defaults to `null`): set window y offset. (default: -1.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.pp`

Ffmpeg filter: Filter video using libpostproc.

Type:
```
(?subfilters : string?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `subfilters` (of type `string?`, which defaults to `null`): set postprocess subfilters. (default: de)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.pp7`

Ffmpeg filter: Apply Postprocessing 7 filter.

Type:
```
(?qp : int?, ?mode : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `qp` (of type `int?`, which defaults to `null`): force a constant quantizer parameter. (default: 0)
- `mode` (of type `int?`, which defaults to `null`): set thresholding mode. (default: 2, possible values: 0 (hard), 1 (soft), 2 (medium))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.premultiply`

Ffmpeg filter: PreMultiply first stream with first plane of second stream. This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime.

Type:
```
(?planes : int?, ?inplace : bool?, ffmpeg.filter.graph,
 [ffmpeg.filter.audio], [ffmpeg.filter.video]) ->
ffmpeg.filter.video
```

Arguments:

- `planes` (of type `int?`, which defaults to `null`): set planes. (default: 15)
- `inplace` (of type `bool?`, which defaults to `null`): enable inplace mode. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.prewitt`

Ffmpeg filter: Apply prewitt operator.

Type:
```
(?planes : int?, ?scale : float?, ?delta : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `planes` (of type `int?`, which defaults to `null`): set planes to filter. (default: 15)
- `scale` (of type `float?`, which defaults to `null`): set scale. (default: 1.)
- `delta` (of type `float?`, which defaults to `null`): set delta. (default: 0.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.prewitt_opencl`

Ffmpeg filter: Apply prewitt operator

Type:
```
(?planes : int?, ?scale : float?, ?delta : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `planes` (of type `int?`, which defaults to `null`): set planes to filter. (default: 15)
- `scale` (of type `float?`, which defaults to `null`): set scale. (default: 1.)
- `delta` (of type `float?`, which defaults to `null`): set delta. (default: 0.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.procamp_vaapi`

Ffmpeg filter: ProcAmp (color balance) adjustments for hue, saturation, brightness, contrast

Type:
```
(?b : float?, ?brightness : float?, ?s : float?,
 ?saturatio : float?, ?c : float?, ?contrast : float?,
 ?h : float?, ?hue : float?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `b` (of type `float?`, which defaults to `null`): Output video brightness. (default: 0.)
- `brightness` (of type `float?`, which defaults to `null`): Output video brightness. (default: 0.)
- `s` (of type `float?`, which defaults to `null`): Output video saturation. (default: 1.)
- `saturatio` (of type `float?`, which defaults to `null`): Output video saturation. (default: 1.)
- `c` (of type `float?`, which defaults to `null`): Output video contrast. (default: 1.)
- `contrast` (of type `float?`, which defaults to `null`): Output video contrast. (default: 1.)
- `h` (of type `float?`, which defaults to `null`): Output video hue. (default: 0.)
- `hue` (of type `float?`, which defaults to `null`): Output video hue. (default: 0.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.program_opencl`

Ffmpeg filter: Filter video using an OpenCL program

Type:
```
(?source : string?, ?kernel : string?, ?inputs : int?,
 ?size : string?, ?s : string?, ffmpeg.filter.graph) ->
ffmpeg.filter.video
```

Arguments:

- `source` (of type `string?`, which defaults to `null`): OpenCL program source file
- `kernel` (of type `string?`, which defaults to `null`): Kernel name in program
- `inputs` (of type `int?`, which defaults to `null`): Number of inputs. (default: 1)
- `size` (of type `string?`, which defaults to `null`): Video size
- `s` (of type `string?`, which defaults to `null`): Video size
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.pseudocolor`

Ffmpeg filter: Make pseudocolored video frames.

Type:
```
(?c0 : string?, ?c1 : string?, ?c2 : string?,
 ?c3 : string?, ?i : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `c0` (of type `string?`, which defaults to `null`): set component #0 expression. (default: val)
- `c1` (of type `string?`, which defaults to `null`): set component #1 expression. (default: val)
- `c2` (of type `string?`, which defaults to `null`): set component #2 expression. (default: val)
- `c3` (of type `string?`, which defaults to `null`): set component #3 expression. (default: val)
- `i` (of type `int?`, which defaults to `null`): set component as base. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.psnr`

Ffmpeg filter: Calculate the PSNR between two video streams.

Type:
```
(?stats_file : string?, ?f : string?,
 ?stats_version : int?, ?output_max : bool?,
 ffmpeg.filter.graph, ffmpeg.filter.video,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `stats_file` (of type `string?`, which defaults to `null`): Set file where to store per-frame difference information
- `f` (of type `string?`, which defaults to `null`): Set file where to store per-frame difference information
- `stats_version` (of type `int?`, which defaults to `null`): Set the format version for the stats file.. (default: 1)
- `output_max` (of type `bool?`, which defaults to `null`): Add raw stats (max values) to the output log.. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.pullup`

Ffmpeg filter: Pullup from field sequence to frames.

Type:
```
(?jl : int?, ?jr : int?, ?jt : int?, ?jb : int?,
 ?sb : bool?, ?mp : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `jl` (of type `int?`, which defaults to `null`): set left junk size. (default: 1)
- `jr` (of type `int?`, which defaults to `null`): set right junk size. (default: 1)
- `jt` (of type `int?`, which defaults to `null`): set top junk size. (default: 4)
- `jb` (of type `int?`, which defaults to `null`): set bottom junk size. (default: 4)
- `sb` (of type `bool?`, which defaults to `null`): set strict breaks. (default: false)
- `mp` (of type `int?`, which defaults to `null`): set metric plane. (default: 0, possible values: 0 (y), 1 (u), 2 (v))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.qp`

Ffmpeg filter: Change video quantization parameters.

Type:
```
(?qp : string?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `qp` (of type `string?`, which defaults to `null`): set qp expression
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.random`

Ffmpeg filter: Return random frames.

Type:
```
(?frames : int?, ?seed : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `frames` (of type `int?`, which defaults to `null`): set number of frames in cache. (default: 30)
- `seed` (of type `int?`, which defaults to `null`): set the seed. (default: -1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.readeia608`

Ffmpeg filter: Read EIA-608 Closed Caption codes from input video and write them to frame metadata.

Type:
```
(?scan_min : int?, ?scan_max : int?, ?spw : float?,
 ?chp : bool?, ?lp : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `scan_min` (of type `int?`, which defaults to `null`): set from which line to scan for codes. (default: 0)
- `scan_max` (of type `int?`, which defaults to `null`): set to which line to scan for codes. (default: 29)
- `spw` (of type `float?`, which defaults to `null`): set ratio of width reserved for sync code detection. (default: 0.27)
- `chp` (of type `bool?`, which defaults to `null`): check and apply parity bit. (default: false)
- `lp` (of type `bool?`, which defaults to `null`): lowpass line prior to processing. (default: true)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.readvitc`

Ffmpeg filter: Read vertical interval timecode and write it to frame metadata.

Type:
```
(?scan_max : int?, ?thr_b : float?, ?thr_w : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `scan_max` (of type `int?`, which defaults to `null`): maximum line numbers to scan for VITC data. (default: 45)
- `thr_b` (of type `float?`, which defaults to `null`): black color threshold. (default: 0.2)
- `thr_w` (of type `float?`, which defaults to `null`): white color threshold. (default: 0.6)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.realtime`

Ffmpeg filter: Slow down filtering to match realtime.

Type:
```
(?limit : int?, ?speed : float?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `limit` (of type `int?`, which defaults to `null`): sleep time limit. (default: 2000000)
- `speed` (of type `float?`, which defaults to `null`): speed factor. (default: 1.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.remap`

Ffmpeg filter: Remap pixels.

Type:
```
(?format : int?, ?fill : string?, ffmpeg.filter.graph,
 ffmpeg.filter.video, ffmpeg.filter.video,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `format` (of type `int?`, which defaults to `null`): set output format. (default: 0, possible values: 0 (color), 1 (gray))
- `fill` (of type `string?`, which defaults to `null`): set the color of the unmapped pixels. (default: black)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.removegrain`

Ffmpeg filter: Remove grain.

Type:
```
(?m0 : int?, ?m1 : int?, ?m2 : int?, ?m3 : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `m0` (of type `int?`, which defaults to `null`): set mode for 1st plane. (default: 0)
- `m1` (of type `int?`, which defaults to `null`): set mode for 2nd plane. (default: 0)
- `m2` (of type `int?`, which defaults to `null`): set mode for 3rd plane. (default: 0)
- `m3` (of type `int?`, which defaults to `null`): set mode for 4th plane. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.removelogo`

Ffmpeg filter: Remove a TV logo based on a mask image.

Type:
```
(?filename : string?, ?f : string?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `filename` (of type `string?`, which defaults to `null`): set bitmap filename
- `f` (of type `string?`, which defaults to `null`): set bitmap filename
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.repeatfields`

Ffmpeg filter: Hard repeat fields based on MPEG repeat field flag.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.replaygain`

Ffmpeg filter: ReplayGain scanner.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.reverse`

Ffmpeg filter: Reverse a clip.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.rgbashift`

Ffmpeg filter: Shift RGBA.

Type:
```
(?rh : int?, ?rv : int?, ?gh : int?, ?gv : int?,
 ?bh : int?, ?bv : int?, ?ah : int?, ?av : int?,
 ?edge : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `rh` (of type `int?`, which defaults to `null`): shift red horizontally. (default: 0)
- `rv` (of type `int?`, which defaults to `null`): shift red vertically. (default: 0)
- `gh` (of type `int?`, which defaults to `null`): shift green horizontally. (default: 0)
- `gv` (of type `int?`, which defaults to `null`): shift green vertically. (default: 0)
- `bh` (of type `int?`, which defaults to `null`): shift blue horizontally. (default: 0)
- `bv` (of type `int?`, which defaults to `null`): shift blue vertically. (default: 0)
- `ah` (of type `int?`, which defaults to `null`): shift alpha horizontally. (default: 0)
- `av` (of type `int?`, which defaults to `null`): shift alpha vertically. (default: 0)
- `edge` (of type `int?`, which defaults to `null`): set edge operation. (default: 0, possible values: 0 (smear), 1 (wrap))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.rgbtestsrc`

Ffmpeg filter: Generate RGB test pattern.

Type:
```
(?size : string?, ?s : string?, ?rate : string?,
 ?r : string?, ?duration : int?, ?d : int?,
 ?sar : string?, ffmpeg.filter.graph) ->
ffmpeg.filter.video
```

Arguments:

- `size` (of type `string?`, which defaults to `null`): set video size. (default: 320x240)
- `s` (of type `string?`, which defaults to `null`): set video size. (default: 320x240)
- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `duration` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `d` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `sar` (of type `string?`, which defaults to `null`): set video sample aspect ratio. (default: 1/1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.roberts`

Ffmpeg filter: Apply roberts cross operator.

Type:
```
(?planes : int?, ?scale : float?, ?delta : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `planes` (of type `int?`, which defaults to `null`): set planes to filter. (default: 15)
- `scale` (of type `float?`, which defaults to `null`): set scale. (default: 1.)
- `delta` (of type `float?`, which defaults to `null`): set delta. (default: 0.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.roberts_opencl`

Ffmpeg filter: Apply roberts operator

Type:
```
(?planes : int?, ?scale : float?, ?delta : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `planes` (of type `int?`, which defaults to `null`): set planes to filter. (default: 15)
- `scale` (of type `float?`, which defaults to `null`): set scale. (default: 1.)
- `delta` (of type `float?`, which defaults to `null`): set delta. (default: 0.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.rotate`

Ffmpeg filter: Rotate the input image.

Type:
```
(?angle : string?, ?a : string?, ?out_w : string?,
 ?ow : string?, ?out_h : string?, ?oh : string?,
 ?fillcolor : string?, ?c : string?, ?bilinear : bool?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `angle` (of type `string?`, which defaults to `null`): set angle (in radians). (default: 0)
- `a` (of type `string?`, which defaults to `null`): set angle (in radians). (default: 0)
- `out_w` (of type `string?`, which defaults to `null`): set output width expression. (default: iw)
- `ow` (of type `string?`, which defaults to `null`): set output width expression. (default: iw)
- `out_h` (of type `string?`, which defaults to `null`): set output height expression. (default: ih)
- `oh` (of type `string?`, which defaults to `null`): set output height expression. (default: ih)
- `fillcolor` (of type `string?`, which defaults to `null`): set background fill color. (default: black)
- `c` (of type `string?`, which defaults to `null`): set background fill color. (default: black)
- `bilinear` (of type `bool?`, which defaults to `null`): use bilinear interpolation. (default: true)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.rubberband`

Ffmpeg filter: Apply time-stretching and pitch-shifting.

Type:
```
(?tempo : float?, ?pitch : float?, ?transients : int?,
 ?detector : int?, ?phase : int?, ?window : int?,
 ?smoothing : int?, ?formant : int?, ?pitchq : int?,
 ?channels : int?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `tempo` (of type `float?`, which defaults to `null`): set tempo scale factor. (default: 1.)
- `pitch` (of type `float?`, which defaults to `null`): set pitch scale factor. (default: 1.)
- `transients` (of type `int?`, which defaults to `null`): set transients. (default: 0, possible values: 0 (crisp), 256 (mixed), 512 (smooth))
- `detector` (of type `int?`, which defaults to `null`): set detector. (default: 0, possible values: 0 (compound), 1024 (percussive), 2048 (soft))
- `phase` (of type `int?`, which defaults to `null`): set phase. (default: 0, possible values: 0 (laminar), 8192 (independent))
- `window` (of type `int?`, which defaults to `null`): set window. (default: 0, possible values: 0 (standard), 1048576 (short), 2097152 (long))
- `smoothing` (of type `int?`, which defaults to `null`): set smoothing. (default: 0, possible values: 0 (off), 8388608 (on))
- `formant` (of type `int?`, which defaults to `null`): set formant. (default: 0, possible values: 0 (shifted), 16777216 (preserved))
- `pitchq` (of type `int?`, which defaults to `null`): set pitch quality. (default: 0, possible values: 33554432 (quality), 0 (speed), 67108864 (consistency))
- `channels` (of type `int?`, which defaults to `null`): set channels. (default: 0, possible values: 0 (apart), 268435456 (together))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.sab`

Ffmpeg filter: Apply shape adaptive blur.

Type:
```
(?luma_radius : float?, ?lr : float?,
 ?luma_pre_filter_radius : float?, ?lpfr : float?,
 ?luma_strength : float?, ?ls : float?,
 ?chroma_radius : float?, ?cr : float?,
 ?chroma_pre_filter_radius : float?, ?cpfr : float?,
 ?chroma_strength : float?, ?cs : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `luma_radius` (of type `float?`, which defaults to `null`): set luma radius. (default: 1.)
- `lr` (of type `float?`, which defaults to `null`): set luma radius. (default: 1.)
- `luma_pre_filter_radius` (of type `float?`, which defaults to `null`): set luma pre-filter radius. (default: 1.)
- `lpfr` (of type `float?`, which defaults to `null`): set luma pre-filter radius. (default: 1.)
- `luma_strength` (of type `float?`, which defaults to `null`): set luma strength. (default: 1.)
- `ls` (of type `float?`, which defaults to `null`): set luma strength. (default: 1.)
- `chroma_radius` (of type `float?`, which defaults to `null`): set chroma radius. (default: -0.9)
- `cr` (of type `float?`, which defaults to `null`): set chroma radius. (default: -0.9)
- `chroma_pre_filter_radius` (of type `float?`, which defaults to `null`): set chroma pre-filter radius. (default: -0.9)
- `cpfr` (of type `float?`, which defaults to `null`): set chroma pre-filter radius. (default: -0.9)
- `chroma_strength` (of type `float?`, which defaults to `null`): set chroma strength. (default: -0.9)
- `cs` (of type `float?`, which defaults to `null`): set chroma strength. (default: -0.9)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.scale`

Ffmpeg filter: Scale the input video size and/or convert the image format.

Type:
```
(?w : string?, ?width : string?, ?h : string?,
 ?height : string?, ?flags : string?, ?interl : bool?,
 ?size : string?, ?s : string?,
 ?in_color_matrix : string?, ?out_color_matrix : string?,
 ?in_range : int?, ?out_range : int?,
 ?in_v_chr_pos : int?, ?in_h_chr_pos : int?,
 ?out_v_chr_pos : int?, ?out_h_chr_pos : int?,
 ?force_original_aspect_ratio : int?,
 ?force_divisible_by : int?, ?param0 : float?,
 ?param1 : float?, ?nb_slices : int?, ?eval : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `w` (of type `string?`, which defaults to `null`): Output video width
- `width` (of type `string?`, which defaults to `null`): Output video width
- `h` (of type `string?`, which defaults to `null`): Output video height
- `height` (of type `string?`, which defaults to `null`): Output video height
- `flags` (of type `string?`, which defaults to `null`): Flags to pass to libswscale. (default: bilinear)
- `interl` (of type `bool?`, which defaults to `null`): set interlacing. (default: false)
- `size` (of type `string?`, which defaults to `null`): set video size
- `s` (of type `string?`, which defaults to `null`): set video size
- `in_color_matrix` (of type `string?`, which defaults to `null`): set input YCbCr type. (default: auto, possible values: auto (auto), bt601 (bt601), bt470 (bt470), smpte170m (smpte170m), bt709 (bt709), fcc (fcc), smpte240m (smpte240m), bt2020 (bt2020))
- `out_color_matrix` (of type `string?`, which defaults to `null`): set output YCbCr type. (possible values: auto (auto), bt601 (bt601), bt470 (bt470), smpte170m (smpte170m), bt709 (bt709), fcc (fcc), smpte240m (smpte240m), bt2020 (bt2020))
- `in_range` (of type `int?`, which defaults to `null`): set input color range. (default: 0, possible values: 0 (auto), 0 (unknown), 2 (full), 1 (limited), 2 (jpeg), 1 (mpeg), 1 (tv), 2 (pc))
- `out_range` (of type `int?`, which defaults to `null`): set output color range. (default: 0, possible values: 0 (auto), 0 (unknown), 2 (full), 1 (limited), 2 (jpeg), 1 (mpeg), 1 (tv), 2 (pc))
- `in_v_chr_pos` (of type `int?`, which defaults to `null`): input vertical chroma position in luma grid/256. (default: -513)
- `in_h_chr_pos` (of type `int?`, which defaults to `null`): input horizontal chroma position in luma grid/256. (default: -513)
- `out_v_chr_pos` (of type `int?`, which defaults to `null`): output vertical chroma position in luma grid/256. (default: -513)
- `out_h_chr_pos` (of type `int?`, which defaults to `null`): output horizontal chroma position in luma grid/256. (default: -513)
- `force_original_aspect_ratio` (of type `int?`, which defaults to `null`): decrease or increase w/h if necessary to keep the original AR. (default: 0, possible values: 0 (disable), 1 (decrease), 2 (increase))
- `force_divisible_by` (of type `int?`, which defaults to `null`): enforce that the output resolution is divisible by a defined integer when force_original_aspect_ratio is used. (default: 1)
- `param0` (of type `float?`, which defaults to `null`): Scaler param 0. (default: 123456.)
- `param1` (of type `float?`, which defaults to `null`): Scaler param 1. (default: 123456.)
- `nb_slices` (of type `int?`, which defaults to `null`): set the number of slices (debug purpose only). (default: 0)
- `eval` (of type `int?`, which defaults to `null`): specify when to evaluate expressions. (default: 0, possible values: 0 (init), 1 (frame))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.scale2ref`

Ffmpeg filter: Scale the input video size and/or convert the image format to the given reference.

Type:
```
(?w : string?, ?width : string?, ?h : string?,
 ?height : string?, ?flags : string?, ?interl : bool?,
 ?size : string?, ?s : string?,
 ?in_color_matrix : string?, ?out_color_matrix : string?,
 ?in_range : int?, ?out_range : int?,
 ?in_v_chr_pos : int?, ?in_h_chr_pos : int?,
 ?out_v_chr_pos : int?, ?out_h_chr_pos : int?,
 ?force_original_aspect_ratio : int?,
 ?force_divisible_by : int?, ?param0 : float?,
 ?param1 : float?, ?nb_slices : int?, ?eval : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video,
 ffmpeg.filter.video) ->
ffmpeg.filter.video * ffmpeg.filter.video
```

Arguments:

- `w` (of type `string?`, which defaults to `null`): Output video width
- `width` (of type `string?`, which defaults to `null`): Output video width
- `h` (of type `string?`, which defaults to `null`): Output video height
- `height` (of type `string?`, which defaults to `null`): Output video height
- `flags` (of type `string?`, which defaults to `null`): Flags to pass to libswscale. (default: bilinear)
- `interl` (of type `bool?`, which defaults to `null`): set interlacing. (default: false)
- `size` (of type `string?`, which defaults to `null`): set video size
- `s` (of type `string?`, which defaults to `null`): set video size
- `in_color_matrix` (of type `string?`, which defaults to `null`): set input YCbCr type. (default: auto, possible values: auto (auto), bt601 (bt601), bt470 (bt470), smpte170m (smpte170m), bt709 (bt709), fcc (fcc), smpte240m (smpte240m), bt2020 (bt2020))
- `out_color_matrix` (of type `string?`, which defaults to `null`): set output YCbCr type. (possible values: auto (auto), bt601 (bt601), bt470 (bt470), smpte170m (smpte170m), bt709 (bt709), fcc (fcc), smpte240m (smpte240m), bt2020 (bt2020))
- `in_range` (of type `int?`, which defaults to `null`): set input color range. (default: 0, possible values: 0 (auto), 0 (unknown), 2 (full), 1 (limited), 2 (jpeg), 1 (mpeg), 1 (tv), 2 (pc))
- `out_range` (of type `int?`, which defaults to `null`): set output color range. (default: 0, possible values: 0 (auto), 0 (unknown), 2 (full), 1 (limited), 2 (jpeg), 1 (mpeg), 1 (tv), 2 (pc))
- `in_v_chr_pos` (of type `int?`, which defaults to `null`): input vertical chroma position in luma grid/256. (default: -513)
- `in_h_chr_pos` (of type `int?`, which defaults to `null`): input horizontal chroma position in luma grid/256. (default: -513)
- `out_v_chr_pos` (of type `int?`, which defaults to `null`): output vertical chroma position in luma grid/256. (default: -513)
- `out_h_chr_pos` (of type `int?`, which defaults to `null`): output horizontal chroma position in luma grid/256. (default: -513)
- `force_original_aspect_ratio` (of type `int?`, which defaults to `null`): decrease or increase w/h if necessary to keep the original AR. (default: 0, possible values: 0 (disable), 1 (decrease), 2 (increase))
- `force_divisible_by` (of type `int?`, which defaults to `null`): enforce that the output resolution is divisible by a defined integer when force_original_aspect_ratio is used. (default: 1)
- `param0` (of type `float?`, which defaults to `null`): Scaler param 0. (default: 123456.)
- `param1` (of type `float?`, which defaults to `null`): Scaler param 1. (default: 123456.)
- `nb_slices` (of type `int?`, which defaults to `null`): set the number of slices (debug purpose only). (default: 0)
- `eval` (of type `int?`, which defaults to `null`): specify when to evaluate expressions. (default: 0, possible values: 0 (init), 1 (frame))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.scale_qsv`

Ffmpeg filter: QuickSync video scaling and format conversion

Type:
```
(?w : string?, ?h : string?, ?format : string?,
 ?mode : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `w` (of type `string?`, which defaults to `null`): Output video width. (default: iw)
- `h` (of type `string?`, which defaults to `null`): Output video height. (default: ih)
- `format` (of type `string?`, which defaults to `null`): Output pixel format. (default: same)
- `mode` (of type `int?`, which defaults to `null`): set scaling mode. (default: 0, possible values: 1 (low_power), 2 (hq))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.scale_vaapi`

Ffmpeg filter: Scale to/from VAAPI surfaces.

Type:
```
(?w : string?, ?h : string?, ?format : string?,
 ?mode : int?, ?out_color_matrix : string?,
 ?out_range : int?, ?out_color_primaries : string?,
 ?out_color_transfer : string?,
 ?out_chroma_location : string?,
 ?force_original_aspect_ratio : int?,
 ?force_divisible_by : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `w` (of type `string?`, which defaults to `null`): Output video width. (default: iw)
- `h` (of type `string?`, which defaults to `null`): Output video height. (default: ih)
- `format` (of type `string?`, which defaults to `null`): Output video format (software format of hardware frames)
- `mode` (of type `int?`, which defaults to `null`): Scaling mode. (default: 512, possible values: 0 (default), 256 (fast), 512 (hq), 768 (nl_anamorphic))
- `out_color_matrix` (of type `string?`, which defaults to `null`): Output colour matrix coefficient set
- `out_range` (of type `int?`, which defaults to `null`): Output colour range. (default: 0, possible values: 2 (full), 1 (limited), 2 (jpeg), 1 (mpeg), 1 (tv), 2 (pc))
- `out_color_primaries` (of type `string?`, which defaults to `null`): Output colour primaries
- `out_color_transfer` (of type `string?`, which defaults to `null`): Output colour transfer characteristics
- `out_chroma_location` (of type `string?`, which defaults to `null`): Output chroma sample location
- `force_original_aspect_ratio` (of type `int?`, which defaults to `null`): decrease or increase w/h if necessary to keep the original AR. (default: 0, possible values: 0 (disable), 1 (decrease), 2 (increase))
- `force_divisible_by` (of type `int?`, which defaults to `null`): enforce that the output resolution is divisible by a defined integer when force_original_aspect_ratio is used. (default: 1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.scdet`

Ffmpeg filter: Detect video scene change

Type:
```
(?threshold : float?, ?t : float?, ?sc_pass : bool?,
 ?s : bool?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `threshold` (of type `float?`, which defaults to `null`): set scene change detect threshold. (default: 10.)
- `t` (of type `float?`, which defaults to `null`): set scene change detect threshold. (default: 10.)
- `sc_pass` (of type `bool?`, which defaults to `null`): Set the flag to pass scene change frames. (default: false)
- `s` (of type `bool?`, which defaults to `null`): Set the flag to pass scene change frames. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.scroll`

Ffmpeg filter: Scroll input video.

Type:
```
(?horizontal : float?, ?h : float?, ?vertical : float?,
 ?v : float?, ?hpos : float?, ?vpos : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `horizontal` (of type `float?`, which defaults to `null`): set the horizontal scrolling speed. (default: 0.)
- `h` (of type `float?`, which defaults to `null`): set the horizontal scrolling speed. (default: 0.)
- `vertical` (of type `float?`, which defaults to `null`): set the vertical scrolling speed. (default: 0.)
- `v` (of type `float?`, which defaults to `null`): set the vertical scrolling speed. (default: 0.)
- `hpos` (of type `float?`, which defaults to `null`): set initial horizontal position. (default: 0.)
- `vpos` (of type `float?`, which defaults to `null`): set initial vertical position. (default: 0.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.select`

Ffmpeg filter: Select video frames to pass in output. This filter has dynamic outputs: returned value is a tuple of audio and video outputs. Total number of outputs is determined at runtime.

Type:
```
(?expr : string?, ?e : string?, ?outputs : int?,
 ?n : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
[ffmpeg.filter.audio] * [ffmpeg.filter.video]
```

Arguments:

- `expr` (of type `string?`, which defaults to `null`): set an expression to use for selecting frames. (default: 1)
- `e` (of type `string?`, which defaults to `null`): set an expression to use for selecting frames. (default: 1)
- `outputs` (of type `int?`, which defaults to `null`): set the number of outputs. (default: 1)
- `n` (of type `int?`, which defaults to `null`): set the number of outputs. (default: 1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.selectivecolor`

Ffmpeg filter: Apply CMYK adjustments to specific color ranges.

Type:
```
(?correction_method : int?, ?reds : string?,
 ?yellows : string?, ?greens : string?, ?cyans : string?,
 ?blues : string?, ?magentas : string?,
 ?whites : string?, ?neutrals : string?,
 ?blacks : string?, ?psfile : string?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `correction_method` (of type `int?`, which defaults to `null`): select correction method. (default: 0, possible values: 0 (absolute), 1 (relative))
- `reds` (of type `string?`, which defaults to `null`): adjust red regions
- `yellows` (of type `string?`, which defaults to `null`): adjust yellow regions
- `greens` (of type `string?`, which defaults to `null`): adjust green regions
- `cyans` (of type `string?`, which defaults to `null`): adjust cyan regions
- `blues` (of type `string?`, which defaults to `null`): adjust blue regions
- `magentas` (of type `string?`, which defaults to `null`): adjust magenta regions
- `whites` (of type `string?`, which defaults to `null`): adjust white regions
- `neutrals` (of type `string?`, which defaults to `null`): adjust neutral regions
- `blacks` (of type `string?`, which defaults to `null`): adjust black regions
- `psfile` (of type `string?`, which defaults to `null`): set Photoshop selectivecolor file name
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.sendcmd`

Ffmpeg filter: Send commands to filters.

Type:
```
(?commands : string?, ?c : string?, ?filename : string?,
 ?f : string?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `commands` (of type `string?`, which defaults to `null`): set commands
- `c` (of type `string?`, which defaults to `null`): set commands
- `filename` (of type `string?`, which defaults to `null`): set commands file
- `f` (of type `string?`, which defaults to `null`): set commands file
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.separatefields`

Ffmpeg filter: Split input video frames into fields.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.setdar`

Ffmpeg filter: Set the frame display aspect ratio.

Type:
```
(?dar : string?, ?ratio : string?, ?r : string?,
 ?max : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `dar` (of type `string?`, which defaults to `null`): set display aspect ratio. (default: 0)
- `ratio` (of type `string?`, which defaults to `null`): set display aspect ratio. (default: 0)
- `r` (of type `string?`, which defaults to `null`): set display aspect ratio. (default: 0)
- `max` (of type `int?`, which defaults to `null`): set max value for nominator or denominator in the ratio. (default: 100)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.setfield`

Ffmpeg filter: Force field for the output video frame.

Type:
```
(?mode : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `mode` (of type `int?`, which defaults to `null`): select interlace mode. (default: -1, possible values: -1 (auto), 0 (bff), 1 (tff), 2 (prog))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.setparams`

Ffmpeg filter: Force field, or color property for the output video frame.

Type:
```
(?field_mode : int?, ?range : int?,
 ?color_primaries : int?, ?color_trc : int?,
 ?colorspace : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `field_mode` (of type `int?`, which defaults to `null`): select interlace mode. (default: -1, possible values: -1 (auto), 0 (bff), 1 (tff), 2 (prog))
- `range` (of type `int?`, which defaults to `null`): select color range. (default: -1, possible values: -1 (auto), 0 (unspecified), 0 (unknown), 1 (limited), 1 (tv), 1 (mpeg), 2 (full), 2 (pc), 2 (jpeg))
- `color_primaries` (of type `int?`, which defaults to `null`): select color primaries. (default: -1, possible values: -1 (auto), 1 (bt709), 2 (unknown), 4 (bt470m), 5 (bt470bg), 6 (smpte170m), 7 (smpte240m), 8 (film), 9 (bt2020), 10 (smpte428), 11 (smpte431), 12 (smpte432), 22 (jedec-p22), 22 (ebu3213))
- `color_trc` (of type `int?`, which defaults to `null`): select color transfer. (default: -1, possible values: -1 (auto), 1 (bt709), 2 (unknown), 4 (bt470m), 5 (bt470bg), 6 (smpte170m), 7 (smpte240m), 8 (linear), 9 (log100), 10 (log316), 11 (iec61966-2-4), 12 (bt1361e), 13 (iec61966-2-1), 14 (bt2020-10), 15 (bt2020-12), 16 (smpte2084), 17 (smpte428), 18 (arib-std-b67))
- `colorspace` (of type `int?`, which defaults to `null`): select colorspace. (default: -1, possible values: -1 (auto), 0 (gbr), 1 (bt709), 2 (unknown), 4 (fcc), 5 (bt470bg), 6 (smpte170m), 7 (smpte240m), 8 (ycgco), 9 (bt2020nc), 10 (bt2020c), 11 (smpte2085), 12 (chroma-derived-nc), 13 (chroma-derived-c), 14 (ictcp))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.setpts`

Ffmpeg filter: Set PTS for the output video frame.

Type:
```
(?expr : string?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `expr` (of type `string?`, which defaults to `null`): Expression determining the frame timestamp. (default: PTS)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.setrange`

Ffmpeg filter: Force color range for the output video frame.

Type:
```
(?range : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `range` (of type `int?`, which defaults to `null`): select color range. (default: -1, possible values: -1 (auto), 0 (unspecified), 0 (unknown), 1 (limited), 1 (tv), 1 (mpeg), 2 (full), 2 (pc), 2 (jpeg))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.setsar`

Ffmpeg filter: Set the pixel sample aspect ratio.

Type:
```
(?sar : string?, ?ratio : string?, ?r : string?,
 ?max : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `sar` (of type `string?`, which defaults to `null`): set sample (pixel) aspect ratio. (default: 0)
- `ratio` (of type `string?`, which defaults to `null`): set sample (pixel) aspect ratio. (default: 0)
- `r` (of type `string?`, which defaults to `null`): set sample (pixel) aspect ratio. (default: 0)
- `max` (of type `int?`, which defaults to `null`): set max value for nominator or denominator in the ratio. (default: 100)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.settb`

Ffmpeg filter: Set timebase for the video output link.

Type:
```
(?expr : string?, ?tb : string?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `expr` (of type `string?`, which defaults to `null`): set expression determining the output timebase. (default: intb)
- `tb` (of type `string?`, which defaults to `null`): set expression determining the output timebase. (default: intb)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.sharpness_vaapi`

Ffmpeg filter: VAAPI VPP for sharpness

Type:
```
(?sharpness : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `sharpness` (of type `int?`, which defaults to `null`): sharpness level. (default: 44)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.showcqt`

Ffmpeg filter: Convert input audio to a CQT (Constant/Clamped Q Transform) spectrum video output.

Type:
```
(?size : string?, ?s : string?, ?fps : string?,
 ?rate : string?, ?r : string?, ?bar_h : int?,
 ?axis_h : int?, ?sono_h : int?, ?fullhd : bool?,
 ?sono_v : string?, ?volume : string?, ?bar_v : string?,
 ?volume2 : string?, ?sono_g : float?, ?gamma : float?,
 ?bar_g : float?, ?gamma2 : float?, ?bar_t : float?,
 ?timeclamp : float?, ?tc : float?, ?attack : float?,
 ?basefreq : float?, ?endfreq : float?,
 ?coeffclamp : float?, ?tlength : string?, ?count : int?,
 ?fcount : int?, ?fontfile : string?, ?font : string?,
 ?fontcolor : string?, ?axisfile : string?,
 ?axis : bool?, ?text : bool?, ?csp : int?,
 ?cscheme : string?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.video
```

Arguments:

- `size` (of type `string?`, which defaults to `null`): set video size. (default: 1920x1080)
- `s` (of type `string?`, which defaults to `null`): set video size. (default: 1920x1080)
- `fps` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `bar_h` (of type `int?`, which defaults to `null`): set bargraph height. (default: -1)
- `axis_h` (of type `int?`, which defaults to `null`): set axis height. (default: -1)
- `sono_h` (of type `int?`, which defaults to `null`): set sonogram height. (default: -1)
- `fullhd` (of type `bool?`, which defaults to `null`): set fullhd size. (default: true)
- `sono_v` (of type `string?`, which defaults to `null`): set sonogram volume. (default: 16)
- `volume` (of type `string?`, which defaults to `null`): set sonogram volume. (default: 16)
- `bar_v` (of type `string?`, which defaults to `null`): set bargraph volume. (default: sono_v)
- `volume2` (of type `string?`, which defaults to `null`): set bargraph volume. (default: sono_v)
- `sono_g` (of type `float?`, which defaults to `null`): set sonogram gamma. (default: 3.)
- `gamma` (of type `float?`, which defaults to `null`): set sonogram gamma. (default: 3.)
- `bar_g` (of type `float?`, which defaults to `null`): set bargraph gamma. (default: 1.)
- `gamma2` (of type `float?`, which defaults to `null`): set bargraph gamma. (default: 1.)
- `bar_t` (of type `float?`, which defaults to `null`): set bar transparency. (default: 1.)
- `timeclamp` (of type `float?`, which defaults to `null`): set timeclamp. (default: 0.17)
- `tc` (of type `float?`, which defaults to `null`): set timeclamp. (default: 0.17)
- `attack` (of type `float?`, which defaults to `null`): set attack time. (default: 0.)
- `basefreq` (of type `float?`, which defaults to `null`): set base frequency. (default: 20.0152312641)
- `endfreq` (of type `float?`, which defaults to `null`): set end frequency. (default: 20495.5968144)
- `coeffclamp` (of type `float?`, which defaults to `null`): set coeffclamp. (default: 1.)
- `tlength` (of type `string?`, which defaults to `null`): set tlength. (default: 384*tc/(384+tc*f))
- `count` (of type `int?`, which defaults to `null`): set transform count. (default: 6)
- `fcount` (of type `int?`, which defaults to `null`): set frequency count. (default: 0)
- `fontfile` (of type `string?`, which defaults to `null`): set axis font file
- `font` (of type `string?`, which defaults to `null`): set axis font
- `fontcolor` (of type `string?`, which defaults to `null`): set font color. (default: st(0, (midi(f)-59.5)/12);st(1, if(between(ld(0),0,1), 0.5-0.5*cos(2*PI*ld(0)), 0));r(1-ld(1)) + b(ld(1)))
- `axisfile` (of type `string?`, which defaults to `null`): set axis image
- `axis` (of type `bool?`, which defaults to `null`): draw axis. (default: true)
- `text` (of type `bool?`, which defaults to `null`): draw axis. (default: true)
- `csp` (of type `int?`, which defaults to `null`): set color space. (default: 2, possible values: 2 (unspecified), 1 (bt709), 4 (fcc), 5 (bt470bg), 6 (smpte170m), 7 (smpte240m), 9 (bt2020ncl))
- `cscheme` (of type `string?`, which defaults to `null`): set color scheme. (default: 1|0.5|0|0|0.5|1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.showfreqs`

Ffmpeg filter: Convert input audio to a frequencies video output.

Type:
```
(?size : string?, ?s : string?, ?mode : int?,
 ?ascale : int?, ?fscale : int?, ?win_size : int?,
 ?win_func : int?, ?overlap : float?, ?averaging : int?,
 ?colors : string?, ?cmode : int?, ?minamp : float?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.video
```

Arguments:

- `size` (of type `string?`, which defaults to `null`): set video size. (default: 1024x512)
- `s` (of type `string?`, which defaults to `null`): set video size. (default: 1024x512)
- `mode` (of type `int?`, which defaults to `null`): set display mode. (default: 1, possible values: 0 (line), 1 (bar), 2 (dot))
- `ascale` (of type `int?`, which defaults to `null`): set amplitude scale. (default: 3, possible values: 0 (lin), 1 (sqrt), 2 (cbrt), 3 (log))
- `fscale` (of type `int?`, which defaults to `null`): set frequency scale. (default: 0, possible values: 0 (lin), 1 (log), 2 (rlog))
- `win_size` (of type `int?`, which defaults to `null`): set window size. (default: 2048)
- `win_func` (of type `int?`, which defaults to `null`): set window function. (default: 1, possible values: 0 (rect), 4 (bartlett), 1 (hanning), 2 (hamming), 3 (blackman), 5 (welch), 6 (flattop), 7 (bharris), 8 (bnuttall), 11 (bhann), 9 (sine), 10 (nuttall), 12 (lanczos), 13 (gauss), 14 (tukey), 15 (dolph), 16 (cauchy), 17 (parzen), 18 (poisson), 19 (bohman))
- `overlap` (of type `float?`, which defaults to `null`): set window overlap. (default: 1.)
- `averaging` (of type `int?`, which defaults to `null`): set time averaging. (default: 1)
- `colors` (of type `string?`, which defaults to `null`): set channels colors. (default: red|green|blue|yellow|orange|lime|pink|magenta|brown)
- `cmode` (of type `int?`, which defaults to `null`): set channel mode. (default: 0, possible values: 0 (combined), 1 (separate))
- `minamp` (of type `float?`, which defaults to `null`): set minimum amplitude. (default: 1e-06)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.showinfo`

Ffmpeg filter: Show textual information for each video frame.

Type:
```
(?checksum : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `checksum` (of type `bool?`, which defaults to `null`): calculate checksums. (default: true)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.showpalette`

Ffmpeg filter: Display frame palette.

Type:
```
(?s : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `s` (of type `int?`, which defaults to `null`): set pixel box size. (default: 30)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.showspatial`

Ffmpeg filter: Convert input audio to a spatial video output.

Type:
```
(?size : string?, ?s : string?, ?win_size : int?,
 ?win_func : int?, ?overlap : float?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.video
```

Arguments:

- `size` (of type `string?`, which defaults to `null`): set video size. (default: 512x512)
- `s` (of type `string?`, which defaults to `null`): set video size. (default: 512x512)
- `win_size` (of type `int?`, which defaults to `null`): set window size. (default: 4096)
- `win_func` (of type `int?`, which defaults to `null`): set window function. (default: 1, possible values: 0 (rect), 4 (bartlett), 1 (hann), 1 (hanning), 2 (hamming), 3 (blackman), 5 (welch), 6 (flattop), 7 (bharris), 8 (bnuttall), 11 (bhann), 9 (sine), 10 (nuttall), 12 (lanczos), 13 (gauss), 14 (tukey), 15 (dolph), 16 (cauchy), 17 (parzen), 18 (poisson), 19 (bohman))
- `overlap` (of type `float?`, which defaults to `null`): set window overlap. (default: 0.5)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.showspectrum`

Ffmpeg filter: Convert input audio to a spectrum video output.

Type:
```
(?size : string?, ?s : string?, ?slide : int?,
 ?mode : int?, ?color : int?, ?scale : int?,
 ?fscale : int?, ?saturation : float?, ?win_func : int?,
 ?orientation : int?, ?overlap : float?, ?gain : float?,
 ?data : int?, ?rotation : float?, ?start : int?,
 ?stop : int?, ?fps : string?, ?legend : bool?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.video
```

Arguments:

- `size` (of type `string?`, which defaults to `null`): set video size. (default: 640x512)
- `s` (of type `string?`, which defaults to `null`): set video size. (default: 640x512)
- `slide` (of type `int?`, which defaults to `null`): set sliding mode. (default: 0, possible values: 0 (replace), 1 (scroll), 2 (fullframe), 3 (rscroll))
- `mode` (of type `int?`, which defaults to `null`): set channel display mode. (default: 0, possible values: 0 (combined), 1 (separate))
- `color` (of type `int?`, which defaults to `null`): set channel coloring. (default: 0, possible values: 0 (channel), 1 (intensity), 2 (rainbow), 3 (moreland), 4 (nebulae), 5 (fire), 6 (fiery), 7 (fruit), 8 (cool), 9 (magma), 10 (green), 11 (viridis), 12 (plasma), 13 (cividis), 14 (terrain))
- `scale` (of type `int?`, which defaults to `null`): set display scale. (default: 1, possible values: 0 (lin), 1 (sqrt), 2 (cbrt), 3 (log), 4 (4thrt), 5 (5thrt))
- `fscale` (of type `int?`, which defaults to `null`): set frequency scale. (default: 0, possible values: 0 (lin), 1 (log))
- `saturation` (of type `float?`, which defaults to `null`): color saturation multiplier. (default: 1.)
- `win_func` (of type `int?`, which defaults to `null`): set window function. (default: 1, possible values: 0 (rect), 4 (bartlett), 1 (hann), 1 (hanning), 2 (hamming), 3 (blackman), 5 (welch), 6 (flattop), 7 (bharris), 8 (bnuttall), 11 (bhann), 9 (sine), 10 (nuttall), 12 (lanczos), 13 (gauss), 14 (tukey), 15 (dolph), 16 (cauchy), 17 (parzen), 18 (poisson), 19 (bohman))
- `orientation` (of type `int?`, which defaults to `null`): set orientation. (default: 0, possible values: 0 (vertical), 1 (horizontal))
- `overlap` (of type `float?`, which defaults to `null`): set window overlap. (default: 0.)
- `gain` (of type `float?`, which defaults to `null`): set scale gain. (default: 1.)
- `data` (of type `int?`, which defaults to `null`): set data mode. (default: 0, possible values: 0 (magnitude), 1 (phase))
- `rotation` (of type `float?`, which defaults to `null`): color rotation. (default: 0.)
- `start` (of type `int?`, which defaults to `null`): start frequency. (default: 0)
- `stop` (of type `int?`, which defaults to `null`): stop frequency. (default: 0)
- `fps` (of type `string?`, which defaults to `null`): set video rate. (default: auto)
- `legend` (of type `bool?`, which defaults to `null`): draw legend. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.showspectrumpic`

Ffmpeg filter: Convert input audio to a spectrum video output single picture.

Type:
```
(?size : string?, ?s : string?, ?mode : int?,
 ?color : int?, ?scale : int?, ?fscale : int?,
 ?saturation : float?, ?win_func : int?,
 ?orientation : int?, ?gain : float?, ?legend : bool?,
 ?rotation : float?, ?start : int?, ?stop : int?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.video
```

Arguments:

- `size` (of type `string?`, which defaults to `null`): set video size. (default: 4096x2048)
- `s` (of type `string?`, which defaults to `null`): set video size. (default: 4096x2048)
- `mode` (of type `int?`, which defaults to `null`): set channel display mode. (default: 0, possible values: 0 (combined), 1 (separate))
- `color` (of type `int?`, which defaults to `null`): set channel coloring. (default: 1, possible values: 0 (channel), 1 (intensity), 2 (rainbow), 3 (moreland), 4 (nebulae), 5 (fire), 6 (fiery), 7 (fruit), 8 (cool), 9 (magma), 10 (green), 11 (viridis), 12 (plasma), 13 (cividis), 14 (terrain))
- `scale` (of type `int?`, which defaults to `null`): set display scale. (default: 3, possible values: 0 (lin), 1 (sqrt), 2 (cbrt), 3 (log), 4 (4thrt), 5 (5thrt))
- `fscale` (of type `int?`, which defaults to `null`): set frequency scale. (default: 0, possible values: 0 (lin), 1 (log))
- `saturation` (of type `float?`, which defaults to `null`): color saturation multiplier. (default: 1.)
- `win_func` (of type `int?`, which defaults to `null`): set window function. (default: 1, possible values: 0 (rect), 4 (bartlett), 1 (hann), 1 (hanning), 2 (hamming), 3 (blackman), 5 (welch), 6 (flattop), 7 (bharris), 8 (bnuttall), 11 (bhann), 9 (sine), 10 (nuttall), 12 (lanczos), 13 (gauss), 14 (tukey), 15 (dolph), 16 (cauchy), 17 (parzen), 18 (poisson), 19 (bohman))
- `orientation` (of type `int?`, which defaults to `null`): set orientation. (default: 0, possible values: 0 (vertical), 1 (horizontal))
- `gain` (of type `float?`, which defaults to `null`): set scale gain. (default: 1.)
- `legend` (of type `bool?`, which defaults to `null`): draw legend. (default: true)
- `rotation` (of type `float?`, which defaults to `null`): color rotation. (default: 0.)
- `start` (of type `int?`, which defaults to `null`): start frequency. (default: 0)
- `stop` (of type `int?`, which defaults to `null`): stop frequency. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.showvolume`

Ffmpeg filter: Convert input audio volume to video output.

Type:
```
(?rate : string?, ?r : string?, ?b : int?, ?w : int?,
 ?h : int?, ?f : float?, ?c : string?, ?t : bool?,
 ?v : bool?, ?dm : float?, ?dmc : string?, ?o : int?,
 ?s : int?, ?p : float?, ?m : int?, ?ds : int?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.video
```

Arguments:

- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `b` (of type `int?`, which defaults to `null`): set border width. (default: 1)
- `w` (of type `int?`, which defaults to `null`): set channel width. (default: 400)
- `h` (of type `int?`, which defaults to `null`): set channel height. (default: 20)
- `f` (of type `float?`, which defaults to `null`): set fade. (default: 0.95)
- `c` (of type `string?`, which defaults to `null`): set volume color expression. (default: PEAK*255+floor((1-PEAK)*255)*256+0xff000000)
- `t` (of type `bool?`, which defaults to `null`): display channel names. (default: true)
- `v` (of type `bool?`, which defaults to `null`): display volume value. (default: true)
- `dm` (of type `float?`, which defaults to `null`): duration for max value display. (default: 0.)
- `dmc` (of type `string?`, which defaults to `null`): set color of the max value line. (default: orange)
- `o` (of type `int?`, which defaults to `null`): set orientation. (default: 0, possible values: 0 (h), 1 (v))
- `s` (of type `int?`, which defaults to `null`): set step size. (default: 0)
- `p` (of type `float?`, which defaults to `null`): set background opacity. (default: 0.)
- `m` (of type `int?`, which defaults to `null`): set mode. (default: 0, possible values: 0 (p), 1 (r))
- `ds` (of type `int?`, which defaults to `null`): set display scale. (default: 0, possible values: 0 (lin), 1 (log))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.showwaves`

Ffmpeg filter: Convert input audio to a video output.

Type:
```
(?size : string?, ?s : string?, ?mode : int?, ?n : int?,
 ?rate : string?, ?r : string?, ?split_channels : bool?,
 ?colors : string?, ?scale : int?, ?draw : int?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.video
```

Arguments:

- `size` (of type `string?`, which defaults to `null`): set video size. (default: 600x240)
- `s` (of type `string?`, which defaults to `null`): set video size. (default: 600x240)
- `mode` (of type `int?`, which defaults to `null`): select display mode. (default: 0, possible values: 0 (point), 1 (line), 2 (p2p), 3 (cline))
- `n` (of type `int?`, which defaults to `null`): set how many samples to show in the same point. (default: 0)
- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `split_channels` (of type `bool?`, which defaults to `null`): draw channels separately. (default: false)
- `colors` (of type `string?`, which defaults to `null`): set channels colors. (default: red|green|blue|yellow|orange|lime|pink|magenta|brown)
- `scale` (of type `int?`, which defaults to `null`): set amplitude scale. (default: 0, possible values: 0 (lin), 1 (log), 2 (sqrt), 3 (cbrt))
- `draw` (of type `int?`, which defaults to `null`): set draw mode. (default: 0, possible values: 0 (scale), 1 (full))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.showwavespic`

Ffmpeg filter: Convert input audio to a video output single picture.

Type:
```
(?size : string?, ?s : string?, ?split_channels : bool?,
 ?colors : string?, ?scale : int?, ?draw : int?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.video
```

Arguments:

- `size` (of type `string?`, which defaults to `null`): set video size. (default: 600x240)
- `s` (of type `string?`, which defaults to `null`): set video size. (default: 600x240)
- `split_channels` (of type `bool?`, which defaults to `null`): draw channels separately. (default: false)
- `colors` (of type `string?`, which defaults to `null`): set channels colors. (default: red|green|blue|yellow|orange|lime|pink|magenta|brown)
- `scale` (of type `int?`, which defaults to `null`): set amplitude scale. (default: 0, possible values: 0 (lin), 1 (log), 2 (sqrt), 3 (cbrt))
- `draw` (of type `int?`, which defaults to `null`): set draw mode. (default: 0, possible values: 0 (scale), 1 (full))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.shuffleframes`

Ffmpeg filter: Shuffle video frames.

Type:
```
(?mapping : string?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `mapping` (of type `string?`, which defaults to `null`): set destination indexes of input frames. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.shuffleplanes`

Ffmpeg filter: Shuffle video planes.

Type:
```
(?map0 : int?, ?map1 : int?, ?map2 : int?, ?map3 : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `map0` (of type `int?`, which defaults to `null`): Index of the input plane to be used as the first output plane . (default: 0)
- `map1` (of type `int?`, which defaults to `null`): Index of the input plane to be used as the second output plane . (default: 1)
- `map2` (of type `int?`, which defaults to `null`): Index of the input plane to be used as the third output plane . (default: 2)
- `map3` (of type `int?`, which defaults to `null`): Index of the input plane to be used as the fourth output plane . (default: 3)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.sidechaincompress`

Ffmpeg filter: Sidechain compressor.

Type:
```
(?level_in : float?, ?mode : int?, ?threshold : float?,
 ?ratio : float?, ?attack : float?, ?release : float?,
 ?makeup : float?, ?knee : float?, ?link : int?,
 ?detection : int?, ?level_sc : float?, ?mix : float?,
 ffmpeg.filter.graph, ffmpeg.filter.audio,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `level_in` (of type `float?`, which defaults to `null`): set input gain. (default: 1.)
- `mode` (of type `int?`, which defaults to `null`): set mode. (default: 0, possible values: 0 (downward), 1 (upward))
- `threshold` (of type `float?`, which defaults to `null`): set threshold. (default: 0.125)
- `ratio` (of type `float?`, which defaults to `null`): set ratio. (default: 2.)
- `attack` (of type `float?`, which defaults to `null`): set attack. (default: 20.)
- `release` (of type `float?`, which defaults to `null`): set release. (default: 250.)
- `makeup` (of type `float?`, which defaults to `null`): set make up gain. (default: 1.)
- `knee` (of type `float?`, which defaults to `null`): set knee. (default: 2.82843)
- `link` (of type `int?`, which defaults to `null`): set link type. (default: 0, possible values: 0 (average), 1 (maximum))
- `detection` (of type `int?`, which defaults to `null`): set detection. (default: 1, possible values: 0 (peak), 1 (rms))
- `level_sc` (of type `float?`, which defaults to `null`): set sidechain gain. (default: 1.)
- `mix` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.sidechaingate`

Ffmpeg filter: Audio sidechain gate.

Type:
```
(?level_in : float?, ?mode : int?, ?range : float?,
 ?threshold : float?, ?ratio : float?, ?attack : float?,
 ?release : float?, ?makeup : float?, ?knee : float?,
 ?detection : int?, ?link : int?, ?level_sc : float?,
 ffmpeg.filter.graph, ffmpeg.filter.audio,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `level_in` (of type `float?`, which defaults to `null`): set input level. (default: 1.)
- `mode` (of type `int?`, which defaults to `null`): set mode. (default: 0, possible values: 0 (downward), 1 (upward))
- `range` (of type `float?`, which defaults to `null`): set max gain reduction. (default: 0.06125)
- `threshold` (of type `float?`, which defaults to `null`): set threshold. (default: 0.125)
- `ratio` (of type `float?`, which defaults to `null`): set ratio. (default: 2.)
- `attack` (of type `float?`, which defaults to `null`): set attack. (default: 20.)
- `release` (of type `float?`, which defaults to `null`): set release. (default: 250.)
- `makeup` (of type `float?`, which defaults to `null`): set makeup gain. (default: 1.)
- `knee` (of type `float?`, which defaults to `null`): set knee. (default: 2.828427125)
- `detection` (of type `int?`, which defaults to `null`): set detection. (default: 1, possible values: 0 (peak), 1 (rms))
- `link` (of type `int?`, which defaults to `null`): set link. (default: 0, possible values: 0 (average), 1 (maximum))
- `level_sc` (of type `float?`, which defaults to `null`): set sidechain gain. (default: 1.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.sidedata`

Ffmpeg filter: Manipulate video frame side data.

Type:
```
(?mode : int?, ?type : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `mode` (of type `int?`, which defaults to `null`): set a mode of operation. (default: 0, possible values: 0 (select), 1 (delete))
- `type` (of type `int?`, which defaults to `null`): set side data type. (default: -1, possible values: 0 (PANSCAN), 1 (A53_CC), 2 (STEREO3D), 3 (MATRIXENCODING), 4 (DOWNMIX_INFO), 5 (REPLAYGAIN), 6 (DISPLAYMATRIX), 7 (AFD), 8 (MOTION_VECTORS), 9 (SKIP_SAMPLES), 10 (AUDIO_SERVICE_TYPE), 11 (MASTERING_DISPLAY_METADATA), 12 (GOP_TIMECODE), 13 (SPHERICAL), 14 (CONTENT_LIGHT_LEVEL), 15 (ICC_PROFILE), 16 (QP_TABLE_PROPERTIES), 17 (QP_TABLE_DATA), 18 (S12M_TIMECOD), 19 (DYNAMIC_HDR_PLUS), 20 (REGIONS_OF_INTEREST))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.sierpinski`

Ffmpeg filter: Render a Sierpinski fractal.

Type:
```
(?size : string?, ?s : string?, ?rate : string?,
 ?r : string?, ?seed : int?, ?jump : int?, ?type : int?,
 ffmpeg.filter.graph) -> ffmpeg.filter.video
```

Arguments:

- `size` (of type `string?`, which defaults to `null`): set frame size. (default: 640x480)
- `s` (of type `string?`, which defaults to `null`): set frame size. (default: 640x480)
- `rate` (of type `string?`, which defaults to `null`): set frame rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set frame rate. (default: 25)
- `seed` (of type `int?`, which defaults to `null`): set the seed. (default: -1)
- `jump` (of type `int?`, which defaults to `null`): set the jump. (default: 100)
- `type` (of type `int?`, which defaults to `null`): set fractal type. (default: 0, possible values: 0 (carpet), 1 (triangle))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.signalstats`

Ffmpeg filter: Generate statistics from video analysis.

Type:
```
(?stat : int?, ?out : int?, ?c : string?,
 ?color : string?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `stat` (of type `int?`, which defaults to `null`): set statistics filters. (default: 0, possible values: 1 (tout), 2 (vrep), 4 (brng))
- `out` (of type `int?`, which defaults to `null`): set video filter. (default: -1, possible values: 0 (tout), 1 (vrep), 2 (brng))
- `c` (of type `string?`, which defaults to `null`): set highlight color. (default: yellow)
- `color` (of type `string?`, which defaults to `null`): set highlight color. (default: yellow)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.signature`

Ffmpeg filter: Calculate the MPEG-7 video signature This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime.

Type:
```
(?detectmode : int?, ?nb_inputs : int?,
 ?filename : string?, ?format : int?, ?th_d : int?,
 ?th_dc : int?, ?th_xh : int?, ?th_di : int?,
 ?th_it : float?, ffmpeg.filter.graph,
 [ffmpeg.filter.audio], [ffmpeg.filter.video]) ->
ffmpeg.filter.video
```

Arguments:

- `detectmode` (of type `int?`, which defaults to `null`): set the detectmode. (default: 0, possible values: 0 (off), 1 (full), 2 (fast))
- `nb_inputs` (of type `int?`, which defaults to `null`): number of inputs. (default: 1)
- `filename` (of type `string?`, which defaults to `null`): filename for output files. (default: )
- `format` (of type `int?`, which defaults to `null`): set output format. (default: 0, possible values: 0 (binary), 1 (xml))
- `th_d` (of type `int?`, which defaults to `null`): threshold to detect one word as similar. (default: 9000)
- `th_dc` (of type `int?`, which defaults to `null`): threshold to detect all words as similar. (default: 60000)
- `th_xh` (of type `int?`, which defaults to `null`): threshold to detect frames as similar. (default: 116)
- `th_di` (of type `int?`, which defaults to `null`): minimum length of matching sequence in frames. (default: 0)
- `th_it` (of type `float?`, which defaults to `null`): threshold for relation of good to all frames. (default: 0.5)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.silencedetect`

Ffmpeg filter: Detect silence.

Type:
```
(?n : float?, ?noise : float?, ?d : int?,
 ?duration : int?, ?mono : bool?, ?m : bool?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `n` (of type `float?`, which defaults to `null`): set noise tolerance. (default: 0.001)
- `noise` (of type `float?`, which defaults to `null`): set noise tolerance. (default: 0.001)
- `d` (of type `int?`, which defaults to `null`): set minimum duration in seconds. (default: 2000000)
- `duration` (of type `int?`, which defaults to `null`): set minimum duration in seconds. (default: 2000000)
- `mono` (of type `bool?`, which defaults to `null`): check each channel separately. (default: false)
- `m` (of type `bool?`, which defaults to `null`): check each channel separately. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.silenceremove`

Ffmpeg filter: Remove silence.

Type:
```
(?start_periods : int?, ?start_duration : int?,
 ?start_threshold : float?, ?start_silence : int?,
 ?start_mode : int?, ?stop_periods : int?,
 ?stop_duration : int?, ?stop_threshold : float?,
 ?stop_silence : int?, ?stop_mode : int?,
 ?detection : int?, ?window : float?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `start_periods` (of type `int?`, which defaults to `null`): Default: 0
- `start_duration` (of type `int?`, which defaults to `null`): set start duration of non-silence part. (default: 0)
- `start_threshold` (of type `float?`, which defaults to `null`): set threshold for start silence detection. (default: 0.)
- `start_silence` (of type `int?`, which defaults to `null`): set start duration of silence part to keep. (default: 0)
- `start_mode` (of type `int?`, which defaults to `null`): set which channel will trigger trimming from start. (default: 0, possible values: 0 (any), 1 (all))
- `stop_periods` (of type `int?`, which defaults to `null`): Default: 0
- `stop_duration` (of type `int?`, which defaults to `null`): set stop duration of non-silence part. (default: 0)
- `stop_threshold` (of type `float?`, which defaults to `null`): set threshold for stop silence detection. (default: 0.)
- `stop_silence` (of type `int?`, which defaults to `null`): set stop duration of silence part to keep. (default: 0)
- `stop_mode` (of type `int?`, which defaults to `null`): set which channel will trigger trimming from end. (default: 0, possible values: 0 (any), 1 (all))
- `detection` (of type `int?`, which defaults to `null`): set how silence is detected. (default: 1, possible values: 0 (peak), 1 (rms))
- `window` (of type `float?`, which defaults to `null`): set duration of window in seconds. (default: 0.02)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.sinc`

Ffmpeg filter: Generate a sinc kaiser-windowed low-pass, high-pass, band-pass, or band-reject FIR coefficients.

Type:
```
(?sample_rate : int?, ?r : int?, ?nb_samples : int?,
 ?n : int?, ?hp : float?, ?lp : float?, ?phase : float?,
 ?beta : float?, ?att : float?, ?round : bool?,
 ?hptaps : int?, ?lptaps : int?, ffmpeg.filter.graph) ->
ffmpeg.filter.audio
```

Arguments:

- `sample_rate` (of type `int?`, which defaults to `null`): set sample rate. (default: 44100)
- `r` (of type `int?`, which defaults to `null`): set sample rate. (default: 44100)
- `nb_samples` (of type `int?`, which defaults to `null`): set the number of samples per requested frame. (default: 1024)
- `n` (of type `int?`, which defaults to `null`): set the number of samples per requested frame. (default: 1024)
- `hp` (of type `float?`, which defaults to `null`): set high-pass filter frequency. (default: 0.)
- `lp` (of type `float?`, which defaults to `null`): set low-pass filter frequency. (default: 0.)
- `phase` (of type `float?`, which defaults to `null`): set filter phase response. (default: 50.)
- `beta` (of type `float?`, which defaults to `null`): set kaiser window beta. (default: -1.)
- `att` (of type `float?`, which defaults to `null`): set stop-band attenuation. (default: 120.)
- `round` (of type `bool?`, which defaults to `null`): enable rounding. (default: false)
- `hptaps` (of type `int?`, which defaults to `null`): set number of taps for high-pass filter. (default: 0)
- `lptaps` (of type `int?`, which defaults to `null`): set number of taps for low-pass filter. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.sine`

Ffmpeg filter: Generate sine wave audio signal.

Type:
```
(?frequency : float?, ?f : float?, ?beep_factor : float?,
 ?b : float?, ?sample_rate : int?, ?r : int?,
 ?duration : int?, ?d : int?,
 ?samples_per_frame : string?, ffmpeg.filter.graph) ->
ffmpeg.filter.audio
```

Arguments:

- `frequency` (of type `float?`, which defaults to `null`): set the sine frequency. (default: 440.)
- `f` (of type `float?`, which defaults to `null`): set the sine frequency. (default: 440.)
- `beep_factor` (of type `float?`, which defaults to `null`): set the beep frequency factor. (default: 0.)
- `b` (of type `float?`, which defaults to `null`): set the beep frequency factor. (default: 0.)
- `sample_rate` (of type `int?`, which defaults to `null`): set the sample rate. (default: 44100)
- `r` (of type `int?`, which defaults to `null`): set the sample rate. (default: 44100)
- `duration` (of type `int?`, which defaults to `null`): set the audio duration. (default: 0)
- `d` (of type `int?`, which defaults to `null`): set the audio duration. (default: 0)
- `samples_per_frame` (of type `string?`, which defaults to `null`): set the number of samples per frame. (default: 1024)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.smartblur`

Ffmpeg filter: Blur the input video without impacting the outlines.

Type:
```
(?luma_radius : float?, ?lr : float?,
 ?luma_strength : float?, ?ls : float?,
 ?luma_threshold : int?, ?lt : int?,
 ?chroma_radius : float?, ?cr : float?,
 ?chroma_strength : float?, ?cs : float?,
 ?chroma_threshold : int?, ?ct : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `luma_radius` (of type `float?`, which defaults to `null`): set luma radius. (default: 1.)
- `lr` (of type `float?`, which defaults to `null`): set luma radius. (default: 1.)
- `luma_strength` (of type `float?`, which defaults to `null`): set luma strength. (default: 1.)
- `ls` (of type `float?`, which defaults to `null`): set luma strength. (default: 1.)
- `luma_threshold` (of type `int?`, which defaults to `null`): set luma threshold. (default: 0)
- `lt` (of type `int?`, which defaults to `null`): set luma threshold. (default: 0)
- `chroma_radius` (of type `float?`, which defaults to `null`): set chroma radius. (default: -0.9)
- `cr` (of type `float?`, which defaults to `null`): set chroma radius. (default: -0.9)
- `chroma_strength` (of type `float?`, which defaults to `null`): set chroma strength. (default: -2.)
- `cs` (of type `float?`, which defaults to `null`): set chroma strength. (default: -2.)
- `chroma_threshold` (of type `int?`, which defaults to `null`): set chroma threshold. (default: -31)
- `ct` (of type `int?`, which defaults to `null`): set chroma threshold. (default: -31)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.smptebars`

Ffmpeg filter: Generate SMPTE color bars.

Type:
```
(?size : string?, ?s : string?, ?rate : string?,
 ?r : string?, ?duration : int?, ?d : int?,
 ?sar : string?, ffmpeg.filter.graph) ->
ffmpeg.filter.video
```

Arguments:

- `size` (of type `string?`, which defaults to `null`): set video size. (default: 320x240)
- `s` (of type `string?`, which defaults to `null`): set video size. (default: 320x240)
- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `duration` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `d` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `sar` (of type `string?`, which defaults to `null`): set video sample aspect ratio. (default: 1/1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.smptehdbars`

Ffmpeg filter: Generate SMPTE HD color bars.

Type:
```
(?size : string?, ?s : string?, ?rate : string?,
 ?r : string?, ?duration : int?, ?d : int?,
 ?sar : string?, ffmpeg.filter.graph) ->
ffmpeg.filter.video
```

Arguments:

- `size` (of type `string?`, which defaults to `null`): set video size. (default: 320x240)
- `s` (of type `string?`, which defaults to `null`): set video size. (default: 320x240)
- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `duration` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `d` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `sar` (of type `string?`, which defaults to `null`): set video sample aspect ratio. (default: 1/1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.sobel`

Ffmpeg filter: Apply sobel operator.

Type:
```
(?planes : int?, ?scale : float?, ?delta : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `planes` (of type `int?`, which defaults to `null`): set planes to filter. (default: 15)
- `scale` (of type `float?`, which defaults to `null`): set scale. (default: 1.)
- `delta` (of type `float?`, which defaults to `null`): set delta. (default: 0.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.sobel_opencl`

Ffmpeg filter: Apply sobel operator

Type:
```
(?planes : int?, ?scale : float?, ?delta : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `planes` (of type `int?`, which defaults to `null`): set planes to filter. (default: 15)
- `scale` (of type `float?`, which defaults to `null`): set scale. (default: 1.)
- `delta` (of type `float?`, which defaults to `null`): set delta. (default: 0.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.sofalizer`

Ffmpeg filter: SOFAlizer (Spatially Oriented Format for Acoustics).

Type:
```
(?sofa : string?, ?gain : float?, ?rotation : float?,
 ?elevation : float?, ?radius : float?, ?type : int?,
 ?speakers : string?, ?lfegain : float?,
 ?framesize : int?, ?normalize : bool?,
 ?interpolate : bool?, ?minphase : bool?,
 ?anglestep : float?, ?radstep : float?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `sofa` (of type `string?`, which defaults to `null`): sofa filename
- `gain` (of type `float?`, which defaults to `null`): set gain in dB. (default: 0.)
- `rotation` (of type `float?`, which defaults to `null`): set rotation. (default: 0.)
- `elevation` (of type `float?`, which defaults to `null`): set elevation. (default: 0.)
- `radius` (of type `float?`, which defaults to `null`): set radius. (default: 1.)
- `type` (of type `int?`, which defaults to `null`): set processing. (default: 1, possible values: 0 (time), 1 (freq))
- `speakers` (of type `string?`, which defaults to `null`): set speaker custom positions
- `lfegain` (of type `float?`, which defaults to `null`): set lfe gain. (default: 0.)
- `framesize` (of type `int?`, which defaults to `null`): set frame size. (default: 1024)
- `normalize` (of type `bool?`, which defaults to `null`): normalize IRs. (default: true)
- `interpolate` (of type `bool?`, which defaults to `null`): interpolate IRs from neighbors. (default: false)
- `minphase` (of type `bool?`, which defaults to `null`): minphase IRs. (default: false)
- `anglestep` (of type `float?`, which defaults to `null`): set neighbor search angle step. (default: 0.5)
- `radstep` (of type `float?`, which defaults to `null`): set neighbor search radius step. (default: 0.01)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.spectrumsynth`

Ffmpeg filter: Convert input spectrum videos to audio output.

Type:
```
(?sample_rate : int?, ?channels : int?, ?scale : int?,
 ?slide : int?, ?win_func : int?, ?overlap : float?,
 ?orientation : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video, ffmpeg.filter.video) ->
ffmpeg.filter.audio
```

Arguments:

- `sample_rate` (of type `int?`, which defaults to `null`): set sample rate. (default: 44100)
- `channels` (of type `int?`, which defaults to `null`): set channels. (default: 1)
- `scale` (of type `int?`, which defaults to `null`): set input amplitude scale. (default: 1, possible values: 0 (lin), 1 (log))
- `slide` (of type `int?`, which defaults to `null`): set input sliding mode. (default: 2, possible values: 0 (replace), 1 (scroll), 2 (fullframe), 3 (rscroll))
- `win_func` (of type `int?`, which defaults to `null`): set window function. (default: 0, possible values: 0 (rect), 4 (bartlett), 1 (hann), 1 (hanning), 2 (hamming), 9 (sine))
- `overlap` (of type `float?`, which defaults to `null`): set window overlap. (default: 1.)
- `orientation` (of type `int?`, which defaults to `null`): set orientation. (default: 0, possible values: 0 (vertical), 1 (horizontal))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.split`

Ffmpeg filter: Pass on the input to N video outputs. This filter has dynamic outputs: returned value is a tuple of audio and video outputs. Total number of outputs is determined at runtime.

Type:
```
(?outputs : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) ->
[ffmpeg.filter.audio] * [ffmpeg.filter.video]
```

Arguments:

- `outputs` (of type `int?`, which defaults to `null`): set number of outputs. (default: 2)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.spp`

Ffmpeg filter: Apply a simple post processing filter.

Type:
```
(?quality : int?, ?qp : int?, ?mode : int?,
 ?use_bframe_qp : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `quality` (of type `int?`, which defaults to `null`): set quality. (default: 3)
- `qp` (of type `int?`, which defaults to `null`): force a constant quantizer parameter. (default: 0)
- `mode` (of type `int?`, which defaults to `null`): set thresholding mode. (default: 0, possible values: 0 (hard), 1 (soft))
- `use_bframe_qp` (of type `bool?`, which defaults to `null`): use B-frames' QP. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.sr`

Ffmpeg filter: Apply DNN-based image super resolution to the input.

Type:
```
(?dnn_backend : int?, ?scale_factor : int?,
 ?model : string?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `dnn_backend` (of type `int?`, which defaults to `null`): DNN backend used for model execution. (default: 0, possible values: 0 (native))
- `scale_factor` (of type `int?`, which defaults to `null`): scale factor for SRCNN model. (default: 2)
- `model` (of type `string?`, which defaults to `null`): path to model file specifying network architecture and its parameters
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.ssim`

Ffmpeg filter: Calculate the SSIM between two video streams.

Type:
```
(?stats_file : string?, ?f : string?,
 ffmpeg.filter.graph, ffmpeg.filter.video,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `stats_file` (of type `string?`, which defaults to `null`): Set file where to store per-frame difference information
- `f` (of type `string?`, which defaults to `null`): Set file where to store per-frame difference information
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.stereo3d`

Ffmpeg filter: Convert video stereoscopic 3D view.

Type:
```
(?in : int?, ?out : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `in` (of type `int?`, which defaults to `null`): set input format. (default: 18, possible values: 24 (ab2l), 24 (tb2l), 25 (ab2r), 25 (tb2r), 22 (abl), 22 (tbl), 23 (abr), 23 (tbr), 26 (al), 27 (ar), 20 (sbs2l), 21 (sbs2r), 18 (sbsl), 19 (sbsr), 16 (irl), 17 (irr), 30 (icl), 31 (icr))
- `out` (of type `int?`, which defaults to `null`): set output format. (default: 3, possible values: 24 (ab2l), 24 (tb2l), 25 (ab2r), 25 (tb2r), 22 (abl), 22 (tbl), 23 (abr), 23 (tbr), 6 (agmc), 7 (agmd), 4 (agmg), 5 (agmh), 26 (al), 27 (ar), 12 (arbg), 2 (arcc), 3 (arcd), 0 (arcg), 1 (arch), 13 (argg), 10 (aybc), 11 (aybd), 8 (aybg), 9 (aybh), 16 (irl), 17 (irr), 14 (ml), 15 (mr), 20 (sbs2l), 21 (sbs2r), 18 (sbsl), 19 (sbsr), 28 (chl), 29 (chr), 30 (icl), 31 (icr), 32 (hdmi))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.stereotools`

Ffmpeg filter: Apply various stereo tools.

Type:
```
(?level_in : float?, ?level_out : float?,
 ?balance_in : float?, ?balance_out : float?,
 ?softclip : bool?, ?mutel : bool?, ?muter : bool?,
 ?phasel : bool?, ?phaser : bool?, ?mode : int?,
 ?slev : float?, ?sbal : float?, ?mlev : float?,
 ?mpan : float?, ?base : float?, ?delay : float?,
 ?sclevel : float?, ?phase : float?, ?bmode_in : int?,
 ?bmode_out : int?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `level_in` (of type `float?`, which defaults to `null`): set level in. (default: 1.)
- `level_out` (of type `float?`, which defaults to `null`): set level out. (default: 1.)
- `balance_in` (of type `float?`, which defaults to `null`): set balance in. (default: 0.)
- `balance_out` (of type `float?`, which defaults to `null`): set balance out. (default: 0.)
- `softclip` (of type `bool?`, which defaults to `null`): enable softclip. (default: false)
- `mutel` (of type `bool?`, which defaults to `null`): mute L. (default: false)
- `muter` (of type `bool?`, which defaults to `null`): mute R. (default: false)
- `phasel` (of type `bool?`, which defaults to `null`): phase L. (default: false)
- `phaser` (of type `bool?`, which defaults to `null`): phase R. (default: false)
- `mode` (of type `int?`, which defaults to `null`): set stereo mode. (default: 0, possible values: 0 (lr>lr), 1 (lr>ms), 2 (ms>lr), 3 (lr>ll), 4 (lr>rr), 5 (lr>l+r), 6 (lr>rl), 7 (ms>ll), 8 (ms>rr))
- `slev` (of type `float?`, which defaults to `null`): set side level. (default: 1.)
- `sbal` (of type `float?`, which defaults to `null`): set side balance. (default: 0.)
- `mlev` (of type `float?`, which defaults to `null`): set middle level. (default: 1.)
- `mpan` (of type `float?`, which defaults to `null`): set middle pan. (default: 0.)
- `base` (of type `float?`, which defaults to `null`): set stereo base. (default: 0.)
- `delay` (of type `float?`, which defaults to `null`): set delay. (default: 0.)
- `sclevel` (of type `float?`, which defaults to `null`): set S/C level. (default: 1.)
- `phase` (of type `float?`, which defaults to `null`): set stereo phase. (default: 0.)
- `bmode_in` (of type `int?`, which defaults to `null`): set balance in mode. (default: 0, possible values: 0 (balance), 1 (amplitude), 2 (power))
- `bmode_out` (of type `int?`, which defaults to `null`): set balance out mode. (default: 0, possible values: 0 (balance), 1 (amplitude), 2 (power))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.stereowiden`

Ffmpeg filter: Apply stereo widening effect.

Type:
```
(?delay : float?, ?feedback : float?,
 ?crossfeed : float?, ?drymix : float?,
 ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `delay` (of type `float?`, which defaults to `null`): set delay time. (default: 20.)
- `feedback` (of type `float?`, which defaults to `null`): set feedback gain. (default: 0.3)
- `crossfeed` (of type `float?`, which defaults to `null`): set cross feed. (default: 0.3)
- `drymix` (of type `float?`, which defaults to `null`): set dry-mix. (default: 0.8)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.streamselect`

Ffmpeg filter: Select video streams This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime. This filter has dynamic outputs: returned value is a tuple of audio and video outputs. Total number of outputs is determined at runtime.

Type:
```
(?inputs : int?, ?map : string?, ffmpeg.filter.graph,
 [ffmpeg.filter.audio], [ffmpeg.filter.video]) ->
[ffmpeg.filter.audio] * [ffmpeg.filter.video]
```

Arguments:

- `inputs` (of type `int?`, which defaults to `null`): number of input streams. (default: 2)
- `map` (of type `string?`, which defaults to `null`): input indexes to remap to outputs
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.subtitles`

Ffmpeg filter: Render text subtitles onto input video using the libass library.

Type:
```
(?filename : string?, ?f : string?,
 ?original_size : string?, ?fontsdir : string?,
 ?alpha : bool?, ?charenc : string?,
 ?stream_index : int?, ?si : int?,
 ?force_style : string?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `filename` (of type `string?`, which defaults to `null`): set the filename of file to read
- `f` (of type `string?`, which defaults to `null`): set the filename of file to read
- `original_size` (of type `string?`, which defaults to `null`): set the size of the original video (used to scale fonts)
- `fontsdir` (of type `string?`, which defaults to `null`): set the directory containing the fonts to read
- `alpha` (of type `bool?`, which defaults to `null`): enable processing of alpha channel. (default: false)
- `charenc` (of type `string?`, which defaults to `null`): set input character encoding
- `stream_index` (of type `int?`, which defaults to `null`): set stream index. (default: -1)
- `si` (of type `int?`, which defaults to `null`): set stream index. (default: -1)
- `force_style` (of type `string?`, which defaults to `null`): force subtitle style
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.super2xsai`

Ffmpeg filter: Scale the input by 2x using the Super2xSaI pixel art algorithm.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.superequalizer`

Ffmpeg filter: Apply 18 band equalization filter.

Type:
```
(?1b : float?, ?2b : float?, ?3b : float?, ?4b : float?,
 ?5b : float?, ?6b : float?, ?7b : float?, ?8b : float?,
 ?9b : float?, ?10b : float?, ?11b : float?,
 ?12b : float?, ?13b : float?, ?14b : float?,
 ?15b : float?, ?16b : float?, ?17b : float?,
 ?18b : float?, ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `1b` (of type `float?`, which defaults to `null`): set 65Hz band gain. (default: 1.)
- `2b` (of type `float?`, which defaults to `null`): set 92Hz band gain. (default: 1.)
- `3b` (of type `float?`, which defaults to `null`): set 131Hz band gain. (default: 1.)
- `4b` (of type `float?`, which defaults to `null`): set 185Hz band gain. (default: 1.)
- `5b` (of type `float?`, which defaults to `null`): set 262Hz band gain. (default: 1.)
- `6b` (of type `float?`, which defaults to `null`): set 370Hz band gain. (default: 1.)
- `7b` (of type `float?`, which defaults to `null`): set 523Hz band gain. (default: 1.)
- `8b` (of type `float?`, which defaults to `null`): set 740Hz band gain. (default: 1.)
- `9b` (of type `float?`, which defaults to `null`): set 1047Hz band gain. (default: 1.)
- `10b` (of type `float?`, which defaults to `null`): set 1480Hz band gain. (default: 1.)
- `11b` (of type `float?`, which defaults to `null`): set 2093Hz band gain. (default: 1.)
- `12b` (of type `float?`, which defaults to `null`): set 2960Hz band gain. (default: 1.)
- `13b` (of type `float?`, which defaults to `null`): set 4186Hz band gain. (default: 1.)
- `14b` (of type `float?`, which defaults to `null`): set 5920Hz band gain. (default: 1.)
- `15b` (of type `float?`, which defaults to `null`): set 8372Hz band gain. (default: 1.)
- `16b` (of type `float?`, which defaults to `null`): set 11840Hz band gain. (default: 1.)
- `17b` (of type `float?`, which defaults to `null`): set 16744Hz band gain. (default: 1.)
- `18b` (of type `float?`, which defaults to `null`): set 20000Hz band gain. (default: 1.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.surround`

Ffmpeg filter: Apply audio surround upmix filter.

Type:
```
(?chl_out : string?, ?chl_in : string?,
 ?level_in : float?, ?level_out : float?, ?lfe : bool?,
 ?lfe_low : int?, ?lfe_high : int?, ?lfe_mode : int?,
 ?angle : float?, ?fc_in : float?, ?fc_out : float?,
 ?fl_in : float?, ?fl_out : float?, ?fr_in : float?,
 ?fr_out : float?, ?sl_in : float?, ?sl_out : float?,
 ?sr_in : float?, ?sr_out : float?, ?bl_in : float?,
 ?bl_out : float?, ?br_in : float?, ?br_out : float?,
 ?bc_in : float?, ?bc_out : float?, ?lfe_in : float?,
 ?lfe_out : float?, ?allx : float?, ?ally : float?,
 ?fcx : float?, ?flx : float?, ?frx : float?,
 ?blx : float?, ?brx : float?, ?slx : float?,
 ?srx : float?, ?bcx : float?, ?fcy : float?,
 ?fly : float?, ?fry : float?, ?bly : float?,
 ?bry : float?, ?sly : float?, ?sry : float?,
 ?bcy : float?, ?win_size : int?, ?win_func : int?,
 ?overlap : float?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `chl_out` (of type `string?`, which defaults to `null`): set output channel layout. (default: 5.1)
- `chl_in` (of type `string?`, which defaults to `null`): set input channel layout. (default: stereo)
- `level_in` (of type `float?`, which defaults to `null`): set input level. (default: 1.)
- `level_out` (of type `float?`, which defaults to `null`): set output level. (default: 1.)
- `lfe` (of type `bool?`, which defaults to `null`): output LFE. (default: true)
- `lfe_low` (of type `int?`, which defaults to `null`): LFE low cut off. (default: 128)
- `lfe_high` (of type `int?`, which defaults to `null`): LFE high cut off. (default: 256)
- `lfe_mode` (of type `int?`, which defaults to `null`): set LFE channel mode. (default: 0, possible values: 0 (add), 1 (sub))
- `angle` (of type `float?`, which defaults to `null`): set soundfield transform angle. (default: 90.)
- `fc_in` (of type `float?`, which defaults to `null`): set front center channel input level. (default: 1.)
- `fc_out` (of type `float?`, which defaults to `null`): set front center channel output level. (default: 1.)
- `fl_in` (of type `float?`, which defaults to `null`): set front left channel input level. (default: 1.)
- `fl_out` (of type `float?`, which defaults to `null`): set front left channel output level. (default: 1.)
- `fr_in` (of type `float?`, which defaults to `null`): set front right channel input level. (default: 1.)
- `fr_out` (of type `float?`, which defaults to `null`): set front right channel output level. (default: 1.)
- `sl_in` (of type `float?`, which defaults to `null`): set side left channel input level. (default: 1.)
- `sl_out` (of type `float?`, which defaults to `null`): set side left channel output level. (default: 1.)
- `sr_in` (of type `float?`, which defaults to `null`): set side right channel input level. (default: 1.)
- `sr_out` (of type `float?`, which defaults to `null`): set side right channel output level. (default: 1.)
- `bl_in` (of type `float?`, which defaults to `null`): set back left channel input level. (default: 1.)
- `bl_out` (of type `float?`, which defaults to `null`): set back left channel output level. (default: 1.)
- `br_in` (of type `float?`, which defaults to `null`): set back right channel input level. (default: 1.)
- `br_out` (of type `float?`, which defaults to `null`): set back right channel output level. (default: 1.)
- `bc_in` (of type `float?`, which defaults to `null`): set back center channel input level. (default: 1.)
- `bc_out` (of type `float?`, which defaults to `null`): set back center channel output level. (default: 1.)
- `lfe_in` (of type `float?`, which defaults to `null`): set lfe channel input level. (default: 1.)
- `lfe_out` (of type `float?`, which defaults to `null`): set lfe channel output level. (default: 1.)
- `allx` (of type `float?`, which defaults to `null`): set all channel's x spread. (default: -1.)
- `ally` (of type `float?`, which defaults to `null`): set all channel's y spread. (default: -1.)
- `fcx` (of type `float?`, which defaults to `null`): set front center channel x spread. (default: 1.)
- `flx` (of type `float?`, which defaults to `null`): set front left channel x spread. (default: 1.)
- `frx` (of type `float?`, which defaults to `null`): set front right channel x spread. (default: 1.)
- `blx` (of type `float?`, which defaults to `null`): set back left channel x spread. (default: 1.)
- `brx` (of type `float?`, which defaults to `null`): set back right channel x spread. (default: 1.)
- `slx` (of type `float?`, which defaults to `null`): set side left channel x spread. (default: 1.)
- `srx` (of type `float?`, which defaults to `null`): set side right channel x spread. (default: 1.)
- `bcx` (of type `float?`, which defaults to `null`): set back center channel x spread. (default: 1.)
- `fcy` (of type `float?`, which defaults to `null`): set front center channel y spread. (default: 1.)
- `fly` (of type `float?`, which defaults to `null`): set front left channel y spread. (default: 1.)
- `fry` (of type `float?`, which defaults to `null`): set front right channel y spread. (default: 1.)
- `bly` (of type `float?`, which defaults to `null`): set back left channel y spread. (default: 1.)
- `bry` (of type `float?`, which defaults to `null`): set back right channel y spread. (default: 1.)
- `sly` (of type `float?`, which defaults to `null`): set side left channel y spread. (default: 1.)
- `sry` (of type `float?`, which defaults to `null`): set side right channel y spread. (default: 1.)
- `bcy` (of type `float?`, which defaults to `null`): set back center channel y spread. (default: 1.)
- `win_size` (of type `int?`, which defaults to `null`): set window size. (default: 4096)
- `win_func` (of type `int?`, which defaults to `null`): set window function. (default: 1, possible values: 0 (rect), 4 (bartlett), 1 (hann), 1 (hanning), 2 (hamming), 3 (blackman), 5 (welch), 6 (flattop), 7 (bharris), 8 (bnuttall), 11 (bhann), 9 (sine), 10 (nuttall), 12 (lanczos), 13 (gauss), 14 (tukey), 15 (dolph), 16 (cauchy), 17 (parzen), 18 (poisson), 19 (bohman))
- `overlap` (of type `float?`, which defaults to `null`): set window overlap. (default: 0.5)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.swaprect`

Ffmpeg filter: Swap 2 rectangular objects in video.

Type:
```
(?w : string?, ?h : string?, ?x1 : string?,
 ?y1 : string?, ?x2 : string?, ?y2 : string?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `w` (of type `string?`, which defaults to `null`): set rect width. (default: w/2)
- `h` (of type `string?`, which defaults to `null`): set rect height. (default: h/2)
- `x1` (of type `string?`, which defaults to `null`): set 1st rect x top left coordinate. (default: w/2)
- `y1` (of type `string?`, which defaults to `null`): set 1st rect y top left coordinate. (default: h/2)
- `x2` (of type `string?`, which defaults to `null`): set 2nd rect x top left coordinate. (default: 0)
- `y2` (of type `string?`, which defaults to `null`): set 2nd rect y top left coordinate. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.swapuv`

Ffmpeg filter: Swap U and V components.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.tblend`

Ffmpeg filter: Blend successive frames.

Type:
```
(?c0_mode : int?, ?c1_mode : int?, ?c2_mode : int?,
 ?c3_mode : int?, ?all_mode : int?, ?c0_expr : string?,
 ?c1_expr : string?, ?c2_expr : string?,
 ?c3_expr : string?, ?all_expr : string?,
 ?c0_opacity : float?, ?c1_opacity : float?,
 ?c2_opacity : float?, ?c3_opacity : float?,
 ?all_opacity : float?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `c0_mode` (of type `int?`, which defaults to `null`): set component #0 blend mode. (default: 0, possible values: 1 (addition), 28 (addition128), 28 (grainmerge), 2 (and), 3 (average), 4 (burn), 5 (darken), 6 (difference), 7 (difference128), 7 (grainextract), 8 (divide), 9 (dodge), 10 (exclusion), 32 (extremity), 31 (freeze), 27 (glow), 11 (hardlight), 25 (hardmix), 30 (heat), 12 (lighten), 26 (linearlight), 13 (multiply), 29 (multiply128), 14 (negation), 0 (normal), 15 (or), 16 (overlay), 17 (phoenix), 18 (pinlight), 19 (reflect), 20 (screen), 21 (softlight), 22 (subtract), 23 (vividlight), 24 (xor))
- `c1_mode` (of type `int?`, which defaults to `null`): set component #1 blend mode. (default: 0, possible values: 1 (addition), 28 (addition128), 28 (grainmerge), 2 (and), 3 (average), 4 (burn), 5 (darken), 6 (difference), 7 (difference128), 7 (grainextract), 8 (divide), 9 (dodge), 10 (exclusion), 32 (extremity), 31 (freeze), 27 (glow), 11 (hardlight), 25 (hardmix), 30 (heat), 12 (lighten), 26 (linearlight), 13 (multiply), 29 (multiply128), 14 (negation), 0 (normal), 15 (or), 16 (overlay), 17 (phoenix), 18 (pinlight), 19 (reflect), 20 (screen), 21 (softlight), 22 (subtract), 23 (vividlight), 24 (xor))
- `c2_mode` (of type `int?`, which defaults to `null`): set component #2 blend mode. (default: 0, possible values: 1 (addition), 28 (addition128), 28 (grainmerge), 2 (and), 3 (average), 4 (burn), 5 (darken), 6 (difference), 7 (difference128), 7 (grainextract), 8 (divide), 9 (dodge), 10 (exclusion), 32 (extremity), 31 (freeze), 27 (glow), 11 (hardlight), 25 (hardmix), 30 (heat), 12 (lighten), 26 (linearlight), 13 (multiply), 29 (multiply128), 14 (negation), 0 (normal), 15 (or), 16 (overlay), 17 (phoenix), 18 (pinlight), 19 (reflect), 20 (screen), 21 (softlight), 22 (subtract), 23 (vividlight), 24 (xor))
- `c3_mode` (of type `int?`, which defaults to `null`): set component #3 blend mode. (default: 0, possible values: 1 (addition), 28 (addition128), 28 (grainmerge), 2 (and), 3 (average), 4 (burn), 5 (darken), 6 (difference), 7 (difference128), 7 (grainextract), 8 (divide), 9 (dodge), 10 (exclusion), 32 (extremity), 31 (freeze), 27 (glow), 11 (hardlight), 25 (hardmix), 30 (heat), 12 (lighten), 26 (linearlight), 13 (multiply), 29 (multiply128), 14 (negation), 0 (normal), 15 (or), 16 (overlay), 17 (phoenix), 18 (pinlight), 19 (reflect), 20 (screen), 21 (softlight), 22 (subtract), 23 (vividlight), 24 (xor))
- `all_mode` (of type `int?`, which defaults to `null`): set blend mode for all components. (default: -1, possible values: 1 (addition), 28 (addition128), 28 (grainmerge), 2 (and), 3 (average), 4 (burn), 5 (darken), 6 (difference), 7 (difference128), 7 (grainextract), 8 (divide), 9 (dodge), 10 (exclusion), 32 (extremity), 31 (freeze), 27 (glow), 11 (hardlight), 25 (hardmix), 30 (heat), 12 (lighten), 26 (linearlight), 13 (multiply), 29 (multiply128), 14 (negation), 0 (normal), 15 (or), 16 (overlay), 17 (phoenix), 18 (pinlight), 19 (reflect), 20 (screen), 21 (softlight), 22 (subtract), 23 (vividlight), 24 (xor))
- `c0_expr` (of type `string?`, which defaults to `null`): set color component #0 expression
- `c1_expr` (of type `string?`, which defaults to `null`): set color component #1 expression
- `c2_expr` (of type `string?`, which defaults to `null`): set color component #2 expression
- `c3_expr` (of type `string?`, which defaults to `null`): set color component #3 expression
- `all_expr` (of type `string?`, which defaults to `null`): set expression for all color components
- `c0_opacity` (of type `float?`, which defaults to `null`): set color component #0 opacity. (default: 1.)
- `c1_opacity` (of type `float?`, which defaults to `null`): set color component #1 opacity. (default: 1.)
- `c2_opacity` (of type `float?`, which defaults to `null`): set color component #2 opacity. (default: 1.)
- `c3_opacity` (of type `float?`, which defaults to `null`): set color component #3 opacity. (default: 1.)
- `all_opacity` (of type `float?`, which defaults to `null`): set opacity for all color components. (default: 1.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.telecine`

Ffmpeg filter: Apply a telecine pattern.

Type:
```
(?first_field : int?, ?pattern : string?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `first_field` (of type `int?`, which defaults to `null`): select first field. (default: 0, possible values: 0 (top), 0 (t), 1 (bottom), 1 (b))
- `pattern` (of type `string?`, which defaults to `null`): pattern that describe for how many fields a frame is to be displayed. (default: 23)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.testsrc`

Ffmpeg filter: Generate test pattern.

Type:
```
(?size : string?, ?s : string?, ?rate : string?,
 ?r : string?, ?duration : int?, ?d : int?,
 ?sar : string?, ?decimals : int?, ?n : int?,
 ffmpeg.filter.graph) -> ffmpeg.filter.video
```

Arguments:

- `size` (of type `string?`, which defaults to `null`): set video size. (default: 320x240)
- `s` (of type `string?`, which defaults to `null`): set video size. (default: 320x240)
- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `duration` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `d` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `sar` (of type `string?`, which defaults to `null`): set video sample aspect ratio. (default: 1/1)
- `decimals` (of type `int?`, which defaults to `null`): set number of decimals to show. (default: 0)
- `n` (of type `int?`, which defaults to `null`): set number of decimals to show. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.testsrc2`

Ffmpeg filter: Generate another test pattern.

Type:
```
(?size : string?, ?s : string?, ?rate : string?,
 ?r : string?, ?duration : int?, ?d : int?,
 ?sar : string?, ?alpha : int?, ffmpeg.filter.graph) ->
ffmpeg.filter.video
```

Arguments:

- `size` (of type `string?`, which defaults to `null`): set video size. (default: 320x240)
- `s` (of type `string?`, which defaults to `null`): set video size. (default: 320x240)
- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `duration` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `d` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `sar` (of type `string?`, which defaults to `null`): set video sample aspect ratio. (default: 1/1)
- `alpha` (of type `int?`, which defaults to `null`): set global alpha (opacity). (default: 255)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.thistogram`

Ffmpeg filter: Compute and draw a temporal histogram.

Type:
```
(?width : int?, ?w : int?, ?display_mode : int?,
 ?d : int?, ?levels_mode : int?, ?m : int?,
 ?components : int?, ?c : int?, ?bgopacity : float?,
 ?b : float?, ?envelope : bool?, ?e : bool?,
 ?ecolor : string?, ?ec : string?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `width` (of type `int?`, which defaults to `null`): set width. (default: 0)
- `w` (of type `int?`, which defaults to `null`): set width. (default: 0)
- `display_mode` (of type `int?`, which defaults to `null`): set display mode. (default: 2, possible values: 0 (overlay), 1 (parade), 2 (stack))
- `d` (of type `int?`, which defaults to `null`): set display mode. (default: 2, possible values: 0 (overlay), 1 (parade), 2 (stack))
- `levels_mode` (of type `int?`, which defaults to `null`): set levels mode. (default: 0, possible values: 0 (linear), 1 (logarithmic))
- `m` (of type `int?`, which defaults to `null`): set levels mode. (default: 0, possible values: 0 (linear), 1 (logarithmic))
- `components` (of type `int?`, which defaults to `null`): set color components to display. (default: 7)
- `c` (of type `int?`, which defaults to `null`): set color components to display. (default: 7)
- `bgopacity` (of type `float?`, which defaults to `null`): set background opacity. (default: 0.9)
- `b` (of type `float?`, which defaults to `null`): set background opacity. (default: 0.9)
- `envelope` (of type `bool?`, which defaults to `null`): display envelope. (default: false)
- `e` (of type `bool?`, which defaults to `null`): display envelope. (default: false)
- `ecolor` (of type `string?`, which defaults to `null`): set envelope color. (default: gold)
- `ec` (of type `string?`, which defaults to `null`): set envelope color. (default: gold)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.threshold`

Ffmpeg filter: Threshold first video stream using other video streams.

Type:
```
(?planes : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video, ffmpeg.filter.video,
 ffmpeg.filter.video, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `planes` (of type `int?`, which defaults to `null`): set planes to filter. (default: 15)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.thumbnail`

Ffmpeg filter: Select the most representative frame in a given sequence of consecutive frames.

Type:
```
(?n : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `n` (of type `int?`, which defaults to `null`): set the frames batch size. (default: 100)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.tile`

Ffmpeg filter: Tile several successive frames together.

Type:
```
(?layout : string?, ?nb_frames : int?, ?margin : int?,
 ?padding : int?, ?color : string?, ?overlap : int?,
 ?init_padding : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `layout` (of type `string?`, which defaults to `null`): set grid size. (default: 6x5)
- `nb_frames` (of type `int?`, which defaults to `null`): set maximum number of frame to render. (default: 0)
- `margin` (of type `int?`, which defaults to `null`): set outer border margin in pixels. (default: 0)
- `padding` (of type `int?`, which defaults to `null`): set inner border thickness in pixels. (default: 0)
- `color` (of type `string?`, which defaults to `null`): set the color of the unused area. (default: black)
- `overlap` (of type `int?`, which defaults to `null`): set how many frames to overlap for each render. (default: 0)
- `init_padding` (of type `int?`, which defaults to `null`):  set how many frames to initially pad. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.tinterlace`

Ffmpeg filter: Perform temporal field interlacing.

Type:
```
(?mode : int?, ?flags : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `mode` (of type `int?`, which defaults to `null`): select interlace mode. (default: 0, possible values: 0 (merge), 1 (drop_even), 2 (drop_odd), 3 (pad), 4 (interleave_top), 5 (interleave_bottom), 6 (interlacex2), 7 (mergex2))
- `flags` (of type `int?`, which defaults to `null`): set flags. (default: 0, possible values: 1 (low_pass_filter), 1 (vlpf), 2 (complex_filter), 2 (cvlpf), 4 (exact_tb), 8 (bypass_il))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.tlut2`

Ffmpeg filter: Compute and apply a lookup table from two successive frames.

Type:
```
(?c0 : string?, ?c1 : string?, ?c2 : string?,
 ?c3 : string?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `c0` (of type `string?`, which defaults to `null`): set component #0 expression. (default: x)
- `c1` (of type `string?`, which defaults to `null`): set component #1 expression. (default: x)
- `c2` (of type `string?`, which defaults to `null`): set component #2 expression. (default: x)
- `c3` (of type `string?`, which defaults to `null`): set component #3 expression. (default: x)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.tmedian`

Ffmpeg filter: Pick median pixels from successive frames.

Type:
```
(?radius : int?, ?planes : int?, ?percentile : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `radius` (of type `int?`, which defaults to `null`): set median filter radius. (default: 1)
- `planes` (of type `int?`, which defaults to `null`): set planes to filter. (default: 15)
- `percentile` (of type `float?`, which defaults to `null`): set percentile. (default: 0.5)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.tmix`

Ffmpeg filter: Mix successive video frames.

Type:
```
(?frames : int?, ?weights : string?, ?scale : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `frames` (of type `int?`, which defaults to `null`): set number of successive frames to mix. (default: 3)
- `weights` (of type `string?`, which defaults to `null`): set weight for each frame. (default: 1 1 1)
- `scale` (of type `float?`, which defaults to `null`): set scale. (default: 0.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.tonemap`

Ffmpeg filter: Conversion to/from different dynamic ranges.

Type:
```
(?tonemap : int?, ?param : float?, ?desat : float?,
 ?peak : float?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `tonemap` (of type `int?`, which defaults to `null`): tonemap algorithm selection. (default: 0, possible values: 0 (none), 1 (linear), 2 (gamma), 3 (clip), 4 (reinhard), 5 (hable), 6 (mobius))
- `param` (of type `float?`, which defaults to `null`): tonemap parameter. (default: nan)
- `desat` (of type `float?`, which defaults to `null`): desaturation strength. (default: 2.)
- `peak` (of type `float?`, which defaults to `null`): signal peak override. (default: 0.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.tonemap_opencl`

Ffmpeg filter: Perform HDR to SDR conversion with tonemapping.

Type:
```
(?tonemap : int?, ?transfer : int?, ?t : int?,
 ?matrix : int?, ?m : int?, ?primaries : int?, ?p : int?,
 ?range : int?, ?r : int?, ?format : string?,
 ?peak : float?, ?param : float?, ?desat : float?,
 ?threshold : float?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `tonemap` (of type `int?`, which defaults to `null`): tonemap algorithm selection. (default: 0, possible values: 0 (none), 1 (linear), 2 (gamma), 3 (clip), 4 (reinhard), 5 (hable), 6 (mobius))
- `transfer` (of type `int?`, which defaults to `null`): set transfer characteristic. (default: 1, possible values: 1 (bt709), 14 (bt2020))
- `t` (of type `int?`, which defaults to `null`): set transfer characteristic. (default: 1, possible values: 1 (bt709), 14 (bt2020))
- `matrix` (of type `int?`, which defaults to `null`): set colorspace matrix. (default: -1, possible values: 1 (bt709), 9 (bt2020))
- `m` (of type `int?`, which defaults to `null`): set colorspace matrix. (default: -1, possible values: 1 (bt709), 9 (bt2020))
- `primaries` (of type `int?`, which defaults to `null`): set color primaries. (default: -1, possible values: 1 (bt709), 9 (bt2020))
- `p` (of type `int?`, which defaults to `null`): set color primaries. (default: -1, possible values: 1 (bt709), 9 (bt2020))
- `range` (of type `int?`, which defaults to `null`): set color range. (default: -1, possible values: 1 (tv), 2 (pc), 1 (limited), 2 (full))
- `r` (of type `int?`, which defaults to `null`): set color range. (default: -1, possible values: 1 (tv), 2 (pc), 1 (limited), 2 (full))
- `format` (of type `string?`, which defaults to `null`): output pixel format
- `peak` (of type `float?`, which defaults to `null`): signal peak override. (default: 0.)
- `param` (of type `float?`, which defaults to `null`): tonemap parameter. (default: nan)
- `desat` (of type `float?`, which defaults to `null`): desaturation parameter. (default: 0.5)
- `threshold` (of type `float?`, which defaults to `null`): scene detection threshold. (default: 0.2)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.tonemap_vaapi`

Ffmpeg filter: VAAPI VPP for tone-mapping

Type:
```
(?format : string?, ?matrix : string?, ?m : string?,
 ?primaries : string?, ?p : string?, ?transfer : string?,
 ?t : string?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `format` (of type `string?`, which defaults to `null`): Output pixel format set
- `matrix` (of type `string?`, which defaults to `null`): Output color matrix coefficient set
- `m` (of type `string?`, which defaults to `null`): Output color matrix coefficient set
- `primaries` (of type `string?`, which defaults to `null`): Output color primaries set
- `p` (of type `string?`, which defaults to `null`): Output color primaries set
- `transfer` (of type `string?`, which defaults to `null`): Output color transfer characteristics set
- `t` (of type `string?`, which defaults to `null`): Output color transfer characteristics set
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.tpad`

Ffmpeg filter: Temporarily pad video frames.

Type:
```
(?start : int?, ?stop : int?, ?start_mode : int?,
 ?stop_mode : int?, ?start_duration : int?,
 ?stop_duration : int?, ?color : string?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `start` (of type `int?`, which defaults to `null`): set the number of frames to delay input. (default: 0)
- `stop` (of type `int?`, which defaults to `null`): set the number of frames to add after input finished. (default: 0)
- `start_mode` (of type `int?`, which defaults to `null`): set the mode of added frames to start. (default: 0, possible values: 0 (add), 1 (clone))
- `stop_mode` (of type `int?`, which defaults to `null`): set the mode of added frames to end. (default: 0, possible values: 0 (add), 1 (clone))
- `start_duration` (of type `int?`, which defaults to `null`): set the duration to delay input. (default: 0)
- `stop_duration` (of type `int?`, which defaults to `null`): set the duration to pad input. (default: 0)
- `color` (of type `string?`, which defaults to `null`): set the color of the added frames. (default: black)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.transpose`

Ffmpeg filter: Transpose input video.

Type:
```
(?dir : int?, ?passthrough : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `dir` (of type `int?`, which defaults to `null`): set transpose direction. (default: 0, possible values: 0 (cclock_flip), 1 (clock), 2 (cclock), 3 (clock_flip))
- `passthrough` (of type `int?`, which defaults to `null`): do not apply transposition if the input matches the specified geometry. (default: 0, possible values: 0 (none), 2 (portrait), 1 (landscape))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.transpose_opencl`

Ffmpeg filter: Transpose input video

Type:
```
(?dir : int?, ?passthrough : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `dir` (of type `int?`, which defaults to `null`): set transpose direction. (default: 0, possible values: 0 (cclock_flip), 1 (clock), 2 (cclock), 3 (clock_flip))
- `passthrough` (of type `int?`, which defaults to `null`): do not apply transposition if the input matches the specified geometry. (default: 0, possible values: 0 (none), 2 (portrait), 1 (landscape))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.transpose_vaapi`

Ffmpeg filter: VAAPI VPP for transpose

Type:
```
(?dir : int?, ?passthrough : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `dir` (of type `int?`, which defaults to `null`): set transpose direction. (default: 0, possible values: 0 (cclock_flip), 1 (clock), 2 (cclock), 3 (clock_flip), 4 (reversal), 5 (hflip), 6 (vflip))
- `passthrough` (of type `int?`, which defaults to `null`): do not apply transposition if the input matches the specified geometry. (default: 0, possible values: 0 (none), 2 (portrait), 1 (landscape))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.treble`

Ffmpeg filter: Boost or cut upper frequencies.

Type:
```
(?frequency : float?, ?f : float?, ?width_type : int?,
 ?t : int?, ?width : float?, ?w : float?, ?gain : float?,
 ?g : float?, ?mix : float?, ?m : float?,
 ?channels : string?, ?c : string?, ?normalize : bool?,
 ?n : bool?, ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `frequency` (of type `float?`, which defaults to `null`): set central frequency. (default: 3000.)
- `f` (of type `float?`, which defaults to `null`): set central frequency. (default: 3000.)
- `width_type` (of type `int?`, which defaults to `null`): set filter-width type. (default: 3, possible values: 1 (h), 3 (q), 2 (o), 4 (s), 5 (k))
- `t` (of type `int?`, which defaults to `null`): set filter-width type. (default: 3, possible values: 1 (h), 3 (q), 2 (o), 4 (s), 5 (k))
- `width` (of type `float?`, which defaults to `null`): set shelf transition steep. (default: 0.5)
- `w` (of type `float?`, which defaults to `null`): set shelf transition steep. (default: 0.5)
- `gain` (of type `float?`, which defaults to `null`): set gain. (default: 0.)
- `g` (of type `float?`, which defaults to `null`): set gain. (default: 0.)
- `mix` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `m` (of type `float?`, which defaults to `null`): set mix. (default: 1.)
- `channels` (of type `string?`, which defaults to `null`): set channels to filter
- `c` (of type `string?`, which defaults to `null`): set channels to filter
- `normalize` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: false)
- `n` (of type `bool?`, which defaults to `null`): normalize coefficients. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.tremolo`

Ffmpeg filter: Apply tremolo effect.

Type:
```
(?f : float?, ?d : float?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `f` (of type `float?`, which defaults to `null`): set frequency in hertz. (default: 5.)
- `d` (of type `float?`, which defaults to `null`): set depth as percentage. (default: 0.5)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.trim`

Ffmpeg filter: Pick one continuous section from the input, drop the rest.

Type:
```
(?start : int?, ?starti : int?, ?end : int?,
 ?endi : int?, ?start_pts : int?, ?end_pts : int?,
 ?duration : int?, ?durationi : int?,
 ?start_frame : int?, ?end_frame : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `start` (of type `int?`, which defaults to `null`): Timestamp of the first frame that should be passed. (default: 9223372036854775807)
- `starti` (of type `int?`, which defaults to `null`): Timestamp of the first frame that should be passed. (default: 9223372036854775807)
- `end` (of type `int?`, which defaults to `null`): Timestamp of the first frame that should be dropped again. (default: 9223372036854775807)
- `endi` (of type `int?`, which defaults to `null`): Timestamp of the first frame that should be dropped again. (default: 9223372036854775807)
- `start_pts` (of type `int?`, which defaults to `null`): Timestamp of the first frame that should be  passed. (default: -9223372036854775808)
- `end_pts` (of type `int?`, which defaults to `null`): Timestamp of the first frame that should be dropped again. (default: -9223372036854775808)
- `duration` (of type `int?`, which defaults to `null`): Maximum duration of the output. (default: 0)
- `durationi` (of type `int?`, which defaults to `null`): Maximum duration of the output. (default: 0)
- `start_frame` (of type `int?`, which defaults to `null`): Number of the first frame that should be passed to the output. (default: -1)
- `end_frame` (of type `int?`, which defaults to `null`): Number of the first frame that should be dropped again. (default: 9223372036854775807)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.unpremultiply`

Ffmpeg filter: UnPreMultiply first stream with first plane of second stream. This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime.

Type:
```
(?planes : int?, ?inplace : bool?, ffmpeg.filter.graph,
 [ffmpeg.filter.audio], [ffmpeg.filter.video]) ->
ffmpeg.filter.video
```

Arguments:

- `planes` (of type `int?`, which defaults to `null`): set planes. (default: 15)
- `inplace` (of type `bool?`, which defaults to `null`): enable inplace mode. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.unsharp`

Ffmpeg filter: Sharpen or blur the input video.

Type:
```
(?luma_msize_x : int?, ?lx : int?, ?luma_msize_y : int?,
 ?ly : int?, ?luma_amount : float?, ?la : float?,
 ?chroma_msize_x : int?, ?cx : int?,
 ?chroma_msize_y : int?, ?cy : int?,
 ?chroma_amount : float?, ?ca : float?, ?opencl : bool?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `luma_msize_x` (of type `int?`, which defaults to `null`): set luma matrix horizontal size. (default: 5)
- `lx` (of type `int?`, which defaults to `null`): set luma matrix horizontal size. (default: 5)
- `luma_msize_y` (of type `int?`, which defaults to `null`): set luma matrix vertical size. (default: 5)
- `ly` (of type `int?`, which defaults to `null`): set luma matrix vertical size. (default: 5)
- `luma_amount` (of type `float?`, which defaults to `null`): set luma effect strength. (default: 1.)
- `la` (of type `float?`, which defaults to `null`): set luma effect strength. (default: 1.)
- `chroma_msize_x` (of type `int?`, which defaults to `null`): set chroma matrix horizontal size. (default: 5)
- `cx` (of type `int?`, which defaults to `null`): set chroma matrix horizontal size. (default: 5)
- `chroma_msize_y` (of type `int?`, which defaults to `null`): set chroma matrix vertical size. (default: 5)
- `cy` (of type `int?`, which defaults to `null`): set chroma matrix vertical size. (default: 5)
- `chroma_amount` (of type `float?`, which defaults to `null`): set chroma effect strength. (default: 0.)
- `ca` (of type `float?`, which defaults to `null`): set chroma effect strength. (default: 0.)
- `opencl` (of type `bool?`, which defaults to `null`): ignored. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.unsharp_opencl`

Ffmpeg filter: Apply unsharp mask to input video

Type:
```
(?luma_msize_x : float?, ?lx : float?,
 ?luma_msize_y : float?, ?ly : float?,
 ?luma_amount : float?, ?la : float?,
 ?chroma_msize_x : float?, ?cx : float?,
 ?chroma_msize_y : float?, ?cy : float?,
 ?chroma_amount : float?, ?ca : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `luma_msize_x` (of type `float?`, which defaults to `null`): Set luma mask horizontal diameter (pixels). (default: 5.)
- `lx` (of type `float?`, which defaults to `null`): Set luma mask horizontal diameter (pixels). (default: 5.)
- `luma_msize_y` (of type `float?`, which defaults to `null`): Set luma mask vertical diameter (pixels). (default: 5.)
- `ly` (of type `float?`, which defaults to `null`): Set luma mask vertical diameter (pixels). (default: 5.)
- `luma_amount` (of type `float?`, which defaults to `null`): Set luma amount (multiplier). (default: 1.)
- `la` (of type `float?`, which defaults to `null`): Set luma amount (multiplier). (default: 1.)
- `chroma_msize_x` (of type `float?`, which defaults to `null`): Set chroma mask horizontal diameter (pixels after subsampling). (default: 5.)
- `cx` (of type `float?`, which defaults to `null`): Set chroma mask horizontal diameter (pixels after subsampling). (default: 5.)
- `chroma_msize_y` (of type `float?`, which defaults to `null`): Set chroma mask vertical diameter (pixels after subsampling). (default: 5.)
- `cy` (of type `float?`, which defaults to `null`): Set chroma mask vertical diameter (pixels after subsampling). (default: 5.)
- `chroma_amount` (of type `float?`, which defaults to `null`): Set chroma amount (multiplier). (default: 0.)
- `ca` (of type `float?`, which defaults to `null`): Set chroma amount (multiplier). (default: 0.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.untile`

Ffmpeg filter: Untile a frame into a sequence of frames.

Type:
```
(?layout : string?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `layout` (of type `string?`, which defaults to `null`): set grid size. (default: 6x5)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.uspp`

Ffmpeg filter: Apply Ultra Simple / Slow Post-processing filter.

Type:
```
(?quality : int?, ?qp : int?, ?use_bframe_qp : bool?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `quality` (of type `int?`, which defaults to `null`): set quality. (default: 3)
- `qp` (of type `int?`, which defaults to `null`): force a constant quantizer parameter. (default: 0)
- `use_bframe_qp` (of type `bool?`, which defaults to `null`): use B-frames' QP. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.v360`

Ffmpeg filter: Convert 360 projection of video.

Type:
```
(?input : int?, ?output : int?, ?interp : int?,
 ?w : int?, ?h : int?, ?in_stereo : int?,
 ?out_stereo : int?, ?in_forder : string?,
 ?out_forder : string?, ?in_frot : string?,
 ?out_frot : string?, ?in_pad : float?,
 ?out_pad : float?, ?fin_pad : int?, ?fout_pad : int?,
 ?yaw : float?, ?pitch : float?, ?roll : float?,
 ?rorder : string?, ?h_fov : float?, ?v_fov : float?,
 ?d_fov : float?, ?h_flip : bool?, ?v_flip : bool?,
 ?d_flip : bool?, ?ih_flip : bool?, ?iv_flip : bool?,
 ?in_trans : bool?, ?out_trans : bool?, ?ih_fov : float?,
 ?iv_fov : float?, ?id_fov : float?, ?alpha_mask : bool?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `input` (of type `int?`, which defaults to `null`): set input projection. (default: 0, possible values: 0 (e), 0 (equirect), 1 (c3x2), 2 (c6x1), 3 (eac), 5 (dfisheye), 4 (flat), 4 (rectilinear), 4 (gnomonic), 6 (barrel), 6 (fb), 7 (c1x6), 8 (sg), 9 (mercator), 10 (ball), 11 (hammer), 12 (sinusoidal), 13 (fisheye), 14 (pannini), 15 (cylindrical), 17 (tetrahedron), 18 (barrelsplit), 19 (tsp), 20 (hequirect), 20 (he))
- `output` (of type `int?`, which defaults to `null`): set output projection. (default: 1, possible values: 0 (e), 0 (equirect), 1 (c3x2), 2 (c6x1), 3 (eac), 5 (dfisheye), 4 (flat), 4 (rectilinear), 4 (gnomonic), 6 (barrel), 6 (fb), 7 (c1x6), 8 (sg), 9 (mercator), 10 (ball), 11 (hammer), 12 (sinusoidal), 13 (fisheye), 14 (pannini), 15 (cylindrical), 16 (perspective), 17 (tetrahedron), 18 (barrelsplit), 19 (tsp), 20 (hequirect), 20 (he))
- `interp` (of type `int?`, which defaults to `null`): set interpolation method. (default: 1, possible values: 0 (near), 0 (nearest), 1 (line), 1 (linear), 2 (lagrange9), 3 (cube), 3 (cubic), 4 (lanc), 4 (lanczos), 5 (sp16), 5 (spline16), 6 (gauss), 6 (gaussian))
- `w` (of type `int?`, which defaults to `null`): output width. (default: 0)
- `h` (of type `int?`, which defaults to `null`): output height. (default: 0)
- `in_stereo` (of type `int?`, which defaults to `null`): input stereo format. (default: 0, possible values: 0 (2d), 1 (sbs), 2 (tb))
- `out_stereo` (of type `int?`, which defaults to `null`): output stereo format. (default: 0, possible values: 0 (2d), 1 (sbs), 2 (tb))
- `in_forder` (of type `string?`, which defaults to `null`): input cubemap face order. (default: rludfb)
- `out_forder` (of type `string?`, which defaults to `null`): output cubemap face order. (default: rludfb)
- `in_frot` (of type `string?`, which defaults to `null`): input cubemap face rotation. (default: 000000)
- `out_frot` (of type `string?`, which defaults to `null`): output cubemap face rotation. (default: 000000)
- `in_pad` (of type `float?`, which defaults to `null`): percent input cubemap pads. (default: 0.)
- `out_pad` (of type `float?`, which defaults to `null`): percent output cubemap pads. (default: 0.)
- `fin_pad` (of type `int?`, which defaults to `null`): fixed input cubemap pads. (default: 0)
- `fout_pad` (of type `int?`, which defaults to `null`): fixed output cubemap pads. (default: 0)
- `yaw` (of type `float?`, which defaults to `null`): yaw rotation. (default: 0.)
- `pitch` (of type `float?`, which defaults to `null`): pitch rotation. (default: 0.)
- `roll` (of type `float?`, which defaults to `null`): roll rotation. (default: 0.)
- `rorder` (of type `string?`, which defaults to `null`): rotation order. (default: ypr)
- `h_fov` (of type `float?`, which defaults to `null`): output horizontal field of view. (default: 90.)
- `v_fov` (of type `float?`, which defaults to `null`): output vertical field of view. (default: 45.)
- `d_fov` (of type `float?`, which defaults to `null`): output diagonal field of view. (default: 0.)
- `h_flip` (of type `bool?`, which defaults to `null`): flip out video horizontally. (default: false)
- `v_flip` (of type `bool?`, which defaults to `null`): flip out video vertically. (default: false)
- `d_flip` (of type `bool?`, which defaults to `null`): flip out video indepth. (default: false)
- `ih_flip` (of type `bool?`, which defaults to `null`): flip in video horizontally. (default: false)
- `iv_flip` (of type `bool?`, which defaults to `null`): flip in video vertically. (default: false)
- `in_trans` (of type `bool?`, which defaults to `null`): transpose video input. (default: false)
- `out_trans` (of type `bool?`, which defaults to `null`): transpose video output. (default: false)
- `ih_fov` (of type `float?`, which defaults to `null`): input horizontal field of view. (default: 90.)
- `iv_fov` (of type `float?`, which defaults to `null`): input vertical field of view. (default: 45.)
- `id_fov` (of type `float?`, which defaults to `null`): input diagonal field of view. (default: 0.)
- `alpha_mask` (of type `bool?`, which defaults to `null`): build mask in alpha plane. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.vaguedenoiser`

Ffmpeg filter: Apply a Wavelet based Denoiser.

Type:
```
(?threshold : float?, ?method : int?, ?nsteps : int?,
 ?percent : float?, ?planes : int?, ?type : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `threshold` (of type `float?`, which defaults to `null`): set filtering strength. (default: 2.)
- `method` (of type `int?`, which defaults to `null`): set filtering method. (default: 2, possible values: 0 (hard), 1 (soft), 2 (garrote))
- `nsteps` (of type `int?`, which defaults to `null`): set number of steps. (default: 6)
- `percent` (of type `float?`, which defaults to `null`): set percent of full denoising. (default: 85.)
- `planes` (of type `int?`, which defaults to `null`): set planes to filter. (default: 15)
- `type` (of type `int?`, which defaults to `null`): set threshold type. (default: 0, possible values: 0 (universal), 1 (bayes))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.vectorscope`

Ffmpeg filter: Video vectorscope.

Type:
```
(?mode : int?, ?m : int?, ?x : int?, ?y : int?,
 ?intensity : float?, ?i : float?, ?envelope : int?,
 ?e : int?, ?graticule : int?, ?g : int?,
 ?opacity : float?, ?o : float?, ?flags : int?,
 ?f : int?, ?bgopacity : float?, ?b : float?,
 ?lthreshold : float?, ?l : float?, ?hthreshold : float?,
 ?h : float?, ?colorspace : int?, ?c : int?,
 ?tint0 : float?, ?t0 : float?, ?tint1 : float?,
 ?t1 : float?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `mode` (of type `int?`, which defaults to `null`): set vectorscope mode. (default: 0, possible values: 0 (gray), 0 (tint), 1 (color), 2 (color2), 3 (color3), 4 (color4), 5 (color5))
- `m` (of type `int?`, which defaults to `null`): set vectorscope mode. (default: 0, possible values: 0 (gray), 0 (tint), 1 (color), 2 (color2), 3 (color3), 4 (color4), 5 (color5))
- `x` (of type `int?`, which defaults to `null`): set color component on X axis. (default: 1)
- `y` (of type `int?`, which defaults to `null`): set color component on Y axis. (default: 2)
- `intensity` (of type `float?`, which defaults to `null`): set intensity. (default: 0.004)
- `i` (of type `float?`, which defaults to `null`): set intensity. (default: 0.004)
- `envelope` (of type `int?`, which defaults to `null`): set envelope. (default: 0, possible values: 0 (none), 1 (instant), 2 (peak), 3 (peak+instant))
- `e` (of type `int?`, which defaults to `null`): set envelope. (default: 0, possible values: 0 (none), 1 (instant), 2 (peak), 3 (peak+instant))
- `graticule` (of type `int?`, which defaults to `null`): set graticule. (default: 0, possible values: 0 (none), 1 (green), 2 (color), 3 (invert))
- `g` (of type `int?`, which defaults to `null`): set graticule. (default: 0, possible values: 0 (none), 1 (green), 2 (color), 3 (invert))
- `opacity` (of type `float?`, which defaults to `null`): set graticule opacity. (default: 0.75)
- `o` (of type `float?`, which defaults to `null`): set graticule opacity. (default: 0.75)
- `flags` (of type `int?`, which defaults to `null`): set graticule flags. (default: 4, possible values: 1 (white), 2 (black), 4 (name))
- `f` (of type `int?`, which defaults to `null`): set graticule flags. (default: 4, possible values: 1 (white), 2 (black), 4 (name))
- `bgopacity` (of type `float?`, which defaults to `null`): set background opacity. (default: 0.3)
- `b` (of type `float?`, which defaults to `null`): set background opacity. (default: 0.3)
- `lthreshold` (of type `float?`, which defaults to `null`): set low threshold. (default: 0.)
- `l` (of type `float?`, which defaults to `null`): set low threshold. (default: 0.)
- `hthreshold` (of type `float?`, which defaults to `null`): set high threshold. (default: 1.)
- `h` (of type `float?`, which defaults to `null`): set high threshold. (default: 1.)
- `colorspace` (of type `int?`, which defaults to `null`): set colorspace. (default: 0, possible values: 0 (auto), 1 (601), 2 (709))
- `c` (of type `int?`, which defaults to `null`): set colorspace. (default: 0, possible values: 0 (auto), 1 (601), 2 (709))
- `tint0` (of type `float?`, which defaults to `null`): set 1st tint. (default: 0.)
- `t0` (of type `float?`, which defaults to `null`): set 1st tint. (default: 0.)
- `tint1` (of type `float?`, which defaults to `null`): set 2nd tint. (default: 0.)
- `t1` (of type `float?`, which defaults to `null`): set 2nd tint. (default: 0.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.vflip`

Ffmpeg filter: Flip the input video vertically.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.vfrdet`

Ffmpeg filter: Variable frame rate detect filter.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.vibrance`

Ffmpeg filter: Boost or alter saturation.

Type:
```
(?intensity : float?, ?rbal : float?, ?gbal : float?,
 ?bbal : float?, ?rlum : float?, ?glum : float?,
 ?blum : float?, ?alternate : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `intensity` (of type `float?`, which defaults to `null`): set the intensity value. (default: 0.)
- `rbal` (of type `float?`, which defaults to `null`): set the red balance value. (default: 1.)
- `gbal` (of type `float?`, which defaults to `null`): set the green balance value. (default: 1.)
- `bbal` (of type `float?`, which defaults to `null`): set the blue balance value. (default: 1.)
- `rlum` (of type `float?`, which defaults to `null`): set the red luma coefficient. (default: 0.072186)
- `glum` (of type `float?`, which defaults to `null`): set the green luma coefficient. (default: 0.715158)
- `blum` (of type `float?`, which defaults to `null`): set the blue luma coefficient. (default: 0.212656)
- `alternate` (of type `bool?`, which defaults to `null`): use alternate colors. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.vibrato`

Ffmpeg filter: Apply vibrato effect.

Type:
```
(?f : float?, ?d : float?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `f` (of type `float?`, which defaults to `null`): set frequency in hertz. (default: 5.)
- `d` (of type `float?`, which defaults to `null`): set depth as percentage. (default: 0.5)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.vidstabdetect`

Ffmpeg filter: Extract relative transformations, pass 1 of 2 for stabilization (see vidstabtransform for pass 2).

Type:
```
(?result : string?, ?shakiness : int?, ?accuracy : int?,
 ?stepsize : int?, ?mincontrast : float?, ?show : int?,
 ?tripod : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `result` (of type `string?`, which defaults to `null`): path to the file used to write the transforms. (default: transforms.trf)
- `shakiness` (of type `int?`, which defaults to `null`): how shaky is the video and how quick is the camera? 1: little (fast) 10: very strong/quick (slow). (default: 5)
- `accuracy` (of type `int?`, which defaults to `null`): (>=shakiness) 1: low 15: high (slow). (default: 15)
- `stepsize` (of type `int?`, which defaults to `null`): region around minimum is scanned with 1 pixel resolution. (default: 6)
- `mincontrast` (of type `float?`, which defaults to `null`): below this contrast a field is discarded (0-1). (default: 0.25)
- `show` (of type `int?`, which defaults to `null`): 0: draw nothing; 1,2: show fields and transforms. (default: 0)
- `tripod` (of type `int?`, which defaults to `null`): virtual tripod mode (if >0): motion is compared to a reference reference frame (frame # is the value). (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.vidstabtransform`

Ffmpeg filter: Transform the frames, pass 2 of 2 for stabilization (see vidstabdetect for pass 1).

Type:
```
(?input : string?, ?smoothing : int?, ?optalgo : int?,
 ?maxshift : int?, ?maxangle : float?, ?crop : int?,
 ?invert : int?, ?relative : int?, ?zoom : float?,
 ?optzoom : int?, ?zoomspeed : float?, ?interpol : int?,
 ?tripod : bool?, ?debug : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `input` (of type `string?`, which defaults to `null`): set path to the file storing the transforms. (default: transforms.trf)
- `smoothing` (of type `int?`, which defaults to `null`): set number of frames*2 + 1 used for lowpass filtering. (default: 15)
- `optalgo` (of type `int?`, which defaults to `null`): set camera path optimization algo. (default: 0, possible values: 0 (opt), 1 (gauss), 2 (avg))
- `maxshift` (of type `int?`, which defaults to `null`): set maximal number of pixels to translate image. (default: -1)
- `maxangle` (of type `float?`, which defaults to `null`): set maximal angle in rad to rotate image. (default: -1.)
- `crop` (of type `int?`, which defaults to `null`): set cropping mode. (default: 0, possible values: 0 (keep), 1 (black))
- `invert` (of type `int?`, which defaults to `null`): invert transforms. (default: 0)
- `relative` (of type `int?`, which defaults to `null`): consider transforms as relative. (default: 1)
- `zoom` (of type `float?`, which defaults to `null`): set percentage to zoom (>0: zoom in, <0: zoom out. (default: 0.)
- `optzoom` (of type `int?`, which defaults to `null`): set optimal zoom (0: nothing, 1: optimal static zoom, 2: optimal dynamic zoom). (default: 1)
- `zoomspeed` (of type `float?`, which defaults to `null`): for adative zoom: percent to zoom maximally each frame. (default: 0.25)
- `interpol` (of type `int?`, which defaults to `null`): set type of interpolation. (default: 2, possible values: 0 (no), 1 (linear), 2 (bilinear), 3 (bicubic))
- `tripod` (of type `bool?`, which defaults to `null`): enable virtual tripod mode (same as relative=0:smoothing=0). (default: false)
- `debug` (of type `bool?`, which defaults to `null`): enable debug mode and writer global motions information to file. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.vignette`

Ffmpeg filter: Make or reverse a vignette effect.

Type:
```
(?angle : string?, ?a : string?, ?x0 : string?,
 ?y0 : string?, ?mode : int?, ?eval : int?,
 ?dither : bool?, ?aspect : string?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `angle` (of type `string?`, which defaults to `null`): set lens angle. (default: PI/5)
- `a` (of type `string?`, which defaults to `null`): set lens angle. (default: PI/5)
- `x0` (of type `string?`, which defaults to `null`): set circle center position on x-axis. (default: w/2)
- `y0` (of type `string?`, which defaults to `null`): set circle center position on y-axis. (default: h/2)
- `mode` (of type `int?`, which defaults to `null`): set forward/backward mode. (default: 0, possible values: 0 (forward), 1 (backward))
- `eval` (of type `int?`, which defaults to `null`): specify when to evaluate expressions. (default: 0, possible values: 0 (init), 1 (frame))
- `dither` (of type `bool?`, which defaults to `null`): set dithering. (default: true)
- `aspect` (of type `string?`, which defaults to `null`): set aspect ratio. (default: 1/1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.vmafmotion`

Ffmpeg filter: Calculate the VMAF Motion score.

Type:
```
(?stats_file : string?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `stats_file` (of type `string?`, which defaults to `null`): Set file where to store per-frame difference information
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.volume`

Ffmpeg filter: Change input volume.

Type:
```
(?volume : string?, ?precision : int?, ?eval : int?,
 ?replaygain : int?, ?replaygain_preamp : float?,
 ?replaygain_noclip : bool?, ffmpeg.filter.graph,
 ffmpeg.filter.audio) -> ffmpeg.filter.audio
```

Arguments:

- `volume` (of type `string?`, which defaults to `null`): set volume adjustment expression. (default: 1.0)
- `precision` (of type `int?`, which defaults to `null`): select mathematical precision. (default: 1, possible values: 0 (fixed), 1 (float), 2 (double))
- `eval` (of type `int?`, which defaults to `null`): specify when to evaluate expressions. (default: 0, possible values: 0 (once), 1 (frame))
- `replaygain` (of type `int?`, which defaults to `null`): Apply replaygain side data when present. (default: 0, possible values: 0 (drop), 1 (ignore), 2 (track), 3 (album))
- `replaygain_preamp` (of type `float?`, which defaults to `null`): Apply replaygain pre-amplification. (default: 0.)
- `replaygain_noclip` (of type `bool?`, which defaults to `null`): Apply replaygain clipping prevention. (default: true)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.volumedetect`

Ffmpeg filter: Detect audio volume.

Type:
```
(ffmpeg.filter.graph, ffmpeg.filter.audio) ->
ffmpeg.filter.audio
```

Arguments:

- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.audio`)

### `ffmpeg.filter.vpp_qsv`

Ffmpeg filter: Quick Sync Video VPP.

Type:
```
(?deinterlace : int?, ?denoise : int?, ?detail : int?,
 ?framerate : string?, ?procamp : int?, ?hue : float?,
 ?saturation : float?, ?contrast : float?,
 ?brightness : float?, ?transpose : int?, ?cw : string?,
 ?ch : string?, ?cx : string?, ?cy : string?,
 ?w : string?, ?width : string?, ?h : string?,
 ?height : string?, ?format : string?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `deinterlace` (of type `int?`, which defaults to `null`): deinterlace mode: 0=off, 1=bob, 2=advanced. (default: 0, possible values: 1 (bob), 2 (advanced))
- `denoise` (of type `int?`, which defaults to `null`): denoise level [0, 100]. (default: 0)
- `detail` (of type `int?`, which defaults to `null`): enhancement level [0, 100]. (default: 0)
- `framerate` (of type `string?`, which defaults to `null`): output framerate. (default: 0/1)
- `procamp` (of type `int?`, which defaults to `null`): Enable ProcAmp. (default: 0)
- `hue` (of type `float?`, which defaults to `null`): ProcAmp hue. (default: 0.)
- `saturation` (of type `float?`, which defaults to `null`): ProcAmp saturation. (default: 1.)
- `contrast` (of type `float?`, which defaults to `null`): ProcAmp contrast. (default: 1.)
- `brightness` (of type `float?`, which defaults to `null`): ProcAmp brightness. (default: 0.)
- `transpose` (of type `int?`, which defaults to `null`): set transpose direction. (default: -1, possible values: 0 (cclock_hflip), 1 (clock), 2 (cclock), 3 (clock_hflip), 4 (reversal), 5 (hflip), 6 (vflip))
- `cw` (of type `string?`, which defaults to `null`): set the width crop area expression. (default: iw)
- `ch` (of type `string?`, which defaults to `null`): set the height crop area expression. (default: ih)
- `cx` (of type `string?`, which defaults to `null`): set the x crop area expression. (default: (in_w-out_w)/2)
- `cy` (of type `string?`, which defaults to `null`): set the y crop area expression. (default: (in_h-out_h)/2)
- `w` (of type `string?`, which defaults to `null`): Output video width. (default: cw)
- `width` (of type `string?`, which defaults to `null`): Output video width. (default: cw)
- `h` (of type `string?`, which defaults to `null`): Output video height. (default: w*ch/cw)
- `height` (of type `string?`, which defaults to `null`): Output video height. (default: w*ch/cw)
- `format` (of type `string?`, which defaults to `null`): Output pixel format. (default: same)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.vstack`

Ffmpeg filter: Stack video inputs vertically. This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime.

Type:
```
(?inputs : int?, ?shortest : bool?, ffmpeg.filter.graph,
 [ffmpeg.filter.audio], [ffmpeg.filter.video]) ->
ffmpeg.filter.video
```

Arguments:

- `inputs` (of type `int?`, which defaults to `null`): set number of inputs. (default: 2)
- `shortest` (of type `bool?`, which defaults to `null`): force termination when the shortest input terminates. (default: false)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.w3fdif`

Ffmpeg filter: Apply Martin Weston three field deinterlace.

Type:
```
(?filter : int?, ?deint : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `filter` (of type `int?`, which defaults to `null`): specify the filter. (default: 1, possible values: 0 (simple), 1 (complex))
- `deint` (of type `int?`, which defaults to `null`): specify which frames to deinterlace. (default: 0, possible values: 0 (all), 1 (interlaced))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.waveform`

Ffmpeg filter: Video waveform monitor.

Type:
```
(?mode : int?, ?m : int?, ?intensity : float?,
 ?i : float?, ?mirror : bool?, ?r : bool?,
 ?display : int?, ?d : int?, ?components : int?,
 ?c : int?, ?envelope : int?, ?e : int?, ?filter : int?,
 ?f : int?, ?graticule : int?, ?g : int?,
 ?opacity : float?, ?o : float?, ?flags : int?,
 ?fl : int?, ?scale : int?, ?s : int?,
 ?bgopacity : float?, ?b : float?, ?tint0 : float?,
 ?t0 : float?, ?tint1 : float?, ?t1 : float?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `mode` (of type `int?`, which defaults to `null`): set mode. (default: 1, possible values: 0 (row), 1 (column))
- `m` (of type `int?`, which defaults to `null`): set mode. (default: 1, possible values: 0 (row), 1 (column))
- `intensity` (of type `float?`, which defaults to `null`): set intensity. (default: 0.04)
- `i` (of type `float?`, which defaults to `null`): set intensity. (default: 0.04)
- `mirror` (of type `bool?`, which defaults to `null`): set mirroring. (default: true)
- `r` (of type `bool?`, which defaults to `null`): set mirroring. (default: true)
- `display` (of type `int?`, which defaults to `null`): set display mode. (default: 1, possible values: 0 (overlay), 1 (stack), 2 (parade))
- `d` (of type `int?`, which defaults to `null`): set display mode. (default: 1, possible values: 0 (overlay), 1 (stack), 2 (parade))
- `components` (of type `int?`, which defaults to `null`): set components to display. (default: 1)
- `c` (of type `int?`, which defaults to `null`): set components to display. (default: 1)
- `envelope` (of type `int?`, which defaults to `null`): set envelope to display. (default: 0, possible values: 0 (none), 1 (instant), 2 (peak), 3 (peak+instant))
- `e` (of type `int?`, which defaults to `null`): set envelope to display. (default: 0, possible values: 0 (none), 1 (instant), 2 (peak), 3 (peak+instant))
- `filter` (of type `int?`, which defaults to `null`): set filter. (default: 0, possible values: 0 (lowpass), 1 (flat), 2 (aflat), 3 (chroma), 4 (color), 5 (acolor), 6 (xflat), 7 (yflat))
- `f` (of type `int?`, which defaults to `null`): set filter. (default: 0, possible values: 0 (lowpass), 1 (flat), 2 (aflat), 3 (chroma), 4 (color), 5 (acolor), 6 (xflat), 7 (yflat))
- `graticule` (of type `int?`, which defaults to `null`): set graticule. (default: 0, possible values: 0 (none), 1 (green), 2 (orange), 3 (invert))
- `g` (of type `int?`, which defaults to `null`): set graticule. (default: 0, possible values: 0 (none), 1 (green), 2 (orange), 3 (invert))
- `opacity` (of type `float?`, which defaults to `null`): set graticule opacity. (default: 0.75)
- `o` (of type `float?`, which defaults to `null`): set graticule opacity. (default: 0.75)
- `flags` (of type `int?`, which defaults to `null`): set graticule flags. (default: 1, possible values: 1 (numbers), 2 (dots))
- `fl` (of type `int?`, which defaults to `null`): set graticule flags. (default: 1, possible values: 1 (numbers), 2 (dots))
- `scale` (of type `int?`, which defaults to `null`): set scale. (default: 0, possible values: 0 (digital), 1 (millivolts), 2 (ire))
- `s` (of type `int?`, which defaults to `null`): set scale. (default: 0, possible values: 0 (digital), 1 (millivolts), 2 (ire))
- `bgopacity` (of type `float?`, which defaults to `null`): set background opacity. (default: 0.75)
- `b` (of type `float?`, which defaults to `null`): set background opacity. (default: 0.75)
- `tint0` (of type `float?`, which defaults to `null`): set 1st tint. (default: 0.)
- `t0` (of type `float?`, which defaults to `null`): set 1st tint. (default: 0.)
- `tint1` (of type `float?`, which defaults to `null`): set 2nd tint. (default: 0.)
- `t1` (of type `float?`, which defaults to `null`): set 2nd tint. (default: 0.)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.weave`

Ffmpeg filter: Weave input video fields into frames.

Type:
```
(?first_field : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `first_field` (of type `int?`, which defaults to `null`): set first field. (default: 0, possible values: 0 (top), 0 (t), 1 (bottom), 1 (b))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.xbr`

Ffmpeg filter: Scale the input using xBR algorithm.

Type:
```
(?n : int?, ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `n` (of type `int?`, which defaults to `null`): set scale factor. (default: 3)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.xfade`

Ffmpeg filter: Cross fade one video with another video.

Type:
```
(?transition : int?, ?duration : int?, ?offset : int?,
 ?expr : string?, ffmpeg.filter.graph,
 ffmpeg.filter.video, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `transition` (of type `int?`, which defaults to `null`): set cross fade transition. (default: 0, possible values: -1 (custom), 0 (fade), 1 (wipeleft), 2 (wiperight), 3 (wipeup), 4 (wipedown), 5 (slideleft), 6 (slideright), 7 (slideup), 8 (slidedown), 9 (circlecrop), 10 (rectcrop), 11 (distance), 12 (fadeblack), 13 (fadewhite), 14 (radial), 15 (smoothleft), 16 (smoothright), 17 (smoothup), 18 (smoothdown), 19 (circleopen), 20 (circleclose), 21 (vertopen), 22 (vertclose), 23 (horzopen), 24 (horzclose), 25 (dissolve), 26 (pixelize), 27 (diagtl), 28 (diagtr), 29 (diagbl), 30 (diagbr), 31 (hlslice), 32 (hrslice), 33 (vuslice), 34 (vdslice))
- `duration` (of type `int?`, which defaults to `null`): set cross fade duration. (default: 1000000)
- `offset` (of type `int?`, which defaults to `null`): set cross fade start relative to first input stream. (default: 0)
- `expr` (of type `string?`, which defaults to `null`): set expression for custom transition
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.xfade_opencl`

Ffmpeg filter: Cross fade one video with another video.

Type:
```
(?transition : int?, ?source : string?,
 ?kernel : string?, ?duration : int?, ?offset : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `transition` (of type `int?`, which defaults to `null`): set cross fade transition. (default: 1, possible values: 0 (custom), 1 (fade), 2 (wipeleft), 3 (wiperight), 4 (wipeup), 5 (wipedown), 6 (slideleft), 7 (slideright), 8 (slideup), 9 (slidedown))
- `source` (of type `string?`, which defaults to `null`): set OpenCL program source file for custom transition
- `kernel` (of type `string?`, which defaults to `null`): set kernel name in program file for custom transition
- `duration` (of type `int?`, which defaults to `null`): set cross fade duration. (default: 1000000)
- `offset` (of type `int?`, which defaults to `null`): set cross fade start relative to first input stream. (default: 0)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.xmedian`

Ffmpeg filter: Pick median pixels from several video inputs. This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime.

Type:
```
(?inputs : int?, ?planes : int?, ?percentile : float?,
 ffmpeg.filter.graph, [ffmpeg.filter.audio],
 [ffmpeg.filter.video]) -> ffmpeg.filter.video
```

Arguments:

- `inputs` (of type `int?`, which defaults to `null`): set number of inputs. (default: 3)
- `planes` (of type `int?`, which defaults to `null`): set planes to filter. (default: 15)
- `percentile` (of type `float?`, which defaults to `null`): set percentile. (default: 0.5)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.xstack`

Ffmpeg filter: Stack video inputs into custom layout. This filter has dynamic inputs: last two arguments are lists of audio and video inputs. Total number of inputs is determined at runtime.

Type:
```
(?inputs : int?, ?layout : string?, ?shortest : bool?,
 ?fill : string?, ffmpeg.filter.graph,
 [ffmpeg.filter.audio], [ffmpeg.filter.video]) ->
ffmpeg.filter.video
```

Arguments:

- `inputs` (of type `int?`, which defaults to `null`): set number of inputs. (default: 2)
- `layout` (of type `string?`, which defaults to `null`): set custom layout
- `shortest` (of type `bool?`, which defaults to `null`): force termination when the shortest input terminates. (default: false)
- `fill` (of type `string?`, which defaults to `null`): set the color for unused pixels. (default: none)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `[ffmpeg.filter.audio]`)
- `(unlabeled)` (of type `[ffmpeg.filter.video]`)

### `ffmpeg.filter.yadif`

Ffmpeg filter: Deinterlace the input image.

Type:
```
(?mode : int?, ?parity : int?, ?deint : int?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `mode` (of type `int?`, which defaults to `null`): specify the interlacing mode. (default: 0, possible values: 0 (send_frame), 1 (send_field), 2 (send_frame_nospatial), 3 (send_field_nospatial))
- `parity` (of type `int?`, which defaults to `null`): specify the assumed picture field parity. (default: -1, possible values: 0 (tff), 1 (bff), -1 (auto))
- `deint` (of type `int?`, which defaults to `null`): specify which frames to deinterlace. (default: 0, possible values: 0 (all), 1 (interlaced))
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.yaepblur`

Ffmpeg filter: Yet another edge preserving blur filter.

Type:
```
(?radius : int?, ?r : int?, ?planes : int?, ?p : int?,
 ?sigma : int?, ?s : int?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `radius` (of type `int?`, which defaults to `null`): set window radius. (default: 3)
- `r` (of type `int?`, which defaults to `null`): set window radius. (default: 3)
- `planes` (of type `int?`, which defaults to `null`): set planes to filter. (default: 1)
- `p` (of type `int?`, which defaults to `null`): set planes to filter. (default: 1)
- `sigma` (of type `int?`, which defaults to `null`): set blur strength. (default: 128)
- `s` (of type `int?`, which defaults to `null`): set blur strength. (default: 128)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.yuvtestsrc`

Ffmpeg filter: Generate YUV test pattern.

Type:
```
(?size : string?, ?s : string?, ?rate : string?,
 ?r : string?, ?duration : int?, ?d : int?,
 ?sar : string?, ffmpeg.filter.graph) ->
ffmpeg.filter.video
```

Arguments:

- `size` (of type `string?`, which defaults to `null`): set video size. (default: 320x240)
- `s` (of type `string?`, which defaults to `null`): set video size. (default: 320x240)
- `rate` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `r` (of type `string?`, which defaults to `null`): set video rate. (default: 25)
- `duration` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `d` (of type `int?`, which defaults to `null`): set video duration. (default: -1)
- `sar` (of type `string?`, which defaults to `null`): set video sample aspect ratio. (default: 1/1)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)

### `ffmpeg.filter.zmq`

Ffmpeg filter: Receive commands through ZMQ and broker them to filters.

Type:
```
(?bind_address : string?, ?b : string?,
 ffmpeg.filter.graph, ffmpeg.filter.video) ->
ffmpeg.filter.video
```

Arguments:

- `bind_address` (of type `string?`, which defaults to `null`): set bind address. (default: tcp://*:5555)
- `b` (of type `string?`, which defaults to `null`): set bind address. (default: tcp://*:5555)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

### `ffmpeg.filter.zoompan`

Ffmpeg filter: Apply Zoom & Pan effect.

Type:
```
(?zoom : string?, ?z : string?, ?x : string?,
 ?y : string?, ?d : string?, ?s : string?,
 ?fps : string?, ffmpeg.filter.graph,
 ffmpeg.filter.video) -> ffmpeg.filter.video
```

Arguments:

- `zoom` (of type `string?`, which defaults to `null`): set the zoom expression. (default: 1)
- `z` (of type `string?`, which defaults to `null`): set the zoom expression. (default: 1)
- `x` (of type `string?`, which defaults to `null`): set the x expression. (default: 0)
- `y` (of type `string?`, which defaults to `null`): set the y expression. (default: 0)
- `d` (of type `string?`, which defaults to `null`): set the duration expression. (default: 90)
- `s` (of type `string?`, which defaults to `null`): set the output image size. (default: hd720)
- `fps` (of type `string?`, which defaults to `null`): set the output framerate. (default: 25)
- `(unlabeled)` (of type `ffmpeg.filter.graph`)
- `(unlabeled)` (of type `ffmpeg.filter.video`)

## Input

## Interaction

### `add_skip_command`

Add a skip function to a source when it does not have one by default.

Type:
```
('c.{id : () -> 'b, skip : (() -> 'a)}) -> unit
```

Arguments:

- `(unlabeled)` (of type `'c.{id : () -> 'b, skip : (() -> 'a)}`): The source to attach the command to.

### `audioscrobbler.submit.full`

Submit songs using audioscrobbler, respecting the full protocol: First signal song as now playing when starting, and then submit song when it ends.

Type:
```
(user : string, password : string, ?host : string,
 ?port : int, ?source : string, ?length : bool,
 ?delay : float, ?force : bool, source(audio=?A,
 video=?B, midi=?C)) -> source(audio=?A, video=?B,
midi=?C)
```

Arguments:

- `user` (of type `string`)
- `password` (of type `string`)
- `host` (of type `string`, which defaults to `"post.audioscrobbler.com"`)
- `port` (of type `int`, which defaults to `80`)
- `source` (of type `string`, which defaults to `"broadcast"`): Source for tracks. Should be one of: "broadcast", "user", "recommendation" or "unknown". Since liquidsoap is intended for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
- `length` (of type `bool`, which defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the "user" source type.
- `delay` (of type `float`, which defaults to `10.`): Submit song when there is only this delay left, in seconds. 
- `force` (of type `bool`, which defaults to `false`): If remaining time is null, the song will be assumed to be skipped or cut, and not submitted. Set to zero to disable this behaviour.
- `(unlabeled)` (of type `source(audio=?A, video=?B, midi=?C)`)

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
- `source` (of type `string`, which defaults to `"broadcast"`): Source for tracks. Should be one of: "broadcast", "user", "recommendation" or "unknown". Since liquidsoap is intended for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
- `length` (of type `bool`, which defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the "user" source type.
- `(unlabeled)` (of type `[string * string]`)

### `lastfm.submit.full`

Submit songs to lastfm using audioscrobbler, respecting the full protocol: First signal song as now playing when starting, and then submit song when it ends.

Type:
```
(user : string, password : string, ?source : string,
 ?length : bool, ?delay : float, ?force : bool,
 source(audio=?A, video=?B, midi=?C)) -> source(audio=?A,
video=?B, midi=?C)
```

Arguments:

- `user` (of type `string`)
- `password` (of type `string`)
- `source` (of type `string`, which defaults to `"broadcast"`): Source for tracks. Should be one of: "broadcast", "user", "recommendation" or "unknown". Since liquidsoap is intended for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
- `length` (of type `bool`, which defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the "user" source type.
- `delay` (of type `float`, which defaults to `10.`): Submit song when there is only this delay left, in seconds. If remaining time is less than this value, the song will be assumed to be skipped or cut, and not submitted. Set to zero to disable this behaviour.
- `force` (of type `bool`, which defaults to `false`): If remaining time is null, the song will be assumed to be skipped or cut, and not submitted. Set to zero to disable this behaviour.
- `(unlabeled)` (of type `source(audio=?A, video=?B, midi=?C)`)

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
- `source` (of type `string`, which defaults to `"broadcast"`): Source for tracks. Should be one of: "broadcast", "user", "recommendation" or "unknown". Since liquidsoap is intended for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
- `length` (of type `bool`, which defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the "user" source type.
- `(unlabeled)` (of type `[string * string]`)

### `librefm.submit.full`

Submit songs to librefm using audioscrobbler, respecting the full protocol: First signal song as now playing when starting, and then submit song when it ends.

Type:
```
(user : string, password : string, ?source : string,
 ?length : bool, ?delay : float, ?force : bool,
 source(audio=?A, video=?B, midi=?C)) -> source(audio=?A,
video=?B, midi=?C)
```

Arguments:

- `user` (of type `string`)
- `password` (of type `string`)
- `source` (of type `string`, which defaults to `"broadcast"`): Source for tracks. Should be one of: "broadcast", "user", "recommendation" or "unknown". Since liquidsoap is intended for radio broadcasting, this is the default. Sources other than user don't need duration to be set.
- `length` (of type `bool`, which defaults to `false`): Try to submit length information. This operation can be CPU intensive. Value forced to true when used with the "user" source type.
- `delay` (of type `float`, which defaults to `10.`): Submit song when there is only this delay left, in seconds. If remaining time is less than this value, the song will be assumed to be skipped or cut, and not submitted. Set to zero to disable this behaviour.
- `force` (of type `bool`, which defaults to `false`): If remaining time is null, the song will be assumed to be skipped or cut, and not submitted. Set to zero to disable this behaviour.
- `(unlabeled)` (of type `source(audio=?A, video=?B, midi=?C)`)

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

## Interactive

## Liquidsoap

### `server.harbor`

Start an interface for the "telnet" server over http.

Type:
```
(?port : int, ?uri : string) -> unit
```

Arguments:

- `port` (of type `int`, which defaults to `8000`): Port of the server.
- `uri` (of type `string`, which defaults to `"/telnet"`): URI of the server.

## List

## Math

## Output

### `output.external.ffmpeg`

Output to ffmpeg.

Type:
```
(?id : string?, ?show_command : bool, ?flush : bool,
 ?fallible : bool, ?on_start : (() -> unit),
 ?on_stop : (() -> unit), ?reopen_delay : float,
 ?reopen_on_metadata : bool, ?reopen_when : (() -> bool),
 ?start : bool, string, source(audio=pcm(stereo),
 video=yuva420p, midi=none)) -> unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `show_command` (of type `bool`, which defaults to `false`)
- `flush` (of type `bool`, which defaults to `false`): Perform a flush after each write.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `reopen_delay` (of type `float`, which defaults to `120.`): Prevent re-opening within that delay, in seconds.
- `reopen_on_metadata` (of type `bool`, which defaults to `false`): Re-open on every new metadata information.
- `reopen_when` (of type `() -> bool`, which defaults to `{false}`): When should the output be re-opened.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `(unlabeled)` (of type `string`)
- `(unlabeled)` (of type `source(audio=pcm(stereo), video=yuva420p, midi=none)`)

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

### `output.file.dash.ffmpeg`

Output an MPEG-DASH playlist using ffmpeg

Type:
```
(?id : string?, ?flush : bool, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?reopen_delay : float, ?reopen_on_metadata : bool,
 ?reopen_when : (() -> bool), ?start : bool,
 ?playlist : string, directory : 'a,
 source(audio=pcm(stereo), video=yuva420p, midi=none)) ->
unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `flush` (of type `bool`, which defaults to `false`): Perform a flush after each write.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `reopen_delay` (of type `float`, which defaults to `120.`): Prevent re-opening within that delay, in seconds.
- `reopen_on_metadata` (of type `bool`, which defaults to `false`): Re-open on every new metadata information.
- `reopen_when` (of type `() -> bool`, which defaults to `{false}`): When should the output be re-opened.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `playlist` (of type `string`, which defaults to `"stream.mpd"`): Playlist name
- `directory` (of type `'a`): Directory to write to
- `(unlabeled)` (of type `source(audio=pcm(stereo), video=yuva420p, midi=none)`)

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

### `output.file.hls.ffmpeg`

Output a HLS playlist using ffmpeg

Type:
```
(?id : string?, ?flush : bool, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?reopen_delay : float, ?reopen_on_metadata : bool,
 ?reopen_when : (() -> bool), ?start : bool,
 ?playlist : string, directory : string,
 source(audio=pcm(stereo), video=yuva420p, midi=none)) ->
unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `flush` (of type `bool`, which defaults to `false`): Perform a flush after each write.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `reopen_delay` (of type `float`, which defaults to `120.`): Prevent re-opening within that delay, in seconds.
- `reopen_on_metadata` (of type `bool`, which defaults to `false`): Re-open on every new metadata information.
- `reopen_when` (of type `() -> bool`, which defaults to `{false}`): When should the output be re-opened.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `playlist` (of type `string`, which defaults to `"stream.m3u8"`): Playlist name
- `directory` (of type `string`): Directory to write to
- `(unlabeled)` (of type `source(audio=pcm(stereo), video=yuva420p, midi=none)`)

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

### `output.youtube.live.ffmpeg`

Stream to youtube.

Type:
```
(?id : string?, ?flush : bool, ?fallible : bool,
 ?on_start : (() -> unit), ?on_stop : (() -> unit),
 ?reopen_delay : float, ?reopen_on_metadata : bool,
 ?reopen_when : (() -> bool), ?start : bool,
 ?url : string, ?bitrate : int, ?quality : string,
 key : string, source(audio=pcm(stereo), video=yuva420p,
 midi=none)) -> unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `flush` (of type `bool`, which defaults to `false`): Perform a flush after each write.
- `fallible` (of type `bool`, which defaults to `false`): Allow the child source to fail, in which case the output will be (temporarily) stopped.
- `on_start` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting starts.
- `on_stop` (of type `() -> unit`, which defaults to `<fun>`): Callback executed when outputting stops.
- `reopen_delay` (of type `float`, which defaults to `120.`): Prevent re-opening within that delay, in seconds.
- `reopen_on_metadata` (of type `bool`, which defaults to `false`): Re-open on every new metadata information.
- `reopen_when` (of type `() -> bool`, which defaults to `{false}`): When should the output be re-opened.
- `start` (of type `bool`, which defaults to `true`): Automatically start outputting whenever possible. If true, an infallible (normal) output will start outputting as soon as it is created, and a fallible output will (re)start as soon as its source becomes available for streaming.
- `url` (of type `string`, which defaults to `"rtmp://a.rtmp.youtube.com/live2"`): URL to stream to
- `bitrate` (of type `int`, which defaults to `2500`): Bitrate of the video (in kbps)
- `quality` (of type `string`, which defaults to `"medium"`): Quality of the video (low / medium / high)
- `key` (of type `string`): Your secret youtube key
- `(unlabeled)` (of type `source(audio=pcm(stereo), video=yuva420p, midi=none)`)

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

## Source / Audio Processing

### `accelerate`

Accelerate a stream by dropping frames. This is useful for testing scripts.

Type:
```
(?id : string?, ?randomize : {float}, ?ratio : {float},
 source(audio='a, video='b, midi='c)) -> source(audio='a,
video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `randomize` (of type `{float}`, which defaults to `1.`): Randomization (0 means no randomization).
- `ratio` (of type `{float}`, which defaults to `2.`): A value higher than 1 means speeding up.
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

### `ladspa.amp_mono`

Mono Amplifier by Richard Furse (LADSPA example plugins).

Type:
```
(?id : string?, ?gain : {float}, source(audio=pcm('a),
 video='b, midi='c)) -> source(audio=pcm('d), video='e,
midi='f)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `gain` (of type `{float}`, which defaults to `1.`): Gain (0 <= `gain`).
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

### `ladspa.amp_stereo`

Stereo Amplifier by Richard Furse (LADSPA example plugins).

Type:
```
(?id : string?, ?gain : {float},
 source(audio=pcm(stereo), video='a, midi='b)) ->
source(audio=pcm(stereo), video='c, midi='d)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `gain` (of type `{float}`, which defaults to `1.`): Gain (0 <= `gain`).
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

### `ladspa.delay_5s`

Simple Delay Line by Richard Furse (LADSPA example plugins).

Type:
```
(?id : string?, ?delay : {float},
 ?dry_wet_balance : {float}, source(audio=pcm('a),
 video='b, midi='c)) -> source(audio=pcm('d), video='e,
midi='f)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `delay` (of type `{float}`, which defaults to `1.`): Delay (Seconds) (0 <= `delay` <= 5).
- `dry_wet_balance` (of type `{float}`, which defaults to `0.5`): Dry/Wet Balance (0 <= `dry_wet_balance` <= 1).
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

### `ladspa.hpf`

Simple High Pass Filter by Richard Furse (LADSPA example plugins).

Type:
```
(?id : string?, ?cutoff_frequency : {float},
 source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('d), video='e, midi='f)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `cutoff_frequency` (of type `{float}`, which defaults to `440.`): Cutoff Frequency (Hz) (0 <= `cutoff_frequency` <= 22050).
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

### `ladspa.lpf`

Simple Low Pass Filter by Richard Furse (LADSPA example plugins).

Type:
```
(?id : string?, ?cutoff_frequency : {float},
 source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('d), video='e, midi='f)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `cutoff_frequency` (of type `{float}`, which defaults to `440.`): Cutoff Frequency (Hz) (0 <= `cutoff_frequency` <= 22050).
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

### `ladspa.noise_white`

White Noise Source by Richard Furse (LADSPA example plugins).

Type:
```
(?id : string?, ?amplitude : {float}) ->
source(audio=pcm(mono), video='a, midi='b)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `amplitude` (of type `{float}`, which defaults to `1.`): Amplitude (0 <= `amplitude`).

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

### `ladspa.sine_faaa`

Sine Oscillator (Freq:audio, Amp:audio) by Richard Furse (LADSPA example plugins).

Type:
```
(?id : string?, source(audio=pcm(stereo), video='a,
 midi='b)) -> source(audio=pcm(mono), video='c, midi='d)
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

### `ladspa.sine_faac`

Sine Oscillator (Freq:audio, Amp:control) by Richard Furse (LADSPA example plugins).

Type:
```
(?id : string?, ?amplitude : {float},
 source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('d), video='e, midi='f)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `amplitude` (of type `{float}`, which defaults to `1.`): Amplitude (0 <= `amplitude`).
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

### `ladspa.sine_fcaa`

Sine Oscillator (Freq:control, Amp:audio) by Richard Furse (LADSPA example plugins).

Type:
```
(?id : string?, ?frequency : {float},
 source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('d), video='e, midi='f)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `frequency` (of type `{float}`, which defaults to `440.`): Frequency (Hz) (0 <= `frequency` <= 22050).
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

### `ladspa.sine_fcac`

Sine Oscillator (Freq:control, Amp:control) by Richard Furse (LADSPA example plugins).

Type:
```
(?id : string?, ?amplitude : {float},
 ?frequency : {float}) -> source(audio=pcm(mono),
video='a, midi='b)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `amplitude` (of type `{float}`, which defaults to `1.`): Amplitude (0 <= `amplitude`).
- `frequency` (of type `{float}`, which defaults to `440.`): Frequency (Hz) (0 <= `frequency` <= 22050).

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

## Source / Conversions

## Source / Input

### `gstreamer.single.audio`

Play a single audio file using GStreamer.

Type:
```
(?id : string?, ?on_error : ((string) -> float), {'a}) ->
source(audio=pcm('b), video='c, midi='d)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens.
- `(unlabeled)` (of type `{'a}`): URI of the file to be played.

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

### `input.mplayer`

Stream data from mplayer

Type:
```
(?id : string, ?restart : bool, ?restart_on_error : bool,
 ?buffer : float, ?max : float, string) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `id` (of type `string`, which defaults to `"input.mplayer"`)
- `restart` (of type `bool`, which defaults to `true`): restart on exit.
- `restart_on_error` (of type `bool`, which defaults to `false`): restart on exit with error.
- `buffer` (of type `float`, which defaults to `0.2`): Duration of the pre-buffered data.
- `max` (of type `float`, which defaults to `10.`): Maximum duration of the buffered data.
- `(unlabeled)` (of type `string`): data URI.

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

### `input.v4l2_with_audio`

Stream from a video4linux2 input device, such as a webcam.

Type:
```
(?id : string?, ?device : string,
 ?on_error : ((string) -> float)) ->
source(audio=pcm(stereo), video=yuva420p('a), midi=none)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `device` (of type `string`, which defaults to `"/dev/video0"`): V4L2 device to use.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens.

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

### `output.file.hls.gstreamer`

Play an http live stream.

Type:
```
(?id : string?, ?on_error : ((string) -> float), {'a}) ->
source(audio=pcm(stereo), video=yuva420p('b), midi=none)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens.
- `(unlabeled)` (of type `{'a}`): URI of the HLS stream index.

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

### `output.file.hls.gstreamer.audio`

Play an audio-only http live stream.

Type:
```
(?id : string?, ?on_error : ((string) -> float), {'a}) ->
source(audio=pcm('b), video='c, midi='d)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `on_error` (of type `(string) -> float`, which defaults to `fun (_) -> 3.`): Callback executed when an error happens.
- `(unlabeled)` (of type `{'a}`): URI of the HLS stream index.

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

### `video.testsrc.gstreamer`

Test audio-video source using GStreamer.

Type:
```
(?id : string?) -> source(audio=pcm(stereo),
video=yuva420p('a), midi=none)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`)

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

## Source / Liquidsoap

## Source / MIDI Processing

## Source / Output

### `gstreamer.encode_jpeg_avi`

Encode jpeg video file using gstreamer

Type:
```
('a, source(audio=pcm('b), video='c, midi='d)) -> unit
```

Arguments:

- `(unlabeled)` (of type `'a`): Encoded file name
- `(unlabeled)` (of type `source(audio=pcm('b), video='c, midi='d)`): Source

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

### `gstreamer.encode_mp3`

Encode a mp3 file using gstreamer

Type:
```
('a, source(audio=pcm('b), video='c, midi='d)) -> unit
```

Arguments:

- `(unlabeled)` (of type `'a`): Encoded file name
- `(unlabeled)` (of type `source(audio=pcm('b), video='c, midi='d)`): Source

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

### `gstreamer.encode_x264_avi`

Encode an x264 video file using gstreamer

Type:
```
('a, source(audio=pcm('b), video='c, midi='d)) -> unit
```

Arguments:

- `(unlabeled)` (of type `'a`): Encoded file name
- `(unlabeled)` (of type `source(audio=pcm('b), video='c, midi='d)`): Source

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
(?host : string, ?port : int, source(audio=pcm('a),
 video='b, midi='c)) -> unit
```

Arguments:

- `host` (of type `string`, which defaults to `"127.0.0.1"`)
- `port` (of type `int`, which defaults to `5000`)
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

### `output.youtube.live`

Stream live on youtube. You need the following Gstreamer plugins: flvmux, rtmpsink, x264enc and a suitable AAC encoder (see `audio_encoder` params).

Type:
```
(?id : string?, ?video_bitrate : int,
 ?audio_encoder : string, ?audio_bitrate : int,
 ?url : string, key : string, source(audio=pcm('a),
 video=yuva420p('b), midi='c)) -> unit
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Source ID
- `video_bitrate` (of type `int`, which defaults to `2000`): Video bitrate
- `audio_encoder` (of type `string`, which defaults to `"fdkaacenc"`): Audio encoder. Can be one of: "fdkaacenc", "voaacenc"
- `audio_bitrate` (of type `int`, which defaults to `128000`): Audio bitrate
- `url` (of type `string`, which defaults to `"rtmp://a.rtmp.youtube.com/live2"`): Server URL
- `key` (of type `string`): Secret key
- `(unlabeled)` (of type `source(audio=pcm('a), video=yuva420p('b), midi='c)`): Source to stream

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

### `helium`

Increases the pitch, making voices sound like on helium.

Type:
```
(source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

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

### `nrj`

Compress and normalize, producing a more uniform and "full" sound.

Type:
```
(source(audio=pcm('a), video='b, midi='c)) ->
source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `(unlabeled)` (of type `source(audio=pcm('a), video='b, midi='c)`): The input source.

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

### `sky`

Multiband-compression.

Type:
```
(source(audio=pcm('a), video=internal('b),
 midi=internal('c))) -> source(audio=pcm('a),
video=internal('b), midi=internal('c))
```

Arguments:

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

## Source / Sound Synthesis

## Source / Track Processing

### `fallback.skip`

Special track insensitive fallback that always skips current song before switching.

Type:
```
(source(audio=internal('a), video=internal('b),
 midi=internal('c)),
 ?fallback : source(audio=internal('a),
 video=internal('b), midi=internal('c))
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
   id : (() -> string)
 }) -> source(audio=internal('a), video=internal('b),
midi=internal('c))
```

Arguments:

- `(unlabeled)` (of type `source(audio=internal('a), video=internal('b),
midi=internal('c))`): The main source.
- `fallback` (of type `source(audio=internal('a), video=internal('b),
midi=internal('c))
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
  id : (() -> string)
}`, which defaults to `<source>.{time = <fun>, shutdown = <fun>, fallible = false, skip = <fun>, seek = <fun>, is_active = <fun>, is_up = <fun>, log = {level = <fun>.{set = <fun>}}, self_sync = <fun>, duration = <fun>, elapsed = <fun>, remaining = <fun>, on_track = <fun>, on_leave = <fun>, on_shutdown = <fun>, on_metadata = <fun>, is_ready = <fun>, id = <fun>}`): The fallback source.

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

### `native.fallback`

At the beginning of each track, select the first ready child.

Type:
```
(?id : string?, ?track_sensitive : bool,
 [source(audio='a, video='b, midi='c)]) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `track_sensitive` (of type `bool`, which defaults to `true`): Re-select only on end of tracks.
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
- `set` (of type `(source(audio=?A, video=?B, midi=?C)) -> unit`): Set the source.
- `shutdown` (of type `() -> unit`): Deactivate a source.
- `skip` (of type `() -> unit`): Skip to the next track.
- `time` (of type `() -> float`): Get a source's time, based on its assigned clock.

### `native.once`

Create a source that plays only one track of the input source.

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

### `native.sequence`

Play only one track of every successive source, except for the last one which is played as much as available.

Type:
```
(?id : string?, [source(audio='a, video='b, midi='c)]) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `(unlabeled)` (of type `[source(audio='a, video='b, midi='c)]`): List of sources to play tracks from.

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

### `native.switch`

Select the first source whose predicate is true in a list. If the second argument is a getter, the source will be dynamically created.

Type:
```
(?id : string?, ?track_sensitive : bool,
 [{bool} * source(audio='a, video='b, midi='c)]) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `id` (of type `string?`, which defaults to `null`): Force the value of the source ID.
- `track_sensitive` (of type `bool`, which defaults to `true`): Re-select only on end of tracks.
- `(unlabeled)` (of type `[{bool} * source(audio='a, video='b, midi='c)]`): Sources with the predicate telling when they can be played.

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

### `notify_metadata`

Use notify to display metadata info.

Type:
```
(?urgency : string, ?icon : string, ?time : int,
 ?display : (([string * string]) -> string),
 ?title : string, 'b
 .{on_metadata : (((([string * string]) -> unit)) -> 'a)
 }) -> 'a
```

Arguments:

- `urgency` (of type `string`, which defaults to `"low"`): Urgency (low|normal|critical).
- `icon` (of type `string`, which defaults to `"stock_smiley-22"`): Icon filename or stock icon to display.
- `time` (of type `int`, which defaults to `3000`): Timeout in milliseconds.
- `display` (of type `([string * string]) -> string`, which defaults to `<fun>`): Function used to display a metadata packet.
- `title` (of type `string`, which defaults to `"Liquidsoap: new track"`): Title of the notification message.
- `(unlabeled)` (of type `'b.{on_metadata : (((([string * string]) -> unit)) -> 'a)
}`)

### `osd_metadata`

Use X On Screen Display to display metadata info.

Type:
```
(?color : string, ?position : string, ?font : string,
 ?display : (([string * string]) -> string), 'b
 .{on_metadata : (((([string * string]) -> unit)) -> 'a)
 }) -> 'a
```

Arguments:

- `color` (of type `string`, which defaults to `"green"`): Color of the text.
- `position` (of type `string`, which defaults to `"top"`): Position of the text (top|middle|bottom).
- `font` (of type `string`, which defaults to `"-*-courier-*-r-*-*-*-240-*-*-*-*-*-*"`): Font used (xfontsel is your friend...)
- `display` (of type `([string * string]) -> string`, which defaults to `<fun>`): Function used to display a metadata packet.
- `(unlabeled)` (of type `'b.{on_metadata : (((([string * string]) -> unit)) -> 'a)
}`)

### `skipper`

Regularly skip tracks from a source (useful for testing skipping).

Type:
```
(?every : {float}, source(audio='a, video='b, midi='c)
 .{skip : () -> unit, time : (() -> float)}) ->
source(audio='a, video='b, midi='c)
```

Arguments:

- `every` (of type `{float}`, which defaults to `5.`): How often to skip tracks.
- `(unlabeled)` (of type `source(audio='a, video='b, midi='c)
.{skip : () -> unit, time : (() -> float)}`): The stream.

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

### `smooth_add`

Mixes two streams, with faded transitions between the state when only the normal stream is available and when the special stream gets added on top of it.

Type:
```
(?duration : float, ?p : {float},
 normal : source(audio=pcm('a), video=internal('b),
 midi=internal('c)), special : source(audio=pcm('a),
 video=internal('b), midi=internal('c))) ->
source(audio=pcm('a), video=internal('b),
midi=internal('c))
```

Arguments:

- `duration` (of type `float`, which defaults to `1.`): Duration of the fade in seconds.
- `p` (of type `{float}`, which defaults to `0.2`): Portion of amplitude of the normal source in the mix.
- `normal` (of type `source(audio=pcm('a), video=internal('b),
midi=internal('c))`): The normal source, which could be called the carrier too.
- `special` (of type `source(audio=pcm('a), video=internal('b),
midi=internal('c))`): The special source.

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

## Source / Video Processing

### `input.external.ffmpeg`

Input from ffmpeg.

Type:
```
(?id : string, ?show_command : bool, ?restart : bool,
 ?restart_on_error : bool, ?buffer : float, ?max : float,
 string) -> source(audio=pcm(stereo), video=yuva420p('a),
midi=none)
```

Arguments:

- `id` (of type `string`, which defaults to `"input.external.ffmpeg"`)
- `show_command` (of type `bool`, which defaults to `false`)
- `restart` (of type `bool`, which defaults to `true`): restart on exit.
- `restart_on_error` (of type `bool`, which defaults to `false`): restart on exit with error.
- `buffer` (of type `float`, which defaults to `0.2`): Duration of the pre-buffered data.
- `max` (of type `float`, which defaults to `10.`): Maximum duration of the buffered data.
- `(unlabeled)` (of type `string`): ffmpeg options specifying the input

### `video.external.testsrc`

ffmpeg's test source video (useful for testing and debugging).

Type:
```
(?id : string, ?restart : bool, ?restart_on_error : bool,
 ?buffer : float, ?max : float, ?framerate : int) ->
source(audio=pcm(stereo), video=yuva420p('a), midi=none)
```

Arguments:

- `id` (of type `string`, which defaults to `"video.external.testsrc"`)
- `restart` (of type `bool`, which defaults to `true`): restart on exit.
- `restart_on_error` (of type `bool`, which defaults to `false`): restart on exit with error.
- `buffer` (of type `float`, which defaults to `0.2`): Duration of the pre-buffered data.
- `max` (of type `float`, which defaults to `10.`): Maximum duration of the buffered data.
- `framerate` (of type `int`, which defaults to `0`)

## Source / Visualization

## String

## String 

## System

## Visualization

### `vumeter`

VU meter: display the audio volume (RMS in dB).

Type:
```
(?rms_min : float, ?rms_max : float, ?window : float,
 ?scroll : bool, source(audio=pcm('a), video='b,
 midi='c)) -> source(audio=pcm('a), video='b, midi='c)
```

Arguments:

- `rms_min` (of type `float`, which defaults to `-25.`): Minimal volume.
- `rms_max` (of type `float`, which defaults to `-5.`): Maximal volume.
- `window` (of type `float`, which defaults to `0.5`): Duration in seconds of volume computation.
- `scroll` (of type `bool`, which defaults to `false`): Update the display in the same line.
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

