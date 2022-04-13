import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:u_assist/Screens/Welcome/components/body.dart';
import 'package:u_assist/Screens/Login/Login1.dart';

class Start extends StatefulWidget {

   createState() => HomePageState();
}

class HomePageState extends State<Start>{

  final FirebaseAuth auth = FirebaseAuth.instance;
  late User user;
  bool isLoggedIn = false;

  checkAuthentication() async{
    auth.authStateChanges().listen((user) {
      if(user == null){
        Navigator.of(context).pushReplacementNamed("SignUp");
        //Navigator.push(context, MaterialPageRoute(builder: (context)) => Login());
      }
    });
  }
  getUser() async{
    User firebaseUser = await auth.currentUser!;
    //await !firebaseUser?.reload();
    firebaseUser = await auth.currentUser!;
    if(firebaseUser != null){
      setState(() {
        this.user = firebaseUser;
        this.isLoggedIn = true;
      });
    }
  }
  @override
  void initState() {
    this.checkAuthentication();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: !isLoggedIn ? CircularProgressIndicator() :
        Column(
          children: <Widget>[
            Container(
              height: 400,
              child: Image(image: AssetImage("assets/icons/chat.svg"),
              fit: BoxFit.contain,
              ),
            ),
            Container(
              child: Text("Hello ${user.displayName} you are logged in as ${user.email}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
            //RaisedButton(onPressed: onPressed)
          ],
        ),
      ),
    );

  }
  
}
