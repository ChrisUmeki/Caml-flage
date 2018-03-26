open Opium.Std


module type User = sig

  type t = {
    username : string;
    mutable posts : post list;
    mutable exposed_users : string list;
  }

  val score_threshold: int

  val score_calculator: string -> string -> int

  val interaction_score : ((string*string),int) Hashtbl.t

end

