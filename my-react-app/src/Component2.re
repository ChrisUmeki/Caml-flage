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
    | Upvote => ReasonReact.Update({...state, count: state.count + 1})
    | Downvote => ReasonReact.Update({...state, count: state.count - 1})
    },

  render: self => {
    let message ="Upvote";
    let message2 = "Downvote";
    let message3 = string_of_int(self.state.count);
    <div>
      <div style =  (ReactDOMRe.Style.make( ~borderStyle = "solid", ~borderColor = "black", ~textAlign =  "center", () ))>
        <div style = (ReactDOMRe.Style.make( ~fontSize = "25px", ~textAlign =  "center", ~margin = "50px", () )) class = "up">
          (ReasonReact.stringToElement(greeting))
        </div>
        
        <button style = (ReactDOMRe.Style.make(~backgroundColor = "A52A2A", ~fontSize = "25px", ~textAlign =  "center", () )) class = "down" onClick=(_event => self.send(Upvote))>
          (ReasonReact.stringToElement(message))
        </button>

        <button style = (ReactDOMRe.Style.make(~backgroundColor = "A52A2A", ~fontSize = "25px", ~textAlign =  "center", () )) onClick=(_event => self.send(Downvote))>
          (ReasonReact.stringToElement(message2))
        </button>

        <div>
          (ReasonReact.stringToElement("number of camels: " ++ message3))
        </div>
      </div>
    </div>;
  },
};
