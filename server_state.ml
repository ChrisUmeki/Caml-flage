type server_state = {
  mutable curr_state : string;
  mutable users : string list;
  mutable entries : string list;
  mutable tags : string list;
}

let update_curr_state t new_state =
    t.curr_state <- new_state

let update_users t new_user =
  if not (List.mem new_user t.users) then
    t.users <- new_user::t.users

let update_entries t new_entry =
  if not (List.mem new_entry t.entries) then
    t.entries <- new_entry::t.entries

let update_tags t new_tag =
  if not (List.mem new_tag t.tags) then
    t.users <- new_user::t.users
