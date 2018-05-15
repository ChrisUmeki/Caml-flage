ReactDOMRe.renderToElementWithId(<Title message="Welcome to Caml-flage" />, "title" );

ReactDOMRe.renderToElementWithId (<PostInput initialText ="Create a new post here!" />, "input");

let url = ReasonReact.Router.dangerouslyGetInitialUrl ();
let lst = url.path;


let sorturl = url => {
  switch (url) {
  | [] => "/state.json" 
  | ["sorted", sort] => "/sorted/"++sort++"/state.json"
  | _ => "/state.json"
  }
};

ReactDOMRe.renderToElementWithId(<AllPosts postsUrl=sorturl(lst)/>, "posts");


let post_id = List.nth(lst, List.length(lst) - 1);

let renderToElement = (posttype, myurl, id) => {
    if (posttype == "post") {

    ReactDOMRe.renderToElementWithId(<AllPosts postsUrl={myurl}/>, "onepost");

    ReactDOMRe.renderToElementWithId(<AllComments post_id=int_of_string(post_id)  postsUrl={myurl}/>, "comments"); 

    /* ReactDOMRe.renderToElementWithId(<CommentInput parent_is_post=true parent_id=post_id post_id=post_id initialText="Write a comment"/>, "comment_input"); */

    } else {

    ReactDOMRe.renderToElementWithId(<Title message=id />, "tagtitle");

    ReactDOMRe.renderToElementWithId(<AllPosts postsUrl={myurl}/>, "poststag");

    }
};


let geturl = url => {
    switch (url) {
    | ["post", id] => renderToElement("post", "/post/"++id++"/poststate.json", id)
    | ["tag", id] => renderToElement("tag", "/tag/"++id++"/tagstate.json", id)
    | _ => ()
    }
};

let myurl = geturl(lst);

ReactDOMRe.renderToElementWithId(<AllTags tagsUrl="/state.json"/>, "tags");

