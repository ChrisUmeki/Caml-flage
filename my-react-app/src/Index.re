ReactDOMRe.renderToElementWithId(<Title message="Welcome to Caml-flage" />, "title");

ReactDOMRe.renderToElementWithId (<PostInput initialText ="Create a new post here!" />, "input");

ReactDOMRe.renderToElementWithId(<AllPosts postsUrl="/state.json"/>, "posts");

let url = ReasonReact.Router.dangerouslyGetInitialUrl ();
let lst = url.path;

let post_id = List.nth(lst, List.length(lst) - 1);

let renderToElement = (posttype, myurl) => {
    if (posttype == "post") {

    ReactDOMRe.renderToElementWithId(<AllPosts postsUrl={myurl}/>, "onepost");

    ReactDOMRe.renderToElementWithId(<AllComments postsUrl={myurl}/>, "comments"); 

    ReactDOMRe.renderToElementWithId(<CommentInput post_id=post_id initialText="Write a comment"/>, "comment_input");

    } else {

    ReactDOMRe.renderToElementWithId(<AllPosts postsUrl={myurl}/>, "poststag");

    }
};


let geturl = url => {
    switch (url) {
    | ["post", id] => renderToElement("post", "/post/"++id++"/poststate.json")
    | ["tag", id] => renderToElement("tag", "/tag/"++id++"/tagstate.json")
    | _ => ()
    }
};

let myurl = geturl(lst);

ReactDOMRe.renderToElementWithId(<AllTags tagsUrl="/state.json"/>, "tags");

/* let tagsurl = ReasonReact.Router.dangerouslyGetInitialUrl (); 
let lst2 = tagsurl.path; 
let tagname = List.nth(lst2, List.length(lst2) - 1); 
let newtagsurl = "/tag/"++tagname++"/tagstate.json";  */

/* ReactDOMRe.renderToElementWithId(<AllPosts postsUrl = {newtagsurl}/>, "poststag");  */

