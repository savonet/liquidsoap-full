 # Log to stdout
 set("log.file",false)
 set("log.stdout",true)
 set("log.level",4)
 # Enable video
 set("frame.video.width",640)
 set("frame.video.height",480)

 audio_file = "/tmp/bla.mp3"
 video_file = "/tmp/bla.jpg"

 # Grab file's title
 r = request.create(audio_file)
 title = 
   if request.resolve(r) then
     meta = request.metadata(r)
     meta["title"]
   else
     # File not readable
     log("Error: cannot decode audio file!")
     shutdown () 
     ""
   end
 title = 
   if title == "" then
      "Unknow title"
   else
      title
   end

 # The audio song.
 audio = request.queue(interactive=false,queue=[r])

 # Create a video source with the image for video track
 video = single(video_file)

 # Mux audio and video
 #source = mux_audio(audio=audio,video)
 source = mux_video(video=video,audio)

 # Disable real-time processing, to process with the maximun speed
 source = clock(sync=false,source)

 # Output to a theora file, shutdown on stop
 output.file(%ogg(%vorbis,%theora),
             id="youtube",fallible=true,
             on_stop=shutdown,reopen_on_metadata=true,
             "/tmp/#{title}.ogv",
             source)
