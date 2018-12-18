# ... same, but also add smart cross-fading
liquidsoap 'out(smart_crossfade(
                  normalize(playlist("playlist_file"))))'
