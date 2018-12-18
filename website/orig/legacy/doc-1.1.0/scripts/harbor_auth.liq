def auth(user,password) = 
  # Call an external process to check 
  # the credentials:
  # The script will return the string 
  # "true" of "false"
  #
  # First call the script
  ret = get_process_lines("/path/to/script \
         --user=#{user} --password=#{password}")
  # Then get the first line of its output
  ret = list.hd(ret)
  # Finally returns the boolean represented 
  # by the output (bool_of_string can also 
  # be used)
  if ret == "true" then
    true
  else
    false
  end
end
