import 'package:flutter/material.dart';
import 'package:u_assist/Screens/Login/components/Login.dart';
import 'package:u_assist/Screens/Signup/UserRegistration.dart';
import 'package:u_assist/Screens/Signup/components/background.dart';
import 'package:u_assist/Screens/Signup/components/or_divider.dart';
import 'package:u_assist/Screens/Signup/components/social_icon.dart';
import 'package:u_assist/components/already_have_an_account_acheck.dart';
import 'package:u_assist/components/rounded_button.dart';
import 'package:u_assist/components/rounded_input_field.dart';
import 'package:u_assist/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends State<UserRegistration> {

  late String name;
  late String contactNumber;
  late String emailId;
  late String address;

  final GlobalKey<FormState>userRegistrationFrmKey = GlobalKey<FormState>();

  registerUser(){

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      key: userRegistrationFrmKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Registration",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              key: const Key("username"),
              hintText: "Your Name",
              onChanged: (value) {
                name= value;
              },
            ),
            RoundedInputField(
              key: const Key("mobile"),
              hintText: "Contact Number",
              onChanged: (value) {
                contactNumber= value;
              },
            ),
            RoundedInputField(
              key: const Key("email"),
              hintText: "Email",
              onChanged: (value) {
                emailId= value;
              },
            ),
            RoundedInputField(
              key: Key("address"),
              hintText: "Full Address",
              onChanged: (value) {
                this.address= value;
              },
            ),
            RoundedButton(
              key: Key("value11"),
              text: "Register",
              press: () {
                registerUser();
              },
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
