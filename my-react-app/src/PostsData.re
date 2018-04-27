type frontposts = {
    post_id: int, 
    text: string, 
    score: int,
    num_comments: int,
  };
   
let parseFrontPostsJson = (json : Js.Json.t) : frontposts => 
    Json.Decode.{
      post_id: field("post_id", int, json),
      text: field("text", string, json), 
      score: field("score", int, json),
      num_comments: field("num_comments", int, json)
    };

/* posts is name of array */
let parseFrontPostsResponseJson = json =>
Json.Decode.field("posts", Json.Decode.array(parseFrontPostsJson), json);

let postsUrl = "/public/SampleFrontPosts.json";

let fetchPosts = () =>
  Js.Promise.(
    Bs_fetch.fetch(postsUrl)
      |> then_(Bs_fetch.Response.text)
      |> then_(
        jsonText =>
          resolve(parseFrontPostsResponseJson(Js.Json.parseExn(jsonText)))
      )
  );