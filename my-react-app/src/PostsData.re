/* PostsData.re parses the json for posts and stores it in type frontpost */

type frontpost = {
    post_id: int, 
    title: string, 
    tag: string,
    text: string, 
    score: int,
    num_comments: int,
  };


/* [parseFrontPostJson json] parses the json by extracting the data of a single post and 
   returns a frontpost with corresponding fields*/   
let parseFrontPostsJson = (json : Js.Json.t) : frontpost => 
    Json.Decode.{
      post_id: field("post_id", int, json),
      title: field("title", string, json),
      tag: field("tag", string, json),
      text: field("text", string, json), 
      score: field("score", int, json),
      num_comments: field("num_comments", int, json)
    
    };

/* [parseFrontPostsJson json] parses the the json by extracting the data of all posts and
   returns an array of frontposts with corresponding fields */
let parseFrontPostsResponseJson = json =>
  Json.Decode.field("posts", Json.Decode.array(parseFrontPostsJson), json);

/* fetchPosts takes the data from the json and passes it into parseFrontPostsResponseJson
* postsUrl is a string 
* this function was taken from Jared's tutorial (see design doc) */
let fetchPosts = (postsUrl: string) =>
  Js.Promise.(
    Bs_fetch.fetch(postsUrl)
      |> then_(Bs_fetch.Response.text)
      |> then_(
        jsonText =>
          resolve(parseFrontPostsResponseJson(Js.Json.parseExn(jsonText)))
      )
  );