type t

(* [posts_list tag] is a list of posts that are associated with a tag [tag] *)
val posts_list: t -> Post.t list

(* [tag_name tag] is the name of a tag [tag] *)
val tag_name: t -> string

(* [to_json a] is a string and Ezjsonm value association list representing a tag [a] *)
val to_json: t -> (string * Ezjsonm.value) list

(* [empty s] is an empty tag with the name of a inputted string [s] *)
val empty: string -> t

(* [tag_from_params s plist] is a new tag made from parameters for each field. It is primarily used for testing. *)
val tag_from_params: string -> Post.t ref list -> t

(* [add_post tag p] adds a post [p] to the posts of a tag [tag] *)
val add_post: t -> Post.t -> unit
