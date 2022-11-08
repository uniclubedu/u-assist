import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:u_assist/Screens/Util/UserDetailsWidget.dart';

import 'Register/user.dart';
import 'Signup/UserRegistration.dart';
import 'dashboard/UserDetails.dart';

class MemberProfile extends StatefulWidget {
  late Member user;

  @override
  State<MemberProfile> createState() => _MemberProfile();

  MemberProfile(this.user);
}

class _MemberProfile extends State<MemberProfile> {
  static const IconData delete = IconData(0xe1b9, fontFamily: 'MaterialIcons');

  //static const IconData edit = IconData(0xe89b, fontFamily: 'MaterialIcons');

  Image image = Image.asset("assets/images/profile.png");
  static const IconData edit = IconData(0xe21a, fontFamily: 'MaterialIcons');

  static const IconData arrow_forward =
      IconData(0xe09c, fontFamily: 'MaterialIcons', matchTextDirection: true);

  @override
  Widget build(BuildContext context) {
    bool _selected = false;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Member Profile"),
          leading: MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back_ios, color: Colors.white)),
          backgroundColor: Colors.purple,
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                height: 200,
                child: Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                Image.network(widget.user.profileImageURL)
                                    .image,
                          )),
                      SizedBox(
                        width: 150,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Column(
                            children: [
                              //  Text("Hello how are you"),
                              Text(
                                'Name :  ${widget.user.fullName} ',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black26),
                              ),
                              const Divider(),
                              Text(
                                'address : ${widget.user.address} ',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black26),
                              ),
                              const Divider(),
                              Text(
                                'date : ${widget.user.joiningDate} ',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black26),
                              ),
                              const Divider(),

                              Text(
                                'Shift: ${widget.user.shift} ',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black26),
                              ),
                              // Text(" details"),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        height: 200,
                        padding: const EdgeInsets.fromLTRB(60, 10, 10, 0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UserRegistration()));
                              }),
                              child: Container(
                                child: Icon(
                                  edit,
                                  size: 30,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UserRegistration()));
                              }),
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 110, 0, 10),
                                child: Icon(
                                  delete,
                                  size: 30,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      // Container(
                      //   padding: const EdgeInsets.fromLTRB(60,40, 10, 20),
                      //   child:  Icon(delete),
                      // )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                height: 160,
                child: Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(right:50),
                                child:  Text(
                                  'Payments',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                              const Divider(),
                              Container(
                                child: Column(
                                  children: [
                                    TextButton.icon(
                                      // <-- ElevatedButton
                                      onPressed: () {},
                                      style: TextButton.styleFrom(primary: Colors.purple),
                                      icon: Text('Payment History', style: TextStyle( fontSize: 15)),
                                      label: Padding(
                                          child: Icon(
                                            Icons.keyboard_arrow_right_outlined,
                                            size: 24.0,
                                          ), padding: const EdgeInsets.only(left: 190),
                                      ),

                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    TextButton.icon(
                                      // <-- ElevatedButton
                                      onPressed: () {},
                                      style: TextButton.styleFrom(primary: Colors.purple),
                                      icon: Text('Add Payment', style: TextStyle( fontSize: 15)),
                                      label: Padding(
                                        child: Icon(
                                          Icons.add,
                                          size: 20.0,
                                        ), padding: const EdgeInsets.only(left: 210),
                                      ),

                                    ),
                                  ],
                                ),
                              ),
                              // Text(" details"),
                            ],
                          ),
                        ),
                      ),

                      // Container(
                      //   padding: const EdgeInsets.fromLTRB(60,40, 10, 20),
                      //   child:  Icon(delete),
                      // )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));

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
