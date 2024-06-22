import 'package:communehub/execom_call/execom_rankingtable.dart';
import 'package:flutter/material.dart';

class PositionSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Position Selection'),
        backgroundColor: Color(0xFFE7E0C9), // Background color of app bar
      ),
      body: Container(
        color: Color(0xFFE7E0C9), // Background color of the whole page
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildChairCard(),
                  SizedBox(width: 20), 
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RankingTablePage()),
                        );
                      },
                  // Add spacing between cards
                  child : _buildWebTeamCard(),
                  ),
                ],
              ),
              SizedBox(height: 20), // Add spacing between rows
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDesignTeamCard(),
                  SizedBox(width: 20), // Add spacing between cards
                  _buildContentTeamCard(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChairCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5.0,
        ),
        width: 150.0,
        height: 150.0,
        decoration: BoxDecoration(
          gradient: _getMeshGradient(Color(0xFF1F1F1F)), // Black color variant
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2.0,
              blurRadius: 5.0,
              offset: Offset(1.0, 4.0),
            ),
          ],
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Text(
            "Chair",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWebTeamCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5.0,
        ),
        width: 150.0,
        height: 150.0,
        decoration: BoxDecoration(
          gradient: _getMeshGradient(Color(0xFF212121)), // Black color variant
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2.0,
              blurRadius: 5.0,
              offset: Offset(1.0, 4.0),
            ),
          ],
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Text(
            "Web Team",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesignTeamCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5.0,
        ),
        width: 150.0,
        height: 150.0,
        decoration: BoxDecoration(
          gradient: _getMeshGradient(Color(0xFF2C2C2C)), // Black color variant
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2.0,
              blurRadius: 5.0,
              offset: Offset(1.0, 4.0),
            ),
          ],
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Text(
            "Design\nTeam",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentTeamCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5.0,
        ),
        width: 150.0,
        height: 150.0,
        decoration: BoxDecoration(
          gradient: _getMeshGradient(Color(0xFF333333)), // Black color variant
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2.0,
              blurRadius: 5.0,
              offset: Offset(1.0, 4.0),
            ),
          ],
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Text(
            "Content\nTeam",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  LinearGradient _getMeshGradient(Color color) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        color.withOpacity(0.6),
        color.withOpacity(0.4),
        color.withOpacity(0.6),
      ],
    );
  }
}
