import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import '../Objects/PostClass.dart';
import '../models/Colors.dart';

class postPageView extends StatefulWidget {
  const postPageView({Key? key, required this.pf, required this.isPhoto})
      : super(key: key);
  final String pf;
  final bool isPhoto;
  @override
  State<postPageView> createState() => _postPageViewState();
}

class commentInfo extends StatelessWidget {
  final String avatar;
  final String name;
  final String timeAgo;
  final String text;
  final String likes;

  commentInfo({
    Key? key,
    required this.avatar,
    required this.name,
    required this.timeAgo,
    required this.text,
    required this.likes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(this.avatar),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5.0),
                      child: Text(
                        this.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      ' · $timeAgo',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Text(
                  this.text,
                  overflow: TextOverflow.clip,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0, right: 20.0),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          LikeButton(
                            size: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.all(6.0),
                            child: Text(
                              this.likes,
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _postPageViewState extends State<postPageView> {
  final List<commentInfo> _items = [
    commentInfo(
        avatar:
            'https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png',
        name: 'Ayse Aydemir',
        timeAgo: '5m',
        text: 'Amazing',
        likes: '0'),
    commentInfo(
        avatar:
            'https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png',
        name: 'Mehmet Sürünen',
        timeAgo: '1h',
        text: 'Fascinating',
        likes: '3'),
    commentInfo(
        avatar:
            'https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png',
        name: 'Ayse Aydemir',
        timeAgo: '5m',
        text: 'Amazing',
        likes: '0'),
    commentInfo(
        avatar:
            'https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png',
        name: 'Mehmet Sürünen',
        timeAgo: '1h',
        text: 'Fascinating',
        likes: '3'),
  ];

  final imagePost = ImagePost(
    profileImage: NetworkImage(
        'https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png'),
    image: NetworkImage(
        "https://images.pexels.com/photos/1772973/pexels-photo-1772973.png?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
    username: "Ayse Aydemir",
    isMine: false,
    postId: '1',
    Location: "Everest",
  );

  final textPost = TextPost(
    text: "Sabancı is the best university",
    isMine: true,
    profileImage: NetworkImage(
        'https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png'),
    Location: "Istanbul",
    username: "Mehmet Sürünen",
    postId: '10',
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Exchangeit'),
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: AppColors.appBarColor,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              widget.isPhoto ? imagePost : textPost,
              Container(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Share your comment...',
                    labelStyle: TextStyle(fontSize: 12, color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.black),
                      //borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  obscureText: false,
                  maxLines: 1,
                ),
              ),
              Container(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _items[index];
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
        //bottomSheet: shareComment(),
      ),
    );
  }
}
