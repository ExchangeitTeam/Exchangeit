import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:sign_button/sign_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  int loginCounter = 0;
  String email = '';
  String pass = '';
  @override
  Widget build(BuildContext context) {
    Size sizeapp = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: sizeapp.height,
          child: Stack(alignment: Alignment.center, children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "images/lineartop.png",
                width: sizeapp.width,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "images/bottom.png",
                width: sizeapp.width * 0.8,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "LOGIN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                              return 'Please enter a yyyy valid e-mail address';
                            }
                          }
                        },
                        onSaved: (value) {
                          email = value ?? '';
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
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        enableSuggestions: false,
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
                            if (value.length < 6) {
                              return 'Password too short';
                            }
                          }
                        },
                        onSaved: (value) {
                          pass = value ?? '';
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: sizeapp.width * 0.8,
                    alignment: Alignment.topRight,
                    child: TextButton(
                      child: Text("Forgot Password?"),
                      onPressed: () {
                        print("Forgot pressed");
                      },
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('Email: $email');
                        _formKey.currentState!.save();
                        print('Email: $email');
                        setState(() {
                          loginCounter++;
                        });
                      } /*else {
                        _showDialog('Form Error', 'Your form is invalid');
                      }*/
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Login: $loginCounter',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(children: <Widget>[
                    Expanded(
                        child: Divider(
                      thickness: 2,
                      indent: 20.0,
                      endIndent: 10.0,
                    )),
                    Text("OR"),
                    Expanded(
                        child: Divider(
                      thickness: 2,
                      indent: 10.0,
                      endIndent: 20.0,
                    )),
                  ]),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: SignInButton(
                          imagePosition: ImagePosition.left, // left or right
                          buttonType: ButtonType.google,
                          buttonSize: ButtonSize.medium,
                          btnText: "Login with Google",
                          onPressed: () {
                            print('Google Pressed');
                          })),
                  SizedBox(height: 20),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: SignInButton(
                          imagePosition: ImagePosition.left, // left or right
                          buttonType: ButtonType.facebook,
                          buttonSize: ButtonSize.medium,
                          btnText: "Login with Facebook",
                          onPressed: () {
                            print('Facebook Pressed');
                          })),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
