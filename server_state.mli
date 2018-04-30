open Entry
open User
open Tag

type t

val init_state : t

val state_of_json : string -> t

val get_curr_state : t -> string

val update_curr_state : t -> string -> unit

val new_vote : t -> Ezjsonm.t -> unit

val update_users : t -> User.t -> unit

val update_posts : t -> Post.t -> unit

val update_tags : t -> Tag.t -> unit

val upcamel : t -> Post.t -> unit

val get_front_posts : t -> Ezjsonm.t

val get_next_id : t -> int