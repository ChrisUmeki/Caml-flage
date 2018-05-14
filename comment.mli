open Ezjsonm

type t

(* []
*)
val get_id : t -> int 


(* [up_camel a] is a with its score incremented *)
val up_camel : t -> unit

(* [down_camel a] is a with its score decremented *)
val down_camel : t -> unit

(* [get_score a] is the score of a *)
val get_score : t -> int 

(* TODO: make this a ref? *)
(* [get_par a] is the id of the parent *)
val get_par : t -> int 

val add_reply : t -> t -> unit

val get_children : t -> t list

val comment_from_val : Ezjsonm.value -> t

val comment_from_new : Ezjsonm.value -> int -> t

val comment_from_params : int -> int -> string -> string -> t list -> int -> t

val comments_of_json : Ezjsonm.value -> t list

val to_json : t -> (string * Ezjsonm.value) list

