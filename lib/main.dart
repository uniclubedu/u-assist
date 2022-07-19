//import 'package:firebase_core/firebase_core.dart';
// ignore: avoid_web_libraries_in_flutter

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:u_assist/Screens/PhoneAuth/login.dart';
import 'package:u_assist/Screens/Signup/UserRegistration.dart';

import 'Screens/Welcome/home.dart';
import 'Screens/dashboard/UserDetails.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  // FirebaseApp.instance.options.
  runApp(MaterialApp(
    home: MyApp(),
    theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepOrange,
        accentColor: Colors.purple,
        scaffoldBackgroundColor: Colors.black26,
        // textTheme: const TextTheme(
        //   bodyText1: TextStyle(color: Colors.white),
        //   bodyText2: TextStyle(color: Colors.white),
        //   new change
        // )
    ),
    debugShowCheckedModeBanner: false,

  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}
