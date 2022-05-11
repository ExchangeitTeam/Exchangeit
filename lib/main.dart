import 'package:exchangeit/routes/SignupPage.dart';
import 'package:exchangeit/routes/WalkthroughPage.dart';
import 'package:flutter/material.dart';
import 'package:exchangeit/routes/WelcomePage.dart';

void main() {
  runApp(MaterialApp(
    // initialRoute: '/login',
    routes: {
      //'/': (context) => const WelcomePage(),
      '/': (context) => const Walkthrough(),
      //SignUp.routeName: (context) => SignUp(),
      //Login.routeName: (context) => Login(),
    },
  ));
}
