import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exchangeit/Objects/NewPostClass.dart';
import 'package:exchangeit/SettingsOptions/PostEdit.dart';
import 'package:exchangeit/models/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../models/Styles.dart';
import '../routes/post_page.dart';
import '../routes/profile_page_posts.dart';

class BaseDesingPost extends StatefulWidget {
  final UserPost post;
  final VoidCallback delete;
  final VoidCallback like;
  bool searched;

  BaseDesingPost(
      {required this.post,
      required this.delete,
      required this.like,
      required this.searched});
  @override
  State<BaseDesingPost> createState() => _BaseDesingPostState();
}

class _BaseDesingPostState extends State<BaseDesingPost> {
  @override
  void initState() {
    //setState(() {});
  }

  final _currentuser = FirebaseAuth.instance.currentUser;
  bool Isliked = false;
  bool there_is_image = true;
  String location = '';
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

    List<dynamic> allLike = [];

    allLike = liked.get('likedBy');

    if (isLiked == false) {
      allLike.add(_currentuser!.uid);

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.post.postownerID)
          .collection('posts')
          .doc(widget.post.postId)
          .update({
        'totalLike': widget.post.totalLike + 1,
        'likedBy': allLike,
      }).then((value) => getliked = true);

      setState(() {
        post.totalLike = post.totalLike + 1;
      });

      DocumentSnapshot Sender = await FirebaseFirestore.instance
          .collection('Users')
          .doc(_currentuser!.uid)
          .get();
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.post.postownerID)
          .collection('notifications')
          .add({
        'datetime': DateTime.now(),
        'notification': 'You get a like from ${Sender['username']}!',
        'Posturl': widget.post.imageurl,
        'uid': _currentuser!.uid,
        'IsfollowReq': 'no',
        'postId': widget.post.postId,
      });

      return getliked;
    } else {
      allLike.remove(_currentuser!.uid);

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.post.postownerID)
          .collection('posts')
          .doc(widget.post.postId)
          .update({
        'totalLike': widget.post.totalLike - 1,
        'likedBy': allLike,
      }).then((value) => getliked = false);

      setState(() {
        post.totalLike = post.totalLike - 1;
      });

      return getliked;
    }
  }

  String Postusername = "";
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (widget.post.imageurl != "") {
      return FutureBuilder(
        future: PostalreadyLiked().then((changer) => Isliked = changer),
        builder: (context, snapshot) {
          print(widget.post.imageurl);
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

           child: Card(
              shadowColor: Colors.grey,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.all(10),
              color: Colors.lightBlueAccent[100],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      child: Image.network(widget.post.imageurl),
                    ),
                    Center(
                      child: Row(
                        children: [
                          Text(
                            Postusername,
                            style: AppStyles.profileTextName,
                          ),
                          SizedBox(width: 100),
                          Spacer(),
                          _currentuser!.uid == widget.post.postownerID
                              ? IconButton(
                                  padding: EdgeInsets.all(0),
                                  alignment: Alignment.center,
                                  visualDensity: VisualDensity.compact,
                                  iconSize: 15,
                                  splashRadius: 20,
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PostEditScreen(
                                              ourPost: widget.post)),
                                    );
                                  },
                                  icon: Icon(Icons.edit))
                              : SizedBox.shrink(),
                        ],
                      ),
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
                            border: Border.all(color: Colors.green, width: 2.0),
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
                  ],
                ),
              ),
            ),
          );
        },
      );
    }  else {
      return FutureBuilder(
          future: PostalreadyLiked().then((result) => Isliked = result),
          builder: (context, snapshot) {
            return InkWell(
              onTap: () {},
              child: Card(
                margin: EdgeInsets.all(10),
                color: Colors.lightBlueAccent[100],
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(widget.post.date, style: AppStyles.postText),
                              //SizedBox(width :5),
                              widget.searched == false
                                  ? IconButton(
                                      alignment: Alignment.center,
                                      onPressed: widget.delete,
                                      iconSize: 20,
                                      splashRadius: 24,
                                      color: Colors.white,
                                      icon: Icon(
                                        Icons.delete_outline,
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              _currentuser!.uid == widget.post.postownerID
                                  ? IconButton(
                                      padding: EdgeInsets.all(0),
                                      alignment: Alignment.center,
                                      visualDensity: VisualDensity.compact,
                                      iconSize: 20,
                                      splashRadius: 20,
                                      color: Colors.white,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PostEditScreen(
                                                        ourPost: widget.post)));
                                      },
                                      icon: Icon(Icons.edit))
                                  : SizedBox.shrink()
                            ],
                          ),
                          Text(location, style: AppStyles.postLocation),
                          SizedBox(height: 5),
                          Text(
                            widget.post.content,
                            style: AppStyles.postText,
                            overflow: TextOverflow.fade,
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
                                  color: Colors.white),
                              SizedBox(width: 5),
                              Text('${widget.post.commentCount}',
                                  style: AppStyles.postText),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Container(
                                  child: Text(widget.post.topic),
                                ),
                              )
                            ],
                          )
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
