
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:u_assist/Screens/PhoneAuth/login.dart';
import 'package:u_assist/Screens/Signup/UserRegistration.dart';
import 'package:u_assist/Screens/dashboard/UserDetails.dart';

import '../Register/dao/user_dao.dart';
import '../Util/UserDetailsWidget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid ="";

  var name = "jitendra";
  var phoneNumber = "9694879050";
  var image = "image";

  final userDao = new UserDao();

  @override
  void initState() {
    // TODO: implement initState
    print("init state is getting called");
    super.initState();
    userDao.getUserDetails();
  }


  @override
  Widget build(BuildContext context) {


    final children = <Widget>[];
    for (var i = 0; i < 3; i++) {
      children.add(new UserDetailsWidget((name+i.toString()), (phoneNumber+i
          .toString()),
          (image+i.toString())));
    }
    return new ListView(
      padding: const EdgeInsets.all(8),
      children: children,
    );

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
        // new UserDetailsWidget(),
        ],

      ),
    );
  }

}
