open Opium.Std


module type User = sig

  type t

  val username : t -> string

  val posts : t -> post list

  val exposed_users : t -> string list

  val score_threshold : int

  val score_calculator : string -> string -> int

  val interaction_score : ((string*string),int) Hashtbl.t

  val get_score: (string*string) -> int

end
