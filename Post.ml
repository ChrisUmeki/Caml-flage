open Ezjsonm
open Comment

module Post = struct

  type t = {
      id: int;
      mutable score: int;
      title: string;
      text: string;
      has_url: bool;
      url: string option;
      user: string;
      mutable children: Comment.t list;
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
      children = Ezjsonm.find o ["children"] |> Comment.posts_of_json;
      tag = "";
      timestamp = Ezjsonm.find o ["timestamp"] |> Ezjsonm.get_float;
  }

let post_from_new o i =
  {
    id = i;
    score = 1;
    title = Ezjsonm.find o ["title"] |> Ezjsonm.get_string;
    text = Ezjsonm.find o ["text"] |> Ezjsonm.get_string;
    has_url = false;
    url = None;
    user = "";
    children = [];
    tag = "";
    timestamp = Unix.time ();
}

let posts_of_json j = match j with
| `A j' -> List.map (fun o -> post_from_val o) j'
| _ -> raise (Failure "bad json")

(* [to_json_front a] extracts only the data that is needed to display a post
* on the front page to a json
*)
let to_json_front a = 
  [("post_id", Ezjsonm.int a.id);
  ("title", `String a.title); 
  ("text", `String a.text);
  ("score", `Float (float_of_int a.score));
  ("num_comments", `Float (float_of_int (List.length a.children)));]

(* [to_json a] extracts all the data of a post to json
*)
let to_json a = 
  [("post_id", Ezjsonm.int a.id);
  ("score", `Float (float_of_int a.score));
  ("title", `String a.title); 
  ("text", `String a.text); 
  ("has_url", `Bool a.has_url); 
  ("url", match a.url with | None -> `Null | Some x -> `String x); 
  ("user", `String a.user); 
  ("children", `A []); (* IMPLEMENT LATER *)
  ("tag", `String a.tag); 
  ("timestamp", `Float a.timestamp);]

let get_hot_score a = 
  let t = a.timestamp -. 1134028003. in 
    let y = if a.score > 0 then 1 
            else if a.score = 0 then 0 
            else -1 in 
      let x = abs a.score in
        let z = if x > 1 then x else 1 in
          int_of_float (log10 (float_of_int z)) + (y*(int_of_float t)/45000)


  let get_children a = a.children
  
end