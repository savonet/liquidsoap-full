# A source to dump
# s = ...

# Dump the stream
output.file(
    %wav(stereo=true),
    "/archive/%Y-%m-%d/%Y-%m-%d-%H_%M_%S.wav",
    on_close=fun(s)->system("qwavheaderdump -F #{s}"),
    reopen_when={0m0s},
    s
)
