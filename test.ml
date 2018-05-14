open OUnit2
open Post
open Comment
open Tag

let post1 = post_from_params 431 50 "test" "this is a test" false None "coolguy42" [] "testtag" 1526275325.
let comment1 = comment_from_params 1000 (-8) "wow i like your test" "coolguy43" [] 431
let post2 = post_from_params 431 51 "test" "this is a test" false None "coolguy42" [] "testtag" 1526275325.
let post3 = post_from_params 431 49 "test" "this is a test" false None "coolguy42" [] "testtag" 1526275325.
let post4 = post_from_params 431 50 "test" "this is a test" false None "coolguy42" [comment1] "testtag" 1526275325.
let post5 = post_from_params 431 (-10) "test" "this is a test" false None "coolguy42" [] "testtag" 1526275325.
let comment2 = comment_from_params 1000 (-7) "wow i like your test" "coolguy43" [] 431
let comment3 = comment_from_params 1000 (-9) "wow i like your test" "coolguy43" [] 431
let comment4 = comment_from_params 1001 (4) "i agree nice test bro" "coolguy44" [] 1000
let comment5 = comment_from_params 1000 (-8) "wow i like your test" "coolguy43" [comment4] 431


let tests =
  [
    "post1 id" >:: (fun _ -> assert_equal 432 (Post.get_id post1));
    "post1 score" >:: (fun _ -> assert_equal 50 (Post.get_score post1));
    "post1 title" >:: (fun _ -> assert_equal "test" (Post.get_title post1));
    "post1 text" >:: (fun _ -> assert_equal "this is a test" (Post.get_text post1));
    "post1 tag" >:: (fun _ -> assert_equal "testtag" (Post.get_tag post1));
    "post1 score up-cameled" >:: (fun _ -> assert_equal post2 (Post.up_camel post1));
    "post1 score down-cameled" >:: (fun _ -> assert_equal post3 (Post.down_camel post1));
    "post1 add reply" >:: (fun _ -> assert_equal post4 (Post.add_reply post1 comment1));
    "post4 children" >:: (fun _ -> assert_equal [comment1] (Post.get_children post4));
    "post4 # of children" >:: (fun _ -> assert_equal 1 (List.length (Post.get_children post4)));
    "post1 hot score" >:: (fun _ -> assert_equal 209 (Post.get_hot_score post1));
    "post5 neg hot score" >:: (fun _ -> assert_equal (-207) (Post.get_hot_score post5));
    "comment1 id" >:: (fun _ -> assert_equal 1000 (Comment.get_id comment1));
    "comment1 neg score" >:: (fun _ -> assert_equal (-8) (Comment.get_score comment1));
    "comment1 text" >:: (fun _ -> assert_equal "wow i like your test" (Comment.get_text comment1));
    "comment1 children" >:: (fun _ -> assert_equal [] (Comment.get_children comment1));
    "comment1 par id" >:: (fun _ -> assert_equal 431 (Comment.get_par comment1));
    "comment1 score up-cameled" >:: (fun _ -> assert_equal comment2 (Comment.up_camel comment1));
    "comment1 score down-cameled" >:: (fun _ -> assert_equal comment3 (Comment.down_camel comment1));
    "comment1 add reply" >:: (fun _ -> assert_equal comment5 (Comment.add_reply comment1 comment1));
    "comment5 children" >:: (fun _ -> assert_equal [comment4] (Comment.get_children comment5));
  ]

let suite =
  "Adventure test suite"
  >::: tests

let _ = run_test_tt_main suite
  