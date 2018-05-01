ReactDOMRe.renderToElementWithId(<Title message="Welcome to Caml-flage" />, "title");

ReactDOMRe.renderToElementWithId (<PostInput initialText ="Create a new post here!" />, "input");

ReactDOMRe.renderToElementWithId(<AllPosts postsUrl="/state.json"/>, "posts");

ReactDOMRe.renderToElementWithId(<AllPosts postsUrl="/post/1/poststate.json"/>, "onepost");

ReactDOMRe.renderToElementWithId(<AllComments/>, "comments");

