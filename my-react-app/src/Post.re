/* import React from 'react';
import "./all.css"; */
open Js.Promise;

/* State declaration */
type state = {
    count: int,
    show: bool,
  };
  
/* Action declaration */
type action =
  | Upvote
  | Downvote;
  
/* Component template declaration.
    Needs to be **after** state and action declarations! */
let component = ReasonReact.reducerComponent("Example");

/* greeting and children are props. `children` isn't used, therefore ignored.
    We ignore it by prepending it with an underscore */
let make = (~greeting, _children) => {
  /* spread the other default fields of component here and override a few */
  ...component,

  initialState: () => {count: 0, show: true},

  /* State transitions */
  reducer: (action, state) =>
    switch (action) {
    | Upvote => 
      Js.Promise.(
      Axios.postData("/vote", {{"direction": "up"}})
      |> then_((response) => resolve(Js.log(response##data)))
      |> catch((error) => resolve(Js.log(error)))
      |> ignore
    );
    ReasonReact.Update({...state, count: state.count + 1});
    | Downvote => ReasonReact.Update({...state, count: state.count - 1})
    },

  render: self => {
    let up ="Upvote";
    let down = "Downvote";
    let count = string_of_int(self.state.count);
    <div>
      <div id = "one">
        <div id = "gr">
          (ReasonReact.stringToElement(greeting))
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