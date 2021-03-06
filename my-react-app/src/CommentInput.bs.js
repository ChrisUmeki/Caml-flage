// Generated by BUCKLESCRIPT VERSION 3.0.0, PLEASE EDIT WITH CARE
'use strict';

var Block = require("bs-platform/lib/js/block.js");
var Curry = require("bs-platform/lib/js/curry.js");
var Axios = require("axios");
var React = require("react");
var Caml_format = require("bs-platform/lib/js/caml_format.js");
var ReasonReact = require("reason-react/src/ReasonReact.js");

function valueFromEvent(evt) {
  return evt.target.value;
}

var component = ReasonReact.reducerComponent("EditField");

function setInputElement(theRef, param) {
  param[/* state */2][/* inputElement */1][0] = (theRef == null) ? /* None */0 : [theRef];
  return /* () */0;
}

function make(parent_is_post, parent_id, post_id, initialText, _) {
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
          /* render */(function (param) {
              var send = param[/* send */4];
              var text = param[/* state */2][/* text */0];
              return React.createElement("div", undefined, React.createElement("div", undefined, "New comment"), React.createElement("div", undefined, React.createElement("input", {
                                  ref: Curry._1(param[/* handle */0], setInputElement),
                                  placeholder: "Write a comment",
                                  type: "text",
                                  value: text,
                                  onKeyDown: (function (evt) {
                                      if (evt.key === "Enter") {
                                        return Curry._1(send, /* Submit */Block.__(1, [text]));
                                      } else {
                                        return 0;
                                      }
                                    }),
                                  onChange: (function (evt) {
                                      return Curry._1(send, /* Change */Block.__(0, [evt.target.value]));
                                    })
                                }), React.createElement("button", {
                                  onClick: (function () {
                                      return Curry._1(send, /* Submit */Block.__(1, [text]));
                                    })
                                }, "Submit")));
            }),
          /* initialState */(function () {
              return /* record */[
                      /* text */initialText,
                      /* inputElement */[/* None */0]
                    ];
            }),
          /* retainedProps */component[/* retainedProps */11],
          /* reducer */(function (action) {
              if (action.tag) {
                Axios.post("/comment", {
                          user_id: "",
                          post_id: Caml_format.caml_int_of_string(post_id),
                          text: action[0],
                          parent_is_post: parent_is_post,
                          parent_comment_id: Caml_format.caml_int_of_string(parent_id)
                        }).then((function (response) {
                          return Promise.resolve((console.log(response.data), /* () */0));
                        })).catch((function (error) {
                        return Promise.resolve((console.log(error), /* () */0));
                      }));
                return (function (state) {
                    return /* Update */Block.__(0, [/* record */[
                                /* text */"Comment made!",
                                /* inputElement */state[/* inputElement */1]
                              ]]);
                  });
              } else {
                var newText = action[0];
                console.log(newText);
                return (function (state) {
                    return /* Update */Block.__(0, [/* record */[
                                /* text */newText,
                                /* inputElement */state[/* inputElement */1]
                              ]]);
                  });
              }
            }),
          /* subscriptions */component[/* subscriptions */13],
          /* jsElementWrapped */component[/* jsElementWrapped */14]
        ];
}

exports.valueFromEvent = valueFromEvent;
exports.component = component;
exports.setInputElement = setInputElement;
exports.make = make;
/* component Not a pure module */
