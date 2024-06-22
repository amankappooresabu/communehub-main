import 'package:communehub/community/CommunityDetailsScreen.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_application_1/utlis/color_utlis.dart';

class communityHome extends StatefulWidget {
  const communityHome({Key? key}) : super(key: key);

  @override
  State<communityHome> createState() => _communityHome();
}

class _communityHome extends State<communityHome> {
  // Map of community names to their respective logo paths
  final Map<String, String> communityLogos = {
    'GDSC': 'assets/GDSC.png',
    'IEEE': 'assets/ieeeb.png',
    'TINKER HUB': 'assets/TINKERHUB.png',
    'UI PATH': 'assets/UIPATH.png',
    'CSI': 'assets/csilo.png',
    // Add more community logos as needed
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Community",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListView.builder(
          itemCount: (communityLogos.length / 2).ceil(),
          itemBuilder: (BuildContext context, int index) {
            int startIndex = index * 2;
            int endIndex = startIndex + 2;
            if (endIndex > communityLogos.length) {
              endIndex = communityLogos.length;
            }
            List<MapEntry<String, String>> currentRowEntries =
                communityLogos.entries.toList().sublist(startIndex, endIndex);
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: currentRowEntries.map((entry) {
                  return SizedBox(
                    width: 170,
                    child: CommunityBox(name: entry.key, logoPath: entry.value),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CommunityBox extends StatelessWidget {
  final String name;
  final String logoPath;

  CommunityBox({required this.name, required this.logoPath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CommunityDetailsScreen(name: name)),
        );
      },
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 3, 3, 3).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 05,
              offset: Offset(0, 6), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              logoPath,
              width: 100,
              height: 50,
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 31, 18, 18)),
            ),
          ],
        ),
      ),
    );
  }
}
