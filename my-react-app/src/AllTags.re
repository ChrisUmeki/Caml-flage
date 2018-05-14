/* This file handles displaying the full list of tags stored */ 

type state = {
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
      TagsData.fetchTags(tagsUrl)
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
              <Tag tag=tag/>,
              tagdata
            )
          )
        | None => ReasonReact.stringToElement("Loading...")
        };
  
        <div className="display">
        {tags}
        </div>
    }
  
  };
  