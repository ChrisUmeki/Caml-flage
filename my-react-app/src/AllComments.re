type state = {
    commentsData: option(array(CommentData.comments)),
  };
  
  type action =
   | Loaded(array(CommentData.comments));
  
  let component = ReasonReact.reducerComponent("AllComments");
  
  let make = (_children) => {
    ...component,
    initialState: () => {
      commentsData: None
    }, 
  
    /* handle our loaded data and update the component state */
    didMount: (self) => {
      let handleCommentsLoaded = self.reduce(commentsData => Loaded(commentsData));
      
      /* loading the data */
      CommentData.fetchComments()
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
  
    render: (self) => {
      let comments =
        switch (self.state.commentsData) {
        | Some(commentdata) => ReasonReact.arrayToElement(
            Array.map(
              (comments: CommentData.comments) => 
              <Comment text=comments.text score=comments.score comment_id=comments.comment_id/>,
              commentdata
            )
          )
        | None => ReasonReact.stringToElement("Loading...")
        };
  
        <div className="display">        {comments}
      </div>
    }
  
  };
  