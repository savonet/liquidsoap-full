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

open Bigarray

class gtk_wave_display (progress:GRange.progress_bar option) (hsb:GRange.range) (da:GMisc.drawing_area) =
object (self)
  initializer
    hsb#adjustment#set_bounds ~lower:0. ~upper:100. ~step_incr:1. ();
    ignore (da#event#connect#configure ~callback:self#configure_cb);
    ignore (da#event#connect#expose ~callback:self#expose_cb);
    ignore (da#event#connect#button_press ~callback:self#button_press_cb);
    ignore (da#event#connect#button_release ~callback:self#button_release_cb);
    ignore (hsb#adjustment#connect#value_changed ~callback:self#scroll_cb);

  val mutable smart_zoom = true
  val no_zoom_freq = 50.

  method disable_smart_zoom = smart_zoom <- false

  val drawable = new GDraw.drawable da#misc#window

  val mutable wavepix = GDraw.pixmap ~width:100 ~height:100 ()

  val mutable data = Array2.create float32 c_layout 1 1
  val mutable data_zoomed_min = Array2.create float32 c_layout 1 1
  val mutable data_zoomed_max = Array2.create float32 c_layout 1 1
  val mutable data_zoomed_block_len = 1
  val data_zoomed_mutex = Mutex.create ()
  val mutable computing_zoom = false
  val mutable samples_per_second = 44100.
  val mutable pixels_per_second = 100.
  val mutable cursor_pos = 0
  val mutable selection_start = 0
  val mutable selection_len = 0
  val mutable offset = 0
  val mutable markers = []

  val mutable need_redraw = true

  method samples_per_second = samples_per_second
  method channels = Array2.dim2 data
  method length = Array2.dim1 data

  method selection_start = selection_start
  method selection_length = selection_len
  method set_selection start len =
    selection_start <- start;
    selection_len <- len;
    need_redraw <- true

  method set_data ?(freq=samples_per_second) buf =
    data <- buf;
    samples_per_second <- freq;
    need_redraw <- true

  method data = data

  method get n =
    Array.init self#channels (fun c -> Array2.get data n c)

  method get_data ofs buf bofs len =
    let len = min len (self#length - ofs) in
      for i = 0 to len - 1 do
        for c = 0 to self#channels - 1 do
          buf.(c).(i+bofs) <- Array2.get data (i+ofs) c
        done
      done;
      len

  method markers = markers

  method add_marker pos color =
    markers <- (pos, color)::markers;
    self#expose

  method set_markers l =
    markers <- l;
    self#expose

  method set_cursor n =
    cursor_pos <- max 0 (min n self#length);
    self#expose

  method private button_press_cb be =
    if GdkEvent.Button.button be = 1 then
      (
        self#set_cursor ((int_of_float (GdkEvent.Button.x be)) * data_zoomed_block_len + offset);
        selection_start <- cursor_pos;
        self#expose
      );
    false

  method private button_release_cb be =
    if GdkEvent.Button.button be = 1 then
      (
        let x = (int_of_float (GdkEvent.Button.x be)) * data_zoomed_block_len + offset in
        let x = min x self#length in
        let x = max x 0 in
          selection_len <- x - cursor_pos;
          if selection_len < 0 then
            (
              selection_start <- selection_start + selection_len;
              selection_len <- -selection_len
            );
          need_redraw <- true;
          self#expose;
      );
    false

  method cursor = cursor_pos

  method private draw_data =
    let width, height = drawable#size in
    let ichans = self#channels in
    let chans = float_of_int ichans in

      (* TODO: use grow_pixmap *)
      wavepix <- GDraw.pixmap ~width ~height ();
      wavepix#set_background `BLACK;

      (* Blackout the background. *)
      wavepix#set_foreground `BLACK;
      wavepix#rectangle ~x:0 ~y:0 ~width ~height ~filled:true ();

      (* Draw the selection. *)
      (
        let selection_start = selection_start / data_zoomed_block_len in
        let selection_len = selection_len / data_zoomed_block_len in
        let offset = offset / data_zoomed_block_len in
          if selection_start < offset + width && selection_start + selection_len > offset then
            (
              let x = max 0 (selection_start-offset) in
              let width = min (width - x - 1) (selection_len - (x-(selection_start-offset))) in
                wavepix#set_foreground (`RGB (max_int/20, max_int/20, max_int/20));
                wavepix#rectangle ~x ~y:0 ~width ~height ~filled:true ();
            )
      );

      (* Draw the waveform. *)
      if pixels_per_second > samples_per_second /. no_zoom_freq then
        (
          let height = float_of_int height in
          let offset = offset / data_zoomed_block_len in
          let width = min width (self#length / data_zoomed_block_len - offset) in
            wavepix#set_foreground (`RGB (0, max_int / 5, 0));
            for i = 0 to width - 2 do
              for c = 0 to ichans - 1 do
                let v = Array2.get data ((i+offset)*data_zoomed_block_len) c in
                let w = Array2.get data ((i+offset+1)*data_zoomed_block_len) c in
                  wavepix#line
                    ~x:i
                    ~y:(int_of_float (height *. (v +. 1.) /. 2. /. chans +. height *. (float_of_int c) /. chans))
                    ~x:i
                    ~y:(int_of_float (height *. (w +. 1.) /. 2. /. chans +. height *. (float_of_int c) /. chans))
              done
            done
        )
      else if not computing_zoom && smart_zoom then
        (
          let height = float_of_int height in
          let offset = offset / data_zoomed_block_len in
          let width = min width (Array2.dim1 data_zoomed_min - offset) in
            wavepix#set_foreground (`RGB (0, max_int / 5, 0));
            for i = 0 to width - 1 do
              for c = 0 to ichans - 1 do
                wavepix#line
                  ~x:i
                  ~y:(int_of_float (height *. (Array2.get data_zoomed_min (i+offset) c +. 1.) /. 2. /. chans +. height *. (float_of_int c) /. chans))
                  ~x:i
                  ~y:(int_of_float (height *. (Array2.get data_zoomed_max (i+offset) c +. 1.) /. 2. /. chans +. height *. (float_of_int c) /. chans))
              done
            done
        )
      else
        (
          let height = float_of_int height in
          let offset = offset / data_zoomed_block_len in
          let width = min width (self#length / data_zoomed_block_len - offset) in
            wavepix#set_foreground (`RGB (0, max_int / 5, 0));
            for i = 0 to width - 1 do
              for c = 0 to ichans - 1 do
                let v = abs_float (Array2.get data ((i+offset)*data_zoomed_block_len) c) in
                  wavepix#line
                    ~x:i
                    ~y:(int_of_float (height *. (0. -. v +. 1.) /. 2. /. chans +. height *. (float_of_int c) /. chans))
                    ~x:i
                    ~y:(int_of_float (height *. (v +. 1.) /. 2. /. chans +. height *. (float_of_int c) /. chans))
              done
            done
        );
      wavepix#set_foreground (`RGB (max_int/5, max_int/5, max_int/5));
      for c = 1 to ichans - 1 do
        wavepix#line
          ~x:0
          ~y:(height * c / ichans)
          ~x:(width-1)
          ~y:(height * c / ichans)
      done

  method private scroll_cb () =
    offset <- int_of_float hsb#adjustment#value;
    need_redraw <- true;
    self#expose

  method set_zoom pps =
    (* TODO: handle 0 < zoom < 1 *)
    if pps <> pixels_per_second && pps > 1. then
      (
        pixels_per_second <- pps;
        self#compute_zoom;
        self#expose
      )

  method zoom = pixels_per_second

  method get_zoom_fit =
    float_of_int (fst (drawable#size)) /.
    float_of_int self#length *.
    samples_per_second

  method get_zoom_selection =
    float_of_int (fst (drawable#size)) /.
    float_of_int self#selection_length *.
    samples_per_second

  method get_zoom_one = samples_per_second

  method private draw_marker pos color =
    let width, height = drawable#size in
    let pos = pos / data_zoomed_block_len in
    let offset = offset / data_zoomed_block_len in
      if pos > offset && pos < offset + width then
        (
          drawable#set_foreground color;
          drawable#line ~x:(pos - offset) ~y:0 ~x:(pos - offset) ~y:height
        )

  method private compute_zoom =
    data_zoomed_block_len <- int_of_float (samples_per_second /. pixels_per_second);
    if smart_zoom && pixels_per_second < samples_per_second /. no_zoom_freq then
      (
        Mutex.lock data_zoomed_mutex;
        Printf.printf "Compute zoom...%!";
        computing_zoom <- true;
        let chans = self#channels in
        let buflen = self#length in
          data_zoomed_min <-
          Array2.create
            float32
            c_layout
            (buflen / data_zoomed_block_len)
            chans;
          data_zoomed_max <-
          Array2.create
            float32
            c_layout
            (buflen / data_zoomed_block_len)
            chans;
          for i = 0 to Array2.dim1 data_zoomed_min - 1 do
            if progress <> None then
              (Tools.get_some progress)#set_fraction (float_of_int i /. float_of_int (Array2.dim1 data_zoomed_min));
            for c = 0 to self#channels - 1 do
              let max = ref 0. in
              let min = ref 0. in
                for j = 0 to data_zoomed_block_len - 1 do
                  if j mod 128 = 0 then Thread.yield ();
                  let v = Array2.get data (i * data_zoomed_block_len + j) c in
                    if v < !min then
                      min := v
                    else if v > !max then
                      max := v;
                    Array2.set data_zoomed_min i c !min;
                    Array2.set data_zoomed_max i c !max
                done
            done
          done;
          computing_zoom <- false;
          Printf.printf "ok\n%!";
          Mutex.unlock data_zoomed_mutex
      );
    hsb#adjustment#set_bounds ~lower:0. ~upper:(float_of_int self#length) ~step_incr:10. ();
    need_redraw <- true;

  (** Redraw the contents. *)
  method private expose_cb (ev:GdkEvent.Expose.t) = self#expose; true
  method expose =
    let width, height = drawable#size in
      if need_redraw then
        (
          self#draw_data;
          need_redraw <- false
        );
      drawable#put_pixmap ~x:0 ~y:0 ~xsrc:0 ~ysrc:0 ~width ~height wavepix#pixmap;

      (* Draw the cursor and markers. *)
      self#draw_marker cursor_pos (`RGB (max_int / 5, 0, 0));
      List.iter (fun (pos, color) -> self#draw_marker pos color) markers;

  (* The window was resized. *)
  method private configure_cb (ev:GdkEvent.Configure.t) =
    need_redraw <- true;
    true

  method iter ofs len ?(samples=1024) (f:float array array -> unit) =
    let buf = Array.init self#channels (fun _ -> Array.make samples 0.) in
    let pos = ref ofs in
      while !pos < ofs + len do
        let len = min samples (ofs + len - !pos) in
        let n = self#get_data !pos buf 0 len in
        let buf =
          if n = samples then
            buf
          else
            Array.map (fun bufc -> Array.sub bufc 0 n) buf
        in
          f buf;
          pos := !pos + n
      done;

  method iter_selection = self#iter self#selection_start self#selection_length

  method map ofs len ?(samples=1024) f =
    let buf = Array.init self#channels (fun _ -> Array.make samples 0.) in
    let pos = ref ofs in
      while !pos < ofs + len do
        let len = min samples (ofs + len - !pos) in
        let n = self#get_data !pos buf 0 len in
        let buf =
          if n = samples then
            buf
          else
            Array.map (fun bufc -> Array.sub bufc 0 n) buf
        in
        let buf = f buf in
          for c = 0 to self#channels - 1 do
            let bufc = buf.(c) in
              for i = 0 to Array.length bufc - 1 do
                Array2.set data (!pos+i) c bufc.(i)
              done
          done;
          pos := !pos + n
      done;
      need_redraw <- true;
      self#expose

  method map_selection = self#map self#selection_start self#selection_length
end

let wave_display ?progress hsb da =
  new gtk_wave_display progress hsb da
