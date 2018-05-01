
module type Entry = sig

  type t

  (* [make_post text url tag id] takes in text, an option for a potential url,
   * a tag category, and the username making the Post, and returns a Post.
   * raises: exception if called from a non-Post module
  *)
  val make_post : string -> string option -> string -> string -> t

  (* [make_comment text user parent] takes in text, the username making the
   * Comment, and the Post which is being replied to.
   * effects: the parent Post's mutable field to store replies will have another
   * value
  *)
  val make_comment : string -> string -> t -> t

  val add_reply : t -> t -> unit

  (* [up_camel entry] is entry with its score incremented *)
  val up_camel : t -> unit

  (* [down_camel entry] is entry with its score decremented *)
  val down_camel : t -> unit

  (* [get_score entry] is the score of entry *)
  val get_score : t -> int

  val get_id : t -> int

  val posts_of_json : Ezjsonm.value -> t list

  val post_from_new : Ezjsonm.value -> int -> t

  val to_json_front : t -> (string * Ezjsonm.value) list

  val to_json : t -> (string * Ezjsonm.value) list

  val get_children : t -> t list

end
