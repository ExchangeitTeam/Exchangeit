import 'package:flutter/material.dart';

class chatMsg {
  String msgContent;
  int receiver;

  chatMsg({
    required this.msgContent,
    required this.receiver,
  });
}

List<chatMsg> messages = [
  chatMsg(msgContent: "Hello, Will", receiver: 1),
  chatMsg(msgContent: "How have you been?", receiver: 1),
  chatMsg(msgContent: "Hey Kriss, I am doing fine dude. wbu?", receiver: 0),
  chatMsg(msgContent: "ehhhh, doing OK.", receiver: 1),
  chatMsg(msgContent: "Is there any thing wrong?", receiver: 0),
];