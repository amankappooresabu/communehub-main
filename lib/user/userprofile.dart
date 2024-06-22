import 'package:communehub/user/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String _userName;
  late String _userEmail;

  @override
  void initState() {
    super.initState();
    _userName = ''; // Initialize to empty string
    _userEmail = ''; // Initialize to empty string
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text('Profile'),
          ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300], // Placeholder color
              ),
              child: Icon(
                Icons.person, // Placeholder icon
                size: 80,
                color: Colors.white, // Placeholder color
              ),
            ),
            SizedBox(height: 20),
            Text(
              _userName.isNotEmpty
                  ? _userName
                  : 'Loading...', // Display loading if name is empty
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              _userEmail.isNotEmpty
                  ? _userEmail
                  : 'Loading...', // Display loading if email is empty
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Handle edit profile button tap
              },
              child: Text('Edit Profile'),
            ),
            SizedBox(height: 30),
            Divider(),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle settings tap
              },
            ),
            ListTile(
              leading: Icon(Icons.event_sharp),
              title: Text('Registered Events'),
              onTap: () {
                // Handle registered events tap
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('User Management'),
              onTap: () {
                // Handle user management tap
              },
            ),
            Divider(),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Information'),
              onTap: () {
                // Handle information tap
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut(); // Sign out the user
                // Navigate to the login page
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
