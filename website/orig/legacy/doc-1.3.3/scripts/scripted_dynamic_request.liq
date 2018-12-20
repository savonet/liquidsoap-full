def my_request_function() = 
  # Get the first line of my external process
  result =
    list.hd(
      get_process_lines("my_script my_params"))
  # Create and return a request using this result
  request.create(result)
end

# Create the source
s = request.dynamic(my_request_function)
