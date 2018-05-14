/* This page displays one tag as a link */ 

let component = ReasonReact.statelessComponent("Tag");

/* message and children are props. `children` isn't used, therefore ignored.
    We ignore it by prepending it with an underscore */
let make = (~tag, _children) => {
  /* spread the other default fields of component here and override a few */
  ...component,

  render: self => {
      <div> 
        <a className = "taglink" href = {"/tag/" ++ tag ++ "/"}>
            (ReasonReact.stringToElement("#" ++ tag))
        </a> 
      </div>
  },
}; 