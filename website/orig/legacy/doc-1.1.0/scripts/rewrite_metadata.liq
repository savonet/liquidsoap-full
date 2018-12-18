# The 'display_artist' field is passed using annotate.
pattern = 
  '$(if $(display_artist),"$(display_artist)","$(artist)")'
rewrite_metadata([("artist",pattern)],source)
