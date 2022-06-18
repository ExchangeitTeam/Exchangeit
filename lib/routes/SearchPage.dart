import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exchangeit/routes/UserSearch.dart';
import 'package:exchangeit/routes/private_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../services/FirestoreServices.dart';

class SearchMain extends StatefulWidget {
  const SearchMain({Key? key}) : super(key: key);

  @override
  State<SearchMain> createState() => _SearchMainState();
}

class _SearchMainState extends State<SearchMain> with TickerProviderStateMixin {
  void buttonPressed() {
    print('Button Pressed in Function');
  }

  late TabController _controller = TabController(length: 4, vsync: this);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 170, 229),
        title: Text('Search'),
        centerTitle: true,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.maxFinite,
            child: Align(
              alignment: Alignment.center,
              child: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.black,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.lightBlueAccent),
                indicatorColor: Colors.purpleAccent,
                indicatorWeight: 2,
                labelPadding: EdgeInsets.symmetric(horizontal: 40.0),
                tabs: [
                  Tab(
                    text: 'People',
                    icon: Icon(Icons.people_alt),
                  ),
                  Tab(
                    text: 'Post',
                    icon: Icon(Icons.comment),
                  ),
                  Tab(
                    text: 'Location',
                    icon: Icon(Icons.edit_location),
                  ),
                  Tab(
                    text: 'Topics',
                    icon: Icon(Icons.lightbulb_outlined),
                  ),
                ],
                controller: _controller,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: [
                SingleChildScrollView(child: SearchPeople()),
                SingleChildScrollView(child: SearchPost()),
                SingleChildScrollView(child: SearchLocation()),
                SingleChildScrollView(child: SearchTopic()),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SearchLocation extends StatefulWidget {
  const SearchLocation({Key? key}) : super(key: key);
  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  final _firestore = FirebaseFirestore.instance;
  final myController = TextEditingController();
  void buttonPressed() {
    print('Button Pressed in Function');
  }

  String loc = "";
  void Starter(String val) {
    setState(() {
      loc = val.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference locationsRef = _firestore.collection('Locations');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            enableSuggestions: true,
            cursorColor: Colors.green,
            onChanged: (val) => Starter(val),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
            stream: loc != "" && loc != null
                ? locationsRef
                    .where('searchKey', arrayContains: loc)
                    .snapshots()
                : locationsRef.where("name", isNull: false).snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> asyncSnapshot) {
              if (asyncSnapshot.hasError) {
                return Center(child: Text('Bir Hata Oluştu, Tekrar Deneyiniz'));
              } else {
                if (asyncSnapshot.hasData) {
                  List<DocumentSnapshot> listOfDocumentSnap =
                      asyncSnapshot.data!.docs;
                  return SingleChildScrollView(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: listOfDocumentSnap.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Row(
                            children: [
                              Text(
                                '#${listOfDocumentSnap[index].get('name')}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30.0,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'Subscribe',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20.0,
                                ),
                              ),
                              IconButton(
                                onPressed: buttonPressed,
                                icon: Icon(Icons.add_circle_outline_outlined),
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          onTap: () {},
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        color: Color.fromARGB(255, 0, 170, 229),
                        thickness: 5.0,
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
            }),
      ],
    );
  }
}

bool Private = false;
Future IsSearchProfilePrivate(var searchID) async {
  DocumentSnapshot docSnap =
      await FirestoreService.userCollection.doc(searchID).get();
  Private = await docSnap.get('checkPrivate');
}

class SearchPeople extends StatefulWidget {
  const SearchPeople({Key? key}) : super(key: key);
  @override
  State<SearchPeople> createState() => _SearchPeopleState();
}

class _SearchPeopleState extends State<SearchPeople> {
  final _firestore = FirebaseFirestore.instance;
  void buttonPressed() {
    print('Button Pressed in Function');
  }

  String user = "";
  void Starter(String val) {
    setState(() {
      user = val.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference usersRef = _firestore.collection('Users');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            enableSuggestions: true,
            cursorColor: Colors.green,
            onChanged: (val) => Starter(val),
          ),
        ),
        Container(
          color: Colors.white38,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Divider(
                  color: Color.fromARGB(255, 0, 170, 229),
                  thickness: 5.0,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: user != "" && user != null
                        ? usersRef
                            .where("userSearch", arrayContains: user)
                            .snapshots()
                        : usersRef.where("username", isNull: false).snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> asyncSnapshot) {
                      if (asyncSnapshot.hasError) {
                        return Center(
                            child: Text('Bir Hata Oluştu, Tekrar Deneyiniz'));
                      } else {
                        if (asyncSnapshot.hasData) {
                          List<DocumentSnapshot> listOfDocumentSnap =
                              asyncSnapshot.data!.docs;
                          return SingleChildScrollView(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: listOfDocumentSnap.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          'https://png.pngitem.com/pimgs/s/64-646593_thamali-k-i-s-user-default-image-jpg.png',
                                        ),
                                        radius: 25,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      child: Container(
                                        child: Text(
                                          '@${listOfDocumentSnap[index].get('username')}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25.0,
                                          ),
                                        ),
                                      ),
                                      onTap: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => UserSearch(
                                                  SearchedId: listOfDocumentSnap[index].get('userId')
                                              )
                                          )
                                        );

                                        /*
                                        await IsSearchProfilePrivate(
                                            listOfDocumentSnap[index]
                                                .get('userId'));
                                        if (Private) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    privateProfileView(
                                                        uid: listOfDocumentSnap[
                                                                index]
                                                            .get('userId'))),
                                          );
                                          print(
                                              '@${listOfDocumentSnap[index].get('userId')}');
                                        } else {}

                                         */
                                      },
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) => Divider(
                                color: Color.fromARGB(255, 0, 170, 229),
                                thickness: 5.0,
                              ),
                            ),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SearchTopic extends StatefulWidget {
  const SearchTopic({Key? key}) : super(key: key);

  @override
  State<SearchTopic> createState() => _SearchTopicState();
}

class _SearchTopicState extends State<SearchTopic> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            enableSuggestions: true,
            cursorColor: Colors.green,
          ),
        ),
        Container(
          color: Colors.white38,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Divider(
                color: Colors.blue,
                thickness: 5.0,
              ),
              Row(
                children: [
                  Text(
                    '#ErasmusInGermany',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Subscribe',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_circle_outline_outlined),
                    color: Colors.blue,
                  ),
                ],
              ),
              Divider(
                color: Colors.blue,
                thickness: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '#SabanciUniLessons',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Subscribe',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_circle_outline_outlined),
                    color: Colors.blue,
                  ),
                ],
              ),
              Divider(
                color: Colors.blue,
                thickness: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '#SabanciUniFoods',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Subscribe',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_circle_outline_outlined),
                    color: Colors.blue,
                  ),
                ],
              ),
              Divider(
                color: Colors.blue,
                thickness: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '#ExperienceInPoland',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Subscribe',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_circle_outline_outlined),
                    color: Colors.blue,
                  ),
                ],
              ),
              Divider(
                color: Colors.blue,
                thickness: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '#PlacesInTurkey',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Subscribe',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_circle_outline_outlined),
                    color: Colors.blue,
                  ),
                ],
              ),
              Divider(
                color: Colors.blue,
                thickness: 5.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SearchPost extends StatefulWidget {
  const SearchPost({Key? key}) : super(key: key);

  @override
  State<SearchPost> createState() => _SearchPostState();
}

class _SearchPostState extends State<SearchPost> {
  final _firestore = FirebaseFirestore.instance;
  void buttonPressed() {
    print('Button Pressed in Function');
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference usersRef = _firestore.collection('Users');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            enableSuggestions: true,
            cursorColor: Colors.green,
          ),
        ),
        Container(
          color: Colors.white38,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Divider(
                color: Color.fromARGB(255, 0, 170, 229),
                thickness: 5.0,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: usersRef.snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> asyncSnapshot) {
                    if (asyncSnapshot.hasError) {
                      return Center(
                          child: Text('Bir Hata Oluştu, Tekrar Deneynizi'));
                    } else {
                      if (asyncSnapshot.hasData) {
                        List<DocumentSnapshot> listOfDocumentSnap =
                            asyncSnapshot.data!.docs;
                        return SingleChildScrollView(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: listOfDocumentSnap.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  //Navigator.pushNamed(context, 'PrivProfile');
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          'https://i.pinimg.com/originals/e6/98/29/e69829a5ae26c1724f59eb3834b471d3.jpg',
                                        ),
                                        radius: 25,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '@${listOfDocumentSnap[index].get('username')}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25.0,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) => Divider(
                              color: Color.fromARGB(255, 0, 170, 229),
                              thickness: 5.0,
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                  }),
              Divider(
                color: Color.fromARGB(255, 0, 170, 229),
                thickness: 5.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
