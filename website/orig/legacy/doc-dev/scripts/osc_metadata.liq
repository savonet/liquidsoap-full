# Our main music source
s = playlist("...")
s = mksafe(s)

# Create a function to insert metadata
ms = insert_metadata(s)
# The function to insert metadata
imeta = fst(ms)
# The source with inserted metadata
s = snd(ms)

# Handler for OSC events (gets pairs of strings)
def on_meta(m) =
  # Extract the label
  label = fst(m)
  # Extract the value
  value = snd(m)
  # A debug message
  print("Insert metadata #{label} = #{value}")
  # Insert the metadata
  imeta([(label,value)])
end

# Call the above handler when we have a pair of strings on /metadata
osc.on_string_pair("/metadata",on_meta)

# Output on icecast
output.icecast(%mp3,mount="test.mp3",s)
