// Generated by BUCKLESCRIPT VERSION 3.0.0, PLEASE EDIT WITH CARE
'use strict';

var ReactDOMRe = require("reason-react/src/ReactDOMRe.js");
var ReasonReact = require("reason-react/src/ReasonReact.js");
var Title$ReactTemplate = require("./Title.bs.js");
var AllPosts$ReactTemplate = require("./AllPosts.bs.js");
var PostInput$ReactTemplate = require("./PostInput.bs.js");

ReactDOMRe.renderToElementWithId(ReasonReact.element(/* None */0, /* None */0, Title$ReactTemplate.make("Welcome to Caml-flage", /* array */[])), "title");

ReactDOMRe.renderToElementWithId(ReasonReact.element(/* None */0, /* None */0, PostInput$ReactTemplate.make("wassup", /* array */[])), "input");

ReactDOMRe.renderToElementWithId(ReasonReact.element(/* None */0, /* None */0, AllPosts$ReactTemplate.make(/* array */[])), "posts");

/*  Not a pure module */
