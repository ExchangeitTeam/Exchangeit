import 'package:flutter/material.dart';
import 'package:exchangeit/Objects/NotificationClass.dart';

class NotificationTile extends StatelessWidget {
  final NotificationObj notificationObj;
  final VoidCallback remove;

  NotificationTile({required this.notificationObj, required this.remove});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: ClipOval(
                      child: Image.network(
                    notificationObj.profilePic,
                    fit: BoxFit.cover,
                  )),
                  backgroundColor: Colors.white,
                  radius: 50,
                ),
                Flexible(
                  child: Column(
                    children: [
                      Text(
                        notificationObj.user + ", " + notificationObj.action,
                      )
                    ],
                  ),
                ),
                /*
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: CircleAvatar(
                    child: Image.network(
                      "https://muze.gen.tr/img/maiden_tower_home.jpg",
                      fit: BoxFit.cover,
                    ),
                    backgroundColor: Colors.white,
                    radius: 30,
                  ),
                ),
                */
                IconButton(
                    onPressed: remove,
                    icon: const Icon(Icons.delete, size: 28, color: Colors.red))
              ],
            )));
  }
}
