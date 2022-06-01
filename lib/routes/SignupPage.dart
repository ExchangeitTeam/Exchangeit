import 'package:email_validator/email_validator.dart';
import 'package:exchangeit/models/Styles.dart';
import 'package:exchangeit/services/FirestoreServices.dart';
import 'package:exchangeit/services/auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../services/Appanalytics.dart';
import 'LoginPage.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key, required this.analytics}) : super(key: key);
  final FirebaseAnalytics analytics;
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKeySign = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String username = "";
  String age = "";
  String uni = "";

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.setCurrentScreen(screenName: "SignUp Page");
    Size sizeapp = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xF3F3F3F3),
      body: SafeArea(
        child: Container(
          //margin: EdgeInsets.fromLTRB(0, 10, 0, 25),
          padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  GradientText("SIGN UP",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      colors: [
                        Colors.blue,
                        Colors.deepPurpleAccent,
                        Colors.blueAccent,
                        Colors.deepPurpleAccent
                      ]),
                ]),
                SizedBox(height: 10),
                Form(
                  key: formKeySign,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //dokunmalı widget yapma
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            hoverColor: Colors.red,
                            onTap: () {
                              print("Pressed add profile page");
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.blueGrey,
                              radius: 50,
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          width: sizeapp.width * 0.8,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            enableSuggestions: true,
                            autocorrect: false,
                            decoration: InputDecoration(
                              fillColor: Colors.grey[200],
                              filled: true,
                              hintText: "Username",
                              enabledBorder: AppStyles.enableInputBorder,
                              focusedBorder: AppStyles.focusedInputBorder,
                              border: AppStyles.borderInput,
                            ),
                            validator: (value) {
                              if (value != null) {
                                if (value.isEmpty) {
                                  return 'Cannot leave username empty';
                                } else if (value.length < 4) {
                                  return 'username too short';
                                } else {
                                  username = value;
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          width: sizeapp.width * 0.8,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            enableSuggestions: true,
                            autocorrect: false,
                            decoration: InputDecoration(
                              fillColor: Colors.grey[200],
                              filled: true,
                              hintText: "Password",
                              enabledBorder: AppStyles.enableInputBorder,
                              focusedBorder: AppStyles.focusedInputBorder,
                              border: AppStyles.borderInput,
                            ),
                            validator: (value) {
                              if (value != null) {
                                if (value.isEmpty) {
                                  return 'Cannot leave password empty';
                                } else if (value.length < 4) {
                                  return 'password too short';
                                } else {
                                  password = value;
                                }
                              }
                            },
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          width: sizeapp.width * 0.8,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              fillColor: Colors.grey[200],
                              filled: true,
                              hintText: "Email",
                              enabledBorder: AppStyles.enableInputBorder,
                              focusedBorder: AppStyles.focusedInputBorder,
                              border: AppStyles.borderInput,
                            ),
                            validator: (value) {
                              if (value != null) {
                                if (value.isEmpty) {
                                  return 'Cannot leave e-mail empty';
                                } else if (!EmailValidator.validate(value)) {
                                  return 'Please enter a valid e-mail address';
                                } else {
                                  email = value;
                                }
                              }
                            },
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          width: sizeapp.width * 0.8,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              fillColor: Colors.grey[200],
                              filled: true,
                              hintText: "Age",
                              enabledBorder: AppStyles.enableInputBorder,
                              focusedBorder: AppStyles.focusedInputBorder,
                              border: AppStyles.borderInput,
                            ),
                            validator: (value) {
                              if (value != null) {
                                if (value.isEmpty) {
                                  return 'Cannot leave age empty';
                                } else if (int.parse(value) < 0 ||
                                    int.parse(value) > 100) {
                                  return 'Please enter a valid age';
                                } else {
                                  age = value;
                                }
                              }
                            },
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          width: sizeapp.width * 0.8,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            enableSuggestions: true,
                            autocorrect: false,
                            decoration: InputDecoration(
                              fillColor: Colors.grey[200],
                              filled: true,
                              hintText: "Exchange University",
                              enabledBorder: AppStyles.enableInputBorder,
                              focusedBorder: AppStyles.focusedInputBorder,
                              border: AppStyles.borderInput,
                            ),
                            validator: (value) {
                              if (value != null) {
                                if (value.isEmpty) {
                                  return 'Cannot leave University empty';
                                } else if (value.length < 3) {
                                  return 'University name too short';
                                } else {
                                  uni = value;
                                }
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: OutlinedButton(
                          onPressed: () async {
                            if (formKeySign.currentState!.validate()) {
                              print('Sign up pressed');
                              await FirestoreService.IsUsernameTaken(username)
                                  .then((value) async {
                                if (value) {
                                  return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title:
                                              Text('Username already taken!'),
                                          content: Text(
                                              'Please select another username!'),
                                        );
                                      });
                                } else {
                                  username = username.toLowerCase().trim();
                                  await AuthService.registerUser(
                                      email, username, uni, age, password);
                                  setState(() {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.green,
                                        elevation: 10,
                                        content: Text(
                                            'Registration Successful! You are redirecting to the home page'),
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 12),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  });
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      "/LoggedIn",
                                      (Route<dynamic> route) => false);
                                }
                              });
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 22,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              primary: Colors.black,
                              fixedSize: Size(sizeapp.width * 0.75, 70)),
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already a user?"),
                          TextButton(
                              onPressed: () {
                                Navigator.popAndPushNamed(context, "/Login");
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blueAccent,
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                )
              ],
            )), //scrollanabilir liste
          ),
        ),
      ),
    );
  }
}
