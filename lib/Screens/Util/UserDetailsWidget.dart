import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:u_assist/Screens/Register/member.dart';
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
      height: 280,
      width: 200,
      //padding: const EdgeInsets.all(26),
      child: InkWell(
          onTap: (){
            print("user details widget");
            print(widget.user.toJson());
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
                        color: Colors.black
                    ),

                  ),
                  const Divider(),

                  Text('Contact No. : ${widget.user.mobileNumber}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black
                    ),
                  ),
                  const Divider(),
                  Text('address : ${widget.user.address}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black
                    ),


                  ),
                  const Divider(),
                  Text('Membership Start Date : ${widget.user.membershipStartDate}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black
                    ),


                  ),
                  const Divider(),
                  Text('Membership End Date : ${widget.user.membershipStartDate}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black
                    ),
                  ),
                  const Divider(),

                  Text('Shift: ${widget.user.shift}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black
                    ),
                  ),
                  const Divider(),
                  Text('Fees: ${widget.user.fees}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black
                    ),
                  ),
                const Divider(),
                  Text('Amount Paid: ${widget.user.amountPaid}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black
                    ),
                  ),

                //  Text(" details"),

                ],
              ),

            ),
          ),

          if(widget.user.profileImageURL != null && widget.user.profileImageURL != '')
            Container(
                padding: const EdgeInsets.fromLTRB(60,10, 0, 20),
                child: CircleAvatar(radius: 60,
                  backgroundImage:Image.network(widget.user.profileImageURL).image,
                )
            )
        ],
      )
    ),
      ),
    );
  }
}
