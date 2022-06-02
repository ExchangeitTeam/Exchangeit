import 'package:exchangeit/models/Colors.dart';
import 'package:exchangeit/services/Appanalytics.dart';
import 'package:flutter/material.dart';

import '../Objects/PostClass.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final List<PostBase> _items = [
    ImagePost(
      profileImage: NetworkImage(
          'https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png'),
      image: NetworkImage(
          "https://images.pexels.com/photos/1772973/pexels-photo-1772973.png?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
      username: "Ayse Aydemir",
      isMine: true,
      postId: '1',
      Location: "Everest",
    ),
    TextPost(
      text: "Sabancı is the best university",
      isMine: true,
      profileImage: NetworkImage(
          'https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png'),
      Location: "Istanbul",
      username: "Mehmet Sürünen",
      postId: '10',
    ),
    ImagePost(
      profileImage: NetworkImage(
          'https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png'),
      image: NetworkImage(
          "https://i.neredekal.com/i/neredekal/75/425x0/604de59d067127e05588bb7b"),
      username: "Ismail Dag",
      isMine: true,
      postId: '2',
      Location: "Ardahan",
    ),
    TextPost(
      text: "Munich is beautiful",
      isMine: true,
      profileImage: NetworkImage(
          'https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png'),
      Location: "Munich",
      username: "Ayse Aydemir",
      postId: '10',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    setCurrentScreenUtil(screenName: 'Post Page');
    return Scaffold(
      appBar: AppBar(
        title: Text('Exchangeit'),
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: AppColors.appBarColor,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "DM");
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return _items[index];
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
            height: 0,
          ),
          itemCount: _items.length,
        ),
      ),
    );
  }
}
