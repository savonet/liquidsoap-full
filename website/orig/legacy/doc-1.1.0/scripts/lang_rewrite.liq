# Rewrite metadata on the fly using a list of (target,rule).
# @category Source / Track Processing
# @param l  List of (target,value) rewriting rules
# @param ~insert_missing \
#           Treat track beginnings without metadata \
#           as having empty ones.
def rewrite_metadata(l,~insert_missing=true,s)
  def map(m)
    def apply(x)
      label = fst(x)
      meta = snd(x)
      if list.mem_assoc(label,l) then
        pattern = l[label]
        (label,pattern % m)
      else
        (label,meta)
      end
    end
    m = list.map(apply,m)
    def add(m,x)
      label = fst(x)
      pattern = snd(x)
      # If m does not have (label,_), then it was
      # not processed previously, we have to
      # add it now..
      if not list.mem_assoc(label,m) then
        list.append(m,[(label,pattern % m)])
      else
        m
      end
    end
    list.fold(add,m,l)
  end
  map_metadata(map,insert_missing=insert_missing,s)
end
