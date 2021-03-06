// Generated by BUCKLESCRIPT VERSION 3.0.0, PLEASE EDIT WITH CARE
'use strict';

var Json_decode = require("@glennsl/bs-json/src/Json_decode.bs.js");

function parseFrontPostsJson(json) {
  return /* record */[
          /* post_id */Json_decode.field("post_id", Json_decode.$$int, json),
          /* title */Json_decode.field("title", Json_decode.string, json),
          /* tag */Json_decode.field("tag", Json_decode.string, json),
          /* text */Json_decode.field("text", Json_decode.string, json),
          /* score */Json_decode.field("score", Json_decode.$$int, json),
          /* num_comments */Json_decode.field("num_comments", Json_decode.$$int, json)
        ];
}

function parseFrontPostsResponseJson(json) {
  return Json_decode.field("posts", (function (param) {
                return Json_decode.array(parseFrontPostsJson, param);
              }), json);
}

function fetchPosts(postsUrl) {
  return fetch(postsUrl).then((function (prim) {
                  return prim.text();
                })).then((function (jsonText) {
                return Promise.resolve(parseFrontPostsResponseJson(JSON.parse(jsonText)));
              }));
}

exports.parseFrontPostsJson = parseFrontPostsJson;
exports.parseFrontPostsResponseJson = parseFrontPostsResponseJson;
exports.fetchPosts = fetchPosts;
/* No side effect */
