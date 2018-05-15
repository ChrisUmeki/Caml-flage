/* CommentData.re parses the json into type comment */ 
type comment = {
    comment_id: int, 
    text: string, 
    score: int,
    children: array(comment),
  };

/* parseCommentsJson parses the json passed in and returns a type comment */
let rec parseCommentsJson = (json : Js.Json.t) : comment => 
    Json.Decode.{
      comment_id: field("comment_id", int, json),
      text: field("text", string, json), 
      score: field("score", int, json),
      children: field("children", Json.Decode.array(parseCommentsJson), json),
    };

/* comments is name of array 
parseCommentsResponseJson parses the field comment_list of the json */
let parseCommentsResponseJson = json =>
Json.Decode.field("comment_list", Json.Decode.array(parseCommentsJson), json);

/* fetchComments takes the data from the json and passes it into parseCommentsResponseJson 
* postsUrl is a string 
* this function was taken from Jared's tutorial (see design doc) */
let fetchComments = (postsUrl:string) =>
  Js.Promise.(
    Bs_fetch.fetch(postsUrl)
      |> then_(Bs_fetch.Response.text)
      |> then_(
        jsonText =>
          resolve(parseCommentsResponseJson(Js.Json.parseExn(jsonText)))
      )
  );
