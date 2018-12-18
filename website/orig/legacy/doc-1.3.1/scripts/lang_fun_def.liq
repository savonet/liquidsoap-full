fun (from,to,~jingle=default) ->
  add ([ sequence([single(jingle), fallback([])]),
         fade.initial(to) ])
