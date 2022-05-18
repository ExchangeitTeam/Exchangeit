import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('Exchangeit'),
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Color.fromARGB(255, 0, 170, 229),
      centerTitle: true,
    ));
  }
}
