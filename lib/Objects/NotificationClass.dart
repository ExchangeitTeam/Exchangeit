import 'package:flutter/material.dart';

class NotificationObj {
  Image profilePic;
  String action;
  String timestamp;
  String user;

  NotificationObj({
    required this.profilePic,
    required this.action,
    required this.timestamp,
    required this.user,
  });
}