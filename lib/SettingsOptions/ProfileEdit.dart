import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Objects/UserClass.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  String university = '';
  String username = '';
  String age = '';
  String bio = '';
  String profile_image = '';
  final _impicker = ImagePicker();
  File? _imageFile = null;
  SettingUser curruser_profile = SettingUser('', '', '', '', '');
  //TO DO:image picker backend
  Future pickImage() async {
    // ignore: deprecated_member_use
    final pickedFile = await _impicker.pickImage(source: ImageSource.gallery);

    setState(() {
      pickedFile != null
          ? _imageFile = File(pickedFile.path)
          : _imageFile = null;
    });
  }
  //TO DO:image upload backend
  //TO D0:profile update

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
                    child: InkWell(
                      onTap: () {
                        //TO DO:İmage picker function
                        pickImage();
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.blueGrey, // !!change later
                        child: ClipOval(
                          child: _imageFile == null
                              ? Image.asset(
                                  'images/addphoto.png',
                                  fit: BoxFit.fitHeight,
                                ) //değişecek
                              : Image.file(_imageFile!),
                        ),
                        radius: 50,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      width: sizeapp.width * 0.8,
                      child: TextFormField(
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
                        validator: (String? value) {
                          if (value!.isEmpty || value == '') {
                            username = ''; //değişmediğini belirtmek için
                          } else {
                            if (value.length < 4) {
                              return 'new username too short';
                            }
                            username = value;
                          }
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      width: sizeapp.width * 0.8,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        enableSuggestions: true,
                        autocorrect: false,
                        decoration: InputDecoration(
                          label: Text("University"),
                          fillColor: Colors.grey[200],
                          filled: true,
                          hintText: "New university",
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
                        validator: (String? value) {
                          if (value!.isEmpty || value == '') {
                            university = ''; //değişmediğini belirtmek için
                          } else {
                            university = value;
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
                          label: Text("Age"),
                          fillColor: Colors.grey[200],
                          filled: true,
                          hintText: " New Age",
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
                        validator: (String? value) {
                          if (value == null || value == "") {
                            age = "";
                          } else {
                            age = value;
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
                        maxLines: 5,
                        keyboardType: TextInputType.text,
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
                        onSaved: (String? value) {
                          if (value == null || value == "") {
                            bio = "";
                          } else {
                            bio = value;
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: OutlinedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              if (false) {
                              } //To Do: username already exist check
                              else {
                                if (_imageFile == null) {
                                  //TO DO:profile update function
                                  Navigator.pop(context);
                                } else {
                                  //TO DO:update profile  image function
                                  Navigator.pop(context);
                                }
                                setState(() {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.green,
                                      elevation: 10,
                                      content: Text('Profile Updated'),
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 12),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                });
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'Save Changes',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.green),
                        ),
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
