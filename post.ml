open Ezjsonm
open Comment

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

let up_camel a = 
  a.score <- a.score + 1

let down_camel a = 
  a.score <- a.score - 1

let get_score a =  
  a.score

let get_title a =
  a.title

let get_text a =
  a.text

let get_children a = 
  a.children

let get_tag a = 
  a.tag

let get_timestamp a = 
  a.timestamp
  
let get_hot_score a = 
  let t = a.timestamp -. 1516892400. in 
    let y = if a.score > 0 then 1 
            else if a.score = 0 then 0 
            else -1 in 
      let x = abs a.score in
        let z = if x > 1 then x else 1 in
          int_of_float (log10 (float_of_int z)) + (y*(int_of_float t)/45000)

let post_from_val o =
  {
    id = Ezjsonm.find o ["post_id"] |> Ezjsonm.get_int;
    score = Ezjsonm.find o ["score"] |> Ezjsonm.get_int;
    title = Ezjsonm.find o ["title"] |> Ezjsonm.get_string;
    text = Ezjsonm.find o ["text"] |> Ezjsonm.get_string;
    has_url = false;
    url = None;
    user = "";
    children = Ezjsonm.find o ["children"] |> comments_of_json;
    tag = Ezjsonm.find o ["tag"] |> Ezjsonm.get_string;
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
    tag = Ezjsonm.find o ["tag"] |> Ezjsonm.get_string;
    timestamp = Unix.time ();
}

let post_from_params i s ti te h url usr chld tag ts =
  {
    id = i;
    score = s;
    title = ti;
    text = te;
    has_url =h;
    url = url;
    user = usr;
    children = chld;
    tag = tag;
    timestamp = ts;
}

let posts_of_json j = match j with
| `A j' -> List.map (fun o -> post_from_val o) j'
| _ -> raise (Failure "bad json")

(* [to_json_front a] extracts only the data that is needed to display a post
* on the front page to a json *)
let to_json_front a = 
  [("post_id", Ezjsonm.int a.id);
  ("title", `String a.title); 
  ("text", `String a.text);
  ("score", `Float (float_of_int a.score));
  ("num_comments", `Float (float_of_int (List.length a.children)));
  ("tag", `String a.tag)]

(* [helper_c c] is a helper function used in to_json to allow for easy conversion from type comment to Ezjsonm.value, 
  * so that a list of Ezjsonm value objects representing the children of a post can be saved to JSON. *)
let helper_c c = Ezjsonm.value (`O (Comment.to_json c))

(* [to_json a] extracts all the data of a post to json *)
let to_json a = 
  [("post_id", Ezjsonm.int a.id);
  ("score", `Float (float_of_int a.score));
  ("title", `String a.title); 
  ("text", `String a.text); 
  ("has_url", `Bool a.has_url); 
  ("url", match a.url with | None -> `Null | Some x -> `String x); 
  ("user", `String a.user); 
  ("children", `A (List.map helper_c a.children)); 
  ("tag", `String a.tag); 
  ("timestamp", `Float a.timestamp);]

