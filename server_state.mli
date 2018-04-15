type server_state = {
  mutable curr_state : string;
  mutable users : string list;
  mutable entries : string list;
  mutable tags : string list;
}

val update_curr_state : server_state -> string -> server_state

val update_users : server_state -> string -> server_state

val update_entries : server_state -> string -> server_state

val update_tags : server_state -> string -> server_state
