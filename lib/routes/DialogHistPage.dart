import 'package:flutter/material.dart';
import 'package:exchangeit/Objects/chatMessage.dart';

class DialogPage extends StatefulWidget {
  final NetworkImage profileImg;
  final String userName;
  DialogPage({Key? key, required this.profileImg, required this.userName})
      : super(key: key);

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                SizedBox(width: 48),
                CircleAvatar(
                  backgroundImage: widget.profileImg,
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.userName,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8),
                    Text("Online",
                        style: TextStyle(
                            color: Colors.grey.shade100, fontSize: 13))
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 10, bottom: 10),
                    child: Align(
                      alignment: (messages[index].receiver == 1
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (messages[index].receiver == 1
                              ? Colors.grey.shade200
                              : Colors.blue[200]),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          messages[index].msgContent,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ));
              }),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 8, bottom: 8, top: 8),
              height: 60,
              width: double.infinity,
              color: Colors.grey.shade500,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: const TextField(
                        decoration: InputDecoration(
                      hintText: "Write the message...",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    )),
                  ),
                  SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.attachment),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  FloatingActionButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
