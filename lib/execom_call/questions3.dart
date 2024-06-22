import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communehub/execom_call/execom_last.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Questions3 extends StatefulWidget {
  final Map<String, String> userData;

  Questions3(this.userData);

  @override
  _Questions3State createState() => _Questions3State();
}

class _Questions3State extends State<Questions3> {
  final TextEditingController _volunteeringController = TextEditingController();
  final TextEditingController _differentSelectionController =
      TextEditingController();

  // FirebaseFirestore instance (assuming you have initialized Firebase)
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // FirebaseAuth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get the current user's email
  String _getUserEmail() {
    User? user = _auth.currentUser;
    if (user != null) {
      return user.email ?? '';
    }
    return '';
  }

  Future<void> submitData() async {
    try {
      // Extract text from controllers
      String volunteeringText = _volunteeringController.text.trim();
      String differentSelectionText = _differentSelectionController.text.trim();

      // Ensure both text fields are non-empty
      if (volunteeringText.isEmpty || differentSelectionText.isEmpty) {
        // Handle case when either of the text fields is empty
        return; // Exit function
      }

      // Create a new document in the 'execom' collection
      DocumentReference docRef =
          await FirebaseFirestore.instance.collection('execom').add({
        'previousPositions': widget.userData['previousPositions'],
        'aptitude': widget.userData['aptitude'],
        'volunteering': volunteeringText, // Correct key for volunteering experiences
        'whatWouldYouDoDifferently': differentSelectionText, // Correct key for what would you do differently
        'timestamp': FieldValue.serverTimestamp(), // Add timestamp
        'identifier': _getUserEmail(), // Add user's email as identifier
      });

      print("Document created with ID: ${docRef.id}");

      // Call your API or perform any other operations here
    } catch (error) {
      print("Error submitting data to Firebase: $error");
    }
  }

  // HTTP POST request to Flask server
  Future<void> submitDataToFlaskServer() async {
    try {
      // Make an HTTP POST request to your Flask server
      final response = await http.post(
        Uri.parse(
            'http:///submit'), // Update with your Flask server URL
        body: json.encode({
          'previousPositions': widget.userData['previousPositions'],
          'aptitude': widget.userData['aptitude'],
          'volunteering': _volunteeringController.text, // Correct key for volunteering experiences
          'whatWouldYouDoDifferently': _differentSelectionController.text, // Correct key for what would you do differently
          'identifier': _getUserEmail(), // Add user's email as identifier
        }), // Send user data as JSON with corrected keys
        headers: {'Content-Type': 'application/json'}, // Set headers
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the response JSON
        final responseData = json.decode(response.body);

        // Do something with the response data
        print(responseData);
      } else {
        // If the request was not successful, print the error
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      // If an error occurs during the request, print the error
      print('Error submitting data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 40,
              child: LinearProgressIndicator(
                value: 0.8,
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB760D5)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Previous volunteering experiences :",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _volunteeringController,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Enter your previous volunteering experiences",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "What would you do differently if you were selected ? ",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _differentSelectionController,
                  maxLines: 8,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Enter your answer here",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 93.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text(
                        "Back",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        submitData();
                        submitDataToFlaskServer();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => NewPage(), // Replace NewPage with your desired page
                          ),
                        ); // Call submitDataToFlaskServer to send data to Flask server
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFFB760D5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text(
                        "Finish",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
