open Ezjsonm

type t

(* [get_id a] is the id of a *)
val get_id : t -> int 

(* [up_camel a] is a with its score incremented *)
val up_camel : t -> unit

(* [down_camel a] is a with its score decremented *)
val down_camel : t -> unit

(* [get_score a] is the score of a *)
val get_score : t -> int 

(* [get_text a] is the text of a *)
val get_text : t -> string 

(* TODO: make this a ref? *)
(* [get_par a] is the id of the parent *)
val get_par : t -> int 

(* [add_reply par reply] adds reply [reply] to the children of parent [par] *)
val add_reply : t -> t -> unit

(* [get_children a] is the list of children of a *)
val get_children : t -> t list

(* [comment_from_val o] is a comment made from Ezjsonm.value object [o] *)
val comment_from_val : Ezjsonm.value -> t

(* [comment_from_new o i] is a new comment made from Ezjsonm.value object [o] recieved from user, and a unique id [i] *)
val comment_from_new : Ezjsonm.value -> int -> t

(* [comment_from_params i s t u c p] is a new comment made from parameters for each field. It is primarily used for testing. *)
val comment_from_params : int -> int -> string -> string -> t list -> int -> t

(* [comment_of_json j] is a list of comments read from a json file [j] *)
val comments_of_json : Ezjsonm.value -> t list

(* [to_json a] is an string and Ezjsonm value association list representing a comment [a] *)
val to_json : t -> (string * Ezjsonm.value) list

