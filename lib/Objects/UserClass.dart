import 'package:flutter/material.dart';

class SettingUser {
  String university = '';
  String username = '';
  String age = '';
  String bio = '';
  String profile_image = '';
  SettingUser(
      this.username, this.university, this.age, this.bio, this.profile_image);
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
