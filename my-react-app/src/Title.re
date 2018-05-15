/* Title.re renders any titles that are displayed on the webpage */
let component = ReasonReact.statelessComponent("Page");

let handleClick = (_event, _self) => Js.log("clicked!");
   
let make = (~message, _children) => {
  ...component,
  render: self =>
    <div style = (ReactDOMRe.Style.make(~color = "#00000", ~fontSize = "68px", ~textAlign =  "center", () )) onClick=(self.handle(handleClick))>
      (ReasonReact.stringToElement(message))
    </div>,
};
