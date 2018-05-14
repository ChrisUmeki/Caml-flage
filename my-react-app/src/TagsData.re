type tag = string;

let parseTagsJson = (json : Js.Json.t) : tag => 
  Json.Decode.string(json);

let parseTagsResponseJson = json =>
  Json.Decode.field("tags", Json.Decode.array(parseTagsJson), json);

let fetchTags = (tagsUrl: string) =>
  Js.Promise.(
    Bs_fetch.fetch(tagsUrl)
      |> then_(Bs_fetch.Response.text)
      |> then_(
        jsonText =>
          resolve(parseTagsResponseJson(Js.Json.parseExn(jsonText)))
      )
  );