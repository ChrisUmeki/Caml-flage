
module type Entry = sig
  type t
  val make_post : string -> string option -> string -> string -> t
  val add_reply : string -> string -> t -> t
  val up_camel : t -> t
  val down_camel : t -> t
  val get_score : t -> int
end

module Comment : Entry = struct

  type t = {
    id: int;
    mutable score: int;
    text: string;
    user: string;
    mutable children: t list;
    parent_id: string;
  }

  let make_post a b c d =
    failwith "Unimplemented"

  let add_reply a b c =
    failwith "Unimplemented"

  let up_camel a =
    failwith "Unimplemented"

  let down_camel a =
    failwith "Unimplemented"

  let get_score a =
    failwith "Unimplemented"

end

module Post : Entry = struct

  type t = {
      id: int;
      mutable score: int;
      title: string;
      text: string;
      has_url: bool;
      url: string option;
      user: string;
      mutable children: t list;
      tag: string;
  }

  let make_post a b c d =
    failwith "Unimplemented"

  let add_reply a b c =
    failwith "Unimplemented"

  let up_camel a =
    failwith "Unimplemented"

  let down_camel a =
    failwith "Unimplemented"

  let get_score a =
    failwith "Unimplemented"

end