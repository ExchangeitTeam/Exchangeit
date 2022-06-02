import 'package:exchangeit/models/Colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:exchangeit/routes/post_photo.dart';
import 'package:exchangeit/routes/post_text.dart';

import '../services/Appanalytics.dart';

class SharePostScreen extends StatefulWidget {
  const SharePostScreen({Key? key, this.analytics}) : super(key: key);
  final FirebaseAnalytics? analytics;
  @override
  State<SharePostScreen> createState() => _SharePostScreenState();
}

class _SharePostScreenState extends State<SharePostScreen> {
  int _selectedIndex = 0;

  PageController pageController = PageController();

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 1000), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    setCurrentScreenUtil(screenName: "Share Post Page");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.appBarColor,
        actions: [
          const Spacer(),
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
              textStyle: const TextStyle(fontSize: 18),
            ),
            child: Text('Post'),
            onPressed: () {},
          ),
        ],
      ),
      body: PageView(
        controller: pageController,
        children: [
          Container(
            child: SharePhoto(analytics: widget.analytics),
          ),
          Container(
            child: ShareText(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.grey[700],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(null),
              label: 'Photo',
              backgroundColor: AppColors.buttonColor),
          BottomNavigationBarItem(icon: Icon(null), label: 'Text'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue.shade600,
        unselectedItemColor: Colors.white,
        onTap: onTapped,
      ),
    );
  }
}
