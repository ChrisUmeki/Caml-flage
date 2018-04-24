open Opium.Std
open Server_state

let listen st = get "/:id/:text" begin fun req ->
    update_curr_state st (param req "text");
    `String ( param req "id" )|> respond'
end

let front st = get "/state" begin fun req ->
    `String ("State page! Our state is: " ^
             (get_curr_state st)) |> respond'
end

let not_found = get "/*" begin fun req ->
    `String ("Not found") |> respond'
end

let index = get "/" begin fun req ->
  let location = Cohttp.Header.init_with "Location" "/public/index.html" in
  respond' ~headers:location ~code:`Found (`String "")
end

let vote st = post "/" begin fun req ->
  update_curr_state st "upvoted";
  `String ("blah") |> respond'
end

let my_state = init_state

let () = App.empty
         |> middleware (Middleware.static ~local_path:"./my-react-app/public" ~uri_prefix:"/public")
         |> middleware (Middleware.static ~local_path:"./my-react-app/build" ~uri_prefix:"/build")
         |> listen my_state
         |> front my_state
         |> vote my_state
         |> index
         |> App.run_command
         |> ignore
