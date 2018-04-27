type state = {
  text:string, 
  inputElement: ref (option(Dom.element))
};

type action = 
  | Change(string)
  | Submit(string); 

 let valueFromEvent = (evt) : string => (
  evt
  |> ReactEventRe.Form.target
  |> ReactDOMRe.domElementToObj
)##value;

let component = ReasonReact.reducerComponent("EditField");

let setInputElement = (theRef, {ReasonReact.state}) => 
state.inputElement := Js.toOption(theRef);
 
let make = (~initialText, _) => {
  ...component,
  initialState: () => {text:initialText, inputElement: ref(None)}, 

  /* reducer: (newText, state) => ReasonReact.Update({...state, text: newText}), */
  /* reducer: (action, newText, state) => 
  switch (action){
   | Submit => ReasonReact.Update ({...state, text: newText})
  }, */
  reducer: (action) => 
    switch (action){
    | Submit(newText) => (
        state => 
        ReasonReact.Update ({...state, text:newText})
        )
    | Change(newText) => (
         state => 
        ReasonReact.Update ({...state, text:newText})
      )
    },

  render: ({state: {text}, send, handle}) => {
  /* <div>
    (ReasonReact.stringToElement("new post"))
  </div>  */
  <div> 
    <div>
    (ReasonReact.stringToElement("new post"))
    </div>

    <div> 
    <input
      value=text
      _type="text"
      ref=(handle(setInputElement))
      placeholder="Write a message"

      onChange = (
          (evt) =>
            send(
                Change(
                    valueFromEvent(evt)
                ),
            )
        )
      
      onKeyDown=(
          (evt) =>
          if (ReactEventRe.Keyboard.key(evt) == "Enter") {
          send(Submit(text))
        } 

      )
    />
    </div>
   </div>;
  },
}; 

/* onChange= (reduce((evt) => valueFromEvent(evt))) */

   /* onKeyDown=(
        (evt) =>
          if (ReactEventRe.Keyboard.key(evt) == "Enter") {
            onSubmit(text); 
            onSubmit = (_event => self.reduce(Submit)); 
            (state.reduce(Submit, text))
            (reduce(() => ""))() 
          } 
           } else if (ReactEventRe.Keyboard.key(evt) == "Escape") {
            onSubmit(initialText);
            (reduce(() => ""))()
          } 
      ) */