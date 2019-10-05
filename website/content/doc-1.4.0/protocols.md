### ANNOTATE

Add metadata to a request

The syntax is `annotate:key="val",key2="val2",...:uri`.

### FFMPEG

Decode any file to wave using ffmpeg

The syntax is `ffmpeg:uri`.

### FTP

Download files using curl

The syntax is `ftp://...`.

### HTTP

Download files using curl

The syntax is `http://...`.

### HTTPS

Download files using curl

The syntax is `https://...`.

### MPD

Finds all files with a tag equal to a given value using mpd.

The syntax is `mpd:tag=value`.

### POLLY

Generate speech synthesis using AWS polly service. Result might be mono, needs aws binary in the path.

The syntax is `polly:Text to read`. This protocol is static.

### PROCESS

Resolve a request using an arbitrary process. `<cmd>` is interpolated with: `[("input",<input>),("output",<output>),("colon",":")]`. `uri` is an optional child request, `<output>` is the name of a fresh temporary file and has extension `.<extname>`. `<input>` is an optional input file name as returned while resolving `uri`.

The syntax is `process:<extname>,<cmd>[:uri]`.

### REPLAY_GAIN

Compute replaygain value using the extract-replaygain script. Adds returned value as `"replay_gain"` metadata

The syntax is `replay_gain:uri`.

### S3

Fetch files from s3 using the AWS CLI

The syntax is `s3://uri`.

### SAY

Generate speech synthesis using text2wave and sox. Result is always stereo.

The syntax is `say:Text to read`. This protocol is static.

### TEXT2WAVE

Generate speech synthesis using text2wave. Result may be mono.

The syntax is `text2wav2:Text to read`. This protocol is static.

### TMP

Mark the given uri as temporary. Useful when chaining protocols

The syntax is `tmp:uri`.

### YOUTUBE-DL

Resolve a request using youtube-dl.

The syntax is `youtube-dl:uri`.

### YOUTUBE-PL

Resolve a request as a youtube playlist using youtube-dl.

The syntax is `youtube-pl:uri`.

