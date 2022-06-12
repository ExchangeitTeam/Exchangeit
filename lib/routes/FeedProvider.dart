import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exchangeit/models/Colors.dart';
import 'package:exchangeit/models/Styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../Objects/NewPostClass.dart';

class FeedProvider extends StatefulWidget {
  final UserPost post;
  final VoidCallback delete;
  final VoidCallback like;
  bool searched;
  FeedProvider(
      {required this.post,
      required this.delete,
      required this.like,
      required this.searched});

  @override
  State<FeedProvider> createState() => _FeedProviderState();
}

class _FeedProviderState extends State<FeedProvider> {
  final _currentuser = FirebaseAuth.instance.currentUser;
  bool Isliked = false;
  Future<bool> PostalreadyLiked() async {
    DocumentSnapshot liked = await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.post.postownerID)
        .collection('posts')
        .doc(widget.post.postId)
        .get();
    DocumentSnapshot userinfos = await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.post.postownerID)
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
        .doc(widget.post.postownerID)
        .collection('posts')
        .doc(widget.post.postId)
        .get();

    List<dynamic> listOfLikes = [];

    listOfLikes = liked.get('likedBy');

    if (isLiked == false) {
      listOfLikes.add(_currentuser!.uid);

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.post.postownerID)
          .collection('posts')
          .doc(widget.post.postId)
          .update({
        'totalLike': widget.post.totalLike + 1,
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
          .doc(widget.post.postownerID)
          .collection('notifications')
          .add({
        'message': 'You received a like from ${info['username']}!',
        'datetime': DateTime.now(),
        'url': widget.post.imageurl,
        'uid': _currentuser!.uid,
        'follow_request': 'no',
      });

      return getliked;
    } else {
      listOfLikes.remove(_currentuser!.uid);

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.post.postownerID)
          .collection('posts')
          .doc(widget.post.postId)
          .update({
        'totalLike': widget.post.totalLike - 1,
        'likedBy': listOfLikes,
      }).then((value) => getliked = false);

      setState(() {
        post.likeCount = post.likeCount - 1;
      });

      return getliked;
    }
  }

  String location = '';
  String Postusername = "";
  @override
  Widget build(BuildContext context) {
    if (widget.post.imageurl != '') {
      return FutureBuilder(
          future: PostalreadyLiked().then((value) => Isliked = value),
          builder: (context, snapshot) {
            return InkWell(
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
                        Image.network(widget.post.imageurl,
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
                                      widget.post.content,
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
                                      isLiked: Isliked,
                                      onTap: (isLiked) {
                                        return LikeButtonTapped(
                                            context, Isliked, widget.post);
                                      },
                                    ),
                                    SizedBox(width: 5),
                                    Text('${widget.post.totalLike}',
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
          future: PostalreadyLiked().then((result) => Isliked = result),
          builder: (context, snapshot) {
            return InkWell(
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
                            ],
                          ),
                          Text(location, style: AppStyles.postLocation),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              SizedBox(width: 10),
                              Text(
                                widget.post.content,
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
                                isLiked: Isliked,
                                onTap: (isLiked) {
                                  return LikeButtonTapped(
                                      context, Isliked, widget.post);
                                },
                              ),
                              SizedBox(width: 5),
                              Text('${widget.post.totalLike}',
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
