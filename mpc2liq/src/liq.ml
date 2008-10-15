(* $Id: liq.ml 3284 2007-04-13 14:26:36Z smimram $ *)

exception Liq_error

type t = in_channel * out_channel

let connect host port =
  let host = (Unix.gethostbyname host).Unix.h_addr_list.(0) in
  let addr = Unix.ADDR_INET(host, port) in
    Unix.open_connection addr

let cmd (ic, oc) c =
  output_string oc (c ^ "\n");
  flush oc;
  let ans = ref [] in
  let ret = ref (input_line ic) in
    while !ret <> "END"
    do
      ans := !ret::!ans;
      ret := input_line ic
    done;
    if List.length !ans = 1 then
      (
        let msg = List.hd !ans in
          if String.length msg >= 5 && String.sub msg 0 5 = "ERROR" then
            raise Liq_error
      );
    List.rev !ans

let disconnect (ic, oc) =
  (
    try
      ignore (cmd (ic, oc) "quit");
    with
      | End_of_file -> ()
  );
  Unix.shutdown_connection ic

let int_list_of_string s =
  let re = Str.regexp "[ ]*\\([0-9]+\\)" in
  let ans = ref [] in
  let i = ref 0 in
    while Str.string_match re s !i
    do
      ans := int_of_string (Str.matched_group 1 s)::!ans;
      i := Str.match_end ()
    done;
    List.rev !ans

let queue l q =
  let c = cmd l (q ^ ".queue") in
    int_list_of_string (List.hd c)

let on_air l =
  let c = cmd l "on_air" in
    int_list_of_string (List.hd c)

let alive l =
  let c = cmd l "alive" in
    int_list_of_string (List.hd c)

let resolving l =
  let c = cmd l "resolving" in
    int_list_of_string (List.hd c)

let metadata l rid =
  let c = cmd l ("metadata " ^ (string_of_int rid)) in
  let re = Str.regexp "\\(.*\\)=\"\\(.*\\)\"" in
  let ans = ref [] in
    List.iter
      (fun s ->
         if (Str.string_match re s 0) then
           ans := (Str.matched_group 1 s, Str.matched_group 2 s)::!ans
      )
      c;
    List.rev !ans

let metadatas l chan =
  let c = cmd l (chan ^ ".metadatas") in
  let re_n = Str.regexp "--- \\([0-9]+\\) ---" in
  let re_m = Str.regexp "\\(.*\\)=\"\\(.*\\)\"" in
  let first = ref true in
  let ans = ref [] in
  let cur = ref [] in
    List.iter
      (fun s ->
         if (Str.string_match re_n s 0) then
           (if !first then first := false else (ans := !cur::!ans; cur := []))
         else if (Str.string_match re_m s 0) then
           cur := (Str.matched_group 1 s, Str.matched_group 2 s)::!cur
      )
      c;
    !cur::!ans

let skip l chan =
  ignore (cmd l (chan ^ ".skip"))

let uptime l =
  List.hd (cmd l "uptime")

let version l =
  List.hd (cmd l "version")

let start l n =
  ignore (cmd l (n ^ ".start"))

let stop l n =
  ignore (cmd l (n ^ ".stop"))

let push l queue uri =
  ignore (cmd l (queue ^ ".push " ^ uri))

let set_var l n v =
  ignore (cmd l ("var.set " ^ n ^ " = " ^ v))

let get_var l n =
  let c = cmd l ("var.get " ^ n) in
    List.hd c
