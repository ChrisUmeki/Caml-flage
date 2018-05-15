# Prototype Status: Caml-flage
## Authors
Arzu Mammadova (am2692),
Shea Murphy (sm967),
Chris Umeki (ctu3),
Mena Wang (mw749)

## System Description (Milestone 0 and 1)
Caml-flage is a social networking platform that, as its title suggests, allows users to interact with each other anonymously. People start out as anonymous users and are able to post text, links, and photos, and interact with each other on a public dashboard. Users tag posts with different topics to categorize discussions. Each post and reply will have three camel-shaped buttons - up-camel (like), down-camel (dislike), and double-camel (direct reply) - thereby enabling users to react to one another’s posts. 

Each account has a “points” accumulator initially set to 0. Once a direct conversation starts between two users, they will both have an interaction score that increases with each reply. Once the score reaches a certain number, the two users will no longer be anonymous to each other. That is, both of the users identities will be exposed and each user will now be able to see the other’s personal profile, i.e. text, photos, etc.

## System Design 
### server.ml
The server module stores all the data that is necessary for the platform to operate including data on each user, posts, comments, and tags. Each individual data group will have another module of their own, detailed below. 
### user.ml
The users module will be responsible for keeping track of data related to the user-- such as the username, their posts, as well as a list of users which they’ve surpassed the interaction score threshold. In addition, the users module will store a hashtable of interaction scores between specific users. 

This information will be kept in a record for each individual user, whereas the data of all the users on the server are the individual records stored in a tree.
### post.ml
Posts are top level entries.

The type defined for a post will include the list of comments associated with a post, which will be implemented as a list of linked lists, a relevance score, determined by the number of up-camels and down-camels, content(text, images,etc.), id of the post, and the date and time the post was published.
### comment.ml
Comments are replies to posts or other comments. 
The type defined for a comment will be similar to posts. Major differences between the two types would be that comments are linked back to the parent entry, and posts have a title as well as content.

Similar to posts, comments will also store the list of comments/replies, a relevance score determined by the number of up-camels and down-camels, as well as the date and time that the comment was posted. 
### tags.ml
Tags are a way for users to categorize their posts as well as to find posts pertaining to a certain topic. Each tag is defined as a string which is the name of the tag as well as the posts that are linked to the tag. 

## Data
Most of our data will be stored in records and lists of records. In addition, we will be using a hash table to store the interaction score between users. 

We are using Ezjsonm to store all of our information in order to maintain the server. 

In terms of communication, we will be using HTTP GET and POST requests. GET requests will be used to return the contents of the webpage-- it is functional because it doesn’t change the state of the server.

## External Dependencies
### Opium
Opium will allow us to maintain the web application, handle HTTP requests, and interact with databases that contain all the users’ and posts’ information. 
### ReasonReact
Our goal is to display all the posts on the server onto an actual webpage. We will use ReasonReact to build the frontend (display of the webpage and user interface) of this project.
### Ezjsonm
We will use Ezjsonm to store the data of users, posts, comments, and tags-- this will ensure that data already stored on the server can be saved for future sessions when the server quits.
### Bucklescript
#### bs-json
 bs-json allows ReasonReact to parse the data sent to us from the server and display it on the page. 
#### bs-axios
We are mainly using bs-axios to handle POST requests-- after the client manipulates the data (for example the number of up-camels and down-camels), bs-axios sends these changes to the state to the server. 

## Testing
Because we have many records and record lists that are used to store data, we will be unit testing all the functions that change the records to make sure data is being stored correctly. Module tests will be written for each of the module listed above. In addition, we will be testing the server requests to ensure that data is being processed correctly and that the webpage functions the way we want. These tests will be more interactive instead of in modules and unit testing. 

Depending on how we split up the modules and coding, each person will be responsible for unit testing their own modules since they’ll be most familiar with how their code should function (this mostly includes the functions that will not be in the .mli). Once we begin implementing the front end portion of the project, everybody is responsible for testing the interactive elements on the webpage.
 
## Status (Milestone 2)
### Frontend
Using ReasonReact, we have built everything related to the display of post and comments. The front page is a list of all the posts -- each post has a title, text, and score displayed. There are up-camels and down-camel buttons associated with each post that can increase or decrease the score. To display the posts, we are extracting the necessary information from a json sent to us from the server. 

When the user clicks on the title of a post, it will redirect them to a separate page where only the post they clicked on and its associated comments are displayed. Each comment also has up-camel and down-camel buttons; the main difference is that comments do not have titles. 

In addition, we implemented input fields where users can write a post. Pressing the submit button sends the data to the server to be stored, and by refreshing the page, the new post will appear at the bottom. As of now, comments also do not have “children”, i.e. users cannot leave comments under comments. We might change that in our final submission. 
### Server
Server loads state from json and begins listening on port 3000. It catches GET requests to http://localhost:3000 and displays the front page posts. It displays post x and the comments of post x at http://localhost:3000/post/x/ where x is an int corresponding to the post_id of post. Data is sent in json to respond to GET requests to http://localhost:3000/state.json and http://localhost:3000/post/x/poststate.json.

The server also catches POST requests to receive json data for new votes and posts, and updates state accordingly. The server can save state to json, the command for which is currently mapped to http://localhost:3000/savethestate, which also displays the json being saved.
### Running the server
In order to start the server: 
``` bash
$ opam install opium ezjsonm
$ make server
```
## Roadmap
We have yet to implement the ranking of the posts on the dashboard, according to their net score (the sum of up-camels and down-camels). To do that, we plan to implement a sorting algorithm similar to the one used by Reddit. 

For the implementation of tags, we will simply add a hoverable dropdown menu under the Tags button on the navigation bar, which will contain a list of various topics (similar to trends on Twitter). Each topic will redirect users to a separate page, where only the posts with the same title as the topic are displayed. (It will be implemented similarly to the way we implemented comments.)

One of our biggest goals will be to implement user authentication and keeping track of what each user posts. We are still researching ways on how to accomplish this most effectively but once that is figured out, we will store user information in a json, similar to the way we have been keeping track of information for posts and comments. 

In addition, we want to come up with an algorithm that calculates the interaction scores of any two users and stores them in a hashmap. We will then implement a function that looks up the interaction score of any two users in the hashmap. Functions score_calculator and interaction_score in user.ml will perform the above-mentioned tasks. 
## Testing
Almost all of our testing have been interactive so far. By displaying elements on the page, we are able to see clearly if something is not working properly-- for example, if a newly created post is missing or a click of a button doesn’t change the score, it is obvious that there is something we need to fix. 

The json that we are storing can be viewed at /state.json. If something is not displaying correctly, we can also check here if the json is updating the way we intended it to. 

Printing logs into the console has also helped us during testing (in addition to error-handling) to track which functions are being used and whether or not it is processing data correctly. 
