import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminNotificationPage extends StatefulWidget {
  @override
  _AdminNotificationPageState createState() => _AdminNotificationPageState();
}

class _AdminNotificationPageState extends State<AdminNotificationPage> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  List<DocumentSnapshot> events = [];
  List<DocumentSnapshot> competitions = [];

  @override
  void initState() {
    super.initState();
    _fetchEvents();
    _fetchCompetitions();
  }

  void _fetchEvents() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('events').get();
    setState(() {
      events = snapshot.docs;
    });
  }

  void _fetchCompetitions() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('competition').get();
    setState(() {
      competitions = snapshot.docs;
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications (Admin)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Events',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(event['nameOfEvent']),
                  onTap: () {
                    _navigateToSendMessagePage(context, event['nameOfEvent']);
                  },
                );
              },
            ),
            SizedBox(height: 16),
            Text(
              'Competitions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              itemCount: competitions.length,
              itemBuilder: (context, index) {
                final competition =
                    competitions[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(competition['nameOfEvent']),
                  onTap: () {
                    _navigateToSendMessagePage(
                        context, competition['nameOfEvent']);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSendMessagePage(BuildContext context, String eventName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SendMessagePage(eventName: eventName),
      ),
    );
  }
}

class SendMessagePage extends StatelessWidget {
  final String eventName;

  SendMessagePage({required this.eventName});

  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Message to $eventName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _linkController,
              decoration: InputDecoration(
                labelText: 'Link',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _sendNotification(context);
              },
              child: Text('Send Notification'),
            ),
          ],
        ),
      ),
    );
  }

  void _sendNotification(BuildContext context) {
    final message = _messageController.text.trim();
    final link = _linkController.text.trim();

    if (message.isNotEmpty) {
      FirebaseFirestore.instance.collection('notifications').add({
        'eventName': eventName,
        'message': message,
        'link': link,
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Notification sent successfully'),
          ),
        );
        Navigator.pop(
            context); // Navigate back to previous page after sending notification
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sending notification: $error'),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a message'),
        ),
      );
    }
  }
}
