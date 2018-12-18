bubble = "/home/dbaelde/savonet/bubble/src/bubble-query " ^
         "-d /var/local/cache/bubble/bubble.sql "
add_protocol(
  "bubble",
  fun (arg,delay) -> get_process_lines(bubble^quote(arg)))
