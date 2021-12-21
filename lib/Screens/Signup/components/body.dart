import 'package:flutter/material.dart';
import 'package:u_assist/Screens/Login/components/Login.dart';
import 'package:u_assist/Screens/Signup/components/background.dart';
import 'package:u_assist/Screens/Signup/components/or_divider.dart';
import 'package:u_assist/Screens/Signup/components/social_icon.dart';
import 'package:u_assist/components/already_have_an_account_acheck.dart';
import 'package:u_assist/components/rounded_button.dart';
import 'package:u_assist/components/rounded_input_field.dart';
import 'package:u_assist/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      key: Key("value8"),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              key: Key("value9"),
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              key: Key("value10"),
              onChanged: (value) {},
            ),
            RoundedButton(
              key: Key("value11"),
              text: "SIGNUP",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              key: Key("value12"),
              login: false,
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>Login(key: Key("welcomkey"),)));
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  key: Key("value13"),
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  key: Key("value14"),
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  key: Key("value15"),
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
