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

(* Error dialog *)
let error_dialog ~parent ?(title="") msg =
  let dialog =
    GWindow.message_dialog
      ~title
      ~parent ~message_type:`ERROR ~buttons:GWindow.Buttons.ok
      ~message:msg ()
  in
    ignore (dialog#run ());
    dialog#destroy ()

(* Input dialog *)
let input_dialog ~parent ?(title="") prompt =
  let data = ref "" in
  let dialog =
    GWindow.dialog
      ~parent
      ~destroy_with_parent:true
      ~title
      ~modal:true ()
  in
  ignore (GMisc.label ~text:prompt ~packing:dialog#vbox#add ()) ;
  let input = GEdit.entry ~packing:dialog#vbox#add ()
  and btn_cl = GButton.button ~stock:`CANCEL ~packing:dialog#action_area#add ()
  and btn_ok = GButton.button ~stock:`OK ~packing:dialog#action_area#add ()
  in
    ignore (btn_cl#connect#clicked ~callback:(fun () -> dialog#destroy())) ;
    ignore (btn_ok#connect#clicked ~callback:(fun () -> data := input#text ; dialog#destroy())) ;
    (
      try
        ignore (dialog#run ()) ;
      with
        | Failure "dialog destroyed" -> ()
    );
    !data

(* Progress dialog *)
let progress_dialog ~parent ?(title="") message =
  let dialog =
    GWindow.dialog
      ~parent
      ~destroy_with_parent:true
      ~title
      ~modal:true ()
  in
  let progress = GRange.progress_bar ~packing:dialog#vbox#add () in
(*    progress#pulse() ;*)
    dialog

(* About window *)
let on_about () =
  Tools.ignore_thread
    (fun () ->
      let md =
        GWindow.about_dialog
          ~authors:["Samuel Mimram";"Vincent Tabard"]
          ~comments:"IAS"
          ~copyright:"Copyright (C) 2007 the Savonet Team"
          ~license:"
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
"
          ~name:"IAS"
          ~version:"0.0.1"
          ~website:"http://savonet.sf.net/"
          ()
      in
        try
          ignore (md#run ());
          md#destroy ()
        with
          | Not_found ->
              md#destroy ()
    )

(* Quit *)
let on_quit () =
  Portaudio.terminate ();
  GMain.Main.quit ()
