import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communehub/execom_call/questions2.dart';
import 'package:flutter/material.dart';

class QuestionsPage extends StatefulWidget {
  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  int selectedAnswer = -1; // -1 indicates no selection
  TextEditingController _membershipIdController = TextEditingController();
  TextEditingController _previousPositionsController = TextEditingController();
  bool isBackButtonSelected = false;
  double progress = 0.25; // Initial progress
  final _formKey = GlobalKey<FormState>();

  // FirebaseFirestore instance (assuming you have initialized Firebase)
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to submit data to Firebase
  Future<Map<String, String>> submitData() async {
    if (_formKey.currentState!.validate()) {
      String membershipId = _membershipIdController.text;
      String previousPositions = _previousPositionsController.text;

      // Create a Map to store user data
      Map<String, String> userData = {
        'isMember': selectedAnswer == 0 ? 'Yes' : 'No',
        'membershipId': membershipId,
        'previousPositions': previousPositions,
      };

      try {
        // Query for existing document in "execom" collection
        QuerySnapshot querySnapshot =
            await _firestore.collection('execom').limit(1).get();

        if (querySnapshot.docs.isNotEmpty) {
          // If document exists, update it
          String docId = querySnapshot.docs[0].id;
          await _firestore.collection('execom').doc(docId).update(userData);
        } else {
          // If document doesn't exist, create a new one
          await _firestore.collection('execom').add(userData);
        }

        print("Data submitted successfully to Firebase!");
        return userData; // Return userData
      } catch (error) {
        print("Error submitting data to Firebase: $error");
        return {}; // Return empty map if error occurs
      }
    } else {
      return {}; // Return empty map if form is not valid
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 60.0),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB760D5)),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 5.0,
                right: 115.0,
              ),
              child: Text(
                "Are you an IEEE member ? ",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              selectedAnswer = 0;
                            });
                          },
                          child: Container(
                            width: 65.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: selectedAnswer == 0
                                  ? Color(0xFFB760D5)
                                  : Colors.black,
                            ),
                            child: Center(
                              child: Text(
                                "Yes",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              selectedAnswer = 1;
                            });
                          },
                          child: Container(
                            width: 65.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: selectedAnswer == 1
                                  ? Color(0xFFB760D5)
                                  : Colors.black,
                            ),
                            child: Center(
                              child: Text(
                                "No",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 5.0,
                right: 160.0,
              ),
              child: Text(
                "IEEE Membership ID : ",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _membershipIdController,
                  enabled:
                      selectedAnswer == 0, // Enable only if Yes is selected
                  validator: (value) {
                    if (selectedAnswer == 0 && value!.isEmpty) {
                      return 'IEEE Membership ID is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter your IEEE Membership ID",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 5.0,
                right: 130.0,
              ),
              child: Text(
                " Previous positions held : ",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
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
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: TextField(
                  controller: _previousPositionsController,
                  maxLines: 7,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Enter your previous positions held",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 130.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle back button
                      },
                      child:
                          Text('Back'), // Add child property with Text widget
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        Map<String, String> userData = await submitData();
                        if (userData.isNotEmpty) {
                          // Navigate to the next page with userData
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Questions2(userData),
                            ),
                          );
                          setState(() {
                            isBackButtonSelected = false;
                            progress =
                                0.5; // Increase progress to half when navigating to next page
                          });
                        }
                      },
                      child:
                          Text('Next'), // Add child property with Text widget
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFFB760D5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
