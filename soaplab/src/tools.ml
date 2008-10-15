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

(* Convert seconds to min:sec *)
let seconds_to_minsec d =
  let m = d /. 60. in
  let s = d -. (60. *. floor m) in
    Printf.sprintf "%d:%06.03f" (int_of_float m) s

let ignore_thread f =
  ignore (Thread.create f ())

let get_some = function
  | Some x -> x
  | None -> assert false

let temp_files = ref []

let unlink_temp_files () =
  List.iter (fun f -> Unix.unlink f) !temp_files

let alloc_buffer chans length =
  let filename = Filename.temp_file "soaplab" ".tmp.wave" in
  let fd =
    Unix.openfile filename [Unix.O_RDWR; Unix.O_CREAT; Unix.O_TRUNC] 0o644
  in
    temp_files := filename :: !temp_files;
    Bigarray.Array2.map_file fd Bigarray.float32 Bigarray.c_layout true length chans

let buffer_blit b1 o1 b2 o2 len =
  let chans = Array2.dim2 b1 in
    for i = 0 to len - 1 do
      for c = 0 to chans - 1 do
        let v = Array2.get b1 (o1 + i) c in
          Array2.set b2 (o2 + i) c v
      done;
    done
