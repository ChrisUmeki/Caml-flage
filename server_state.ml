open Post
open Comment
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

let new_vote st j = 
  let j' = Ezjsonm.value j in
  let i = Ezjsonm.find j' ["post_id"] |> Ezjsonm.get_int in
  match Ezjsonm.find j' ["direction"] with
  | `String "up" -> List.find (fun x -> Post.get_id x = i) st.posts |> Post.up_camel
  | `String "down" -> List.find (fun x -> Post.get_id x = i) st.posts |> Post.down_camel
  | _ -> ()

let state_of_json filename = 
  let j = Ezjsonm.from_channel (open_in filename) in
    {
    curr_state = "";
    users = [];
    posts = Ezjsonm.find j ["posts"] |> Post.posts_of_json;
    comments = [];
    tags = [];
  }

let json_of_state st = 
  let j = `O [("users", `A []); 
  ("posts", (`A (List.fold_left (fun j p -> (Ezjsonm.value (`O (Post.to_json p)))::j) [] st.posts)));
  ("comments", `A []);
  ("tags", `A [])] in
  j

(* [get_comments st i] extracts from st all the information to display a page for post i
*)
let get_comments st i =
  let p = List.find (fun x -> i = Post.get_id x) st.posts in
  let post = Post.to_json_front p in
  let comment_list =
    (`A (List.fold_left (fun j c -> (Ezjsonm.value (`O (Comment.to_json c))) :: j) [] (Post.get_children p)))
    (* TODO:Post.get_children *)
  in
  `O [("posts", `A ([Ezjsonm.value (`O post)])); ("comment_list", comment_list)]

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
  let f = (fun x -> Post.get_id x = Comment.get_par new_comment) in
  if (List.exists f t.posts) then
    let p = List.find f t.posts in
    Post.add_reply p new_comment
    
let update_tags t (new_tag : Tag.t) =
  if not (List.mem new_tag t.tags) then
    t.tags <- new_tag::t.tags

let upcamel t e =
  failwith "unimplemented"

let get_front_posts s =
  let l = s.posts in
  `O [("posts", (`A (List.fold_left (fun j p -> (Ezjsonm.value (`O (Post.to_json_front p)))::j) [] l)))]

let get_next_post_id s =
  (List.length s.posts) + 1

let get_next_comment_id s =
  (List.length s.comments) + 1



