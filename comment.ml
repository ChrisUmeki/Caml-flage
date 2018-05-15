open Ezjsonm 

  type t = {
    id: int;
    mutable score: int;
    text: string;
    user: string;
    mutable children: t list;
    post_id: int;
    parent_comment_id: int;
    parent_is_post: bool;
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
    a.parent_comment_id

  let par_is_post a =
    a.parent_is_post
  
  let get_post_id a =
    a.post_id

  let add_reply par reply =
    par.children <- reply::par.children

  let comment_from_new o i =
    {
      id = i;
      score = 1;
      text = Ezjsonm.find o ["text"] |> Ezjsonm.get_string;
      user = Ezjsonm.find o ["user_id"] |> Ezjsonm.get_string;
      children = [];
      post_id = Ezjsonm.find o ["post_id"] |> Ezjsonm.get_int;
      parent_comment_id = Ezjsonm.find o ["parent_comment_id"] |> Ezjsonm.get_int;
      parent_is_post = Ezjsonm.find o ["parent_is_post"] |> Ezjsonm.get_bool;
    }

  let rec comment_from_val o =
    let childrenlst = Ezjsonm.find o ["children"] |> Ezjsonm.get_list comment_from_val in
    {
      id = Ezjsonm.find o ["comment_id"] |> Ezjsonm.get_int;
      score = Ezjsonm.find o ["score"] |> Ezjsonm.get_int;
      text = Ezjsonm.find o ["text"] |> Ezjsonm.get_string;
      user = Ezjsonm.find o ["user"] |> Ezjsonm.get_string;
      children = childrenlst;
      post_id = Ezjsonm.find o ["post_id"] |> Ezjsonm.get_int;
      parent_comment_id = Ezjsonm.find o ["parent_comment_id"] |> Ezjsonm.get_int;
      parent_is_post = Ezjsonm.find o ["parent_is_post"] |> Ezjsonm.get_bool;
    }

  let comment_from_params i s t u c p =
    {
      id = i;
      score = s;
      text = t;
      user = u;
      children = c; 
      post_id = p;
      parent_comment_id = -1;
      parent_is_post = true;
    }

  let comments_of_json j = match j with
| `A j' -> List.map (fun o -> comment_from_val o) j'
| _ -> raise (Failure "bad json")

  (* [helper_c c] is a helper function used in to_json to allow for easy conversion from type comment to Ezjsonm.value, 
   * so that a list of Ezjsonm value objects representing the children of a comment can be saved to JSON. *)
  let rec helper_c c = Ezjsonm.value (`O (to_json c))

  and to_json a = 
    [
      ("comment_id", Ezjsonm.int a.id);
      ("text", `String a.text); 
      ("score", `Float (float_of_int a.score));
      ("user", Ezjsonm.string a.user);
      ("children", `A (List.map helper_c a.children));
      ("post_id", Ezjsonm.int a.post_id);
      ("parent_comment_id", Ezjsonm.int a.parent_comment_id);
      ("parent_is_post", Ezjsonm.bool a.parent_is_post);
    ]

