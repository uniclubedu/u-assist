import 'package:flutter/material.dart';

import '../../components/rounded_button.dart';
import 'OTPNew.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              child: Center(
                child: Text(
                  'Phone Authentication',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40, right: 10, left: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  prefix: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('+91'),
                  ),
                ),
                maxLength: 10,
                keyboardType: TextInputType.number,
                controller: _controller,
              ),
            )
          ]),
          Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            child: RoundedButton(
              key: const Key("value11"),
              text: "Login",
              press: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PinPutView(_controller.text)));
              },
            ),
            // child: TextButton(
            //   onPressed: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (context) => PinPutView(_controller.text)));
            //   },
            //   child: Text(
            //     'Next',
            //     style: TextStyle(color: Colors.black54),
            //   ),
            // ),
          )
        ],
      ),
    );
  }

  FlatButton({required MaterialColor color, required Null Function() onPressed, required Text child}) {}
}
