import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class SearchMain extends StatefulWidget {
  const SearchMain({Key? key}) : super(key: key);

  @override
  State<SearchMain> createState() => _SearchMainState();
}

class _SearchMainState extends State<SearchMain> with TickerProviderStateMixin {
  void buttonPressed() {
    print('Button Pressed in Function');
  }

  late TabController _controller = TabController(length: 3, vsync: this);

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
                    text: 'Location',
                    icon: Icon(Icons.edit_location),
                  ),
                  Tab(
                    text: 'Topics',
                    icon: Icon(Icons.lightbulb_outlined),
                  ),
                  Tab(
                    text: 'People',
                    icon: Icon(Icons.people_alt),
                  ),
                ],
                controller: _controller,
              ),
            ),
          ),
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

              //onChanged: (val) => initiateSearch(val),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: [
                SingleChildScrollView(child: SearchLocation()),
                SingleChildScrollView(
                  child: SearchTopic(),
                ),
                SingleChildScrollView(child: SearchPeople()),
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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.white38,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Divider(
                color: Color.fromARGB(255, 0, 170, 229),
                thickness: 5.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'PrivProfile');
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
                      '@MehmetSürünen',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Color.fromARGB(255, 0, 170, 229),
                thickness: 5.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'PrivProfile');
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
                      '@AhmetYerebakan',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: Color.fromARGB(255, 0, 170, 229),
                thickness: 5.0,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://img.chip.com.tr/rcman/Cw940h529q95gm/images/content/201407050205465146.jpg',
                      ),
                      radius: 25,
                    ),
                  ),
                  SizedBox(
                    width: 10,
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
                color: Color.fromARGB(255, 0, 170, 229),
                thickness: 5.0,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://img.chip.com.tr/rcman/Cw940h529q95gm/images/content/201407050205465146.jpg',
                      ),
                      radius: 25,
                    ),
                  ),
                  SizedBox(
                    width: 10,
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
                color: Color.fromARGB(255, 0, 170, 229),
                thickness: 5.0,
              ),
              Row(
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
                    '@İsmailDag',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                    ),
                  )
                ],
              ),
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
