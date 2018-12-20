# Variable bitrate
%vorbis(samplerate=44100, channels=2, quality=0.3)
% Average bitrate
%vorbis.abr(samplerate=44100, channels=2, bitrate=128, max_bitrate=192, min_bitrate=64)
# Constant bitrate
%vorbis.cbr(samplerate=44100, channels=2, bitrate=128)
