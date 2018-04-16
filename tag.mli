open Entry

type tag

(* [post tag] takes in a tag and returns a list of posts that are associated
 * with the tag *)
val posts_list: tag -> string list

val tag_name: tag -> string
