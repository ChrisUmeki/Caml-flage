open Entry

type server_state

val init_state : server_state

val get_curr_state : server_state -> string

val update_curr_state : server_state -> string -> unit

val update_users : server_state -> string -> unit

val update_entries : server_state -> string -> unit

val update_tags : server_state -> string -> unit

val upcamel : server_state -> Post.t -> unit