
module type Entry = sig

  type t

  (* [make_post text url tag id] takes in text, an option for a potential url,
   * a tag category, and the username making the Post, and returns a Post.
   * raises: exception if called from a non-Post module
  *)
  val make_post : string -> string option -> string -> string -> t

  (* [add_reply text user parent] takes in text, the username making the
   * Comment, and the Post which is being replied to.
   * effects: the parent Post's mutable field to store replies will have another
   * value
  *)
  val add_reply : string -> string -> t -> t

  (* [up_camel entry] is entry with its score incremented *)
  val up_camel : t -> t

  (* [down_camel entry] is entry with its score decremented *)
  val down_camel : t -> t

  (* [get_score entry] is the score of entry *)
  val get_score : t -> int

end

module Comment : Entry

module Post : Entry


