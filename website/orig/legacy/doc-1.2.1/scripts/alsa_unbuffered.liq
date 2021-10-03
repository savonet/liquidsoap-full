# Set correct frame size:
set("frame.size",940)

input = input.alsa(bufferize=false)
output.alsa(bufferize=false,input)
