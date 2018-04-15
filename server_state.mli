type server_state = {
  mutable curr_state : string;
  mutable users : string list;
  mutable entries : string list;
  mutable tags : string list;
}

val get_curr_state : server_state -> string

val update_curr_state : server_state -> string -> unit

val update_users : server_state -> string -> unit

val update_entries : server_state -> string -> unit

val update_tags : server_state -> string -> unit
