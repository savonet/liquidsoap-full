server.read "OVER[\r\n]+" :  ret then
  log("Read until OVER: #{ret}")
  # Do more stuff then send the final response:
  "Done!"
end
