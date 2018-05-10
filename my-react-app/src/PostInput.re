type state = {
  title: string, 
  text: string,
  tag: string,
  inputElement: ref (option(Dom.element))
};

type action = 
  | ChangeTitle(string)
  | ChangeText(string)
  | ChangeTag(string)
  | Submit(string, string, string); 

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
  initialState: () => {title: "Title", text:initialText, tag:"Tag", inputElement: ref(None)}, 

  reducer: (action) => 
    switch (action){
    | Submit(newTitle, newText, newTag) => 
      Js.Promise.(
        Axios.postData("/post", {{"user_id": "", "title": newTitle, "text": newText, "tag":newTag}})
        |> then_((response) => resolve(Js.log(response##data)))
        |> catch((error) => resolve(Js.log(error)))
        |> ignore
      );(
        state => 
       ReasonReact.Update ({...state, title: "Post made!", text:"", tag:""})
     )
    | ChangeTitle(newTitle) => Js.log(newTitle);(
         state => 
        ReasonReact.Update ({...state, title: newTitle})
      )
    | ChangeTag(newTag) => Js.log(newTag);(
         state => 
        ReasonReact.Update ({...state, tag: newTag})
      )
    | ChangeText(newText) => Js.log(newText);(
         state => 
        ReasonReact.Update ({...state, text: newText})
      )
    },

  render: ({state: {title, text, tag}, send, handle}) => {
  <div> 

    <div>
    (ReasonReact.stringToElement("Create a new post"))
    </div>

    <div> 
    <input
      value=title
      _type="text"
      ref=(handle(setInputElement))

      onChange = (
          (evt) =>
            send(
                ChangeTitle(
                    valueFromEvent(evt)
                ),
            )
        )
    />

    <input
      value=text
      _type="text"
      ref=(handle(setInputElement))

      onChange = (
          (evt) =>
            send(
                ChangeText(
                    valueFromEvent(evt)
                ),
            )
        )
    />

    <input
      value=tag
      _type="text"
      ref=(handle(setInputElement))

      onChange = (
          (evt) =>
            send(
                ChangeTag(
                    valueFromEvent(evt)
                ),
            )
        )
    />

    <button onClick=(_event => send(Submit(title, text, tag)))> 
        (ReasonReact.stringToElement("Submit"))
    </button>

    </div>
   </div>;
  },
}; 

/* onKeyDown=(
          (evt) =>
          if (ReactEventRe.Keyboard.key(evt) == "Enter") {
          send(Submit(text))
        } 
      ) */

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