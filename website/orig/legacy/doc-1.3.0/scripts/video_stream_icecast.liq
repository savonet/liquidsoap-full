source = single("video.avi")

output.icecast(
        %ogg(%theora(quality=25,width=320,height=240),%vorbis),
        host="localhost",
        port=8000,
        password="hackme",
        mount="/videostream",
        source)
