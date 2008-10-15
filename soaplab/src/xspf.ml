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

open DomHelper

(* XSPF Parser *)
exception Not_xspf
type xspf_link = { rel: string ; href: string }
type xspf_meta = xspf_link
type xspf_extension = { application: string ; data: Gdome.element }
let xspf_ns = "http://xspf.org/ns/0/"

(* XSPF Track *)
class xspf_track =
  object (self)
    val mutable title = ""
    val mutable creator = ""
    val mutable annotation = ""
    val mutable info = ""
    val mutable location = ""
    val mutable identifier = ""
    val mutable image = ""
    val mutable album = ""
    val mutable trackNum = 0
    val mutable duration = 0
    val mutable link : xspf_link list = []
    val mutable meta : xspf_meta list = []
    val mutable extension : xspf_extension list = []
    
    method title = title
    method set_title t = title <- t
    method creator = creator
    method set_creator c = creator <- c
    method annotation = annotation
    method set_annotation a = annotation <- a
    method info = info
    method set_info i = info <- i
    method location = location
    method set_location l = location <- l
    method identifier = identifier
    method set_identifier i = identifier <- i
    method image = image
    method set_image i = image <- i
    method album = album
    method set_album a = album <- a
    method trackNum = trackNum
    method set_trackNum n = trackNum <- n
    method duration = duration
    method set_duration d = duration <- d
    method link = link
    method add_link l = link <- link@[l]
    method meta = meta
    method add_meta m = meta <- meta@[m]
    method extension = extension
    method add_extension e = extension <- extension@[e]
  end
let xspf_track_from_xml root =
  (match root#get_namespaceURI with
    | Some s -> if (s#to_string <> xspf_ns) then raise Not_xspf
    | None -> raise Not_xspf ) ;
  let tr = new xspf_track in
    (* Children *)
    let children = domiterator_to_element_list root#get_childNodes in
      List.iter (fun (_,e) ->
        match e#get_localName with
          | Some s ->
              (match s#to_string with
                | "title" -> tr#set_title (get_element_contents e)
                | "creator" -> tr#set_creator (get_element_contents e)
                | "annotation" -> tr#set_annotation (get_element_contents e)
                | "info" -> tr#set_info (get_element_contents e)
                | "location" -> tr#set_location (get_element_contents e)
                | "identifier" -> tr#set_identifier (get_element_contents e)
                | "image" -> tr#set_image (get_element_contents e)
                | "album" -> tr#set_album (get_element_contents e)
                | "trackNum" -> tr#set_trackNum (int_of_string (get_element_contents e))
                | "duration" -> tr#set_duration (int_of_string (get_element_contents e))
                | "link" ->
                    let rel = e#getAttributeNS
                                ~namespaceURI:(Gdome.domString xspf_ns)
                                ~localName:(Gdome.domString "rel")
                    in
                      tr#add_link {rel = rel#to_string ;
                                   href = get_element_contents e}
                | "meta" ->
                    let rel = e#getAttributeNS
                                ~namespaceURI:(Gdome.domString xspf_ns)
                                ~localName:(Gdome.domString "rel")
                    in
                      tr#add_meta {rel = rel#to_string ;
                                   href = get_element_contents e}
                | "extension" ->
                    let app = e#getAttributeNS
                                ~namespaceURI:(Gdome.domString xspf_ns)
                                ~localName:(Gdome.domString "application")
                    in
                      tr#add_extension {application = app#to_string ; data = e}
                | _ -> () (* be extensible, and ignore any unknown elementhttp://savonet.sf.net/message/role/category-contents *)
              )
          | None -> assert false (* impossible *)
        ) children ;
        tr

(* XSPF Playlist *)
class xspf_playlist =
  object (self)
    val mutable version = 1
    val mutable title = ""
    val mutable creator = ""
    val mutable annotation = ""
    val mutable info = ""
    val mutable location = ""
    val mutable identifier = ""
    val mutable image = ""
    val mutable date = ""
    val mutable license : string list = []
    val mutable attribution = "" (* unhandled atm *)
    val mutable link : xspf_link list = []
    val mutable meta : xspf_meta list = []
    val mutable extension : xspf_extension list = []
    val mutable tracks : xspf_track list = []
    
    method version = version
    method set_version v = version <- v
    method title = title
    method set_title t = title <- t
    method creator = creator
    method set_creator c = creator <- c
    method annotation = annotation
    method set_annotation a = annotation <- a
    method info = info
    method set_info i = info <- i
    method location = location
    method set_location l = location <- l
    method identifier = identifier
    method set_identifier i = identifier <- i
    method image = image
    method set_image i = image <- i
    method date = date
    method set_date d = date <- d
    method license = license
    method add_license l = license <- license@[l] (* ro, no del *)
    method link = link
    method add_link l = link <- link@[l]
    method meta = meta
    method add_meta m = meta <- meta@[m]
    method extension = extension
    method add_extension e = extension <- extension@[e]
    method tracks = tracks
    method add_track t = tracks <- tracks@[t]
    method set_trackList l = tracks <- l
  end
let xspf_playlist_from_xml root =
  (match root#get_namespaceURI with
    | Some s -> if (s#to_string <> xspf_ns) then raise Not_xspf
    | None -> raise Not_xspf ) ;
  let pl = new xspf_playlist in
    (* Attributes *)
    let version = root#getAttributeNS ~namespaceURI:(Gdome.domString xspf_ns)
                                      ~localName:(Gdome.domString "version")
    in
      if (version#to_string <> "") then
        pl#set_version (int_of_string version#to_string) ;
    (* Children *)
    let children = domiterator_to_element_list root#get_childNodes in
      List.iter (fun (_,e) ->
        match e#get_localName with
          | Some s ->
              (match s#to_string with
                | "title" -> pl#set_title (get_element_contents e)
                | "creator" -> pl#set_creator (get_element_contents e)
                | "annotation" -> pl#set_annotation (get_element_contents e)
                | "info" -> pl#set_info (get_element_contents e)
                | "location" -> pl#set_location (get_element_contents e)
                | "identifier" -> pl#set_identifier (get_element_contents e)
                | "image" -> pl#set_image (get_element_contents e)
                | "date" -> pl#set_date (get_element_contents e)
                | "license" -> pl#add_license (get_element_contents e)
                | "link" ->
                    let rel = e#getAttributeNS
                                ~namespaceURI:(Gdome.domString xspf_ns)
                                ~localName:(Gdome.domString "rel")
                    in
                      pl#add_link {rel = rel#to_string ;
                                   href = get_element_contents e}
                | "meta" ->
                    let rel = e#getAttributeNS
                                ~namespaceURI:(Gdome.domString xspf_ns)
                                ~localName:(Gdome.domString "rel")
                    in
                      pl#add_meta {rel = rel#to_string ;
                                   href = get_element_contents e}
                | "extension" ->
                    let app = e#getAttributeNS
                                ~namespaceURI:(Gdome.domString xspf_ns)
                                ~localName:(Gdome.domString "applicaton")
                    in
                      pl#add_extension {application = app#to_string ; data = e}
                | "trackList" ->
                   let tracks = domiterator_to_element_list e#get_childNodes in
                     pl#set_trackList
                       (List.map (fun (_,t) -> xspf_track_from_xml t) tracks)
                | _ -> () (* be extensible, and ignore any unknown element *)
              )
          | None -> assert false (* impossible *)
        ) children ;
        pl
