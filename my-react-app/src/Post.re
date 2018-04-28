
/* State declaration */
type state = {
    count: int,
  };
  
/* Action declaration */
type action =
  | Upvote
  | Downvote;
  
/* Component template declaration.
    Needs to be **after** state and action declarations! */
let component = ReasonReact.reducerComponent("Post");

/* message and children are props. `children` isn't used, therefore ignored.
    We ignore it by prepending it with an underscore */
let make = (~title, ~text, ~score, ~post_id, _children) => {
  /* spread the other default fields of component here and override a few */
  ...component,

  initialState: () => {count: score},

  /* State transitions */
  reducer: (action, state) =>
    switch (action) {
    | Upvote => 
      Js.Promise.(
      Axios.postData("/vote", {{"direction": "up", "user_id": 0, "post_id": post_id, "entry_type": "post"}})
      |> then_((response) => resolve(Js.log(response##data)))
      |> catch((error) => resolve(Js.log(error)))
      |> ignore
    );
    ReasonReact.Update({...state, count: state.count + 1});

    | Downvote => 
    Js.Promise.(
      Axios.postData("/vote", {{"direction": "down", "user_id": 0, "post_id": post_id, "entry_type": "post"}})
      |> then_((response) => resolve(Js.log(response##data)))
      |> catch((error) => resolve(Js.log(error)))
      |> ignore
    );
    ReasonReact.Update({...state, count: state.count - 1});
    },

  render: self => {
    let up ="Upvote";
    let down = "Downvote";
    let count = string_of_int(self.state.count);
    <div>
      <div id = "one">
        <div id = "gr">
          <h4>(ReasonReact.stringToElement(title))</h4>
          <p>(ReasonReact.stringToElement(text))</p>
        </div>

        <button className = "up" onClick=(_event => self.send(Upvote))>
          (ReasonReact.stringToElement(up))
        </button>

        <button className = "down" onClick=(_event => self.send(Downvote))>
          (ReasonReact.stringToElement(down))
        </button>

        <div>
          (ReasonReact.stringToElement("number of camels: " ++ count))
        </div>
      </div>
    </div>;
  },
}; 