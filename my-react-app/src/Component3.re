/* State declaration */
type state = {
  count: int,
  show: bool,
};

/* Action declaration */
type action =
  | Click
  | Toggle;

/* Component template declaration.
   Needs to be **after** state and action declarations! */
let component = ReasonReact.reducerComponent("Example2");

/* greeting and children are props. `children` isn't used, therefore ignored.
   We ignore it by prepending it with an underscore */
let make = (~greeting, _children) => {
  /* spread the other default fields of component here and override a few */
  ...component,

  initialState: () => {count: 0, show: true},

  /* State transitions */
  reducer: (action, state) =>
    switch (action) {
    | Click => ReasonReact.Update({...state, count: state.count + 1})
    | Toggle => ReasonReact.Update({...state, show: ! state.show})
    },

  render: self => {
    let message =
      "Downvotes: -" ++ string_of_int(self.state.count);
    <div>
      <button onClick=(_event => self.send(Click))>
        (ReasonReact.stringToElement(message))
      </button>
      (
        self.state.show ?
          ReasonReact.stringToElement(greeting) : ReasonReact.nullElement
      )
    </div>;
  },
};
