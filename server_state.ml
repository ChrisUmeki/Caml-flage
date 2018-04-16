type server_state = {
  mutable curr_state : string;
  mutable users : string list;
  mutable entries : string list;
  mutable tags : string list;
}

let init_state = {
  curr_state = "state";
  users = [];
  entries = [];
  tags = [];
}

let get_curr_state t =
  t.curr_state

let update_curr_state t new_state =
  t.curr_state <- new_state

let update_users t (new_user:string) =
  if not (List.mem new_user t.users) then
    t.users <- new_user::t.users

let update_entries t (new_entry:string) =
  if not (List.mem new_entry t.entries) then
    t.entries <- new_entry::t.entries

let update_tags t (new_tag:string) =
  if not (List.mem new_tag t.tags) then
    t.tags <- new_tag::t.tags

let upcamel t e =
  failwith "unimplemented"
