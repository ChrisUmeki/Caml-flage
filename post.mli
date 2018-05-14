type t 

val get_id : t -> int

val add_reply : t -> Comment.t -> unit

val up_camel : t -> unit

val down_camel : t -> unit

val get_score : t -> int

val get_children : t -> Comment.t list

val get_hot_score : t -> int

val post_from_val : Ezjsonm.value -> t

val post_from_new : Ezjsonm.value -> int -> t

val post_from_params : int -> int -> string -> string -> bool -> string option -> string -> Comment.t list -> string -> float -> t

val posts_of_json : Ezjsonm.value -> t list

(* [to_json_front a] extracts only the data that is needed to display a post
* on the front page to a json
*)
val to_json_front : t -> (string * Ezjsonm.value) list

(* [to_json a] extracts all the data of a post to json
*)
val to_json : t -> (string * Ezjsonm.value) list


