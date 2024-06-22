import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:communehub/execom_call/questions1.dart';
import 'package:communehub/execom_call/questions3.dart';
import 'package:flutter/material.dart';

class Questions2 extends StatefulWidget {
  final Map<String, String> userData;

  Questions2(this.userData);

  @override
  _Questions2State createState() => _Questions2State();
}

class _Questions2State extends State<Questions2> {
  final TextEditingController _aptitudeController = TextEditingController();
  bool isBackButtonSelected = false;

  // FirebaseFirestore instance (assuming you have initialized Firebase)
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> submitData(Map<String, dynamic> userData) async {
  final String aptitude = _aptitudeController.text;

  // Convert userData to Map<String, String> by casting each value
  Map<String, String> userDataString = userData.map((key, value) => MapEntry(key, value.toString()));

  // Combine all data into a single map
  Map<String, String> combinedData = {
    ...userDataString,
    'aptitude': aptitude,
  };

  try {
    // Create a document in the "execom" collection with combined data
    await _firestore.collection('execom').add(combinedData);

    print("Data submitted successfully to Firebase!");
    // Navigate to the next page (assuming Questions3() is your next page)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Questions3(combinedData)),
    );
  } catch (error) {
    print("Error submitting data to Firebase: $error");
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 40,
              child: LinearProgressIndicator(
                value: 0.5,
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB760D5)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Why are you aptable for this position?",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
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
                  controller: _aptitudeController,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Enter your response here",
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
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 275.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuestionsPage()),
                        );
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
                        submitData(widget.userData.cast<String, String>());
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
                        "Next",
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
