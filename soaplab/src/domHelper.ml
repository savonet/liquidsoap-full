exception Bad_namespace of string
exception Unknown_element of string
exception Not_text_node
exception Not_Soap_Envelope

(* Namespaces *)
let soap_envelope_ns = "http://www.w3.org/2003/05/soap-envelope"
let liq_message_type_ns = "http://savonet.sf.net/ns/message-type"

(* DOM XML Helper functions *)
let split_ns_tag tag =
  try
    let i = String.rindex tag ':' in
      String.sub tag 0 i, String.sub tag (i + 1) (String.length tag - i - 1)
  with
    | Not_found -> "",tag

let domiterator_to_element_list di =
  let l = ref [] in
  for index = 1 to di#get_length do
   let child = di#item ~index in
      match child with
        | Some c ->
          (match c#get_nodeType with
            | GdomeNodeTypeT.ELEMENT_NODE ->
              let e = (new Gdome.element_of_node c) in
                let ns,tag = split_ns_tag e#get_tagName#to_string in
                let t =
                  (match e#get_namespaceURI with
                    | Some u -> (u#to_string ^ ":")
                    | None -> "")
                in
                  l := !l@[(t ^ tag, e)]
            | _ -> () (* Discardable node type *))
        | None -> () (* No child *)
  done ;
  !l

let get_element_contents e =
  let child = e#get_firstChild in
    match child with
      | Some c ->
        (match c#get_nodeType with
          | GdomeNodeTypeT.TEXT_NODE ->
            (match c#get_nodeValue with
              | Some v -> v#to_string
              | _ -> "" (* Empty text node *))
          | _ -> raise Not_text_node)
      | None -> "" (* Empty node *)

