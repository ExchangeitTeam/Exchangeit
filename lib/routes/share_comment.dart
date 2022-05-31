import 'package:flutter/material.dart';

class shareComment extends StatefulWidget {
  const shareComment({Key? key}) : super(key: key);

  @override
  State<shareComment> createState() => _shareCommentState();
}

class _shareCommentState extends State<shareComment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Container(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Share your comment...',
                labelStyle: TextStyle(fontSize: 24, color: Colors.grey),
                border: InputBorder.none,
              ),
              obscureText: false,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
