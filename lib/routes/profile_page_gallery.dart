import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exchangeit/routes/post_page.dart';
import 'package:exchangeit/routes/profile_page.dart';
import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  const Gallery({required this.GmyPosts});
  final List<dynamic> GmyPosts;
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          crossAxisCount: 3,
        ),
        itemCount: widget.GmyPosts.length,
        itemBuilder: (context, index) {
          return new GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => postPageView(
                          pf: widget.GmyPosts[index],
                          isPhoto: false,
                        )),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.GmyPosts[index].imageurl),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
