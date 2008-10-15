open Ref_types

exception Unsupported_type of string

let get_some v d =
  match v with
    | Some a -> a
    | None -> d

let () =
  Printf.fprintf stderr "Reading from '%s'...\n" Sys.argv.(1) ;
  try
    let lexbuf = Lexing.from_channel (open_in Sys.argv.(1)) in
      Ref_parser.model Ref_lexer.token lexbuf
  with End_of_file -> () ;
  flush stderr ; 
  let print_val v =
    match v with
      | XML_Child (t,m) ->
          if m then
            Printf.printf "    val mutable %s : %s list = []\n" t.var_name t.var_type
          else
            Printf.printf "    val mutable %s = None\n" t.var_name
      | XML_Element e ->
          (match e.var_type with
            | "string" -> Printf.printf "    val mutable %s = %S\n" e.var_name (get_some e.default "")
            | "int" -> Printf.printf "    val mutable %s = %d\n" e.var_name (int_of_string (get_some e.default "0"))
            | "float" -> Printf.printf "    val mutable %s = %f\n" e.var_name (float_of_string (get_some e.default "0."))
            | _ -> raise (Unsupported_type e.var_type))
  in
  let print_method v =
    match v with
      | XML_Child (t,m) ->
          let v,i = t.var_name,(String.sub t.var_name 0 1) in
            if m then
              Printf.printf "    method %s = %s\n    method add_%s %s = %s <- %s@[%s]\n" v v v i v v i
            else
              Printf.printf "    method %s = %s\n    method set_%s %s = %s <- Some %s\n" v v v i v i
      | XML_Element e ->
          let v,i = e.var_name,(String.sub e.var_name 0 1) in
            Printf.printf "    method %s = %s\n    method set_%s %s = %s <- %s\n" v v v i v i
  in
  let print_parser v =
    match v with
      | XML_Child (t,m) ->
          if m then
            Printf.printf "                | %S -> c#add_%s (%s_from_xml e)\n" t.tag t.var_name t.var_type
          else
            Printf.printf "                | %S -> c#set_%s (%s_from_xml e)\n" t.tag t.var_name t.var_type
      | XML_Element e ->
          Printf.printf "                | %S -> c#set_%s (get_element_contents e)\n" e.tag e.var_name
  in
  let print_class (n,c) =
    let l = List.rev c.contents in
      Printf.printf "exception Not_%s\nlet %s_ns = \"%s\"\n\nclass %s =\n  object(self)\n" n n c.xmlns n ;
      List.iter print_val l ;
      Printf.printf "\n" ;
      List.iter print_method l ;
      Printf.printf "  end\n" ;
      Printf.printf "let %s_from_xml root =
  (match root#get_namespaceURI with
    | Some s -> if (s#to_string <> %s_ns) then raise Not_%s
    | None -> raise Not_%s ) ;
  let c = new %s in
    (* Children *)
    let children = domiterator_to_element_list root#get_childNodes in
      List.iter (fun (_,e) ->
        match e#get_localName with
          | Some s ->
              (match s#to_string with\n" n n n n n ;
      List.iter print_parser l ;
      Printf.printf "                | _ -> () (* be extensible, and ignore any unknown element *)
              )
          | None -> assert false (* impossible *)
        ) children ;
        c\n\n" ;
  in
  List.iter print_class !Ref_types.classes ;

