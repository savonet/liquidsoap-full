add_protocol("bubble",
  fun (arg,delay) ->
    get_process_lines("/usr/bin/bubble-query "^quote(arg)))
