open Opium.Std

type tag = {
  name: string;
  posts: string list;
}

let posts_list tag = tag.posts

let tag_name tag = tag.name
