open Opium.Std
open Server_state

let filepath_to_string f =
  let ic = open_in f in
  let n = in_channel_length ic in
  let s = Bytes.create n in
  really_input ic s 0 n;
  close_in ic;
  Bytes.to_string s

let listen st = get "/:id/:text" begin fun req ->
  update_curr_state st (param req "text");
  `String ( param req "id" )|> respond'
end

let state st = get "/state.json" begin fun req ->
  `Json (get_front_posts st) |> respond'
end

let not_found = get "/*" begin fun req ->
  `String ("Not found") |> respond'
end

let index = get "/" begin fun req ->
  let s = filepath_to_string "my-react-app/index.html" in
  `String s |> respond'
end

let vote st = post "/vote" begin fun req ->
  let j = App.json_of_body_exn req in
  let f = fun x -> new_vote st x |> Lwt.return in
  Lwt.bind j f |> ignore;
  `String "Vote received" |> respond'
end

let new_post st = post "/post" begin fun req ->
  let j = App.json_of_body_exn req in
  let f = fun x -> update_posts st (Entry.Post.post_from_new (Ezjsonm.value x)) |> Lwt.return in
  Lwt.bind j f |> ignore;
  `String "Post made" |> respond'
end

let my_state = state_of_json "ServerState.json"

let () = App.empty
         |> middleware (Middleware.static ~local_path:"./my-react-app/public" ~uri_prefix:"/public")
         |> middleware (Middleware.static ~local_path:"./my-react-app/build" ~uri_prefix:"/build")
         |> listen my_state
         |> state my_state
         |> vote my_state
         |> new_post my_state
         |> index
         |> App.run_command
         |> ignore
