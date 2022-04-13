
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:u_assist/Screens/PhoneAuth/login.dart';
import 'package:u_assist/Screens/Signup/UserRegistration.dart';
import 'package:u_assist/Screens/dashboard/UserDetails.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid ="";

  static const descTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w800,
    fontFamily: 'Roboto',
    letterSpacing: 0.5,
    fontSize: 18,
    height: 2,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
      ),
      body: Row(
        children: [
          // TextButton(
          //     style: ButtonStyle(
          //       foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          //       overlayColor: MaterialStateProperty.resolveWith<Color?>(
          //             (Set<MaterialState> states) {
          //           if (states.contains(MaterialState.hovered)) {
          //             return Colors.blue.withOpacity(0.04);
          //           }
          //           if (states.contains(MaterialState.focused) ||
          //               states.contains(MaterialState.pressed)) {
          //             return Colors.blue.withOpacity(0.12);
          //           }
          //           return null; // Defer to the widget's default.
          //         },
          //       ),
          //     ),
          //     onPressed: () {
          //       Navigator.pushAndRemoveUntil(
          //         context,
          //         MaterialPageRoute(builder: (context) => UserRegistration()),
          //             (route) => false);},
          //     child: const Text('Register User')
          // ),
          new UserInfoRow(),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FirebaseAuth.instance.currentUser().then((FirebaseUser user) =>
    //   uid = user.uid
    // );
  }
}
