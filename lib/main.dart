//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:u_assist/Screens/Login/components/Login.dart';
import 'package:u_assist/Screens/PhoneAuth/login.dart';
import 'package:u_assist/Screens/dashboard/UserDetails.dart';

import 'Screens/Welcome/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  FirebaseAppCheck.instance.activate();
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

    // return FutureBuilder<User>(
    //     future: Future.value(FirebaseAuth.instance.currentUser),
    //     builder: (BuildContext context, AsyncSnapshot<User> snapshot){
    //       if (snapshot.hasData){
    //         User? user = snapshot.data; // this is your user instance
    //         /// is because there is user already logged
    //         return MaterialApp(home:Home());
    //       }
    //       /// other way there is no user logged.
    //       return LoginScreen();
    //     }
    // );
    if(FirebaseAuth.instance.currentUser == null){
      return MaterialApp
        (
        home:
        LoginScreen(),
      );
    }else{
      return MaterialApp
      (
          home:Home(),
      );
    }
  }
}
