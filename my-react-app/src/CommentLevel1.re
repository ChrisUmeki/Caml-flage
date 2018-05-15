/* CommentLevel1.re displays nested comments on level 1 */ 
type state = {
    count: int,
  };

type action =
  | Upvote
  | Downvote;
  
let component = ReasonReact.reducerComponent("CommentLevel1");


let rec make = (~text, ~score, ~comment_id, ~nestedcomments, _children) => {

  ...component,

  initialState: () => {count: score},

  /* State transitions */
  reducer: (action, state) =>
    switch (action) {
    | Upvote => 
      Js.Promise.(
      Axios.postData("/vote", {{"direction": "up", "user_id": 0, "comment_id": comment_id, "entry_type": "comment"}})
      |> then_((response) => resolve(Js.log(response##data)))
      |> catch((error) => resolve(Js.log(error)))
      |> ignore
    );
    ReasonReact.Update({...state, count: state.count + 1});

    | Downvote => 
    Js.Promise.(
      Axios.postData("/vote", {{"direction": "down", "user_id": 0, "comment_id": comment_id, "entry_type": "comment"}})
      |> then_((response) => resolve(Js.log(response##data)))
      |> catch((error) => resolve(Js.log(error)))
      |> ignore
    );
    ReasonReact.Update({...state, count: state.count - 1});
    },

  render: self => {
    let up ="UpCaml";
    let down = "DownCaml";
    let count = string_of_int(self.state.count);
    <div>
       /* nested comment */ 
      <div className="nested1">
        <div className = "gr">
          <p>(ReasonReact.stringToElement(text))</p>
        </div>

        <div className="comment-buttons">
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
        
      </div>

    </div>;
  },
}; 