import 'package:exchangeit/routes/WelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      imagename: "images/hi_cartoon.png",
      currPage: 0),
  WalkthroughScreen(
      header: "Meet with  Exchange students!",
      bottom: "Don’t miss anything!",
      imagename: "images/students.png",
      currPage: 1),
  WalkthroughScreen(
      header: "Follow Erasmus students from all over the world!",
      bottom:
          "Are you having trouble finding someone who has done Erasmus? We’re right there with you.",
      imagename: "images/Worldcircle.png",
      currPage: 2),
  WalkthroughScreen(
      header: "Chat With People!",
      bottom: "Talk one-on-one with people",
      imagename: "images/chatting.png",
      currPage: 3)
];

class WalkItem extends StatelessWidget {
  final int index;
  WalkItem(this.index);
  void setSeenTrue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen', true);
    print("girdi");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            WalkPagesList[index].header,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 25),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 300,
                padding: EdgeInsets.all(150),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        image: AssetImage(WalkPagesList[index].imagename),
                        fit: BoxFit.contain)),
              ),
            ],
          ),
          SizedBox(height: 30),
          Text(
            WalkPagesList[index].bottom,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 18),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              index == 3
                  ? OutlinedButton(
                      onPressed: () {
                        setSeenTrue();
                        Navigator.popAndPushNamed(context, "/welcome");
                      },
                      child: Text(
                        "Get Started",
                      ),
                    )
                  : SizedBox(height: 48)
            ],
          )
        ],
      ),
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
      height: isActive ? 14 : 10,
      width: isActive ? 14 : 10,
      decoration: BoxDecoration(
          color: isActive ? Colors.purpleAccent : Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
    throw UnimplementedError();
  }
}
