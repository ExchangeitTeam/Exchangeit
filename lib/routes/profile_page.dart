import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exchangeit/Objects/PostBase.dart';
import 'package:exchangeit/main.dart';
import 'package:exchangeit/models/Colors.dart';
import 'package:exchangeit/routes/profile_page_gallery.dart';
import 'package:exchangeit/services/Appanalytics.dart';
import 'package:exchangeit/services/FirestoreServices.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:exchangeit/routes/profile_page_base_screen.dart';
import 'package:exchangeit/routes/profile_page_posts.dart';
import 'package:exchangeit/routes/profile_page_location.dart';
import 'package:provider/provider.dart';

import '../Objects/NewPostClass.dart';
import '../Objects/UserClass.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key, required this.analytics}) : super(key: key);
  final FirebaseAnalytics analytics;
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

String username = '';
Future getusername(var uid) async {
  if (uid != null) {
    DocumentSnapshot docSnap =
        await FirestoreService.userCollection.doc(uid).get();
    username = docSnap.get('username');
    totalFollower = docSnap.get('followerCount');
    totalFollowing = docSnap.get('followingCount');
  }
  print('Provider uid:$uid');
  print('Provider usernama: $username');
}

currentusercheck() {
  var _user = FirebaseAuth.instance.currentUser;
  if (_user == null) {
    print('user yok');
  } else {
    print('user var');
    print('Firebase user:${_user.uid}');
  }
}

int totalLike = 0;

List<UserPost> myPosts = [];
Future getPosts(var uid) async {
  myPosts = [];
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Users')
      .doc(uid)
      .collection('posts')
      .orderBy('datetime', descending: true)
      .get();

  for (var message in snapshot.docs) {
    totalLike = message.get('totalLike');
    print(totalLike);
    List comment = message.get('comments');
    Timestamp t = message.get('datetime');
    DateTime d = t.toDate();
    String date = d.toString().substring(0, 10);
    String posttopic = message.get("topic");
    UserPost post = UserPost(
      postId: message.id,
      content: message.get('content').toString(),
      imageurl: message.get('imageUrl').toString(),
      date: date,
      totalLike: totalLike,
      commentCount: comment.length,
      comments: comment,
      postownerID: uid,
      topic: posttopic,
    );
    myPosts.add(post);
  }
}

class _ProfileViewState extends State<ProfileView> {
  void initState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    currentusercheck();
    var user = Provider.of<appUser?>(context);
    var _userid = user?.uid;
    if (user == null) {
      _userid = FirebaseAuth.instance.currentUser?.uid;
    }
    Appanalytics.setLogEventUtil(eventName: 'Profile_Page_Viewed');
    return FutureBuilder(
        future: Future.wait([getusername(_userid), getPosts(_userid)]),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return WaitingScreen(message: "Loading profile page");
          }
          print("mypost array lenght: ${myPosts.length}");
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: AppColors.appBarColor,
              elevation: 0.0,
              title: Text(
                username,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'Settings');
                  },
                ),
              ],
            ),
            body: DefaultTabController(
              length: 3,
              child: NestedScrollView(
                headerSliverBuilder: (context, _) {
                  return [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          SingleChildScrollView(child: BaseScreenView()),
                        ],
                      ),
                    ),
                  ];
                },
                body: Column(
                  children: <Widget>[
                    Material(
                      color: Colors.white,
                      child: TabBar(
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey[400],
                        indicatorWeight: 1,
                        indicatorColor: Colors.black,
                        tabs: [
                          Tab(
                            icon: Icon(
                                IconData(0xf435, fontFamily: 'MaterialIcons')),
                          ),
                          Tab(
                            icon: Icon(
                                IconData(0xf131, fontFamily: 'MaterialIcons')),
                          ),
                          Tab(
                            icon: Icon(
                                IconData(0xf193, fontFamily: 'MaterialIcons')),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Container(
                            child: SingleChildScrollView(
                              child: Center(
                                child: Container(
                                  child: Column(
                                      children: myPosts
                                          .map((mappingpost) => BaseDesingPost(
                                              post: mappingpost,
                                              delete: () {
                                                setState(() {});
                                              },
                                              like: () {},
                                              searched: false))
                                          .toList()),
                                ),
                              ),
                            ),
                          ),
                          Gallery(GmyPosts: myPosts),
                          Location(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
