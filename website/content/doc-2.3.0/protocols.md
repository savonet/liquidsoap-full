### annotate

Add metadata to a request

The syntax is `annotate:key="val",key2="val2",...:uri`.

### autocue

Adding automatically computed cues/crossfade metadata

The syntax is `autocue:uri`.

### copy

Copy file to a temporary destination

The syntax is `copy:/path/to/file.extname`.

### fallible

Mark the given uri as being fallible. This can be used to prevent a request or source from being resolved once and for all and considered infallible for the duration of the script, typically when debugging.

The syntax is `fallible:uri`.

### ffmpeg

Decode any file to wave using ffmpeg

The syntax is `ffmpeg:uri`.

### file

File protocol. Only local files are supported

The syntax is `file:///path/to/file`.

### gtts

Generate speech synthesis using Google translate's text-to-speech API. This requires the `gtts-cli` binary.  Result may be mono.

The syntax is `gtts:Text to read`.

### http

Download http URLs using curl

The syntax is `http://...`.

### https

Download http URLs using curl

The syntax is `https://...`.

### macos_say

Generate speech synthesis using the `say` command available on macos.

The syntax is `macos_say:Text to read`.

### mpd

Finds all files with a tag equal to a given value using mpd.

The syntax is `mpd:tag=value`.

### pico2wave

Generate speech synthesis using pico2wave. Result may be mono.

The syntax is `pico2wave:Text to read`.

### polly

Generate speech synthesis using AWS polly service. Result might be mono, needs aws binary in the path.

The syntax is `polly:Text to read`.

### process

Resolve a request using an arbitrary process. `<cmd>` is interpolated with: `[("input",<input>),("output",<output>),("colon",":")]`. `uri` is an optional child request, `<output>` is the name of a fresh temporary file and has extension `.<extname>`. `<input>` is an optional input file name as returned while resolving `uri`.

The syntax is `process:<extname>,<cmd>[:uri]`.

### replaygain

Compute ReplayGain value. Adds returned value as `"replaygain_track_gain"` metadata

The syntax is `replaygain:uri`.

### s3

Fetch files from s3 using the AWS CLI

The syntax is `s3://uri`.

### say

Generate speech synthesis using text2wave. Result is always stereo.

The syntax is `say:Text to read`.

### stereo

Convert a file to stereo (currently decodes to wav).

The syntax is `stereo:<uri>`.

### synth

Synthesize audio. Parameters are optional.

The syntax is `synth:shape=sine,frequency=440.,duration=10.`.

### text2wave

Generate speech synthesis using text2wave. Result may be mono.

The syntax is `text2wave:Text to read`.

### tmp

Mark the given uri as temporary. Useful when chaining protocols

The syntax is `tmp:uri`.

### youtube-dl

Resolve a request using youtube-dl.

The syntax is `youtube-dl:uri`.

### youtube-pl

Resolve a request as a youtube playlist using youtube-dl. You typically want to use this as `playlist("youtube-pl:...")`.

The syntax is `youtube-pl:uri`.

