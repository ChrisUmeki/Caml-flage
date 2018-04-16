open Entry
open User
open Tag

type server_state = {
  mutable curr_state : string;
  mutable users : User.t list;
  mutable posts : Post.t list;
  mutable tags : Tag.t list;
}

let init_state = {
  curr_state = "state";
  users = [];
  posts = [];
  tags = [];
}

let get_curr_state t =
  t.curr_state

let update_curr_state t new_state =
  t.curr_state <- new_state

let update_users t (new_user : User.t) =
  if not (List.mem new_user t.users) then
    t.users <- new_user::t.users

let update_posts t (new_post : Post.t) =
  if not (List.mem new_post t.posts) then
    t.posts <- new_post::t.posts

let update_tags t (new_tag : Tag.t) =
  if not (List.mem new_tag t.tags) then
    t.tags <- new_tag::t.tags

let upcamel t e =
  failwith "unimplemented"
