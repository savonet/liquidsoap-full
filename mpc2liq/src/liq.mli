(* $Id* *)

exception Liq_error

type t

val connect : string -> int -> t

val disconnect : t -> unit

val on_air : t -> int list

val metadata : t -> int -> (string * string) list

val metadatas : t -> string -> (string * string) list list

val skip : t -> string -> unit

val uptime : t -> string

val push : t -> string -> string -> unit

val queue : t -> string -> int list

val alive : t -> int list

val resolving : t -> int list

val version : t -> string

val set_var : t -> string -> string -> unit

val get_var : t -> string -> string

val start : t -> string -> unit

val stop : t -> string -> unit
