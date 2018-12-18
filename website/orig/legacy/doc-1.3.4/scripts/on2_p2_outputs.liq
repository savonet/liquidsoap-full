# A function that contains all the output
# we want to create with the final stream
def outputs(s) =
  # First, we partially apply output.icecast
  # with common parameters. The resulting function
  # is stored in a new definition of output.icecast,
  # but this could be my_icecast or anything.
  output.icecast = output.icecast(host="my_server", 
                                  password="hack_me_not")

  # An output in ogg/vorbis to the "my_radio.ogg"
  # mountpoint:
  output.icecast(%vorbis, mount="my_radio.ogg",s)
  
  # An output in mp3 at 128kbits to the "my_radio"
  # mountpoint:
  output.icecast(%mp3(bitrate=128), mount="my_radio",s)

  # An output in ogg/flac to the "my_radio-flac.ogg"
  # mountpoint:
  output.icecast(%ogg(%flac), mount="my_radio-flac.ogg",s)

  # An output in AAC+ at 32 kbits to the "my_radio.aac"
  # mountpoint
  output.icecast(%fdkaac(bitrate=32), mount="my_radio.aac",s)
end
