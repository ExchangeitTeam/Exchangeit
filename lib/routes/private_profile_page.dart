import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exchangeit/models/Colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:exchangeit/routes/private_profile_page_base_screen.dart';
import 'package:flutter/rendering.dart';

import '../main.dart';
import '../services/Appanalytics.dart';
import '../services/FirestoreServices.dart';

class privateProfileView extends StatefulWidget {
  privateProfileView({Key? key, this.uid})
      : super(key: key);

  String? uid;

  @override
  State<privateProfileView> createState() => _privateProfileViewState();
}

class _privateProfileViewState extends State<privateProfileView> {
  String uname = "";

  Future getuserInfo() async {
    DocumentSnapshot docSnap =
    await FirestoreService.userCollection.doc(widget.uid).get();
    uname = docSnap.get('username');
  }

  @override
  Widget build(BuildContext context) {
    Appanalytics.setCurrentScreenUtil(screenName: "Private_Profile_Page");
    return FutureBuilder(
        future: Future.wait([getuserInfo()]),
        builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return WaitingScreen(message: "Loading Profile");
        }
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
          body: DefaultTabController(
            length: 3,
            child: NestedScrollView(
              headerSliverBuilder: (context, _) {
                return [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        privateBaseScreenView(uid: widget.uid!),
                      ],
                    ),
                  ),
                ];
              },
              body: Column(
                children: [
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
      }
    );
  }
}
