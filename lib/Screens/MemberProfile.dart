
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:u_assist/Screens/Util/UserDetailsWidget.dart';

import 'Register/user.dart';
import 'dashboard/UserDetails.dart';




class MemberProfile extends StatefulWidget {
  late Member user;


  @override
  State<MemberProfile> createState() => _MemberProfile();

  MemberProfile(this.user);
}

class _MemberProfile extends State<MemberProfile>{
  static const IconData delete = IconData(0xe1b9, fontFamily: 'MaterialIcons');
  static const IconData edit = IconData(0xe89b, fontFamily: 'MaterialIcons');

  Image image = Image.asset("assets/images/profile.png");

  @override
  Widget build(BuildContext context) {

    bool _selected =false;

return Scaffold(
       appBar: AppBar(
       title: const Text('Member Profile'),
       ),

    body: Container(
      margin: const EdgeInsets.fromLTRB(0, 40, 0, 30),
      height: 180,
      child: Card(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 150,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20,20, 20, 20),
                  child: Column(
                    children: const [
                    //  Text("Hello how are you"),
                      Text('Name : lalit  ',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                        ),

                      ),
                      const Divider(),
                      Text('address : bhusawar',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white
                      ),


                      ),
                      const Divider(),
                      Text('date : 03/11/22',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white
                        ),


                      ),
                      const Divider(),

                      Text('Shift: Full',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white
                        ),


                      ),
                      Text(" details"),

                        ],
                  ),

                ),
              ),

              Container(
                  padding: const EdgeInsets.fromLTRB(60,10, 20, 20),
                 child: CircleAvatar(radius: 60,
                    backgroundImage: AssetImage( 'assets/images/profile.png'),
                  )
              )
            ],
        ),
      ),
    )
);

    //  //    body:Container(
   //  //
   //  //   height: 300,
   //  //  // width: MediaQuery.of(context).size.width - 24,
   //  //   decoration: BoxDecoration(
   //  //
   //  //       borderRadius: BorderRadius.circular(50),
   //  //       color: Colors.grey,
   //  //       border:
   //  //       Border.all(width: 0.5, color: Colors.redAccent)),
   //  //   child: Padding(
   //  //       padding: const EdgeInsets.fromLTRB(20,40,10,10,),
   //  //       child: Row(
   //  //         children: <Widget>[
   //  //       Row(
   //  //       crossAxisAlignment: CrossAxisAlignment.end,
   //  //         children: <Widget>[
   //  //           Column(
   //  //             crossAxisAlignment: CrossAxisAlignment.start,
   //  //
   //  //             children: <Widget>[
   //  //               InkWell(
   //  //                 onTap: () {
   //  //                   setState(() {});
   //  //                 },
   //  //                 child: Container(
   //  //
   //  //                     height: 80,
   //  //                     width: 100,
   //  //                     decoration: BoxDecoration(
   //  //                         color: Colors.white,
   //  //                         borderRadius:
   //  //                         BorderRadius.circular(60),
   //  //                         border: Border.all(
   //  //                           width: 0.5,
   //  //                           color: Colors.grey,
   //  //                         )
   //  //                     ),
   //  //
   //  //                     child: Icon(
   //  //                       Icons.account_box_outlined,
   //  //
   //  //
   //  //                       size: 30,
   //  //                       color: Colors.purple[100],
   //  //
   //  //                     )),
   //  //
   //  //
   //  //               ),
   //  //
   //  //               Icon(edit),
   //  //               Text(
   //  //                 'Name = lalit ',
   //  //                 style: TextStyle(fontSize: 24
   //  //                 ),
   //  //
   //  //               ),
   //  //               Text(
   //  //                 'Adderess = bhusawar'
   //  //               ),
   //  //               Text(
   //  //                   'Contact = 83xxxxxxxx'
   //  //               ),
   //  //               Text(
   //  //                   'Joining date = 01/11/2022'
   //  //               ),
   //  //               Text(
   //  //                   'shift  = full '
   //  //               ),
   //  //               Text(
   //  //                   'fees = 0000'
   //  //               ),
   //  //             ],
   //  //           ),
   //  //           FilterChip(
   //  //               showCheckmark: true,
   //  //               selected: _selected,
   //  //               label: const Text('Woolha'),
   //  //               onSelected: (bool selected) {
   //  //                 setState(() {
   //  //                   _selected = !_selected;
   //  //                 });
   //  //               }
   //  //           )
   //  //
   //  //         ],
   //  //       )
   //  //
   //  //
   //  // ],
   //  //
   //  // ),
   //  //
   //  //   )
   //  // ),
   //
   //
   // );
   //


    // TODO: implement build
  }



}


