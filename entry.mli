
module type Entry = sig

  type t

  (* [make_post text cont tag user] creates posts
  *)
  val make_post : string -> bool -> string -> string -> t

  (* [add_reply text user par]
  *)
  val add_reply : string -> string -> t -> t

end

module Comment : Entry

module Post : Entry


