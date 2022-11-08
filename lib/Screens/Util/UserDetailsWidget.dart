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
    color: Colors.grey,
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
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      height: 200,
      width: 200,
      //padding: const EdgeInsets.all(26),
      child: InkWell(
        onTap: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MemberProfile(widget.user)));
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (context) => MemberProfile(new Member
          //       (fullName: ' ', mobileNumber: '', address: '', profileImageURL: ''))),
          //         (route) => false);
        },

    child: Card(
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Container(
              padding: const EdgeInsets.fromLTRB(0,0, 0, 0),
              child: Column(
                children:  [
                  //  Text("Hello how are you"),
                  Text('Name : ${widget.user.fullName} ',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black26
                    ),

                  ),
                  const Divider(),
                  Text('address : ${widget.user.address}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black26
                    ),


                  ),
                  const Divider(),
                  Text('Joining Date : ${widget.user.joiningDate}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black26
                    ),


                  ),
                  const Divider(),

                  Text('Shift: ${widget.user.shift}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black26
                    ),


                  ),
                //  Text(" details"),

                ],
              ),

            ),
          ),

          Container(
              padding: const EdgeInsets.fromLTRB(60,10, 0, 20),
              child: CircleAvatar(radius: 60,
                backgroundImage:Image.network(widget.user.profileImageURL).image,
              )
          )
        ],
      )
    ),
        // child: Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Expanded(
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Container(
        //
        //               //padding: const EdgeInsets.only(bottom: 10.0),
        //               child: Text(
        //                 widget.user.fullName,
        //                 style: descTextStyle,
        //               ),
        //             ),
        //             Text(' Contact Number : ${widget.user.mobileNumber}',
        //                 style: descTextStyle),
        //             Text(' Address : ${widget.user.address}', style: descTextStyle),
        //             Text(
        //               ' Contact Number : ${widget.user.mobileNumber}',
        //               style: descTextStyle
        //             ),
        //             Text(
        //                 ' Address : ${widget.user.address}',
        //                 style: descTextStyle
        //             ),
        //             Text(
        //                 ' Fees : ${widget.user.fees}',
        //                 style: descTextStyle
        //             ),
        //             Text(
        //                 ' Shift : ${widget.user.shift}',
        //                 style: descTextStyle
        //             ),
        //             Text(
        //                 ' Joining Date : ${widget.user.joiningDate}',
        //                 style: descTextStyle
        //             )
        //           ],
        //         )),
        //     CircleAvatar(
        //         radius: 48,
        //         backgroundImage:
        //         Image.network(widget.user.profileImageURL).image),
        //     //  InkWell(
        //     //   onTap: () {
        //     //     print("click");
        //     //     Navigator.pushAndRemoveUntil(
        //     //        context,
        //     //        MaterialPageRoute(builder: (context) => UserRegistration()),
        //     //             (route) => false);
        //     //   },
        //     // )
        //   ],
        // ),
      ),
    );
  }
}
