import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: SearchMain()));
}
class SearchMain extends StatefulWidget {
  const SearchMain({Key? key}) : super (key: key);

  @override
  State<SearchMain> createState() => _SearchMainState();
}

class _SearchMainState extends State<SearchMain> {
  void buttonPressed() {
    print('Button Pressed in Function');
  }
  var _pages = [SearchLocation(),SearchTopic(),SearchPeople()];
  int selected_item = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children : _pages,
        onPageChanged: (index){
          setState(() {
            selected_item = index;
          });
        },
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
  final formKeySign = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0 , 170, 229),
        title: Text('Search'),
        centerTitle: true,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height:40.0,
            color: Color.fromARGB(255, 0 , 170, 229),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.black87,
                    backgroundColor: Colors.white,
                    minimumSize: Size(88, 36),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchLocation()));
                  },
                  child: Text('Location'),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.black87,
                    backgroundColor: Colors.white,
                    minimumSize: Size(88, 36),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchTopic()));
                  },
                  child: Text('Topic'),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.black87,
                    backgroundColor: Colors.white,
                    minimumSize: Size(88, 36),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchPeople()));
                  },
                  child: Text('People'),
                ),
              ],
            ),
          ),
          Form(
            key: formKeySign,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.search,
                    size: 30.0),

              ],
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
                      '#Germany',
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
                      onPressed: (){},
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
                      '#Turkey',
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
                      onPressed: (){},
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
                      '#Netherlands',
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
                      onPressed: (){},
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
                      '#Poland',
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
                      onPressed: (){},
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
                      '#USA',
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
                      onPressed: (){},
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
      ),
    );
  }
}
class SearchPeople extends StatefulWidget {
  const SearchPeople({Key? key}) : super(key: key);
  @override
  State<SearchPeople> createState() => _SearchPeopleState();
}

class _SearchPeopleState extends State<SearchPeople> {
  void buttonPressed() {
    print('Button Pressed in Function');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0 , 170, 229),
        title: Text('Search'),
        centerTitle: true,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height:40.0,
            color: Color.fromARGB(255, 0 , 170, 229),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.black87,
                    backgroundColor: Colors.white,
                    minimumSize: Size(88, 36),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchLocation()));
                  },
                  child: Text('Location'),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.black87,
                    backgroundColor: Colors.white,
                    minimumSize: Size(88, 36),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchTopic()));
                  },
                  child: Text('Topic'),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.black87,
                    backgroundColor: Colors.white,
                    minimumSize: Size(88, 36),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchPeople()));
                  },
                  child: Text('People'),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white38,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Icons.search,
                          size: 30.0),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Color.fromARGB(255, 0 , 170, 229),
                  thickness: 5.0,
                ),
                Row(
                  children: [
                    Padding(
                      padding:const EdgeInsets.all(3.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://i.pinimg.com/originals/e6/98/29/e69829a5ae26c1724f59eb3834b471d3.jpg',
                        ),
                        radius: 25,
                      ),
                    ),
                    SizedBox(
                      width:10,
                    ),
                    Text(
                      '@MehmetSürünen',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Color.fromARGB(255, 0 , 170, 229),
                  thickness: 5.0,
                ),
                Row(
                  children: [
                    Padding(
                      padding:const EdgeInsets.all(3.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://i.pinimg.com/originals/e6/98/29/e69829a5ae26c1724f59eb3834b471d3.jpg',
                        ),
                        radius: 25,
                      ),
                    ),
                    SizedBox(
                      width:10,
                    ),
                    Text(
                      '@AhmetYerebakan',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                      ),
                    )
                  ],
                ),
                Divider(
                  color:Color.fromARGB(255, 0 , 170, 229),
                  thickness: 5.0,
                ),
                Row(
                  children: [
                    Padding(
                      padding:const EdgeInsets.all(3.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://img.chip.com.tr/rcman/Cw940h529q95gm/images/content/201407050205465146.jpg',
                        ),
                        radius: 25,
                      ),
                    ),
                    SizedBox(
                      width:10,
                    ),
                    Text(
                      '@AyseOlmez',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                      ),
                    )
                  ],
                ),
                Divider(
                  color: Color.fromARGB(255, 0 , 170, 229),
                  thickness: 5.0,
                ),
                Row(
                  children: [
                    Padding(
                      padding:const EdgeInsets.all(3.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://img.chip.com.tr/rcman/Cw940h529q95gm/images/content/201407050205465146.jpg',
                        ),
                        radius: 25,
                      ),
                    ),
                    SizedBox(
                      width:10,
                    ),
                    Text(
                      '@ZeynepOlmez',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                      ),
                    )
                  ],
                ),
                Divider(
                  color: Color.fromARGB(255, 0 , 170, 229),
                  thickness: 5.0,
                ),
                Row(
                  children: [
                    Padding(
                      padding:const EdgeInsets.all(3.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://i.pinimg.com/originals/e6/98/29/e69829a5ae26c1724f59eb3834b471d3.jpg',
                        ),
                        radius: 25,
                      ),
                    ),
                    SizedBox(
                      width:10,
                    ),
                    Text(
                      '@İsmailDag',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                      ),
                    )
                  ],
                ),
                Divider(
                  color: Color.fromARGB(255, 0 , 170, 229),
                  thickness: 5.0,
                ),
              ],
            ),
          ),
        ],
      ),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0 , 170, 229),
        title: Text('Search'),
        centerTitle: true,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height:40.0,
            color: Color.fromARGB(255, 0 , 170, 229),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.black87,
                    backgroundColor: Colors.white,
                    minimumSize: Size(88, 36),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchLocation()));
                  },
                  child: Text('Location'),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.black87,
                    backgroundColor: Colors.white,
                    minimumSize: Size(88, 36),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchTopic()));
                  },
                  child: Text('Topic'),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.black87,
                    backgroundColor: Colors.white,
                    minimumSize: Size(88, 36),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchPeople()));
                  },
                  child: Text('People'),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white38,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Icons.search,
                          size: 30.0),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Search for location...',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
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
                      onPressed: (){},
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
                      onPressed: (){},
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
                      onPressed: (){},
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
                      onPressed: (){},
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
                      onPressed: (){},
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
      ),
    );
  }
}

