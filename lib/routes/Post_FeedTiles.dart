import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exchangeit/models/Colors.dart';
import 'package:exchangeit/models/Styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../Objects/NewPostClass.dart';

class FeedpostTile extends StatefulWidget {
  final UserPost post;
  final VoidCallback delete;
  final VoidCallback like;
  bool searched;
  FeedpostTile(
      {required this.post,
      required this.delete,
      required this.like,
      required this.searched});

  @override
  State<FeedpostTile> createState() => _FeedpostTileState();
}

class _FeedpostTileState extends State<FeedpostTile> {
  final _currentuser = FirebaseAuth.instance.currentUser;
  bool liked_already = false;
  Future<bool> PostalreadyLiked() async {
    DocumentSnapshot liked = await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.post.owner)
        .collection('posts')
        .doc(widget.post.postId)
        .get();
    DocumentSnapshot userinfos = await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.post.owner)
        .get();
    Postusername = userinfos['username'];
    location = liked.get('location');
    List<dynamic> listOfLikes = [];
    listOfLikes = liked.get('likedBy');
    if (listOfLikes.contains(_currentuser!.uid)) {
      return true;
    }
    return false;
  }

  Future<bool> LikeButtonTapped(context, bool isLiked, post) async {
    bool getliked = false;

    DocumentSnapshot liked = await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.post.owner)
        .collection('posts')
        .doc(widget.post.postId)
        .get();

    List<dynamic> listOfLikes = [];

    listOfLikes = liked.get('likedBy');

    if (isLiked == false) {
      listOfLikes.add(_currentuser!.uid);

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.post.owner)
          .collection('posts')
          .doc(widget.post.postId)
          .update({
        'likeCount': widget.post.likeCount + 1,
        'likedBy': listOfLikes,
      }).then((value) => getliked = true);

      setState(() {
        post.likeCount = post.likeCount + 1;
      });

      DocumentSnapshot info = await FirebaseFirestore.instance
          .collection('Users')
          .doc(_currentuser!.uid)
          .get();
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.post.owner)
          .collection('notifications')
          .add({
        'message': 'You received a like from ${info['username']}!',
        'datetime': DateTime.now(),
        'url': widget.post.image_url,
        'uid': _currentuser!.uid,
        'follow_request': 'no',
      });

      return getliked;
    } else {
      listOfLikes.remove(_currentuser!.uid);

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.post.owner)
          .collection('posts')
          .doc(widget.post.postId)
          .update({
        'likeCount': widget.post.likeCount - 1,
        'likedBy': listOfLikes,
      }).then((value) => getliked = false);

      setState(() {
        post.likeCount = post.likeCount - 1;
      });

      return getliked;
    }
  }

  Future<void> report(UserPost post) async {
    //yapamadım
  }
  String location = '';
  String Postusername = "";
  @override
  Widget build(BuildContext context) {
    if (widget.post.image_url != '') {
      return FutureBuilder(
          future: PostalreadyLiked().then((value) => liked_already = value),
          builder: (context, snapshot) {
            return GestureDetector(
              onTap: () {},
              child: Card(
                margin: EdgeInsets.all(10),
                color: AppColors.appBarColor,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(widget.post.image_url,
                            height: 150, width: 150, fit: BoxFit.cover),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  Postusername,
                                  style: AppStyles.profileTextName,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(widget.post.date,
                                    style: AppStyles.profileText),
                                //SizedBox(width :5),
                                SizedBox.shrink(),
                                IconButton(
                                  alignment: Alignment.center,
                                  onPressed: () => report(widget.post),
                                  iconSize: 20,
                                  splashRadius: 24,
                                  color: AppColors.postTextColor,
                                  icon: Icon(
                                    Icons.report,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(location, style: AppStyles.postLocation),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 10),
                                    Text(
                                      widget.post.text,
                                      style: AppStyles.postText,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LikeButton(
                                      isLiked: liked_already,
                                      onTap: (isLiked) {
                                        return LikeButtonTapped(context,
                                            liked_already, widget.post);
                                      },
                                    ),
                                    SizedBox(width: 5),
                                    Text('${widget.post.likeCount}',
                                        style: AppStyles.postText),
                                    SizedBox(width: 15),
                                    Icon(Icons.chat_bubble_outline,
                                        color: AppColors.postTextColor),
                                    SizedBox(width: 5),
                                    Text('${widget.post.commentCount}',
                                        style: AppStyles.postText),
                                    SizedBox(width: 5),
                                    SizedBox(height: 45),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            );
          });
    } else {
      return FutureBuilder(
          future: PostalreadyLiked().then((result) => liked_already = result),
          builder: (context, snapshot) {
            //print(widget.post.text);
            //print(liked_already);
            return GestureDetector(
              onTap: () {},
              child: Card(
                margin: EdgeInsets.all(10),
                color: AppColors.postBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                Postusername,
                                style: AppStyles.profileTextName,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(widget.post.date, style: AppStyles.postText),
                              //SizedBox(width :5),
                              SizedBox.shrink(),
                              IconButton(
                                alignment: Alignment.center,
                                onPressed: () => report(widget.post),
                                iconSize: 20,
                                splashRadius: 24,
                                color: AppColors.postTextColor,
                                icon: Icon(
                                  Icons.report,
                                ),
                              ),
                            ],
                          ),
                          Text(location, style: AppStyles.postLocation),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              SizedBox(width: 10),
                              Text(
                                widget.post.text,
                                style: AppStyles.postText,
                                overflow: TextOverflow.fade,
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LikeButton(
                                isLiked: liked_already,
                                onTap: (isLiked) {
                                  return LikeButtonTapped(
                                      context, liked_already, widget.post);
                                },
                              ),
                              SizedBox(width: 5),
                              Text('${widget.post.likeCount}',
                                  style: AppStyles.postText),
                              SizedBox(width: 15),
                              Icon(Icons.chat_bubble_outline,
                                  color: AppColors.postTextColor),
                              SizedBox(width: 5),
                              Text('${widget.post.commentCount}',
                                  style: AppStyles.postText),
                              SizedBox(width: 5),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }
}
