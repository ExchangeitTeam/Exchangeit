import 'package:exchangeit/SettingsOptions/ChangePassword.dart';
import 'package:exchangeit/routes/DMPage.dart';
import 'package:exchangeit/routes/GoogleSignIn.dart';
import 'package:exchangeit/routes/LoggedIn.dart';
import 'package:exchangeit/routes/LoginPage.dart';
import 'package:exchangeit/routes/OpeningPage.dart';
import 'package:exchangeit/routes/SettingsPage.dart';
import 'package:exchangeit/routes/SignupPage.dart';
import 'package:exchangeit/routes/WalkthroughPage.dart';
import 'package:exchangeit/routes/post_photo.dart';
import 'package:exchangeit/routes/private_profile_page.dart';
import 'package:exchangeit/routes/share_post.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:exchangeit/routes/WelcomePage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:exchangeit/routes/NotificationPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<FirebaseApp> _fbappinit = Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        home: FutureBuilder(
          future: _fbappinit,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorScreen(message: snapshot.error.toString());
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return Opening();
            } else {
              return WaitingScreen();
            }
          },
        ),
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
          'DM': (context) => DMPage(),
          'PrivProfile': (context) => privateProfileView(),
        },
      ),
    ),
  );
}

class ErrorScreen extends StatelessWidget {
  ErrorScreen({Key? key, required this.message}) : super(key: key);

  String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error Occurred'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(color: Colors.blueAccent),
      ),
    );
  }
}
/*
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
        'DM': (context) => DMPage(),
        'PrivProfile': (context) => privateProfileView(),
      },
    );
  }
}
*/
