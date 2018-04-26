
let component = ReasonReact.statelessComponent("AllPosts");

type state = {
  posts : list(string),
};

let make = (_children) => {
  ...component,
  render: (self) =>
    <div className="display">
      <Post greeting="HELLOOOO" />
      <Post greeting="HELLOOOO2" />
      <Post greeting="HELLOOOO3" />
      <Post greeting="HELLOOOO3" />
    </div>

};
