
module type Entry = sig
  type t
  val make_post : string -> bool -> string -> string -> t
  val add_reply : string -> string -> t -> t
end

module Comment : Entry = struct

  type t = {
    id: int;
    score: int;
    text: string;
    user: string;
    mutable children: t list;
    parent_id: string;
  }

  let make_post a b c d =
    failwith "Unimplemented"

  let add_reply a b c =
    failwith "Unimplemented"

end

module Post : Entry = struct

  type t = {
      id: int;
      score: int;
      title: string;
      text: string;
      is_url: bool;
      user: string;
      mutable children: t list;
      tag: string;
  }

  let make_post a b c d =
    failwith "Unimplemented"

  let add_reply a b c =
    failwith "Unimplemented"

end