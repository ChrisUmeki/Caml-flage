open Opium.Std
open User
open Tags
open Post
open Comment

(* [users] returns a list of all users. *)
val users : user list

(* [posts] returns a list of all posts. *)
val posts : post list

(* [comments] returns a list of all comments. *)
val comments : comment list

(* [tags] returns a list of all tags. *)
val tags : tag list
