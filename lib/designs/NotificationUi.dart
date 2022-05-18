import 'package:flutter/material.dart';
import 'package:exchangeit/Objects/NotificationClass.dart';

class NotificationTile extends StatelessWidget {

  final NotificationObj notificationObj;
  final VoidCallback remove;

  NotificationTile({
    required this.notificationObj,
    required this.remove
});

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
                child: Image.network("https://tr.web.img4.acsta.net/c_310_420/pictures/16/01/19/11/06/274206.jpg",
                  fit: BoxFit.cover,
                )
              ),
              backgroundColor: Colors.white,
              radius: 39,
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
            CircleAvatar(
              child: ClipOval(
                  child: Image.network("https://tr.web.img4.acsta.net/c_310_420/pictures/16/01/19/11/06/274206.jpg",
                    fit: BoxFit.cover,
                  )
              ),
              backgroundColor: Colors.white,
              radius: 39,
            ),
            IconButton(onPressed: remove, icon: const Icon(Icons.delete, size: 28, color: Colors.red))
            
          ],
        )
      )
    );
  }
}
