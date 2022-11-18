
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:u_assist/Screens/Login/components/background.dart';
import 'package:u_assist/Screens/Login/components/body.dart';
import 'package:u_assist/Screens/Signup/UserRegistration.dart';
import 'package:u_assist/Screens/Welcome/Start.dart';
import 'package:u_assist/components/already_have_an_account_acheck.dart';
import 'package:u_assist/components/rounded_button.dart';
import 'package:u_assist/components/rounded_input_field.dart';
import 'package:u_assist/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'background.dart';

class Body extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GlobalKey<FormState>loginFormKey = GlobalKey<FormState>();

    late String email="null", password="null";
    Size size = MediaQuery.of(context).size;
    return Background(
      key: loginFormKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            // RoundedInputField(
            //   key: Key("value4"),
            //   hintText: "Your Email",
            //   onChanged: (value) {
            //     email= value;
            //   },
            // ),
            RoundedInputField(
              key: Key("value9"),
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              key: Key("value5"),
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedButton(
              key: Key("value6"),
              text: "LOGIN",
              press: () {
                //login();
                },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              key: Key("value7"),
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MemberRegistration();
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