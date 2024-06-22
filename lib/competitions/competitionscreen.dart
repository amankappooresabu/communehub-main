import 'package:communehub/user/userhome.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompdisplayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Competition'),
        backgroundColor: Color(0xFF7E53D6),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('competition').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          List<Map<String, dynamic>> competition =
              snapshot.data!.docs.map((DocumentSnapshot doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return {
              "name": data["nameOfEvent"],
              "date": data["date"],
              "participants": data["participants"],
              "imagePath": data["imageUrl"],
              "color": Colors.white,
              "conductMode": data["modeOfConduct"],
              "description": data["description"],
            };
          }).toList();

          return ListView.builder(
            itemCount: competition.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CompetitionDetailsPageuser(comp: competition[index]),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: competition[index]["color"],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 40, 35, 35)
                            .withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 9,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            12), // Add border radius to the image
                        child: Image.network(
                          competition[index]["imagePath"],
                          width: 140,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              competition[index]["name"],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Date: ${competition[index]["date"]}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${competition[index]["conductMode"]}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CompetitionDetailsPageuser extends StatelessWidget {
  final Map<String, dynamic> comp;

  CompetitionDetailsPageuser({required this.comp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          comp["name"],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFF7E53D6),
      ),
      body: Material(
        // Wrap the Container with Material
        elevation: 4, // Set elevation
        shadowColor: Colors.black.withOpacity(0.3), // Set shadow color
        borderRadius: BorderRadius.circular(20), // Set circular border radius
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFECECEC), // Set background color to ECECEC
            borderRadius:
                BorderRadius.circular(20), // Set circular border radius
          ),
          constraints: BoxConstraints.expand(
              height: double.infinity), // Set infinite height
          child: Padding(
            padding: EdgeInsets.all(5),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        comp["imagePath"],
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Competition Details'),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Name: ${comp["name"]}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    'Date: ${comp["date"]}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    'Participants: ${comp["participants"]}',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    'Mode of Conduct: ${comp["conductMode"]}',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Done'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.info),
                      label: Text('Competition Details'),
                    ),
                  ),
                  SizedBox(height: 3),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date and Time: ${comp["date"]}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${comp["description"]}',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Participants: ${comp["participants"]}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Mode of Conduct: ${comp["conductMode"]}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
     bottomNavigationBar: GestureDetector(
        onTap: () {
          // try {
          //   final currentUser = FirebaseAuth.instance.currentUser;
          //   if (currentUser != null) {
          //     final userEmail = currentUser.email;
          //     final userName = currentUser.displayName;

          //     // Add registration to Firestore
          //     await FirebaseFirestore.instance
          //         .collection('registrations')
          //         .doc(event['name'])
          //         .collection('users')
          //         .doc(currentUser.uid)
          //         .set({
          //       'userName': userName,
          //       'userEmail': userEmail,
          //       'eventDate': event['date'],
          //       'eventName': event['name'],
          //       // Add more fields as needed
          //     });

              // Navigate to registration complete page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegistrationCompletePage1(),
                ),
              );
        //     } else {
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         SnackBar(
        //           content: Text('User not logged in'),
        //           duration: Duration(seconds: 3),
        //         ),
        //       );
        //     }
        //   } catch (error) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(
        //         content: Text('Error: $error'),
        //         duration: Duration(seconds: 3),
        //       ),
        //     );
        //   }
        // },
        child: Container(
          color: Color(0xFF7E53D6),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.event),
              SizedBox(width: 10),
              Text(
                'Register Event',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        );}
      ),
    );
  }
}



class RegistrationCompletePage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECECEC),
      appBar: AppBar(
        backgroundColor: Color(0xFFECECEC),

        // backgroundColor: Color(0xFFB760D5),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated tick GIF
            Image.asset(
              'assets/tick1.gif',
              height: 200,
              width: 300,
            ),
            SizedBox(height: 20),
            // Registration complete message with animation
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 24.0),
              duration: Duration(seconds: 1),
              builder: (context, value, child) {
                return Text(
                  'Registration Complete!',
                  style: TextStyle(
                    fontSize: value,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB760D5),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            // View Ticket button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => HomePage()));
                // Add functionality to view ticket
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFB760D5),
              ),
              child: Text(
                'Done',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
