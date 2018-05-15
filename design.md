# Caml-flage Design Document
#### Arzu Mammadova | am2692 \\ Shea Murphy | sm967 \\ Chris Umeki | ctu3 \\ Mena Wang | mw749


## System Description
Caml-flage is a social networking platform that, as its title suggests, allows users to interact with each other anonymously. People start out as anonymous users and are able to post text, links, and photos, and interact with each other on a public dashboard. Users tag posts with different topics to categorize discussions. Each post and reply will have three camel-shaped buttons - up-camel (like), down-camel (dislike), and double-camel (direct reply) - thereby enabling users to react to one another’s posts. 

Each account has a “points” accumulator initially set to 0. Once a direct conversation starts between two users, they will both have an interaction score that increases with each reply. Once the score reaches a certain number, the two users will no longer be anonymous to each other. That is, both of the users identities will be exposed and each user will now be able to see the other’s personal profile, i.e. text, photos, etc. 

## System Design

### server.ml
The server module stores all the data that is necessary for the platform to operate including data on each user, posts, comments, and tags. Each individual data group will have another module of their own, detailed below. 

We are still investigating the uses of our external libraries and how to connect the data and the server. Therefore, we will be adding more functions to server.mli later on. 

### users.ml
The users module will be responsible for keeping track of data related to the user-- such as the username, their posts, as well as a list of users which they’ve surpassed the interaction score threshold. In addition, the users module will store a hashtable of interaction scores between specific users. 

This information will be kept in a record for each individual user, whereas the data of all the users on the server are the individual records stored in a tree. 


### post.ml 
Posts are top level entries posted by the users, that are displayed on the dashboard. 

The type defined for a post is a record with fields that store the id, score (determined by the sum of total up-camels and down-camels), title, text, user, url, tag, list of comments associated with a post, as well as the time the post was published. 

The posts module contains the key functions for creating post given the needed arguments, accessing the fields of a post, calculating the "hot score" that is assigned to a post for sorting, as well as functions that extract post data to a json.

### comment.ml 
Comments are replies to posts or comments. 

The type defined for a comment is similar to posts. It is a record with fields that store the id, score, title, text, user, url, the id of a post under which the comment was added and the parent comment id, if the comment was added under another comment.

The comments module contains the key functions for creating a comment given the needed arguments, accessing the fields of a comment and functions that extract comment data to a json.

Besides the differences in some fields, major differences between posts and comments include that comments are linked back to a parent entry, and that comments are not sorted.

### tags.ml
Tags are a way for users to categorize their posts as well as to find posts pertaining to a certain topic. Each tag is defined as a record with two fields: a string which is the name of the tag as well as the mutable posts field that contains a list of posts associated with a a tag. 

## Data

Most of our data will be stored in records and lists of records. In addition, we will be using a hash table to store the interaction score between users. 

We are using Yojson to store all of our information in order to maintain the server. 

In terms of communication, we will be using HTTP GET and POST requests. GET requests will be used to return the contents of the webpage-- it is functional because it doesn’t change the state of the server.

## External Dependencies

### Opium
Opium will allow us to maintain the web application, handle HTTP requests, and interact with databases that contain all the users’ and posts’ information. 

```
$ opam install opium
```

### ReasonReact
Our goal is to display all the posts on the server onto an actual webpage. We will use ReasonReact to build the frontend (display of the webpage and user interface) of this project.

### Ezjsonm
We will use Ezjsonm to store the data of users, posts, comments, and tags-- this will ensure that data already stored on the server will not be lost. 

## Testing

Because we have many records and record lists that are used to store data, we will be unit testing all the functions that change the records to make sure data is being stored correctly. Module tests will be written for each of the module listed above. In addition, we will be testing the server requests to ensure that data is being processed correctly and that the webpage functions the way we want. These tests will be more interactive instead of in modules and unit testing. 

Depending on how we split up the modules and coding, each person will be responsible for unit testing their own modules since they’ll be most familiar with how their code should function (this mostly includes the functions that will not be in the .mli). Once we begin implementing the front end portion of the project, everybody is responsible for testing the interactive elements on the webpage. 

## Testing functions in .ml files 

We added unit tests for functions in post.ml and comment.ml that create posts and comments given corresponding arguments, functions that get the id, score, title, children, tags and timestamp (for posts only), add replies, and calculate the hot score assigned to each post for sorting purposes. We also created json values to test the functions that extract post and comment data to json. In addition, we tested tag.ml functions that create tags, access tag name and the list of posts associated with a tag. 



## Division of Labor

Shea: I mostly worked on backend .ml files like post, comment, tag, and server + server_state. I implemented some of the functions in all of these files, wrote a lot of the specifications, and did a lot of the unit testing for these files as well. I also did a lot of research about various sorting algorithms, and ended up deciding to implement a slightly modified version of reddit's previous hot score algorithm for posts. I have also helped with interactive testing and writing the design documentation. 


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



