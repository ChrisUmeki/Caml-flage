


type medium = Text | Url | Image

type comment = {
  id: int;
  score: int;
  text: string;
  content: medium;
  user: string;
  mutable children: comment list;
  parent: string;
}

type post = {
  id: int;
  score: int;
  text: string;
  content: medium;
  tag: string;
  user: string;
  mutable children: comment list;
}

type entry = Post of post | Comment of comment

(* [generate ()] is a stream that always returns a unique int
*)
val generate : unit -> int

(* [make_post text cont tag usr] creates posts
*)
val make_post : string -> medium -> string -> string -> post

(* [add_reply scorepar ]
*)
(* val add_reply :  *)
