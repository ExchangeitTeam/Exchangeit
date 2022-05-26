import 'dart:async';

import 'package:exchangeit/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Opening extends StatefulWidget {
  const Opening({Key? key}) : super(key: key);

  @override
  State<Opening> createState() => _OpeningState();
}

class _OpeningState extends State<Opening> {
  @override
  initState() {
    super.initState();
    new Timer(const Duration(seconds: 2), FirstSeen);
  }

  Future FirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = await prefs.getBool('seen') ?? false;
    print("ılk ${_seen},");
    if (_seen == true) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/Welcome', (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/Walkthrough', (Route<dynamic> route) => false);
    }
    print("SONRA ${_seen},");
  }

  @override
  Widget build(BuildContext context) {
    return WaitingScreen();
  }
}
