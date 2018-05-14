open Ezjsonm 

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

  let get_text a =
  a.text

  let get_children a =
    a.children

  let get_par a = 
    a.parent_id

  let add_reply par reply =
    par.children <- reply::par.children

  let comment_from_new o i =
    {
      id = i;
      score = 1;
      text = Ezjsonm.find o ["text"] |> Ezjsonm.get_string;
      user = Ezjsonm.find o ["user_id"] |> Ezjsonm.get_string;
      children = [];
      parent_id = Ezjsonm.find o ["post_id"] |> Ezjsonm.get_int;
    }

  let comment_from_val o =
    {
      id = Ezjsonm.find o ["comment_id"] |> Ezjsonm.get_int;
      score = Ezjsonm.find o ["score"] |> Ezjsonm.get_int;
      text = Ezjsonm.find o ["text"] |> Ezjsonm.get_string;
      user = Ezjsonm.find o ["user"] |> Ezjsonm.get_string;
      children = []; (* IMPLEMENT COMMENTS ON COMMENTS *)
      parent_id = Ezjsonm.find o ["parent_id"] |> Ezjsonm.get_int;
    }

  let comment_from_params i s t u c p =
    {
      id = i;
      score = s;
      text = t;
      user = u;
      children = c; 
      parent_id = p;
    }

  let comments_of_json j = match j with
| `A j' -> List.map (fun o -> comment_from_val o) j'
| _ -> raise (Failure "bad json")

  (* [helper_c c] is a helper function used in to_json to allow for easy conversion from type comment to Ezjsonm.value, 
   * so that a list of Ezjsonm value objects representing the children of a comment can be saved to JSON. *)
  let rec helper_c c = Ezjsonm.value (`O (to_json c))

  and to_json a = 
    [("comment_id", Ezjsonm.int a.id);
    ("text", `String a.text); 
    ("score", `Float (float_of_int a.score));
    ("user", Ezjsonm.string a.user);
    ("children", `A (List.map helper_c a.children));
    ("parent_id", Ezjsonm.int a.parent_id);]

