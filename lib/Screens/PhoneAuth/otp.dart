// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:u_assist/Screens/Welcome/home.dart';
import 'package:pinput/pin_put/pin_put.dart';


class OTPScreen extends StatefulWidget {
  final String phone;
  OTPScreen(this.phone);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  late String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                'Verify +91-${widget.phone}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: PinPut(
              fieldsCount: 6,
              textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.fade,
              onSubmit: (pin) => {
                login(pin,context)},
            ),
          )
        ],
      ),
    );
  }

  Future<void> login(String pin, BuildContext context) async {
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
                   } catch (e) {
                     FocusScope.of(context).unfocus();
                     // void showInSnackBar(String value) {
                     //   _scaffoldkey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
                     // }
                     // _scaffoldkey.currentState.showBottomSheet(new SnackBar(content:
                     // Text
                     //   ('invalid OTP')));
                   }
  }

  _verifyPhone()  {
    print("varifying phone otp");
     FirebaseAuth.instance.verifyPhoneNumber(
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
    print("varification completed");
  }
}
