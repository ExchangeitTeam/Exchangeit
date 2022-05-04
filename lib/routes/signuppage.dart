import 'package:flutter/material.dart';

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
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 25),
          padding: EdgeInsets.fromLTRB(25, 105, 25, 45),
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 110),
            child: ListView(
              children: [
                Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
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
                                  horizontal: 20, vertical: 20),
                              width: sizeapp.width * 0.8,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                obscureText: false,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  hintText: "Password",
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
                                      return 'Cannot leave password empty';
                                    }
                                    if (value.length < 6) {
                                      return 'Password too short';
                                    }
                                  }
                                },
                                onSaved: (value) {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ), //scrollanabilir liste
          ),
        ),
      ),
    );
  }
}
