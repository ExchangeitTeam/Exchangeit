import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class printComments extends StatefulWidget {
  const printComments({Key? key}) : super(key: key);

  @override
  State<printComments> createState() => _printCommentsState();
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

class _printCommentsState extends State<printComments> {
  final List<commentInfo> _items = [
    commentInfo(
        avatar: 'https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png',
        name: 'Ayse Aydemir',
        timeAgo: '5m',
        text: 'Amazing',
        likes: '0'),
    commentInfo(
        avatar: 'https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png',
        name: 'Mehmet Sürünen',
        timeAgo: '1h',
        text: 'Fascinating',
        likes: '3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
