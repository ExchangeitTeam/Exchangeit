import 'package:exchangeit/routes/NotificationPage.dart';
import 'package:exchangeit/routes/profile_page.dart';
import 'package:exchangeit/routes/searchpage_location.dart';
import 'package:flutter/material.dart';

import 'AddPostPage.dart';
import 'FeedPage.dart';

class LoggedIn extends StatefulWidget {
  const LoggedIn({Key? key}) : super(key: key);

  @override
  State<LoggedIn> createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  int _selectedIndex = 0;
  static List _BarOptions = [
    FeedPage(),
    SearchMain(),
    AddPost(),
    NotificationView(),
    ProfileView(),
  ];
  static List<String> page_names = [
    "Home",
    "Search",
    "Add Post",
    "Noticications",
    "Profile"
  ];
  void _BarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exchangeit'),
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue.shade600,
        actions: [
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: _BarOptions.elementAt(_selectedIndex),
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue.shade600,
        unselectedItemColor: Colors.black,
        onTap: _BarTapped,
      ),
    );
  }
}
