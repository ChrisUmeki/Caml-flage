open Opium.Std

type tags = {
  name: string;
  posts: post list;
}

let tag_name tag = tag.name

let post_lists tag = tag.posts
