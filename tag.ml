open Entry

type t = {
  name: string;
  posts: Post.t list;
}

let posts_list tag = tag.posts

let tag_name tag = tag.name
