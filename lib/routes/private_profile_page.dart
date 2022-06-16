import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exchangeit/models/Colors.dart';
import 'package:exchangeit/routes/ZoomPhotoView.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:exchangeit/routes/private_profile_page_base_screen.dart';
import 'package:flutter/rendering.dart';

import '../main.dart';
import '../models/Styles.dart';
import '../services/Appanalytics.dart';
import '../services/FirestoreServices.dart';

class privateProfileView extends StatefulWidget {
  privateProfileView({Key? key, this.uid}) : super(key: key);

  String? uid;

  @override
  State<privateProfileView> createState() => _privateProfileViewState();
}

class _privateProfileViewState extends State<privateProfileView> {
  String uname = "";
  int totalFollower = 0;
  int totalFollowing = 0;
  String profilepp = "";
  String Bio = "";
  String uni = "";
  Future getuserInfo() async {
    DocumentSnapshot docSnap =
        await FirestoreService.userCollection.doc(widget.uid).get();
    uname = docSnap.get('username');
    totalFollower = await docSnap.get('followerCount');
    totalFollowing = await docSnap.get('followingCount');
    profilepp = await docSnap.get('profileIm');
    Bio = await docSnap.get('bio');
    uni = await docSnap.get('university');
  }

  Future updateFollower() async {
    List allFollowers = [];
    List allFollowings = [];
    DocumentSnapshot docSnap =
        await FirestoreService.userCollection.doc(widget.uid).get();

    int currFollowers = docSnap.get('followerCount');
    allFollowers = docSnap.get('followers');
    allFollowers.add(currId);

    await FirestoreService.userCollection.doc(widget.uid).update(
        {'followers': allFollowers, 'followerCount': currFollowers + 1});

    int currFollowing = docSnap.get('followingCount');
    allFollowings = docSnap.get('following');
    allFollowings.add(widget.uid);

    await FirestoreService.userCollection.doc(currId).update(
        {'following': allFollowings, 'followingCount': currFollowing + 1});
  }

  final currId = FirebaseAuth.instance.currentUser!.uid;
  String buttonChanger = "Follow";
  @override
  Widget build(BuildContext context) {
    Appanalytics.setCurrentScreenUtil(screenName: "Private_Profile_Page");
    return FutureBuilder(
        future: Future.wait([getuserInfo()]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return WaitingScreen(message: "Loading Profile");
          }
          final NetworkImage pp = NetworkImage(profilepp);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: AppColors.appBarColor,
              elevation: 0.0,
              title: Text(
                "$uname",
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
            body: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
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
                                  if (buttonChanger == "Requested")
                                    buttonChanger = "Follow";
                                  else
                                    buttonChanger = "Requested";
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
                                  child: Center(child: Text(buttonChanger)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            InkWell(
                              borderRadius: BorderRadius.circular(15),
                              splashColor: Colors.blueAccent,
                              onTap: () {},
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                              child: Text(
                                " University: $uni",
                                style: AppStyles.WalkTextStyle,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
                              child: Text(
                                "$Bio",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.lock, size: 50),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "This Account is Private",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                          ),
                        ),
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
