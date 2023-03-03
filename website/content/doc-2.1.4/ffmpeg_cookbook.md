# FFmpeg cookbook

Here are some examples of what is possible to do with the ffmpeg support in liquidsoap:

Relaying without re-encoding
----------------------------

With ffmpeg support, Liquidsoap can relay encoded streams without re-encoding them, making it possible to re-send a stream to multiple destinations. Here's an example:

```liquidsoap
# Input the stream,
# from an Icecast server or any other source
encoded_source = input.http("https://icecast.radiofrance.fr/fip-hifi.aac")

# Send to one server here:
output.icecast(
  %ffmpeg(format="adts", %audio.copy),
  fallible=true,
  mount="/restream",
  host="streaming.example.com", port=8000, password="xxx",
  encoded_source)

# An another one here:
output.icecast(
  %ffmpeg(format="adts", %audio.copy),
  fallible=true,
  mount="/restream",
  host="streaming2.example.com", port=8000, password="xxx",
  encoded_source)
```

We cannot use `mksafe` here because the content is not plain `pcm` samples, which this operator is designed to produce. There
are several ways to make the source infallible, however, either by providing a `single(...)` source with the same encoded content
as we expect from `encoded_source` or by creating an infallible source using `ffmpeg.encode.audio`.

On-demand relaying without re-encoding
--------------------------------------

Anothe refinement on the previous example is the capacity to relay a stream only when listeners are connected to it,
all without re-encoding the content.

To make it work, you will need a format that can be handled by `ffmpeg` for that purpose. `mp3` is a good example.

In the script below, you need to match the encoded format of the stream with a blank file (or any other file).
The `output.harbor` will then relay the data from the file if no one is connected and start/stop the underlying
input when there are listeners:

```liquidsoap
stream = input.http(start = false, "https://wwoz-sc.streamguys1.com/wwoz-hi.mp3")

listeners_count = ref(0)

def on_connect(~headers, ~uri, ~protocol, _) =
  listeners_count := !listeners_count + 1
  if !listeners_count > 0 and not stream.is_started() then
    log("Starting input")
    stream.start()
  end
end

def on_disconnect(_) =
  listeners_count := !listeners_count - 1
  if !listeners_count == 0 and stream.is_started() then
    log("Stopping input")
    stream.stop()
  end
end

blank = single("/tmp/blank.mp3")

stream = fallback(track_sensitive=false, [stream, blank])

output.harbor(
  %ffmpeg(format="mp3", %audio.copy),
  format="audio/mpeg",
  mount="relay",
  on_connect=on_connect,
  on_disconnect=on_disconnect,
  stream)
```

Shared encoding
---------------

Liquidsoap can also encode in one place and share the encoded with data with multiple outputs, making it possible to
minimize CPU resources. Here's an example adapted from the previous one:

```liquidsoap
# Input the stream,
# from an Icecast server or any other source
source = input.http("https://icecast.radiofrance.fr/fip-hifi.aac")

# Make it infallible:
source = mksafe(source)

# Encode it in mp3:
source = ffmpeg.encode.audio(
  %ffmpeg(%audio(codec="libmp3lame")),
  source)

# Send to one server here:
output.icecast(
  %ffmpeg(format="mp3", %audio.copy),
  mount="/restream",
  host="streaming.example.com", port=8000, password="xxx",
  source)

# An another one here:
output.icecast(
  %ffmpeg(format="mp3", %audio.copy),
  mount="/restream",
  host="streaming2.example.com", port=8000, password="xxx",
  source)
```

Shared encoding is even more useful when dealing with video encoding, which is very costly. Here's a fun example
sharing audio and video encoding and sending to different destinations, both via Icecast and to YouTube/Facebook
via the rtmp protocol:

```liquidsoap
# An audio source
audio = ...

# Encode it in mp3
audio = ffmpeg.encode.audio(
  %ffmpeg(%audio(codec="libmp3lame")),
  audio)

# Send it to icecast
output.icecast(
  %ffmpeg(format="mp3", %audio.copy),
  host = "...",
  password = "...",
  mount = "/stream",
  audio
)

# A video source, for instance a static image
video = ...

# Encode it in h264 format
video = ffmpeg.encode.video(
  %ffmpeg(%video(codec="libx264")),
  video)

# Mux it with the audio
stream = mux_video(video=video, audio)

# Copy encoder for the rtmp stream
enc = %ffmpeg(
  format="flv",
  %audio.copy,
  %video.copy)

# Send to YouTube
key = "..."
url = "rtmp://a.rtmp.youtube.com/live2/#{key}"
output.url(url=url, enc, stream)

# Send to Facebook
key = "..."
url = "rtmps://live-api-s.facebook.com:443/rtmp/#{key}"
output.url(self_sync=true, url=url, enc, stream)
```

Add transparent logo and video
------------------------------

See: https://github.com/savonet/liquidsoap/discussions/1862

Live switch between encoded content
-----------------------------------

*This is an ongoing development effort. Please refer to the online support channels if you are experiencing issues with this kind of feature.*

Starting with liquidsoap `2.1.x`, it is gradually becoming possible to do proper live switches on encoded content and send the
result to different outputs.

Please note that this requires a solid knowledge of media codecs, containers and ffmpeg bitstream filters. Different input and output
containers store codec binary data in different ways and those are not always compatible. This requires the use of bitstream filters
to adapt the binary data and, it's possible some new filters will need to be written to support more combinations of input/output and codecs.

Here's a use case that has been tested: live switch between a playlist of mp4 files and a rtmp flv input:

```liquidsoap
s1 = input.rtmp(listen=false,"rtmp://....")
s1 = ffmpeg.filter.bitstream.h264_mp4toannexb(s1)

s2 = playlist("/path/to/playlist")
s2 = ffmpeg.filter.bitstream.h264_mp4toannexb(s2)

s = fallback(track_sensitive=false, [s1, s2])

mpegts = %ffmpeg(
  format="mpegts",
  fflags="-autobsf",
  %audio.copy, %video.copy)

streams = [
  ("mpegts",mpegts),
]

output_dir = "/tmp/hls"

output.file.hls(playlist="live.m3u8",
                fallible=true,
                segment_duration=5.,
                output_dir,
                streams,
                s)
```

* We need the `h264_mp4toannexb` on each stream to make sure that the mp4 data conforms to what the mpegts container expect
* We need to disable ffmpeg's automatic insertion of bitstream filters via `-autobsf`. FFmpeg does not support this kind of live switch at the moment and its automatically inserted filters won't work, which is why we're doing it ourselves.

That's it! In the future we want to extend this use-case to also be able to output to a `rtmp` output from the same data. And more!
