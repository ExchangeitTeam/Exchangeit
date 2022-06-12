import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exchangeit/models/Colors.dart';
import 'package:exchangeit/services/Appanalytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Objects/NewPostClass.dart';

import '../main.dart';
import 'FeedProvider.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key, required this.analytics}) : super(key: key);
  final FirebaseAnalytics analytics;
  @override
  State<FeedPage> createState() => _FeedPageState();
}

List<UserPost> myPosts = [];

class _FeedPageState extends State<FeedPage> {
  @override
  void initState() {
    setState(() {});
  }

  final _currentuser = FirebaseAuth.instance.currentUser;
  List posts = [];
  int TotalLike = 0;
  Future getPosts(var uid) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('posts')
        .orderBy('datetime', descending: true)
        .get();

    for (var message in snapshot.docs) {
      TotalLike = message.get('totalLike');
      print(TotalLike);
      List comment = message.get('comments');
      Timestamp t = message.get('datetime');
      DateTime d = t.toDate();
      String date = d.toString().substring(0, 10);
      String posttopic = message.get('topic');
      UserPost post = UserPost(
          postId: message.id,
          content: message.get('content').toString(),
          imageurl: message.get('imageUrl').toString(),
          date: date,
          totalLike: TotalLike,
          commentCount: comment.length,
          comments: comment,
          postownerID: uid,
          topic: posttopic);
      posts.add(post);

      String locat = message['location'];
      print(locat);
    }
  }

  Future getFeedPosts() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(_currentuser!.uid)
        .get();
    List allPostOwner = snapshot.get('following');

    for (var id in allPostOwner) {
      print("Following id:$id");
      await getPosts(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    Appanalytics.setCurrentScreenUtil(screenName: 'Post Page');
    return FutureBuilder(
        future: Future.wait([getFeedPosts()]),
        builder: (context, snapshot) {
          print("Post len: ${posts.length}");
          posts.sort((a, b) {
            DateTime dt1 = DateTime.parse(a.date);
            DateTime dt2 = DateTime.parse(b.date);
            return dt2.compareTo(dt1);
          });
          if (snapshot.connectionState == ConnectionState.waiting) {
            return WaitingScreen(message: "Loading feed page");
          }
          return Scaffold(
            appBar: AppBar(
              title: Text('Exchangeit'),
              elevation: 0,
              foregroundColor: Colors.white,
              backgroundColor: AppColors.appBarColor,
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "DM");
                  },
                ),
              ],
            ),
            body: Container(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    child: Column(
                      children: posts
                          .map((currentpost) => FeedProvider(
                              post: currentpost,
                              delete: () {
                                setState(() async {
                                  //myPosts.remove(post);
                                  await FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(_currentuser!.uid)
                                      .collection('posts')
                                      .doc(currentpost.postId)
                                      .delete();
                                });
                              },
                              like: () {},
                              searched: false))
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
