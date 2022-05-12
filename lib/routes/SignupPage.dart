import 'package:email_validator/email_validator.dart';
import 'package:exchangeit/routes/SettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKeySign = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size sizeapp = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xF3F3F3F3),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 25),
          padding: EdgeInsets.fromLTRB(25, 105, 25, 40),
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 110),
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
                            validator: (value) {
                              if (value != null) {
                                if (value.isEmpty) {
                                  return 'Cannot leave username empty';
                                }
                                if (value.length < 4) {
                                  return 'username too short';
                                }
                              }
                            },
                            onSaved: (value) {},
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
                            validator: (value) {
                              if (value != null) {
                                if (value.isEmpty) {
                                  return 'Cannot leave password empty';
                                }
                                if (value.length < 4) {
                                  return 'password too short';
                                }
                              }
                            },
                            onSaved: (value) {},
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
                            validator: (value) {
                              if (value != null) {
                                if (value.isEmpty) {
                                  return 'Cannot leave e-mail empty';
                                }
                                if (!EmailValidator.validate(value)) {
                                  return 'Please enter a valid e-mail address';
                                }
                              }
                            },
                            onSaved: (value) {},
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
                            validator: (value) {
                              if (value != null) {
                                if (value.isEmpty) {
                                  return 'Cannot leave age empty';
                                }
                                if (int.parse(value) < 0 ||
                                    int.parse(value) > 100) {
                                  return 'Please enter a valid age';
                                }
                              }
                            },
                            onSaved: (value) {},
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
                            validator: (value) {
                              if (value != null) {
                                if (value.isEmpty) {
                                  return 'Cannot leave University empty';
                                }
                                if (value.length < 4) {
                                  return 'University name too short';
                                }
                              }
                            },
                            onSaved: (value) {},
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Settings()));
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
                      SizedBox(height: 50),
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
