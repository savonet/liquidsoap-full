def cue_protocol(~rlog,~maxtime,arg) =
  [process_uri(extname="wav",uri=uri,"ffmpeg -y -i $(input) -af -ss 10 -t 30 $(output)")]
end
add_protocol("cue_cut",cue_protocol)
