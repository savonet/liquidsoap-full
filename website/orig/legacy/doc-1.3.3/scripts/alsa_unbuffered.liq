# Set correct frame size:
set("frame.audio.size",2048)

input = input.alsa(bufferize=false)
output.alsa(bufferize=false,input)
