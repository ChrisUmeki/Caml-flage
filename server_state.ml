open Post
open Comment
open User
open Tag

type t = {
  mutable users : User.t list;
  mutable posts : Post.t list;
  mutable tags : Tag.t list;
  numcomments : int ref;
}

let empty_state = {
  users = [];
  posts = [];
  tags = [];
  numcomments = ref 0;
}

(* [new_vote st j] updates the state by incrementing or decrementing a Post score
    as specified in j *)
let new_vote st j = 
  let j' = Ezjsonm.value j in
  let i = Ezjsonm.find j' ["post_id"] |> Ezjsonm.get_int in
  match Ezjsonm.find j' ["direction"] with
  | `String "up" -> List.find (fun x -> Post.get_id x = i) st.posts |> Post.up_camel
  | `String "down" -> List.find (fun x -> Post.get_id x = i) st.posts |> Post.down_camel
  | _ -> ()

(* TODO: Fill empty tags with post refs *)
let build_tags j = 
  let lst = Ezjsonm.get_list (fun s -> match s with `String s' -> s' | _ -> "") j in
  List.map (fun s -> Tag.empty s) lst

let fill_tags st =
  let findtag mypost = List.find (fun x -> Post.get_tag mypost = Tag.tag_name x) st.tags in
  let f mypost = Tag.add_post (findtag mypost) mypost; mypost in
  List.map f st.posts |> ignore; ()


(* [state_of_json filename] loads a state from a local json with filename *)
let state_of_json filename = 
  let j = Ezjsonm.from_channel (open_in filename) in
  let st =
  {
    users = [];
    posts = Ezjsonm.find j ["posts"] |> Post.posts_of_json;
    tags = Ezjsonm.find j ["tags"] |> build_tags;
    numcomments = Ezjsonm.find j ["numcomments"] |> Ezjsonm.get_int |> ref;
  } in
  fill_tags st;
  st

(* [json_of_state st] writes the current state to a json *)
let json_of_state st = 
  let j = `O [
  ("users", `A []); 
  ("posts", (`A (List.fold_left (fun j p -> (Ezjsonm.value (`O (Post.to_json p)))::j) [] st.posts)));
  ("tags", `A (List.map (fun tag -> `String (tag_name tag)) st.tags));
  ("numcomments", Ezjsonm.int !(st.numcomments))] in
  j

(* [get_comments st i] extracts from st all the information to display a page for post i
*)
let get_comments st i =
  let p = List.find (fun x -> i = Post.get_id x) st.posts in
  let post = Post.to_json_front p in
  let f j c = (Ezjsonm.value (`O (Comment.to_json c))) :: j in
  let comment_list = (`A (List.fold_left f [] (Post.get_children p))) in
  `O [
      ("posts", `A ([Ezjsonm.value (`O post)]));
      ("comment_list", comment_list)
     ]

let update_users t (new_user : User.t) =
  if not (List.mem new_user t.users) then
    t.users <- new_user::t.users

(* [update_posts st p] adds post p to state st *)
let update_posts st (p : Post.t) =
  if not (List.mem p st.posts) then
    st.posts <- p::st.posts
    
(* [update_comments st c] adds comment c to state st *)
let update_comments st (c : Comment.t) =
  let f = (fun x -> Post.get_id x = Comment.get_par c) in
  if (List.exists f st.posts) then
    let p = List.find f st.posts in
    incr st.numcomments;
    Post.add_reply p c
    
let update_tags t (new_tag : Tag.t) =
  if not (List.mem new_tag t.tags) then
    t.tags <- new_tag::t.tags

let sort_posts lst =
  let f a b = Post.get_hot_score a - Post.get_hot_score b in
  List.sort f lst

let get_front_posts s =
  let l = sort_posts s.posts in
  let f j p = (Ezjsonm.value (`O (Post.to_json_front p)))::j in
  `O [
    ("posts", (`A (List.fold_left f [] l)));
    ("tags", `A (List.map (fun tag -> `String (tag_name tag)) s.tags))
    ]

(* TODO: show only posts with tag id *)
let get_tag_posts s id =
  let mytag = List.find (fun x -> id = Tag.tag_name x) s.tags in
  let l = Tag.posts_list mytag |> sort_posts in
  let f j p = (Ezjsonm.value (`O (Post.to_json_front p)))::j in
  `O [
    ("posts", (`A (List.fold_left f [] l)))
  ]

let get_next_post_id s =
  (List.length s.posts) + 1

let get_next_comment_id s =
  !(s.numcomments) + 1



