open Ezjsonm 

module type Entry = sig
  type t
  val make_post : string -> string option -> string -> string -> t
  val make_comment : string -> string -> t -> t
  val add_reply : t -> t -> unit
  val up_camel : t -> unit
  val down_camel : t -> unit
  val get_score : t -> int
  val get_id : t -> int
  val to_json_f : t -> (string * Ezjsonm.value) list
  val posts_of_json : Ezjsonm.value -> t list
  val post_from_new : Ezjsonm.value -> t
end

module Comment : Entry = struct

  type t = {
    id: int;
    mutable score: int;
    text: string;
    user: string;
    mutable children: t list;
    parent_id: int;
  }

  let get_id a =
    a.id

  let up_camel a =
    a.score <- a.score + 1

  let down_camel a =
    a.score <- a.score - 1

  let get_score a =
    a.score

  let make_post a b c d =
    failwith "Not a post"

  let add_reply par reply =
    par.children <- reply::par.children

  let make_comment txt usr par =
    let reply = {
      id = 0;
      score = 0;
      text = txt;
      user = usr;
      children = [];
      parent_id = get_id par;
    } in
      add_reply par reply;
      reply

  let to_json_f a = 
    failwith "Not used"

  let posts_of_json j =
    failwith "Not used"

  let post_from_new o = 
    failwith "Not yet"

end

module Post : Entry = struct

  type t = {
      id: int;
      mutable score: int;
      title: string;
      text: string;
      has_url: bool;
      url: string option;
      user: string;
      mutable children: t list;
      tag: string;
      timestamp: float;
  }

  let get_id a =
    a.id

  let add_reply par reply =
    par.children <- reply::par.children

  let make_post a b c d =
    failwith "Unimplemented"

  let make_comment txt usr par =
    failwith "Not a comment"

  let add_reply par reply =
    par.children <- reply::par.children

  let up_camel a =
    a.score <- a.score + 1

  let down_camel a =
    a.score <- a.score - 1

  let get_score a =
    a.score

  let post_from_val o =
    {
      id = Ezjsonm.find o ["post_id"] |> Ezjsonm.get_int;
      score = Ezjsonm.find o ["score"] |> Ezjsonm.get_int;
      title = Ezjsonm.find o ["title"] |> Ezjsonm.get_string;
      text = Ezjsonm.find o ["text"] |> Ezjsonm.get_string;
      has_url = false;
      url = None;
      user = "";
      children = [];
      tag = "";
      timestamp = Unix.time ();
  }

(* TODO: Generate unique IDs *)
  let post_from_new o =
    {
      id = 9;
      score = 1;
      title = Ezjsonm.find o ["title"] |> Ezjsonm.get_string;
      text = "";
      has_url = false;
      url = None;
      user = "";
      children = [];
      tag = "";
      timestamp = Ezjsonm.find o ["timestamp"] |> Ezjsonm.get_float;
  }
  
  let posts_of_json j = match j with
  | `A j' -> List.map (fun o -> post_from_val o) j'
  | _ -> raise (Failure "bad json")

  let to_json_f a = 
    [("post_id",Ezjsonm.int a.id);
    ("title", `String a.title); 
    ("text", `String a.text); 
    ("score", `Float (float_of_int a.score));
    ("num_comments", `Float (float_of_int (List.length a.children)));]

end