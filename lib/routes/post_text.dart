import 'package:flutter/material.dart';

class ShareText extends StatefulWidget {
  const ShareText({Key? key}) : super(key: key);

  @override
  State<ShareText> createState() => _ShareTextState();
}

class _ShareTextState extends State<ShareText> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Container(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Tell others about yourself...',
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
