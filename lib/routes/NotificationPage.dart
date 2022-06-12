import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:exchangeit/Objects/NotificationClass.dart';
import 'package:exchangeit/designs/NotificationUi.dart';

import '../main.dart';


class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  List<NotificationObj> notifications = [];

  Future getNotification() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('notifications')
        .orderBy('datetime', descending: true)
        .get();

    DocumentSnapshot idSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .get();

    String userName = idSnapshot.get('username');

    for (var notification in snapshot.docs) {
      Timestamp t = notification.get('datetime');
      DateTime d = t.toDate();
      String date = d.toString().substring(0, 10);
      String nType = notification.get('follow_request');
      String action = notification.get('message');
      String senderId = notification.get('uid');
      DocumentSnapshot senderShot = await FirebaseFirestore.instance.collection('Users').doc(senderId).get();
      String senderName = senderShot.get('username');
      String picUrl = senderShot.get('profileIm');

      NotificationObj notObj = NotificationObj(
          profilePic: picUrl,
          action: action,
          timestamp: date,
          user: userName,
          sender: senderName,
          type: nType,
      );

      notifications.add(notObj);
    }
  }

  ////// DÜZELTİLECEK

  void deleteNotification(NotificationObj curr) {
    setState(() {
      notifications.remove(curr);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([getNotification()]),
      builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return WaitingScreen(message: "Loading Notifications");
      }

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color.fromARGB(255, 0, 170, 229),
            title: const Text(
              "Notifications",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: notifications
                    .map((notification) => NotificationTile(
                        notificationObj: notification,
                        remove: () {
                          deleteNotification(notification);
                        }))
                    .toList(),
              ),
            ),
          ),
        );
      }
    );
  }
}
