import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:u_assist/Screens/Register/user.dart';
import 'package:u_assist/Screens/dashboard/UserDetails.dart';
import 'package:u_assist/Screens/MemberProfile.dart';

import '../Signup/UserRegistration.dart';

class UserDetailsWidget extends StatefulWidget{

  Member user;

  @override
  State<UserDetailsWidget> createState() => _UserDetailsWidgetState();

  UserDetailsWidget(this.user);
}

class _UserDetailsWidgetState extends State<UserDetailsWidget> {
  static const descTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w800,
    fontFamily: 'Roboto',
    letterSpacing: 0.5,
    fontSize: 10,
    height: 3,
  );

  Image image = Image.asset("assets/images/profile.png");

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 200,
      decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(
            color: Colors.purple,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(40.0),
          // gradient: const LinearGradient(
          //     colors: [
          //       Colors.black,
          //       Colors.grey
          //     ]
          // ),
          boxShadow: const [
            BoxShadow(blurRadius: 2.0, offset: Offset(2.0, 2.0))
          ]),
      //padding: const EdgeInsets.all(26),
      child: InkWell(
        onTap: (){
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MemberProfile(new Member
                (fullName: '', mobileNumber: '', address: '', profileImageURL: ''))),
                  (route) => false);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(

                      //padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        widget.user.fullName,
                        style: descTextStyle,
                      ),
                    ),
                    Text('Contact Number : ${widget.user.mobileNumber}',
                        style: descTextStyle),
                    Text('Address : ${widget.user.address}', style: descTextStyle),
                    Text(
                      'Contact Number : ${widget.user.mobileNumber}',
                      style: descTextStyle
                    ),
                    Text(
                        'Address : ${widget.user.address}',
                        style: descTextStyle
                    ),
                    Text(
                        'Fees : ${widget.user.fees}',
                        style: descTextStyle
                    ),
                    Text(
                        'Shift : ${widget.user.shift}',
                        style: descTextStyle
                    ),
                    Text(
                        'Joining Date : ${widget.user.joiningDate}',
                        style: descTextStyle
                    )
                  ],
                )),
            CircleAvatar(
                radius: 48,
                backgroundImage:
                Image.network(widget.user.profileImageURL).image),
            //  InkWell(
            //   onTap: () {
            //     print("click");
            //     Navigator.pushAndRemoveUntil(
            //        context,
            //        MaterialPageRoute(builder: (context) => UserRegistration()),
            //             (route) => false);
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
