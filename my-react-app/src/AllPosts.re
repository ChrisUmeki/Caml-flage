
type state = {
  postsData: option(array(PostsData.frontposts)),
};

type action =
 | Loaded(array(PostsData.frontposts));

let component = ReasonReact.reducerComponent("AllPosts");

let make = (_children) => {
  ...component,
  initialState: () => {
    postsData: None
  }, 

  /* handle our loaded data and update the component state */
  didMount: (self) => {
    let handlePostsLoaded = self.reduce(postsData => Loaded(postsData));
    
    /* loading the data */
    PostsData.fetchPosts()
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
            (frontposts: PostsData.frontposts) => <Post message=frontposts.text />,
            postdata
          )
        )
      | None => ReasonReact.stringToElement("blah")
      };

      <div className="display">
      /* <h1>{ReasonReact.stringToElement("Reason Projects")}</h1> */
      {posts}
    </div>
  }





  /* render: (self) =>
    <div className="display">
      <Post message="HELLOOOO" />
      <Post message="HELLOOOO2" />
      <Post message="HELLOOOO3" />
      <Post message="HELLOOOO3" />
    </div> */

};
