type state = {
  text:string, 
  inputElement: ref (option(Dom.element))
};

  
 let valueFromEvent = (evt) : string => (
  evt
  |> ReactEventRe.Form.target
  |> ReactDOMRe.domElementToObj
)##value;

let component = ReasonReact.reducerComponent("EditField");

let setInputElement = (theRef, {ReasonReact.state}) => 
state.inputElement := Js.toOption(theRef);
 
let make = (~initialText, ~onSubmit, _) => {
  ...component,
  initialState: () => {text:initialText, inputElement: ref(None)}, 
  reducer: (newText, state) => ReasonReact.Update ({...state, text: newText}),
  render: ({state: {text}, reduce, handle}) =>
    <input
      value=text
      _type="text"
      ref=(handle(setInputElement))
      placeholder="Todo description"
      onChange=(reduce((evt) => valueFromEvent(evt)))
      onKeyDown=(
        (evt) =>
          if (ReactEventRe.Keyboard.key(evt) == "Enter") {
            onSubmit(text);
            (reduce(() => ""))()
          } else if (ReactEventRe.Keyboard.key(evt) == "Escape") {
            onSubmit(initialText);
            (reduce(() => ""))()
          }
      )
    />
};

/*
module Input = {
  type state = string;
  let component = ReasonReact.reducerComponent("Input");
  let make = (~onSubmit, _) => {
    ...component,
    initialState: () => "",
    reducer: (newText, _text) => ReasonReact.Update(newText),
    render: ({state: text, reduce}) =>
      <input
        value=text
        _type="text"
        placeholder="Write something to do"
        onChange=(reduce((evt) => valueFromEvent(evt)))
        onKeyDown=((evt) =>
          if (ReactEventRe.Keyboard.key(evt) == "Enter") {
            onSubmit(text);
            (reduce(() => ""))()
          }
        )
      />
  }; */
