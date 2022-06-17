import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exchangeit/routes/ZoomPhotoView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Objects/NewPostClass.dart';
import '../main.dart';
import '../models/Colors.dart';
import '../services/FirestoreServices.dart';

class UserSearch extends StatefulWidget {
  UserSearch({Key? key, required this.SearchedId}) : super(key: key);
  String SearchedId;
  @override
  State<UserSearch> createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  bool Private = false;
  Future IsSearchProfilePrivate(var searchID) async {
    DocumentSnapshot docSnap =
        await FirestoreService.userCollection.doc(searchID).get();
    Private = await docSnap.get('checkPrivate');
  }

  int totalFollower = 0;
  int totalFollowing = 0;
  String profilepp = "";
  String bio = "";
  String uni = "";
  String searchedUserName="";
  int totalLike = 0;
  bool viewerFollow = false;
  List<UserPost> SearchedPosts = [];
  Future updateFollower() async {
    List allFollowers = [];
    List allFollowings = [];
    DocumentSnapshot docSnap =
        await FirestoreService.userCollection.doc(widget.SearchedId).get();
    //aranan userimin follower sayısını arttırma
    //currID sayfayı ziyaret eden
    int currFollowers = docSnap.get('followerCount');
    allFollowers = docSnap.get('followers');
    allFollowers.add(currId);
    await FirestoreService.userCollection.doc(widget.SearchedId).update(
        {'followers': allFollowers, 'followerCount': currFollowers + 1});

    //isteği atan kişinin following yaptıklarına ekleme
    int currFollowing = docSnap.get('followingCount');
    allFollowings = docSnap.get('following');
    allFollowings.add(widget.SearchedId);

    await FirestoreService.userCollection.doc(currId).update(
        {'following': allFollowings, 'followingCount': currFollowing + 1});
  }

  Future getSearchedUserPosts(var uid) async {
    SearchedPosts = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('posts')
        .orderBy('datetime', descending: true)
        .get();

    for (var message in snapshot.docs) {
      totalLike = message.get('totalLike');
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
      SearchedPosts.add(post);
    }
  }

  Future getSearcheduserInfo() async {
    DocumentSnapshot docSnap =
        await FirestoreService.userCollection.doc(widget.SearchedId).get();
    searchedUserName=await docSnap.get("username");
    totalFollower = await docSnap.get('followerCount');
    totalFollowing = await docSnap.get('followingCount');
    profilepp = await docSnap.get('profileIm');
    bio = await docSnap.get('bio');
    uni = await docSnap.get('university');
  }

  Future senderFollowstate() async {
    DocumentSnapshot CurrentuserSnap =
        await FirestoreService.userCollection.doc(currId).get();
    List allfollowings = [];
    allfollowings = CurrentuserSnap.get('following');
    if (allfollowings.contains(widget.SearchedId)) {
      viewerFollow = true;
    } else {
      viewerFollow = false;
    }
  }

  final currId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait(
            [senderFollowstate(), IsSearchProfilePrivate(widget.SearchedId)]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return WaitingScreen(message: "Loading Profile");
          }
          return FutureBuilder(
              future: getSearchedUserPosts(widget.SearchedId),
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return WaitingScreen(message: "Loading Profile");
                }
                final NetworkImage pp = NetworkImage(profilepp);
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: AppColors.appBarColor,
                    elevation: 0.0,
                    title: Text(
                      searchedUserName
                      ,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    centerTitle: true,
                  ),
                  body: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:  BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                      child: CircleAvatar(
                                        radius: 60,
                                        backgroundImage: pp,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        photoViewPage(pht: pp)));
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 15, 15, 0),
                                            child: Text(
                                              '$totalFollower',
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Followers',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 15, 15, 0),
                                            child: Text(
                                              '$totalFollowing',
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Follow',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 25),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const SizedBox(height: 30),
                                  InkWell(
                                    borderRadius: BorderRadius.circular(15),
                                    splashColor: Colors.blueAccent,
                                    onTap: () {
                                      setState(() {
                                        /*if (buttonChanger == "Requested")
                                          buttonChanger = "Follow";
                                        else
                                          buttonChanger = "Requested";*/
                                      });
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Container(
                                        width: 150,
                                        height: 40,
                                        margin: const EdgeInsets.all(3.0),
                                        padding: const EdgeInsets.all(3.0),
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlue[100],
                                          border: Border.all(
                                              width: 2.5,
                                              color: Colors.lightBlueAccent),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(15.0)),
                                        ),
                                        child: Center(child: Text("Follow")),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  InkWell(
                                    borderRadius: BorderRadius.circular(15),
                                    splashColor: Colors.blueAccent,
                                    onTap: () {
                                      //Send Message page
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Container(
                                        width: 150,
                                        height: 40,
                                        margin: const EdgeInsets.all(3.0),
                                        padding: const EdgeInsets.all(3.0),
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlue[100],
                                          border: Border.all(
                                              width: 2.5,
                                              color: Colors.lightBlueAccent),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(15.0)),
                                        ),
                                        child: Center(child: Text("Send Message")),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                );
              }
    );
  }
    );
}
