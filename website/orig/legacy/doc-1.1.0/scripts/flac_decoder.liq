  def test_flac(file) =
    if test_process("which metaflac") then
      channels = list.hd(get_process_lines("metaflac \
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
