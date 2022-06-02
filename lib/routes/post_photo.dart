import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../services/Appanalytics.dart';

class SharePhoto extends StatefulWidget {
  const SharePhoto({Key? key, required this.analytics}) : super(key: key);
  final FirebaseAnalytics? analytics;
  @override
  State<SharePhoto> createState() => _SharePhotoState();
}

class buttonInfo extends StatelessWidget {
  final String text;

  buttonInfo({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size sizeapp = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      //margin: const EdgeInsets.all(3.0),
                      //padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                      primary: Colors.black,
                      textStyle: const TextStyle(fontSize: 18),
                      fixedSize: Size(sizeapp.width * 0.75, 50),
                    ),
                    onPressed: () {},
                    child: Text(this.text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SharePhotoState extends State<SharePhoto> {
  final List<buttonInfo> buttonInfos = [
    buttonInfo(text: 'Take a Photo'),
    buttonInfo(text: 'Add from galery'),
  ];

  @override
  Widget build(BuildContext context) {
    setCurrentScreenUtil(screenName: "Share Post Page");
    return Container(
      color: Colors.white,
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return buttonInfos[index];
        },
        separatorBuilder: (BuildContext context, int index) => Divider(
          height: 3,
        ),
        itemCount: buttonInfos.length,
      ),
    );
  }
}
