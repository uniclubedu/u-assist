import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:u_assist/Screens/PhoneAuth/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseApp.instance.options.
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
