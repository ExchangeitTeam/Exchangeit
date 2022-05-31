import 'package:exchangeit/models/Styles.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:exchangeit/routes/post_page.dart';

abstract class PostBase extends StatelessWidget {
  final NetworkImage profileImage;
  final String username;
  final bool isMine;
  final String postId;
  final String Loc;
  PostBase(
      {required this.profileImage,
      required this.username,
      required this.isMine,
      required this.postId,
      required this.Loc});
}

class ImagePost extends PostBase {
  final NetworkImage image;
  ImagePost(
      {required this.image,
      required NetworkImage profileImage,
      required String username,
      required bool isMine,
      required String postId,
      required String Location})
      : super(
            profileImage: profileImage,
            username: username,
            isMine: isMine,
            postId: postId,
            Loc: Location);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.fromLTRB(10, 0, 10, 14),
        child: Padding(
          padding: EdgeInsets.all(4.0),
          child: Column(
            children: [
              PostHeader(
                  profileImage: profileImage,
                  username: username,
                  isMine: isMine,
                  postId: postId,
                  location: Loc),
              PostHeaderDivider(),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Image(
                  image: image,
                  width: 800,
                  height: 350,
                  fit: BoxFit.fill,
                ),
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
                            '32164',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            IconData(0xe17e, fontFamily: 'MaterialIcons'),
                            size: 16.0,
                            color: Colors.black45,
                          ),
                          onPressed: () {
                            //Hocam burasi haaa sakin unutma!!!!!!!!!!!!!!
                            print('1!');
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=> postPageView(pf: this)),
                            );
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.all(6.0),
                          child: Text(
                            '321',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            IconData(0xf378, fontFamily: 'MaterialIcons'),
                            size: 16.0,
                            color: Colors.black45,
                          ),
                          onPressed: () {},
                        ),
                        Container(
                          margin: const EdgeInsets.all(6.0),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostHeader extends StatelessWidget {
  const PostHeader({
    Key? key,
    required this.profileImage,
    required this.username,
    required this.isMine,
    required this.postId,
    required this.location,
  }) : super(key: key);

  final NetworkImage profileImage;
  final String username;
  final bool isMine;
  final String postId;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 2, 12, 0),
                    child: CircleAvatar(
                      backgroundImage: this.profileImage,
                      backgroundColor: Colors.grey[400],
                      radius: 25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child:
                              Text(username, style: AppStyles.profileTextName),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(12, 2, 12, 0),
                    child: InkWell(
                      child: Icon(Icons.more_horiz, size: 25),
                      onTap: () {
                        isMine
                            ? showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    //title: Text("Add Comment"),
                                    content: Container(
                                      height: 160,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                  child: Icon(Icons.close),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  })
                                            ],
                                          ),
                                          OutlinedButton(
                                              child: Text("Delete"),
                                              onPressed: () {
                                                print("Delete this post" +
                                                    postId);
                                              }),
                                          OutlinedButton(
                                              child: Text("Update"),
                                              onPressed: () {
                                                print("Update this post" +
                                                    postId);
                                                // post update sayfasına gidilcek
                                              }),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            : showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    //title: Text("Add Comment"),
                                    content: Container(
                                      height: 160,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                  child: Icon(Icons.close),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  })
                                            ],
                                          ),
                                          OutlinedButton(
                                              child: Text("Report"),
                                              onPressed: () async {
                                                print("Report this post" +
                                                    postId);
                                              }),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                      },
                    )
                    // Icon(
                    //   Icons.more_horiz,
                    //   size: 25,
                    // ),

                    ),
              ]),
            ),
            //

            //
          ],
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Text("Location: $location")),
      ],
    );
  }
}

class PostHeaderDivider extends StatelessWidget {
  const PostHeaderDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 20,
      thickness: 2,
    );
  }
}

class Posts extends StatelessWidget {
  final List<PostBase> items;

  Posts(this.items);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: this.items,
      ),
    );
    //  return ListView(
    //   // padding: const EdgeInsets.all(8),
    //   children: this.items,
    //   shrinkWrap: true,
    // );
  }
}

class TextPost extends PostBase {
  final String text;
  final bool isMine;
  TextPost(
      {required this.text,
      username,
      profileImage,
      required this.isMine,
      postId,
      Location})
      : super(
            profileImage: profileImage,
            username: username,
            isMine: isMine,
            postId: postId,
            Loc: Location);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.fromLTRB(10, 0, 10, 14),
        child: Padding(
          padding: EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PostHeader(
                profileImage: profileImage,
                username: username,
                isMine: isMine,
                postId: postId,
                location: Loc,
              ),
              PostHeaderDivider(),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  this.text,
                ),
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
                            '32164',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            IconData(0xe17e, fontFamily: 'MaterialIcons'),
                            size: 16.0,
                            color: Colors.black45,
                          ),
                          onPressed: () {},
                        ),
                        Container(
                          margin: const EdgeInsets.all(6.0),
                          child: Text(
                            '321',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            IconData(0xf378, fontFamily: 'MaterialIcons'),
                            size: 16.0,
                            color: Colors.black45,
                          ),
                          onPressed: () {},
                        ),
                        Container(
                          margin: const EdgeInsets.all(6.0),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
