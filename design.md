# Caml-flage Design Document
#### Arzu Mammadova (am2692)  Shea Murphy (sm967) Chris Umeki (ctu3) Mena Wang (mw749)


## System Description
Caml-flage is a social networking platform that, as its title suggests, allows users to interact with each other anonymously. Anonymous users post text posts and reply to each other on a public dashboard. Users tag posts with different topics to categorize discussions. 

Each post and comment has three buttons - up-camel (like), down-camel (dislike), and comment (direct reply) - thereby enabling users to react to one another’s posts. 

## System Design

### Ocaml (.ml, .mli)

#### Server
The server module stores all the data that is necessary for the platform to operate including data on each user, posts, comments, and tags. Each individual data group will have another module of their own, detailed below. 


#### Post
Posts are top level entries posted by the users, that are displayed on the dashboard.

The type defined for a post is a record with fields that store the id, score (determined by the sum of total up-camels and down-camels), title, text, user, url, tag, list of comments associated with a post, as well as the time the post was published. 

The posts module contains the key functions for creating post given the needed arguments, accessing the fields of a post, calculating the "hot score" that is assigned to a post for sorting, as well as functions that extract post data to a json.

#### Comment
Comments are replies to posts or comments. 

Comments are defined similarly to posts. It is a record with fields that store the id, score, title, text, user, associated post id, the parent comment id, and whether the comment is a direct reply to a post. When the comment is a direct reply to a post, the parent_comment_id has no meaning.

The comments module contains the key functions for creating a comment from json, accessing the fields of a comment and functions that extract comment data to a json.

Besides the differences in some fields, major differences between posts and comments include that comments are linked back to a parent entry, and that comments are not sorted.

#### Tag
Tags are a way for users to categorize their posts as well as to find posts pertaining to a certain topic. Each tag is defined as a record with two fields: a string which is the name of the tag as well as the mutable posts field that contains a list of posts associated with a a tag.

### ReasonML (.re)

#### Index
Index is the entrypoint to determining which components to render.

#### Posts
##### AllPosts 
AllPosts renders all the posts that are received from the json. The json is parsed in PostsData and stored in a frontpost record. 

##### Post
Post renders one post component based on the data that was received from PostsData and AllPosts. This component includes buttons for Upcaml-ing, Downcaml-ing, and commenting on a post. When the score changes, the data is sent to the server using Axios. 

##### PostInput 
PostInput is the input field that users can type into to create a new post. This data is then sent to the server using Axios. 

#### Comments 
##### AllComments
AllComments renders all the comments that are received from the json. The json is parsed in CommentData and stored in a comment record. Comments are different from posts because they have fields which determine what parent post / comments they are nested under. 

##### Comment 
Comment renders one comment component based on the data that was received from CommentData and AllComments. Buttons rendered for a comment component are similar to a post component. 

##### CommentInput 
CommentInput is the input field that users can type into to create a new input. This data is sent to the server using Axios. It differs from a PostInput because it sends additional data storing the parent post or comment. 

#### Tags 
##### AllTags 
AllTags is the component that displays all the tags received by the server. This data is parsed from TagsData.

##### Tag 
Each Tag component is a link to a tag page that displays all the posts related to the tag. 

#### Title 
The title component is a stateless component that displays Caml-flage on every page. 

 

## Data

Most of our data will be stored in record types and lists of records.

We are using Ezjsonm to store all of our information in order to maintain the server. 

The server responds HTTP GET and POST requests. GET requests return the contents of the webpage-- it is functional because it doesn’t change the state of the server.

## External Dependencies

### Opium
We use Opium to maintain the web application and handle HTTP requests.

```
$ opam install opium
```

### ReasonReact
We use ReasonReact to build the frontend (display of the webpage and user interface) of this project.

### Ezjsonm
We use Ezjsonm to store the entire state of the server, and to store it to Json. In addition we use Ezjsonm to send and receive Json data from the client.

## Testing

Because we have many records and record lists that are used to store data, we will be unit testing all the functions that change the records to make sure data is being stored correctly. Module tests will be written for each of the module listed above. In addition, we will be testing the server requests to ensure that data is being processed correctly and that the webpage functions the way we want. These tests will be more interactive instead of in modules and unit testing. 

Depending on how we split up the modules and coding, each person will be responsible for unit testing their own modules since they’ll be most familiar with how their code should function (this mostly includes the functions that will not be in the .mli). Once we begin implementing the front end portion of the project, everybody is responsible for testing the interactive elements on the webpage. 

## Testing functions in .ml files 

We added unit tests for functions in post.ml and comment.ml that create posts and comments given corresponding arguments, functions that get the id, score, title, children, tags and timestamp (for posts only), add replies, and calculate the hot score assigned to each post for sorting purposes. We also created json values to test the functions that extract post and comment data to json. In addition, we tested tag.ml functions that create tags, access tag name and the list of posts associated with a tag. 



## Division of Labor

Shea: I mostly worked on backend .ml files like post, comment, tag, and server + server_state. I implemented some of the functions in all of these files, wrote a lot of the specifications, and did a lot of the unit testing for these files as well. I also did a lot of research about various sorting algorithms, and ended up deciding to implement a slightly modified version of reddit's previous hot score algorithm for posts. I have also helped with interactive testing and writing the design documentation. 

Mena: I worked mostly on frontend such as the displaying the posts, comments, and tags. This included parsing the data from the json files (sent to us from the server) and showing them on the appropriate pages. In addition, I worked on the functions that handled data on client side and sent the data to the server when certain buttons were pressed. 

Arzu: I mostly workd on fronted such as defining the type of posts and comments, parsing post/comment data from json by extracting the necessary fields and displaying them on the main page. I also worked on adding two options for sorting posts by defining a new variant and modifying functions in server.ml and server_state.ml. In addition, I built most of the html files with the necessary links and buttons and added styling using CSS. For testing, I added unit tests for some functions in .ml files.


## Sources used

### Reddit's Hot Post Score Algorithm:
reddit.com
https://medium.com/hacking-and-gonzo/how-reddit-ranking-algorithms-work-ef111e33d0d9

### ReasonReact:
general formatting:
https://jaredforsyth.com/posts/a-reason-react-tutorial/

toggle:
https://github.com/reasonml/reason-react/blob/master/docs/state-actions-reducer.md

input fields: 
https://github.com/reasonml-community/reason-react-example/blob/master/src/todomvc/TodoItem.re



