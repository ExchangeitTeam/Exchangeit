import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Objects/UserClass.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

Future setPreferences(User currentUser) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('settingsChanged', true);
  await prefs.setString('name', currentUser.name ?? "");
  await prefs.setString('userName', currentUser.userName ?? "");
  await prefs.setString('email', currentUser.email ?? "");
  await prefs.setString('biography', currentUser.biography ?? "");
  await prefs.setBool('private', currentUser.private);
}

Future<User> _getPreferences() async {
  var currentUser =
      User(name: "", userName: "", email: "", biography: "", private: false);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  currentUser.name = prefs.getString('name');
  currentUser.userName = prefs.getString('userName');
  currentUser.email = prefs.getString('email');
  currentUser.biography = prefs.getString('biography');
  currentUser.private = prefs.getBool('private')!;
  return currentUser;
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  var _currentUserSettings =
      User(name: "", userName: "Enis", email: "", private: false);
  var _newUserSettings =
      User(name: "", userName: "", email: "", private: false);
  @override
  void initState() {
    setState(() {
      _getPreferences().then((User currentUser) {
        setState(() {
          _currentUserSettings = currentUser;
        });
      });
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size sizeapp = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile Settings"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      width: sizeapp.width * 0.8,
                      child: TextFormField(
                        initialValue: _currentUserSettings.userName,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        enableSuggestions: true,
                        autocorrect: false,
                        decoration: InputDecoration(
                          label: Text("Username"),
                          fillColor: Colors.grey[200],
                          filled: true,
                          hintText: "New username",
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        validator: (value) {
                          if (value != null) {
                            if (value.length < 4) {
                              return 'new username too short';
                            }
                          }
                        },
                        onSaved: (value) {
                          if (value == null || value == "") {
                            value = _currentUserSettings.name;
                          }
                          _newUserSettings.name = value;
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
                        initialValue: _currentUserSettings.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          label: Text("Email"),
                          fillColor: Colors.grey[200],
                          filled: true,
                          hintText: "Email",
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        validator: (value) {
                          if (value != null) {
                            if (!EmailValidator.validate(value)) {
                              return 'Please enter a valid e-mail address';
                            }
                          }
                        },
                        onSaved: (value) {
                          if (value == null || value == "") {
                            value = _currentUserSettings.email;
                          }
                          _newUserSettings.email = value;
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
                        maxLines: 5,
                        initialValue: _currentUserSettings.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          label: Text("Bio"),
                          fillColor: Colors.grey[200],
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        onSaved: (value) {
                          if (value == null || value == "") {
                            value = _currentUserSettings.biography;
                          }
                          _newUserSettings.biography = value;
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            setPreferences(_newUserSettings);
                            Navigator.pop(context);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: Text(
                            'Save Changes',
                            //TO DO:style,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
