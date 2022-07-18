import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

import '../Welcome/home.dart';

class PinPutView extends StatefulWidget{

  final String phone;
  PinPutView(this.phone);

  @override
  PinPutViewState createState() => PinPutViewState();
}

class PinPutViewState extends State<PinPutView>{
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final _pinPutController = TextEditingController();
  final _pinPutController2 = TextEditingController();
  late String _verificationCode;
  @override
  void initState() {
    _verifyPhone();
    super.initState();
  }

  _verifyPhone() async {
    print("varifying phone otp");
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (AuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              print("user value ");
              print(value.user);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                      (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {

          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
          print(e.message);
          print("varification failed");
        },
        codeSent: (String verficationID,[ int? resendtoken]) async{
          setState(() {
            print("code sent varification id {}"+verficationID);
            _verificationCode = verficationID;
          });
          //PhoneAuthProvider.(verificationId: verificationId, smsCode: smsCode)
          // AuthCredential credential = PhoneAuthProvider.getCredential(verificationId:
          // verficationID, smsCode: smsCode);
          //
          // // Sign the user in (or link) with the credential
          // await auth.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            print("code auto retrival timeout");
            _verificationCode = verificationID;
          });
        },

        timeout: Duration(seconds: 120));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("OTP Verification"),
          centerTitle: true,
        ),
        body: Column(children: [
          Expanded(child: Container(
            margin: EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                'Verify +91-${widget.phone}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
          )),
          Expanded(child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: darkRoundedPinPut()),
                  Expanded(child: animatedBorders())
                ]),
          )),

        ],));
  }
  Widget darkRoundedPinPut() {
    return PinPut(
      eachFieldWidth: 50.0,
      eachFieldHeight: 50.0,
      withCursor: true,
      fieldsCount: 6,
      controller: _pinPutController,
      eachFieldMargin: EdgeInsets.symmetric(horizontal: 5),
      onSubmit: (String pin) => _showSnackBar(pin),
      submittedFieldDecoration: BoxDecoration(
        color: Colors.green[800],
        borderRadius: BorderRadius.circular(15.0),
      ),
      selectedFieldDecoration: BoxDecoration(
        color: Colors.green[800],
        borderRadius: BorderRadius.circular(15.0),
      ),
      followingFieldDecoration: BoxDecoration(
        color: Colors.green[800],
        borderRadius: BorderRadius.circular(15.0),
      ),
      pinAnimationType: PinAnimationType.rotation,
      textStyle: TextStyle(color: Colors.white,
          fontSize: 20.0,
          height: 1),
    );
  }

  Widget animatedBorders() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PinPut(
        fieldsCount: 4,
        eachFieldHeight: 50.0,
        withCursor: true,
        onSubmit: (String pin) => _showSnackBar(pin),
        controller: _pinPutController2,
        submittedFieldDecoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(15.0),
        ).copyWith(
          borderRadius: BorderRadius.circular(20.0),
        ),
        selectedFieldDecoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(15.0),
        ),
        followingFieldDecoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(15.0),
        ).copyWith(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String pin) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 4),
      content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            'Pin Submitted: $pin',
            style: TextStyle(fontSize: 25.0),
          ),
        ),
      ),
      action: SnackBarAction(
        label: "Submit",
        onPressed: () =>login(pin),
      ),

      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
  login(String pin) async {
    print("Login method is getting caled after pin submit ${_verificationCode}");
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
          verificationId: _verificationCode, smsCode: pin))
          .then((value) async {
        if (value.user != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
                  (route) => false);
        }
      });
    } catch (stacktrace, e) {
      print(stacktrace);
      print(e);
      FocusScope.of(context).unfocus();
      SnackBar(content: Text(pin));
      const SnackBar(content:
      Text
        ('invalid OTP'));
    }
  }
}