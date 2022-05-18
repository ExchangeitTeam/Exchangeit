import 'package:exchangeit/routes/profile_page_gallery.dart';
import 'package:flutter/material.dart';
import 'package:exchangeit/routes/profile_page_base_screen.dart';
import 'package:exchangeit/routes/profile_page_posts.dart';
import 'package:exchangeit/routes/profile_page_gallery.dart';
import 'package:exchangeit/routes/profile_page_location.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 170, 229),
        elevation: 0.0,
        title: Text(
          "Ayşe Aydemir",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'Settings');
            },
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    BaseScreenView(),
                  ],
                ),
              ),
            ];
          },
          body: Column(
            children: <Widget>[
              Material(
                color: Colors.white,
                child: TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey[400],
                  indicatorWeight: 1,
                  indicatorColor: Colors.black,
                  tabs: [
                    Tab(
                      icon: Icon(IconData(0xf435, fontFamily: 'MaterialIcons')),
                    ),
                    Tab(
                      icon: Icon(IconData(0xf131, fontFamily: 'MaterialIcons')),
                    ),
                    Tab(
                      icon: Icon(IconData(0xf193, fontFamily: 'MaterialIcons')),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Post(),
                    Gallery(),
                    Location(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
