# A function applied to each metadata chunk
def append_title(m) =
  # Grab the current title
  title = m["title"]

  # Return a new title metadata
  [("title","#{title} - www.station.com")]
end

# Apply map_metadata to s using append_title
s = map_metadata(append_title, s)
