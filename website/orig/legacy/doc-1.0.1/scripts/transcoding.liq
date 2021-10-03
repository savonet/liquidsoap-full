# Input the stream,
# from an Icecast server or any other source
url = "http://streaming.example.com:8000/your-stream.ogg"
input = mksafe(input.http(url))

# First transcoder: MP3 32 kbps
# We also degrade the samplerate, and encode in mono
# Accordingly, a mono conversion is performed on the input stream
output.icecast(
  %mp3(bitrate=32, samplerate=22050, stereo=false),
  mount="/your-stream-32.mp3",
  host="streaming.example.com", port=8000, password="xxx",
  mean(input))
# Second transcoder : MP3 128 kbps
output.icecast(
  %mp3(bitrate=128), 
  mount="/your-stream-128.mp3",
  host="streaming.example.com", port=8000, password="xxx",
  input)
