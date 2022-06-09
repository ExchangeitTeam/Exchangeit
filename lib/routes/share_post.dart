import 'dart:io' as io;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exchangeit/models/Colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:exchangeit/routes/post_photo.dart';
import 'package:exchangeit/routes/post_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../main.dart';
import '../services/Appanalytics.dart';
import 'package:path/path.dart';

class SharePostScreen extends StatefulWidget {
  const SharePostScreen({Key? key, required this.analytics}) : super(key: key);
  final FirebaseAnalytics analytics;
  @override
  State<SharePostScreen> createState() => _SharePostScreenState();
}

class _SharePostScreenState extends State<SharePostScreen> {
  File? _imageFile = null;
  final _currentuser = FirebaseAuth.instance.currentUser;
  String post_message = '';
  String location = '';
  final _PostKey = GlobalKey<FormState>();
  final _textFormControllercontent = TextEditingController();
  final _textFormControllerlocation = TextEditingController();

  showDialogueForWaiting(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => WaitingScreen(
            message: "Your post is being created, please wait..."));
  }

  hideProgressDialogue(BuildContext context) {
    Navigator.of(context).pop(
        WaitingScreen(message: "Your post is being created, please wait..."));
  }

  Future pickImage() async {
    // ignore: deprecated_member_use
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  Future uploadPostwithImage(BuildContext context, message) async {
    showDialogueForWaiting(context);
    String fileName = basename(_imageFile!.path);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts')
        .child(_currentuser!.uid)
        .child('/$fileName');

    var url;

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': fileName});
    firebase_storage.UploadTask uploadTask;

    uploadTask = ref.putFile(io.File(_imageFile!.path)!, metadata);

    firebase_storage.UploadTask task = await Future.value(uploadTask);
    Future.value(uploadTask)
        .then((value) async => {
              url = await value.ref.getDownloadURL(),
              print(url),
              FirebasePostUpload(_currentuser!.uid, 0, url, message),
              print("Upload file path ${value.ref.fullPath}"),
              hideProgressDialogue(context),
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  elevation: 10,
                  content:
                      Text("Your Post successfully uploaded,check feed page"),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  behavior: SnackBarBehavior.floating,
                ),
              ),
            })
        .onError((error, stackTrace) =>
            {print("Upload file path error ${error.toString()} ")});
  }

  Future FirebasePostUpload(uid, like, url, content) async {
    final firestoreInstance = FirebaseFirestore.instance;

    List<String> indexList = [];

    for (int i = 1; i <= location.length; i++) {
      indexList.add(location.substring(0, i).toLowerCase());
    }
    firestoreInstance
        .collection("Users")
        .doc(_currentuser!.uid)
        .collection('posts')
        .add({
      "image_url": url,
      "likeCount": like,
      "comments": [],
      "content": content,
      "datetime": DateTime.now(),
      "location": location,
      "likedBy": [],
      "sharedFrom": '',
      'location_key': indexList,
      "userID": _currentuser!.uid,
    }).then((value) {
      print(value.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    Appanalytics.setCurrentScreenUtil(screenName: "Share Post Page");
    Size sizeapp = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.appBarColor,
        actions: [
          const Spacer(),
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
              textStyle: const TextStyle(fontSize: 18),
            ),
            child: Text('Post'),
            onPressed: () {
              if (_PostKey.currentState!.validate()) {
                if (_imageFile == null) {
                  FirebasePostUpload(_currentuser!.uid, 0, '', post_message);
                } else {
                  uploadPostwithImage(context, post_message);
                }
              }
              _textFormControllercontent.clear();
              _textFormControllerlocation.clear();
              setState(() {
                _imageFile = null;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Form(
              key: _PostKey,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      height: sizeapp.width * 0.8,
                      width: sizeapp.height * 0.8,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 3.0, color: AppColors.buttonColor),
                        borderRadius: BorderRadius.all(Radius.circular(
                                50.0) //                 <--- border radius here
                            ),
                      ),
                      margin: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 25.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(70)),
                        child: _imageFile != null
                            ? InkWell(
                                onTap: pickImage,
                                child: Image.file(_imageFile!),
                              )
                            : OutlinedButton(
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 50,
                                ),
                                onPressed: pickImage,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: Container(
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        controller: _textFormControllercontent,
                        textAlign: TextAlign.center,
                        maxLines: null,
                        decoration: new InputDecoration(
                          hintText: "Write your content..",
                          fillColor: Colors.black,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                        ),
                        validator: (String? value) {
                          if (value == '' || value == null) {
                            return 'Please enter some text';
                          } else {
                            post_message = value;
                            print(post_message);
                            print('post message yazdirma yeri');
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: Container(
                      child: TextFormField(
                        controller: _textFormControllerlocation,
                        textAlign: TextAlign.center,
                        decoration: new InputDecoration(
                          hintText: "Enter Location...",
                          fillColor: Colors.black,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                        ),
                        validator: (String? value) {
                          if (value == '' || value == null) {
                            return null;
                          } else {
                            location = value;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
