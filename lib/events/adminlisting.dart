import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communehub/events/admininput.dart'; // Import UserInputPage

class EventlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E0C9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE7E0C9),
        title: Text('Event Details'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('events').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No events found'));
          }

          // Events found, display them
          final events = snapshot.data!.docs;
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (BuildContext context, int index) {
              final event = events[index].data();
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20), // Add padding around the card
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        15.0), // Set circular border radius
                  ),
                  elevation: 5, // Add elevation for a card effect
                  child: ListTile(
                    contentPadding: EdgeInsets.only(
                        left: 20), // Add padding inside the card
                    leading: Container(
                      width: 100,
                      // margin: EdgeInsets.only(right: 16),
                      // borderRadius: BorderRadius.circular(
                      //     5.0), // Set circular border radius
                      child: Image.network(
                        event['imageUrl'],
                        fit: BoxFit.fill,
                      ),
                    ),
                    title: Text(
                      '${event['nameOfEvent']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25, // Adjust the font size as needed
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${event['date']}',
                          style: TextStyle(
                            fontSize: 16, // Adjust the font size as needed
                          ),
                        ),
                        Text(
                          '${event['description']}',
                          style: TextStyle(
                            fontSize: 16, // Adjust the font size as needed
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Delete the event from Firebase and navigate back to the EventDetailsPage
                        FirebaseFirestore.instance
                            .collection('events')
                            .doc(events[index].id)
                            .delete()
                            .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Event deleted'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }).catchError((error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error deleting event'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to UserInputPage when floating action button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserInputPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red, // Set background color to red
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
