import 'package:flutter/material.dart';

import '../Objects/PostClass.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  final List<ImagePost> _items = [
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
    ImagePost(
      profileImage: NetworkImage(
          'https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png'),
      image: NetworkImage(
          "https://i.neredekal.com/i/neredekal/75/425x0/604de59d067127e05588bb7b"),
      username: "Ayse Aydemir",
      isMine: true,
      postId: '2',
      Location: "Ardahan",
    ),
    ImagePost(
      profileImage: NetworkImage(
          'https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png'),
      image: NetworkImage("https://muze.gen.tr/img/maiden_tower_home.jpg"),
      username: "Ayse Aydemir",
      isMine: false,
      postId: '2',
      Location: "Istanbul",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
