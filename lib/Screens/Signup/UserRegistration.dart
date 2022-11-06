// ignore: file_names
import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:u_assist/Screens/Register/dao/user_dao.dart';
import 'package:u_assist/Screens/Register/user.dart';
import 'package:u_assist/Screens/Signup/components/background.dart';
import 'package:u_assist/Screens/Signup/components/user_image_picker.dart';
import 'package:u_assist/Screens/Welcome/home.dart';
import 'package:u_assist/components/rounded_button.dart';
import 'package:u_assist/components/rounded_input_field.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';
import '../Util/NewsCardSkelton.dart';
import '../dashboard/UserDetails.dart';


class UserRegistration extends StatefulWidget {
  //StreamController <UserBean>streamController;
  //UserRegistration(this.streamController);
  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  late String name;
  late String contactNumber;
  late String emailId;
  late String address;
  late String date;
  late File _userImageFile;

  late bool _isLoading;

  @override
  void initState() {
    _isLoading = false;
    // TODO: implement initState
    super.initState();
  }

  final userDao = UserDao();

  final GlobalKey<FormState>userRegistrationFrmKey = GlobalKey<FormState>();

  void _pickedImageTest(File file){
      _userImageFile = file;
  }

  registerUser(_UserRegistrationState user) async {
    print("Saving object to the data base");
    UserBean userObj  = UserBean(fullName: user.name, mobileNumber: user.name,
        address:user.address, date: user.date ,
        profileImage: user._userImageFile,
        profileImageURL:'');
     await userDao.saveUser(userObj);
    // UserBean? userBeanObj = null;
    // userBean.then((value) => {userBeanObj = value});

    //widget.streamController.sink.add(userBean!);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        key: userRegistrationFrmKey,

         child: _isLoading?
         ListView.separated(
           itemCount: 5,
           itemBuilder: (context, index) => const NewsCardSkelton(),
           separatorBuilder: (context, index) =>
           const SizedBox(height: defaultPadding),
         )
             : SingleChildScrollView(

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
                  this.name= value;
                },
              ),
              RoundedInputField(
                key: const Key("mobile"),
                hintText: "Contact Number",
                onChanged: (value) {
                  this.contactNumber= value;
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
                key: const Key("address"),
                hintText: "Full Address",
                onChanged: (value) {
                  address= value;
                },
              ),
              UserImagePicker(_pickedImageTest),
              RoundedButton(
                key: const Key("value11"),
                text: "Register",
                press: () async {
                  _isLoading = true;
                   await registerUser(this);
                   _isLoading = false;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                          (route) => false);
                },
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

}