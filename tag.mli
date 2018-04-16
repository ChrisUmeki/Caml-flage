type t

(* [post tag] takes in a tag and returns a list of posts that are associated
 * with the tag *)
val posts: string -> post list
