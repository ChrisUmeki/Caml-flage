ReactDOMRe.renderToElementWithId(<Title message="Welcome to Caml-flage" />, "title");

ReactDOMRe.renderToElementWithId (<PostInput initialText ="Create a new post here!" />, "input");

ReactDOMRe.renderToElementWithId(<AllPosts postsUrl="/state.json"/>, "posts");

let url = ReasonReact.Router.dangerouslyGetInitialUrl ();
let lst = url.path;
let post_id = List.nth(lst, List.length(lst) - 1);
let myurl = "/post/"++post_id++"/poststate.json";

ReactDOMRe.renderToElementWithId(<AllPosts postsUrl={myurl}/>, "onepost");

ReactDOMRe.renderToElementWithId(<AllComments postsUrl={myurl}/>, "comments");

ReactDOMRe.renderToElementWithId(<CommentInput post_id=post_id initialText="Write a comment"/>, "comment_input");

ReactDOMRe.renderToElementWithId(<AllTags tagsUrl="/state.json"/>, "tags");

