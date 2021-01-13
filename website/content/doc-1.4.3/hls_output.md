HLS Output
==========

Starting with liquidsoap `1.4.0`, it is possible to send your streams as [HLS output](https://en.wikipedia.org/wiki/HTTP_Live_Streaming).

The main operator is `output.file.hls`. Here's an example using it, courtesy of [srt2hls](https://github.com/mbugeia/srt2hls):

```liquidsoap
aac_lofi = %ffmpeg(format="mpegts",
                   codec="aac",
                   channels=2,
                   ar=44100,
                   b="32k")

aac_midfi = %ffmpeg(format="mpegts",
                   codec="aac",
                   channels=2,
                   ar=44100,
                   b="96k")

aac_hifi = %ffmpeg(format="mpegts",
                   codec="aac",
                   channels=2,
                   ar=44100,
                   b="192k")

streams_info = [("aac_lofi",(40000,"mp4a.40.29","ts")),
                ("aac_midfi",(110000,"mp4a.40.2","ts")),
                ("aac_hifi",(220000,"mp4a.40.2","ts"))]
                
streams = [("aac_lofi",aac_lofi), 
           ("aac_midfi", aac_midfi), 
           ("aac_hifi", aac_hifi)]
                
def segment_name(~position,~extname,stream_name) =
  timestamp = int_of_float(gettimeofday())
  duration = 2
  "#{stream_name}_#{duration}_#{timestamp}_#{position}.#{extname}"
end             

output.file.hls(playlist="live.m3u8",
                segment_duration=2.0,
                segments=5,
                segments_overhead=5,
                segment_name=segment_name,
                streams_info=streams_info,
                persist=true,
                persist_at="/path/to/state.config",
                "/path/to/hls/directory",
                streams,
                source)
```

Let's see what's important here:

* `streams` describes the encoded streams. It's a list of: `(stream_name, encoder)`. `stream_name` is used to generate
  the corresponding media playlists. Encoders can be any encoder supported by liquidsoap. However, the [HLS RFC](https://tools.ietf.org/html/rfc8216)
  limits the list of possible codecs to `mp3` and `aac`. Furthermore, for the best possible compatible, it is recommended
  to send data encapsulated in a `MPEG-TS` stream. Currently, the only encoder capable of doing this in liquidsoap is `%ffmpeg`.
* `streams_info` describes additional data used to generated the HLS playlists according to
  [section 4.3.4.2](https://tools.ietf.org/html/rfc8216#section-4.3.4.2) of the RFC. It consists of a list
  of the form: `(stream_name, (average_bandwidth, codec_name, segments_file_extension))`. This list is inffered for the following formats:
  `%mp3`, `%fdkaac`, `%shine`. When using these formats, you do not need to pass an entry for the corresponding stream in this
  list. However, since we're using the `%ffmpeg` encoder to get `MPEG-TS` encapsulated data, we need to add 
  these info for each stream.
* `persist` and `persist_at` are used to allow liquidsoap to restart while keeping the existing segments and playlists. When
  shutting down, liquidsoap stores the current configuration at `persist_at` and uses it to restart the HLS stream when
  restarting.
* `segments` and `segments_overhead` are used to keep track of the generated segments. Each media playlist will contain
  a number of segments defined by `segments` and an extra set of segments, defined by `segments_overhead`, is kept past the playlist size for those
   listeners who are still listening on outdated segments.
   
There are more useful options, in particular `on_file_change`, which can be used for instance to sync up your segments and playlists
to a distant storage and hosting service such as S3.

Liquidsoap also provides a `output.harbor.hls` and `output.harbor.hls.ssl` which allow to serve HLS streams directly from
liquidsoap. Their options should be the same as `output.file.hls`, except for harbor-specifc options `port` and `path`. It is 
not recommended for listener-facing setup but can be useful to sync up with a caching system such as cloudfront.
   
