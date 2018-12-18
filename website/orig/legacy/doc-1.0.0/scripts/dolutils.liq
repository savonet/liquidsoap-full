def dole_fade (~start_next=3.,~fade_in=3.,~fade_out=3.,
                     ~width=1.,~conservative=false,~jingles,s)
  mf_high = 20.
  mf_medium = 32.
  mf_margin = 4.
  fade.out = fade.out(duration=fade_out)
  fade.in = fade.in(duration=fade_in)

  j = random(id="jrand",
             strict=true,weights=[1,5],
             [jingles, blank(id="bbb",duration=1.)])
  add = fun (from,to) ->
    add(normalize=false,
        [ to,
          sequence([ j, fallback([]) ]),
          from ])

  log = log(label="dole_fade")

  def transition (a, b, ma, mb, sa, sb)
    if
      (a + mf_high >= 0. and b + mf_high >= 0.) or
      (a + mf_medium >= 0. and b + mf_medium >= 0. and abs(a - b) <= mf_margin)
    then
      log("No transition, just sequencing.")
      sequence([sa, sb])

    elsif
      a + mf_medium <= 0. and b + mf_medium >= 0. and abs(a - b) <= mf_margin
    then
      log("Using transition 1: crossed.")
      add(fade.out(sa),fade.in(sb))

    elsif
      b >= a + mf_margin and a <= mf_high
    then
      log("Using transition 2: crossed, fade-out.")
      add(fade.out(sa),sb)

    elsif
      a >= b + mf_margin and b <= mf_high
    then
      log("Using transition 3: crossed, fade-in.")
      add(sa,fade.in(sb))

    else
      log("Using transition 4: crossed, fade-in, fade-out.")
      add(fade.out(sa),fade.in(sb))
    end
  end

  smart_cross(transition,
               width=width,
               duration=start_next,conservative=conservative,
               s)
end

def audio_process(s)
  gain = interactive_float("compress.gain",3.)
  ratio = 3. # interactive_float("compress.ratio",3.)
  threshold = interactive_float("compress.threshold",-15.)

  target = interactive_float("norm.target",-13.)
  k_up = interactive_float("norm.kup",0.005)
  k_down = interactive_float("norm.kdn",0.1)

  s = normalize(target=target,k_up=k_up,k_down=k_down,s)
  s = compress(gain=gain,ratio=ratio,threshold=threshold,s)
  s
end
