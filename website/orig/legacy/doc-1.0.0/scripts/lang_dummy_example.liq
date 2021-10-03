radio =
  output.icecast(
    %vorbis,mount="test.ogg",
    random(
      [ jingle ,
        fallback([ playlist1,playlist2,playlist3 ]) ]))
