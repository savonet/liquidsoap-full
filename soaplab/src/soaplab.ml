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

(* let clipboard = GData.clipboard Gdk.Atom.clipboard *)

let usage = Sys.argv.(0) ^ " [--editor <file>]"
let file = ref None
let editor = ref false
let () =
  Arg.parse
    [
      "--editor", Arg.Set editor, "Use as an audio editor.";
    ]
    (fun s -> file := Some s) usage

let () = Portaudio.init ()

let se = new SoundEditor.sound_editor ~file:(Filename.dirname Sys.argv.(0) ^ "/IAS/ias.glade")

let () =
  (* Editor mode *)
  if !editor then
    (
      (* Hide stuff *)
      se#menu_markers#misc#hide ();
      se#table_tags#misc#hide ();
      se#vbox_markers#misc#hide ();

      (* Connect quit *)
      ignore (se#toplevel#connect#destroy ~callback:on_quit) ;
      ignore (se#menu_quit#connect#activate ~callback:on_quit) ;

      (* File *)
      match !file with
        | Some f ->
            if Sys.file_exists f then se#open_file f else
              se#open_source f
        | None -> ()
    )
  (* Normal mode *)
  else
    (
      se#menu_quit#misc#hide ();
      se#separator_menu_quit#misc#hide ();
      let me = new MetadataEditor.metadata_editor ~file:(Filename.dirname Sys.argv.(0) ^ "/IAS/ias.glade") in
      let dp = new DatabasePalette.db_palette ~file:(Filename.dirname Sys.argv.(0) ^ "/IAS/ias.glade") se me in
        ignore (dp#toplevel#connect#destroy ~callback:on_quit);
        ignore (dp#menu_quit#connect#activate ~callback:on_quit)
    )

let () =
  (* Start the event loop. *)
  GtkThread.main ()
