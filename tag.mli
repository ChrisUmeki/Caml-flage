type t

(* [post tag] takes in a tag and returns a list of posts that are associated
 * with the tag *)
val posts_list: t -> Post.t list

val tag_name: t -> string

val to_json: t -> (string * Ezjsonm.value) list
