# Set the values for video size and fps.
# On my standard computer, higher values means
# that we cannot encode in realtime.
set("frame.video.width", 320)
set("frame.video.height",240)
set("frame.video.samplerate",12)

# The video we want to stream.
s = single("big_buck_bunny_720p_stereo.ogg")
# This hack is necessary (for now) in order
# to leave the synchronization to GStreamer.
clock.assign_new(sync=false,[s])

output.harbor(
  format="video/mpeg",
  icy_metadata="false",
  mount="/test",
  %gstreamer(video="x264enc speed-preset=1",audio="lamemp3enc"),
  s)
