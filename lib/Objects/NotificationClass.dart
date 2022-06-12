import 'package:flutter/material.dart';

class NotificationObj {
  String profilePic;
  String action;
  String timestamp;
  String user;
  String sender;
  String type;

  NotificationObj({
    required this.profilePic,
    required this.action,
    required this.timestamp,
    required this.user,
    required this.sender,
    required this.type,
  });
}