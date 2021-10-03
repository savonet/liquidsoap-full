# Input from webcam
cam = input.v4l2()

# Detect faces (this generates a white disk over faces)
mask = video.frei0r.opencvfacedetect(cam)
# Pixellize the video
censored = video.frei0r.pixeliz0r(blocksizex=0.1,blocksizey=0.1,cam)
# Generate a mask for video without the face
unmask = video.frei0r.invert0r(mask)
# Put the pixellized face over the video
s = video.frei0r.addition(
  video.frei0r.multiply(mask,censored),
  video.frei0r.multiply(unmask,cam))
# We have to bufferize the source because its clock it GStreamer's clock
s = buffer(buffer=0.1,mksafe(s))

# Input audio from microphone
mic = input.pulseaudio(clock_safe=false)
# Transpose sound to generate a funny voice
mic = soundtouch(pitch=1.5,mic)
# Add sound to video
s = mux_audio(audio=mic,s)

# Let's hear the sound
output.pulseaudio(fallible=true,s)
# Let's see the video
output.sdl(fallible=true,drop_audio(s))

s = mksafe(s)
# Output the video/sound into a file in theora/vorbis format
output.file(%ogg(%theora(quality=63),%vorbis), "anonymous.ogv", s)
