import 'package:flutter/material.dart';
import 'package:u_assist/Screens/Login/components/Login.dart';

class Login1 extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}
class LoginState extends State<Login1>{



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Login(key: Key("value2"),),
    );
  }

}