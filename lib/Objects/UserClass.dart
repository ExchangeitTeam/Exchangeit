import 'package:flutter/material.dart';

import 'PostClass.dart';

class SettingUser {
  String university = '';
  String username = '';
  String age = '';
  String bio = '';
  String profile_image = '';
  SettingUser(
      this.username, this.university, this.age, this.bio, this.profile_image);
}

class User {
  String id = "";
  late NetworkImage profileImage;
  String university = '';
  String username = '';
  String age = '';
  String bio = '';
  String profile_image = '';
  List<User> followers = [];
  List<User> following = [];
  List<String> comments = [];
  List<PostBase> Posts = [];

  User(
    this.id,
    this.profileImage,
    this.username,
    this.university,
    this.age,
    this.bio,
    this.profile_image,
    this.followers,
    this.following,
    this.Posts,
  );
}
