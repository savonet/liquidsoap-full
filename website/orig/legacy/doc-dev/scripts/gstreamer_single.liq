s = single("test.mp4")
output.gstreamer.video(pipeline="videoconvert ! avenc_mpeg4 ! rtpmp4vpay config-interval=2 ! udpsink host=127.0.0.1 port=5000", s)
