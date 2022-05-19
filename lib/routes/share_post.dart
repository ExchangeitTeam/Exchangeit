import 'package:exchangeit/models/Colors.dart';
import 'package:flutter/material.dart';
import 'package:exchangeit/routes/post_photo.dart';
import 'package:exchangeit/routes/post_text.dart';

class SharePostScreen extends StatefulWidget {
  const SharePostScreen({Key? key}) : super(key: key);

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
            child: SharePhoto(),
          ),
          Container(
            child: ShareText(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(null), label: 'Photo'),
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
