import 'package:exchangeit/routes/LoginPage.dart';
import 'package:exchangeit/routes/SignupPage.dart';
import 'package:exchangeit/routes/WalkthroughPage.dart';
import 'package:flutter/material.dart';
import 'package:exchangeit/routes/WelcomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSeen = false;
  Future FirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = await prefs.getBool('seen') ?? false;
    print("ılk ${_seen},${_isSeen}");
    if (_seen == true) {
      setState(() {
        _isSeen = true;
      });
    } else {
      setState(() {
        _isSeen = false;
      });
    }
    print("SONRA ${_seen},${_isSeen}");
  }

  @override
  void initState() {
    FirstSeen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _isSeen ? WelcomePage() : Walkthrough(),
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/walkthrough': (context) => const Walkthrough(),
        'SignUp': (context) => SignUp(),
        'Login': (context) => LoginScreen(),
      },
    );
  }
}
