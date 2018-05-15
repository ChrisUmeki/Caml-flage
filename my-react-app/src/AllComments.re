/* AllComments.re displays all comments associated with a post */ 
type state = {
    commentsData: option(array(CommentData.comment)),
  };
  
  type action =
   | Loaded(array(CommentData.comment));
  
  let component = ReasonReact.reducerComponent("AllComments");
  
  let make = (~postsUrl, ~post_id, _children) => {
    ...component,
    initialState: () => {
      commentsData: None
    }, 
  
    /* handle our loaded data and update the component state */
    didMount: (self) => {
      let handleCommentsLoaded = self.reduce(commentsData => Loaded(commentsData));
      
      /* loading the data */
      CommentData.fetchComments(postsUrl)
        |> Js.Promise.then_(commentsData => {
            handleCommentsLoaded(commentsData);
            Js.Promise.resolve();
          })
        |> ignore;
  
      ReasonReact.NoUpdate;
    },
    reducer: (action, _state) => {
      switch action {
        | Loaded(loadedComments) => ReasonReact.Update({
            commentsData: Some(loadedComments)
          })
      };
    },
  
    /* render passes in the data stored in commentsData and renders individual Comment components */
    render: (self) => {
      let comments =
        switch (self.state.commentsData) {
        | Some(commentdata) => ReasonReact.arrayToElement(
            Array.map(
              (comment: CommentData.comment) => 
              <Comment 
              post_id=post_id 
              text=comment.text 
              score=comment.score 
              comment_id=comment.comment_id 
              nestedcomments=comment.children
              />,
              commentdata
            )
          )
        | None => ReasonReact.stringToElement("Loading...")
        };
  
      <div className="display">
      {comments}
      </div>
    }
  
  };
  