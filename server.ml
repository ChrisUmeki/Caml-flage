open Opium.Std
open Server_state
open Post
open Comment
open Tag




(* [front_state st] serves json data for the front page *)
let front_state st sort = get "/state.json" begin fun req ->
  `Json (get_front_posts sort st) |> respond'
end

let front_state_sorted st = get "/sorted/:sort/state.json" begin fun req ->
  match param req "sort" with
  | "hot" -> `Json (get_front_posts Hot st) |> respond'
  | "time" -> `Json (get_front_posts Time st) |> respond'
  | _ -> `Json (get_front_posts Hot st) |> respond'
end

(* [post_state st] serves json data for the post at /post/:id *)
let post_state st = get "/post/:id/poststate.json" begin fun req ->
  let id = param req "id" |> int_of_string in
  `Json (get_comments st id) |> respond'
end

(* [tag_state st] serves json data for the tags at /tag/:tag *)
let tag_state st sort = get "/tag/:tagid/tagstate.json" begin fun req ->
  let tagid = param req "tagid" in
  `Json (get_tag_posts st tagid sort) |> respond'
end

(* [save_state st] saves the data in st as a json and also displays it to the client
  (for debugging/testing purposes) *)
let save_state st = get "/savethestate" begin fun req ->
  let j = json_of_state st in
  let out_file = open_out "savedstate.json" in
  Ezjsonm.to_channel ~minify:false out_file j;
  flush out_file;
  `String (Ezjsonm.to_string ~minify:false j) |> respond'
end

(* [filepath_to_string f] is the contents of the file f in one string
* [require] f is a path for a valid text file
*)
let filepath_to_string f =
  let ic = open_in f in
  let n = in_channel_length ic in
  let s = Bytes.create n in
  really_input ic s 0 n;
  close_in ic;
  Bytes.to_string s

(* [front_serve] serves the front page *)
let front_serve = get "/" begin fun req ->
  let s = filepath_to_string "my-react-app/index.html" in
  `String s |> respond'
end

(* [front_serve_sort] serves the front page with a chosen sort *)
let front_serve_sort = get "/sorted/:sort" begin fun req ->
  let s = filepath_to_string "my-react-app/index.html" in
  `String s |> respond'
end

(* [all_tags] serves a page listing tags *)
let all_tags = get "/tags" begin fun req ->
  let s = filepath_to_string "my-react-app/tags.html" in
  `String s |> respond'
 end

(* [all_tags2] serves a page listing tags *)
let all_tags2 = get "/tags/" begin fun req ->
  let s = filepath_to_string "my-react-app/tags.html" in
  `String s |> respond'
 end

(* [post_serve] serves the post with [id] with its comments. The data itself is requested by the client
 and is served by [post_state st] *)
let post_serve = get "/post/:id" begin fun req ->
  let s = filepath_to_string "my-react-app/comments.html" in
  `String s |> respond'
end
(* [post_serve2] serves the post with [id] with its comments but when an [/] is appended *)
let post_serve2 = get "/post/:id/" begin fun req ->
  let s = filepath_to_string "my-react-app/comments.html" in
  `String s |> respond'
end

(* [tag_serve] serves the posts associated with [tag]. The data itself is requested by the client
 and is served by [post_state st] *)
let tag_serve = get "/tag/:tag" begin fun req ->
  let s = filepath_to_string "my-react-app/tagposts.html" in
  `String s |> respond'
end

(* [tag_serve2] serves the posts associated with [tag] but when an [/] is appended *)
let tag_serve2 = get "/tag/:tag/" begin fun req ->
  let s = filepath_to_string "my-react-app/tagposts.html" in
  `String s |> respond'
end

(* [vote_listen st] updates scores in [st] in response to incoming POST requests *)
let vote_listen st = post "/vote" begin fun req ->
  let j = App.json_of_body_exn req in
  let f = fun x -> new_vote st x |> Lwt.return in
  Lwt.bind j f |> ignore;
  `String "Vote received" |> respond'
end

(* [post_listen st] adds new posts to [st] in response to incoming POST requests *)
let post_listen st = post "/post" begin fun req ->
  let j = App.json_of_body_exn req in
  let f = fun x -> update_posts st (Post.post_from_new (Ezjsonm.value x) (Server_state.get_next_post_id st)) |> Lwt.return in
  Lwt.bind j f |> ignore;
  `String "Post made" |> respond'
end

(* [comment_listen st] adds new posts to [st] in response to incoming POST requests *)
let comment_listen st = post "/comment" begin fun req ->
  let j = App.json_of_body_exn req in
  let newid = Server_state.get_next_comment_id st in
  let f = fun x -> 
            Comment.comment_from_new (Ezjsonm.value x) newid
            |> update_comments st
            |> Lwt.return in
  Lwt.bind j f |> ignore;
  `String "Comment made" |> respond'
end

let not_found = get "/*" begin fun req ->
  `String ("Not found") |> respond'
end

let my_state = state_of_json "savedstate.json"


let () = App.empty
         |> middleware (Middleware.static ~local_path:"./my-react-app/public" ~uri_prefix:"/public")
         |> middleware (Middleware.static ~local_path:"./my-react-app/build" ~uri_prefix:"/build")
         |> front_state my_state (Hot)
         |> front_state_sorted my_state
         |> post_state my_state
         |> tag_state my_state (Hot)
         |> save_state my_state
         |> front_serve
         |> front_serve_sort
         |> post_serve
         |> post_serve2
         |> all_tags
         |> all_tags2
         |> tag_serve
         |> tag_serve2
         |> vote_listen my_state
         |> post_listen my_state
         |> comment_listen my_state
         |> App.run_command
         |> ignore
