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
    bool _seen = prefs.getBool('seen') ?? false;
    print("TRIAL ${_seen}");
    if (_seen) {
      setState(() {
        _isSeen = true;
      });
    } else {
      setState(() {
        _isSeen = false;
      });
    }
  }

  @override
  void initState() {
    FirstSeen();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: _isSeen ? "/welcome" : "/walkthrough",
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/walkthrough': (context) => const Walkthrough(),
        //SignUp.routeName: (context) => SignUp(),
        //Login.routeName: (context) => Login(),
      },
    );
  }
}
