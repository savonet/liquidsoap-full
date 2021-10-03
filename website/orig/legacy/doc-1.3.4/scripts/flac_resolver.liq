if test_process("which metaflac") then
  log(level=3,"Found metaflac binary: \
               enabling flac external metadata resolver.")
  def flac_meta(file)
    ret = get_process_lines("metaflac --export-tags-to=- \
                            #{quote(file)} 2>/dev/null")
    ret = list.map(string.split(separator="="),ret)
    # Could be made better..
    def f(l',l)=
      if list.length(l) >= 2 then
        list.append([(list.hd(default="",l),list.nth(default="",l,1))],l')
      else
        if list.length(l) >= 1 then
          list.append([(list.hd(default="",l),"")],l')
        else
          l'
        end
      end
    end
  list.fold(f,[],ret)
  end
  add_metadata_resolver("FLAC",flac_meta)
end
