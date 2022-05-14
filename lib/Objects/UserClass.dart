import 'package:flutter/material.dart';

class User {
  int? userID;
  String? name;
  String? userName;
  String? profilePicturePath;
  String? gender;
  String? email;
  String? password;
  String? biography;
  List<User?>? followers;
  List<User?>? followings;
  List<Post?>? posts;
  int? followerCount;
  int? followingCount;
  int? postCount;
  bool private;

  User({
    this.userID,
    this.name,
    this.userName,
    this.profilePicturePath,
    this.email,
    this.password,
    this.biography,
    this.followers,
    this.followings,
    this.posts,
    this.followerCount,
    this.followingCount,
    this.postCount,
    required this.private,
  });
}

class Post {
  String? postID;
  String? text;
  var date;
  List<String?>? comments;
  int? likeCount;
  int? commentCount;

  Post({
    this.postID,
    this.text,
    this.comments,
    this.date,
    this.likeCount,
    this.commentCount,
  });
}
