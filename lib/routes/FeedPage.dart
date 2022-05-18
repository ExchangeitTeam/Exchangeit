import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exchangeit'),
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 0, 170, 229),
        centerTitle: true,
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
      body: Column(
        children: [Text("FeedPage")],
      ),
    );
  }
}
