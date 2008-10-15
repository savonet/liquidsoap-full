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

open GtkHelper

(* Categories treeview *)
module CategoryColumn =
struct
  let list = new GTree.column_list
  let visibility = list#add Gobject.Data.boolean
  let icon = list#add Gobject.Data.string
  let name = list#add Gobject.Data.string
  let location = list#add Gobject.Data.string
  let etype = list#add Gobject.Data.string
end

(* Audio elements treeview *)
module AudioElementColumn =
struct
  let list = new GTree.column_list
  let visibility = list#add Gobject.Data.boolean
  let icon = list#add Gobject.Data.string
  let title = list#add Gobject.Data.string
  let artist = list#add Gobject.Data.string
  let category = list#add Gobject.Data.string
  let duration = list#add Gobject.Data.string
  let location = list#add Gobject.Data.string
  let info = list#add Gobject.Data.string
end

(* Load XML data *)
exception No_datasource

class db_palette ?(file="IAS/ias.glade") (se: SoundEditor.sound_editor) (me: MetadataEditor.metadata_editor) =
  object (self)
    inherit Ias.db_palette ~file () as super

    (* Toolbar *)
    val tbtn_se = GButton.tool_button ~label:"Sound Editor" ~stock:(`STOCK "gtk-media-play") ()
    val tbtn_me = GButton.tool_button ~label:"Metadata Editor" ~stock:`INDEX ()
    val tbtn_artists = GButton.tool_button ~label:"Artists" ()

    (* Categories treeview model *)
    val treeview_categories_store = GTree.tree_store CategoryColumn.list

    (* Audio elements treeview model *)
    val treeview_ae_store = GTree.list_store AudioElementColumn.list

    initializer
      (* Help menu *)
      ignore (self#menu_about#connect#activate ~callback:on_about);

      (* Insert toolbar elements *)
      top_toolbar#insert tbtn_se ;
      top_toolbar#insert tbtn_me ;
      top_toolbar#insert tbtn_artists ;

      (* Connect them *)
      ignore (tbtn_se#connect#clicked ~callback:se#toplevel#show);
      ignore (tbtn_me#connect#clicked ~callback:me#toplevel#show);
(*      ignore (tbtn_artists#connect#clicked ~callback:Artists.show);*)

      (* Server entry and button *)
      ignore (btn_connect_server#connect#clicked ~callback:(fun () -> self#load_datasource entry_server#text)) ;

      (* Categories treeview model *)
      let f = GTree.model_filter treeview_categories_store in
        f#set_visible_column CategoryColumn.visibility ;
        treeview_categories#set_model (Some treeview_categories_store#coerce) ;

      (* Categories treeview view *)
      let viewcolumn_icon = GTree.view_column ~title:"Icon" ~renderer:(GTree.cell_renderer_pixbuf [], [("stock-id", CategoryColumn.icon)]) ()
      and viewcolumn_name = GTree.view_column ~title:"Name" ~renderer:(GTree.cell_renderer_text [], [("text", CategoryColumn.name)]) () in
        ignore (treeview_categories#append_column viewcolumn_icon) ;
        ignore (treeview_categories#append_column viewcolumn_name) ;

      (* Categories treeview callbacks *)
      ignore (treeview_categories#connect#row_activated ~callback:self#load_category) ;

      (* Audio elements treeview model *)
      let f = GTree.model_filter treeview_ae_store in
        f#set_visible_column AudioElementColumn.visibility ;
        treeview_audio_elements#set_model (Some treeview_ae_store#coerce) ;

      (* Audio elements treeview view *)
      let viewcolumn_icon = GTree.view_column ~title:"" ~renderer:(GTree.cell_renderer_pixbuf [], [("stock-id", AudioElementColumn.icon)]) ()
      and viewcolumn_duration = GTree.view_column ~title:"Duration" ~renderer:(GTree.cell_renderer_text [], [("text", AudioElementColumn.duration)]) ()
      and viewcolumn_artist = GTree.view_column ~title:"Artist" ~renderer:(GTree.cell_renderer_text [], [("text", AudioElementColumn.artist)]) ()
      and viewcolumn_title = GTree.view_column ~title:"Title" ~renderer:(GTree.cell_renderer_text [], [("text", AudioElementColumn.title)]) () in
        ignore (treeview_audio_elements#append_column viewcolumn_icon) ;
        ignore (treeview_audio_elements#append_column viewcolumn_title) ;
        ignore (treeview_audio_elements#append_column viewcolumn_artist) ;
        ignore (treeview_audio_elements#append_column viewcolumn_duration) ;

      (* Audio elements treeview callbacks *)
      ignore (treeview_audio_elements#connect#row_activated ~callback:self#load_audio_element) ;

    (* Allow to add categories *)
    method add_category ~name ?(location="") ?(icon="") ?(under=None) () =
      Printf.printf "Adding category '%s' in treeview\n" name ;
      flush stdout ;
      (* Add in the treeview model *)
      let row = 
        match under with
          | Some parent -> (treeview_categories_store#append ~parent ())
          | None -> (treeview_categories_store#append ())
      in
      let s column = treeview_categories_store#set ~row ~column in
        s CategoryColumn.name name ;
        s CategoryColumn.location location ;
        s CategoryColumn.icon icon ;
        (match under with
          | Some p -> s CategoryColumn.etype "element"
          | None -> s CategoryColumn.etype "category") ;
        row

      (* Allow to add audio elements *)
    method add_audio_element ~title ~artist ~category ~duration ~location ~info ~icon () =
      Printf.printf "Adding audio element '%s' in treeview\n" (Printf.sprintf "%s -- %s" title artist) ;
      flush stdout ;
      (* Add in the treeview model *)
      let row = treeview_ae_store#append () in
      let s column = treeview_ae_store#set ~row ~column in
        s AudioElementColumn.title title ;
        s AudioElementColumn.artist artist ;
        s AudioElementColumn.duration (Tools.seconds_to_minsec duration) ;
        s AudioElementColumn.location location ;
        s AudioElementColumn.icon icon ;
        s AudioElementColumn.category category ;
        s AudioElementColumn.info info ;

    (* Load the contents of a category *)
    method load_category p c =
      Printf.printf "A category row has been double-clicked\n" ;
      (* Get category *)
      let t = treeview_categories_store in
      let row = t#get_iter p in
        let n = t#get ~row ~column:CategoryColumn.name
        and l = t#get ~row ~column:CategoryColumn.location
        and etype = t#get ~row ~column:CategoryColumn.etype in
          if (etype = "element") then
            (
              Printf.printf "Category '%s' has been selected... We will load data from %s\n" n l ;
              flush stdout ;
              (* Get data *)
              let r = Request.create ~audio:false l in
                (* Get the datasource *)
                match r with
                  | Some r ->
                      ignore (Request.resolve r 10.) ;
                      let f = Request.get_filename r in
                        (match f with
                          | Some f ->
                              let _,xspf = Soap.parse_soap_document f in
                              let xspf = Soap.xspf_playlist_of_soap_body xspf in
                                (* Clear the treeview *)
                                treeview_ae_store#clear () ;
                                (* Now put the data in the treeview *)
                                List.iter (fun t ->
                                  self#add_audio_element ~title:(t#title) ~artist:(t#creator) ~category:n ~duration:((float_of_int t#duration) /. 1000.) ~location:(t#location) ~info:(t#info) ~icon:"gtk-cdrom" ()) xspf#tracks
                          | None -> raise No_datasource) ;
                      ignore (Request.destroy r)
                  | None -> assert false
            )
          else
            Printf.printf "Element '%s' has been selected... We will ignore this\n" n ;
            flush stdout

    (* Load an audio element *)
    method load_audio_element p c =
      Printf.printf "An audio element row has been double-clicked\n" ;
      (* Get audio element *)
      let t = treeview_ae_store in
      let i = t#get_iter p in
        let t = t#get ~row:i ~column:AudioElementColumn.title
        and l = t#get ~row:i ~column:AudioElementColumn.location
        and d = t#get ~row:i ~column:AudioElementColumn.duration
        and o = t#get ~row:i ~column:AudioElementColumn.info in
          (if (o <> "") then
            (
              Printf.printf "Element '%s' has been selected... We will load data from %s\n" t o ;
              flush stdout ;
              (* Get data *)
              (*open_source (Printf.sprintf "single('%s')" l)*)
              let r = Request.create ~audio:false o in
                (* Get the datasource *)
                match r with
                  | Some r ->
                      ignore (Request.resolve r 10.) ;
                      let f = Request.get_filename r in
                        (match f with
                          | Some f ->
                              (* Get the RCS Song data *)
                              let _,rcs = Soap.parse_soap_document f in
                              let rcs = Soap.rcs_song_of_soap_body rcs in
                                List.iter (fun m ->
                                  let d = (match m#description with
                                    | "fade-in" -> "Fade in"
                                    | "fade-out" -> "Fade out"
                                    | "start-next" -> "Start next"
                                    | _ -> assert false) in
                                    se#add_marker ~mtype:(Some d) m#time)
                                  (List.nth rcs#media 0)#timepoint ;
                                ignore (Request.destroy r) ;
                                (* Now get the audio *)
                                let progress = progress_dialog ~parent:toplevel ~title:"Loading sound file" "Loading..." in
                                let th = Thread.create (fun () -> try ignore (progress#run ()) with Failure "dialog destroyed" -> Thread.exit ()) () in
                                Printf.printf "Now loading audio for '%s' from %s\n" t l ;
                                flush stdout ;
                                let s = Request.create ~audio:true l in
                                  (* Get the datasource *)
                                  (match s with
                                    | Some s ->
                                        ignore (Request.resolve s 100.) ;
                                        progress#destroy () ;
                                        let f = Request.get_filename s in
                                          (match f with
                                            | Some f ->
                                                se#label_title#set_label rcs#title ;
                                                se#label_artist#set_label (List.fold_right (fun a b -> a#name ^ " + " ^ b) rcs#artist "") ;
                                                se#label_category#set_label rcs#category ;
                                                se#entry_duration#set_text d ;
                                                me#entry_title#set_text rcs#title ;
                                                se#open_file f ;
                                            | None -> error_dialog ~parent:toplevel "Could not download sound file." )
                                    | None -> assert false)
                          | None -> error_dialog ~parent:toplevel "Could not get the audio element metadata.")
(*                      ignore (Request.destroy r) ;*)
                  | None -> assert false
            )
          else
            Printf.printf "Element '%s' has been selected... We will ignore this\n" t ) ;
          flush stdout

    method load_datasource d =
      let r = Request.create ~audio:false d in
        (* Get the datasource *)
        match r with
          | Some r ->
              ignore (Request.resolve r 10.) ;
              let f = Request.get_filename r in
                (match f with
                  | Some f ->
                      let _,xspf = Soap.parse_soap_document f in
                      let xspf = Soap.xspf_playlist_of_soap_body xspf in
                        (* Clear the treeview *)
                        treeview_categories_store#clear () ;
                        (* Now put the data in the treeview *)
                        List.iter (fun t ->
                          let c = self#add_category ~name:(t#title) ~location:(t#location) ~icon:"gtk-cdrom" () in
                          let s = Request.create ~audio:false t#location in
                            (* Get the datasource *)
                            match s with
                              | Some s ->
                                  ignore (Request.resolve s 10.) ;
                                  let f = Request.get_filename s in
                                    (match f with
                                      | Some f ->
                                          let _,xspf = Soap.parse_soap_document f in
                                          let xspf = Soap.xspf_playlist_of_soap_body xspf in
                                            List.iter (fun t ->
                                             ignore (self#add_category ~name:(t#title) ~location:(t#location) ~icon:"gtk-cdrom" ~under:(Some c) ())
                                                      ) xspf#tracks
                                      | None -> raise No_datasource) ;
                                  ignore (Request.destroy s) ;
                             | None -> assert false
                         ) xspf#tracks
                  | None -> raise No_datasource) ;
              ignore (Request.destroy r) ;
          | None -> assert false
  end
