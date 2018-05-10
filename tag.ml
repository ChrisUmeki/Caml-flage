open Post

type t = {
  name: string;
  posts: Post.t list;
}

let posts_list t = t.posts

let tag_name t = t.name
