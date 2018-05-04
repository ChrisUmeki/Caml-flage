open Ezjsonm 

module Comment = struct

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

  let get_par a = a.parent_id

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

  let comment_from_val o =
    {
      id = Ezjsonm.find o ["comment_id"] |> Ezjsonm.get_int;
      score = Ezjsonm.find o ["score"] |> Ezjsonm.get_int;
      text = Ezjsonm.find o ["text"] |> Ezjsonm.get_string;
      user = "";
      children = [];
      parent_id = 0;
    }

  let comment_from_new o i =
    {
      id = i;
      score = 1;
      text = Ezjsonm.find o ["text"] |> Ezjsonm.get_string;
      user = Ezjsonm.find o ["user_id"] |> Ezjsonm.get_string;
      children = [];
      parent_id = Ezjsonm.find o ["post_id"] |> Ezjsonm.get_int;
    }
  

  let posts_of_json j = match j with
| `A j' -> List.map (fun o -> comment_from_val o) j'
| _ -> raise (Failure "bad json")

  let post_from_new o = 
    failwith "Not yet"

  let to_json_front a = 
    failwith "Not used"

  let to_json a = 
    [("comment_id", Ezjsonm.int a.id);
    ("text", `String a.text); 
    ("score", `Float (float_of_int a.score));]

  let get_children a = a.children

end