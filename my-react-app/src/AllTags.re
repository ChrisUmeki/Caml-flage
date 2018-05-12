/* type state = {
    tagsData: option(array(TagsData.tag)),
  };
  
  type action =
   | Loaded(array(TagsData.tag));
  
  let component = ReasonReact.reducerComponent("AllTags");
  
  
  let make = (~tagsUrl, _children) => {
    ...component,
    initialState: () => {
      tagsData: None
    }, 
  
    /* handle our loaded data and update the component state */
    didMount: (self) => {
      let handlePostsLoaded = self.reduce(tagsData => Loaded(tagsData));
      
      /* loading the data */
      TagsData.fetchPosts(tagsUrl)
        |> Js.Promise.then_(tagsData => {
            handlePostsLoaded(tagsData);
            Js.Promise.resolve();
          })
        |> ignore;
  
      ReasonReact.NoUpdate;
    },
    reducer: (action, _state) => {
      switch action {
        | Loaded(loadedTags) => ReasonReact.Update({
            tagsData: Some(loadedTags)
          })
      };
    },
  
    render: (self) => {
      let tags =
        switch (self.state.tagsData) {
        | Some(tagdata) => ReasonReact.arrayToElement(
            Array.map(
              (tag: TagsData.tag) => 
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
   */