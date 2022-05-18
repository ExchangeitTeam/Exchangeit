import 'package:exchangeit/SettingsOptions/ProfileEdit.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile()));
            },
            icon: Icon(
              Icons.edit,
              size: 30,
            ),
            label: Text(
              "Edit Profile",
              style: TextStyle(fontSize: 20),
            ),
            style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
                primary: Colors.black,
                fixedSize: Size(size.width, size.height * 0.1)),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.visibility_off,
              size: 30,
            ),
            label: Text(
              "Change profile visibility",
              style: TextStyle(fontSize: 20),
            ),
            style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
                primary: Colors.black,
                fixedSize: Size(size.width, size.height * 0.1)),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, 'PassChange');
            },
            icon: Icon(
              Icons.password,
              size: 30,
            ),
            label: Text(
              "Change password",
              style: TextStyle(fontSize: 20),
            ),
            style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
                primary: Colors.black,
                fixedSize: Size(size.width, size.height * 0.1)),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.delete_rounded,
              size: 30,
            ),
            label: Text(
              "Delete account",
              style: TextStyle(fontSize: 20),
            ),
            style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
                primary: Colors.black,
                fixedSize: Size(size.width, size.height * 0.1)),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.logout_outlined,
              size: 30,
            ),
            label: Text(
              "Logout",
              style: TextStyle(fontSize: 20),
            ),
            style: TextButton.styleFrom(
                alignment: Alignment.centerLeft,
                primary: Colors.black,
                fixedSize: Size(size.width, size.height * 0.1)),
          ),
        ],
      ),
    );
  }
}
