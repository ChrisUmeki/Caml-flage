open Post

module User : sig

(* The type of User values *)
  type t

(* [username] is a function that takes in a user u and returns its username. *)
  val username : t -> string

(* [posts] is a function that takes in a user u and returns a list of its posts. *)
  val posts : t -> Post.t list

(* [exposed_users] is a function that takes in a user u and returns a list of
   usernames that the user reached the threshold interaction score with, that are
   not anonymous to the user. *)
  val exposed_users : t -> string list

(* [score_threshold] is the target score that two users have to reach in order
for their accounts to be exposed to one another. *)
  val score_threshold : int


end