/* AllPosts.re displays all posts currently stored in the Json  */
type state = {
  postsData: option(array(PostsData.frontpost)),
};

type action =
 | Loaded(array(PostsData.frontpost));

let component = ReasonReact.reducerComponent("AllPosts");


let make = (~postsUrl, _children) => {
  ...component,
  initialState: () => {
    postsData: None
  }, 

  /* handle our loaded data and update the component state */
  didMount: (self) => {
    let handlePostsLoaded = self.reduce(postsData => Loaded(postsData));
    
    /* loading the data */
    PostsData.fetchPosts(postsUrl)
      |> Js.Promise.then_(postsData => {
          handlePostsLoaded(postsData);
          Js.Promise.resolve();
        })
      |> ignore;

    ReasonReact.NoUpdate;
  },
  reducer: (action, _state) => {
    switch action {
      | Loaded(loadedPosts) => ReasonReact.Update({
          postsData: Some(loadedPosts)
        })
    };
  },

  render: (self) => {
    let posts =
      switch (self.state.postsData) {
      | Some(postdata) => ReasonReact.arrayToElement(
          Array.map(
            (frontpost: PostsData.frontpost) => 
            <Post title=frontpost.title tag=frontpost.tag text=frontpost.text score=frontpost.score post_id=frontpost.post_id/>,
            postdata
          )
        )
      | None => ReasonReact.stringToElement("Loading...")
      };

      <div className="display">
      {posts}
      </div>
  }

};
