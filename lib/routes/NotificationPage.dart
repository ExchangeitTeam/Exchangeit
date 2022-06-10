import 'package:flutter/material.dart';
import 'package:exchangeit/Objects/NotificationClass.dart';
import 'package:exchangeit/designs/NotificationUi.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  static String actionHolder =
      "Ahmet liked your photo,Lorem ipsum dolor sit amet,";

  List<NotificationObj> notifications = [
    NotificationObj(
        profilePic: Image.network(
            "https://tr.web.img4.acsta.net/c_310_420/pictures/16/01/19/11/06/274206.jpg"),
        action: actionHolder,
        timestamp: "2hrs ago",
        user: "Ayşe"),
    NotificationObj(
        profilePic: Image.network(
            "https://tr.web.img4.acsta.net/c_310_420/pictures/16/01/19/11/06/274206.jpg"),
        action: actionHolder,
        timestamp: "2hrs ago",
        user: "Ayşe"),
    NotificationObj(
        profilePic: Image.network(
            "https://tr.web.img4.acsta.net/c_310_420/pictures/16/01/19/11/06/274206.jpg"),
        action: actionHolder,
        timestamp: "2hrs ago",
        user: "Ayşe"),
    NotificationObj(
        profilePic: Image.network(
            "https://tr.web.img4.acsta.net/c_310_420/pictures/16/01/19/11/06/274206.jpg"),
        action: actionHolder,
        timestamp: "2hrs ago",
        user: "Ayşe"),
    NotificationObj(
        profilePic: Image.network(
            "https://tr.web.img4.acsta.net/c_310_420/pictures/16/01/19/11/06/274206.jpg"),
        action: actionHolder,
        timestamp: "2hrs ago",
        user: "Ayşe"),
    NotificationObj(
        profilePic: Image.network(
            "https://tr.web.img4.acsta.net/c_310_420/pictures/16/01/19/11/06/274206.jpg"),
        action: actionHolder,
        timestamp: "2hrs ago",
        user: "Ayşe"),
  ];

  void deleteNotification(NotificationObj curr) {
    setState(() {
      notifications.remove(curr);
    });
  }

  @override
  Widget build(BuildContext context) {
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
}
