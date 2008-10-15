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

exception No_selection

(* Markers treeview *)
module MarkerColumn =
struct
  let list = new GTree.column_list
  let visibility = list#add Gobject.Data.boolean
  (* let icon : GdkPixbuf.pixbuf GTree.column = list#add Gobject.Data.gobject*)
  let icon = list#add Gobject.Data.string
  let position = list#add Gobject.Data.string
  let mtype = list#add Gobject.Data.string
end

let get_some x =
  match x with
    | Some x -> x
    | None -> assert false

class sound_editor ?(file="IAS/ias.glade") =
object (self)
  inherit Ias.sound_editor ~file () as super

  (* Play *)
  val mutable playing = false
  val mutable play_thread = None
  (* Zoom *)
  val zoom_step = 1.2
  val mutable zoom_thread = None

  (* Markers treeview *)
  val treeview_markers_store = GTree.list_store MarkerColumn.list

  (* Progress bar stuff *)
  val mutable wd = None

  initializer
    ignore (self#toplevel#connect#destroy ~callback:self#on_destroy);

    (* Connect them *)
    ignore (tbtn_play#connect#clicked ~callback:self#on_play);
    ignore (tbtn_stop#connect#clicked ~callback:self#on_stop);
    ignore (tbtn_loop#connect#clicked ~callback:(fun () -> self#on_play ~loop:true ()));
    ignore (tbtn_import#connect#clicked ~callback:self#on_open);
    ignore (tbtn_export#connect#clicked ~callback:self#on_save);
    ignore (tbtn_zoom_fit#connect#clicked ~callback:(fun () -> hsb#adjustment#set_value 0.; self#set_zoom (get_some wd)#get_zoom_fit));
    ignore (tbtn_zoom_sel#connect#clicked ~callback:(fun () -> self#set_zoom (get_some wd)#get_zoom_selection; hsb#adjustment#set_value (float_of_int (get_some wd)#selection_start)));
    ignore (tbtn_zoom_100#connect#clicked ~callback:(fun () -> self#set_zoom (get_some wd)#get_zoom_one));
    ignore (tbtn_zoom_in#connect#clicked  ~callback:(fun () -> self#set_zoom ((get_some wd)#zoom *. zoom_step)));
    ignore (tbtn_zoom_out#connect#clicked ~callback:(fun () -> self#set_zoom ((get_some wd)#zoom /. zoom_step)));

    (* Markers treeview model *)
    (
      let f = GTree.model_filter treeview_markers_store in
        f#set_visible_column MarkerColumn.visibility ;
        self#treeview_markers#set_model (Some treeview_markers_store#coerce) ;
    );

    (* Markers treeview view *)
    (
      let viewcolumn_icon = GTree.view_column ~title:"Icon" ~renderer:(GTree.cell_renderer_pixbuf [], [("stock-id", MarkerColumn.icon)]) ()
      and viewcolumn_marker = GTree.view_column ~title:"Marker" ~renderer:(GTree.cell_renderer_text [], [("text", MarkerColumn.position)]) ()
      and viewcolumn_mtype = GTree.view_column ~title:"Type" ~renderer:(GTree.cell_renderer_text [], [("text", MarkerColumn.mtype)]) ()
      in
        ignore (self#treeview_markers#append_column viewcolumn_icon) ;
        ignore (self#treeview_markers#append_column viewcolumn_marker) ;
        ignore (self#treeview_markers#append_column viewcolumn_mtype) ;
    );

    (* File menu *)
    ignore (self#menu_open#connect#activate ~callback:self#on_open);
    ignore (self#menu_save#connect#activate ~callback:self#on_save);
    ignore (self#menu_from_source#connect#activate ~callback:(fun () -> let source = input_dialog ~parent:toplevel ~title:"Import from source" "Liquidsoap one-liner:" in self#open_source source));
    (* Edit menu *)
    ignore (self#menu_copy#connect#activate ~callback:self#on_copy);
    ignore (self#menu_paste#connect#activate ~callback:self#on_paste);
    ignore (self#menu_cut#connect#activate ~callback:(self#on_cut ~delete:false));
    ignore (self#menu_delete#connect#activate ~callback:(self#on_cut ~delete:true));
    (* Tools menu *)
    ignore (self#menu_normalize#connect#activate ~callback:self#on_normalize);
    ignore (self#menu_cut_blanks#connect#activate ~callback:self#on_cut_blanks);
    ignore (self#menu_rms#connect#activate ~callback:self#on_rms);
    (* Markers menu *)
    ignore (self#menu_add_m_fi#connect#activate ~callback:(fun () -> self#add_marker ~mtype:(Some "Fade in")  (float_of_int (get_some wd)#cursor /. (get_some wd)#samples_per_second))) ;
    ignore (self#menu_add_m_fo#connect#activate ~callback:(fun () -> self#add_marker ~mtype:(Some "Fade out") (float_of_int (get_some wd)#cursor /. (get_some wd)#samples_per_second))) ;
    ignore (self#menu_add_m_sn#connect#activate ~callback:(fun () -> self#add_marker ~mtype:(Some "Start next") (float_of_int (get_some wd)#cursor /. (get_some wd)#samples_per_second))) ;
    (* View menu *)
    ignore (menu_zoom_fit#connect#activate ~callback:(fun () -> hsb#adjustment#set_value 0.; self#set_zoom (get_some wd)#get_zoom_fit));
    ignore (menu_zoom_selection#connect#activate ~callback:(fun () -> self#set_zoom (get_some wd)#get_zoom_selection; hsb#adjustment#set_value (float_of_int (get_some wd)#selection_start)));
    ignore (self#menu_zoom_normal#connect#activate ~callback:(fun () -> self#set_zoom (get_some wd)#get_zoom_one));
    ignore (self#menu_zoom_in#connect#activate ~callback:(fun () -> self#set_zoom ((get_some wd)#zoom *. zoom_step)));
    ignore (self#menu_zoom_out#connect#activate ~callback:(fun () -> self#set_zoom ((get_some wd)#zoom /. zoom_step)));
    (* Help menu *)
    ignore (self#menu_about#connect#activate ~callback:on_about);

    (* Buttons *)
    ignore (self#btn_add_marker#connect#clicked ~callback:(fun () -> self#add_marker (float_of_int (get_some wd)#cursor /. (get_some wd)#samples_per_second))) ;
    ignore (self#btn_del_marker#connect#clicked ~callback:self#remove_marker) ;

    (* Zoom *)
    zsb#adjustment#set_bounds ~lower:0.001 ~upper:3000. ~step_incr:10. ();
    ignore (zsb#adjustment#connect#value_changed ~callback:self#on_zoom);

    (* GtkWaveDisplay *)
    ignore (wave_display#event#connect#button_press ~callback:self#on_da_button_press);
    ignore (wave_display#event#connect#button_release ~callback:self#on_da_button_release);

    (* It's showtime, folks! *)
    toplevel#show ();
    progress#misc#hide ();

    (* Window must already be shown for wave_display to be called. *)
    wd <- Some (GtkWaveDisplay.wave_display ~progress:progress hsb wave_display) ;

    (get_some wd)#disable_smart_zoom;
    zsb#set_update_policy `CONTINUOUS

  (* Allow to add markers *)
  method add_marker ?(mtype = None) position =
    try
      let marker_type =
        (match mtype with
           | Some m -> m
           | _ ->
               if (combobox_marker_type#active < 0) then raise No_selection ;
               let i = combobox_marker_type#active_iter in
               (* Is this the right way? *)
               let column =
                 {
                   GTree.index = 0;
                   GTree.conv = Gobject.Data.string;
                   GTree.creator = 0;
                 }
               in
                 (match i with
                    | Some row -> combobox_marker_type#model#get ~row ~column
                    | _ -> raise No_selection))
      in
        Printf.printf "Adding '%s' marker at: %s\n" marker_type (Tools.seconds_to_minsec position) ;
        flush stdout ;

        (* Add in the treeview model *)
        let icon =
          match marker_type with
            | "Fade in" -> "gtk-goto-first"
            | "Fade out" -> "gtk-goto-last"
            | "Start next" -> "gtk-goto-bottom"
            | _ -> raise No_selection
        in
        let row = treeview_markers_store#append () in
        let s column = treeview_markers_store#set ~row ~column in
          s MarkerColumn.icon icon ;
          s MarkerColumn.position (Tools.seconds_to_minsec position) ;
          s MarkerColumn.mtype marker_type ;

          (* Add on the gtkWaveDisplay *)
          let color =
            match marker_type with
              | "Fade in" -> `RGB (max_int, 0, max_int)
              | "Fade out" -> `RGB (0, 0, max_int)
              | "Start next" -> `RGB (max_int, max_int, 0)
              | _ -> raise No_selection
          in
            (get_some wd)#add_marker (int_of_float (position *. (get_some wd)#samples_per_second)) color
    with
      | No_selection ->
          error_dialog ~parent:toplevel ~title:"Pointer error" (Printf.sprintf "You must select a pointer type before adding a pointer.")

  (* Allow to remove them too... *)
  method remove_marker () =
    let s = treeview_markers#selection#get_selected_rows in
      List.iter
        (fun p ->
           Printf.printf "Removing selected row: %d\n" (GTree.Path.get_indices p).(0) ;
           ignore (treeview_markers_store#remove (treeview_markers_store#get_iter p)) ;
        ) s ;
      flush stdout

  (* Play a sound *)
  method on_play ?(loop=false) () =
    playing <- false;
    while play_thread <> None do
      Thread.yield () (* TODO: find something better *)
    done;
    play_thread <-
    Some (
      Thread.create
        (fun () ->
           try
             let old_cursor = (get_some wd)#cursor in
             let chans = (get_some wd)#channels in
             (* TODO: open the stream once for all *)
             let dev = Portaudio.open_default_stream 0 chans 44100 256 in
             let buflen = 1024 in
             let buf = Array.init chans (fun _ -> Array.make buflen 0.) in
             let len = ref (-1) in
               if loop then
                 (get_some wd)#set_cursor (get_some wd)#selection_start;
               Portaudio.start_stream dev;
               playing <- true;
               while playing && (!len <> 0 || loop) && (not loop || (get_some wd)#selection_length <> 0) do
                 if !len = 0 && loop then
                   (get_some wd)#set_cursor (get_some wd)#selection_start;
                 let ofs = (get_some wd)#cursor in
                 let buflen =
                   if loop then
                     min buflen ((get_some wd)#selection_start + (get_some wd)#selection_length - ofs)
                   else
                     buflen
                 in
                   len := (get_some wd)#get_data ofs buf 0 buflen;
                   (get_some wd)#set_cursor (ofs + !len);
                   entry_position#set_text (Tools.seconds_to_minsec (float_of_int ofs /. (get_some wd)#samples_per_second)) ;
                   Portaudio.write_stream dev buf 0 !len
               done;
               (get_some wd)#set_cursor old_cursor;
               Portaudio.stop_stream dev;
               Portaudio.close_stream dev;
               playing <- false;
               play_thread <- None
           with
             | Portaudio.Error n ->
                 play_thread <- None;
                 error_dialog ~parent:toplevel ~title:"Portaudio error" ((Portaudio.string_of_error n) ^ ".")
        ) ()
    )

  method on_stop () =
    playing <-false

  (* Zoom *)
  method zoom_progress f () =
    (*
     match !zoom_thread with
     | Some t -> Thread.kill t
     | None -> ()
     *)
    zoom_thread <-
    Some
      (
        Thread.create
          (fun () ->
             progress#set_text "Computing zoomed waveform...";
             progress#set_fraction 0.;
             progress#misc#show ();
             f ();
             progress#misc#hide ();
             zoom_thread <- None
          ) ()
      )

  method on_zoom () =
    self#zoom_progress (fun () -> (get_some wd)#set_zoom zsb#adjustment#value) ()

  method set_zoom n =
    zsb#adjustment#set_value n

  method big_chunks ~chunk_size ~channels =
    let total  = ref 0 in
    let maxj   = ref 0 in
    let chunks = ref [] in
    let feed i j v =
      while j >= !total do
        let ba = Tools.alloc_buffer channels chunk_size in
          total := !total + chunk_size ;
          chunks := ba :: !chunks
      done ;
      let rec insert total chunks =
        match chunks with
          | hd::tl ->
              let total = total - chunk_size in
                if j >= total then
                  Bigarray.Array2.set hd (j - total) i v
                else
                  insert total tl
          | [] -> assert false
      in
        maxj := max !maxj j ;
        insert !total !chunks
    in
    let finish () =
      let real_len = 1 + !maxj in
      let ba = Tools.alloc_buffer channels real_len in
        ignore
          (List.fold_left
             (fun (off,len) subarray ->
                let subsub = Bigarray.Array2.sub_left subarray 0 len in
                let suball = Bigarray.Array2.sub_left ba off len in
                  Bigarray.Array2.blit subsub suball ;
                  (off-chunk_size,chunk_size))
             (!total-chunk_size,
              let l = real_len mod chunk_size in
                if l = 0 then chunk_size else l)
             !chunks) ;
        ba
    in
      feed,finish

  method decoder_of_source (s:Source.source) =
    s#get_ready [s] ;
    while not (s#is_ready) do
      Printf.printf "Waiting for src to be ready...\n%!" ;
      Thread.delay 0.1 ;
    done ;
    { Decoder.fill  = (fun ab -> s#get ab ; s#after_output ; s#remaining) ;
      Decoder.close = (fun () -> s#leave s) }

  method open_decoder dec =
    let open_decoder dec =
      progress#set_fraction 0. ;
      progress#set_text "Decoding...";
      progress#misc#show ();
      let frame = Fmt.create_frame () in
      let buf = AFrame.get_float_pcm frame in
      let off = ref 0 in
      let set,finish = self#big_chunks ~chunk_size:(44100*2*30) ~channels:2 in
        try
          Printf.printf "Reading data...\n%!" ;
          while true do
            AFrame.clear frame ;
            let rem = dec.Decoder.fill frame in
            let rem =
              if rem >= 0 then float (Fmt.samples_of_ticks rem) else infinity
            in
              Array.iteri
                (fun c bc ->
                   Array.iteri
                     (fun j bcj ->
                        set c (!off + j) bcj)
                     bc)
                buf ;
              off := !off + Array.length buf.(0) ;
              let off = float !off in
                progress#set_fraction (off /. (off +. rem)) ;
                if AFrame.is_partial frame then failwith "END"
          done
        with Failure "END" ->
          Printf.printf "Track done\n%!" ;
          dec.Decoder.close () ;
          (get_some wd)#set_data (finish ()) ;
          self#set_zoom (get_some wd)#get_zoom_fit
    in
      Thread.create open_decoder dec

  (* Open a Liquidsoap source *)
  method open_source expr =
    Printf.printf "Opening %s...\n" expr ;
    let src =
      let i,o = Unix.pipe () in
      let i = Unix.in_channel_of_descr i in
      let o = Unix.out_channel_of_descr o in
        output_string o expr ;
        close_out o ;
        let lexbuf = Lexing.from_channel i in
        let ast = Lang_parser.scheduler Lang_pp.token lexbuf in
          Lang_values.check ast ;
          let s = Lang_values.eval_toplevel ast in
            close_in i ;
            match s.Lang_values.value with
              | Lang_values.Source s -> s
              | _ -> assert false
    in
      ignore (self#open_decoder (self#decoder_of_source src))

  (* Open a sound file *)
  method open_file f =
    match Decoder.search_valid f with
      | None ->
          error_dialog ~parent:toplevel ~title:"Error" (Printf.sprintf "Could not decode %S!" f)
      | Some d -> ignore (self#open_decoder (d ()))

  (* Open callback *)
  method on_open () =
    let fcd =
      GWindow.file_chooser_dialog
        ~action:`OPEN
        ~title:"Please choose a file"
        ()
    in
      fcd#add_button_stock `CANCEL `CANCEL;
      fcd#add_select_button_stock `OPEN `ACCEPT;
      if fcd#run () = `ACCEPT then
        (
          match fcd#filename with
            | Some f ->
                if Sys.file_exists f then
                  self#open_file f
                else
                  self#open_source f
            | None -> ()
        );
      fcd#destroy ()

  method save_file ofs len f =
    Tools.ignore_thread
      (fun () ->
         progress#set_fraction 0. ;
         progress#set_text "Encoding...";
         progress#misc#show ();
         let fd = Unix.openfile f [Unix.O_WRONLY; Unix.O_CREAT] 0o644 in
         let write s = ignore (Unix.write fd s 0 (String.length s)) in
         let enc = Vorbis.Encoder.create_vbr (get_some wd)#channels (int_of_float (get_some wd)#samples_per_second) 0.2 in
         let os = Ogg.Stream.create () in
         let pos = ref 0 in
           Vorbis.Encoder.headerout enc os [];
           write (Ogg.Stream.flush os);
           (get_some wd)#iter ofs len
             (fun buf ->
                Vorbis.Encoder.encode_buffer_float enc os buf 0 (Array.length buf.(0));
                write (Ogg.Stream.pagesout os);
                pos := !pos + Array.length buf.(0);
                progress#set_fraction (float_of_int !pos /. float_of_int len)
             );
           Vorbis.Encoder.end_of_stream enc os;
           write (Ogg.Stream.flush os);
           Unix.close fd;
           progress#misc#hide ()
      )

  (* Save callback *)
  method on_save () =
    let fcd =
      GWindow.file_chooser_dialog
        ~action:`SAVE
        ~title:"Please choose a file"
        ()
    in
      fcd#add_button_stock `CANCEL `CANCEL;
      fcd#add_select_button_stock `SAVE `ACCEPT;
      if fcd#run () = `ACCEPT then
        (
          match fcd#filename with
            | Some f ->
                self#save_file 0 (get_some wd)#length f
            | None -> ()
        );
      fcd#destroy ()

  (* Handle marker positionning on click *)
  method on_da_button_press be =
    entry_position#set_text (Tools.seconds_to_minsec (float_of_int (get_some wd)#cursor /. (get_some wd)#samples_per_second));
    entry_selection_start#set_text (Tools.seconds_to_minsec (float_of_int (get_some wd)#selection_start /. (get_some wd)#samples_per_second));
    false

  method on_da_button_release be =
    entry_selection_start#set_text (Tools.seconds_to_minsec (float_of_int (get_some wd)#selection_start /. (get_some wd)#samples_per_second));
    entry_selection_end#set_text (Tools.seconds_to_minsec (float_of_int ((get_some wd)#selection_start + (get_some wd)#selection_length) /. (get_some wd)#samples_per_second));
    false

  (* Normalize *)
  method on_normalize () =
    let m = Array.make (get_some wd)#channels 0. in
      (get_some wd)#iter_selection
        (fun buf ->
           for c = 0 to Array.length buf - 1 do
             let bufc = buf.(c) in
               for i = 0 to Array.length bufc - 1 do
                 m.(c) <- max m.(c) (abs_float bufc.(i))
               done;
           done
        );
      let m = Array.fold_left min 0. m in
        (get_some wd)#map_selection
          (fun buf ->
             for c = 0 to Array.length buf - 1 do
               let bufc = buf.(c) in
                 for i = 0 to Array.length bufc - 1 do
                   bufc.(i) <- bufc.(i) /. m
                 done;
             done;
             buf
          )

  (* Compute RMS *)
  method on_rms () =
    let rms = Array.make (get_some wd)#channels 0. in
      (get_some wd)#iter_selection
        (fun buf ->
           for c = 0 to Array.length buf - 1 do
             let bufc = buf.(c) in
               for i = 0 to Array.length bufc - 1 do
                 rms.(c) <- rms.(c) +. bufc.(i) *. bufc.(i)
               done;
           done
        );
      let rms =
        Array.map (fun r -> sqrt (r /. float_of_int (get_some wd)#selection_length)) rms
      in
      let rms =
        Array.map (fun r -> 20. *. log r /. log 10.) rms
      in
      let s =
        let s = ref "" in
          for c = 0 to Array.length rms -  1 do
            s := Printf.sprintf "%schannel %d: %5.02f dB\n" !s c rms.(c)
          done;
          !s
      in
      let dialog =
        GWindow.message_dialog
          ~title:"RMS"
          ~parent:toplevel ~message_type:`INFO ~buttons:GWindow.Buttons.ok
          ~message:s ()
      in
        ignore (dialog#run ());
        dialog#destroy ()

  val mutable clipboard = Tools.alloc_buffer 2 1

  method on_copy () =
    let wd = get_some wd in
      clipboard <- Tools.alloc_buffer wd#channels wd#selection_length;
      Tools.buffer_blit wd#data wd#selection_start clipboard 0 wd#selection_length

  method delete_sound start len =
    let wd = get_some wd in
    let new_data = Tools.alloc_buffer wd#channels (wd#length - len) in
      Tools.buffer_blit wd#data 0 new_data 0 start;
      Tools.buffer_blit
        wd#data (start + len)
        new_data start
        (wd#length - (start + len));
      wd#set_data ~freq:(wd#samples_per_second) new_data;
      wd#expose

  method on_cut ~delete () =
    if not delete then self#on_copy ();
    let wd = get_some wd in
      wd#set_selection wd#selection_start 0;
      self#delete_sound wd#selection_start wd#selection_length

  method on_paste () =
    let wd = get_some wd in
    let clip_len = Bigarray.Array2.dim1 clipboard in
    let new_data = Tools.alloc_buffer wd#channels (wd#length + clip_len) in
      Tools.buffer_blit wd#data 0 new_data 0 wd#cursor;
      Tools.buffer_blit clipboard 0 new_data wd#cursor clip_len;
      Tools.buffer_blit wd#data wd#cursor new_data (wd#cursor + clip_len) (wd#length - wd#cursor);
      wd#set_data ~freq:(wd#samples_per_second) new_data;
      wd#set_selection wd#cursor clip_len;
      wd#expose

  method on_cut_blanks () =
    let wd = get_some wd in
    let is_blank v = abs_float v < 0.01 in
    let is_blank s = Array.fold_left (fun b v -> b && is_blank v) true s in
    let is_blank n = is_blank (wd#get n) in
    let blank_start = ref 0 in
    let blank_end = ref (wd#length - 1) in
      while is_blank !blank_start && !blank_start < wd#length do
        incr blank_start
      done;
      while is_blank !blank_end && !blank_end >= 0 do
        decr blank_end
      done;
      self#delete_sound 0 !blank_start;
      if !blank_end < wd#length - 1 then
        self#delete_sound (!blank_end + 1) (wd#length - (!blank_end + 1))

  method on_destroy () =
    Tools.unlink_temp_files ()
end
