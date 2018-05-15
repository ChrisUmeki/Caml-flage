open OUnit2
open Post
open Comment
open Tag
open Ezjsonm

let post1 = post_from_params 431 50 "test" "this is a test" false None "coolguy42" [] "testtag" 1526275325.
let comment1 = comment_from_params 1000 (-8) "wow i like your test" "coolguy43" [] 431 431 true
let comment2 = comment_from_params 1001 (-2) "this is the greatest comment on earth" "coolgirl18" [] 431 431 true
let post2 = post_from_params 431 51 "test" "this is a test" false None "coolguy42" [] "testtag" 1526275325.
let post3 = post_from_params 431 49 "test" "this is a test" false None "coolguy42" [] "testtag" 1526275325.
let post4 = post_from_params 431 50 "test" "this is a test" false None "coolguy42" [comment1] "testtag" 1526275325.
let post5 = post_from_params 431 (-10) "test" "this is a test" false None "coolguy42" [] "testtag" 1526275325.
let comment3 = comment_from_params 1000 (-9) "wow i like your test" "coolguy43" [] 431 431 true
let commentnested = comment_from_params 1009 (4) "the nicest" "coolguy45" [] (-1) 1002 false
let comment4 = comment_from_params 1002 (4) "i agree nice test bro" "coolguy44" [commentnested] (-1) 1000 false
let comment5 = comment_from_params 1000 (-8) "wow i like your test" "coolguy43" [comment4] 431 431 true
let comment6 = comment_from_params 1003 (2) "woah" "dogluvr2" [] 431 431 true
let comment7 = comment_from_params 1004 (0) "what a nice post" "niceman88" [] 431 431 true
let post6 = post_from_params 432 50 "test" "this is a test" false None "coolguy42" [] "testtag" (1526275325. -. 604800.)
let post7 = post_from_params 431 50 "test" "this is a test" false None "coolguy42" [comment5; comment6; comment7] "testtag" 1526275325.
let tag1 = tag_from_params "hi" [(ref post1); (ref post2)]
let tag2 = empty "hi"
let tag3 = tag_from_params "bye" []
let unit = add_post tag2 post3
let unit1 = Post.up_camel post4
let unit2 = Post.down_camel post5 
let unit3 = Post.add_reply post2 comment2 
let unit4 = Comment.up_camel comment4 
let unit5 = Comment.down_camel comment5 
let unit6 = Comment.add_reply comment5 comment3
let json = `String ("savedstate.json")

let json1 = [("post_id", `Float (431.));
  ("score", `Float (50.));
  ("title", `String "test"); 
  ("text", `String "this is a test"); 
  ("has_url", `Bool false); 
  ("url", `Null ); 
  ("user", `String ("coolguy42")); 
  ("children", `A []); 
  ("tag", `String "testtag"); 
  ("timestamp", `Float 1526275325.);]

let json2 = [("post_id", `Float (431.));
  ("title", `String "test"); 
  ("text", `String "this is a test");
  ("score", `Float (51.));
  ("num_comments", `Float 1.);
  ("tag", `String "testtag")]

let tests =
  [
    "post1 id" >:: (fun _ -> assert_equal 431 (Post.get_id post1));
    "post1 score" >:: (fun _ -> assert_equal 50 (Post.get_score post1));
    "post1 title" >:: (fun _ -> assert_equal "test" (Post.get_title post1));
    "post1 text" >:: (fun _ -> assert_equal "this is a test" (Post.get_text post1));
    "post2 text" >:: (fun _ -> assert_equal "this is a test" (Post.get_text post2));
    "post1 tag" >:: (fun _ -> assert_equal "testtag" (Post.get_tag post1));
    "post1 score up-cameled" >:: (fun _ -> assert_equal 51 (Post.get_score post4));
    "post1 score down-cameled" >:: (fun _ -> assert_equal (-11) (Post.get_score post5));
    "post1 add reply" >:: (fun _ -> assert_equal [comment2] (Post.get_children post2));
    "post4 # of children" >:: (fun _ -> assert_equal 1 (List.length (Post.get_children post4)));
    "post1 timestamp" >:: (fun _ -> assert_equal 1526275325. (Post.get_timestamp post1));
    "post1 get hot score" >:: (fun _ -> assert_equal 209 (Post.get_hot_score post1));    (* These two tests demonstrate how different scores *)
    "post5 get hot score" >:: (fun _ -> assert_equal (-207) (Post.get_hot_score post5)); (* but same time posted affect hot score. *)
    "post6 get hot score" >:: (fun _ -> assert_equal 196 (Post.get_hot_score post6));    (* This one, compared to post1 get hot score, is posted a week before. *)
    "post 1 to json" >:: (fun _ -> assert_equal json1 (Post.to_json post1));
    "post 2 front json" >:: (fun _ -> assert_equal json2 (Post.to_json_front post2));
    "comment1 id" >:: (fun _ -> assert_equal 1000 (Comment.get_id comment1));
    "comment1 neg score" >:: (fun _ -> assert_equal (-8) (Comment.get_score comment1));
    "comment2 text" >:: (fun _ -> assert_equal "this is the greatest comment on earth" (Comment.get_text comment2));
    "comment1 text" >:: (fun _ -> assert_equal "wow i like your test" (Comment.get_text comment1));
    "comment1 children" >:: (fun _ -> assert_equal [] (Comment.get_children comment1));
    "comment1 par id" >:: (fun _ -> assert_equal 431 (Comment.get_par comment1));
    "comment1 post id" >:: (fun _ -> assert_equal 431 (Comment.get_post_id comment1));
    "comment1 par is post" >:: (fun _ -> assert_equal true (Comment.par_is_post comment1));
    "comment4 par is post" >:: (fun _ -> assert_equal false (Comment.par_is_post comment4));
    "comment2 par id" >:: (fun _ -> assert_equal 431 (Comment.get_par comment2));
    "comment4 par id" >:: (fun _ -> assert_equal 1000 (Comment.get_par comment4));
    "comment1 score up-cameled" >:: (fun _ -> assert_equal 5 (Comment.get_score comment4));
    "comment1 score down-cameled" >:: (fun _ -> assert_equal (-9) (Comment.get_score comment5));
    "comment1 add reply" >:: (fun _ -> assert_equal [comment3; comment4] (Comment.get_children comment5));
    "tag01" >:: (fun _ -> assert_equal "hi" (Tag.tag_name tag1));
    "tag02" >:: (fun _ -> assert_equal [] (Tag.posts_list tag3));
    "tag03" >:: (fun _ -> assert_equal [post1;post2] (Tag.posts_list tag1));
    "tag04" >:: (fun _ -> assert_equal [post3] (Tag.posts_list tag2));
    "DFS post7 1000" >:: (fun _ -> assert_equal comment5 (Post.find_comment 1000 post7));
    "DFS post7 1003" >:: (fun _ -> assert_equal comment6 (Post.find_comment 1003 post7));
    "DFS post7 1004" >:: (fun _ -> assert_equal comment7 (Post.find_comment 1004 post7));
    "DFS post7 1002 (nested)" >:: (fun _ -> assert_equal comment4 (Post.find_comment 1002 post7));
    "DFS post7 1009 (2 nested)" >:: (fun _ -> assert_equal commentnested (Post.find_comment 1009 post7));
  ]

let suite =
  "Caml-flage test suite"
  >::: tests

let _ = run_test_tt_main suite
  