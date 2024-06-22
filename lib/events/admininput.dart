import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserInputPage extends StatefulWidget {
  @override
  _UserInputPageState createState() => _UserInputPageState();
}

class _UserInputPageState extends State<UserInputPage> {
  final nameOfEventController =
      TextEditingController(); // Added controller for event name
  final nameOfCommunityController =
      TextEditingController(); // Added controller for community name
  final dateController = TextEditingController();
  final descriptionController = TextEditingController();
  final participantsController = TextEditingController();
  final modeOfConductController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _submitEvent() async {
    try {
      // Check if any required field is empty
      if (nameOfEventController.text.isEmpty ||
          nameOfCommunityController.text.isEmpty ||
          dateController.text.isEmpty ||
          descriptionController.text.isEmpty ||
          participantsController.text.isEmpty ||
          modeOfConductController.text.isEmpty) {
        // Show snackbar if any field is empty
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please fill in all fields!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Show loading indicator while uploading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // Check if an image is selected
      if (_selectedImage != null) {
        // Create a reference to the Firebase Storage bucket
        var storageRef = FirebaseStorage.instance.ref().child('images');

        // Create a unique filename for the image
        var timestamp = DateTime.now().millisecondsSinceEpoch.toString();
        var imageName = 'image_$timestamp.jpg';

        // Upload the image file to Firebase Storage
        var uploadTask = storageRef.child(imageName).putFile(_selectedImage!);

        // Get the download URL of the uploaded image
        var imageUrl = await (await uploadTask).ref.getDownloadURL();

        // Store event details in Firestore including the image URL
        CollectionReference collRef =
            FirebaseFirestore.instance.collection('events');

        // Add a new document with a generated ID
        await collRef.add({
          'nameOfEvent': nameOfEventController.text,
          'nameOfCommunity': nameOfCommunityController.text,
          'date': dateController.text,
          'description': descriptionController.text,
          'participants': int.parse(participantsController.text),
          'modeOfConduct': modeOfConductController.text,
          'imageUrl': imageUrl, // Add image URL to Firestore
        });

        // Clear all text fields after submission
        nameOfEventController.clear();
        nameOfCommunityController.clear();
        dateController.clear();
        descriptionController.clear();
        participantsController.clear();
        modeOfConductController.clear();
        setState(() {
          _selectedImage = null; // Clear selected image
        });

        // Hide loading indicator
        Navigator.of(context).pop();

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Event added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Hide loading indicator
        Navigator.of(context).pop();

        // Show error message if no image is selected
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select an image!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Hide loading indicator
      Navigator.of(context).pop();

      // Show error message if any exception occurs
      print('Error uploading image and adding event: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Events',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent, // Set the background color
        elevation: 0, // Set elevation to 0 for a flat appearance
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextFormField(
                    controller: nameOfEventController,
                    decoration: InputDecoration(
                      hintText: 'Name of Event',
                      prefixIcon: Icon(Icons.event), // Added event icon
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextFormField(
                    controller: nameOfCommunityController,
                    decoration: InputDecoration(
                      hintText: 'Name of Community',
                      prefixIcon: Icon(Icons.people),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 1),
                            );
                            if (pickedDate != null) {
                              final TimeOfDay? pickedTime =
                                  await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (pickedTime != null) {
                                final DateTime combinedDateTime = DateTime(
                                  pickedDate.year,
                                  pickedDate.month,
                                  pickedDate.day,
                                  pickedTime.hour,
                                  pickedTime.minute,
                                );
                                setState(() {
                                  // Format the date and time for display
                                  final formattedDateTime =
                                      '${pickedDate.year}-${pickedDate.month}-${pickedDate.day} ${pickedTime.format(context)}';
                                  dateController.text = formattedDateTime;
                                });
                              }
                            }
                          },
                          child: IgnorePointer(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                  color: Colors.grey, // Set border color
                                ),
                              ),
                              child: TextFormField(
                                controller: dateController,
                                decoration: InputDecoration(
                                  hintText: 'Date and Time',
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.date_range),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Short Description',
                      prefixIcon: Icon(Icons.description),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextFormField(
                    controller: participantsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Number of Participants',
                      prefixIcon: Icon(Icons.group),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextFormField(
                    controller: modeOfConductController,
                    decoration: InputDecoration(
                      hintText: 'Mode of Conduct',
                      prefixIcon: Icon(Icons.settings),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                _selectedImage == null
                    ? ElevatedButton(
                        onPressed: _pickImage,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          elevation: MaterialStateProperty.all<double>(8),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_photo_alternate),
                            SizedBox(width: 8),
                            Text('Add Image'),
                          ],
                        ),
                      )
                    : Image.file(_selectedImage!),
                SizedBox(height: 170.0),
                ElevatedButton(
                  onPressed: _submitEvent,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF7E53D6)),
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(double.infinity, 50)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.done,
                        color:
                            Colors.white, // Set the color of the icon to white
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Submit',
                        style: TextStyle(
                            color: Colors
                                .white), // Set the color of the text to white
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
