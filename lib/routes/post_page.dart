import 'package:flutter/material.dart';
import '../Objects/PostClass.dart';
import '../models/Colors.dart';
import 'package:exchangeit/routes/share_comment.dart';
import 'package:exchangeit/routes/print_comments.dart';

class postPageView extends StatefulWidget {
  const postPageView({Key? key, required this.pf}) : super(key: key);
  final dynamic ? pf;
  @override
  State<postPageView> createState() => _postPageViewState();
}

class _postPageViewState extends State<postPageView> {
  final imagepost = ImagePost(
    profileImage: NetworkImage(
    'https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png'),
    image: NetworkImage(
    "https://images.pexels.com/photos/1772973/pexels-photo-1772973.png?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
    username: "Ayse Aydemir",
    isMine: true,
    postId: '1',
    Location: "Everest",
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
        body: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return widget.pf;
          }, body: printComments(),
          // shareComment(),
        ),
        //bottomNavigationBar: SafeArea(
          //child: shareComment(),
        //),
      ),
    );
  }
}

/*
DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            // Hocam bura unutmaa!!!!!!!!!!
            return <Widget> [
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
            ];
          },
          body:
 */