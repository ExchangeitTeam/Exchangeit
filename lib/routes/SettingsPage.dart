import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exchangeit/SettingsOptions/ProfileEdit.dart';
import 'package:exchangeit/models/Colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../services/Appanalytics.dart';
import '../services/auth.dart';

showDialogueForWaiting(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) => WaitingScreen(
          message: "Your account visibility is changing, please wait..."));
}

hideProgressDialogue(BuildContext context) {
  Navigator.of(context).pop(WaitingScreen(
      message: "Your account visibility is changing, please wait..."));
}

Future makePrivate() async {
  if (isPrivate == 'public') {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(_currentuser!.uid)
        .update({
      'isPrivate': 'private',
    });
  }
  if (isPrivate == 'private') {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(_currentuser!.uid)
        .update({
      'isPrivate': 'public',
    });
  }
}

Future checkPrivate() async {
  print("check girdi");
  try {
    DocumentSnapshot curruserinfo = await FirebaseFirestore.instance
        .collection("Users")
        .doc(_currentuser!.uid)
        .get();
    isPrivate = curruserinfo.get("isPrivate");
  } catch (e) {
    print(e);
  }
}

final _currentuser = FirebaseAuth.instance.currentUser;
String isPrivate = '';

class Settings extends StatefulWidget {
  const Settings({Key? key, required this.analytics}) : super(key: key);
  final FirebaseAnalytics analytics;
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    Appanalytics.setCurrentScreenUtil(screenName: "Settings Page");
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: checkPrivate(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return WaitingScreen(message: "Loading Settings page");
          } else {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text("Settings"),
                centerTitle: true,
                backgroundColor: AppColors.appBarColor,
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()));
                    },
                    icon: Icon(
                      Icons.edit,
                      size: 30,
                    ),
                    label: Text(
                      "Edit Profile",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: TextButton.styleFrom(
                        alignment: Alignment.centerLeft,
                        primary: Colors.black,
                        fixedSize: Size(size.width, size.height * 0.1)),
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      showDialogueForWaiting(context);
                      await makePrivate();
                      hideProgressDialogue(context);
                      setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            elevation: 10,
                            content: Text('Profile visibility updated'),
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      });
                    },
                    icon: Icon(
                      Icons.visibility_off,
                      size: 30,
                    ),
                    label: Text(
                      isPrivate == 'public'
                          ? 'Make private profile'
                          : 'Make public profile',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: TextButton.styleFrom(
                        alignment: Alignment.centerLeft,
                        primary: Colors.black,
                        fixedSize: Size(size.width, size.height * 0.1)),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, 'PassChange');
                    },
                    icon: Icon(
                      Icons.password,
                      size: 30,
                    ),
                    label: Text(
                      "Change password",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: TextButton.styleFrom(
                        alignment: Alignment.centerLeft,
                        primary: Colors.black,
                        fixedSize: Size(size.width, size.height * 0.1)),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete_rounded,
                      size: 30,
                    ),
                    label: Text(
                      "Delete account",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: TextButton.styleFrom(
                        alignment: Alignment.centerLeft,
                        primary: Colors.black,
                        fixedSize: Size(size.width, size.height * 0.1)),
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      bool _facebooklogin =
                          await prefs.getBool('facebooklogin') ?? false;
                      bool _googlelogin =
                          await prefs.getBool('googlelogin') ?? false;
                      if (_facebooklogin == true) {
                        await prefs.setBool('facebooklogin', false);
                        await AuthService().FacebookLogout();
                      }
                      if (_googlelogin == true) {
                        await prefs.setBool('googlelogin', false);
                        await AuthService().googleLogout();
                      }
                      if (_facebooklogin == false && _googlelogin == false) {
                        AuthService().signOut();
                      }
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/Login', (Route<dynamic> route) => false);
                    },
                    icon: Icon(
                      Icons.logout_outlined,
                      size: 30,
                    ),
                    label: Text(
                      "Logout",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: TextButton.styleFrom(
                        alignment: Alignment.centerLeft,
                        primary: Colors.black,
                        fixedSize: Size(size.width, size.height * 0.1)),
                  ),
                ],
              ),
            );
          }
        });
  }
}
