def s3_protocol(~rlog,~maxtime,arg) =
  extname = file.extension(dir_sep="/",arg)
  [process_uri(extname=extname,"aws s3 cp s3:#{arg} $(output)")]
end
add_protocol("s3",s3_protocol,doc="Fetch files from s3 using the AWS CLI",
             syntax="s3://uri")
