


type medium = Text | Url | Image

(*TODO: Decide how to represent the relationship between post and comment*)
type comment = unit

type post = {
  score: int;
  text: string;
  content: medium;
  tag: string;
  user: string;
  mutable children: comment list;
}


val make_post : string -> medium -> string -> string -> post

val add_reply : post -> post
