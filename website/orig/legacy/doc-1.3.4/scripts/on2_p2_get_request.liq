# Our custom request function
def get_request() = 
  # Get the URI
  uri = list.hd(default="",get_process_lines("cat /tmp/request"))
  # Create a request
  request.create(uri)
end
