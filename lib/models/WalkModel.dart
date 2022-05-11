import 'package:flutter/material.dart';

class WalkthroughScreen {
  String header;
  String bottom;
  String imagename;
  int currPage;
  WalkthroughScreen(
      {required this.header,
      required this.bottom,
      required this.imagename,
      required this.currPage});
}

List<WalkthroughScreen> WalkPagesList = [
  WalkthroughScreen(
      header: "Welcome to Our App!",
      bottom: "Explore our app with a quick overview!",
      imagename: "images/google.png",
      currPage: 0),
  WalkthroughScreen(
      header: "Easily Follow Erasmus students!",
      bottom: "Don’t miss anything!",
      imagename: "images/google.png",
      currPage: 1),
  WalkthroughScreen(
      header: "3rd page!",
      bottom: "Don’t miss anything!",
      imagename: "images/google.png",
      currPage: 2)
];

class WalkItem extends StatelessWidget {
  final int index;
  WalkItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(WalkPagesList[index].imagename),
                      fit: BoxFit.cover)),
            ),
            SizedBox(height: 20),
            Text(
              WalkPagesList[index].header,
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 22),
            ),
            Text(
              WalkPagesList[index].bottom,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 18),
            )
          ],
        )
      ],
    );
  }
}

class WalkDots extends StatelessWidget {
  bool isActive;
  WalkDots(this.isActive);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? Theme.of(context).primaryColor : Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
    throw UnimplementedError();
  }
}
