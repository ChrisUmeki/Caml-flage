module type Entry = sig
  type t
  val make_post : string -> string option -> string -> string -> t
  val make_comment : string -> string -> t -> t
  val add_reply : t -> t -> unit
  val up_camel : t -> unit
  val down_camel : t -> unit
  val get_score : t -> int
  val get_id : t -> int
end

module Comment : Entry = struct

  type t = {
    id: int;
    mutable score: int;
    text: string;
    user: string;
    mutable children: t list;
    parent_id: int;
  }
  let get_id a =
    a.id

  let up_camel a =
    a.score <- a.score + 1

  let down_camel a =
    a.score <- a.score - 1

  let get_score a =
    a.score

  let make_post a b c d =
    failwith "Not a post"

  let add_reply par reply =
    par.children <- reply::par.children

  let make_comment txt usr par =
    let reply = {
      id = 0;
      score = 0;
      text = txt;
      user = usr;
      children = [];
      parent_id = get_id par;
    } in
      add_reply par reply;
      reply



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

  let get_id a =
    a.id

  let add_reply par reply =
    par.children <- reply::par.children

  let make_post a b c d =
    failwith "Unimplemented"

  let make_comment txt usr par =
    failwith "Not a comment"

  let add_reply par reply =
    par.children <- reply::par.children

  let up_camel a =
    a.score <- a.score + 1

  let down_camel a =
    a.score <- a.score - 1

  let get_score a =
    a.score

end