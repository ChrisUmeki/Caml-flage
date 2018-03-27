open Opium.Std

module User = struct

  type t = {
    username : string;
    mutable posts : post list;
    mutable exposed_users : string list;
  }

  let username u = u.username

  let posts u = u.posts

  let exposed_users u = u.exposed_users

  let threshold_score = 100

  let score_calculator = failwith "Unimplemented"

let interaction_score = failwith "Unimplemented"

end
