import 'package:communehub/competitions/competitionscreen.dart';
import 'package:communehub/events/eventscreen.dart';
import 'package:communehub/execom_call/position_selection.dart';
import 'package:communehub/user/userhome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _pressedButtonIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          const SizedBox(height: 40.0), // Adding some vertical space
          SingleChildScrollView(
            // Wrap Row with SingleChildScrollView
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EventsPage()),
                      );
                    },
                    icon: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(24.0),
                        color:
                            _pressedButtonIndex == 0 ? Color(0xFFB760D5) : null,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        'Events',
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
                    onPressed: () => setState(() => _pressedButtonIndex = 1),
                    icon: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(24.0),
                        color:
                            _pressedButtonIndex == 1 ? Color(0xFFB760D5) : null,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                        MaterialPageRoute(
                            builder: (context) => CompdisplayPage()),
                      );
                    },
                    icon: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(24.0),
                        color:
                            _pressedButtonIndex == 2 ? Color(0xFFB760D5) : null,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              // Use Column for vertical layout
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text and divider to left
              children: [
                Row(
                  // Wrap Text with Row for left alignment (optional)
                  children: [
                    Text(
                      'Execom Call',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0), // Add some vertical space
                Container(
                  width: 50.0, // Adjust width as needed
                  height: 3.0, // Adjust height for thickness
                  decoration: BoxDecoration(
                    color: Color(0xFFB760D5),
                    borderRadius: BorderRadius.all(
                        Radius.circular(2.0)), // Set border radius
                  ),
                ),
                const SizedBox(
                    height: 20.0), // Add space before the large container
                // Large box for content
                Center(
                  child: Stack(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              offset: Offset(4.0, 4.0),
                              blurRadius: 15.0,
                              spreadRadius: 7.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Container(
                            width: 350.0,
                            height: 170.0,
                            child: Image.asset(
                              "assets/IEEE.png", // Replace with your image path
                              fit: BoxFit
                                  .cover, // Stretch image to fill container
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 21.0), // Adjust padding as needed
                          child: Opacity(
                            opacity: 1.0,
                            child: Text(
                              "   Call for execom",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 27.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 70), // Adjust padding as needed
                          child: Opacity(
                            opacity: 1.0,
                            child: Text(
                              "      Deadline : 5 April , 2024",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20.0, // Adjust button position from bottom
                        left:
                            23.0, // Adjust button position from left (optional)
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle button press action
                            Navigator.push(
                              context,
                              MaterialPageRoute( builder: (context) => PositionSelection()),
                            );
                          },
                          child: Text(
                            "Apply Now",
                            style: TextStyle(
                              color: Colors.white, // Set text color to white
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(
                                0xFFB760D5), // Adjust button color (optional)
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            minimumSize: Size(
                                125.0, 30.0), // Set desired width and height
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                    height: 20.0), // Add space before the large container
              
              ],
            ),
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                  // Your widget content here
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
