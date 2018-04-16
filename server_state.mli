open Entry
open User
open Tag

type server_state

val init_state : server_state

val get_curr_state : server_state -> string

val update_curr_state : server_state -> string -> unit

val update_users : server_state -> User.t -> unit

val update_posts : server_state -> Post.t -> unit

val update_tags : server_state -> Tag.t -> unit

val upcamel : server_state -> Post.t -> unit
