/* type tag = string;

/* let parseTagsJson = (json : Js.Json.t) : tag => 
    Json.Decode.{ 
      tag: field("tag", string, json),
    }; */


let parseTagsResponseJson = json =>
  Json.Decode.field("tags", Json.Decode.(array string), json);

let fetchTags = (tagsUrl: string) =>
  Js.Promise.(
    Bs_fetch.fetch(tagsUrl)
      |> then_(Bs_fetch.Response.text)
      |> then_(
        jsonText =>
          resolve(parseTagsResponseJson(Js.Json.parseExn(jsonText)))
      )
  ); */