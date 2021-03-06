// Generated by BUCKLESCRIPT VERSION 3.0.0, PLEASE EDIT WITH CARE
'use strict';

var $$Array = require("bs-platform/lib/js/array.js");
var Block = require("bs-platform/lib/js/block.js");
var Curry = require("bs-platform/lib/js/curry.js");
var React = require("react");
var ReasonReact = require("reason-react/src/ReasonReact.js");
var Post$ReactTemplate = require("./Post.bs.js");
var PostsData$ReactTemplate = require("./PostsData.bs.js");

var component = ReasonReact.reducerComponent("AllPosts");

function make(postsUrl, _) {
  return /* record */[
          /* debugName */component[/* debugName */0],
          /* reactClassInternal */component[/* reactClassInternal */1],
          /* handedOffState */component[/* handedOffState */2],
          /* willReceiveProps */component[/* willReceiveProps */3],
          /* didMount */(function (self) {
              var handlePostsLoaded = Curry._1(self[/* reduce */1], (function (postsData) {
                      return /* Loaded */[postsData];
                    }));
              PostsData$ReactTemplate.fetchPosts(postsUrl).then((function (postsData) {
                      Curry._1(handlePostsLoaded, postsData);
                      return Promise.resolve(/* () */0);
                    }));
              return /* NoUpdate */0;
            }),
          /* didUpdate */component[/* didUpdate */5],
          /* willUnmount */component[/* willUnmount */6],
          /* willUpdate */component[/* willUpdate */7],
          /* shouldUpdate */component[/* shouldUpdate */8],
          /* render */(function (self) {
              var match = self[/* state */2][/* postsData */0];
              var posts = match ? $$Array.map((function (frontpost) {
                        return ReasonReact.element(/* None */0, /* None */0, Post$ReactTemplate.make(frontpost[/* title */1], frontpost[/* tag */2], frontpost[/* text */3], frontpost[/* score */4], frontpost[/* post_id */0], /* array */[]));
                      }), match[0]) : "Loading...";
              return React.createElement("div", {
                          className: "display"
                        }, posts);
            }),
          /* initialState */(function () {
              return /* record */[/* postsData : None */0];
            }),
          /* retainedProps */component[/* retainedProps */11],
          /* reducer */(function (action, _) {
              return /* Update */Block.__(0, [/* record */[/* postsData : Some */[action[0]]]]);
            }),
          /* subscriptions */component[/* subscriptions */13],
          /* jsElementWrapped */component[/* jsElementWrapped */14]
        ];
}

exports.component = component;
exports.make = make;
/* component Not a pure module */
