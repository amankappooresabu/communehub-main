import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RankingTablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ranking Table (Web Team)'),
        backgroundColor: Color(0xFFE7E0C9), // Background color of app bar
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('execom_scores')
              .orderBy('average_score', descending: true) // Order by average_score in descending order
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            List<DocumentSnapshot>? documents = snapshot.data?.docs;

            if (documents == null || documents.isEmpty) {
              return Center(child: Text('No data available'));
            }

            return SingleChildScrollView(
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Average Score')),
                ],
                rows: documents
                    .map((doc) => DataRow(cells: [
                          DataCell(Text(doc.id)), // Document ID is the email
                          DataCell(Text(doc['average_score'].toString())),
                        ]))
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
