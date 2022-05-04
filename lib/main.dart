import 'package:exchangeit/routes/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:exchangeit/routes/welcomepage.dart';

void main() {
  runApp(MaterialApp(
    // initialRoute: '/login',
    routes: {
      '/': (context) => const WelcomePage(),
      //SignUp.routeName: (context) => SignUp(),
      //Login.routeName: (context) => Login(),
    },
  ));
}
