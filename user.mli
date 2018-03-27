open Opium.Std


module type User = sig

(* The type of User values *)
  type t

(* [username] is a function that takes in a user u and returns its username. *)
  val username : t -> string

(* [posts] is a function that takes in a user u and returns a list of its posts. *)
  val posts : t -> post list

(* [exposed_users] is a function that takes in a user u and returns a list of
   usernames that the user reached the threshold interaction score with, that are
   not anonymous to the user. *)
  val exposed_users : t -> string list

(* [score_threshold] is the target score that two users have to reach in order
for their accounts to be exposed to one another. *)
  val score_threshold : int

(* [score_calculator] is a function that takes in two usernames and calculates the
interaction score that the two respective users have reached thus far. *)
  val score_calculator : string -> string -> int

(* [interaction_score] is a hashtable that stores tuples of usernames as keys and their
  interaction score as values. *)
  val interaction_score : ((string*string),int) Hashtbl.t

  (* [get_score (u1,u2)] is the interaction score that users u1 and u2 have reached. *)
  val get_score: (string*string) -> int

end
