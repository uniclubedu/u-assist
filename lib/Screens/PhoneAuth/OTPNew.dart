import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:u_assist/Screens/Register/dao/client_dao.dart';
import 'package:u_assist/Screens/dashboard/ContactAdmin.dart';

import '../../components/rounded_button.dart';
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
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  late String _verificationCode;
  late String _pin;
  @override
  void initState() {
    _verifyPhone();
    super.initState();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  _verifyPhone() async {
    debugPrint("varifying phone otp");
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (AuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              if(await ClientDAO().isAccountActivated()){
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                        (route) => false);
              }else{
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ContactAdmin()),
                        (route) => false);
              }
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {

          if (e.code == 'invalid-phone-number') {
            debugPrint('The provided phone number is not valid.');
          }
          debugPrint(e.message);
          debugPrint("varification failed");
        },
        codeSent: (String verficationID,[ int? resendtoken]) async{
          setState(() {
            debugPrint("code sent varification id {}"+verficationID);
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
            debugPrint("code auto retrival timeout");
            _verificationCode = verificationID;
          });
        },

        timeout: Duration(seconds: 120));
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 5, color:Color.fromRGBO(234,
            239, 243,
            1))),
        //borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border(bottom: BorderSide(width: 5, color:Color.fromRGBO(114, 178, 238, 1))),
      //borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border(bottom: BorderSide(width: 5, color:Color.fromRGBO(234, 239, 243, 1))),
      ),
    );
    return Scaffold(
          appBar: AppBar(
            title: Text("OTP Verification"),
            centerTitle: true,
            backgroundColor: Colors.purple,
          ),

      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  Container(
                    child:Text("Verification"),
                  ),
                  Container(
                    child:Text("Enter the code sent to the mobile number."),
                  ),
                  Container(
                    child:Text("+91${widget.phone}"),
                  )
                ],
              ),
            ),
            Container(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Directionality(
                      // Specify direction if desired
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        controller: pinController,
                        focusNode: focusNode,
                        androidSmsAutofillMethod: AndroidSmsAutofillMethod
                            .smsRetrieverApi,
                        //AndroidSmsAutofillMethod.smsUserConsentApi,
                        listenForMultipleSmsOnAndroid: true,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        length: 6,
                        submittedPinTheme: submittedPinTheme,
                        validator: (value) {
                          //return value == '222222' ? null : 'Pin is
                          // incorrect';
                        },
                        // onClipboardFound: (value) {
                        //   debugPrint('onClipboardFound: $value');
                        //   pinController.setText(value);
                        // },
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          _pin= pin;
                          debugPrint('onCompleted: $pin');
                        },
                        onChanged: (value) {
                          _pin=value;
                          debugPrint('onChanged: $value');
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 22,
                              height: 1,
                              color: focusedBorderColor,
                            ),
                          ],
                        ),
                        errorPinTheme: defaultPinTheme.copyBorderWith(
                          border: Border.all(color: Colors.redAccent),
                        ),
                      ),
                    ),
                    RoundedButton(
                      key: const Key("verify"),
                      text: "Verify",
                      press: () async {
                        login(_pin);
                        if(formKey.currentState!.validate()){

                        }
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
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
    debugPrint("Login method is getting caled after pin submit ${_verificationCode}");
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
          verificationId: _verificationCode, smsCode: pin))
          .then((value) async {
        if (value.user != null) {
          debugPrint("checking if user is activated");
          if(await ClientDAO().isAccountActivated()){
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Home()),
                    (route) => false);
          }else{
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ContactAdmin()),
                    (route) => false);
          }
        }
      });
    } catch (stacktrace, e) {
      debugPrint("Stacktrace : ${stacktrace}");
      debugPrint(e as String?);
      FocusScope.of(context).unfocus();
      SnackBar(content: Text(pin));
      const SnackBar(content:
      Text
        ('invalid OTP'));
    }
  }
}