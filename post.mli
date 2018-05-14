type t 

(* [get_id a] is the id of a *)
val get_id : t -> int

(* [add_reply par reply] adds reply [reply] to the children of parent [par] *)
val add_reply : t -> Comment.t -> unit

(* [up_camel a] is a with its score incremented *)
val up_camel : t -> unit

(* [down_camel a] is a with its score decremented *)
val down_camel : t -> unit

(* [get_score a] is the score of a *)
val get_score : t -> int

(* [get_title a] is the title of a *)
val get_title : t -> string

(* [get_text a] is the text of a *)
val get_text : t -> string

(* [get_children a] is the list of children of a *)
val get_children : t -> Comment.t list

(* [get_tag a] is the tag of a *)
val get_tag : t -> string

(* [get_hot_score a] is the "hot score" of a *)
val get_hot_score : t -> int

(* [post_from_val o] is a post made from Ezjsonm.value object [o] *)
val post_from_val : Ezjsonm.value -> t

(* [post_from_new o i] is a new post made from Ezjsonm.value object [o] recieved from user, and a unique id [i] *)
val post_from_new : Ezjsonm.value -> int -> t

(* [post_from_params i s ti te h url usr chld tag ts] is a new post made from parameters for each field. It is primarily used for testing. *)
val post_from_params : int -> int -> string -> string -> bool -> string option -> string -> Comment.t list -> string -> float -> t

(* [posts_of_json j] is a list of posts read from a json file [j] *)
val posts_of_json : Ezjsonm.value -> t list

(* [to_json_front a] extracts only the data that is needed to display a post
* on the front page to a json *)
val to_json_front : t -> (string * Ezjsonm.value) list

(* [to_json a] extracts all the data of a post to json *)
val to_json : t -> (string * Ezjsonm.value) list


