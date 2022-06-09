import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exchangeit/Objects/NewPostClass.dart';
import 'package:exchangeit/models/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../models/Styles.dart';
import '../routes/post_page.dart';
import '../routes/profile_page_posts.dart';

class PostTile extends StatefulWidget {
  final UserPost post;
  final VoidCallback delete;
  final VoidCallback like;
  bool searched;
  int dummy = 0;

  PostTile(
      {required this.post,
      required this.delete,
      required this.like,
      required this.searched});
  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  final _currentuser = FirebaseAuth.instance.currentUser;
  bool liked_already = false;
  bool there_is_image = true;
  String location = '';
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
  String Postusername = "boş";
  @override
  Widget build(BuildContext context) {
    if (widget.post.image_url != "") {
      return FutureBuilder(
        future: PostalreadyLiked().then((value) => liked_already = value),
        builder: (context, snapshot) {
          return GestureDetector(
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
              margin: EdgeInsets.all(8),
              color: Colors.lightBlueAccent[100],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          Postusername,
                          style: AppStyles.profileTextName,
                        ),
                        SizedBox(width: 100),
                        Spacer(),
                        _currentuser!.uid == widget.post.owner
                            ? IconButton(
                                padding: EdgeInsets.all(0),
                                alignment: Alignment.center,
                                visualDensity: VisualDensity.compact,
                                iconSize: 15,
                                splashRadius: 20,
                                color: Colors.white,
                                onPressed: () {},
                                /*=> Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              editPost(post: widget.post)),
                                    ),*/
                                icon: Icon(Icons.edit))
                            : SizedBox.shrink(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(widget.post.image_url,
                            height: 150, width: 150, fit: BoxFit.cover),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 5),
                                Text(
                                  widget.post.date,
                                  style: GoogleFonts.signika(
                                    color: Colors.deepOrangeAccent,
                                    fontSize: 16,
                                  ),
                                ),
                                widget.searched == false
                                    ? IconButton(
                                        padding: EdgeInsets.all(0),
                                        visualDensity: VisualDensity.compact,
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
                                IconButton(
                                  padding: EdgeInsets.all(0),
                                  alignment: Alignment.center,
                                  visualDensity: VisualDensity.compact,
                                  onPressed: () => report(widget.post),
                                  iconSize: 20,
                                  splashRadius: 20,
                                  color: Colors.white,
                                  icon: Icon(
                                    Icons.report,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(location, style: AppStyles.postOwnerText),
                                SizedBox(height: 5),
                                Text(widget.post.text,
                                    style: AppStyles.postText),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LikeButton(
                                      circleColor: CircleColor(
                                          start: const Color(0xFFFF5722),
                                          end: const Color(0xFFFFC107)),
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
                                        color: Colors.white),
                                    SizedBox(width: 5),
                                    Text('${widget.post.commentCount}',
                                        style: AppStyles.postText),
                                    SizedBox(width: 10),
                                  ],
                                ),
                                SizedBox(height: 45),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
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
                              IconButton(
                                alignment: Alignment.center,
                                onPressed: () => report(widget.post),
                                iconSize: 20,
                                splashRadius: 24,
                                color: Colors.white,
                                icon: Icon(
                                  Icons.report,
                                ),
                              ),
                              _currentuser!.uid == widget.post.owner
                                  ? IconButton(
                                      padding: EdgeInsets.all(0),
                                      alignment: Alignment.center,
                                      visualDensity: VisualDensity.compact,
                                      iconSize: 20,
                                      splashRadius: 20,
                                      color: Colors.white,
                                      onPressed:
                                          () {} /* Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => editPost(post: widget.post)),
                                  ),*/
                                      ,
                                      icon: Icon(Icons.edit))
                                  : SizedBox.shrink()
                            ],
                          ),
                          Text(location, style: AppStyles.postLocation),
                          SizedBox(height: 5),
                          Text(
                            widget.post.text,
                            style: AppStyles.postText,
                            overflow: TextOverflow.fade,
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
                                  color: Colors.white),
                              SizedBox(width: 5),
                              Text('${widget.post.commentCount}',
                                  style: AppStyles.postText),
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
