open Opium.Std

type state = {
    mutable s : string; 
}

let listen st = get "/:id/:text" begin fun req ->
    st.s <- (param req "text"); 
    `String ( param req "id" )|> respond'
end

let front st = get "/" begin fun req ->
    `String ("Front page! Our state is: " ^ st.s) |> respond'
end

let not_found = get "/*" begin fun req ->
    `String ("Not found") |> respond'
end

let my_state : state = {s = "old state"}

let () = App.empty
         |> listen my_state
         |> front my_state
         |> not_found 
         |> App.run_command
         |> ignore
