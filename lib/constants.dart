import 'package:flutter/material.dart';
import 'package:u_assist/Screens/Register/user.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Colors.white38;

const Color primaryColor = Color(0xFF2967FF);
const Color grayColor = Color(0xFF8D8D8E);

const double defaultPadding = 16.0;

const bool isTesting = true;

Member usr1 = new Member(fullName: 'Jitendra', mobileNumber: "9694879050"
  , address: "address", profileImageURL: "profileImageURL", shift: "Fulltime"
  , fees: "500", joiningDate: "01/02/2022");

Member usr2 = new Member(fullName: 'Jitendra', mobileNumber: "9694879050"
    , address: "address", profileImageURL: "profileImageURL", shift: "Fulltime"
    , fees: "500", joiningDate: "01/02/2022");

Member usr3 = new Member(fullName: 'Jitendra', mobileNumber: "9694879050"
    , address: "address", profileImageURL: "profileImageURL", shift: "Fulltime"
    , fees: "500", joiningDate: "01/02/2022");
List<Member>userList = [usr1,usr2, usr3];