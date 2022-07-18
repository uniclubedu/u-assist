import 'package:flutter/material.dart';
import 'package:u_assist/Screens/Login/components/Login.dart';
import 'package:u_assist/Screens/Login/components/Login.dart';
import 'package:u_assist/Screens/Signup/UserRegistration.dart';
import 'package:u_assist/Screens/Welcome/components/background.dart';
import 'package:u_assist/components/rounded_button.dart';
import 'package:u_assist/constants.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      key: Key("value16"),
      child: SingleChildScrollView(
        key: Key("value1"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "WELCOME TO EDU",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              key: Key("value17"),
              text: "LOGIN",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>Login(key: Key("loginkey"),)));
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       => Login();
                //     },
                //   ),
                // );
              },
            ),
            RoundedButton(
              key: Key("value18"),
              text: "SIGN UP",
              color: Colors.lightGreen,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return UserRegistration();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
