import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../PhoneAuth/login.dart';

class ContactAdmin extends StatefulWidget {
  const ContactAdmin({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ContactAdmin createState() => _ContactAdmin();
}

class _ContactAdmin extends State<ContactAdmin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(

          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: const Text("Zuvocloud"),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                          (route) => false);
                },
              )
            ],
          ), // AppBar


          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(10, 150, 10, 0),
                    child: Text("Please contact admin to activate your account. You can  send an email on uniclubedu@gmail.com",
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize:20,
                          color: Colors.indigo,
                          fontWeight: FontWeight.normal
                      ),
                    )
                ),


              ],


            ),
          ),



        )
    );// MaterialApp
  }
}