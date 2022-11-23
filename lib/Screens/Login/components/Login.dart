import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:u_assist/Screens/Login/components/background.dart';
import 'package:u_assist/Screens/Signup/MemberRegistration.dart';
import 'package:u_assist/Screens/Welcome/Start.dart';
import 'package:u_assist/components/already_have_an_account_acheck.dart';
import 'package:u_assist/components/rounded_button.dart';
import 'package:u_assist/components/rounded_input_field.dart';
import 'package:u_assist/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({
    required Key key,
  }) : super(key: key);

  @override
  LoginState createState() => LoginState();




}
class LoginState extends State<Login>{

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState>loginFormKey = GlobalKey<FormState>();

  late String email="null", password="null";

  checkAuthentification() async{

      auth.authStateChanges().listen((user) {

        if(user != null){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>Start()));
        }

      });
  }

  @override
  void initState(){
    super.initState();
    this.checkAuthentification();
  }

  login() async{
    log("Logging in with email:$email and password:$password");
    if(loginFormKey.currentState != null && loginFormKey.currentState!.validate()){
      loginFormKey.currentState!.save();
    }
    try{
      await auth.signInWithEmailAndPassword(email: this.email, password:
      this.password);
    }
    catch(e){
      showError(e.toString());
    }
  }

  showError(error){
    showDialog(context: context,

        builder: (BuildContext context){
            return AlertDialog(
              title: Text("Error"),
              content: Text(error),

              actions: <Widget>[
                TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    }

                    , child: Text("Ok"))
              ],
            );
        });

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Background(
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
              onChanged: (value) {this.email= value;
              log("Entered email is: $email");
              },
            ),
            RoundedPasswordField(
              key: Key("value5"),
              onChanged: (value) {
                this.password = value;
                log("password value is: $password");
              },
            ),
            RoundedButton(
              key: Key("value6"),
              text: "LOGIN",
              press: () {login();},
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
    ));
  }
}
