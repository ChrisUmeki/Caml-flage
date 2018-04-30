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
      | Submit(newText) => 
        Js.Promise.(
          Axios.postData("/comment", {{"text": newText}})
          |> then_((response) => resolve(Js.log(response##data)))
          |> catch((error) => resolve(Js.log(error)))
          |> ignore
        );(
          state => 
         ReasonReact.Update ({...state, text:"Comment made!"})
       )
      | Change(newText) => Js.log(newText);(
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
      (ReasonReact.stringToElement("new comment"))
      </div>
  
      <div> 
      <input
        value=text
        _type="text"
        ref=(handle(setInputElement))
        placeholder="Write a comment"

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