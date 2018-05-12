

type frontpost = {
    post_id: int, 
    title: string, 
    tag: string,
    text: string, 
    score: int,
    num_comments: int,
  };
   
let parseFrontPostsJson = (json : Js.Json.t) : frontpost => 
    Json.Decode.{
      post_id: field("post_id", int, json),
      title: field("title", string, json),
      tag: field("tag", string, json),
      text: field("text", string, json), 
      score: field("score", int, json),
      num_comments: field("num_comments", int, json)
    
    };

    /* field ("comment_list", list ({comment_id: field("comment_id",int, json), text: field( "text", string, json), score:field("score", int,json)}), json),
       */

/* posts is name of array */
let parseFrontPostsResponseJson = json =>
  Json.Decode.field("posts", Json.Decode.array(parseFrontPostsJson), json);

let fetchPosts = (postsUrl: string) =>
  Js.Promise.(
    Bs_fetch.fetch(postsUrl)
      |> then_(Bs_fetch.Response.text)
      |> then_(
        jsonText =>
          resolve(parseFrontPostsResponseJson(Js.Json.parseExn(jsonText)))
      )
  );