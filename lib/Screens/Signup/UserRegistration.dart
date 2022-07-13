// ignore: file_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:u_assist/Screens/Register/dao/user_dao.dart';
import 'package:u_assist/Screens/Register/user.dart';
import 'package:u_assist/Screens/Signup/components/background.dart';
import 'package:u_assist/Screens/Signup/components/user_image_picker.dart';
import 'package:u_assist/components/rounded_button.dart';
import 'package:u_assist/components/rounded_input_field.dart';
import 'package:flutter_svg/svg.dart';

import '../dashboard/UserDetails.dart';


class UserRegistration extends StatefulWidget {
  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  late String name;
  late String contactNumber;
  late String emailId;
  late String address;
  late File _userImageFile;

  final userDao = UserDao();

  final GlobalKey<FormState>userRegistrationFrmKey = GlobalKey<FormState>();

  void _pickedImageTest(File file){
      _userImageFile = file;
  }

  registerUser(_UserRegistrationState user){
    print("Saving object to the data base");
    User userObj  = User(fullName: user.name, mobileNumber: user.name,
        address:user.address, profileImage: user._userImageFile,
        profileImageURL:'');
    userDao.saveUser(userObj);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
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
                press: () {
                  registerUser(this);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => UserInfoRow()),
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