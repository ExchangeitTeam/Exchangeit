import 'dart:ui';
import 'package:exchangeit/models/Colors.dart';
import 'package:exchangeit/routes/ForgotPassPage.dart';
import 'package:exchangeit/routes/LoggedIn.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:sign_button/sign_button.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'SignupPage.dart';

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
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.appBackColor,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: sizeapp.height,
          child: Stack(alignment: Alignment.center, children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "images/upper.png",
                width: sizeapp.width * 0.8,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GradientText("LOGIN",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      colors: [
                        Colors.blue,
                        Colors.deepPurpleAccent,
                        Colors.blueAccent,
                        Colors.deepPurpleAccent
                      ]),
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
                          fillColor: AppColors.textFormColor,
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
                          fillColor: AppColors.textFormColor,
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
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    width: sizeapp.width * 0.8,
                    alignment: Alignment.topRight,
                    child: TextButton(
                      child: Text("Forgot Password?",
                          style: TextStyle(color: Colors.black)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgetPass()));
                      },
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/LoggedIn", (Route<dynamic> route) => false);
                        /* if (_formKey.currentState!.validate()) {
                          print('Email: $email');
                          _formKey.currentState!.save();
                          print('Email: $email');
                          setState(() {
                            loginCounter++;
                          });

                        } */
                        /*else {
                          _showDialog('Form Error', 'Your form is invalid');
                        }*/
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.buttonColor,
                          fixedSize: Size(sizeapp.width * 0.75, 50)),
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
                    Text("OR", style: TextStyle(fontSize: 15)),
                    Expanded(
                        child: Divider(
                      thickness: 2,
                      indent: 10.0,
                      endIndent: 20.0,
                    )),
                  ]),
                  SizedBox(height: 20),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: SignInButton(
                          imagePosition: ImagePosition.left, // left or right
                          buttonType: ButtonType.google,
                          buttonSize: ButtonSize.large,
                          btnText: "Login with Google",
                          elevation: 10,
                          onPressed: () {
                            print('Google Pressed');
                          })),
                  SizedBox(height: 20),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: SignInButton(
                          imagePosition: ImagePosition.left, // left or right
                          buttonType: ButtonType.facebook,
                          buttonSize: ButtonSize.large,
                          btnText: "Login with Facebook",
                          elevation: 10,
                          onPressed: () {
                            print('Facebook Pressed');
                          })),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Need an Account? "),
                      TextButton(
                          onPressed: () {
                            Navigator.popAndPushNamed(context, "/SignUp");
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              decorationThickness: 2,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
