import 'package:exchangeit/models/Colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:exchangeit/Objects/DMClass.dart';
import 'package:exchangeit/designs/DMUi.dart';

import '../services/Appanalytics.dart';

class DMPage extends StatelessWidget {
  DMPage({Key? key,required this.analytics}) : super(key: key);
  final FirebaseAnalytics? analytics;
  List<DMObj> DMusers = [
    DMObj(
        name: "Jane Russel",
        msgTxt: "Awesome Setup",
        profileImg: const NetworkImage(
            "https://i.insider.com/5cb8b133b8342c1b45130629?width=700"),
        time: "Now"),
    DMObj(
        name: "Murphy",
        msgTxt: "That's Great",
        profileImg: const NetworkImage(
            "https://i.insider.com/61f14a0ce996470011907119?width=600&format=jpeg&auto=webp"),
        time: "Yesterday"),
    DMObj(
        name: "Henry",
        msgTxt: "Hey where are you?",
        profileImg: const NetworkImage(
            "https://i.insider.com/5cb8b133b8342c1b45130629?width=700"),
        time: "31 Mar"),
    DMObj(
        name: "Philip",
        msgTxt: "Busy! Call me in 20 mins",
        profileImg: const NetworkImage(
            "https://i.insider.com/61f14a0ce996470011907119?width=600&format=jpeg&auto=webp"),
        time: "28 Mar"),
    DMObj(
        name: "Debra",
        msgTxt: "Thankyou, It's awesome",
        profileImg: const NetworkImage(
            "https://i.insider.com/5cb8b133b8342c1b45130629?width=700"),
        time: "23 Mar"),
    DMObj(
        name: "Jacob Pena",
        msgTxt: "will update you in evening",
        profileImg: const NetworkImage(
            "https://i.insider.com/61f14a0ce996470011907119?width=600&format=jpeg&auto=webp"),
        time: "17 Mar"),
    DMObj(
        name: "Andrey Jones",
        msgTxt: "Can you please share the file?",
        profileImg: const NetworkImage(
            "https://i.insider.com/5cb8b133b8342c1b45130629?width=700"),
        time: "24 Feb"),
    DMObj(
        name: "John Wick",
        msgTxt: "How are you?",
        profileImg: const NetworkImage(
            "https://i.insider.com/61f14a0ce996470011907119?width=600&format=jpeg&auto=webp"),
        time: "18 Feb"),
  ];

  @override
  Widget build(BuildContext context) {
    setCurrentScreenUtil(
        analytics:analytics, screenName: "DM Page");
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.appBarColor,
          title: const Text(
            "Direct Messages",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 2, bottom: 2),
                    height: 30.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey,
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text("Add Contact", style: TextStyle(fontSize: 14))
                      ],
                    ),
                  )),
            )
          ],
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 13, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Contact...",
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade500,
                      size: 20,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: const EdgeInsets.all(4),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.grey.shade100,
                        ))),
              ),
            ),
            ListView.builder(
                itemCount: DMusers.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 16),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return contact(
                    name: DMusers[index].name,
                    msgTxt: DMusers[index].msgTxt,
                    profileImg: DMusers[index].profileImg,
                    time: DMusers[index].time,
                    isRead: index == 0 ? true : false,
                  );
                })
          ]),
        ));
  }
}
