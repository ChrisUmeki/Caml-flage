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
   
  let make = (~parent_is_post, ~parent_id, ~post_id, ~initialText, _) => {
    ...component,
    initialState: () => {text:initialText, inputElement: ref(None)}, 
  
    reducer: (action) => 
      switch (action){
      | Submit(newText) => 
        Js.Promise.(
          Axios.postData("/comment", {
            {
              "user_id": "",
              "post_id": int_of_string(post_id),
              "text": newText,
              "parent_is_post": parent_is_post,
              "parent_comment_id": int_of_string(parent_id)
            }
          })
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

    <div> 
      <div>
      (ReasonReact.stringToElement("New comment"))
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

      <button onClick=(_event => send(Submit(text)))> 
        (ReasonReact.stringToElement("Submit"))
      </button>
      </div>
     </div>;
    },
  }; 