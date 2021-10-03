## Introduction

You can use external programs in liquidsoap to decode audio files. The program must be able to
output WAV data to its standard output (`stdout`) and, posssibly, read encoded data from its 
standard input.

Please note that this feature is not available under Windows.

## Basic operators

External decoders are registered using the `add_decoder` and `add_oblivious_decoder` operators. 
They are invoked the following way: 

### add_decoder

```liquidsoap
add_decoder(name="my_decoder",description="My custom decoder",
            test,decoder)
```

`add_decoder` is used for external decoders that can read the encoded data from their standard
input (stdin) and write the decoded data as WAV to their standard output (stdout). This operator
is recommended because its estimation of the remaining time is better than the estimation done
by the decoders registered using `add_oblivious_decoder`. The important parameters are:

* `test` is a function used to determine if the file should be decoded by the decoder. Returned values are:  * `0`: no decodable audio, 
 * `-1`: decodable audio but number of audio channels unknown, 
 * `x`: fixed number of decodable audio channels.


* `decoder` is the string containing the shell command to run to execute the decoding process.

### add_oblivious_decoder

`add_oblivious_decoder` is very similar to `add_decoder`. The main difference is that the
decoding program reads encoded data directly from the local files and not its standard input.
Decoders registered using this operator do not have a reliable estimation of the remaining
time. You should use `add_oblivious_decoder` only if your decoding program is not able
to read the encoded data from its standard input.

```liquidsoap
add_oblivious_decoder(name="my_decoder",description="My custom decoder",
                      buffer=5., test,decoder)
```

`add_decoder` is used for external decoders that can read the encoded data from their standard
input (stdin) and write the decoded data as WAV to their standard output (stdout). This operator
is recommended because its estimation of the remaining time is better than the estimation done
by the decoders registered using `add_oblivious_decoder`. The important parameters are:

* `test` is a function used to determine if the file should be decoded by the decoder. Returned values are:  * `0`: no decodable audio,
 * `-1`: decodable audio but number of audio channels unknown,
 * `x`: fixed number of decodable audio channels.


* `decoder` is a function that receives the name of the file that should be decoded and returns a string containing the shell command to run to execute the decoding process.

### add_metadata_resolver

You may also register new metadata resolvers using the `add_metadata_resolver` operator. It is invoked the
following way: `add_metadata_resolver(format,resolver)`, where:

* `format` is the name of the resolved format. It is only informative.
* `resolver` is a function `f` that returns a list of metadata of the form: `(label, value)`. It is invoked the following way: `f(format=name,file)`, where: * `format` contains the name of the format, as returned by the decoder that accepted to decode the file. `f` may return immediately if this is not an expected value.
 * `file` is the name of the file to decode.

## Wrappers

On top of the basic operators, wrappers have been written for some common decoders. This includes the `flac` and 
`faad` decoders, by default. All the operators are defined in `externals.liq`.

### The FLAC decoder

The flac decoder uses the `flac` command line. It is enabled if the binary can be found in the current `$PATH`.

Its code is the following:

```liquidsoap
  def test_flac(file) =
    if test_process("which metaflac") then
      channels = list.hd(default="",get_process_lines("metaflac \
                                            --show-channels #{quote(file)} \
                                            2>/dev/null"))
      # If the value is not an int, this returns 0 and we are ok :)
      int_of_string(channels)
    else
      # Try to detect using mime test..
      mime = get_mime(file)
      if string.match(pattern="flac",file) then
        # We do not know the number of audio channels
        # so setting to -1
        (-1)
      else
        # All tests failed: no audio decodable using flac..
        0
      end
    end
  end
  add_decoder(name="FLAC",description="Decode files using the flac \
              decoder binary.", test=test_flac,flac_p)
```

Additionaly, a metadata resolver is registered when the `metaflac` command can be found in the `$PATH`:

```liquidsoap
if test_process("which metaflac") then
  log(level=3,"Found metaflac binary: \
               enabling flac external metadata resolver.")
  def flac_meta(file)
    ret = get_process_lines("metaflac --export-tags-to=- \
                            #{quote(file)} 2>/dev/null")
    ret = list.map(string.split(separator="="),ret)
    # Could be made better..
    def f(l',l)=
      if list.length(l) >= 2 then
        list.append([(list.hd(default="",l),list.nth(default="",l,1))],l')
      else
        if list.length(l) >= 1 then
          list.append([(list.hd(default="",l),"")],l')
        else
          l'
        end
      end
    end
  list.fold(f,[],ret)
  end
  add_metadata_resolver("FLAC",flac_meta)
end
```

### The faad decoder

The faad decoder uses the `faad` program, if found in the `$PATH`. 
It can decode AAC and AAC+ audio files. This program does not support
reading encoded data from its standard input so the decoder is 
registered using `add_oblivious_decoder`.

Its code is the following:

```liquidsoap
  aac_mimes = ["audio/aac", "audio/aacp", "audio/3gpp", "audio/3gpp2", "audio/mp4",
               "audio/MP4A-LATM", "audio/mpeg4-generic", "audio/x-hx-aac-adts"]
  aac_filexts = ["m4a", "m4b", "m4p", "m4v",
                 "m4r", "3gp", "mp4", "aac"]

  # Faad is not very selective so
  # We are checking only file that
  # end with a known extension or mime type
  def faad_test(file) =
    # Get the file's mime
    mime = get_mime(file)
    # Test mime
    if list.mem(mime,aac_mimes) then
      true
    else
      # Otherwise test file extension
      ret = string.extract(pattern='\.(.+)$',file)
        if list.length(ret) != 0 then
          ext = ret["1"]
          list.mem(ext,aac_filexts)
        else
          false
        end
    end
  end

  if test_process("which faad") then
    log(level=3,"Found faad binary: enabling external faad decoder and \
                 metadata resolver.")
    faad_p = (fun (f) -> "faad -w #{quote(f)} 2>/dev/null")
    def test_faad(file) =
      if faad_test(file) then
        channels = list.hd(default="",get_process_lines("faad -i #{quote(file)} 2>&1 | \
                                                         grep 'ch,'"))
        ret = string.extract(pattern=", (\d) ch,",channels)
        ret =
          if list.length(ret) == 0 then
          # If we pass the faad_test, chances are
          # high that the file will contain aac audio data..
            "-1"
          else
            ret["1"]
          end
        int_of_string(default=(-1),ret)
      else
        0
      end
    end
    add_oblivious_decoder(name="FAAD",description="Decode files using \
                          the faad binary.", test=test_faad, faad_p)
    def faad_meta(file) =
      if faad_test(file) then
        ret = get_process_lines("faad -i \
                     #{quote(file)} 2>&1")
        # Yea, this is tuff programming (again) !
        def get_meta(l,s)=
          ret = string.extract(pattern="^(\w+):\s(.+)$",s)
          if list.length(ret) > 0 then
            list.append([(ret["1"],ret["2"])],l)
          else
            l
          end
        end
        list.fold(get_meta,[],ret)
      else
        []
      end
    end
    add_metadata_resolver("FAAD",faad_meta)
  end
```


