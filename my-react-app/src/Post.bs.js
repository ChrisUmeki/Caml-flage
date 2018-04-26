// Generated by BUCKLESCRIPT VERSION 3.0.0, PLEASE EDIT WITH CARE
'use strict';

var Block = require("bs-platform/lib/js/block.js");
var Curry = require("bs-platform/lib/js/curry.js");
var Axios = require("axios");
var React = require("react");
var ReasonReact = require("reason-react/src/ReasonReact.js");

var component = ReasonReact.reducerComponent("Example");

function make(greeting, _) {
  return /* record */[
          /* debugName */component[/* debugName */0],
          /* reactClassInternal */component[/* reactClassInternal */1],
          /* handedOffState */component[/* handedOffState */2],
          /* willReceiveProps */component[/* willReceiveProps */3],
          /* didMount */component[/* didMount */4],
          /* didUpdate */component[/* didUpdate */5],
          /* willUnmount */component[/* willUnmount */6],
          /* willUpdate */component[/* willUpdate */7],
          /* shouldUpdate */component[/* shouldUpdate */8],
          /* render */(function (self) {
              var count = String(self[/* state */2][/* count */0]);
              return React.createElement("div", undefined, React.createElement("div", {
                              id: "one"
                            }, React.createElement("div", {
                                  id: "gr"
                                }, greeting), React.createElement("button", {
                                  className: "up",
                                  onClick: (function () {
                                      return Curry._1(self[/* send */4], /* Upvote */0);
                                    })
                                }, "Upvote"), React.createElement("button", {
                                  className: "down",
                                  onClick: (function () {
                                      return Curry._1(self[/* send */4], /* Downvote */1);
                                    })
                                }, "Downvote"), React.createElement("div", undefined, "number of camels: " + count)));
            }),
          /* initialState */(function () {
              return /* record */[
                      /* count */0,
                      /* show */true
                    ];
            }),
          /* retainedProps */component[/* retainedProps */11],
          /* reducer */(function (action, state) {
              if (action) {
                return /* Update */Block.__(0, [/* record */[
                            /* count */state[/* count */0] - 1 | 0,
                            /* show */state[/* show */1]
                          ]]);
              } else {
                Axios.post("/vote", {
                          direction: "up"
                        }).then((function (response) {
                          return Promise.resolve((console.log(response.data), /* () */0));
                        })).catch((function (error) {
                        return Promise.resolve((console.log(error), /* () */0));
                      }));
                return /* Update */Block.__(0, [/* record */[
                            /* count */state[/* count */0] + 1 | 0,
                            /* show */state[/* show */1]
                          ]]);
              }
            }),
          /* subscriptions */component[/* subscriptions */13],
          /* jsElementWrapped */component[/* jsElementWrapped */14]
        ];
}

exports.component = component;
exports.make = make;
/* component Not a pure module */
