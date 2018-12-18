def crossfade(~start_next,~fade_in,~fade_out,s)
  s = fade.in(duration=fade_in,s)
  s = fade.out(duration=fade_out,s)
  fader = fun (a,b) -> add(normalize=false,[b,a])
  cross(duration=start_next,fader,s)
end
my_source =
  crossfade(start_next=1.,fade_out=1.,fade_in=1.,my_source)
