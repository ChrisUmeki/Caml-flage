open Opium.Std
open Server_state

let listen st = get "/:id/:text" begin fun req ->
    update_curr_state st (param req "text");
    `String ( param req "id" )|> respond'
end

let front st = get "/" begin fun req ->
    `String ("Front page! Our state is: " ^
             (get_curr_state st)) |> respond'
end

let not_found = get "/*" begin fun req ->
    `String ("Not found") |> respond'
end

let my_state = init_state

let () = App.empty
         |> listen my_state
         |> front my_state
         |> not_found
         |> App.run_command
         |> ignore
