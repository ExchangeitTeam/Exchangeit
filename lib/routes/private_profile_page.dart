import 'package:exchangeit/models/Colors.dart';
import 'package:flutter/material.dart';
import 'package:exchangeit/routes/private_profile_page_base_screen.dart';
import 'package:flutter/rendering.dart';

class privateProfileView extends StatefulWidget {
  const privateProfileView({Key? key}) : super(key: key);

  @override
  State<privateProfileView> createState() => _privateProfileViewState();
}

class _privateProfileViewState extends State<privateProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.appBackColor,
        elevation: 0.0,
        title: Text(
          "Mehmet Sürünen",
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
            onPressed: () {},
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
                    privateBaseScreenView(),
                  ],
                ),
              ),
            ];
          },
          body: Column(
            children: [
              Column(
                children: [
                  Icon(Icons.lock, size: 50),
                ],
              ),
              Column(
                children: [
                  Text(
                    "This Account is Private",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
