import 'package:exchangeit/routes/ChangePassword.dart';
import 'package:exchangeit/routes/DMPage.dart';
import 'package:exchangeit/routes/LoggedIn.dart';
import 'package:exchangeit/routes/LoginPage.dart';
import 'package:exchangeit/routes/OpeningPage.dart';
import 'package:exchangeit/routes/SettingsPage.dart';
import 'package:exchangeit/routes/SignupPage.dart';
import 'package:exchangeit/routes/WalkthroughPage.dart';
import 'package:exchangeit/routes/post_photo.dart';
import 'package:exchangeit/routes/share_post.dart';
import 'package:flutter/material.dart';
import 'package:exchangeit/routes/WelcomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:exchangeit/routes/NotificationPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Opening(),
      routes: {
        '/Welcome': (context) => const WelcomePage(),
        '/Walkthrough': (context) => const Walkthrough(),
        '/SignUp': (context) => SignUp(),
        '/Login': (context) => LoginScreen(),
        '/LoggedIn': (context) => LoggedIn(),
        'Settings': (context) => Settings(),
        'PassChange': (context) => PassChange(),
        'SharePost': (context) => SharePostScreen(),
        'SharePhoto': (context) => SharePhoto(),
        'DM': (context) => DMPage()
      },
    );
  }
}
