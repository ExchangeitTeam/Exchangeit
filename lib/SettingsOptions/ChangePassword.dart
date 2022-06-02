import 'package:email_validator/email_validator.dart';
import 'package:exchangeit/models/Colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../services/Appanalytics.dart';

class PassChange extends StatefulWidget {
  PassChange({Key? key, required this.analytics}) : super(key: key);
  final FirebaseAnalytics analytics;
  @override
  State<PassChange> createState() => _PassChangeState();
}

String current_pass = '';
String email = '';
String new_pass = '';

class _PassChangeState extends State<PassChange> {
  final passkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    setCurrentScreenUtil(screenName: "Change Password Page");
    Size sizeapp = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Change Password"),
        centerTitle: true,
        backgroundColor: AppColors.appBarColor,
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xF3F3F3F3)),
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
            child: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Change Password"),
                      ],
                    ),
                    SizedBox(height: 10),
                    Form(
                      key: passkey,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            width: sizeapp.width * 0.8,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: "Enter email",
                                fillColor: AppColors.textFormColor,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                } else if (!EmailValidator.validate(value)) {
                                  return 'Please enter a valid email address';
                                } else {
                                  email = value;
                                }
                                return null;
                              },
                            ),
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              width: sizeapp.width * 0.8,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.text,
                                obscureText: false,
                                enableSuggestions: true,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  fillColor: AppColors.textFormColor,
                                  filled: true,
                                  hintText: "Current Password",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                ),
                                validator: (value) {
                                  if (value != null) {
                                    if (value.isEmpty) {
                                      return 'Cannot leave Current password empty';
                                    } else if (value.length < 4) {
                                      return 'password too short';
                                    } else {
                                      current_pass = value;
                                    }
                                  }
                                },
                                onSaved: (value) {},
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            width: sizeapp.width * 0.8,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: "Enter new password",
                                fillColor: AppColors.textFormColor,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                } else if (value.length < 4) {
                                  return 'Password too short';
                                } else {
                                  new_pass = value;
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            width: sizeapp.width * 0.8,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: "Enter new password again",
                                fillColor: AppColors.textFormColor,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                } else if (value != new_pass) {
                                  return "Passwords don't match";
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "Update Password",
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
