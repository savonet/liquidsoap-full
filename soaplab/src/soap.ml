(*****************************************************************************

  SoapLab, an integrated automation system.
  Copyright 2007 Savonet team

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details, fully stated in the COPYING
  file at the root of the liquidsoap distribution.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

 *****************************************************************************)

open Gdome
open DomHelper

exception Element_not_found of string
exception Unhandled_content_type of string
exception Unhandled_role of string

(* SOAP Body *)
type soap_body_type = Xspf_playlist of Xspf.xspf_playlist | Rcs_song of Rcs.rcs_song
let xspf_playlist_of_soap_body = function
  | Xspf_playlist a -> a
  | _ -> assert false
let rcs_song_of_soap_body = function
  | Rcs_song a -> a
  | _ -> assert false

(* Liq Message Header *)
type message_role = Types_list | Categories_list | Category_contents
                    | Song_metadata
type liq_message_header = { content_type: string ;
                            role: message_role ;
                            date_time: int ;
                            sender: string }

(* Parse a SOAP document *)
let parse_soap_document uri =
  let di = domImplementation () in
  let doc = di#createDocumentFromURI ~uri () in
  let root = doc#get_documentElement in
    (* Root element: SOAP Envelope *)
    (match root#get_namespaceURI with
      | Some u ->
        (
          let ns,tag = split_ns_tag root#get_tagName#to_string in
            Printf.printf "Root element: %s (in %s).\n" tag u#to_string ;
            if (tag <> "Envelope" || u#to_string <> soap_envelope_ns) then
              (
                raise Not_Soap_Envelope
              )
        )
      | _ -> raise (Bad_namespace "") ) ;
    let level1_elements = (domiterator_to_element_list root#get_childNodes) in
    (* First child: SOAP Header *)
    let header = 
      try
        let header = List.assoc (soap_envelope_ns ^ ":Header") level1_elements in
          Printf.printf " SOAP Envelope Header element encountered.\n" ;
          (* We expect a Liq Message Type Header *)
          let lmt_header =
            List.assoc (liq_message_type_ns ^ ":Header")
                       (domiterator_to_element_list header#get_childNodes)
          in
            Printf.printf "  Liq Message Type Header element encountered.\n" ;
            (* Attributes *)
            let role = lmt_header#getAttributeNS ~namespaceURI:(Gdome.domString soap_envelope_ns) ~localName:(Gdome.domString "role")
            and must = lmt_header#getAttributeNS ~namespaceURI:(Gdome.domString soap_envelope_ns) ~localName:(Gdome.domString "mustUnderstand")
            in
              Printf.printf "   > Role: %s\n   > Must Understand? %s\n" role#to_string (if (must#to_string = "true") then "yes" else "no") ;
            (* Children *)
            let children = domiterator_to_element_list lmt_header#get_childNodes in
              let message_type = List.assoc (liq_message_type_ns ^ ":message-type") children in
                let mt_children = domiterator_to_element_list message_type#get_childNodes in
                let content_type = get_element_contents (List.assoc (liq_message_type_ns ^ ":content-type") mt_children)
                and role =
                  let r = get_element_contents (List.assoc (liq_message_type_ns ^ ":role") mt_children) in
                    (match r with
                      | "http://savonet.sf.net/message/role/types-list" -> Types_list
                      | "http://savonet.sf.net/message/role/categories-list" -> Categories_list
                      | "http://savonet.sf.net/message/role/category-contents" -> Category_contents
                      | "http://savonet.sf.net/message/role/song-metadata" -> Song_metadata
                      | _ -> raise (Unhandled_role r))
                in
              let date_time = get_element_contents (List.assoc (liq_message_type_ns ^ ":sender") children) in
              let sender = List.assoc (liq_message_type_ns ^ ":sender") children in
                let s_children = domiterator_to_element_list sender#get_childNodes in
                let server = get_element_contents (List.assoc (liq_message_type_ns ^ ":server") s_children) in
                  { content_type = content_type ; role = role ;
                    date_time = 0 ; sender = server }
      with
        | Not_found -> raise (Element_not_found "Header")
    in
    (* Second child: SOAP Body *)
    Printf.printf "Body content-type: %s.\n" header.content_type ;
    let body =
      try
        let body = 
          List.assoc (soap_envelope_ns ^ ":Body") level1_elements
        in
          match header.content_type with
            | "application/xspf+xml" ->
                let xspf =
                  let c = domiterator_to_element_list body#get_childNodes in
                    (try
                      List.assoc (Xspf.xspf_ns ^ ":playlist") c
                    with
                      | Not_found -> raise (Element_not_found (Xspf.xspf_ns ^ ":playlist")))
                in
                  let pl = Xspf.xspf_playlist_from_xml xspf in
                    (Xspf_playlist pl)
            | "application/x-rcs+xml" ->
                let xml =
                  let c = domiterator_to_element_list body#get_childNodes in
                    (try
                      List.assoc (Rcs.rcs_song_ns ^ ":Song") c
                    with
                      | Not_found -> raise (Element_not_found (Rcs.rcs_song_ns ^ ":Song")))
                in
                  let s = Rcs.rcs_song_from_xml xml in
                    (Rcs_song s)
            | _ -> raise (Unhandled_content_type header.content_type)
      with
        | Not_found -> raise (Element_not_found (soap_envelope_ns ^ ":Body"))
    in
      header,body

