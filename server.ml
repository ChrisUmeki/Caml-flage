open Opium.Std
open Server_state

let listen st = get "/:id/:text" begin fun req ->
    Server_state.update_curr_state st (param req "text");
    `String ( param req "id" )|> respond'
end

let front st = get "/" begin fun req ->
    `String ("Front page! Our state is: " ^
             (Server_state.get_curr_state st)) |> respond'
end

let not_found = get "/*" begin fun req ->
    `String ("Not found") |> respond'
end

let my_state : server_state = {
  curr_state = "state";
  users = [];
  entries = [];
  tags = [];
}

let () = App.empty
         |> listen my_state
         |> front my_state
         |> not_found
         |> App.run_command
         |> ignore
