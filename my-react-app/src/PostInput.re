/* type state = {
  text:string, 
  inputElement: ref (option(Dom.element))
};

type action = 
  | Submit; 

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

  reducer: (newText, state) => 
  switch (action){
   | Submit => ReasonReact.Update ({...state, text: newText})
  },

  render: ({state: {text}, reduce, handle}) =>
  <form>
    <input
      value=text
      _type="text"
      ref=(handle(setInputElement))
      placeholder="Write a message"
      onChange=(reduce((evt) => valueFromEvent(evt)))
      onKeyDown=(
        (evt) =>
          if (ReactEventRe.Keyboard.key(evt) == "Enter") {
            /* onSubmit(text); */
            onSubmit = (_event => self.send(Submit));
            (reduce(() => ""))()
          } else if (ReactEventRe.Keyboard.key(evt) == "Escape") {
            onSubmit(initialText);
            (reduce(() => ""))()
          }
      )
    />
    </form>
   
}; */