def normalization_protocol(~rlog,~maxtime,arg) =
  # "normalize" command here is just an example..
  [process_uri(extname="wav",uri=arg,"normalize $(inpuit)")]
end
add_protocol("normalize",normalization_protoco)
