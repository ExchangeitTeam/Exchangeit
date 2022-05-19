import 'package:flutter/material.dart';
import 'package:exchangeit/designs/dialogHistUi.dart';
import 'package:exchangeit/routes/DialogHistPage.dart';

class contact extends StatefulWidget {
  String name;
  String msgTxt;
  NetworkImage profileImg;
  String time;
  bool isRead;

  contact(
      {required this.name,
      required this.msgTxt,
      required this.profileImg,
      required this.time,
      required this.isRead});

  @override
  State<contact> createState() => _contactState();
}

class _contactState extends State<contact> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DialogPage(
              profileImg: widget.profileImg,
              userName: widget.name,
            );
          }));
        },
        child: Container(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: widget.profileImg,
                maxRadius: 30,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.name,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      widget.msgTxt,
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          fontWeight: widget.isRead
                              ? FontWeight.bold
                              : FontWeight.normal),
                    )
                  ],
                ),
              )),
              Text(
                widget.time,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight:
                      widget.isRead ? FontWeight.bold : FontWeight.normal,
                ),
              )
            ],
          ),
        ));
  }
}
