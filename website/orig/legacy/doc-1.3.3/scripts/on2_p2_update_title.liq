# This function updates the title metadata with
# the content of "/tmp/metadata"
def update_title(m) = 
  # The title metadata
  title = m["title"]
  # Our addition
  content = list.hd(get_process_lines("cat /tmp/metadata"))
  
  # If title is empty
  if title == "" then
    [("title",content)]
  # Otherwise
  else
    [("title","#{title} on #{content}")]
  end
end
