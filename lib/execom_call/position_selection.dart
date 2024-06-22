import 'package:communehub/execom_call/questions1.dart';
import 'package:flutter/material.dart';

class PositionSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 40.0,
                    bottom: 10.0,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "  Position Selection",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Container(
                        width: 70.0,
                        height: 3.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFB760D5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(2.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Text(
                    "Select the position you want to apply for ",
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ],
            ),
            ListView(
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildChairCard(),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuestionsPage()),
                          );
                        },
                        child: _buildWebTeamCard(),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildDesignTeamCard(),
                    ),
                    Expanded(
                      child: _buildContentTeamCard(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildChairCard() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20.0),
    child: Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 5.0,
      ),
      width: 170.0,
      height: 175.0,
      decoration: BoxDecoration(
        gradient: _getMeshGradient(),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2.0,
            blurRadius: 5.0,
            offset: Offset(1.0, 4.0),
          ),
        ],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 60.0,
        ),
        child: Text(
          "Chair",
          style: TextStyle(
            fontSize: 20.0,
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
    borderRadius: BorderRadius.circular(20.0),
    child: Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 5.0,
      ),
      width: 170.0,
      height: 175.0,
      decoration: BoxDecoration(
        gradient: _getMeshGradient(),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2.0,
            blurRadius: 5.0,
            offset: Offset(1.0, 4.0),
          ),
        ],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 60.0,
        ),
        child: Text(
          "Web Team",
          style: TextStyle(
            fontSize: 20.0,
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
    borderRadius: BorderRadius.circular(20.0),
    child: Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 5.0,
      ),
      width: 170.0,
      height: 175.0,
      decoration: BoxDecoration(
        gradient: _getMeshGradient(),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2.0,
            blurRadius: 5.0,
            offset: Offset(1.0, 4.0),
          ),
        ],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 60.0,
        ),
        child: Text(
          "Design\nTeam",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
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
    borderRadius: BorderRadius.circular(20.0),
    child: Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 5.0,
      ),
      width: 170.0,
      height: 175.0,
      decoration: BoxDecoration(
        gradient: _getMeshGradient(),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2.0,
            blurRadius: 5.0,
            offset: Offset(1.0, 4.0),
          ),
        ],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 60.0,
        ),
        child: Text(
          "Content\nTeam",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Gradient _getMeshGradient() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF7E53D6),
      Color(0xFFB760D5),
    ],
  );
}
