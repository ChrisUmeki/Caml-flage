open Post

type t = {
  name: string;
  posts: (Post.t ref) list;
}

let posts_list tag = let f x = !x in List.map f tag.posts

let tag_name tag = tag.name

let helper_p p = Ezjsonm.value (`O (Post.to_json p))

let to_json a = 
  [("name", Ezjsonm.string a.name);
  ("posts", `A (List.map helper_p (posts_list a)))
]

