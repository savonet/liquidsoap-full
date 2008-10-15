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

exception Not_rcs_timepoint
let rcs_timepoint_ns = "urn:PEContentSchema"

class rcs_timepoint =
  object (self)
    val mutable time = 0.
    val mutable description = ""

    method time = time
    method set_time t = time <- t
    method description = description
    method set_description d = description <- d
  end
let rcs_timepoint_from_xml root =
  (match root#get_namespaceURI with
    | Some s -> if (s#to_string <> rcs_timepoint_ns) then raise Not_rcs_timepoint
    | None -> raise Not_rcs_timepoint ) ;
  let c = new rcs_timepoint in
    (* Children *)
    let children = domiterator_to_element_list root#get_childNodes in
      List.iter (fun (_,e) ->
        match e#get_localName with
          | Some s ->
              (match s#to_string with
                | "time" -> c#set_time (float_of_string (get_element_contents e))
                | "description" -> c#set_description (get_element_contents e)
                | _ -> () (* be extensible, and ignore any unknown element *)
              )
          | None -> assert false (* impossible *)
        ) children ;
        c

exception Not_rcs_mediaformat
let rcs_mediaformat_ns = "urn:PEContentSchema"

class rcs_mediaformat =
  object (self)
    val mutable encoding = ""
    val mutable packaging = ""
    val mutable num_channels = 0
    val mutable samplerate = 0

    method encoding = encoding
    method set_encoding e = encoding <- e
    method packaging = packaging
    method set_packaging p = packaging <- p
    method num_channels = num_channels
    method set_num_channels n = num_channels <- n
    method samplerate = samplerate
    method set_samplerate s = samplerate <- s
  end
let rcs_mediaformat_from_xml root =
  (match root#get_namespaceURI with
    | Some s -> if (s#to_string <> rcs_mediaformat_ns) then raise Not_rcs_mediaformat
    | None -> raise Not_rcs_mediaformat ) ;
  let c = new rcs_mediaformat in
    (* Children *)
    let children = domiterator_to_element_list root#get_childNodes in
      List.iter (fun (_,e) ->
        match e#get_localName with
          | Some s ->
              (match s#to_string with
                | "encoding" -> c#set_encoding (get_element_contents e)
                | "packaging" -> c#set_packaging (get_element_contents e)
                | "numChannels" -> c#set_num_channels (int_of_string (get_element_contents e))
                | "sampleRate" -> c#set_samplerate (int_of_string (get_element_contents e))
                | _ -> () (* be extensible, and ignore any unknown element *)
              )
          | None -> assert false (* impossible *)
        ) children ;
        c

exception Not_rcs_media
let rcs_media_ns = "urn:PEContentSchema"

class rcs_media =
  object (self)
    val mutable format : rcs_mediaformat list = []
    val mutable timepoint : rcs_timepoint list = []

    method format = format
    method add_format f = format <- format@[f]
    method timepoint = timepoint
    method add_timepoint t = timepoint <- timepoint@[t]
  end
let rcs_media_from_xml root =
  (match root#get_namespaceURI with
    | Some s -> if (s#to_string <> rcs_media_ns) then raise Not_rcs_media
    | None -> raise Not_rcs_media ) ;
  let c = new rcs_media in
    (* Children *)
    let children = domiterator_to_element_list root#get_childNodes in
      List.iter (fun (_,e) ->
        match e#get_localName with
          | Some s ->
              (match s#to_string with
                | "MediaFormat" -> c#add_format (rcs_mediaformat_from_xml e)
                | "TimePoint" -> c#add_timepoint (rcs_timepoint_from_xml e)
                | _ -> () (* be extensible, and ignore any unknown element *)
              )
          | None -> assert false (* impossible *)
        ) children ;
        c

exception Not_rcs_artist
let rcs_artist_ns = "urn:SongSchema"

class rcs_artist =
  object (self)
    val mutable name = ""
    val mutable guid = ""
    val mutable internal_id = ""
    val mutable sequencenumber = ""

    method name = name
    method set_name n = name <- n
    method guid = guid
    method set_guid g = guid <- g
    method internal_id = internal_id
    method set_internal_id i = internal_id <- i
    method sequencenumber = sequencenumber
    method set_sequencenumber s = sequencenumber <- s
  end
let rcs_artist_from_xml root =
  (match root#get_namespaceURI with
    | Some s -> if (s#to_string <> rcs_artist_ns) then raise Not_rcs_artist
    | None -> raise Not_rcs_artist ) ;
  let c = new rcs_artist in
    (* Children *)
    let children = domiterator_to_element_list root#get_childNodes in
      List.iter (fun (_,e) ->
        match e#get_localName with
          | Some s ->
              (match s#to_string with
                | "name" -> c#set_name (get_element_contents e)
                | "guid" -> c#set_guid (get_element_contents e)
                | "internal_id" -> c#set_internal_id (get_element_contents e)
                | "sequencenumber" -> c#set_sequencenumber (get_element_contents e)
                | _ -> () (* be extensible, and ignore any unknown element *)
              )
          | None -> assert false (* impossible *)
        ) children ;
        c

exception Not_rcs_song
let rcs_song_ns = "urn:SongSchema"

class rcs_song =
  object (self)
    val mutable title = ""
    val mutable guid = ""
    val mutable internal_id = ""
    val mutable category = ""
    val mutable opening = ""
    val mutable ending = ""
    val mutable artist : rcs_artist list = []
    val mutable media : rcs_media list = []

    method title = title
    method set_title t = title <- t
    method guid = guid
    method set_guid g = guid <- g
    method internal_id = internal_id
    method set_internal_id i = internal_id <- i
    method category = category
    method set_category c = category <- c
    method opening = opening
    method set_opening o = opening <- o
    method ending = ending
    method set_ending e = ending <- e
    method artist = artist
    method add_artist a = artist <- artist@[a]
    method media = media
    method add_media m = media <- media@[m]
  end
let rcs_song_from_xml root =
  (match root#get_namespaceURI with
    | Some s -> if (s#to_string <> rcs_song_ns) then raise Not_rcs_song
    | None -> raise Not_rcs_song ) ;
  let c = new rcs_song in
    (* Children *)
    let children = domiterator_to_element_list root#get_childNodes in
      List.iter (fun (_,e) ->
        match e#get_localName with
          | Some s ->
              (match s#to_string with
                | "title" -> c#set_title (get_element_contents e)
                | "guid" -> c#set_guid (get_element_contents e)
                | "internal_id" -> c#set_internal_id (get_element_contents e)
                | "category" -> c#set_category (get_element_contents e)
                | "opening" -> c#set_opening (get_element_contents e)
                | "ending" -> c#set_ending (get_element_contents e)
                | "Artist" -> c#add_artist (rcs_artist_from_xml e)
                | "Media" -> c#add_media (rcs_media_from_xml e)
                | _ -> () (* be extensible, and ignore any unknown element *)
              )
          | None -> assert false (* impossible *)
        ) children ;
        c

