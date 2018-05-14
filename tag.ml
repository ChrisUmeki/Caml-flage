open Post

type t = {
  name: string;
  mutable posts: (Post.t ref) list;
}

let posts_list tag = let f x = !x in List.map f tag.posts

let tag_name tag = tag.name

let helper_p p = Ezjsonm.value (`O (Post.to_json p))

let to_json a = 
  [("name", Ezjsonm.string a.name);
  ("posts", `A (List.map helper_p (posts_list a)))
]

let empty s = {
  name = s;
  posts = [];
}

let add_post tag p = tag.posts <- (ref p)::tag.posts
