import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exchangeit/models/Colors.dart';
import 'package:exchangeit/models/Styles.dart';
import 'package:exchangeit/routes/post_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    DocumentSnapshot CurrentPost = await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.post.postownerID)
        .collection('posts')
        .doc(widget.post.postId)
        .get();
    DocumentSnapshot DocSnapInfo = await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.post.postownerID)
        .get();
    Postusername = DocSnapInfo['username'];
    location = CurrentPost.get('location');
    List<dynamic> AllLikers = [];
    AllLikers = CurrentPost.get('likedBy');
    if (AllLikers.contains(_currentuser!.uid)) {
      return true;
    }
    return false;
  }

  Future<bool> LikeButtonTapped(context, bool isLiked, post) async {
    bool getliked = false;

    DocumentSnapshot DocSnapPost = await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.post.postownerID)
        .collection('posts')
        .doc(widget.post.postId)
        .get();

    List<dynamic> AllLikers = [];

    AllLikers = DocSnapPost.get('likedBy');

    if (isLiked == false) {
      AllLikers.add(_currentuser!.uid);

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.post.postownerID)
          .collection('posts')
          .doc(widget.post.postId)
          .update({
        'totalLike': widget.post.totalLike + 1,
        'likedBy': AllLikers,
      }).then((value) => getliked = true);

      setState(() {
        post.totalLike = post.totalLike + 1;
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
        'datetime': DateTime.now(),
        'notification': 'You get a like from ${info['username']}!',
        'Posturl': widget.post.imageurl,
        'uid': _currentuser!.uid,
        'IsfollowReq': 'no',
        'postId': widget.post.postId,
      });

      return getliked;
    } else {
      AllLikers.remove(_currentuser!.uid);

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.post.postownerID)
          .collection('posts')
          .doc(widget.post.postId)
          .update({
        'totalLike': widget.post.totalLike - 1,
        'likedBy': AllLikers,
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => postPageView(
                            pf: widget.post,
                            isPhoto: false,
                          )),
                );
              },
              child: Container(
                child: Card(
                  margin: EdgeInsets.all(10),
                  color: Colors.lightBlueAccent[100],
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(children: [
                      Row(
                        children: [
                          Text(
                            Postusername,
                            style: AppStyles.profileTextName,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Image.network(widget.post.imageurl,
                                height: 250, width: 350, fit: BoxFit.fill),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.post.date,
                            style: GoogleFonts.signika(
                              color: Colors.deepOrangeAccent,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          LikeButton(
                            circleColor: CircleColor(
                                start: const Color(0xFFFF5722),
                                end: const Color(0xFFFFC107)),
                            isLiked: Isliked,
                            onTap: (isLiked) {
                              return LikeButtonTapped(
                                  context, Isliked, widget.post);
                            },
                          ),
                          SizedBox(width: 5),
                          Text('${widget.post.totalLike}',
                              style: AppStyles.postText),
                          Spacer(),
                          Icon(Icons.insert_comment_outlined,
                              color: Colors.white),
                          SizedBox(width: 5),
                          Text('${widget.post.commentCount}',
                              style: AppStyles.postText),
                          Spacer(),
                          widget.searched == false
                              ? IconButton(
                                  padding: EdgeInsets.all(0),
                                  alignment: Alignment.center,
                                  onPressed: widget.delete,
                                  iconSize: 20,
                                  splashRadius: 20,
                                  color: Colors.white,
                                  icon: Icon(
                                    Icons.delete_outline,
                                  ),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 5),
                          Row(mainAxisSize: MainAxisSize.min, children: [
                            Column(
                              children: [
                                Container(
                                  child: Text(
                                    widget.post.content,
                                    style: AppStyles.WalkTextStyle,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                  color: Colors.white,
                                  padding: EdgeInsets.all(8),
                                ),
                              ],
                            ),
                          ]),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text("Location: $location",
                                style: AppStyles.postOwnerText),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              border:
                                  Border.all(color: Colors.green, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(50, 50)),
                            ),
                          ),
                          Spacer(),
                          Center(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Text(widget.post.topic,
                                  style: AppStyles.buttonText),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                border:
                                    Border.all(color: Colors.green, width: 2.0),
                                borderRadius: new BorderRadius.all(
                                    Radius.elliptical(50, 50)),
                              ),
                            ),
                          )
                        ],
                      )
                    ]),
                  ),
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
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            Postusername,
                            style: AppStyles.profileTextName,
                          ),
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
                ),
              ),
            );
          });
    }
  }
}
