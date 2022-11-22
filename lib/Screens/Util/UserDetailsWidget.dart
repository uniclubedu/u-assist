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
    height: 5,
  );

  Image image = Image.asset("assets/images/profile.png");

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0,0),
      height: 150,
      width: 280,
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
            width: 170,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10,0, 10,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0,0, 80,0),
                    child:  Text('${widget.user.fullName} ',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black
                      ),

                    ),
                  )
                  ,
                  const Divider(),
                  buildMemberAttributes(widget.user.mobileNumber),
                  const Divider(),
                  buildMemberAttributes("Address :"+widget.user.address),
                  const Divider(),
                  buildMemberAttributes("Amount Paid :"+(widget.user.amountPaid.toString())),

                //  Text(" details"),

                ],
              ),

            ),
          ),
          Column(
            children: [
              if(widget.user.profileImageURL != null && widget.user.profileImageURL != '')
                Container(
                    padding: const EdgeInsets.fromLTRB(80,10, 0, 0),
                    child: CircleAvatar(radius: 40,
                      backgroundImage:Image.network(widget.user.profileImageURL).image,
                    )
                )
              else
                Container(
                    padding: const EdgeInsets.fromLTRB(80,10, 0, 0),
                    child: CircleAvatar(radius: 40,
                      backgroundImage:AssetImage("assets/images/profile.png"),
                    )
                ),
              Container(
                margin: EdgeInsets.only(bottom: 10, left: 80, top: 15),
                child: Column(
                  children: [
                      if(widget.user.amountPaid < double.parse(widget.user.fees))
                        Text(
                          "Pending",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Open Sans',
                            fontSize: 20,

                          ),
                        )
                    else
                        Text(
                          "Paid",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Open Sans',
                            fontSize: 20,

                          ),
                        )
                  ],

                ),
              )
            ],
          )


        ],
      )
    ),
      ),
    );
  }

  Container buildMemberAttributes(var parameter) {
    return Container(

                child: Text('${parameter}',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black
                      ),
                    )
                );
  }
}
