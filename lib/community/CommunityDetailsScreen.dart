// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
//import 'package:flutter_application_1/reusable_widget/reusable_widget.dart';

class CommunityDetailsScreen extends StatelessWidget {
  final String name;

  CommunityDetailsScreen({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Center(
          child: _buildCommunityDetails(context),
        ),
      ),
    );
  }

  Widget _buildCommunityDetails(BuildContext context) {
    switch (name) {
      case 'GDSC':
        return _buildGDSCDetails(context);
      case 'IEEE':
        return _buildIEEEDetails(context);
      case 'TINKER HUB':
        return _buildTINKERHUBDetails(context);
      case 'UI PATH':
        return _buildUIPATHDetails(context);
      case 'CSI':
        return _buildCSIDetails(context);

      // case 'UIPATH':
      // return _buildUIPATHDetails(context);
      // Add cases for other communities as needed
      default:
        return Text(
          'Details for $name are not available.',
          style: TextStyle(
              fontSize: 24.0, color: const Color.fromARGB(255, 36, 29, 29)),
        );
    }
  }

  Widget _buildGDSCDetails(BuildContext context) {
    List<Map<String, dynamic>> coreMembers = [
      {'name': 'Austin Benny', 'imagePath': 'assets/belly.png'},
      {'name': 'Aman Sabu', 'imagePath': 'assets/menlap.png'},
      {'name': 'Liya George', 'imagePath': 'assets/lady.png'},
      {'name': 'Alan Peter', 'imagePath': 'assets/meny.png'}
      // Example list of core members
    ];
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, left: 5, right: 5),
            decoration: BoxDecoration(
              color: Color.fromARGB(180, 6, 1, 96),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Image.asset(
              "assets/gdschh.png", // Replace 'assets/gdsc_logo.png' with the path to your GDSC logo image asset
              width: 550, // Adjust the width of the image as needed
              height: 350, // Adjust the height of the image as needed
            ),
          ),
          SizedBox(height: 20), // Add some vertical spacing
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 1, 1, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '18M+',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Google Developer Student Clubs',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 1, 1),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20), // Add some vertical spacing
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About us',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 10),
                Text(
                  'GDSCs, backed by Google Developers, are student-led communities fostering tech education and collaboration. Through workshops and events, students explore Google technologies, gain hands-on experience, and connect with industry mentors, empowering them to thrive in the tech world.',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 20),
                Text(
                  'Core Members',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: coreMembers.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage(coreMembers[index]['imagePath']),
                            radius: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            coreMembers[index]['name'],
                            style: TextStyle(
                                fontSize: 15,
                                color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Contact us',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0))),
                SizedBox(
                  height: 5,
                ),
                Text('Austin Benny-9856482522',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 0, 0, 0))),
                SizedBox(
                  height: 1,
                ),
                Text('LEAD',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 0, 0, 0)))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIEEEDetails(BuildContext context) {
    List<Map<String, dynamic>> coreMembers = [
      {'name': 'Albin Sony', 'imagePath': 'assets/belly.png'},
      {'name': 'Seion shoji', 'imagePath': 'assets/menlap.png'},
      {'name': 'Kavya KA', 'imagePath': 'assets/lady.png'},
      {'name': 'Amal A', 'imagePath': 'assets/meny.png'}
      // Example list of core members
    ];
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, left: 5, right: 5),
            decoration: BoxDecoration(
              color: Color.fromARGB(180, 249, 249, 249),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Image.asset(
              "assets/ieeehh.png", // Replace 'assets/gdsc_logo.png' with the path to your GDSC logo image asset
              width: 550, // Adjust the width of the image as needed
              height: 350, // Adjust the height of the image as needed
            ),
          ),
          SizedBox(height: 20), // Add some vertical spacing
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 1, 1, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '180M+',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'IEEE',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 1, 1),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20), // Add some vertical spacing
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About us',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 10),
                Text(
                  'IEEE (Institute of Electrical and Electronics Engineers) is a professional association for electronic engineering and electrical engineering (and associated disciplines) with its corporate office in New York City and its operations center in Piscataway, New Jersey. It was formed in 1963 from the amalgamation of the American Institute of Electrical Engineers and the Institute of Radio Engineers.',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 20),
                Text(
                  'Core Members',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                  textAlign: TextAlign.center,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: coreMembers.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage(coreMembers[index]['imagePath']),
                            radius: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            coreMembers[index]['name'],
                            style: TextStyle(
                                fontSize: 15,
                                color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Contact us',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0))),
                SizedBox(
                  height: 5,
                ),
                Text('Akash Vijay-9856482522',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 0, 0, 0))),
                SizedBox(
                  height: 1,
                ),
                Text('LEAD',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 0, 0, 0)))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTINKERHUBDetails(BuildContext context) {
    List<Map<String, dynamic>> coreMembers = [
      {'name': 'Thomas Jose', 'imagePath': 'assets/belly.png'},
      {'name': 'Athul Sabu', 'imagePath': 'assets/menlap.png'},
      {'name': 'Liya Elizabath', 'imagePath': 'assets/lady.png'},
      {'name': 'Ayush G', 'imagePath': 'assets/meny.png'}
      // Example list of core members
    ];
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, left: 5, right: 5),
            decoration: BoxDecoration(
              color: Color.fromARGB(180, 6, 1, 96),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Image.asset(
              "images/gdschh.png", // Replace 'assets/gdsc_logo.png' with the path to your GDSC logo image asset
              width: 550, // Adjust the width of the image as needed
              height: 350, // Adjust the height of the image as needed
            ),
          ),
          SizedBox(height: 20), // Add some vertical spacing
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 1, 1, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '10L+',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'TINKER HUB',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 1, 1),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20), // Add some vertical spacing
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About us',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 10),
                Text(
                  'TinkerHub is a vibrant community where tech enthusiasts come together to innovate, collaborate, and learn. Join us to explore cutting-edge technologies, share knowledge, and work on impactful projects. Lets build a brighter future together! ',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 20),
                Text(
                  'Core Members',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: coreMembers.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage(coreMembers[index]['imagePath']),
                            radius: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            coreMembers[index]['name'],
                            style: TextStyle(
                                fontSize: 15,
                                color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Contact us',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0))),
                SizedBox(
                  height: 5,
                ),
                Text('Athul Sabu-9856482522',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 0, 0, 0))),
                SizedBox(
                  height: 1,
                ),
                Text('LEAD',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 0, 0, 0)))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCSIDetails(BuildContext context) {
    List<Map<String, dynamic>> coreMembers = [
      {'name': 'Thomas Jose', 'imagePath': 'assets/belly.png'},
      {'name': 'Seion shoji', 'imagePath': 'assets/menlap.png'},
      {'name': 'Merlin Jaison', 'imagePath': 'assets/lady.png'},
      {'name': 'Ajay krishna', 'imagePath': 'assets/meny.png'}
      // Example list of core members
    ];
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, left: 5, right: 5),
            decoration: BoxDecoration(
              color: Color.fromARGB(180, 249, 249, 249),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Image.asset(
              "assets/gdschh.png", // Replace 'assets/gdsc_logo.png' with the path to your GDSC logo image asset
              width: 550, // Adjust the width of the image as needed
              height: 350, // Adjust the height of the image as needed
            ),
          ),
          SizedBox(height: 20), // Add some vertical spacing
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 1, 1, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '10M+',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'COMPUTER SOCIETY OF INDIA',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 1, 1),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20), // Add some vertical spacing
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About us',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 10),
                Text(
                  'CSI (Computer Society of India) is a premier professional organization in India dedicated to advancing the theory and practice of computer science and IT. With a vast network of professionals, students, and academia, CSI promotes research, knowledge sharing, and skill development in the field of computing. Join us to connect with like-minded individuals, stay updated on industry trends, and unlock opportunities for career growth in the ever-evolving world of technology.',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 20),
                Text(
                  'Core Members',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                  textAlign: TextAlign.center,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: coreMembers.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage(coreMembers[index]['imagePath']),
                            radius: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            coreMembers[index]['name'],
                            style: TextStyle(
                                fontSize: 15,
                                color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Contact us',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0))),
                SizedBox(
                  height: 5,
                ),
                Text('Thomas Jose-9856482522',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 0, 0, 0))),
                SizedBox(
                  height: 1,
                ),
                Text('LEAD',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 0, 0, 0)))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUIPATHDetails(BuildContext context) {
    List<Map<String, dynamic>> coreMembers = [
      {'name': 'Albin Sony', 'imagePath': 'assets/belly.png'},
      {'name': 'Seion shoji', 'imagePath': 'assets/menlap.png'},
      {'name': 'Noora Fathima', 'imagePath': 'assets/lady.png'},
      {'name': 'Amal A', 'imagePath': 'assets/meny.png'}
      // Example list of core members
    ];
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, left: 5, right: 5),
            decoration: BoxDecoration(
              color: Color.fromARGB(180, 249, 249, 249),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Image.asset(
              "assets/gdschh.png", // Replace 'assets/gdsc_logo.png' with the path to your GDSC logo image asset
              width: 550, // Adjust the width of the image as needed
              height: 350, // Adjust the height of the image as needed
            ),
          ),
          SizedBox(height: 20), // Add some vertical spacing
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 1, 1, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '05M+',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'UI PATH',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 1, 1),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20), // Add some vertical spacing
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About us',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 10),
                Text(
                  'UI Path is a leading platform for Robotic Process Automation (RPA) that enables organizations to automate repetitive tasks, streamline business processes, and improve operational efficiency. With UI Path, users can build, deploy, and manage software robots that mimic human actions to interact with digital systems and applications. Whether its automating data entry, invoice processing, or customer service tasks, UI Path empowers businesses to achieve greater productivity, accuracy, and cost savings',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 20),
                Text(
                  'Core Members',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0)),
                  textAlign: TextAlign.center,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: coreMembers.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage(coreMembers[index]['imagePath']),
                            radius: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            coreMembers[index]['name'],
                            style: TextStyle(
                                fontSize: 15,
                                color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Contact us',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0))),
                SizedBox(
                  height: 5,
                ),
                Text('Noora fathima-9856482522',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 0, 0, 0))),
                SizedBox(
                  height: 1,
                ),
                Text('LEAD',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: const Color.fromARGB(255, 0, 0, 0)))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
