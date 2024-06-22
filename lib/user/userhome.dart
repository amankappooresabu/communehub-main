import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communehub/community/communityhome.dart';
import 'package:communehub/competitions/competitionscreen.dart';
import 'package:communehub/events/eventscreen.dart';
import 'package:communehub/execom_call/execom_main.dart';
import 'package:communehub/user/loginscreen.dart';
import 'package:communehub/user/userprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class Event {
  final String name;
  final String timings;
  final String description;
  final String imageUrl;
  final String modeOfConduct;
  Event({
    required this.name,
    required this.timings,
    required this.description,
    required this.imageUrl,
    required this.modeOfConduct,
  });
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pressedButtonIndex = 0;
  String _userName = '';
  String _userEmail = '';
  List<Event> _events = [];

  @override
  void initState() {
    super.initState();
    _fetchUserName();
    _fetchEvents();
  }

  Future<void> _fetchUserName() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        setState(() {
          _userName = userDoc['name'];
          _userEmail = userDoc['email'];
        });
      }
    }
  }

  Future<void> _fetchEvents() async {
    QuerySnapshot eventSnapshot =
        await FirebaseFirestore.instance.collection('events').get();
    setState(() {
      _events = eventSnapshot.docs.map((doc) {
        return Event(
          name: doc['nameOfEvent'],
          timings: doc['date'],
          description: doc['description'],
          imageUrl: doc['imageUrl'],
          modeOfConduct: doc['modeOfConduct'],
        );
      }).toList();
    });
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color(0xFFB760D5),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back,',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300, // Light font weight
                    ),
                  ),
                  Text(
                    _userName,
                    style: TextStyle(
                      fontSize: 24, // Increased font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(Icons.notifications_none),
            ),
            SizedBox(height: 10),
          ],
        ),
        automaticallyImplyLeading: false, // Remove back arrow
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 47,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                color: Colors.grey[200],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.search),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
              height: 4), // Added space between search bar and image slider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17), // Circular border radius
              child: SizedBox(
                height: 190,
                child: ImageSlider(),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EventsPage()),
                  );
                },
                icon: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                    color: _pressedButtonIndex == 0 ? Color(0xFFB760D5) : null,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
                  child: Text(
                    '   Events   ',
                    style: TextStyle(
                      color: _pressedButtonIndex == 0
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyWidget()),
                  );
                },
                icon: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                    color: _pressedButtonIndex == 1 ? Color(0xFFB760D5) : null,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Text(
                    'Execom Call',
                    style: TextStyle(
                      color: _pressedButtonIndex == 1
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CompdisplayPage()),
                  );
                },
                icon: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                    color: _pressedButtonIndex == 2 ? Color(0xFFB760D5) : null,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Text(
                    'Competitions',
                    style: TextStyle(
                      color: _pressedButtonIndex == 2
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Trending',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EventsPage()),
                    );
                  },
                  child: Text(
                    'See All',
                    style: TextStyle(
                      color: Color(0xFFB760D5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              itemCount: _events.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 160,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          child: Image.network(
                            _events[index].imageUrl, // Use network image
                            fit:
                                BoxFit.cover, // Ensure the image covers the box
                            height: 130, // Adjust the height of the image
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _events[index].name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${_events[index].timings}', // Correct field name
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Mode of Conduct: ${_events[index].modeOfConduct ?? "N/A"}',
                                style: TextStyle(fontSize: 18),
                              ),

                              // Text(
                              //   'Description: ${_events[index].description}',
                              //   style: TextStyle(fontSize: 16),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: GNav(
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              duration: Duration(milliseconds: 900),
              tabBackgroundColor: Color(0xFFB760D5),
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  onPressed: () {
                    // Navigate to UserInputPage when floating action button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => communityHome()),
                    );
                  },
                  icon: Icons.people_alt_outlined, // Heart outline icon
                  text: 'Community',
                ),
                GButton(
                  onPressed: () {
                    // Navigate to UserInputPage when floating action button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => communityHome()),
                    );
                  },
                  icon: LineIcons.search,
                  text: 'Search',
                ),
                GButton(
                  onPressed: () {
                    // Navigate to UserInputPage when floating action button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      // endDrawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       // Drawer content here
      //     ],
      //   ),
      // ),
    );
  }
}

class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final List<String> imagePaths = [
    "assets/Slider1.png",
    "assets/Slider2.png",
    "assets/Slider3.png"
  ];
  int _currentIndex = 0;

  void _previousImage() {
    setState(() {
      _currentIndex = (_currentIndex - 1) % imagePaths.length;
    });
  }

  void _nextImage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % imagePaths.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          itemCount: imagePaths.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Image.asset(
              imagePaths[index],
              fit: BoxFit.cover,
            );
          },
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(imagePaths.length, (index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Colors.blue
                        : Colors.grey.withOpacity(0.5),
                  ),
                ),
              );
            }),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: _previousImage,
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: _nextImage,
          ),
        ),
      ],
    );
  }
}

class ExecomcallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Execomcall'),
      ),
      body: Center(
        child: Text('Execomcall Page'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
