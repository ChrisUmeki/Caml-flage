open Post
open Comment
open User
open Tag

type t

(* [empty_state] creates a new server state *)
val empty_state : t

(* [state_of_json filename] loads a state from a local json with filename *)
val state_of_json : string -> t

(* [json_of_state st] writes the current state to a json *)
val json_of_state : t -> Ezjsonm.t

(* [get_comments st i] extracts from st all the information to display a page for post i *)
val get_comments : t -> int -> Ezjsonm.t

(* [new_vote st j] updates the state by incrementing or decrementing a Post score
 *  as specified in j *)
val new_vote : t -> Ezjsonm.t -> unit

(* [update_users t u] adds a new user [u] to the server state [st] *)
val update_users : t -> User.t -> unit

(* [update_posts st p] adds a new post [p] to the server state [st] *)
val update_posts : t -> Post.t -> unit

(* [update_comments st c] adds a new comment [c] to the server state [st] *)
val update_comments : t -> Comment.t -> unit

(* [update_tags st tag] adds a new tag [tag] to the server state [st] *)
val update_tags : t -> Tag.t -> unit

(* [get_front_posts st] converts posts from the server state [st] to JSON for the front page of the website *)
val get_front_posts : t -> Ezjsonm.t

(* [get_tag_posts st id] converts posts from the server state [st] to JSON for a tag page on the website *)
val get_tag_posts : t -> string -> Ezjsonm.t

(* [get_next_post_id st] generates a new unique id for a post based on the total number of posts in the server state [st] *)
val get_next_post_id : t -> int

(* [get_next_comment_id] generates a new unique id for a comment based on the total number of comments in the entire server state [st] *)
val get_next_comment_id : t -> int