import 'package:exchangeit/routes/NotificationPage.dart';
import 'package:exchangeit/routes/profile_page.dart';
import 'package:exchangeit/routes/SearchPage.dart';
import 'package:exchangeit/routes/share_post.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../services/Appanalytics.dart';
import 'FeedPage.dart';

class LoggedIn extends StatefulWidget {
  const LoggedIn({Key? key, required this.analytics}) : super(key: key);
  final FirebaseAnalytics analytics;
  @override
  State<LoggedIn> createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  int _selectedIndex = 0;
  PageController _PageController = PageController();
  List<Widget> _BarOptions = [
    FeedPage(),
    SearchMain(),
    SharePostScreen(),
    NotificationView(),
    ProfileView(),
  ];
  static List<String> page_names = [
    "Home",
    "Search",
    "Add Post",
    "Notifications",
    "Profile"
  ];
  void _BarTapped(int index) {
    _PageController.jumpToPage(index);
  }

  void _PageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    setCurrentScreenUtil(
        analytics: widget.analytics, screenName: "loginScreen");
    return Scaffold(
      body: PageView(
        controller: _PageController,
        children: _BarOptions,
        onPageChanged: _PageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline), label: 'Add'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Account'),
        ],
        selectedItemColor: Colors.blue.shade600,
        unselectedItemColor: Colors.black,
        onTap: _BarTapped,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
