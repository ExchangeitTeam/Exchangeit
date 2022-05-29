import 'package:exchangeit/SettingsOptions/ProfileEdit.dart';
import 'package:exchangeit/models/Colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/Appanalytics.dart';
import '../services/auth.dart';

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
    setCurrentScreenUtil(
        analytics: widget.analytics, screenName: "Settings Page");
    Size size = MediaQuery.of(context).size;
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile()));
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
            onPressed: () {},
            icon: Icon(
              Icons.visibility_off,
              size: 30,
            ),
            label: Text(
              "Change profile visibility",
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
              SharedPreferences prefs = await SharedPreferences.getInstance();
              bool _facebooklogin =
                  await prefs.getBool('facebooklogin') ?? false;
              bool _googlelogin = await prefs.getBool('googlelogin') ?? false;
              if (_facebooklogin == true) {
                await AuthService().FacebookLogout();
              }
              if (_googlelogin == true) {
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
}
