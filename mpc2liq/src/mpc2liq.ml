let liq = Liq.connect "127.0.0.1" 1234

exception End_of_connection

type state = Play | Stop | Pause

let state = ref Stop

let string_of_state = function
  | Play -> "play"
  | Stop -> "stop"
  | Pause -> "pause"

let write_metadata write rid =
  let md = Liq.metadata liq rid in
    write (Printf.sprintf "file: %s\n" (List.assoc "initial_uri" md));
      List.iter
      (fun (l,v) ->
         match l with
           | "album"
           | "artist"
           | "genre"
           | "title"
             -> write (String.capitalize l ^ ": " ^ v ^ "\n")
           | _ -> ()
      )
      md;
      write "Pos: 0\n";
      write (Printf.sprintf "Id: %d\n" rid)

let rec commands =
  [
    "add", 1, (fun _ a -> Liq.push liq "queue" ("\"" ^ a.(0) ^ "\""); None);
    "close", 0, (fun _ _ -> raise End_of_connection);
    "commands", 0,
    (fun write _ ->
       write ((String.concat "\n" (List.map (fun (c,_,_) -> "command: "^c) commands))^"\n");
       None
    );
    "currentsong", 0,
    (fun write a ->
       write_metadata write (List.hd (Liq.on_air liq));
       None
    );
    "lsinfo", 0, (fun _ _ -> None);
    "next", 0, (fun _ _ -> Liq.skip liq "output"; None);
    "notcommands", 0, (fun write _ -> write "command: notcommands\n"; None);
    "pause", 1,
    (fun _ a ->
       state :=
       (if a.(0) = "1" then
          (
            Liq.stop liq "output";
            Pause
          )
        else
          (
            Liq.start liq "output";
            Play
          )
       );
       None
    );
    "ping", 0, (fun _ _ -> None);
    "play", 0, (fun _ _ -> Liq.start liq "output"; state := Play; None);
    "playid", 0, (fun _ _ -> Liq.start liq "output"; state := Play; None);
    "playlistid", 1, (fun write a -> write_metadata write (int_of_string a.(0)); None);
    "playlistinfo", 0, (fun write a -> write_metadata write (int_of_string a.(0)); None);
    "setvol", 1,
    (fun _ a ->
       try
         Liq.set_var liq "volume" (string_of_float (float_of_string a.(0) /. 100.));
         None
       with
         | Failure("float_of_string") -> Some (2, "argument is not an integer: \"" ^ a.(0) ^ "\"")
    );
    "stats", 0,
    (fun write _ ->
       None
    );
    "status", 0,
    (fun write _ ->
       let volume = float_of_string (Liq.get_var liq "volume") in
       let volume = int_of_float (volume *. 100.) in
         write (Printf.sprintf "volume: %d\n" volume);
         write (Printf.sprintf "state: %s\n" (string_of_state !state));
         (try write (Printf.sprintf "song: %d\n" (List.hd (Liq.on_air liq))) with _ -> ());
         (try write (Printf.sprintf "songid: %d\n" (List.hd (Liq.on_air liq))) with _ -> ());
         write "playlist: 0\n";
         (try write (Printf.sprintf "playlistlength: %d\n" (List.length (Liq.queue liq "queue"))) with _ -> ());
         None
    );
    "stop", 0, (fun _ _ -> Liq.stop liq "output"; state := Stop; None);
  ]

exception Invalid_command

let re_cmd = Str.regexp "\\([a-z]+\\)"
let re_arg = Str.regexp "[ \t]*\\([^ \r\n]+\\)"
let re_arg_quoted = Str.regexp "[ \t]*\"\\([^\"\r\n]+\\)\""

let parse_command s =
  let args = ref [] in
    if Str.string_match re_cmd s 0 then
      let cmd = Str.matched_group 1 s in
      let pos = ref (String.length (Str.matched_string s)) in
        while Str.string_match re_arg_quoted s !pos || Str.string_match re_arg s !pos do
          pos := !pos + String.length (Str.matched_string s);
          args := (Str.matched_group 1 s) :: !args
        done;
        cmd, Array.of_list (List.rev !args)
    else
      "", [||]

let handle sock =
  let write s =
    Printf.printf "ANS: %s%!" s;
    ignore (Unix.write sock s 0 (String.length s))
  in
  let read () =
    let buflen = 1024 in
    let buf = String.create buflen in
    let n = Unix.read sock buf 0 buflen in
      String.sub buf 0 n
  in
    try
      write "OK MPD 0.13.0\n";
      while true do
        let cmd = read () in
          Printf.printf "CMD: %s%!" cmd;
          let cmd, args = parse_command cmd in
            if not (List.exists
                      (fun (name,nargs,f) ->
                         if cmd = name then
                           (
                             (
                               match f write args with
                                 | None -> write "OK\n"
                                 | Some (n,s) -> write (Printf.sprintf "ACK [%d@1] {%s} %s\n" n name s)
                             );
                             true
                           )
                         else false
                      ) commands)
            then
              write (Printf.sprintf "ACK [5@1] {%s} unknown command\n" cmd)
      done
    with
      | End_of_connection -> Unix.close sock
      | e -> Printf.printf "EXC: %s\n%!" (Printexc.to_string e); raise e

let () =
  let bind_addr = Unix.ADDR_INET (Unix.inet_addr_loopback, 6601) in
  let sock = Unix.socket Unix.PF_INET Unix.SOCK_STREAM 0 in
    Unix.setsockopt sock Unix.SO_REUSEADDR true;
    Unix.bind sock bind_addr;
    Unix.listen sock 10;
    while true do
      let (s, caller) = Unix.accept sock in
        handle s
    done
