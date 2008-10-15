(**
  * A gtk widget to display waveforms.
  *
  * @author Samuel Mimram
  *)

(** A widget to display waves. *)
class gtk_wave_display :
  GRange.progress_bar option ->
  GRange.range ->
  GMisc.drawing_area ->
  object
    (** Redraw the waveform. *)
    method expose : unit

    (** {3 Audio data} *)

    (** Length of audio data in samples. *)
    method length : int

    (** Number of channels of the audio data. *)
    method channels : int

    (** Number of samples per seconds of the audio data. *)
    method samples_per_second : float

    (** Audio data. *)
    method data : (float, Bigarray.float32_elt, Bigarray.c_layout) Bigarray.Array2.t

    (** Get a sample. *)
    method get : int -> float array

    (** Retreive part of the current audio data. *)
    method get_data : int -> float array array -> int -> int -> int

    (** Fill the buffer with audio data. *)
    method set_data :
      ?freq:float ->
      (float, Bigarray.float32_elt, Bigarray.c_layout) Bigarray.Array2.t ->
      unit

    (** [iter start length f] iters a function [f] over data starting at
      * position [start] to cover [length] samples. *)
    method iter : int -> int -> ?samples:int -> (float array array -> unit) -> unit

    (** Iter a function over the current selection. *)
    method iter_selection : ?samples:int -> (float array array -> unit) -> unit

    (** [iter start length f] maps a function [f] over data starting at
      * position [start] to cover [length] samples. *)
    method map :
      int ->
      int -> ?samples:int -> (float array array -> float array array) -> unit

    (** Map a function over the current selection. *)
    method map_selection :
      ?samples:int -> (float array array -> float array array) -> unit

    (** {3 Cursor, selection and markers} *)

    (** Current position of the cursor in samples. *)
    method cursor : int

    (** Set the position of the cursor. *)
    method set_cursor : int -> unit

    (** Beginning of the current selection in samples. *)
    method selection_start : int

    (** Length of the current selection in samples. *)
    method selection_length : int

    (** Set selection start and length. *)
    method set_selection : int -> int -> unit

    (** Currently set markers. *)
    method markers : (int * GDraw.color) list

    (** [add_marker pos color] adds a marker at position [pos] (in samples) with
      * color [color]. *)
    method add_marker : int -> GDraw.color -> unit

    (** Set all the markers. *)
    method set_markers : (int * GDraw.color) list -> unit

    (** {3 Zoom} *)

    (** Current value of the zoom in pixels per second. *)
    method zoom : float

    (** Value of the zoom to fit the whole waveform in the window. *)
    method get_zoom_fit : float

    (** Value of the zoom to have one pixel per sample. *)
    method get_zoom_one : float

    (** Value of the zoom to fit the current selection. *)
    method get_zoom_selection : float

    (** Set the zoom (in pixels per second). *)
    method set_zoom : float -> unit

    (** Disable nicer but slower zoomed data computation. *)
    method disable_smart_zoom : unit
  end

(** Create a wave display. *)
val wave_display : ?progress:GRange.progress_bar -> GRange.range -> GMisc.drawing_area -> gtk_wave_display
