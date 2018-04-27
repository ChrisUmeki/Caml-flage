open Entry
open User
open Tag

type t = {
  mutable curr_state : string;
  mutable users : User.t list;
  mutable posts : Post.t list;
  mutable comments : Comment.t list;
  mutable tags : Tag.t list;
}

let init_state = {
  curr_state = "state";
  users = [];
  posts = [];
  comments = [];
  tags = [];
}

let state_of_json filename = 
  let j = Ezjsonm.from_channel (open_in filename) in
    {
    curr_state = "";
    users = [];
    posts = Ezjsonm.find j ["posts"] |> Post.posts_of_json;
    comments = [];
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
    
let update_comments t (new_comment : Comment.t) =
  if not (List.mem new_comment t.comments) then
    t.comments <- new_comment::t.comments
    
let update_tags t (new_tag : Tag.t) =
  if not (List.mem new_tag t.tags) then
    t.tags <- new_tag::t.tags

let upcamel t e =
  failwith "unimplemented"

let get_front_posts s =
  let l = s.posts in
  Ezjsonm.value (`A (List.fold_left (fun j p -> (Ezjsonm.value (`O (Post.to_json_f p)))::j) [] l))
