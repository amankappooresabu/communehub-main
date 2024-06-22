import 'package:communehub/community/communityhome.dart';
import 'package:communehub/events/admininput.dart';
import 'package:communehub/events/adminlisting.dart';
import 'package:communehub/events/eventscreen.dart';
import 'package:communehub/firebase_options.dart';

import 'package:communehub/onboarding/onboarding.dart';
import 'package:communehub/onboarding/useroradmin.dart';
import 'package:communehub/user/loginscreen.dart';
import 'package:communehub/user/signup.dart';

import 'package:communehub/user/userhome.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: "/",
      routes: {
        '/': (context) => OnboardingView(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomePage(),
        '/communityhome': (context) => communityHome()
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
